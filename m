Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F3E20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 20:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFAUg0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 16:36:26 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34473 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFAUgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 16:36:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so36901008pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IYWwnWrr6Tc68c5WRI/fnc9c/HpF8K56R4kxiIVs1v4=;
        b=K8xhpvGEh90umiMeL++lMtMqdw6CWc/QjH1qtCWH6xe9ezXaQM/N2jaMl04F679DyK
         zsDXV4g/AiK+L9ry7ntKyesxD1is4lkM44+rs6bHrcC1B+pJA6m7aLT7xe3leLSzrg3Z
         e5Rl+leWyl9CcMeHJQfEdRXUKjMgTey04HUy+eSM5u1hby2ZwpbrIqMeKzggx8H3mlO6
         bB/zsWo0ORFCjbz1ADYKGuyeogFIr7ib5xi0Ho8SeXTtwx/FqSOIyItrJ6rKKBC5yUSl
         SxA5B5Tm7o8TV8NsG/YjLjEpiwkBjgMbPbPAQjkXGgBPOtRf52xiyoWwGdbkpJh9uvNQ
         eiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IYWwnWrr6Tc68c5WRI/fnc9c/HpF8K56R4kxiIVs1v4=;
        b=uI6jIlto/zvZzTbJrD4DSABNcjBS/ZXpGQfU5AmYFS79Okvutt8TA0X9MobAPkEFPz
         9XyuIEWTmV089TDzNuRkAlVND4zgxFutpsA+uA30FhRmzDaa7C5JpedqC6jPG8+mCpJf
         gLrtI/qCk3P8/R8Em0hXbKlgAgVzHnwgnZyAO5mfAT3YYA15IwGzbm5xfq0dGwdClS55
         eF+D2crohIBDELDddOX6PySlKF67euCEXxNuC9NnQ0t+kXMSXULlRTxnf8F6FiRflv93
         C+oLA6R00AjhveHn0a3L3bvLDrBBYmbt7oFWrAR3OhfOpFm3hX3gOoHLTOgyGpBhHxJl
         iIcw==
X-Gm-Message-State: AODbwcCjl/dbnbbvG5gjEoCN6c3/5GI8kmX5OkmI260Twc/Lg2wvPvj5
        mJyio+kv+SsyckddZrp+FUBWWMhLjMzG
X-Received: by 10.84.248.73 with SMTP id e9mr98361810pln.76.1496349384934;
 Thu, 01 Jun 2017 13:36:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 13:36:24 -0700 (PDT)
In-Reply-To: <20170531214417.38857-32-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-32-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 13:36:24 -0700
Message-ID: <CAGZ79kY4iLWuCrPVA6mo6BbgwoF_-wyP_=ju5Fs0+n8cTifb=Q@mail.gmail.com>
Subject: Re: [PATCH 31/31] ls-files: use repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:44 PM, Brandon Williams <bmwill@google.com> wrote:
> Convert ls-files to use a repository struct and recurse submodules
> inprocess.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>


> +static void show_submodule(const struct repo *superproject,
> +                          struct dir_struct *dir, const char *path)
>  {
> +       struct repo submodule;
> +       char *gitdir = mkpathdup("%s/%s", superproject->worktree, path);
> +       repo_init(&submodule, gitdir);
> +
> +       repo_read_index(&submodule);
> +       repo_read_gitmodules(&submodule);
> +
> +       if (superproject->submodule_prefix)
> +               submodule.submodule_prefix = xstrfmt("%s%s/", superproject->submodule_prefix, path);
> +       else
> +               submodule.submodule_prefix = xstrfmt("%s/", path);
> +       show_files(&submodule, dir);
> +
> +       repo_clear(&submodule);
> +       free(gitdir);
>  }

I like how it seems easy now to do work in another repository. :)

> -       { "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
> +       { "ls-files", cmd_ls_files, RUN_SETUP },

With this step, we can get rid of SUPPORT_SUPER_PREFIX eventually.

I do not have comments on the patches in the middle, but they
cleared up some of the questions that I asked in the early patches.

Thanks,
Stefan
