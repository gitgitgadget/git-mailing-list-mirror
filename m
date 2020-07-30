Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61857C433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 05:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322EF20842
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 05:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6+Q7Gca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgG3F0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3F0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 01:26:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD42DC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 22:26:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so13143870ply.11
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 22:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=RH6GcZpw1lmKzVxpdTz/etGQ4cXGp5oEHr+6r2BUl4s=;
        b=i6+Q7Gcaz6qWoYCL9wu8rOUjbFmCWrVHjlfCunR+gYLTjV3gjQGwn9JkJ1PJQZBOXU
         eYBv1azAp+Z7pFhClCQKKf9fvsvlDE4o0MXJZDsXjLC97iS/YQc9FzZOvfhSrvRixx8T
         fJ67YnDOSwOFpPC0MWshUmN3GPllx/NCaYtiRBuB1kxuYL9UlvzrE5TtUVTvCkrN0xmZ
         DeQN6pSC/9L2BXHAuuOJT9WLC75F+iipGXBv32S3/uxP7isUqMNIwgsXGu6XkibWlSws
         Cp9WRsuMEfOZaz3ZTcqIpcVWXLdIdws2Q1Zi4Bm8tgnzbyh0Uy5uDP8I4A36G9U7P9h0
         XURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=RH6GcZpw1lmKzVxpdTz/etGQ4cXGp5oEHr+6r2BUl4s=;
        b=Rk3dxHOJ59jZyT1TKanhTK6VjpAiHk1IVCiE1Gs3ye6j3zeLCNj3Xou8nACigvu36d
         SQ/RQWBIZNl911FL0+r445c0U5qLt4gXufzxBgJeZ0yZgDPNMFjJlZMReZamOIhxwxDr
         b8jMcJoc+isNjnf/p3Z97/NE2Nz4QKoSjDolU5DG4r68fV5Tl2fz6Fc6D/IBar90lbqt
         lExgBrthfBo1L5c9Cq8kfWhhV8L5IAKDQOXyRMt3+1ThN0r1M/RWkDH6+AVXKNLU3j2u
         61gihHdePr6CnSvaIYVUX+O1pX26Se8ZZMUtvhIsOhKxMOcwh06IAXyX8NkYH20LHA1c
         /XxA==
X-Gm-Message-State: AOAM5303rD7+zvZ0ifAaZbpt1VsL2hRqm9npmBIVNnJB1MMdIPVHF7Xm
        VQtkcsifkxOfkNmZdjFUzS4=
X-Google-Smtp-Source: ABdhPJwRkGclxDYoGcuKi/eMdDmTluPPOn8jnHyHoZ5HKaGBefgMY2vPRBmtq6tCExphFRWygEV3Wg==
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr1442828pjb.84.1596086794187;
        Wed, 29 Jul 2020 22:26:34 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:208c:7cf0:d18:2f72:fb83:4831])
        by smtp.gmail.com with ESMTPSA id x66sm4451575pgb.12.2020.07.29.22.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 22:26:33 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:54:29 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, abhishekkumar8222@gmail.com,
        gitgitgadget@gmail.com, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom
 filter
Message-ID: <20200730052429.GA50429@Abhishek-Arch>
Reply-To: 20200728152844.GB87373@syl.lan
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
 <20200728152844.GB87373@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728152844.GB87373@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 11:28:44AM -0400, Taylor Blau wrote:
> On Tue, Jul 28, 2020 at 09:13:46AM +0000, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With 3d112755 (commit-graph: examine commits by generation number), Git
> > knew to sort by generation number before examining the diff when not
> > using pack order. c49c82aa (commit: move members graph_pos, generation
> > to a slab, 2020-06-17) moved generation number into a slab and
> > introduced a helper which returns GENERATION_NUMBER_INFINITY when
> > writing the graph. Sorting is no longer useful and essentially reverts
> > the earlier commit.
> 
> This last sentence is slightly confusing. Do you think it would be more
> clear if you said elaborated a bit? Perhaps something like:
> 
>   [...]
> 
>   commit_gen_cmp is used when writing a commit-graph to sort commits in
>   generation order before computing Bloom filters. Since c49c82aa made
>   it so that 'commit_graph_generation()' returns
>   'GENERATION_NUMBER_INFINITY' during writing, we cannot call it within
>   this function. Instead, access the generation number directly through
>   the slab (i.e., by calling 'commit_graph_data_at(c)->generation') in
>   order to access it while writing.
> 

Thanks! That is clearer. Will change.

> I think the above would be a good extra paragraph in the commit message
> provided that you remove the sentence beginning with "Sorting is no
> longer useful..."
> 
> > Let's fix this by accessing generation number directly through the slab.
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 1af68c297d..5d3c9bd23c 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	const struct commit *a = *(const struct commit **)va;
> >  	const struct commit *b = *(const struct commit **)vb;
> >
> > -	uint32_t generation_a = commit_graph_generation(a);
> > -	uint32_t generation_b = commit_graph_generation(b);
> > +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> > +	uint32_t generation_b = commit_graph_data_at(b)->generation;
> > +
> 
> Nit; this whitespace diff is extraneous, but it's not hurting anything
> either. Since it looks like you're rerolling anyway, it would be good to
> just get rid of it.
> 
> Otherwise this fix makes sense to me.
> 
> >  	/* lower generation commits first */
> >  	if (generation_a < generation_b)
> >  		return -1;
> > --
> > gitgitgadget
> 
> Thanks,
> Taylor
