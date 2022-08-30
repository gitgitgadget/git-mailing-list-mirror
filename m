Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E45ECAAD3
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 02:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH3CxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 22:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiH3CxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 22:53:12 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDE9F8D8
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:53:11 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y15so4475768qvn.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uB1W6Dd8lyZRXvRZjCFLoqN6nLBJECpzWEKa+O3Znv4=;
        b=KKciiLG5NmfILC46wzBmlePqD3J9vHEIoRn9mmgcciEd5yL3eZa4C1gPDHYGNdV5S/
         4VbUjH9dkfxoxseNmc6qdALQwAhn8u/ZyNS5YUEZcsHaFiGocEZbO1+KfIQXvS0MomE7
         Y5PmVuK4QeaUC+xs0qFcBwIhWc/4L0kFjLlzCv06Y2gfn+BdSK+HiFJf6AQNMWeoC+R3
         NIXjJaVMfJ4L2bfNU0jrfEqZM3yCj4M66uVee5uv6UbTdFFDcC7E/69iWr9Z+wv7jAAO
         +zbxImM5J0dvMFxhyMLNYhSP6DaYGJiaJPoZfAg19Lj/tysglHunJe7sv1ecRuW5GrRk
         AQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uB1W6Dd8lyZRXvRZjCFLoqN6nLBJECpzWEKa+O3Znv4=;
        b=OWUd58R33goBcqlkv1/VZIsl6M4jnOix2S2d5F3/FNYltlrZIM7sGGepDBV3674rjk
         xDM4Vf1BD39pFp8w9uAyFIsLqGC0SqsazBkzpXgYXKYHwJrVrgy3a3PR/IUlmnh4NX6+
         qgqnpVw0Op+b2ysAR49el5EgUb8xxwFE997F6vJcHUvjnGX9dpF8AJ7MakPZS0MoKoSt
         /+Vya3L77gj/f8G1g+CBxqtNrR8886gN//+JtmewuM2vZ4t94HALnOx1gt6vIS8WWca6
         oJkZEMlsaIw1d1vL5J0x6rDwTYdG1oy7NzQOpvJgzGspylLCQMmJ39U24l601v0NrE1j
         Qc+w==
X-Gm-Message-State: ACgBeo2S55e/9X7Kv/Rew/2opRWU9wtu1FRjxy9txvUUVJwlw0Mv7z4b
        +ekqw7mjkJIyWd1rOKeemvfi14QHE5COn/xk13Q=
X-Google-Smtp-Source: AA6agR4ItnINHsPBykbQVx0AXwpv1kDtnSdn3e9F98s9/l6ffI5hIDc4WF13GSteJlTFd4RAUqB5VlhgEUjmCvIfY0w=
X-Received: by 2002:ad4:5cea:0:b0:497:c55:edb3 with SMTP id
 iv10-20020ad45cea000000b004970c55edb3mr13154947qvb.99.1661827990152; Mon, 29
 Aug 2022 19:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
In-Reply-To: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Aug 2022 19:52:59 -0700
Message-ID: <CABPp-BGBEfFh0z0YHGcHE+rva9JdapXprPn-RSmif0xn6fcxYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 10:18 PM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series fixes a failing test in t4301 due to 'sed' behavioral
> differences between implementations. It also fixes a couple broken &&-chains
> and adds missing explicit loop termination.
>
> The third patch is entirely subjective and can be dropped if unwanted. I
> spent more than a few minutes puzzling over the script's use of 'printf
> "\\n"' rather than the more typical 'printf "\n"' or even a simple 'echo',
> wondering if there was some subtlety I was missing or whether Elijah had
> encountered an unusual situation in which '\\n' was needed over '\n'. The
> third patch chooses to replace 'printf "\\n"' with 'echo' which I find more
> idiomatic, but I can see value in using 'printf "\n"' as perhaps being
> clearer that it is adding a newline where one is missing.

I can't actually provide the reasoning for it; I took Dscho's testcase
from [1] and used it as a basis for adding several other testcases.
When I was copying & pasting and adjusting, I just didn't notice the
'printf "\\n"'.  But using a simple echo makes sense.

[1] https://lore.kernel.org/git/3b4ed8bb1bb615277ee51a7b2af5fc53bae0a6e4.1660892256.git.gitgitgadget@gmail.com/

Anyway, I've read through the patches and your series looks good to me.
