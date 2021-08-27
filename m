Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80776C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E7960EE7
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhH0VPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhH0VPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:15:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498AC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:14:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p15so13723540ljn.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5AgU2T6HgnnWSTYrGhAbJpXNAEwJeu9WfJB5sRPvpo=;
        b=S5Ja/xXKIhxLGe3HJYtJ3uXGh72/onr8qsWCLt1c7ooaM7Q+12ESIG3vHDfdFB1TXb
         sAhtvCp4wxLcQvUkYPCkCC7OnhiFnHnM4PEQTnH5GQzfUF7jz2DPcx6YwZhLuDMlYGTJ
         HunM3MnHx0j9WaCGJL3chGzNrYw8GJyXR7AvcJ7hTvESBc3bKC/ZkBdNfkcYFWAqP9MO
         gW76aoBhpIDBlXBJNFMat4VSTsSH+ahzJATkpVKgnXGtmBEAYh4GwTdMHBKQgJjZ4ass
         /rXoT2p0kSRRE12TPpRwR3dHH2bPPpye0BYhsBuQTLO9YDqIWCWE/NmvZH6nBPGw7LZH
         4u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5AgU2T6HgnnWSTYrGhAbJpXNAEwJeu9WfJB5sRPvpo=;
        b=M7RePUnTBsNwUW+/Yjjp0B/WObpdoB2g3o+R9mA/rixr2w8C4+fP1tiUIckLoE5u5W
         iCN9b7ELkZPQ9Lkh7FpmPrNJntu2iS+zQiCvcY7efzma87weJWXJA135rJUpCkuWdvZs
         ZhMEibgp5ZCcxWcumrr4h6bD0ojRtdqBoRPMKrMK9S2tgZe2HHS1Z5ehCLjUY/a99BCY
         NYVgMgNJOUtnlEJ9AK5dT+/Ormsngdy8NlsRr9o9P68aMwRyiaVb5+MfFJ/V5WWt4pWG
         gm2IhjGW4uREB2kWHzLYqa3vZE1pA4Y2NFVXBMDWffwxTU0wZSKAmJr325KkBD2Ih4hh
         UbRA==
X-Gm-Message-State: AOAM530P+tM5H9h4W3MsX5YLDjYer3X7Tr/hRmYDrji/S6Y/HZHBfAXl
        QB9QWZqw7UPpvIzKpddgzcv1Dvgs5GVeeZNP5d3tWQ==
X-Google-Smtp-Source: ABdhPJyrzdbPey0VZLGTT1myacL3bKGtm9ukjE6nFlxfqV0woqGlfaAdAdhshVyn+dNhtOCP5R6wL3mu4BF1Won9I7o=
X-Received: by 2002:a05:651c:211c:: with SMTP id a28mr9665018ljq.8.1630098863200;
 Fri, 27 Aug 2021 14:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <6edadbc2000bd6d2ec76cbeff08b309ae4928b37.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <6edadbc2000bd6d2ec76cbeff08b309ae4928b37.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:14:12 -0300
Message-ID: <CAHd-oW7xvnojJsxi7thukOtQ0=m2eiGdkr9Ne+kj1Lufc_MbZg@mail.gmail.com>
Subject: Re: [PATCH 07/13] add: implement the --sparse option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 3a109276b74..68f2de80594 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
>
> @@ -46,7 +47,7 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
>                 struct cache_entry *ce = active_cache[i];
>                 int err;
>
> -               if (ce_skip_worktree(ce))
> +               if (!include_sparse && ce_skip_worktree(ce))
>                         continue;

Not related to this change but just as a reminder: if you agree with
my suggestion from the previous patch to use the skipping logic at
run_diff_files() or update_callback(), we also need to override it in
this patch when include_sparse is true.
