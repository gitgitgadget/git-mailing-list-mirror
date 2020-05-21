Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E6C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6FB2083E
	for <git@archiver.kernel.org>; Thu, 21 May 2020 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtA0V8SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgEUH0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUH0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 03:26:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8CC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:26:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h7so4794692otr.3
        for <git@vger.kernel.org>; Thu, 21 May 2020 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGLx0aOHXSR8TnAZGHCLYyKUFEkqSnnYFrnrf4T2loM=;
        b=BtA0V8SFaH2S07e35Oa+AmOcvZDq7bYt2WPAenAF/UDpgHG5wo+pJUSm6EGqOLojpA
         n8S3Ics5X3tlCvY30kX8HME/ikhq8E1KBiQgGpvhfqJasEAYAfChvxheX+VL740CV/lN
         F6fO76lpWmJcOWmsqqlpb2rRbMcRtcPBcvg1u83A7cPKpTKA6fMHe05c+Z65KOx0BEfg
         kTzUBhdQB36TjcRs2lr9VBs6wcNG3NktVDTr4T3bKEYyOyjOiKF2vonWKVw1DejZm7wl
         ZlBSTxyCP4P3jNuzLPDFQ0igtLEC57GRO0hnQOcZaPKzBfad/VcXZ6G256YFD5x9CdHn
         RXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGLx0aOHXSR8TnAZGHCLYyKUFEkqSnnYFrnrf4T2loM=;
        b=WtMjB5wjRtlPVZhnTqo91pMHe4OopLZdS6XaX1dWew4o9icdZL2wUgX7TTft8TZmCn
         GoBOqHeSvmpbxeTdkYYxuqN7dC1xABg326+ISGC2iMPk/6WVauTei4FYsEHD5LhQQqIg
         +ZHNcvSWvWPWAfYwH8Rkj5snNMGjVK1MUsTFXa0uYF9zeVFQLS/Zn4hm55tyQyiWmH7u
         I5yu59rRLn+uYGTqmvRZKsFNH3UrAOrPgRtzqO5Oun9dmjkJ80alEGdQrir+c2X4lKGy
         Q7zHkHZ2xz/m5hwYKonkenFZJKQ2Ubt3e+EH/vQtL21SPiRuKL+QUK9mkBALthij5+m/
         fD9Q==
X-Gm-Message-State: AOAM531nogS3YRwrryUR1AHhZxKKoOiGPX6Lhu18ewQ70Oxt4POysPiw
        lVmlZAT1C1UFQw1rx2AzdSZj2ePi1TMVeREoCoInzyQA
X-Google-Smtp-Source: ABdhPJyCx0qZ8R70AgUMS42b9NK98NoLKiTQ7lyqk8VtkCKU9CmX7u+TZEQnaDC9Cdb8FV4dc6BUwb/PGlh1tus+t54=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr6272409ota.345.1590045978090;
 Thu, 21 May 2020 00:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com> <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
 <xmqqsgg4wuwt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgg4wuwt.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 00:26:06 -0700
Message-ID: <CABPp-BFiPO_Hg-F2edv9GVQSqJCNj6NvOaB5Ez8UUzAMPdTqUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > The idea behind not skipping gitlinks here was to be compliant with
> > what we have in the working tree. In 4fd683b ("sparse-checkout:
> > document interactions with submodules"), we decided that, if the
> > sparse-checkout patterns exclude a submodule, the submodule would
> > still appear in the working tree. The purpose was to keep these
> > features (submodules and sparse-checkout) independent. Along the same
> > lines, I think we should always recurse into initialized submodules in

Sorry if I missed it in the code, but do you check whether the
submodule is initialized before descending into it, or do you descend
into it based on it just being a submodule?

> > grep, and then load their own sparsity patterns, to decide what should
> > be grepped within.
>
> OK.
>
> I do not necessarily agree with the justification described in
> 4fd683b (e.g. "would easily cause problems." that is not
> substantiated is merely an opinion), but I do agree with you that
> the new code in "git grep" we are discussing here does behave in
> line with that design.
>
> Thanks.

I'm also a little worried by 4fd683b; are we headed towards a circular
reasoning of some sort?  In particular, sparse-checkout was written
assuming submodules might already be checked out.  I can see how
un-checking-out an existing submodule could raise fears of losing
untracked or ignored files within it, or stuff stored on other
branches, etc.  But that's not the only relevant case.  What if
someone runs:
   git clone --recurse-submodules --sparse=moduleA git.hosting.site:my/repo.git
In such a case, we don't have already checked out submodules.
Obviously, we should clone submodules that are within our sparsity
paths.  But should we automatically clone the submodules outside our
sparsity paths?  The the logic presented in 4fd683b makes this
completely ambiguous.  ("It will appear if it's initialized."  Okay,
but do we initialize it?)

You may say that clone doesn't have a --sparse= flag right now.  So
let me change the example slightly.  What if someone runs
   git checkout --recurse-submodules $otherBranch
and $otherBranch adds a new submodule somewhere deep under a directory
excluded by the sparsity patterns (i.e. deep within a directory we
aren't interested in and don't have checked out).  Should the
submodule be checked out, i.e. should it be initialized?  Commit
4fd683b only says it will appear if it's initialized, but my whole
question is should we initialize it?
