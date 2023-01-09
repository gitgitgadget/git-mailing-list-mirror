Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C3FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjAITxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbjAITx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 14:53:27 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B028FE2
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 11:53:25 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id k19so6991926pfg.11
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 11:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ngXSCMMBGCj9syIs7pOITH31w0W1KsUeoR/+Hp1+IU=;
        b=eKQ0kjpcXg2lOvBgi625CkycGTohyiW+B/6wqe9tBikBqIeRK9AaGNOaLs0BO1MBnG
         h0Axi1ISX9YPNxYoAgzAQ5cjZorXMupHEgbUH8Ct2S76EATE0gWk++ggL6LIBADgUgRj
         C4UFPq7SVnSpKyp0xHFmJ0vuv74rGyeLvWUZ8spLuHMzxiawL7E6EhtbC+JISZSfMZJI
         7MzC+ZcNF7DHhJWjENG/smeXTOfOYR+DUfQ9AbiIbR3gqS5JKUK71AZJG3XTY7qted3M
         vVjmpSYc1DSpwdXDyysFSdn6EmdTv4vKGcRiU20YU8xuvfajULvCMyq0FUpv9EFXXzmh
         yHDw==
X-Gm-Message-State: AFqh2krDSfXiDJATEA1jhRuyNpYPKdB2b7d12r3rp/8hyxsYVd7TlR+8
        m7LOs12B6+PkZjznd/RFf/Cr3SyWiD6sRibqMf5qkSk1cww=
X-Google-Smtp-Source: AMrXdXvu5BbdT2ZN5Kg4GEROnp5KorCytOsiLKnSCieBP7+fa4s/6N2MA6x5ieAVBpY0UC6IkXs0OXffg8xRJeaQUZQ=
X-Received: by 2002:a05:6a00:1414:b0:580:e5ef:79f2 with SMTP id
 l20-20020a056a00141400b00580e5ef79f2mr3398215pfu.60.1673294004475; Mon, 09
 Jan 2023 11:53:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com> <pull.1422.v2.git.git.1673261237449.gitgitgadget@gmail.com>
In-Reply-To: <pull.1422.v2.git.git.1673261237449.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 14:53:13 -0500
Message-ID: <CAPig+cTHMEeUw8PVg7nWU8+jdo=yN9nC+RRuaSiVg8D3Or-nNQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc: add "git switch -c" as another option on detached HEAD
To:     Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 5:53 AM Yutaro Ohno via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In the "DETACHED HEAD" section in the git-checkout doc, it suggests
> using "git checkout -b <branch-name>" to create a new branch on the
> detached head.
>
> On the other hand, when you checkout a commit that is not at the tip of
> any named branch (e.g., when you checkout a tag), git suggests using
> "git switch -c <branch-name>".
>
> Add "git switch -c" as another option and mitigate this inconsistency.
>
> Signed-off-by: Yutaro Ohno <yutaro.ono.418@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -477,9 +477,9 @@ before that happens. If we have not yet moved away from commit `f`,
>  ------------
> -$ git checkout -b foo   <1>
> -$ git branch foo        <2>
> -$ git tag foo           <3>
> +$ git checkout -b foo  # or "git switch -c foo"  <1>
> +$ git branch foo                                 <2>
> +$ git tag foo                                    <3>
>  ------------

Thanks. This version looks good to me and addresses reviewer comments[1,2,3].

[1]: https://lore.kernel.org/git/CAPig+cQe_VMW2KV+ZyZwosFw07Q+hePryDVushRJ-jFfD4yzpw@mail.gmail.com/
[2]: https://lore.kernel.org/git/xmqqk01wusmz.fsf@gitster.g/
[3]: https://lore.kernel.org/git/CAPig+cTO1jBjcwjX4UpxG813OwrDAaYVvViC_XGWorwbXvOfvw@mail.gmail.com/
