Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC7C2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 23:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742C02225A
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 23:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQfJxiTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762903AbgJXXQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762900AbgJXXQw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 19:16:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE5C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 16:16:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a5so5700287ljj.11
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PJOYdUbYlqcD2FW13MNcYPGuoQ1+a4cd3Y0AU062WmU=;
        b=cQfJxiTbQZrWfyCo+qzqhQERv9AVVgOTRiZeTTfFZOwU05+85HxSJqaG5TgJ8cNsYz
         2g91QShQR64v4wtw86lUM9VY9J3ynAWxBkaP6coeuYPK3wrAmM4hXiuF53MQSha5H8lY
         qy86pFRfdg0sKCCUnpc+by2p+p0hp7oMzPfCQ5Ad9fecAFKpV2/6tfBCtXhcDYcj9rrM
         o18UsK+HQuscPVbL0Plk7MoUcIBXRzXCxs1kqeynOgBgUlmsvfCTRKoF1DjsZcKVZSn0
         3GJ/5GM0tm2RUgB+zac35/QWDEDeBJjQL7UvwTQ4QXENT+ZSEc15+D9/Lc3S+/Uz10mv
         Rb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=PJOYdUbYlqcD2FW13MNcYPGuoQ1+a4cd3Y0AU062WmU=;
        b=RJVRe2hcXExYqe0790ixSGxfm+hzPd0uh4WfXzK1+CRZ5WLJVcB9u5Ma7jyz+UWffZ
         B2EgI5jq9jUlBYqLLTFGqZilse4gshJIHfnaheq7u8TIiz8KPZqhAv+/s567OuQDn3gB
         x8hE+ral5fZ/r/d/naGY57qCGa1UecVMDUG7iiyhJAnw5wBrbiIY3ddfzzBbDNZu7hXR
         ECYPR+ndOILA0pfF26a1JCU6fdYQ/tVAz9hS40C/UrmXKiHKiznIUIAWr39K4TB0IG30
         Ss2FKYmPnXP301A+EjDzEtqIqkvXu0SaQSQtB00xZYRfvCLTGWkihmOT9lQj4CazrewA
         5XzQ==
X-Gm-Message-State: AOAM533wBQqdOcfHpOh9funcDjOh0KtFfMxq8Mv8Lowlhpj6bdQBAGmX
        lIdSgmblm2u4WsfUipLCYgU=
X-Google-Smtp-Source: ABdhPJyWYEpg+2UWuDf2XM/iONnmGqro7ej5UORDJrRaQ39rn8Yne/n9QjlRvR7iWaypj7fehXndOA==
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr3139689ljc.257.1603581410496;
        Sat, 24 Oct 2020 16:16:50 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id v4sm632290ljk.80.2020.10.24.16.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 16:16:49 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 01/10] commit-graph: fix regression when computing Bloom filters
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <fae81b534b14c8227454ff94e385fb16faee0e99.1602079785.git.gitgitgadget@gmail.com>
Date:   Sun, 25 Oct 2020 01:16:48 +0200
In-Reply-To: <fae81b534b14c8227454ff94e385fb16faee0e99.1602079785.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:36
        +0000")
Message-ID: <85wnzf43kv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> commit_gen_cmp is used when writing a commit-graph to sort commits in
> generation order before computing Bloom filters. Since c49c82aa (commit:
> move members graph_pos, generation to a slab, 2020-06-17) made it so
> that 'commit_graph_generation()' returns 'GENERATION_NUMBER_INFINITY'
> during writing, we cannot call it within this function. Instead, access
> the generation number directly through the slab (i.e., by calling
> 'commit_graph_data_at(c)->generation') in order to access it while
> writing.

This description is all right, but I think it can be made more clear:

  When running `git commit-graph write --reachable --changed-paths` to
  compute Bloom filters for changed paths, commits are first sorted by
  generation number using 'commit_gen_cmp()'.  Commits with similar
  generation are more likely to have many trees in common, making the
  diff faster, see 3d112755.

  However, since c49c82aa (commit: move members graph_pos, generation to
  a slab, 2020-06-17) made it so that 'commit_graph_generation()'
  returns 'GENERATION_NUMBER_INFINITY' during writing, we cannot call it
  within this function.  Instead, access the generation number directly
  through the slab (i.e., by calling 'commit_graph_data_at(c)->generation')
  in order to access it while writing.

Or something like that.

We should also add an explanation why avoiding getter is safe here,
perhaps adding the following line to the second paragraph:

  It is safe to do because 'commit_gen_cmp()' from commit-graph.c is
  static and used only when writing Bloom filters, and because writing
  changed-paths filters is done after computing generation numbers (if
  necessary).

Or something like that.

>
> While measuring performance with `git commit-graph write --reachable
> --changed-paths` on the linux repository led to around 1m40s for both
> HEAD and master (and could be due to fault in my measurements), it is
> still the "right" thing to do.

I had to read the above paragraph several times to understand it,
possibly because I have expected here to be a fix for a performance
regression.  The commit message for 3d112755 (commit-graph: examine
commits by generation number) describes reduction of computation time
from 3m00s to 1m37s.  So I would expect performance with HEAD (i.e.
before those changes) to be around 3m, not the same before and after
changes being around 1m40s.

Can anyone recheck this before-and-after benchmark, please?

Anyway, it might be more clear to write it as the following:

  On the Linux kernel repository, this patch didn't reduce the
  computation time for 'git commit-graph write --reachable
  --changed-paths', which is around 1m40s both before and after this
  change.  This could be a fault in my measurements; it is still the
  "right" thing to do.

Or something like that.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---

Anyway, it is nice and clear change.

>  commit-graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index cb042bdba8..94503e584b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *a =3D *(const struct commit **)va;
>  	const struct commit *b =3D *(const struct commit **)vb;
>=20=20
> -	uint32_t generation_a =3D commit_graph_generation(a);
> -	uint32_t generation_b =3D commit_graph_generation(b);
> +	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
> +	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;

Best,
--=20
Jakub Nar=C4=99bski
