Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B1C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbiASVct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 16:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbiASVcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 16:32:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD26AC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 13:32:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s30so13544267lfo.7
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 13:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuLJaTLgjHXtlV7xfPMrFQ4Ksuf9IxIk31gL6/p5VxM=;
        b=Ep2dkAwUTyW+M0voc8b3vZas2n9+GbGl8A/1ThLqjIi5rJQuR6+92GIICuPddTzdEr
         2ckGDcRTbvZeUldTsee3+N0zhC6p0zQm9tUKbxGH6CyLchZSd8l+oeStcWf0rX+Z1ze+
         1fq6KfTrWYXoZjx4lkZKyn3qbbOaQaQ4ckLWs745SX1dBtvm+24XS5bic9P8ZUkFcg08
         5PlpzqrcV8jjgaU6WBiRmOoLNXsobHIUSZe481z5EcrLOtvuQ3JHY/wNR0j+zwNMIUoI
         fXj+2xruGsOkJ0Y+UvWnc94yXG2+JGPfGKgx3RFoeOrrZJU8FxYj/6Ywe6xFOrWNTxSN
         XKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuLJaTLgjHXtlV7xfPMrFQ4Ksuf9IxIk31gL6/p5VxM=;
        b=ex8N57TX09uqIum/yg400OGOU8nzeY8WHwKPVtK84Imveh9uLDLL5I5Ej1kwaOWBpL
         tOf3oD3ZGN1BYUjGUHfXQWgi9RPJ4X9fP+fNlc9RA+cyaDYs2uQCzBFmyPCNO9MtGNVE
         QwR9doT6N07YA8vnTZ8xCh3TD7ks9AZLusSph2xRK125wMXulWwQvQuEjh9HgR9BlpOo
         umyUFAaqEbVUwcASk8TKJm76BntetCpHyNXMqRUYrf0Eqwq75NLTKkILvDE9ANnJAcmj
         Sty4m2f8DD4zwUCrsGX9TZadvmEz/kcOulqc5NDElPLpEzuW+TbzMJKK2Nw2ruFEvFyb
         MhPg==
X-Gm-Message-State: AOAM531MSC3JAZ/8TYtbSPpc6Z3rAwyfRNVfEJAkOl4sl14B1I/J7Uhy
        r0IgK3LycU6ILPpJaB9jCzt8oTHPWhBp0250yoGhSQ==
X-Google-Smtp-Source: ABdhPJx7C7VCXpcscpVEdA88lAKrjSPzhsn1TQg6IWWiywBoL/D8EDBpj/wRqC2wvZ5Yxwbi48vp8PgLD/jxleV7x90=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr29429144lfu.240.1642627966014;
 Wed, 19 Jan 2022 13:32:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqy23h4nss.fsf@gitster.g> <220118.86a6ftowx3.gmgdl@evledraar.gmail.com>
 <kl6ltue0ygcq.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6ltue0ygcq.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Wed, 19 Jan 2022 13:32:34 -0800
Message-ID: <CAJoAoZ=FKV6231v21pwZg4BycCyjdxn7iYJXWc5iAM3F62gwPw@mail.gmail.com>
Subject: Re: ab/config-based-hooks-2 (was: What's cooking in git.git (Jan
 2022, #04; Fri, 14))
To:     Glen Choo <chooglen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 18, 2022 at 11:49 AM Glen Choo <chooglen@google.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Fri, Jan 14 2022, Junio C Hamano wrote:
> >
> >> * ab/config-based-hooks-2 (2022-01-07) 17 commits
> >>  - run-command: remove old run_hook_{le,ve}() hook API
> >>  - receive-pack: convert push-to-checkout hook to hook.h
> >>  - read-cache: convert post-index-change to use hook.h
> >>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
> >>  - git-p4: use 'git hook' to run hooks
> >>  - send-email: use 'git hook run' for 'sendemail-validate'
> >>  - git hook run: add an --ignore-missing flag
> >>  - hooks: convert worktree 'post-checkout' hook to hook library
> >>  - hooks: convert non-worktree 'post-checkout' hook to hook library
> >>  - merge: convert post-merge to use hook.h
> >>  - am: convert applypatch-msg to use hook.h
> >>  - rebase: convert pre-rebase to use hook.h
> >>  - hook API: add a run_hooks_l() wrapper
> >>  - am: convert {pre,post}-applypatch to use hook.h
> >>  - gc: use hook library for pre-auto-gc hook
> >>  - hook API: add a run_hooks() wrapper
> >>  - hook: add 'run' subcommand
> >>
> >>  More "config-based hooks".
> >>
> >>  Will merge to 'next', with minor nits?
> >>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com=
>
> >
> > I'd really like that, if you're OK with it.
> >
> > I.e. I could re-roll it, but those comments are relatively minor, and i=
n
> > any case will be addressed eventually by subsequent to-be-submitted
> > parts of the hook.[ch] API conversion.
> >
> > So unless Emily or Glen have strong objections I think it makes sense t=
o
> > mark it for 'next'. Thanks!
>
> No strong objections from me :) The minor comments can be cleaned up,
> and some might presumably become obsolete later?

No objections from me either. Thanks.
