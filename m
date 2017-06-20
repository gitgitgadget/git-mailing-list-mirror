Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DACBE20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbdFTH4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35069 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdFTH4q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21286750wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBA/gs7IgK/P/t6DAiLywqS8rAtguZ5NBA2P5tJVtXs=;
        b=aFleGBbIME3ZA56mmpTEvAknDm7iXc00P4R+yn+ILQ0JvInvFMlSZwNG9ZzQlcboV1
         6HIkaXdFJisFBtLuJm2sZhJkSP4gOSOoHi9M7zEk00s6O/7qyjpOOYAVsa44gL8VDi2i
         nmx29SbIozLcnMy7KxTS2rYbJTkHpHI+F1hkT5dwigvAyWfVsdlkKVZJz+pnbYJdkVhg
         IdA+3NMCP0ProYj/7KdFpy+CzKf+WnBsA+MQaIBawPr7iyUdFCunCUmyWT+ANYNpowDk
         NxUkNTC9bWp1QraBWKArzdiXL/Z0KSq1UfErIm8vAx9nlYcnkGFSdZyaehOWnSN34PPS
         +XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBA/gs7IgK/P/t6DAiLywqS8rAtguZ5NBA2P5tJVtXs=;
        b=Yax3pWfL9uVt4nwCx6CVKKCR5Wtr6RmiWd9djeB7YUEP9qQOBJZqLFgtuGPb51qQk3
         +1F7olMyqGomL3dWUTrbpPcVJiG6cGNqDjbcAo2xComeVk8/TdXh01zkdTrzOXK3v1+T
         ADGidFLItqBiQBr0fnkWvbtpTlIGIQjic38YcSD8aXL7QLMSU0Nt60CLoR6Qpq8bYoL8
         N2Q3ie1dsyTatSvSyA1ymqjkZLSkO0jKSDNqilkWwZ2lK6LC1I96yKFaOdr1KGLsBNxY
         B9Ax2BBr6mp4aSM40SYAR1AF/j57qDf7FrFTFMvt0YXJhDGZQA9RcKCJE9kp+L+/8feV
         MJ3w==
X-Gm-Message-State: AKS2vOwZgZFSyHHEgDFhU/Y612+ffxUbn2gkXmmzP4KGPOBgJ20HFeR7
        /gkYvvrS1cxY6upg
X-Received: by 10.28.50.70 with SMTP id y67mr1817021wmy.62.1497945394561;
        Tue, 20 Jun 2017 00:56:34 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:34 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 35/49] Add t0460 to test passing git objects
Date:   Tue, 20 Jun 2017 09:55:09 +0200
Message-Id: <20170620075523.26961-36-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0460-read-object-git.sh | 29 ++++++++++++++++++++
 t/t0460/read-object-git    | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 t/t0460-read-object-git.sh
 create mode 100755 t/t0460/read-object-git

diff --git a/t/t0460-read-object-git.sh b/t/t0460-read-object-git.sh
new file mode 100755
index 0000000000..d08b44cdce
--- /dev/null
+++ b/t/t0460-read-object-git.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process passing git objects'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0460"
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+HELPER="read-object-git"
+
+test_expect_success 'blobs can be retrieved from the host repo' '
+	git init guest-repo &&
+	(cd guest-repo &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.fetchKind "gitObject" &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'invalid blobs generate errors' '
+	cd guest-repo &&
+	test_must_fail git cat-file blob "invalid"
+'
+
+test_done
diff --git a/t/t0460/read-object-git b/t/t0460/read-object-git
new file mode 100755
index 0000000000..356a22cd4c
--- /dev/null
+++ b/t/t0460/read-object-git
@@ -0,0 +1,67 @@
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
+packet_read_and_check_capabilities("get");
+packet_write_capabilities("get");
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		my $path = $sha1;
+		$path =~ s{..}{$&/};
+		$path = $DIR . "/objects/" . $path;
+
+		my $contents = do {
+		    local $/;
+		    open my $fh, $path or die "Can't open '$path': $!";
+		    <$fh>
+		};
+
+		packet_bin_write($contents);
+		packet_flush();
+		packet_txt_write("status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.13.1.565.gbfcd7a9048

