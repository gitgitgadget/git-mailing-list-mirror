Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF86C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiLLWin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiLLWi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:38:27 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92E255
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:38:25 -0800 (PST)
Date:   Mon, 12 Dec 2022 22:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670884704; x=1671143904;
        bh=2wwOFLE3o/nby4w5p3ty6svQ5MJ05SvbXwsRMwAiSuc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=iAoBTgLOeIUaog1ZvRJTp391fdWXhBs58IAsOonEKwoZDX+EsG4wZsUyF++dBlC5C
         RzMhEa2KLSYI76zWFQ78tzPRYdWV83Y8aYh4BsZhfT6wZGSuqEaugdCSbFuThswlpv
         R2t/3YfJxH0HfxYm8ZlUFdPvghOSgQMomQPYsu5yMJfJdaNqrxw0dgi5jXKdesluFA
         1BE6b0BWZsk2cFJZH8mew24UtrDiW+WzjxDJaiBElgeqhdG9sZfo+YRm9Q7t0TVt6k
         1oi0t7afHXh0NPU8ZnHaungo3suKt+k/p8mh6dg+SkR2uwuDa743ewaZtJ4kK+82hh
         94i72pKm54WgQ==
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221212223806.nswh5i3l6s7drjek@phi>
In-Reply-To: <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221212014003.20290-4-jacobabel@nullpo.dev> <221212.86pmcp57w4.gmgdl@evledraar.gmail.com> <20221212145913.aftjeq6kn55zbkai@phi> <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/12 07:16PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > The following are what I have made for this set of changes (against v4)=
.
> >
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 8bb1453e0f..38f7a27927 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -732,12 +732,11 @@ static int add(int ac, const char **av, const cha=
r *prefix)
> >         } else if (!lookup_commit_reference_by_name(branch)) {
> >                 advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
> >                         "If you meant to create a worktree containing a=
 new orphan branch\n"
> > -                       "(branch with no commits) for this repository, =
e.g. '%s',\n"
> > -                       "you can do so using the --orphan option:\n"
> > +                       "(branch with no commits) for this repository, =
you can do so\n"
> > +                       "using the --orphan option:\n"
> >                         "\n"
> > -                       "       git worktree add --orphan %s %s\n"
> > -                       "\n",
> > -                        new_branch, new_branch, path);
> > +                       "       git worktree add --orphan %s %s\n",
> > +                        new_branch, path);
>
> Looks good, we'd usually put the "new_branch, path" on the previous line
> (to the extent that it fits within 79 chars.
>
> Also: This string should use _() to mark this for translation.

Done.


