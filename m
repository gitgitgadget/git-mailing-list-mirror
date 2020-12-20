Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57771C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7EB22AED
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLUFtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLUFtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:49:22 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F556C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:48:42 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id t9so7877362ilf.2
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pV0MjnBOt8CgAuSPEY2oL8NqC+NULq09iROuS9xysbE=;
        b=WUOqmW4UR9rM3CkFmOQwrWP2NCjFdUTT8Sm8NgO9V/rr+oFzCxVEFJXG3xmYcDmbU3
         ASj27RDYtZjOGM2GTYbLh9Hrbb/ltNfZy+/nxuzggkkxmjgwRqmPz7Gobbn0LxI55jS8
         4XE0FowMI7TfoB9zsdTY+7fIDd8ECPBZ1sm5buTu5PKYJpQsbmlseXITPdncuUoCrbok
         6MHsoVh+E05wJmuMGl9moAYWJ8LglyHzIDKhvn1K8WuB4pZnzrpyOtGcCEqpWYASJL2x
         3RfP7XbFyyuDZ+PuvrP4k8qBSZu2JlUHAjUYxn2jVX+OJar8FNuk1uF113mJcdWKLtyJ
         QCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pV0MjnBOt8CgAuSPEY2oL8NqC+NULq09iROuS9xysbE=;
        b=sIQdbfPpn0mffkW1kpQCqlkRZiv82wS855Ei7hGUHh5ctR7dzRhhaTymgltgFxxcdy
         HpU3L4vtGy89Y00fweXN7Lp739Svr80jgnrGLYk+K1+nyBpYI4IHAsuy0f1Ue+tB732d
         xLf52hCE1qxdCny7XXxi4TLh4Q7dTuzx63reVqaSNelrZrapnYTBXOYGLYd9vpogDEt1
         fAVHdLVqu07zWAzr7VIuYyjQ70HxXQNQOX05Ar2M4ORNObaw1Va5yhyyBUDez2Ez7sEB
         5qFv4Xe6ksALfRFj1G3cgLkeYQbVK+ZjKTegpGfmV9VhnPowOXzLrZEg2D4uuO2sHDb/
         cQeQ==
X-Gm-Message-State: AOAM5308ZLuX5SHP3djxxD5FGmadRizGaY0CMDd6x7+Vy3sZ+H+wsdi/
        VD4b6ISu242BNXqYkEn10wFcf+mLzTVehSA+DhsF5gOfQhM=
X-Google-Smtp-Source: ABdhPJyiB3YllPS4dI0U/4iy31eb/wx54tWnmD6zUUXAJQ6g9YUqDiGMC/Ku8OHSWNHLZjbiHzv+fZZLQFVMm0DA0Iw=
X-Received: by 2002:a92:444e:: with SMTP id a14mr13942801ilm.129.1608502982611;
 Sun, 20 Dec 2020 14:23:02 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com> <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch> <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen> <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen> <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen> <xmqq3603v3a0.fsf@gitster.c.googlers.com>
 <5fdc998216c89_104e15208da@natae.notmuch> <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
 <5fde69944fe4d_1e50c7208f@natae.notmuch> <CAJDDKr6RP+TPFF2mHph7sqa-eG9uoRtqS4d4vUU84V3HJ_CMBA@mail.gmail.com>
 <5fdf030d2bde5_32bc20825@natae.notmuch>
In-Reply-To: <5fdf030d2bde5_32bc20825@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Sun, 20 Dec 2020 14:22:25 -0800
Message-ID: <CAJDDKr5EiH3R284XNToTkVQ1a12Mqp7oCA30xpt_cMjatfHQjg@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 11:53 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> David Aguilar wrote:
> > On Sat, Dec 19, 2020 at 12:59 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > They don't have to rely on that failure, they can just turn off
> > > mergetool.automerge.
> > >
> > >
> > > But fine. Let's the perfect be the enemy of the good. That seems wise.
> >
> > FWIW I'm in favor of having per-tool configuration precisely for
> > custom mergetools that do things with custom file formats and benefit
> > from having all of LOCAL REMOTE and BASE.
>
> That's a preference, not an argument.

Lol, that's why I said "in favor".  But, since you asked, it turns out
that my preferences have a stronger weight than yours.

