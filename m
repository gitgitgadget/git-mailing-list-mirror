Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75181F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDPWlZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42345 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeDPWlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id s18so30243670wrg.9
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9RI3qSECP3eSU3NMpO1eLkmrMjreG7ZjWkNY8ntvX4=;
        b=aO9b1W4YvrY5cqk+GzfnFdiZueOaR1oBEVpiLUZw/ThEluIXmciGSaK8vlHvw/cGxO
         X/WDkGahglxvdDTdoVyUyfD6Ir6cot4Id+jJMC+yD4fHP4nFC4alFitdoFTg10CwhWIJ
         yVtoLVtjZyaB0976YqAnUJoimjBaj0vZlhkfTPcFjidkMGSIJW0mhdWBDv+crTtptu9i
         syVsKnzB1KcjrNP5TNZMsggHEOM5fKv2aIpv2eFiYNLVtr227PsAyDuSn+J2Vwq3qiUp
         3pMgTFg8gXCxHZfBNcSpwpa7hTKrKh5tTyPXEsV+B6FOo+2xbpnRp/Qt/avnyspGpVNS
         iBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9RI3qSECP3eSU3NMpO1eLkmrMjreG7ZjWkNY8ntvX4=;
        b=JGe1DErbArm7UrZNuUKYC/alu9zLRYOYq9IF9NnGsBpbTqyi/x4ys7aU+Y+Y7k1Za8
         YY05g5i6dfYcTX10xldXzWV1a/2LNEH9hWaUqPgIzZouuwoTP/fm/sWinOdCW+SNK8QT
         FYyg7zxNF+SnaITpCjJBYykB7cOPXCJJCVePyA96sJi8skklIHAjA9wgt0qlE8yTysEE
         OWr5gSVZAGGKXsoiSq1oRGQvqBR6JhnpI2W5ssZr/Y2WpeYKxixTMdjZqV0STWmpDNdm
         OCKU3WyIpYftvMc3zmHb2QzyMIj1vVRAh3HFs5H5LGKfpR54oF7vi3uVhzb0PIqyvMmY
         T1vg==
X-Gm-Message-State: ALQs6tCMjkU05rMn2iVT71RFdkger4KsW4DmWGSSO5MpXrFpqJ7XK01z
        DYUETcwc/Y+g3+IbGWUnnODxPQ==
X-Google-Smtp-Source: AIpwx4/iYli0SHgipUeRyZowY7N8SPFfml8pCfXVsXaFTt4uKdbJDDOde9MSrz/fqpJwseWhI/7Zjg==
X-Received: by 10.223.192.3 with SMTP id z3mr11083014wre.177.1523918482185;
        Mon, 16 Apr 2018 15:41:22 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 01/11] t9902-completion: add tests demonstrating issues with quoted pathnames
Date:   Tue, 17 Apr 2018 00:41:05 +0200
Message-Id: <20180416224113.16993-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion functions see all words on the command line verbatim,
including any backslash-escapes, single and double quotes that might
be there.  Furthermore, git commands quote pathnames if they contain
certain special characters.  All these create various issues when
doing git-aware path completion.

Add a couple of failing tests to demonstrate these issues.

Later patches in this series will discuss these issues in detail as
they fix them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    Do any more new tests need FUNNYNAMES* prereq?

 t/t9902-completion.sh | 91 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b7f5b1e632..ff2e4a8f5f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1427,6 +1427,97 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
+# The next tests only care about how the completion script deals with
+# unusual characters in path names.  By defining a custom completion
+# function to list untracked files they won't be influenced by future
+# changes of the completion functions of real git commands, and we
+# don't have to bother with adding files to the index in these tests.
+_git_test_path_comp ()
+{
+	__git_complete_index_file --others
+}
+
+test_expect_failure 'complete files - escaped characters on cmdline' '
+	test_when_finished "rm -rf \"New|Dir\"" &&
+	mkdir "New|Dir" &&
+	>"New|Dir/New&File.c" &&
+
+	test_completion "git test-path-comp N" \
+			"New|Dir" &&	# Bash will turn this into "New\|Dir/"
+	test_completion "git test-path-comp New\\|D" \
+			"New|Dir" &&
+	test_completion "git test-path-comp New\\|Dir/N" \
+			"New|Dir/New&File.c" &&	# Bash will turn this into
+						# "New\|Dir/New\&File.c "
+	test_completion "git test-path-comp New\\|Dir/New\\&F" \
+			"New|Dir/New&File.c"
+'
+
+test_expect_failure 'complete files - quoted characters on cmdline' '
+	test_when_finished "rm -r \"New(Dir\"" &&
+	mkdir "New(Dir" &&
+	>"New(Dir/New)File.c" &&
+
+	test_completion "git test-path-comp \"New(D" "New(Dir" &&
+	test_completion "git test-path-comp \"New(Dir/New)F" \
+			"New(Dir/New)File.c"
+'
+
+test_expect_failure 'complete files - UTF-8 in ls-files output' '
+	test_when_finished "rm -r árvíztűrő" &&
+	mkdir árvíztűrő &&
+	>"árvíztűrő/Сайн яваарай" &&
+
+	test_completion "git test-path-comp á" "árvíztűrő" &&
+	test_completion "git test-path-comp árvíztűrő/С" \
+			"árvíztűrő/Сайн яваарай"
+'
+
+if test_have_prereq !MINGW &&
+   mkdir 'New\Dir' 2>/dev/null &&
+   touch 'New\Dir/New"File.c' 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES_BS_DQ
+else
+	say "Your filesystem does not allow \\ and \" in filenames."
+	rm -rf 'New\Dir'
+fi
+test_expect_failure FUNNYNAMES_BS_DQ \
+    'complete files - C-style escapes in ls-files output' '
+	test_when_finished "rm -r \"New\\\\Dir\"" &&
+
+	test_completion "git test-path-comp N" "New\\Dir" &&
+	test_completion "git test-path-comp New\\\\D" "New\\Dir" &&
+	test_completion "git test-path-comp New\\\\Dir/N" \
+			"New\\Dir/New\"File.c" &&
+	test_completion "git test-path-comp New\\\\Dir/New\\\"F" \
+			"New\\Dir/New\"File.c"
+'
+
+if test_have_prereq !MINGW &&
+   mkdir $'New\034Special\035Dir' 2>/dev/null &&
+   touch $'New\034Special\035Dir/New\036Special\037File' 2>/dev/null
+then
+	test_set_prereq FUNNYNAMES_SEPARATORS
+else
+	say 'Your filesystem does not allow special separator characters (FS, GS, RS, US) in filenames.'
+	rm -rf $'New\034Special\035Dir'
+fi
+test_expect_failure FUNNYNAMES_SEPARATORS \
+    'complete files - \nnn-escaped control characters in ls-files output' '
+	test_when_finished "rm -r '$'New\034Special\035Dir''" &&
+
+	# Note: these will be literal separator characters on the cmdline.
+	test_completion "git test-path-comp N" "'$'New\034Special\035Dir''" &&
+	test_completion "git test-path-comp '$'New\034S''" \
+			"'$'New\034Special\035Dir''" &&
+	test_completion "git test-path-comp '$'New\034Special\035Dir/''" \
+			"'$'New\034Special\035Dir/New\036Special\037File''" &&
+	test_completion "git test-path-comp '$'New\034Special\035Dir/New\036S''" \
+			"'$'New\034Special\035Dir/New\036Special\037File''"
+'
+
+
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
 	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
-- 
2.17.0.366.gbe216a3084

