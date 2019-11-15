Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33E0E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKOBA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:00:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOBAz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:00:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so5449968pfn.12
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lc83agBZRYyQyaq7Jlodkh3tF/B8joXU/DGPzO7/iR0=;
        b=D0hzajHP74vdDv3Tu7T04NCAoZk4wmJJRdT+Sxj4qF1Z372bCx4FzaZC/sR3f3f/FU
         7cBxBLuijqBNBev9Sc47KEUMS6DytnDyneU4Pa7EBIRog8cFpPYtFvQcBn/bX0sgd9hD
         oE8jmX0DReri+bDn9WOsBx6MU9nbMWqdZgzBVMQRt3xA+FWJCmoy/Yf9T9kGHuV59p+W
         bPMquyigOA+ZjZnwM8qN/DB/Frq03ov4er7KVzUquKB215VTksQoNdgP5jTqgonoKd9h
         UMbJ1e4EiZcyax3KOMLOEmkazfua8ZiqsEvcoHganfVKf2kqXmjqLqEcZXHLjRKyDPYW
         34cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lc83agBZRYyQyaq7Jlodkh3tF/B8joXU/DGPzO7/iR0=;
        b=RrtMZNiJiC1WPcf2NXycOawgTGGYpw3i0yyC+1tFc5sRZjSGpmUCRwTfb9N5UJy26L
         VdDqv5ufu6/9R5glrtenuTPL8RuzQZHJwLbBwMDwslmuFrAv0K/fOLR+IzeErtXwvsBe
         71/8ogwWYxq7BesCMTz/KwknVxFsGGLkGkH868lySr6tKvN2NmIANDEiae7iAytxzrzF
         38rbUTV4P0i/pGiyIxgbtIl+igh9vBqSNm7UHss9aznz9YQlKTNXCVI0OuGtHOd7FGOD
         gLv2F62i97hM3dKvUk2a+R0AnqOtk4FicBPm8Zvu0d1eIrf9KNCBG6MigGFrp8+g+i3v
         dFDg==
X-Gm-Message-State: APjAAAXd13SHEq1ZfT7EC+qT0xbJkeMmI2YOjUkBP0lxX8Gp9r6e9jTV
        FBpEIGcbwWqoJ/QPxFmvwQEbdSJB
X-Google-Smtp-Source: APXvYqxe6h+6qfH+/YtAGxQLS8U8DDcrwbVMI0DNLkoefTlk+n4BWHFoH1z7qVuEarBMUCtNfA8WvQ==
X-Received: by 2002:a63:dc45:: with SMTP id f5mr10696793pgj.250.1573779652808;
        Thu, 14 Nov 2019 17:00:52 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id fz12sm6833139pjb.15.2019.11.14.17.00.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:00:52 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:00:49 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 08/27] t4015: stop losing return codes of git commands
Message-ID: <ea17bfa60eefd446c06702e111908f9d46d7a8d6.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this so that git commands are either run
on their own or in an assignment-only command substitution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 119 ++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index eadaf57262..7fb83c8eff 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -16,7 +16,8 @@ test_expect_success "Ray Lehtiniemi's example" '
 	} while (0);
 	EOF
 	git update-index --add x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 
 	cat <<-\EOF >x &&
 	do
@@ -25,7 +26,8 @@ test_expect_success "Ray Lehtiniemi's example" '
 	}
 	while (0);
 	EOF
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	cat <<-EOF >expect &&
 	diff --git a/x b/x
@@ -63,7 +65,8 @@ test_expect_success 'another test, without options' '
 	EOF
 
 	git update-index x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 
 	tr "_" " " <<-\EOF >x &&
 	_	whitespace at beginning
@@ -73,7 +76,8 @@ test_expect_success 'another test, without options' '
 	unchanged line
 	CR at end
 	EOF
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
@@ -526,13 +530,15 @@ test_expect_success 'ignore-blank-lines: mix changes and blank lines' '
 test_expect_success 'check mixed spaces and tabs in indent' '
 	# This is indented with SP HT SP.
 	echo " 	 foo();" >x &&
-	git diff --check | grep "space before tab in indent"
+	test_must_fail git diff --check >check &&
+	grep "space before tab in indent" check
 '
 
 test_expect_success 'check mixed tabs and spaces in indent' '
 	# This is indented with HT SP HT.
 	echo "	 	foo();" >x &&
-	git diff --check | grep "space before tab in indent"
+	test_must_fail git diff --check >check &&
+	grep "space before tab in indent" check
 '
 
 test_expect_success 'check with no whitespace errors' '
@@ -753,20 +759,23 @@ test_expect_success 'check tab-in-indent excluded from wildcard whitespace attri
 test_expect_success 'line numbers in --check output are correct' '
 	echo "" >x &&
 	echo "foo(); " >>x &&
-	git diff --check | grep "x:2:"
+	test_must_fail git diff --check >check &&
+	grep "x:2:" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 	echo "foo();" >x &&
 	echo "" >>x &&
