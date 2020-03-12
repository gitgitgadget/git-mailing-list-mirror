Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67004C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302BC206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMzYzAK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLVyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:54:43 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38440 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLVyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:54:43 -0400
Received: by mail-ed1-f41.google.com with SMTP id h5so9422836edn.5
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kPcaQa1Yiew8G3RzgE4XrrzQ6dv1Lp7XS0A57o56UM=;
        b=YMzYzAK7hHIPzumKmajVdRrvejwOpiGuMQIFRne/uHjVWTUNKJxSoEYhBcIsbugbRs
         Y8/sG2U8ywi/5ZpomynucWxe9dlV8M7/+owNR5oIFMF+WquvdHAG0wrdBw4a6JhgCPz5
         HkRLGKn8TCJMc7Skh+nAUriPdDY4rAkBwHxVnrvfziKG/ZSa+4op12CRrxL/wrqybrcj
         RXq0GDT//eSoKJG61CIkbXaVnRnma0aifPXG5J/BNhoCp+6KW9EbODqxUU97YRdVZdVp
         s21P00vC4khBRk24zx0/u4Fse7g5V1svYkpgi3xrXpSTwExezwyjgjjse4GA0nDAkcHt
         miOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kPcaQa1Yiew8G3RzgE4XrrzQ6dv1Lp7XS0A57o56UM=;
        b=DgWSk6lCEsmHEaQuWajKlbCps8USmH9j1bKyswaGG6lEgsQ9+uUGCG3dCtYLRIEYn0
         plPSbMDGkYSUN3XtSy4h5C/mRklTvpD+J83U3Rwg0Nk/ChubcLoxi9wCOS+W613ppUyu
         16w2c+7m4M26Naq+yJLtwaSFmXl/KBjJVrHEBtV5DYhC1PrPtf7Iv6CKqZMGM5sMghJR
         NLNBkadTcjmbg8LUxb+okmhJ+O8k5sSKnUMwAXy7IHcaXLip2QsJ25FEqw13zCivzmba
         iLQEcwFN6RLrkFQztp+vgxYjuU9qJRUAVxgig5PSQdVP3Q5PUWsGuPEFov2Pcekea3WM
         6hVA==
X-Gm-Message-State: ANhLgQ343Faho6oQT3XQGHCPUbEXaLvB73o62/lB4nm5oJdElINiiflT
        DAhOVGOsj+9KtDv+ETO2IxZAcWZkaNFxPd3fes4=
X-Google-Smtp-Source: ADFU+vvHarbIUoKC6VoZZ8v7SKdclmA2/0u7vLp7AnoYkN4XfPnM2w6afRDIcWdS599Tgnb7SGzWXsUzYnfwk5i+0y8=
X-Received: by 2002:a50:f70c:: with SMTP id g12mr10311995edn.142.1584050080856;
 Thu, 12 Mar 2020 14:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com> <20200312175151.GB120942@google.com>
In-Reply-To: <20200312175151.GB120942@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Mar 2020 22:54:29 +0100
Message-ID: <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 6:51 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jonathan Tan wrote:
> > Derrick Stolee wrote:
>
> >> but it appears that we rely on the "remote.<name>.promisor = true"
> >> setting instead of this extension.
> >
> > Hmm...besides giving the name of the promisor remote, the
> > extensions.partialClone setting is there to prevent old versions of Git
> > (that do not know this extension) from manipulating the repo.

That could be true of "remote.<name>.promisor = true".

> Yes, so the lack of setting is a bug.
>
> Christian, what would your prefered way be to fix this?  Should
> extensions.partialclone specify a particular "default" promisor
> remote, or should we use a new repository extension for multiple
> promisors?

My opinion has always been that "extensions.partialClone = <remote>"
is a mistake as it is inherently making difficult to have many
promisor remotes.

It is also not clear what a default should be. Should it be the last
promisor remote that is tried when all the others couldn't provide all
the needed objects? Or should it be the first one that is tried? And
what if the order should be different when pushing and when fetching?

I think it is much clearer to have an order (that could be different
when pushing and fetching) in which promisor remotes are tried.

So I'd rather obsolete "extensions.partialClone = <remote>" and to
find other ways.

> [...]
> > I cloned and indeed it is as Stolee describes. Git still works as
> > expected if I remove "promisor = true" and add
> > "[extensions]\npartialclone=origin", so at least extensions.partialClone
> > is still supported, even if not written by default.

Yeah, I didn't remove support for it. Maybe we could have
"[extensions]\npartialclone=<bool>" though that feels messy, or maybe
we could have another extension alltogether like
"[extensions]\npromisorremotes=<bool>" and over time obsolete
"extensions.partialClone" altogether. I prefer the later.
