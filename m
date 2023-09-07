Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697BEEE14D4
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 04:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjIGEyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 00:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGEyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 00:54:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273DB19B5
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 21:54:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so795565e87.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1694062443; x=1694667243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNOv5XyNxu3kH8K71HCMXje/UY0rEEfi9lLg1dryfY8=;
        b=Te0ArH2gn8KXl5NycjHHpS1xCi7pew0YucSQhHiwnPvx68FOcoq6Gc2RaRn8H/tMSk
         QepRM+T8EQPq2sFEX1oo5jz4/ocHy1J0iPkHJNB5HkDqlMwXnsYM0bzjGZ6JGIU+9Amt
         iT15NDvi3kz3a+/VzgioxNlB4o8SJSux4LqNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694062443; x=1694667243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNOv5XyNxu3kH8K71HCMXje/UY0rEEfi9lLg1dryfY8=;
        b=F7cRIitjz1R7haozEamDJ5WLOdrFvlydeJnL2G6x9cSMM5E5AQMD3a5eKc2YWrW9Y4
         2TIuSyRbDYh9Z+PSC4X/5QAkr9W/omuW0mOGnDRNm3K9G7YkjAPjNMIg2y5PW/7e7gYG
         E0SPp8VNTlVO9Sya5BJu1JPSZ5987jQj1vkZQjYvcUb51svwUa5aGEM9UmWcxLbc+CDa
         rEYbhN/buWEuf8/VT2NiqE9Z/QQ7VguLH7Ao9qjKvTqLKZ8igY6Sm7AM0gS3/K8GmPR2
         4HUHam8OB8u9ZT/9cyGeJ7rlK0xYH52tUuHKIpVxdgNafqn3PRnQZ5RG3bLhxt6NL8sQ
         DPUg==
X-Gm-Message-State: AOJu0YwIanONXB8C8bEF9fVKmHV5+2OYlpQTBjtPgCHFapTnbRvUGMgs
        oErdF+VevLu7yLBMbXyxNs+yjh1UbfvnWJZ9ScOkpCBE0EF3KI191nCcWdMe
X-Google-Smtp-Source: AGHT+IFooBDTrV8nv5IZyRQMgaXu+kyPpPSu+xa7tukovOLvpWkIq+3pCkAh5Z/efBVin5TvDBuJ0QA0y26jNzwFjKc=
X-Received: by 2002:a05:6512:5cf:b0:500:bf44:b2b6 with SMTP id
 o15-20020a05651205cf00b00500bf44b2b6mr3072983lfo.45.1694062443161; Wed, 06
 Sep 2023 21:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com> <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com> <87edjbuugw.fsf@osv.gnss.ru>
 <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com> <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
 <xmqqledjm4k2.fsf@gitster.g>
In-Reply-To: <xmqqledjm4k2.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 7 Sep 2023 06:53:58 +0200
Message-ID: <CAPMMpojTLswqubRk0Ly3RQqkrnpx_9Hiu_TRK1=ASPbPNz4ApQ@mail.gmail.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap
 error in git gc.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Sergey Organov <sorganov@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2023 at 10:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > I like the nomenclature, I like the simple "zero (i.e. bare) or one
