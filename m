Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBCBC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA02F2053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKmd8uVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgHOVxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgHOVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD592C025575
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so13021016ljc.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSXUzHrsp5+czKqabMJHrVPCaZGWcEcvsQY5uNE3Occ=;
        b=kKmd8uVJoZyYPbFwDqD1fj7xUXY87oX/oaZ81T8s0ORLjrYD+NXtVOm+esGDWWAjJ+
         Q/8EAfml3nMNQcvrD5w4E+5hN5NhAni4Ns5mgQnmLJd7BNWjILVe9D8tcngJT2A5aSx1
         CUdskD2glNuTJsdfOT5Tdi7wCdNUgiyj+EBDbla3A+K0OQBAjsEsaqxpD9v19nknxEKh
         aKSfFB6oaJJXVfmNnQx9iN8CsnO+eliUL26PIo1H3nc3hZA9Vi1Jrq/IbNHdzuLzz/OV
         77AmSOUGJE1ZktY7JjgeKK4jYdhLwv3eIIDsAWD3LVK77ch/haTUjFLhFxwubv//2L3P
         iydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSXUzHrsp5+czKqabMJHrVPCaZGWcEcvsQY5uNE3Occ=;
        b=trk31KEroq1gO6N3Sp7WIGov9NMLBplvBITVjsDa0/zyKpCea16nUak56rTusMFFCG
         hNcQI88gwTKWgloQfbtLDEu1yxX5g156sch+52+8x3xOb927sputgGCCw34djui6WW7h
         UKoJdk6GVMi4JJ8YWKBDf/m5Wpaa14DCqns1YgfQqf8gdp4Yh/Nn+DxmHA8Y1MvntYkc
         KkI8t6Yjq1Csq/eLrg7wecNlP8QEzXyTp/i0DEbvS4Banmk9hW5MWzj9VKIh7qo4HhWj
         volpgF9IkDjlvzDFeO6Ki6oofGTPRKjBEhnzLiM5PXw2k3RpSg9ea0aDwCNSsPme7hxC
         ydew==
X-Gm-Message-State: AOAM531NT1N70zQFOddotlCt8y4xq66HrGbBPJQsEBKklNR4dIIJ2OoN
        A3gzMs9Vkt2NOHLJrc3QiOiOJ78J5PQ=
X-Google-Smtp-Source: ABdhPJyM3t6GnHQyOv71K0jfwkB/gC3Kvg3IKKsUeVw2AiiLRfJDZ076/tZystCGrEPp1wusgvZRHw==
X-Received: by 2002:a2e:3802:: with SMTP id f2mr3372712lja.212.1597507591897;
        Sat, 15 Aug 2020 09:06:31 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a1sm2670493lfb.10.2020.08.15.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:06:31 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] protocol-capabilities.txt: clarify "allow-x-sha1-in-want" re SHA-256
Date:   Sat, 15 Aug 2020 18:06:01 +0200
Message-Id: <2e82be9e365d5157a604a599d764fa39664ab684.1597506837.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <cover.1597506837.git.martin.agren@gmail.com>
References: <cover.1597406877.git.martin.agren@gmail.com> <cover.1597506837.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two of our capabilities contain "sha1" in their names, but that's
historical. Clarify that object names are still to be given using
whatever object format has been negotiated using the "object-format"
capability.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/protocol-capabilities.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 36ccd14f97..124d716807 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -324,15 +324,19 @@ allow-tip-sha1-in-want
 ----------------------
 
 If the upload-pack server advertises this capability, fetch-pack may
-send "want" lines with SHA-1s that exist at the server but are not
-advertised by upload-pack.
+send "want" lines with object names that exist at the server but are not
+advertised by upload-pack. For historical reasons, the name of this
+capability contains "sha1". Object names are always given using the
+object format negotiated through the 'object-format' capability.
 
 allow-reachable-sha1-in-want
 ----------------------------
 
 If the upload-pack server advertises this capability, fetch-pack may
-send "want" lines with SHA-1s that exist at the server but are not
-advertised by upload-pack.
+send "want" lines with object names that exist at the server but are not
+advertised by upload-pack. For historical reasons, the name of this
+capability contains "sha1". Object names are always given using the
+object format negotiated through the 'object-format' capability.
 
 push-cert=<nonce>
 -----------------
-- 
2.28.0.297.g1956fa8f8d

