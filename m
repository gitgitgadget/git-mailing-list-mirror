Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C9F1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGWWw0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:52:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34979 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbeGWWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:52:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so552856wmc.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mpQd7LAxRa1ONQUNAqTBh0hgsTVouIfrA1uyitmTNC0=;
        b=ZL9eMuduzyw2l13unhnRT1fgB6i4uIoVg4EkUjhFjVIV+ytKuCpPznugkjzGbMOOve
         UBQCcHq9KhW/b2O85CjWqcRn1iBLvm6jN9oNx/H0agWLgUsSbFhSDLziK2Vc18+JKnbg
         x2lZBLka/suSewZqnIIln5BSsGNrDX5jcuZ0tOpQRyNEhUMDZ/zMuMTUwSHZpYzgXTfF
         SciTpYR7yQ6mpCdoER1GqoquZhLKH3vT/66/uGj0Ozfx5irQmTOrviuD9/SA0CdeGDCd
         gVUrHJVlWxHTpIdQzlAG1vSyWDryzxl7xX+QujzdzQ1XXjsNv/C4zIGaT9Yx2SFq/41x
         RTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mpQd7LAxRa1ONQUNAqTBh0hgsTVouIfrA1uyitmTNC0=;
        b=c6OdS287pXkPB3SMWUs2eGynN9f/Vfoudj1JH458v2kESdDz80gp3+caqsrcdiHKfG
         QA75zq/vQ8RmIHpunv+KPG/CpEBUfZ2qF6A5zD5M2zsPF13s0PmMYPzc2fK599zuzcvt
         J1bY7zC7jBzT/xlcwfxH/Hwppi4w+7ZcsuLeZqYakw9krni7GPSmMg1zyMBzzqSAZlZ/
         RcHCmu3TKCRwY0IWbrFgAc6Duv6gDyoAQvivPdaFNpomEKHjl+eeHm5/pTxWb5pKEB2A
         RzGhwmMHsm5rHLk/v6UIxJn/1W+iCrG6FCM86bH/WnwmgCdTysJ9TtET+JEsYd9+jjLR
         9ovQ==
X-Gm-Message-State: AOUpUlEV0k/J3ahTTPLX6Um6L1xliItW9Pz8QbdlLAoUnkjXrHqK8RcR
        WNAH4bk6HElwszmsVJbNeG8=
X-Google-Smtp-Source: AAOMgpfIhDulU9VSEm/Ywyod9iaw4VkNTrAn8UWdiEJNUnNvdhtxHkPNGFstt58oD7pbH49N8LCj1A==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr412312wmf.114.1532382553509;
        Mon, 23 Jul 2018 14:49:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h14-v6sm7321701wro.15.2018.07.23.14.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:49:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
Date:   Mon, 23 Jul 2018 14:49:12 -0700
In-Reply-To: <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 23 Jul 2018 14:03:38 -0700")
Message-ID: <xmqq36w94o87.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sat, Jul 21, 2018 at 3:04 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
>> Side note: I work on implementing range-diff not only to make life easier for reviewers who have to suffer through v2, v3, ... of my patch series, but also to verify my changes before submitting a new iteration. And also, maybe even more importantly, I plan to use it to verify my merging-rebases of Git for
>> Windows (for which I previously used to redirect the pre-rebase/post-rebase diffs vs upstream and then compare them using `git diff --no-index`). And of course any interested person can see what changes were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by running a command like:
>
> Thanks for making tools that makes the life of a Git developer easier!
> (Just filed https://github.com/gitgitgadget/gitgitgadget/issues/26
> which asks to break lines for this cover letter)

Thanks.  These cover letters are unreadable without W Q
(gnus-article-fill-long-lines)