> > inline worktree, zero or more attached worktrees" explanation.
>
> We have used "main worktree" to refer to the working tree part (plus
> the repository) of a non-bare repository.  And it makes sense to
> explain it together with the concept of "worktree", as the primary
> one is very much special in that it cannot be removed.  You can see
> that "git worktree remove" would stop you from removing it with an
> error message:
>
>         fatal: '../there' is a main working tree.
>
> It probably does not add much value to introduce a new term
> "inline".  Here is what "git worktree --help" has to say about it.
>
>     A repository has one main worktree (if it's not a bare repository) an=
d
>     zero or more linked worktrees.

I've definitely changed my mind about "inline", I agree "main" is
better. I'm not convinced it's the best word we could come up with,
but if it's well-established, I'm happy with it.

The problem I (now) see with "inline" is that it seems to imply a
spatial proximity that doesn't necessarily hold true, with
"--separate-git-dir" or other ways to separate the main worktree from
its usual "just above the .git directory" location. "Inline" is still
a reasonable qualification of the main worktree's *metadata* in that
situation (index, etc), but I think the word would not be sufficiently
clear/representative overall.

>
> I applaud whoever wrote this sentence for packing so much good
> information in a concise and easy-to-understand description.

I also like this sentence, it's basically equivalent to Sergey's sentence a=
bove.

>
> We can read that (1) a non-bare repository itself is considered
> its "main worktree", (2) a bare repository, by inference, has no
> main worktree (otherwise we wouldn't have said "if it's not"), and
> (3) both bare and non-bare repositories can have linked worktrees
> (again, otherwise we wouldn't have brought up a bare repository in
> the description).
>
> Perhaps we should borrow it to update the glossary, like so?
>

Looks good to me, but that leaves me with a different nitpick: we say
'One "worktree" consists of a "working tree" and repository metadata,
most of which are shared among other worktrees of a single repository,
and some of which are maintained separately per worktree'

This claims that the *shared metadata* (presumably the refs, the
branch reflogs, the objects, the config, etc) are *part of the
worktree* (a worktree "consists of" them and other things). That seems
like a very strange way to conceive of things, to me.

I would find it reasonable to state that the main worktree is part of
the repo - certainly that's now most everyday users would think of it,
if they were made to think of the worktree concept at all - but not
that the shared repo metadata is part of the worktree, and especially
not that the shared repo metadata is part of the attached worktrees.

I imagine that this weird phrasing intends to allude to the fact that
a worktree is "broken" without the repository metadata folder that
contains both its worktree-specific metadata and the shared metadata
that it depends just as much on... but can we come up with better
"relationship words here?

* A repository "has" zero or more worktrees
* If it "has" a "main" worktree it is not a bare repository, otherwise it i=
s.
* It can have any number of "attached" worktrees

If a repo "has" these worktrees, is it in the sense that I "have" arms
and legs, and I "consist of" a person with arms and legs and other
body parts, or is it in the sense that I "have" a lifetime, opinions,
legal rights, and other things that I have as a consequence of being a
person, but are not "part of" me?

Similarly, do we have a term for "the directory that contains the
'refs' and 'objects' folders and stuff", regardless of whether it is
in fact the entire bare repository, typically with a name other than
".git", or it is nested in a main worktree in the usual fashion as
".git", or it is separated (and again, typically differently-named) in
a "--separate-git-dir" topology? I called it a "repository metadata
folder" above, but I'm not sure whether there is a correct, succinct
term for it.

Wrt to the "shared among other worktrees" bit specifically, I agree
with Sergey that "shared among all" would be clearer, but it's still
weird, because all of that shared metadata is "inherent to the repo"
beyond any and all worktrees. If this happens to be a bare repo, and
we remove all the attached worktrees, the metadata is still just as
meaningful - so saying that it was "shared among the worktrees", while
true, seems to be unnecessarily implying a smaller purpose/meaning
than appropriate.

Sorry to continue nitpicking - I would love to see a clear
nomenclature and description of these parts and their relationships
for people (with less git experience) to "get it" more easily.

>
>  Documentation/glossary-content.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-=
content.txt
> index 5a537268e2..d9ba3bab88 100644
> --- c/Documentation/glossary-content.txt
> +++ w/Documentation/glossary-content.txt
> @@ -694,8 +694,8 @@ The most notable example is `HEAD`.
>         plus any local changes that you have made but not yet committed.
>
>  [[def_worktree]]worktree::
> -       A repository can have zero (i.e. bare repository) or one or
> -       more worktrees attached to it. One "worktree" consists of a
> +       A repository has one main worktree (if it's not a bare
> +       repository) and zero or more linked worktrees.  One "worktree" co=
nsists of a
>         "working tree" and repository metadata, most of which are
>         shared among other worktrees of a single repository, and
>         some of which are maintained separately per worktree
