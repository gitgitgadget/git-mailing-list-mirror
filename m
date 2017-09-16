Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D399320A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdIPIIy (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37976 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdIPIIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id p37so2368618wrb.5
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IF2ajciyemVFavvF0K4Ysmdi6PN9HUjwhRLEE9yQtJs=;
        b=aoyTQ4dn3xrKFm8bs9Xoljd/LSHUoztx0PR5gXpWcAeTUmMGLDC4EM54efbjceX1a5
         V+emhwy5yA5b1OutXE86EcYe2n68SEqm6KVSzt1530dAbg+8ztqjYx4A9O2uozXkQ/nD
         mFCEgUTRRaI+rRfcZNYC2KbFEueQw00lLd7g/+CspKTGnmgq4gFd/kV3oDWbPBcfjbcp
         MP8jc9PqDTTahpQlA5u99SygOM21mSeOGHUq52pEvpZ1f5mtxVnhyFEKuxmUPRXFuHtX
         LBKrJIbzOM2UVnatYix5VYMNdFBjvyRpjJDrfsJAxw1gUcfrVz8+xKNVpHjGWKhtFEt6
         2A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IF2ajciyemVFavvF0K4Ysmdi6PN9HUjwhRLEE9yQtJs=;
        b=FFLfmkHNlI3fPseKBR1M9t8mPKDa02MTk3siZIDYRarJSgvaZV4xRciS0T0ys2l32N
         1S4THsBAADIBamJVG4iL0tR6+qgfndcfu6HAisvfZ6YgmIDeMelT3cgJqtI9nJoeFigC
         kV1tZjVAjvtJumMrXESVyaPfGTiGZ59yco85/3TBLXr59H81Qs0FRU4xiDvxcsl/06c6
         K3crG/XDfKucHosl89cxD2UaZ968z77E8R3J00BKSu7xA33BO6nL+TE8aCYtr7mR913m
         ZkqzdTP2Odzu5TkoaikUbqLEMGbN2CSLaroDfmspoiXO89Ojej2SnGocswaVtgsbUJtY
         lvgA==
X-Gm-Message-State: AHPjjUihWi1RvVLjhohifE9BvjHieZ9NaK6fcjUUctJiWSqeBI+s/sQh
        to4rLL6phyYL43t9
X-Google-Smtp-Source: AOwi7QCnNEEXtjyWhM16T2ksCBeo+aarxzaQHTLL9nk32ty6EKDbASM8QZqestzEGS7hm23g1elaIg==
X-Received: by 10.223.164.153 with SMTP id g25mr14598297wrb.67.1505549320123;
        Sat, 16 Sep 2017 01:08:40 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:39 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 40/40] Doc/external-odb: explain transfering objects and metadata
Date:   Sat, 16 Sep 2017 10:07:31 +0200
Message-Id: <20170916080731.13925-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/external-odb.txt | 105 +++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/technical/external-odb.txt b/Documentation/technical/external-odb.txt
index 58ec8a8145..76dd1e2e6c 100644
--- a/Documentation/technical/external-odb.txt
+++ b/Documentation/technical/external-odb.txt
@@ -340,3 +340,108 @@ can that contains:
 *.jpg           odb=magic
 ------------------------
 
+Transfering objects
+===================
+
+When an external odb helper is configured, the objects managed by the
+external odb are not put in the pack file that is sent (when pushing
+or answering clone and fetch requests), so the receiver should also
+have configured an external odb helper that can get the missing
+objects otherwise Git will error out complaining about missing
+objects.
+
+This has some drawbacks of course, but at least it makes sure that
+users' and admins' repositories are both properly configured to use a
+common external ODB before they can talk to each other.
+
+Transfering meta information and restartable clone
+==================================================
+
+There are different ways to make it possible for the external odb
+helpers to know which services they should get the objects from (or
+put them into), for example the information could be hardcoded into
+the helpers, or the information could be computed from configuration
+information like the url of the "origin" remote.
+
+The external odb mechanism itself doesn't really take care of this, so
+helpers are free to do whatever they want.
+
+One interesting possibility though is to have this information as part
+of the repository in special refs, for example refs/odb/magic/*, where
+"magic" is the external odb name.
+
+This would especially make it possible to implement a restartable
+clone using Git bundles (and an external odb helper) like this:
+
+	1) At the very start of the clone, Git would fetch the refs
+	that contain "meta information", for example refs/odb/magic/*
+	(where "magic" is the odb name). These refs would point to
+	some blobs that contain lists of the bundles that are
+	available for fetching by the helper, along with enough
+	information for the helper to fetch them (for example HTTP
+	urls of the bundles).
+
+	2) After this first fetch of the refs/odb/magic/* refs, the
+	helper would be sent the 'init' instruction. At that time it
+	can read all the blobs pointed to by these refs and download
+	the bundles listed in the blobs.
+
+	If something goes wrong when the helper "fetches" a bundle,
+	the helper could force the clone to error out (after maybe
+	retrying), and when the user (or the helper itself) tries
+	again to clone, the helper would restart its bundle "fetch"
+	(using the restartable protocol, for example HTTP).
+
+	When this "fetch" eventually succeeds, then the helper will
+	unbundle what it received, and then give back control to the
+	second regular part of the clone.
+
+	3) This regular part of the clone will then try to fetch the
+	usual refs, but as the unbundling has already updated the
+	content of the usual refs as well as the object stores this
+	fetch will find that everything is up-to-date.
+
+	Or if everything is not quite up-to-date and there are still
+	things to fetch, another hopefully much small regular fetch
+	will happen.
+
+As this is an interesting use of the external odb mechanism, the
+`--initial-refspec` option has been implemented in `git clone`. This
+makes it possible to perform all the above steps using a single clone
+command like:
+
+------------------------
+$ git clone -c odb.magic.scriptCommand="$HELPER" \
+  --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" "$URL"
+------------------------
+
+But note that the above could also be performed using:
+
+------------------------
+$ git init
+$ git remote add origin "$URL"
+$ git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*"
+$ git config odb.magic.scriptCommand "$HELPER"
+$ git fetch origin
+------------------------
+
+So the `--initial-refspec` option can be seen as just a shortcut to
+simplify external odb helped clones for users.
+
+Also note that this `--initial-refspec` approach could be slower than
+a regular clone, so it is mostly interesting if one wants to fetch a
+big number of objects or many big objects, like for an initial clone
+of a big repo. In this use case a relatively small amount of time
+spent in the initial fetch is an acceptable trade-off if the clone is
+restartable.
+
+Though in some cases, as the `--initial-refspec` clone could alleviate
+resource usage of the Git server, it could be even faster than a
+regular clone.
+
+So admins and users should not blindly use the `--initial-refspec`
+option all the time when an external odb is configured. But using an
+external odb in the first place means that they have specific
+requirements for handling objects which suggests that the regular way
+to clone might not be very good for their use cases and for the
+objects that are stored in their external ODBs.
-- 
2.14.1.576.g3f707d88cd

