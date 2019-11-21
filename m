Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA1C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01485206CC
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgqXbE5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKURBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:01:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43977 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKURBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 12:01:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so3809193oie.10
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Piq3X6YB6e/NG9SWT3AjNfOPyvaaL41ulEECqIOkl5g=;
        b=tgqXbE5pCPD6/M8Y8eOi6W+SOx8gt2YswbHy7NgMw3SsI9ggfMVcvCQ5uL0f5THZwR
         9GohV2GW6jGZIllyIlbyfmLOA4xugTtIszjqXoDVM4VhOg3rtZGed2cDkD8VYMxKp2/x
         0rWnVgsZSEj1Sj/yduW0+DCL992mgwnZShk1wV6NbuLTwpdXNvc4U5Faq58jB7t15iM3
         WsX46/sKLTux70dyClwWmRkkW3RCdZWZQWr4gEIi14gRQhT1kbaweUTGSllv0YsfkS8T
         P4Zm0f0l7Rsb89gNdzjjVLBYSGb+od/KAMc6XQYSrtnS/H+5SYhLq4NaPZU0sv4SEk6a
         yFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Piq3X6YB6e/NG9SWT3AjNfOPyvaaL41ulEECqIOkl5g=;
        b=mv3+wzeL2CziQnjy8gGXNgw1BQg+61gWc1n5wg2OkNumVe6CkqwtbdTYzJVvPghn5d
         GbWoHx3Ciw422W24Hwdc2/k8ai92XXXS86ZYtnwL8p4+tU8KuyGdNd4XgpGclZsJSgWb
         tP/zlKoaoHy7SxAfBOZSTbzzlBhCr+XyB5lQVJl29Rtm2affSMw85+jjF5tsTxhlH2d8
         /1iI9z2mMJUj2S01qlX11uWIT/mwQ2qO6w2uoQkNO7GrbsEy0i/1S7gEEzyZ9NJXDW3h
         zwIqcsnzFuw88ndHfPYAYQiFqvLSxuA9DmIbIlAbFIcgRM9jdny6fkHo9VbUjs5f6Dx4
         4NBw==
X-Gm-Message-State: APjAAAVI7EKaNROvZ4v74MWFNbF2F4nNma0d0oK1I8Jynl6VjarV1XIs
        VI+0lOJZHiwp3cPwFGGfw6iNOcpctDf05o7ZNTg=
X-Google-Smtp-Source: APXvYqxb+2UfmBcTAIlecVQzWmylQ/c3ZC0DdRm0CyoGz51JrJOs4gPosE02CLdPzmdcLP5YnFWmGEPRcNC19EEjaj0=
X-Received: by 2002:aca:c508:: with SMTP id v8mr8219857oif.31.1574355691194;
 Thu, 21 Nov 2019 09:01:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com> <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev> <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
 <20191121152744.GU23183@szeder.dev> <72a54009-5801-c92a-f108-faf38ebbdd4b@gmail.com>
 <20191121163706.GV23183@szeder.dev>
In-Reply-To: <20191121163706.GV23183@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Nov 2019 09:01:19 -0800
Message-ID: <CABPp-BEVFyd9+22MhtREh57FYUJhBSj2vz3piUuk_hX8=Aq3UA@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 8:37 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Nov 21, 2019 at 10:36:10AM -0500, Derrick Stolee wrote:
> > > But wait, I thought that only changes to files that are excluded from
> > > the sparse-checkout are thrown away, but as it turns out it throws
> > > away changes to files that are included in the sparse-checkout:
>
> For completeness, 'git sparse-checkout disable' throws away staged
> changes as well, as it, too, runs 'git read-tree -um HEAD' (or its
> equivalent).
>
> > Thanks for the additional details.
> >
> > This series intended to make the existing sparse-checkout behavior
> > more useful to users by not requiring manual edits of the sparse-checko=
ut
> > file followed by 'git read-tree' commands. However, there do appear
> > to be some serious improvements that we can make in the future.
> >
> > Keeping staged changes seems important, and we can address that in
> > the near future.
>
> I think that at least for now 'git sparse-checkout' should flat out
> refuse to init/set/disable if the working tree is not clean (but still
> allow 'list', as that's a read-only operation), like the patch below.
> Yeah, that way it wouldn't work in cases that appear to be safe
> (unstaged changes), but it would prevent the data loss until we
> carefully consider the circumstances under which these operations can
> be safely allowed.

A big +1 for this from me.

We had an unfortunately large number of mis-merging and dataloss bugs
in the merge machinery that were slowly fixed over the course of more
than a decade[1], due to the fact that builtin/merge required
index=3D=3DHEAD and did so by placing a comment in the code notifying
folks that the individual merge strategies were responsible to enforce
it -- and, in practice, they *all* forgot to do so unless and until we
discovered bugs.  So, count me as a strongly in favor of just
preventatively enforcing safe conditions and then later relaxing them
in special conditions if it can be proven safe.

[1] https://public-inbox.org/git/20190725174611.14802-4-newren@gmail.com/

>   -- >8 --
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 76f65d8edd..4b05625c4c 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -12,6 +12,7 @@
>  #include "lockfile.h"
>  #include "resolve-undo.h"
>  #include "unpack-trees.h"
> +#include "wt-status.h"
>
>  static char const * const builtin_sparse_checkout_usage[] =3D {
>         N_("git sparse-checkout (init|list|set|disable) <options>"),
> @@ -188,6 +189,10 @@ static int sparse_checkout_init(int argc, const char=
 **argv)
>                              builtin_sparse_checkout_init_options,
>                              builtin_sparse_checkout_init_usage, 0);
>
> +       repo_read_index(the_repository);
> +       require_clean_work_tree(the_repository,
> +                               N_("initialize sparse-checkout"), NULL, 1=
, 0);
> +
>         if (init_opts.cone_mode) {
>                 mode =3D MODE_CONE_PATTERNS;
>                 core_sparse_checkout_cone =3D 1;
> @@ -386,6 +391,10 @@ static int sparse_checkout_set(int argc, const char =
**argv, const char *prefix)
>                              builtin_sparse_checkout_set_usage,
>                              PARSE_OPT_KEEP_UNKNOWN);
>
> +       repo_read_index(the_repository);
> +       require_clean_work_tree(the_repository,
> +                               N_("set up sparse-checkout"), NULL, 1, 0)=
;
> +
>         if (core_sparse_checkout_cone) {
>                 struct strbuf line =3D STRBUF_INIT;
>                 hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL,=
 0);
> @@ -437,6 +446,10 @@ static int sparse_checkout_disable(int argc, const c=
har **argv)
>         char *sparse_filename;
>         FILE *fp;
>
> +       repo_read_index(the_repository);
> +       require_clean_work_tree(the_repository,
> +                               N_("disable sparse-checkout"), NULL, 1, 0=
);
> +
>         if (sc_set_config(MODE_ALL_PATTERNS))
>                 die(_("failed to change config"));
