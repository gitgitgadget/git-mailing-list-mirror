Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE8C9208D8
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdHCJUV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38229 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbdHCJUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id g32so571785wrd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6BV5Nck3BNN2dauKJj3lnr2crvOUmX+sAwqUHDbBRE0=;
        b=Jn89BXlcE8XPvHLLIxEwmKyHnPcQUEajKsqthTCFYKYYZwkbblxrukyTz9bb5/t9lp
         JS4FrN6suZEwTz/bPhq4YSlSxsbSOFnu+Ew5RaFhQuNrX2m51R/Xop1HoYzSTHHfV6zv
         yyxRZnDOiTUgri+CXWO8ZpRetp+miM/gZRCWMnznnVwXYC1Kqk9XdObY0D3XG/7KV+NQ
         B4C0JhcL/Y3uCuztx+Ws2puAGLTR+YTyiaNZiUwImqFY8GuIVIj7MiaV7bKcLIs7/voG
         Eo6ouomvdvsVIiJ+wbM7oGvqDaAIluVqjkgnlt3I1JyfGQBKlIjzxzE6XN8PAHc3ftb7
         UUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6BV5Nck3BNN2dauKJj3lnr2crvOUmX+sAwqUHDbBRE0=;
        b=HWyIRwUBawKKHq0+03Z56z9IuT8b3+f8wrrjKCXEiH1YdtTM9mL5qlUCqbUHP417cy
         TQ/Wwnd4aqwtmifJiJ8sL1y9YRppH9Jyc6YxrcWDThA/sdmxNqLadlxejbcTqFvQp4ot
         Rqa7+pAVzdNBJiF6uZ2WWUIoa8wREdP6fRsc7QGFCXWswyJcsv8gYzeau+pOdkPhe2v3
         B3N+NTYdoxKp4E+LwSZNvI4zGU/1vIH6qPOfBYKTLm+czpP3mNyQXeBMZmOSvvt69445
         VorXEvq83/IjbSvvjNlzhy0/5Ajft0N9++Ie1eTyDVPgFJe9IDtpWxXqFNyfK4zXVPik
         aHVw==
X-Gm-Message-State: AIVw112i4NkA0O0VvYVdSlHlaqjLX4Fvv9xmL9rO8TcOSH5LIuvB487G
        XNo+WCquDvmKnp0Q
X-Received: by 10.223.163.10 with SMTP id c10mr758010wrb.164.1501752012244;
        Thu, 03 Aug 2017 02:20:12 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:11 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v5 28/40] Add t0450 to test 'get_direct' mechanism
Date:   Thu,  3 Aug 2017 11:19:14 +0200
Message-Id: <20170803091926.1755-29-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0450-read-object.sh | 28 +++++++++++++++++++++
 t/t0450/read-object    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object

diff --git a/t/t0450-read-object.sh b/t/t0450-read-object.sh
new file mode 100755
index 0000000000..6b97305452
--- /dev/null
+++ b/t/t0450-read-object.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0450"
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+HELPER="read-object"
+
+test_expect_success 'blobs can be retrieved from the host repo' '
+	git init guest-repo &&
+	(cd guest-repo &&
+	 git config odb.magic.subprocessCommand "$HELPER" &&
+	 git cat-file blob "$hash1" >/dev/null)
+'
+
+test_expect_success 'invalid blobs generate errors' '
+	cd guest-repo &&
+	test_must_fail git cat-file blob "invalid"
+'
+
+test_done
diff --git a/t/t0450/read-object b/t/t0450/read-object
new file mode 100755
index 0000000000..cf22e2f581
--- /dev/null
+++ b/t/t0450/read-object
@@ -0,0 +1,68 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /e/guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling 
+# was implemented.
+#
+
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use Git::Packet;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "../.git/";
+
+packet_initialize("git-read-object", 1);
+
+packet_read_and_check_capabilities("get_direct");
+packet_write_capabilities("get_direct");
+
+while (1) {
+	my ($res, $command) = packet_txt_read();
+
+	if ( $res == -1 ) {
+		exit 0;
+	}
+
+	$command =~ s/^command=//;
+
+	if ( $command eq "init" ) {
+		packet_bin_read();
+
+		packet_txt_write("status=success");
+		packet_flush();
+	} elsif ( $command eq "get_direct" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | GIT_NO_EXTERNAL_ODB=1 git hash-object -w --stdin >/dev/null 2>&1');
+
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

