Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6FBC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D03611CD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFLEbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:31:25 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:36395 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhFLEbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:31:25 -0400
Received: by mail-pl1-f172.google.com with SMTP id x10so3817061plg.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx196AKQvESKTDR5aAqf0/u0GE+KOcQVTvlEC0J9Wrs=;
        b=FuHkxVFYsiBrdSsuzxG45fJXhlwXyI0+0FbNqZsdwSklw1W9lyAmZct7hVCkyD958q
         rSNfv7Ut0FaZ7Y5fm7x2J07wTF5dZ3KcRp13Mek8K83DBtiIobEI5GKZqMsTf1aAhxRz
         FCyf5a2SaGby0lZz6arGD20nUT+KwJDnvXTEjcplvHnaYA1+erJHgGtYtERMqCnH01sq
         PAMD6eFtK5tEfO+yjMQsymrL2CjbeOjMkEydpa7p/n9mP56EsYAtRx8OHXnxPwVHdyjV
         eG2NF5V+xLqK2Y5LgVTppEcdi50jpx9qBPPfBahhh0cYC0yKjTNQFX26rxeSthi/p7n8
         dbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx196AKQvESKTDR5aAqf0/u0GE+KOcQVTvlEC0J9Wrs=;
        b=F1lcCoYV5TZ0bu84SB41dP6h4XLjnJwyWqC13IiYnGDmejOtedZRI+TQDtLb++Z9r0
         UVmjiSjCB6fVeGbkHgxUc45YpMQ8pZFYwGL0oBzlm/RrItc/IsPcJ1oVB5jTFlznT5Tm
         GspqdpFGQ3IvUFNWuSBtQWGaWtO9IPjshvAoESxQgWvZGm9TlbTFGDWxGsRqErHpzkTO
         4eO8Wy7sfsPseLLlNZANli/d4GgDv8Lt8cY2Ha8oWi49ZPDznJeypHVcbn5JpCMYWCe9
         R3gIBvaFhxFaWNDhh07WZhUGhs+yLTDSNukOlhh6WJNnn0xcwLAfeHa+ly0rwf+0/2/Y
         4arw==
X-Gm-Message-State: AOAM533PMlEOKwWiaY4/vevbXU51WmktgXJ78t4DEmyNdhXvCOHHfTcE
        S7oN4aJF9uOVr35tZ0tSTqXsDnKrx5kfyg==
X-Google-Smtp-Source: ABdhPJy+ZzKW5ihUjnjxAEvii9Ml2JjT0Khdr8hXUQ0houcWvgqrnJwzL7dw/w2tFzTGCSigFs/gFw==
X-Received: by 2002:a17:90b:d95:: with SMTP id bg21mr7601965pjb.115.1623472091532;
        Fri, 11 Jun 2021 21:28:11 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id w19sm11272539pjg.48.2021.06.11.21.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:28:11 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Date:   Sat, 12 Jun 2021 11:27:52 +0700
Message-Id: <20210612042755.28342-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210612042755.28342-1-congdanhqx@gmail.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git project, we have multiple occasions that requires checking number
of lines of text in stdout and/or stderr of a command. One of such
example is t6400, which checks number of files in various states.

Some of those commands are Git command, and we would like to check their
exit status.  In some of those checks, we pipe the stdout of those
commands to "wc -l" to check for line count, thus loosing the exit status.

Introduce a helper function to check for number of lines in stdout and
stderr from those commands.

This helper will create 2 temporary files in process, thus it may affect
output of some checks.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

Notes:
    Theoretically, we could avoid those temporary files by this shenanigan:
    
    	! (
    	  test $(
    		(
    		  test $(
    			  ( "$@" || echo "'$*' run into failure" >&3) | wc -l
    			)
    			"$out_ops" "$out_val" ||
    		  echo "stdout: !$outop $outval '$*'" >&3
    		) 2>&1 | wc -l
    	  ) "$errop" "$errval" ||
    	  echo "stderr: !$errop $errval '$*'" >&3
    	) 3>&1 | grep .
    
    However, it looks too complicated.

 t/test-lib-functions.sh | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b823c14027..85bb31ea4c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -817,6 +817,70 @@ test_line_count () {
 	fi
 }
 
+# test_line_count_cmd checks the number of lines of captured stdout and/or
+# stderr of a command.
+#
+# NOTE: this helper function will create 2 temporary files named:
+# * test_line_count_cmd_.out; and
+# * test_line_count_cmd_.err
+#
+# And this helper function will remove those 2 files if the check is succeed.
+# In case of failure, those files will be preserved.
+test_line_count_cmd () {
+	local outop outval
+	local errop errval
+
+	while test $# -ge 3
+	do
+		case "$1" in
+		--out)
+			outop="$2"
+			outval="$3"
+			;;
+		--err)
+			errop="$2"
+			errval="$3"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift 3
+	done &&
+	if test $# = 0 ||
+	   { test "x$1" = "x!" && test $# = 1 ; }
+	then
+		BUG "test_line_count_cmd: no command to be run"
+	fi &&
+	if test -z "$outop$errop"
+	then
+		BUG "test_line_count_cmd: check which stream?"
+	fi &&
+
+	if test "x$1" = "x!" 
+	then
+		shift &&
+		if "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
+		then
+			echo "error: '$@' succeed!"
+			return 1
+		fi
+	elif ! "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
+	then
+		echo "error: '$@' run into failure!"
+		return 1
+	fi &&
+	if test -n "$outop"
+	then
+		test_line_count "$outop" "$outval" test_line_count_cmd_.out
+	fi &&
+	if test -n "$errop"
+	then
+		test_line_count "$errop" "$errval" test_line_count_cmd_.err
+	fi &&
+	rm -f test_line_count_cmd_.out test_line_count_cmd_.err
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 
2.32.0.278.gd42b80f139