"git shortlog -n git-difftool* git-mergetool*" shows that my
preferences and opinions are 44 times more important than yours in
this area, whether you like it or not.  ;-p

Poking fun is my answer to such misguided seriousness.


> > I don't have to imagine these use cases, they are very real.
>
> Show one.

Heh, I don't have to show you anything.  If you *really* want to see
one then I would be super happy to get your resume, but I doubt I can
convince you to go that far!

Barring that, please use your imagination.  Imagine a custom file
format for a graph-like data structure (both binary and text-like)
that is able to use the full set of information for the purposes of
resolving conflicts.  Private tools exist.  It's impossible to prove
that they don't so I won't ask you or anyone else to do so.


> > This design choice is also in alignment with the general
> > mergetool/difftool per-tool configuration paradigm.  If we didn't
> > support per-tool, then it would be inconsistent.
>
> Can you do
>
>  1. mergetool.vimdiff3.keepBackup
>  2. mergetool.vimdiff3.keepTemporaries
>  3. mergetool.vimdiff3.writeToTemp
>  4. mergetool.vimdiff3.prompt

can_merge()
diff_cmd()
merge_cmd()
translate_merge_tool_path()
list_tool_variants()
exit_code_trustable()

mergetool.<tool>.cmd
mergetool.<tool>.path
mergetool.<tool>.trustExitCode

We even have mergetool.meld.hasOutput which is completely tool-specific.

I'm not asking, I'm telling you: the tool was designed around per-tool
hooks.  This is per-tool behavior.  End of story.


> ?
>
> In fact the opposite is the case; not a *single* `mergetool.foo`
> configuration can be done with `mergetool.<tool>.foo`.

That's not the right question.  This a behavior that can differ
per-tool and thus this feature must reflect that.

There is a difference between top-level and per-tool behavior.  This
is a per-tool feature and we want a way for users to be able to
enable/disable it globally while still enabling/disabling for an
individual tool.  We must allow individual tools to expose their
enhanced capabilities, otherwise the community tools have no reason to
improve, and private tools would be harmed.

The way to think about it is that it's a per-tool feature with a
top-level default.  The important implementation detail is that tools
have plenty of hooks for per-tool flexibility; the configuration is
just one way that we allow for it.  The scriplet for something like
"diffconflicts" could even override should_automerge() to return false
since it might want to handle it itself, for example.

We are not designing just for today; we must keep our eye on
longer-term goals where the community tools can be improved.

I'm in favor of the auto-merge feature in general, and think it should
be made the default behavior (in a future version?).  That said, it
entails a change in behavior and having a granular mechanism to both
allow enhanced tools to do their own thing, and to allow the original
behavior to be retained, is the most sensible approach.

Here is the "right" question to ask: Why shouldn't we have this
flexibility?  The implementation is pretty darn simple considering
that the toolset is already designed with per-tool affordances in
mind, so why not?

What I am 100% certain about is that someone is going to notice the
change in behavior, and whether or not it's "better" is completely
irrelevant.  The heavy hammer of completely disabling the feature
means that they will have crippled all of the other mergetools just
because one of them couldn't cope, or because for whatever reason they
want the old behavior, so we should turn that heavy hammer into a
fine-grained chisel.

Are you willing to compromise on the small concession that we should
allow per-tool overrides so that we can move forward and get this
integrated?


To be extremely clear -- is this discussion arguing between the
following two strategies?

# Per-tool override + Global default

should_automerge () {
    git config mergetool.$tool.automerge || git config
mergetool.automerge || echo true
}

# vs. Global default only

should_automerge () {
    git config mergetool.automerge || echo true
}

, or are we discussing a different aspect?  When spelled out in code,
we're discussing whether or not we should have
"mergetool.$tool.automerge ||" in there, and the argument for why not
is pretty thin considering that use cases that would be harmed by not
doing so exist.

Such a trivial difference is not a hill worth dying on so please route
this energy into a patch so that we can get this integrated.

I suggest this compromise -- if adding "mergetool.$tool.automerge ||"
to the logic is something you don't want to do then submit the patch
without it and I'll submit a follow-up patch that adds the per-tool
override.

I'd personally prefer to just have the patch include this from the
get-go, though, so if we've managed to convince you then please take
the shorter path to success.
-- 
David