-	git diff --check | grep "new blank line"
+	test_must_fail git diff --check >check &&
+	grep "new blank line" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
 	{ echo a; echo b; echo; echo; } >x &&
 	git add x &&
 	{ echo a; echo; echo; echo; echo; } >x &&
-	git diff --check | grep "new blank line"
+	test_must_fail git diff --check >check &&
+	grep "new blank line" check
 '
 
 test_expect_success 'checkdiff allows new blank lines' '
@@ -794,14 +803,16 @@ test_expect_success 'whitespace-only changes reported across renames' '
 	git reset --hard &&
 	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
 	git add x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$hash_x") &&
 	git commit -m "base" &&
 	sed -e "5s/^/ /" x >z &&
 	git rm x &&
 	git add z &&
-	after=$(git rev-parse --short $(git hash-object z)) &&
-	git diff -w -M --cached |
-	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" >actual &&
+	hash_z=$(git hash-object z) &&
+	after=$(git rev-parse --short "$hash_z") &&
+	git diff -w -M --cached >actual.raw &&
+	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" actual.raw >actual &&
 	cat <<-EOF >expect &&
 	diff --git a/x b/z
 	similarity index NUM%
@@ -840,7 +851,8 @@ test_expect_success 'combined diff with autocrlf conversion' '
 	git config core.autocrlf true &&
 	test_must_fail git merge master &&
 
-	git diff | sed -e "1,/^@@@/d" >actual &&
+	git diff >actual.raw &&
+	sed -e "1,/^@@@/d" actual.raw >actual &&
 	! grep "^-" actual
 
 '
@@ -864,11 +876,14 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	git config core.whitespace blank-at-eol &&
 	git reset --hard &&
 	echo "test" >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -m "initial" x &&
 	echo "{NTN}" | tr "NT" "\n\t" >>x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
-	git diff --color | test_decode_color >current &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
+	git diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -891,17 +906,19 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
-	git diff --color |
-	test_decode_color >current &&
+	git diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -925,14 +942,16 @@ test_expect_success 'ws-error-highlight test setup' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	cat >expect.default-old <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -974,32 +993,32 @@ test_expect_success 'ws-error-highlight test setup' '
 
 test_expect_success 'test --ws-error-highlight option' '
 
-	git diff --color --ws-error-highlight=default,old |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=default,old >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
-	git diff --color --ws-error-highlight=all |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=all >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
-	git diff --color --ws-error-highlight=none |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=none >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
 
 test_expect_success 'test diff.wsErrorHighlight config' '
 
-	git -c diff.wsErrorHighlight=default,old diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
-	git -c diff.wsErrorHighlight=all diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=all diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
-	git -c diff.wsErrorHighlight=none diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=none diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
@@ -1007,18 +1026,18 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 test_expect_success 'option overrides diff.wsErrorHighlight' '
 
 	git -c diff.wsErrorHighlight=none \
-		diff --color --ws-error-highlight=default,old |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=default,old >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
 	git -c diff.wsErrorHighlight=default \
-		diff --color --ws-error-highlight=all |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=all >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
 	git -c diff.wsErrorHighlight=all \
-		diff --color --ws-error-highlight=none |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=none >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
@@ -1038,7 +1057,8 @@ test_expect_success 'detect moved code, complete file' '
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
-	git diff HEAD --color-moved=zebra --color --no-renames | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
@@ -1141,9 +1161,12 @@ test_expect_success 'detect malicious moved code, inside file' '
 			bar();
 		}
 	EOF
-	after_main=$(git rev-parse --short $(git hash-object main.c)) &&
-	after_test=$(git rev-parse --short $(git hash-object test.c)) &&
-	git diff HEAD --no-renames --color-moved=zebra --color | test_decode_color >actual &&
+	hash_main=$(git hash-object main.c) &&
+	after_main=$(git rev-parse --short "$hash_main") &&
+	hash_test=$(git hash-object test.c) &&
+	after_test=$(git rev-parse --short "$hash_test") &&
+	git diff HEAD --no-renames --color-moved=zebra --color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index $before_main..$after_main 100644<RESET>
@@ -1192,7 +1215,8 @@ test_expect_success 'plain moved code, inside file' '
 	test_config color.diff.oldMovedAlternative "blue" &&
 	test_config color.diff.newMovedAlternative "yellow" &&
 	# needs previous test as setup
-	git diff HEAD --no-renames --color-moved=plain --color | test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=plain --color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index $before_main..$after_main 100644<RESET>
@@ -1771,7 +1795,8 @@ test_expect_success 'move detection with submodules' '
 	! grep BRED decoded_actual &&
 
 	# nor did we mess with it another way
-	git diff --submodule=diff --color | test_decode_color >expect &&
+	git diff --submodule=diff --color >expect.raw &&
+	test_decode_color <expect.raw >expect &&
 	test_cmp expect decoded_actual &&
 	rm -rf bananas &&
 	git submodule deinit bananas
-- 
2.24.0.399.gf8350c9437

