Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB497C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiHRPaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbiHRPaP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:30:15 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FE8993E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:30:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11c9af8dd3eso1800486fac.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CUdTUTcGiPJf4v/L0OvBNm4+TXCpwmQRVljxriVQ8oE=;
        b=ZUytcP9kXR5rjk0xl03PCJdjXoAj1NrDlB2YlfanCErlJvh6nyPnmH0GooAvz9y+Df
         vA6+S62+5BWN9nY57/P8So+2sAyq5DPZq3IENksCi967dXAXl4/BV2yxZ4NlV9SHR3o/
         f3AMUzSH05YNH/t1q31QaQ7jIFeXJDPtAGn2pr3Dj7E936BqKYgIvApXFz37mOWDHARx
         NEbQutBCPuBCs/HfYpziX7PPXa0l0QtvK+ZiXeTB0+3i4muBv+LTswn0afyVTrPF9TKd
         8hK3IbRxYVV6tZXFbOhQJAwRSDGWBRxd67TTIgvwyhYpdoxWjZBUxJsYGkhtJ61YQC+m
         iEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CUdTUTcGiPJf4v/L0OvBNm4+TXCpwmQRVljxriVQ8oE=;
        b=XFR8qRwRHd0306gB2jXZ+fNjBGW0l4z583RdOhpInElimoKGBmiUWeuI5Zr9Z126YW
         3r++jka1TValxHjeakr/zgETb2oZUlH/hw5zHRLMjUOqPZcP2YBxNz/yAZ1tXaPUtV04
         aNzFpVUGEDURfa+uHqtZ+eEUGGiouN6Lv+YU4tzD1iRGt9FG8diMr8XWgze1xMMuyucy
         Twk6iYY51XYEdK5K/ZvXl9DZz0DrasEHCpdnLIf7QAYFW/gLX28hyPu8dxPgRyW2EsW0
         EHk/V8QrZzfng+tROiuJBfa5+7Iedv3BAgvcGDop0MVz0RSMwVKgn1iGuCavPq7NAgUt
         plww==
X-Gm-Message-State: ACgBeo2GWhfWwmu5Wk75OKMiLfy7qMVOf7hDtlNzDlc9+4ElPWMrcRBx
        dcswnGjZLC/iEZPQmbgaXsNCOARWOrmy
X-Google-Smtp-Source: AA6agR4RTaxa7CmSHbsLVMb1Cgxve7BZaZROR1AseH9UmuKkiDTm3gToyQOygaxZC9ky1hkW4qNptg==
X-Received: by 2002:a05:6870:a708:b0:10f:a91:5990 with SMTP id g8-20020a056870a70800b0010f0a915990mr1658153oam.147.1660836613535;
        Thu, 18 Aug 2022 08:30:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id k38-20020a4a94a9000000b004354a4412edsm360583ooi.29.2022.08.18.08.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:30:13 -0700 (PDT)
Message-ID: <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
Date:   Thu, 18 Aug 2022 11:30:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an
 argument
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 2:17 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

Code looks good!

> diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
> index af57a04b7ff..d3657737fa6 100755
> --- a/t/t6019-rev-list-ancestry-path.sh
> +++ b/t/t6019-rev-list-ancestry-path.sh
> @@ -8,8 +8,13 @@ test_description='--ancestry-path'
>  #   /                     \
>  #  A-------K---------------L--M
>  #
> -#  D..M                 == E F G H I J K L M
> -#  --ancestry-path D..M == E F H I J L M
> +#  D..M                                     == E F G H I J K L M
> +#  --ancestry-path                     D..M == E F   H I J   L M
> +#  --ancestry-path=F                   D..M == E F       J   L M
> +#  --ancestry-path=G                   D..M ==     G H I J   L M
> +#  --ancestry-path=H                   D..M == E   G H I J   L M
> +#  --ancestry-path=K                   D..M ==             K L M
> +#  --ancestry-path=K --ancestry-path=F D..M == E F       J K L M

These are good examples, because they help clarify what I had initially
been confused about: you include things in _both_ directions. In
particular, "--ancestry-path=K --ancestry-path=f D..M" you are kind of
taking the union of the following queries:

	--ancestry-path D..K
	--ancestry-path K..M
	--ancestry-path D..F
	--ancestry-path F..M

I did check just in case, but specifying multiple ranges such as

	--ancestry-path D..K K..M

does not do what is expected.

> +test_expect_success 'rev-list --ancestry-path=F D..M' '
> +	test_write_lines E F J L M >expect &&
> +	git rev-list --ancestry-path=F --format=%s D..M |
> +	sed -e "/^commit /d" |
> +	sort >actual &&
> +	test_cmp expect actual
> +'

These tests follow the patterns from other tests in this file, but
it also has bad patterns. Specifically, the 'git rev-list' command
is fed directly into a pipe. I include a patch below that applies
directly on this one to rewrite these tests. If you want, you could
rebase to have that test refactor happen before you add your new
--ancestry-path=<X> option tests.

