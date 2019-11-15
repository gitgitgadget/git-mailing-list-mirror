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
	by dcvr.yhbt.net (Postfix) with ESMTP id 064C71F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKOBBV (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38458 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so3487458plq.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDaEV66oyC8M3jsTFMc8uV+NTrs+JXbrreg96Pzbs2Q=;
        b=MYtTFlcEk7M/YpyAV/UhT9D4K58fqBTfpKXRHwQHt2TZcLqTdg1rPtnUlOMvnnoQl9
         Asa83wJMwlviGUoDcD8lg4TKpXfrBEr2reqiVF3CWuwsOrOHyFj3I0tsVaRzB8cmf2Wk
         hTEBy7tknJ9u+FaXyfk2K0Jk2oK+akZZ+44siR2IYa3YjPU0FS6IUTJaqCL8h5dg5c/b
         TW4ZiRoyrxcdZc1MWwtnbYztZ4FMGe79J9hwNDri6gsO3jU+pXUuCRiVL7n7UnfFmEKI
         /Dtl8hBG5Z+ZlGcZOo2erscBFiRvD/RNY6nVuthD3+YRuFBY13Hr7TMEr6EjMmq5XCjx
         LmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDaEV66oyC8M3jsTFMc8uV+NTrs+JXbrreg96Pzbs2Q=;
        b=O2/sjwd4ccFf5M9yZRJTbJpVgotCc9pW12/RXLwU5hI2YHD/tA3jHA5O8xRFZDsYAd
         VG+Lmop85S/E+dN6DPYpegYHnVcqw8kWaLa3TKFQnnuSrBmyH/X13Fr1yfI+jQlgWhdb
         +ud9LhipqHGHVwgD2tU+twbqiUK7DSnj2nbdSBYDl/pq9irNFn0kdRmwa6WSaPa58obb
         CvucPnkfxofl47EP0TNT7w9YCgaiCI+Ghd/L74eDa5vZ5fys+hlMDaHDyCEaUVgal7sR
         SRwwvnlL/X2HOamt3y0n/TTNmghIP535NlN+VRN/g2/YQ/XSpuCPe/7yX5U09z68m8jK
         +PVQ==
X-Gm-Message-State: APjAAAXbN+tlrbgoLPSnSOhkXMuvN7glNucQMWWhAM1F9WLjeFfljoed
        dabPIY7CcJmrIAfaIpEWl+Bt3TXg
X-Google-Smtp-Source: APXvYqzNBGItC3Fe3yLq7PTxb+naoswJQC8d3ykuhp0X9CSaA+UdBsnbZCfjgUbmDbXY2Avmih7USg==
X-Received: by 2002:a17:90a:9b87:: with SMTP id g7mr16057315pjp.64.1573779679529;
        Thu, 14 Nov 2019 17:01:19 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 125sm7955717pfu.136.2019.11.14.17.01.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:19 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 20/27] t7700: stop losing return codes of git commands
Message-ID: <d9dcb23662bd09bb1325f20478475a8263e4a21b.1573779465.git.liu.denton@gmail.com>
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

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 64 ++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1d14ddcbdb..ff50722e26 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -18,14 +18,13 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	git commit -m initial_commit &&
 	# Create two packs
 	# The first pack will contain all of the objects except one
-	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack &&
+	git rev-list --objects --all >objs &&
+	grep -v file2 objs | git pack-objects pack &&
 	# The second pack will contain the excluded object
-	packsha1=$(git rev-list --objects --all | grep file2 |
-		git pack-objects pack) &&
+	packsha1=$(grep file2 objs | git pack-objects pack) &&
 	>pack-$packsha1.keep &&
-	objsha1=$(git verify-pack -v pack-$packsha1.idx | head -n 1 |
-		sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
+	git verify-pack -v pack-$packsha1.idx >packlist &&
+	objsha1=$(head -n 1 packlist | sed -e "s/^\([0-9a-f]\{40\}\).*/\1/") &&
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
@@ -33,7 +32,8 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -51,7 +51,8 @@ test_expect_success 'writing bitmaps via command-line can duplicate .keep object
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -69,7 +70,8 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -91,7 +93,8 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	git prune-packed &&
 	for p in .git/objects/pack/*.idx
 	do
-		if git verify-pack -v $p | egrep "^$objsha1"
+		git verify-pack -v $p >packlist || return $?
+		if egrep "^$objsha1" packlist
 		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
@@ -109,15 +112,18 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p"
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
@@ -132,15 +138,18 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
@@ -160,15 +169,18 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
-		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest
+		git verify-pack -v $p >packlist || return $?
+		sed -n -e "/^[0-9a-f]\{40\}/p" packlist
+	done >packs &&
+	git verify-pack -v $myidx >mypacklist &&
+	while read sha1 rest
 	do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		if ! grep "^$sha1" mypacklist
 		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-	done
+	done <packs
 '
 
 test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
@@ -184,8 +196,8 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! egrep "^$csha1 " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
@@ -201,8 +213,8 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	    --unpack-unreachable </dev/null pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
-	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		egrep "^$csha1 " | sort | uniq | wc -l) &&
+	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
+	! egrep "^$csha1 " &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
-- 
2.24.0.399.gf8350c9437

