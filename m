Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB0C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D4C207F7
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BsYKj3kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgEURgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEURgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:36:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAA5C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:36:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so4955921lfh.2
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfvvbYqHiplRAqSDWsql8PS5OzeHH6yiOFTEZ8wq39U=;
        b=BsYKj3kRmnDjUS7FimgjQhciqKtxQEOVzNerQ28WwBqk1ku7tWqetzGo8JyClBzIcr
         R0Dc8KTeqZj4/4XVVjHstO9pfmj4LQ648i4f/VZ7T2xvof4mMlBY9hx8612laH+66HGb
         anL3qNuRCF+asttZhSoVTIm8ZivGzVtgCjRNEqK7e50mHDnQphdmGoids6eN9kvMA59D
         dp0Y8v0s8V5B0ZveUPSBTL6+ZEFG3kUaTEqj/kmmZHADP3JI7yQOlgoUad+tnPS33qSm
         C/1G/ozEiRmdmT9Hru8f2LJ+digtzDS3t3+sRMcsY76JUNODvdXqjsF/16HgYyfAsOXh
         zK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfvvbYqHiplRAqSDWsql8PS5OzeHH6yiOFTEZ8wq39U=;
        b=npyuFE+cCwJDYSnhu78zML7u1wakQfNaMpqzp70ZUMMLuxyYdkV+8WGgbMn06nhawt
         SFrd070pX76W7GAv2XIfuiDEHiYT40xsdJLvuZuIJU7k8Xrj35T0jJYKr+JIkOxsV9Hg
         GoH9K911J04InXjBZHA4i76WnwdE8ST0PsQPpRsuGNs9esUZ9RRzO+TXGG2Qr/jgTGTf
         Gp30jD4UkANg3JIU0kln96QbxlWJUt1jen4uZLrYyzvErTjUYmda3pCaK2gDSfT9xTcr
         WrLO/3NKb5L8Cgi9cFAJ/r2GfeIItJbRRI7fpF4fjKdMLlZ1lmNfC5w15dDcvV033Q1e
         GM2Q==
X-Gm-Message-State: AOAM533OaUkENDhrloWwZwCJnRjiALmMFVXIqx/0KLsYlNajUS7TFYCu
        nhc/m2SkLYwMdnHYn8PtGPtwq7UXuuMt+XSmgg9e4g==
X-Google-Smtp-Source: ABdhPJxCnH5pnjdQz5B2XI8M2V2DjOl/LlNywG5rGI29pdKnx5LAot01YkCpP9DlgqaN0P+ybWgvdM+FG0JOVRGFGfg=
X-Received: by 2002:a19:f119:: with SMTP id p25mr5227768lfh.99.1590082561144;
 Thu, 21 May 2020 10:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com> <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
 <xmqqsgg4wuwt.fsf@gitster.c.googlers.com> <CABPp-BFiPO_Hg-F2edv9GVQSqJCNj6NvOaB5Ez8UUzAMPdTqUw@mail.gmail.com>
In-Reply-To: <CABPp-BFiPO_Hg-F2edv9GVQSqJCNj6NvOaB5Ez8UUzAMPdTqUw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 21 May 2020 14:35:50 -0300
Message-ID: <CAHd-oW7K+OVjScLmL34ctQMYRPqz3B+nc9mNP+v1b2JbaNoMsw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 4:26 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, May 12, 2020 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> >
> > > The idea behind not skipping gitlinks here was to be compliant with
> > > what we have in the working tree. In 4fd683b ("sparse-checkout:
> > > document interactions with submodules"), we decided that, if the
> > > sparse-checkout patterns exclude a submodule, the submodule would
> > > still appear in the working tree. The purpose was to keep these
> > > features (submodules and sparse-checkout) independent. Along the same
> > > lines, I think we should always recurse into initialized submodules in
>
> Sorry if I missed it in the code, but do you check whether the
> submodule is initialized before descending into it, or do you descend
> into it based on it just being a submodule?

We only descend if the submodule is initialized. The new code in this
patch doesn't do this check, but it is already implemented in
grep_submodule() (which is called by grep_tree() and grep_cache() when
a submodule is found).