> +test_expect_success 'rev-list --ancestry-path=G D..M' '
> +	test_write_lines G H I J L M >expect &&
> +	git rev-list --ancestry-path=G --format=%s D..M |
> +	sed -e "/^commit /d" |
> +	sort >actual &&
> +	test_cmp expect actual
> +'
> +test_expect_success 'rev-list --ancestry-path=H D..M' '

nit: needs extra whitespace between tests. The above test pair
needs one, too. This becomes moot with the patch I provide.

Thanks,
-Stolee

--- >8 ---

From 9ac4e81dba0d7801513a09f5fe307d01357123dd Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Thu, 18 Aug 2022 11:25:04 -0400
Subject: [PATCH] t6019: modernize tests with helper

The tests in t6019 are repetive, so create a helper that greatly
simplifies the test script.

In addition, update the common pattern that places 'git rev-list' on the
left side of a pipe, which can hide some exit codes. Send the output to
a 'raw' file that is then consumed by other tools so the Git exit code
is verified as zero.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t6019-rev-list-ancestry-path.sh | 131 +++++++-----------------------
 1 file changed, 31 insertions(+), 100 deletions(-)

diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index d3657737fa60..18941a80ce67 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -55,111 +55,42 @@ test_expect_success setup '
 	test_commit M
 '
 
-test_expect_success 'rev-list D..M' '
-	test_write_lines E F G H I J K L M >expect &&
-	git rev-list --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path D..M' '
-	test_write_lines E F H I J L M >expect &&
-	git rev-list --ancestry-path --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path=F D..M' '
-	test_write_lines E F J L M >expect &&
-	git rev-list --ancestry-path=F --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-test_expect_success 'rev-list --ancestry-path=G D..M' '
-	test_write_lines G H I J L M >expect &&
-	git rev-list --ancestry-path=G --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-test_expect_success 'rev-list --ancestry-path=H D..M' '
-	test_write_lines E G H I J L M >expect &&
-	git rev-list --ancestry-path=H --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path=K D..M' '
-	test_write_lines K L M >expect &&
-	git rev-list --ancestry-path=K --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path=F --ancestry-path=K D..M' '
-	test_write_lines E F J K L M >expect &&
-	git rev-list --ancestry-path=F --ancestry-path=K --format=%s D..M |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list D..M -- M.t' '
-	echo M >expect &&
-	git rev-list --format=%s D..M -- M.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
-	echo M >expect &&
-	git rev-list --ancestry-path --format=%s D..M -- M.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
+test_ancestry () {
+	args=$1
+	expected=$2
+	test_expect_success "rev-list $args" "
+		test_write_lines $expected >expect &&
+		git rev-list --format=%s $args >raw &&
+
+		if test -n \"$expected\"
+		then
+			sed -e \"/^commit /d\" raw | sort >actual &&
+			test_cmp expect actual || return 1
+		else
+			test_must_be_empty raw
+		fi
+	"
+}
 
-test_expect_success 'rev-list F...I' '
-	test_write_lines F G H I >expect &&
-	git rev-list --format=%s F...I |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "D..M" "E F G H I J K L M"
 
-test_expect_success 'rev-list --ancestry-path F...I' '
-	test_write_lines F H I >expect &&
-	git rev-list --ancestry-path --format=%s F...I |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "--ancestry-path D..M" "E F H I J L M"
+test_ancestry "--ancestry-path D..M" "E F H I J L M"
+test_ancestry "--ancestry-path=F D..M" "E F J L M"
+test_ancestry "--ancestry-path=G D..M" "G H I J L M"
+test_ancestry "--ancestry-path=H D..M" "E G H I J L M"
+test_ancestry "--ancestry-path=K D..M" "K L M"
+test_ancestry "--ancestry-path=K --ancestry-path=F D..M" "E F J K L M"
 
-# G.t is dropped in an "-s ours" merge
-test_expect_success 'rev-list G..M -- G.t' '
-	git rev-list --format=%s G..M -- G.t |
-	sed -e "/^commit /d" >actual &&
-	test_must_be_empty actual
-'
+test_ancestry "D..M -- M.t" "M"
+test_ancestry "--ancestry-path D..M -- M.t" "M"
 
-test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
-	echo L >expect &&
-	git rev-list --ancestry-path --format=%s G..M -- G.t |
-	sed -e "/^commit /d" >actual &&
-	test_cmp expect actual
-'
+test_ancestry "F...I" "F G H I"
+test_ancestry "--ancestry-path F...I" "F H I"
 
-test_expect_success 'rev-list --ancestry-path --simplify-merges G^..M -- G.t' '
-	test_write_lines G L >expect &&
-	git rev-list --ancestry-path --simplify-merges --format=%s G^..M -- G.t |
-	sed -e "/^commit /d" |
-	sort >actual &&
-	test_cmp expect actual
-'
+test_ancestry "G..M -- G.t" ""
+test_ancestry "--ancestry-path G..M -- G.t" "L"
+test_ancestry "--ancestry-path --simplify-merges G^..M -- G.t" "G L"
 
 #   b---bc
 #  / \ /
-- 
2.37.1.vfs.0.0.rebase




