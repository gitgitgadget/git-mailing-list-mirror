Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB2C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 02:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLBCCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 21:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLBCCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 21:02:18 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2DA7F8B6
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 18:02:17 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so3604255pfz.6
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 18:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSow6SDTrxe1QbRxRWkwpR8P1+E/U059vBKdIKLeDDA=;
        b=ScZ/HRC/JAKJWDQG5bAeomGMIWvMCL5dzBl/bp3BfyIkHpxdHCD9ZG6aC9+DTNfvWU
         MK2OSyPTDIRywKV8WfgefsBupF3prM6kcTtCUAIs1YpLtpE00IyOxUdrFLlgKkHf080O
         EsZnj+LJ53o7XlvtXgD02YNvSRWJ1ewQd7JwzOG5VVIjUTN0/ZEoJ5lKqOoaceIXOCIM
         1KYBtMOHYMJdvnHsUsMAFX6uYc4uILHOZSnzs5CquudUAzxnG7lFzY2do6BqZBDZVRt+
         o2S72bYKDI8i6S976xaQnZvrqS8nZ/647Kmwez5M6zyv4Q6v4p5yw6ZpCnONmdESaAde
         2Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSow6SDTrxe1QbRxRWkwpR8P1+E/U059vBKdIKLeDDA=;
        b=LwEqUBea9b9VV5kqzzB3hfg+LvzeEpPZckdxXIp36KL0zhPwd7qy678ds40oiP6bwj
         cc3cq3CWCV88Fbft5ksLBF7pLLz0Ydb2mGlQns0K6KmcR0uAyc49nBN7OfmOnqmmPDe5
         ycCiQ6V4Uvqng3CXHRJi5Tupns1E1heQwTM+puMpfmrBtDjwJuDLIW7EAK8zFFhLs8Ek
         WW3yTXWJM80GfaT06msmdM+EqiVpPFbe870mE8BIR58ATwBbzwh8MC1Atx1YyF8Y1iWI
         mOLo3Ih1fnzmUHOncHAqf6VcfNB7HnIVOyMNwRA80eqfXM+JGVUB6wM24wVUIfSp7QNH
         H48g==
X-Gm-Message-State: ANoB5pkuyPPHa+WGiUdqy/qEZ5qz9GAzFkbenLtqciWU5tGcchqm2xLm
        HAYdUTFg75iTktPHzp66NhA=
X-Google-Smtp-Source: AA0mqf7o7VketdsVVN3KmcJokBPOrSGeIbp189QeixfypMkijKyYU3GqA7i+cgSaBPCx9WyMht7rFA==
X-Received: by 2002:a63:2361:0:b0:477:b603:f683 with SMTP id u33-20020a632361000000b00477b603f683mr40641783pgm.93.1669946536982;
        Thu, 01 Dec 2022 18:02:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b001894881842dsm4307016plt.151.2022.12.01.18.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 18:02:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/8] diff tests: fix ignored exit codes in t4023
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <patch-v2-3.8-c5feef1c808-20221202T000227Z-avarab@gmail.com>
Date:   Fri, 02 Dec 2022 11:02:15 +0900
In-Reply-To: <patch-v2-3.8-c5feef1c808-20221202T000227Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Dec
 2022 01:06:29
        +0100")
Message-ID: <xmqqsfhypnq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change a "git diff-tree" command to be &&-chained so that we won't
> ignore its exit code, see the ea05fd5fbf7 (Merge branch
> 'ab/keep-git-exit-codes-in-tests', 2022-03-16) topic for prior art.
>
> This fixes code added in b45563a229f (rename: Break filepairs with
> different types., 2007-11-30). Due to hiding the exit code we hid a
> memory leak under SANITIZE=leak.

Thanks.

The changes all make sense and obviously correct.  The ancient style
to have a blank line before the first statement in the test body is
also gone, which is a good thing.


> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4023-diff-rename-typechange.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
> index 7cb99092938..25c31b0cb1b 100755
> --- a/t/t4023-diff-rename-typechange.sh
> +++ b/t/t4023-diff-rename-typechange.sh
> @@ -52,8 +52,8 @@ test_expect_success setup '
>  '
>  
>  test_expect_success 'cross renames to be detected for regular files' '
> -
> -	git diff-tree five six -r --name-status -B -M | sort >actual &&
> +	git diff-tree five six -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		echo "R100	foo	bar" &&
>  		echo "R100	bar	foo"
> @@ -63,8 +63,8 @@ test_expect_success 'cross renames to be detected for regular files' '
>  '
>  
>  test_expect_success 'cross renames to be detected for typechange' '
> -
> -	git diff-tree one two -r --name-status -B -M | sort >actual &&
> +	git diff-tree one two -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		echo "R100	foo	bar" &&
>  		echo "R100	bar	foo"
> @@ -74,8 +74,8 @@ test_expect_success 'cross renames to be detected for typechange' '
>  '
>  
>  test_expect_success 'moves and renames' '
> -
> -	git diff-tree three four -r --name-status -B -M | sort >actual &&
> +	git diff-tree three four -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		# see -B -M (#6) in t4008
>  		echo "C100	foo	bar" &&
