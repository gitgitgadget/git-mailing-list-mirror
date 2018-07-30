Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9BC1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG3UoE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:44:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37135 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbeG3UoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:44:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so4942249pfo.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jV9tIp/r+iQvUfQh98QYpVPK91fZlX8oJwZCBFfQ96w=;
        b=YQ7rYhEYkQuusxAK3TJF9ICAHW5OD/+3G/HvWqHza2pC/p7xI2j74XlS4kTv4q1rIK
         fWdRBB9oFvre7/JN5gsiqpSPV7k4PoNurcodx58ZOhenC1DZ2EpC6rYTfPgQA9XsbAkG
         NpXIvd7h/M3r1dyW/bx20+6YEbqhLmzcF5EGYkha+PMOcP7SOl4/u/Zk+1cjVXSsOLe4
         uIbTEFM1ZDF1Yv67Qpgafr48pItpEo2dhQDukkdzRrVrkZ/3t/bk7FIYrMhFdqjFCm0G
         J67NXU2xVJDnLDkpVS0s+Uq8lWZUC0wOlNLAPwC+kzqkCBwVX/pCtWcCIKm/q1lXxepo
         0Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jV9tIp/r+iQvUfQh98QYpVPK91fZlX8oJwZCBFfQ96w=;
        b=mD9BVxrHVed7s0CYTIfWAM3WA7BoQQj3E3J7n4i/38AIR6yPC9js1nXG1R+UPu0j88
         wHaG+Cqr+t+iiEMQfp6lGocO4FwbeanqfYmw4cY1DaKEkFJbr+zLWmY+7nRMwkJub40y
         ABfws5waWygwHY3h2alSphnXvwNbnA/ps6Jd8ppOStspiCjmIvDPmzQQkC5xyvOCtxQq
         WYZ/9bdev9N2fDveHIuvqaG+JDibVtMTXivC5PL9SbQYcqTRIO1VP+Ue5Swyvs8jeaGN
         uZ7o1/8voNiE2taiZhQiIf4wyXC11YeWEsn1v/Qaz8he77UyMTAU7IvwRGizJYmd6Tga
         wyiQ==
X-Gm-Message-State: AOUpUlGyF/IsOZ3znhNTobGP8wshl2cfDmwrxbu/4EQou0J2fxrg1b9p
        JQ55A5eoCQcEx2uShUo+L4AB7AjA
X-Google-Smtp-Source: AAOMgpdhHZ/hECPgAy8zokKzShbpIF4uAaWj1aYnA0Fb+Y5f/6j9KGE/63L3GXWdF7wawtx5jsnquA==
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr18983443pfi.174.1532977660585;
        Mon, 30 Jul 2018 12:07:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s3-v6sm24899877pgj.84.2018.07.30.12.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:07:40 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:07:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] subtree test: simplify preparation of expected results
Message-ID: <20180730190738.GD156463@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
 <20180730190612.GB156463@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730190612.GB156463@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This mixture of quoting, pipes, and here-docs to produce expected
results in shell variables is difficult to follow.  Simplify by using
simpler constructs that write output to files instead.

Noticed because without this patch, t/chainlint is not able to
understand the script in order to validate that its subshells use an
unbroken &&-chain, causing "make -C contrib/subtree test" to fail with

	error: bug in the test script: broken &&-chain or run-away HERE-DOC:

in t7900.21.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's the end of the series.  Thanks for reading.

Thanks,
Jonathan

 contrib/subtree/t/t7900-subtree.sh | 119 ++++++++---------------------
 1 file changed, 30 insertions(+), 89 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index e6a28f2c3e..57ff4b25c1 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -540,26 +540,10 @@ test_expect_success 'make sure exactly the right set of files ends up in the sub
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD &&
 
