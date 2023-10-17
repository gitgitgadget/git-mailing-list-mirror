Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BE430E2
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD2frsXM"
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE2269E
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:02:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41b7ec4cceeso8169831cf.1
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697572972; x=1698177772;
        h=content-transfer-encoding:list-id:precedence:mime-version:fcc
         :dkim-signature:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLJOFOrTx5pgyS1H4fi8lWtDPoJEmc98h22ZeEbqo6Y=;
        b=C48p3oecChjSRMKllDyLr0Z9ZVDioHbniP7jaUyI6V6xxVeHZUKHvm4bvNxBi0pieT
         muM2Wb/AdmI2l88b5Rzs4ZbQYgFjhbB81iInsHF2G5rb8Kys6d6lxm7nn29oDxH6BfFw
         NP4XgbDHBaiTmEUNTqgRaoZvm7tDjuuWTz4wGB3tjj55sXWKO2K5NtcLi3Cuuo5MYGdx
         keUhG7l5JeV+7O7FT2WnXyGGwuDf3Ami8QNn/XdnLvnWhZJ8t6vNnwz0BFIfxaOQ/W/c
         CUYvLzHLflUQ1ITU5GfSiBv4AAuj6pOcfRYSiPzehQOtIgafRgYW3zxDP1BYFc4Z6nPx
         Esdg==
X-Gm-Message-State: AOJu0YyCkFZD9vEl2Vp9nFcrYv1zfc3IHOT7ATaRAwRMIfmvw5rUI58k
	VPjzUqlO/ALiWE4TGNR6oH31rw==
X-Google-Smtp-Source: AGHT+IEuLEOeyR1RRu539jQk9ORypisqNer7bYzcEotd5lWGnkYKK2MFPdKM4RbdfYmDX8C+avOPww==
X-Received: by 2002:a05:622a:1920:b0:418:79a:e350 with SMTP id w32-20020a05622a192000b00418079ae350mr4423827qtc.23.1697572972127;
        Tue, 17 Oct 2023 13:02:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-98-180-245.cinci.res.rr.com. [174.98.180.245])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05622a610800b00419732075b4sm857104qtb.84.2023.10.17.13.02.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Oct 2023 13:02:51 -0700 (PDT)
From: Zach FettersMoore <zach.fetters@apollographql.com>
X-Google-Original-From: Zach FettersMoore <4425109+BobaFetters@users.noreply.github.com>
To: gitgitgadget@gmail.com,
	git@vger.kernel.org
Cc: zach.fetters@apollographql.com
Subject: [PATCH v3 3/3] subtree: adding test to validate fix
Date: Tue, 17 Oct 2023 16:02:39 -0400
Message-ID: <eff8bfcc04278eeae658ffbff8317f822edb9b20.1696019580.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
References: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com> <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18]) by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E8E71D33 for <git@archiver.kernel.org>; Fri, 29 Sep 2023 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id S233490AbjI2UdO (ORCPT <rfc822;git@archiver.kernel.org>); Fri, 29 Sep 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S232985AbjI2UdM (ORCPT <rfc822;git@vger.kernel.org>); Fri, 29 Sep 2023 16:33:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b]) by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67A1B0 for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406609df1a6so7938375e9.3 for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1696019584; x=1696624384; darn=vger.kernel.org; h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from :references:in-reply-to:message-id:from:to:cc:subject:date :message-id:reply-to; bh=fdC+bsPVckJYi/Zh4cZeAa88NrJBCRi7MTAopCnpxcc=; b=cD2frsXM1vK7x0cqewkZI6yMEEDKz/PfgK8a4eHHlBaYkgCkUl21an9Eolse8xcj+x Q/e0J/LRsyARbfy74JpDC1mAx8Ca4Vjtfsi1/3hmRJB35NfB8Ds47/Ptv4Rf3qA75X3a dIViEQrIGu4Zab4Rlcfgp4tKJ+u72VsOSh4aY0A/yuT0JV6+gWI5b40Lu79mTOnpSowY 2o1BI4TomSjMDI8LRZcvp43WcOs9gROMsJDd9ga4cI4jW6Mg2PDBebw8zmqtmUNTwewx 40nPaqdvCR4Z6OtdUun6lJXL2D54EvqnL9K+BmLusaF00DwP9dHySOT8rq//cKGSZFo4 t/dA==
X-Received: by 2002:a7b:c397:0:b0:3fe:3004:1ffd with SMTP id s23-20020a7bc397000000b003fe30041ffdmr4700571wmj.4.1696019583799; Fri, 29 Sep 2023 13:33:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28]) by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b003fe23b10fdfsm2124219wme.36.2023.09.29.13.33.03 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Fri, 29 Sep 2023 13:33:03 -0700 (PDT)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-ID: <20231017200239.tm27dXOvxfNtNghXqzyYoIZJO1UYFFmI8hM06LoTGrg@z>

