Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C101F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeGLS7g (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:59:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36797 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeGLS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:59:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so22723651wro.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yfHHtxoQi2uRBYlHkyMMAu7vvdkt0neLcl2KCew9dgI=;
        b=DfZPEqNsbgIkzhecRmbfVTtXhu19A+tcZxGLWGhK1TtlLThBMrfMP/r60olBDfujsU
         oj5ZIS/81KERxTOWXLCs4yszmjbG5MhAPiuwYbUMXcT2GgmxGCEqhAk660QwQDJOGf3/
         8/WQySKCU0hNwaCW6B/sWxGyy73QKVlET5uA9LM2oKlgRxzFt+qm4ZoqmkBgWRBJmGrF
         LdxQ2e039lmR9r1uqGZju80zCQRC12S6vp0eQt5q/3mesh/arnlLWEIFsI16DQgIZMDL
         rcBr3aMa1/SPymOmRbHx0hAh+q/2VK383WIGZNAww8Ks0vY0Q651wWmdABbyXzDYdCE8
         geTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yfHHtxoQi2uRBYlHkyMMAu7vvdkt0neLcl2KCew9dgI=;
        b=CE0hdZuoKNhsQIMUO7dFbqzJ99gxsAlkel4fcxfB0HpBXwqyctPj5cSJt+p9u+2uEd
         KDfBbWrq7z+NP09HKpzkv7BpNIrkPQvCtt3qdoahY3JgbX6wYFA1X2/HWghwhiHip6BN
         /AD3FX3ixzDA7fHT0c+ntrbkqaM1NL83vq61Gg9095jCB7dtdp2DbYXwc6SwKn/HBIPF
         PVUgnw6tsH0/uamrYcE3PIoPd14FcUBL9T+9+nsvfbKlsplUVKbOEx2H2DIwytLXqm2X
         I9+FjVuqFEHShF/v4/QsXM5bSl5hpql37byBv1gLOZtxiOClfxUt4z/Z3Od0BdmE74Eb
         LCCw==
X-Gm-Message-State: AOUpUlH9MZ1ddezbrH32VWlnwIkY4z+RNxOjF4TA6qUFOoj6IpGPROwF
        B0Ht1M4UkhIct59/iY5ASuU=
X-Google-Smtp-Source: AAOMgpc5GCLqJojWyseyPBbJgcyBD9/ETeU2K1eJWFYhs8DwKOUAjp6dpC+9xdXwRjUvy2UpAWuIww==
X-Received: by 2002:adf:9996:: with SMTP id y22-v6mr2748176wrb.69.1531421326778;
        Thu, 12 Jul 2018 11:48:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm19588733wrn.75.2018.07.12.11.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:48:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t6036: fix broken && chain in sub-shell
References: <c9201ced-34a8-98f4-2da6-9c36c408b501@ramsayjones.plus.com>
Date:   Thu, 12 Jul 2018 11:48:45 -0700
In-Reply-To: <c9201ced-34a8-98f4-2da6-9c36c408b501@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 12 Jul 2018 16:32:25 +0100")
Message-ID: <xmqq4lh4xpbm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> I had a test failure on 'pu' today - Eric's chain-lint series
> found another broken chain in one of Elijah's new tests (on the
> 'en/t6036-recursive-corner-cases' branch).

Thanks, I see the same breakage in my build, too.

>
> ATB,
> Ramsay Jones
>
>  t/t6036-recursive-corner-cases.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index 2a44acace..59e52c5a0 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -495,7 +495,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
>  		test_write_lines 1 2 3 4 5 6 7 8 >a &&
>  		git add a &&
>  		git commit -m E3 &&
> -		git tag E3
> +		git tag E3 &&
>  
>  		git checkout C^0 &&
>  		test_must_fail git merge B^0 &&