-		chks="sub1
-sub2
-sub3
-sub4" &&
-		chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chks
-TXT
-) &&
-		chkms="main-sub1
-main-sub2
-main-sub3
-main-sub4" &&
-		chkms_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chkms
-TXT
-) &&
-
-		subfiles=$(git ls-files) &&
-		check_equal "$subfiles" "$chkms
-$chks"
+		test_write_lines main-sub1 main-sub2 main-sub3 main-sub4 \
+			sub1 sub2 sub3 sub4 >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -606,25 +590,11 @@ test_expect_success 'make sure the subproj *only* contains commits that affect t
 		git fetch .. subproj-br &&
 		git merge FETCH_HEAD &&
 
-		chks="sub1
-sub2
-sub3
-sub4" &&
-		chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chks
-TXT
-) &&
-		chkms="main-sub1
-main-sub2
-main-sub3
-main-sub4" &&
-		chkms_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chkms
-TXT
-) &&
-		allchanges=$(git log --name-only --pretty=format:"" | sort | sed "/^$/d") &&
-		check_equal "$allchanges" "$chkms
-$chks"
+		test_write_lines main-sub1 main-sub2 main-sub3 main-sub4 \
+			sub1 sub2 sub3 sub4 >expect &&
+		git log --name-only --pretty=format:"" >log &&
+		sort <log | sed "/^\$/ d" >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -675,29 +645,16 @@ test_expect_success 'make sure exactly the right set of files ends up in the mai
 		cd "$subtree_test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" master &&
 
-		chkm="main1
-main2" &&
-		chks="sub1
-sub2
-sub3
-sub4" &&
-		chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chks
-TXT
-) &&
-		chkms="main-sub1
-main-sub2
-main-sub3
-main-sub4" &&
-		chkms_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chkms
-TXT
-) &&
-		mainfiles=$(git ls-files) &&
-		check_equal "$mainfiles" "$chkm
-$chkms_sub
-$chks_sub"
-)
+		test_write_lines main1 main2 >chkm &&
+		test_write_lines main-sub1 main-sub2 main-sub3 main-sub4 >chkms &&
+		sed "s,^,sub dir/," chkms >chkms_sub &&
+		test_write_lines sub1 sub2 sub3 sub4 >chks &&
+		sed "s,^,sub dir/," chks >chks_sub &&
+
+		cat chkm chkms_sub chks_sub >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
 '
 
 next_test
@@ -748,37 +705,21 @@ test_expect_success 'make sure each filename changed exactly once in the entire
 		cd "$subtree_test_count" &&
 		git subtree pull --prefix="sub dir" ./"sub proj" master &&
 
-		chkm="main1
-main2" &&
-		chks="sub1
-sub2
-sub3
-sub4" &&
-		chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chks
-TXT
-) &&
-		chkms="main-sub1
-main-sub2
-main-sub3
-main-sub4" &&
-		chkms_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
-$chkms
-TXT
-) &&
+		test_write_lines main1 main2 >chkm &&
+		test_write_lines sub1 sub2 sub3 sub4 >chks &&
+		test_write_lines main-sub1 main-sub2 main-sub3 main-sub4 >chkms &&
+		sed "s,^,sub dir/," chkms >chkms_sub &&
 
 		# main-sub?? and /"sub dir"/main-sub?? both change, because those are the
 		# changes that were split into their own history.  And "sub dir"/sub?? never
 		# change, since they were *only* changed in the subtree branch.
-		allchanges=$(git log --name-only --pretty=format:"" | sort | sed "/^$/d") &&
-		expected=''"$(cat <<TXT | sort
-$chkms
-$chkm
-$chks
-$chkms_sub
-TXT
-)"'' &&
-		check_equal "$allchanges" "$expected"
+		git log --name-only --pretty=format:"" >log &&
+		sort <log >sorted-log &&
+		sed "/^$/ d" sorted-log >actual &&
+
+		cat chkms chkm chks chkms_sub >expect-unsorted &&
+		sort expect-unsorted >expect &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.18.0.345.g5c9ce644c3

