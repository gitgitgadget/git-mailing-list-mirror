Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C4C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8E52177B
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYA/ynTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHEXQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHEXQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 19:16:15 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57BC061574
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 16:16:14 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so19789692ljj.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kPHEsR1e8ZqMOt1MMKS6khbhMJtJnx+6rBpIliAdf+o=;
        b=ZYA/ynTEEjbvp6rhAJaNqHc2RuUTWDFZ35hkik7BPSO5KMXUMyJZLS5TDZVW0hWXWH
         OB2IXW4/LVgCIXRfs7tXMCLyLsJb2VUW0WtU62Ijsm4M3gw7qHt8viG9pj/ysihNkkql
         Tkueq3ynnmYygqYbn4PiyTBGMDVBBP/53vtveCcYHgPAf22ZYJwvcBWT+0AhK6beCAn9
         hSNjlMJeHbUXNMMa6Y/c2p1ODvYnYfaHEmRrRntec6+CwLzJZzdCoaTSeUqS9so2h5PF
         y6U9RPhTnMChH30ZKA/CEh2yf4DoeViw+SBnXTDAgLDaU6e8nt5X/nYAUC452ayyn935
         S3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=kPHEsR1e8ZqMOt1MMKS6khbhMJtJnx+6rBpIliAdf+o=;
        b=aMH616WRlj04xTjTWje75aDkng/4nltYQTlIxXwORyJ95aSUs6UGTAU9TdtzXG8OZe
         XumBPclSeWrURJZrBhDz8oXp3R59Ycyvd2sPfWk4L03BiFiblMvR7WJG0Z8wRs1nWlGE
         e/dxkEhdxb5aulrpVxhDG0uMF3a5qHxFBrZVpP9T3Tg7kKcu12G8L1oue3WSDM551DXp
         wRLRqZyBNcTMkf/bXdEBnuQP2XbIF1rtVGM/oUmH9vVfZFg1bOUeQpO3nPXuea/bk+wU
         kpaPbJU2rOIbhKJz+bJb6v2L0bsON7k9E8JzSqRRl494/LE8mBFwZezCfKucBmQ7PQJP
         H3fw==
X-Gm-Message-State: AOAM530lNl2un2TRfC98pawdGrAF+okEWAopMuQxQvFOl12pFH1Bcl0a
        Vfn1F7HOeRrTCtFhocZpeVg=
X-Google-Smtp-Source: ABdhPJzpc4VapM1ddk1YxzHIVQMSM+yBAQ697tYMtbuEy5sKyj1hZFkuqOFNF3I5IJAbvhBjrTwgrw==
X-Received: by 2002:a2e:81cc:: with SMTP id s12mr2410243ljg.232.1596669373181;
        Wed, 05 Aug 2020 16:16:13 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id a2sm1501750ljj.40.2020.08.05.16.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:16:12 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 2/6] revision: parse parent in indegree_walk_step()
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:16:10 +0200
In-Reply-To: <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Tue, 28 Jul 2020 09:13:47
        +0000")
Message-ID: <85pn84u1j9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> In indegree_walk_step(), we add unvisited parents to the indegree queue.
> However, parents are not guaranteed to be parsed. As the indegree queue
> sorts by generation number, let's parse parents before inserting them to
> ensure the correct priority order.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  revision.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 6aa7f4f567..23287d26c3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3343,6 +3343,9 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  		struct commit *parent =3D p->item;
>  		int *pi =3D indegree_slab_at(&info->indegree, parent);
>
> +		if (parse_commit_gently(parent, 1) < 0)

All right, parse_commit_gently() avoids re-parsing objects, and makes
use of the commit-graph data.  If parents are not guaranteed to be
parsed, this is a correct thing to do.

Though I do wonder how this issue got missed by the test suite, just
like other reviewers...

> +			return ;

Why this need to be 'return' and not 'continue'?

> +
>  		if (*pi)
>  			(*pi)++;
>  		else

Best,
--=20
Jakub Nar=C4=99bski