From: "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>

> From: Zach FettersMoore <zach.fetters@apollographql.com>
> 
> Adding a test to validate that the proposed fix
> solves the issue.
> 
> The test accomplishes this by checking the output
> of the split command to ensure the output from
> the progress of 'process_split_commit' function
> that represents the 'extracount' of commits
> processed does not increment.
> 
> This was tested against the original functionality
> to show the test failed, and then with this fix
> to show the test passes.
> 
> This illustrated that when using multiple subtrees,
> A and B, when doing a split on subtree B, the
> processing does not traverse the entire history
> of subtree A which is unnecessary and would cause
> the 'extracount' of processed commits to climb
> based on the number of commits in the history of
> subtree A.
> 
> Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 41 ++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 49a21dd7c9c..57c12e9f924 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -385,6 +385,47 @@ test_expect_success 'split sub dir/ with --rejoin' '
>  	)
>  '
>  
> +test_expect_success 'split with multiple subtrees' '
> +	subtree_test_create_repo "$test_count" &&
> +	subtree_test_create_repo "$test_count/subA" &&
> +	subtree_test_create_repo "$test_count/subB" &&
> +	test_create_commit "$test_count" main1 &&
> +	test_create_commit "$test_count/subA" subA1 &&
> +	test_create_commit "$test_count/subA" subA2 &&
> +	test_create_commit "$test_count/subA" subA3 &&
> +	test_create_commit "$test_count/subB" subB1 &&
> +	(
> +		cd "$test_count" &&
> +		git fetch ./subA HEAD &&
> +		git subtree add --prefix=subADir FETCH_HEAD
> +	) &&
> +	(
> +		cd "$test_count" &&
> +		git fetch ./subB HEAD &&
> +		git subtree add --prefix=subBDir FETCH_HEAD
> +	) &&
> +	test_create_commit "$test_count" subADir/main-subA1 &&
> +	test_create_commit "$test_count" subBDir/main-subB1 &&
> +	(
> +		cd "$test_count" &&
> +		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 1"
> +	) &&
> +	(
> +		cd "$test_count" &&
> +		git subtree split --prefix=subBDir --squash --rejoin -m "Sub B Split 1"
> +	) &&
> +	test_create_commit "$test_count" subADir/main-subA2 &&
> +	test_create_commit "$test_count" subBDir/main-subB2 &&
> +	(
> +		cd "$test_count" &&
> +		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 2"
> +	) &&
> +	(
> +		cd "$test_count" &&
> +		test "$(git subtree split --prefix=subBDir --squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
> +	)
> +'
> +
>  test_expect_success 'split sub dir/ with --rejoin from scratch' '
>  	subtree_test_create_repo "$test_count" &&
>  	test_create_commit "$test_count" main1 &&
> --

Checking to see if there is something else I need to do with this
to get it across the finish line, wasn't sure if something else
was needed since it's been dormant since my last push a few 
weeks ago.

Thanks
