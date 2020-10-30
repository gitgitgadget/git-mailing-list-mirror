Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A86C55179
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF60A22210
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpLjaKm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJ3ITd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 04:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3ITd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 04:19:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE484C0613D2
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 01:19:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p5so7417383ejj.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKZiciqPhxwspGsl3EcmzV8xmUPXlJiYGaBkt2dpMOE=;
        b=DpLjaKm3tuKpxrwWuSgyDAV8uI1tehYRSIs++Ppb37Kmd7c1SkKyaTREhYdS5gR6lh
         iDz/W4fv840VdzMxXUZs4lw/9s5Jhi6UIdqqgCCvLGHOOCEEd6IijzEimX/44wqRca58
         /NOZRvutMZaUTdZcGPR+UfXbBT5yxUdfI+j76fWD3d5gsHu4/l+T7SjLqnWvMe/QDefJ
         JYcQ+7bpYAbeMZ8o2NOS4ldD5REiIHHyzWlA/Os39Pmbyk93O19FRd9trgizjZdu2wST
         FC14VcJQV92fyCqP7wu5gXcaE6+XulhIlQmQbkpuC3OC72qvm0zLnFYgPEDJ6wJQhQcX
         airw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKZiciqPhxwspGsl3EcmzV8xmUPXlJiYGaBkt2dpMOE=;
        b=k+U0/WBnEvwm2I3MSRU6KLgyAVGzsuCIT32qL0tVlQps2G3a48JHC5+dvQAJ31gvUC
         Ol2T3vqlsksC0UgcWmNwQwBDmidV1Pz9VZNcXs2qTOgD6n95IvvVZPSuhuXuU9BFmP/N
         1psYeYRbd/t122mTIGMdbBXUDmAARyK/5lfnO3wTSeyVhdqg6aMa6q6U1NscPOh9ltZN
         aYn6r0Bd3KcT8w49J1FIolj3Qs+QFTW7YQlYfca0z+99hMaU3Cw8wg1DNGV7d5XANRo4
         NQE9JE3gwQSSylefRGY7bbK4vKN86o9FtP5fvYwWLBZK9PtnVQGZ/BxwU7LfDPzsW/yp
         4qsw==
X-Gm-Message-State: AOAM530NPnQMmDGSxXlHTEU+xpwpH+neKFELFEOUi6q8TgiEmVxTfaWt
        /SNnFGNhfpEh7hOD4VyI3ACh/MQGFzSq1x5pTwLp3naVUa8r9A==
X-Google-Smtp-Source: ABdhPJzwvK5ypvukKO1MlhV+Eq6dvtci0YELJBa9IKZxym9OncZvU4+S8ObgdxltWWtNHhJh3ZnhRu8ed1s8WTvNXeI=
X-Received: by 2002:a17:906:278b:: with SMTP id j11mr1310516ejc.197.1604045971621;
 Fri, 30 Oct 2020 01:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <robbat2-20201027T175013-504497035Z@orbis-terrarum.net>
In-Reply-To: <robbat2-20201027T175013-504497035Z@orbis-terrarum.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 30 Oct 2020 09:19:20 +0100
Message-ID: <CAP8UFD1_h7SBmY8rOgwuXPfN_fygOVhMyjryti+75E+XGO-maA@mail.gmail.com>
Subject: Re: Bundles: Partial Clone & Shallow clone
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 10:39 PM Robin H. Johnson <robbat2@gentoo.org> wrote:
>
> Hi!
>
> I was wondering if anybody has made a start towards easier ways to
> create bundles of partial & shallow clones.

I don't think anybody has started working on this.

> I'm looking at potential ways to improve the various snapshot &
> incremental update mechanisms that we have available in Gentoo Linux's
> tree distribution.

The next Git Rev News edition
(https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-68.md),
which should be published today, has a summary of a discussion thread
(https://lore.kernel.org/git/CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com/)
related to this that you might find interesting.

Best,
Christian.
