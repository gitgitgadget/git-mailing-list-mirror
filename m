Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7261CC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EF920759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDBXDURj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgEURwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgEURwe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:52:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43CC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:52:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 23so5721026oiq.8
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg45Zx77bYwf31j4v6g7ZMz5mGaOACRoyTssDYmaH5E=;
        b=lDBXDURj7gl2KeE6yoXjXQqrqQ7Up2ebkfJCpxBIWkPRiJtZaz3YxufZVlIsWVDrhL
         YesFMHtgQvju+JgDDR37foXJ1iBJtaTAoSav646qg5pqbaFZI+JVMMpPS4RODZJW48ID
         FspPzsq2KCPisc8OdTZyImWFis1nwjLaJNJ42DgaurKAup0gtJ6QiiNQm1YWYFVhqRfW
         cXemwgy1civ17wK57FSgYPzfIyq90BA8OXhEyduXeXyvg+nCkWFj5KMpttrXTj06CBVA
         swSVgK2em9xNXv/iH2Jr4tZ8gAJyZa++brhUUaMPPS8cSNceao6bncG4gQLv9mM+lcNw
         UgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg45Zx77bYwf31j4v6g7ZMz5mGaOACRoyTssDYmaH5E=;
        b=Qvnw9LnfpIYy/vkvkKDX4yZ7Uw1lwooiGLp80qIfW1A/yPOCDmfIxTKtAfTg/UnsEq
         ZUbNHQk+HGJCNhsNpR0ghIopHQ0x6/l9wzEKejsv+08ThPpeGaN/utaunXt7KA6cBDUT
         vFCl10Yypd8Hvtsd0LNwCTZ4N/i7xgWgkZeowUQ31xfvnGz09iNbjmuOJkwRzvgyOF20
         HBRPoPFYbLm5vwHzDtAkkohM+y0zZuvhMlq96uGgdfaEv3AQq9tB+6FG/VaTeXOnOlD4
         vQmLevI9ZNoQJWLYyxgxvPvH2eNt9lZVtDmcBjzvpJWMiRQbBmw/cS5MJgoxmkYDwTl/
         p+1A==
X-Gm-Message-State: AOAM532bYufs3lKNWnUB0aSrZmF4jirYWapdMpKWhaalshKjTVD/4mvb
        39b9r7AupsCLI8r0QjXKuEgawDfsEkhu3ZZ5Hz8=
X-Google-Smtp-Source: ABdhPJxwfg1o3kYsJPynmHKZ1vo+vcwHL9wyo6K6HpG6RKwiCC2WB1iObfYE/Ro2txB4pW0ZxRwi0m14e8ojzbGUlPQ=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr7838701oia.167.1590083553139;
 Thu, 21 May 2020 10:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com> <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
 <xmqqsgg4wuwt.fsf@gitster.c.googlers.com> <CABPp-BFiPO_Hg-F2edv9GVQSqJCNj6NvOaB5Ez8UUzAMPdTqUw@mail.gmail.com>
 <CAHd-oW7K+OVjScLmL34ctQMYRPqz3B+nc9mNP+v1b2JbaNoMsw@mail.gmail.com>
In-Reply-To: <CAHd-oW7K+OVjScLmL34ctQMYRPqz3B+nc9mNP+v1b2JbaNoMsw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 10:52:21 -0700
Message-ID: <CABPp-BE2PFzUA0uXLXoUw=9aaLU-HvUcf2mdej+atzOGO6GhUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 10:36 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Thu, May 21, 2020 at 4:26 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Tue, May 12, 2020 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> > >
> > > > The idea behind not skipping gitlinks here was to be compliant with
> > > > what we have in the working tree. In 4fd683b ("sparse-checkout:
> > > > document interactions with submodules"), we decided that, if the
> > > > sparse-checkout patterns exclude a submodule, the submodule would
> > > > still appear in the working tree. The purpose was to keep these
> > > > features (submodules and sparse-checkout) independent. Along the same
> > > > lines, I think we should always recurse into initialized submodules in
> >
> > Sorry if I missed it in the code, but do you check whether the
> > submodule is initialized before descending into it, or do you descend
> > into it based on it just being a submodule?
>
> We only descend if the submodule is initialized. The new code in this
> patch doesn't do this check, but it is already implemented in
> grep_submodule() (which is called by grep_tree() and grep_cache() when
> a submodule is found).

Good to know.  To up the ante a bit: What if another branch has
directory that doesn't exist in HEAD or the current checkout, and
within that directory is a submodule.  Would it be recursed into?
What if it matched the sparsity paths?  (Is it even possible to
recurse into it?)
