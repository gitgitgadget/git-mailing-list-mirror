Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD1C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8358061050
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhHDVtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhHDVtp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:49:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A197C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 14:49:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v2-20020a17090ac902b0290176b4310aaeso527961pjt.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/vkqAy8nsFaJQ/dnI/a90LidfEmbnHnz4lPzEceNwdA=;
        b=C8k+0+4BXBexa23cPw73zdz5cLnPeFjPWZwE0IilayQHtdDQ2BcqCruhFwjyfvCOBb
         mrTYEqGjHU1xYvxrwcny8w8umRnQEq+te9ba66paVBMPbrsc6MOl4oxGzdqZkLij9FBy
         wVWr1YkNQ7N8OddBJzuPsd4KnF5cR7iXrkK/eD37fsZM1CLwfYNx7nSugJptStQgr2xq
         nfWbzKC8XcR7365fMPMvozesZMHB1KRGfj0ydL+Y04WOAzEMCse7GZjLWd7OafhQy8aN
         tnYhf7u6BqgjD3y96e9XD7FXRBYgIDHGAxaYDoQWEkT2hKCKZ/ztGxiYmkWVNjDVEuaH
         qjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/vkqAy8nsFaJQ/dnI/a90LidfEmbnHnz4lPzEceNwdA=;
        b=B04oOd5NuyM66SWX4A/IkzzOb8t+2gxetpbYCXy161SzeQk6ZFPCgclGgLuTukV5N0
         fH9Vjbqh8vYtJNTdGmbx5h3TJlKbJ2OHCRLiMW/VoSU6cTkRqvenLO5delwxwvcuR/+4
         cLTTVVCTYBtJj3iGgWcg+bUjeFHeAliSvsG2chTyAow1CKQyf5oErUwaIAzU57GHSAIM
         2O44WOMjbSlz5aYnFvd/FUe1NM1CtuEJzBQcLF2DOhfOlc2On83LpQPEqaHwY+zRQFsW
         F4EasUdHXDOyypDSW5/zsMatJUpPu//Llwln94TmBSR/rl2VGa3fH4ZARwqnNicJnmd+
         FIxw==
X-Gm-Message-State: AOAM532V4JDE4hcJySfL/hRJwKsD07OzK54iSY+tzM9VxTAmdl84Xwep
        UO+HyLoO1/wbEoHDgL+1EfMlfmvE7qg8NHHoViPc
X-Google-Smtp-Source: ABdhPJxND/P2So41GC+8CLx2/bkqtwsjVFfgGkmdU2bW5e0/5PsAz716/LhU2pabVgZfXx9PErfGoiP3KSaE0HTSGy5M
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:ccc:b029:3c6:701a:3a55 with
 SMTP id b12-20020a056a000cccb02903c6701a3a55mr1645064pfv.46.1628113771901;
 Wed, 04 Aug 2021 14:49:31 -0700 (PDT)
Date:   Wed,  4 Aug 2021 14:49:28 -0700
In-Reply-To: <87bl6ttmlv.fsf@evledraar.gmail.com>
Message-Id: <20210804214928.3689322-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87bl6ttmlv.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     emilyshaffer@google.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I would also need twice as many lines to run a script I wrote as a hook
> > - that is, the base case which is probably all most people will need. S=
o
> > with your proposal I *must* name every hook I want to add. Instead of
> > "hook.pre-commit.command =3D ~/check-for-debug-strings" I need to
> > configure "hook.check-debug-strings.event =3D pre-commit" and
> > "hook.check-debug-strings.command =3D ~/check-for-debug-strings". That'=
s a
> > little frustrating, and if I never want to skip that check or move it
> > later or something, it will be extra overhead for no gain for me.
>=20
> The gain is that "git hook list" becomes a trivial "git config
> -show-origin --show-scope --get-regexp" wrapper.

I think that in both schemes, "git hook list" is not difficult to
implement.

> > I do agree that your approach bans the regrettably awkward
> > "hookcmd.~/check-for-debug-strings.skip =3D true", but I'm not sure
> > whether or not it's worth it.
>=20
> That design choice also means that you can't expand the path using "git
> config --get --type=3Dpath.

I'm not sure what the use of this is, especially when the more important
position is in "hook.pre-commit.command" (which can be expanded, I
believe).

> As noted in the follow-up reply while we don't case normalize the LeVeL"
> part of "ThReE.LeVeL.KeY" that's tolower(), which we know isn't a 1=3D1
> mapping on some
> FS's. https://lore.kernel.org/git/87y2ebo16v.fsf@evledraar.gmail.com/

We're comparing strings in the config file, though, not strings against
what's on the filesystem.

> To reply to all the above, yes, your suggestion comes out ahead in being
> less verbose.
>=20
> But isn't the real difference not in the differing prefixes, i.e. hook.*
> and hookcmd.* (A) v.s. always hook.* (B, which is what I'm mainly
> focusing on, i.e. what requires the added complexity.

OK, this is a good point - it may be confusing for the user to remember
the difference between "hook" and "hookcmd", and your scheme eliminates
that.

> But that in that in your proposed way of doing it it's:
>=20
>     hook.<event-or-name>.*
>=20
> V.s. my suggestion of:
>=20
>     hook.<name>.*

[snip discussion of how hook.<event-or-name> is bad]

I think you were thinking that someone would say "let's unify 'hook' and
'hookcmd' then" in response to you saying "'hook' vs 'hookcmd' is bad",
and you're arguing against this new point. I don't think anyone is
saying that, though.

> That complexity being that you use <event-or-name> and I use <name>, and
> you want to in turn support N number of "*.command" for any
> "hook.<event-or-name>".

I don't know if anyone is wanting to support this.

> The way to skip hooks in my proposal is:
>=20
>     hook.<name>.command =3D true
>=20
> Or whatever noop command you want on the RHS. In practice we wouldn't
> invoke "true", just like we don't invoke "cat" for "PAGER=3Dcat".
>=20
> But unlike "*.skip" that doesn't require complexity in implementation or
> user understanding, it just falls naturally out of the rest of the
> model.

This is a good point.

> Even with I think it's fair to say deep knowledge of your proposal at
> this point I still needed to read this a few times to see if that:
>=20
>     command =3D reusable-hook
>=20
> Is referring to:
>=20
>     [hookcmd "reusable-hook"]
>=20
> I.e. is it going to run:
>=20
>     command =3D /long/path/reusable-hook
>=20
> Or is it just re-specifying /long/path/reusable-hook but relying on a
> $PATH lookup?

This is true - seeing "hook.post-commit.command =3D reusable-hook", we
need to look at the rest of the config to see how it is interpreted.

Going back to the central idea, though, I think that the main advantage
of the scheme Emily proposed is the ability to write, more concisely:

  [hook.pre-commit]
  command =3D /path/to/command-1
  command =3D /path/to/command-2

instead of

  [hook.command-1]
  event =3D pre-commit
  command =3D /path/to/command-1
  [hook.command-2]
  event =3D pre-commit
  command =3D /path/to/command-2

But =C3=86var's scheme gives us the advantage that if need to do anything
more complicated (even merely slightly more complicated - for example,
skipping a hook or overriding the command of a hook), it would be hard
to write (and even to just figure it out) in Emily's scheme. In =C3=86var's
scheme, just following the standard "last config wins" rule (and knowing
about /usr/bin/true) can already do a lot. For this reason, I think it's
worth considering =C3=86var's scheme - writing 3 lines instead of 2 is not
much more difficult to teach and to do.
