Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A8620401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbdFTH4n (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36512 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbdFTH4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so21333815wme.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52urNxnbi0bCIu2Ea9osSTep9kr1XoEhuhzhlh75cCs=;
        b=a6jVk6khSvi0Saxq6YvosJtnb7IjX+xQQ2fgtCxtz+e2brJeddJ+819KU+ETVbASbm
         dfdA6MQ9E6/FX9AF48qtvz8X2hRtmgSZ+tGNUby+t3qjWobQ82lSiIQRYccxTegVjYOE
         2Ljqn8UWx8QuwLDOJTkBQnLwZHSKblHiM8xMPmQJwwYu1VwpZCkO4pLARf+avwITNuoB
         E1Z6Nm/GPqaqg8Ey8aJdepCzp+Q6Yrf/9GjQja90e+z5/ly6yw73wFK8oErc5bncIHDD
         YekDFNlRWzRjIjIV/MPi84HL9OOe2tIAaKQsPQzaPCoLRjKIWob6PoTySYx0EZ6ucDP6
         keTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52urNxnbi0bCIu2Ea9osSTep9kr1XoEhuhzhlh75cCs=;
        b=oWtzP+PmGJyYFTCpGxGlq4nAyzgbDeMel4U9rxRoWiinv3Kwi+Tv6mGg6Of6x+m4U4
         8Y0rUmSvwhaANyGruEMemgWWIhLRhsifS8UZ69fiCmwTln+UyD5BbZV2RBJsZoflaev7
         WVHBVK6oe27TYJzqfpnQTkRGnqZcUnd3Ydp0Y97c0lTLp/eBPzJ7JkLsnTGRdFDF6+1s
         IOGrcGRjeGlQSSjXytIfgvUrkjScg8pHHLkCuuby3VPaEvnrDLz/apY5PKOTrqPUYu1R
         itgcfhUzsc303kwhTJNSIb9jI+itL+Ki10BFYYB70LKBkOeMEydLQQlYKOxijpwYdxI0
         5brg==
X-Gm-Message-State: AKS2vOz4PxeKQGaZjpsMvAqCeFP5z9JnaWf7HJeBNuVRla8zp68CCxg5
        hletd3zwxSc+zfst
X-Received: by 10.28.1.205 with SMTP id 196mr1734940wmb.100.1497945398410;
        Tue, 20 Jun 2017 00:56:38 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:37 -0700 (PDT)
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
Subject: [RFC/PATCH v4 38/49] Add t0470 to test passing plain objects
Date:   Tue, 20 Jun 2017 09:55:12 +0200
Message-Id: <20170620075523.26961-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0470-read-object-http-e-odb.sh | 123 ++++++++++++++++++++++++++++++++++++++
 t/t0470/read-object-plain         |  93 ++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100755 t/t0470-read-object-http-e-odb.sh
 create mode 100755 t/t0470/read-object-plain

diff --git a/t/t0470-read-object-http-e-odb.sh b/t/t0470-read-object-http-e-odb.sh
new file mode 100755
index 0000000000..3360a98ec3
--- /dev/null
+++ b/t/t0470-read-object-http-e-odb.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='tests for read-object process passing plain objects to an HTTPD server'
+
+. ./test-lib.sh
+
+# If we don't specify a port, the current test number will be used
+# which will not work as it is less than 1024, so it can only be used by root.
+LIB_HTTPD_PORT=$(expr ${this_test#t} + 12000)
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd apache-e-odb.conf
+
+PATH="$PATH:$TEST_DIRECTORY/t0470"
+
+# odb helper script must see this
+export HTTPD_URL
+
+HELPER="read-object-plain"
+
+test_expect_success 'setup repo with a root commit' '
+	test_commit zero
+'
+
+test_expect_success 'setup another repo from the first one' '
+	git init other-repo &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+test_expect_success 'setup the helper in the root repo' '
+	git config odb.magic.command "$HELPER" &&
+	git config odb.magic.fetchKind "plainObject"
+'
+
+UPLOADFILENAME="hello_apache_upload.txt"
+
+UPLOAD_URL="$HTTPD_URL/upload/?sha1=$UPLOADFILENAME&size=123&type=blob"
+
+test_expect_success 'can upload a file' '
+	echo "Hello Apache World!" >hello_to_send.txt &&
+	echo "How are you?" >>hello_to_send.txt &&
+	curl --data-binary @hello_to_send.txt --include "$UPLOAD_URL" >out_upload
+'
+
+LIST_URL="$HTTPD_URL/list/"
+
+test_expect_success 'can list uploaded files' '
+	curl --include "$LIST_URL" >out_list &&
+	grep "$UPLOADFILENAME" out_list
+'
+
+test_expect_success 'can delete uploaded files' '
+	curl --data "delete" --include "$UPLOAD_URL&delete=1" >out_delete &&
+	curl --include "$LIST_URL" >out_list2 &&
+	! grep "$UPLOADFILENAME" out_list2
+'
+
+FILES_DIR="httpd/www/files"
+
+test_expect_success 'new blobs are transfered to the http server' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	echo "$hash1-4-blob" >expected &&
+	ls "$FILES_DIR" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blobs can be retrieved from the http server' '
+	git cat-file blob "$hash1" &&
+	git log -p >expected
+'
+
+test_expect_success 'update other repo from the first one' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.fetchKind "plainObject" &&
+	 git cat-file blob "$hash1" &&
+	 git pull origin master)
+'
+
+test_expect_success 'local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone .. . &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'no-local clone from the first repo fails' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 test_must_fail git clone --no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local clone from the first repo with helper succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git clone -c odb.magic.command="$HELPER" \
+		-c odb.magic.plainObjects="true" \
+		--no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local initial-refspec clone succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.fetchKind "plainObject" &&
+	 git -c odb.magic.command="$HELPER" \
+		-c odb.magic.plainObjects="true" \
+		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
+stop_httpd
+
+test_done
diff --git a/t/t0470/read-object-plain b/t/t0470/read-object-plain
new file mode 100755
index 0000000000..bb65ca908a
--- /dev/null
+++ b/t/t0470/read-object-plain
@@ -0,0 +1,93 @@
+#!/usr/bin/perl
+#
+
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use Git::Packet;
+use LWP::UserAgent;
+use HTTP::Request::Common;
+
+print STDERR "read-object-plain: starting\n";
+
+packet_initialize("git-read-object", 1);
+
+print STDERR "read-object-plain: after init\n";
+
+packet_read_and_check_capabilities("get", "put");
+packet_write_capabilities("get", "put");
+
+print STDERR "read-object-plain: after reading and writing get capability\n";
+
+my $http_url = $ENV{HTTPD_URL};
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	print STDERR "read-object-plain: command: '$command'\n";
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		my $get_url = $http_url . "/list/?sha1=" . $sha1;
+		print STDERR "read-object-plain: get_url: '$get_url'\n";
+
+		my $userAgent = LWP::UserAgent->new();
+
+		my $response = $userAgent->get( $get_url );
+
+		if ($response->is_error) {
+		    print STDERR $response->error_as_HTML . "\n";
+		    packet_txt_write("size=0");
+		    packet_txt_write("kind=none");	    
+		    packet_txt_write("status=notfound");
+		} else {
+		    print STDERR "content: \n";
+		    print STDERR $response->content;
+		    packet_txt_write("size=" . length($response->content));
+		    packet_txt_write("kind=blob");
+		    packet_bin_write($response->content);
+		    packet_flush();
+		    packet_txt_write("status=success");
+		}
+
+		packet_flush();
+	} elsif ( $command eq "put" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		print STDERR "read-object-plain: put sha1: '$sha1'\n";
+
+		my ($size) = packet_txt_read() =~ /^size=([0-9]+)$/;
+		print STDERR "read-object-plain: put size: '$size'\n";
+
+		my ($kind) = packet_txt_read() =~ /^kind=(\w+)$/;
+		print STDERR "read-object-plain: put kind: '$kind'\n";
+
+		packet_bin_read();
+
+		# We must read the content we are sent and send it to the right url
+		my ($res, $buf) = packet_bin_read();
+		die "bad packet_bin_read res ($res)" unless ($res eq 0);
+		( packet_bin_read() eq ( 1, "" ) ) || die "bad send end";		
+
+		my $upload_url = $http_url . "/upload/?sha1=" . $sha1 . "&size=" . $size . "&type=blob";
+		print STDERR "read-object-plain: upload_url: '$upload_url'\n";
+		print STDERR "read-object-plain: upload buffer: '$buf'\n";
+
+		my $userAgent = LWP::UserAgent->new();
+		my $request = POST $upload_url, Content_Type => 'multipart/form-data', Content => $buf;
+
+		my $response = $userAgent->request($request);
+
+		if ($response->is_error) {
+			print STDERR $response->error_as_HTML . "\n";
+			packet_txt_write("status=failure");
+		} else {
+			packet_txt_write("status=success");
+		}
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.13.1.565.gbfcd7a9048

