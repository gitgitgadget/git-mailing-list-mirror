Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0EC35641
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 03:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B1620722
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 03:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndZ7RRjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgBVDLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 22:11:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43471 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVDLS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 22:11:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so3661609oif.10
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 19:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raJPgZeIsS4NHdAuTf2PUb4NyzSKw39o5XXzW/q7KGE=;
        b=ndZ7RRjwiKF66rLo8rwQ41zI2AvreKLqno8ijUCmNlPiaiA/XxHFXbsRHeZwNWLjMj
         I5VYRzpf+5hdT2GqddkT6hrqMpZmWLVqJeCbAsiVNxa9Ys1AOxY7DIceLoUdl/5T9mdO
         maNltWaCSjdyiGlp4eIoztufdQUbjytuOngSiR8YJL11CT3GO+XJYrcN0zRS53bQsRFK
         KDIV3SOenphOa3U+QBTX/Fgw5a4fH/Yszma5OKX4L9yVWOpIvl059BbE4wyY5lOQsaRm
         kTSxqjpWqG9eXmrQJyk+hOf9ku/xexaQE2d5KZx4YOK8TvJuJoeDa0jbLWguFeemZ8s3
         VUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raJPgZeIsS4NHdAuTf2PUb4NyzSKw39o5XXzW/q7KGE=;
        b=b0N30gvkc4Mv/bHZPn8hdaTW6nnKSiOjXmOtLHzo/tmI0UYqC95cPBD4nTkk+vFWb5
         h3SdGM2rW8SfrN6TH3nAvia8gPSOACSCLyRX+IImDlowz9c+cWxlKWlAFpSa63KD6I0S
         WNC8ejwIBJ2gDEWU9eFE9+oOdwffv8SK5OzML6wjjmwip8zit09gQah9YgCimlJBaU/J
         iec2+19LHu66TcJxQAudXjz22S3emmvpOvh9EWDT7ztqwHj7NFDi2+m0jWIN3HK//b2B
         UrDAQ0RTaDVdFQZZeFQyGyLTgwCChA5+md8FyerHQDmWE4LvuIHz30JCFIhq9j9DUAwI
         /6mw==
X-Gm-Message-State: APjAAAWwwkNrmXeSfdb2PFUInslO2xWPWVLh0BFYlsafGg8MydNcFbFN
        4f8oPEbGsQyGp7tmC0PkrFtAv6yHYHqHoWIJmP8=
X-Google-Smtp-Source: APXvYqyvfxPkQPpj8OhrGaiAK1OcJ2DW8WL1gRXYX/aKD0Nb3JN8jBR3hmbIZc14nqlFZacIZ+A5o4bumETuUYRIGaQ=
X-Received: by 2002:aca:5588:: with SMTP id j130mr4548960oib.122.1582341076219;
 Fri, 21 Feb 2020 19:11:16 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com> <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
In-Reply-To: <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 21 Feb 2020 19:11:05 -0800
Message-ID: <CABPp-BEnt4C_7XyxQKxk4aga=JjM9fXCE-7SFp7azO_v5-pQYw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 7:30 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Feb 17, 2020 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > * en/fill-directory-exponential (2020-01-31) 6 commits
> >  - t7063: blindly accept diffs
> >  - dir: replace exponential algorithm with a linear one
> >  - dir: refactor treat_directory to clarify control flow
> >  - dir: fix confusion based on variable tense
> >  - dir: fix broken comment
> >  - dir: consolidate treat_path() and treat_one_path()
> >
> >  The directory traversal code had redundant recursive calls which
> >  made its performance characteristics exponential wrt the depth of
> >  the tree, which was corrected.
> >
> >  Still RFC?
> >  cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
> >  cf. <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>
>
> Yes, sorry.  I was hoping someone familiar with untracked-cache (or
> even just the index format) could comment and provide some pointers,
> but it looks like that won't be happening.  I'll try to dig in this
> week to figure out what to do there.

After some digging around, at least part of the final patch is wrong,
and it points to me having somehow broken something with the untracked
cache in the earlier patches.  (t7063.8 sets up a test where dthree/
and dtwo/ should both be shown as untracked directories by 'git status
--porcelain' but are not.  'git ls-files -o --directory', in contrast,
will show them as untracked.)  I probably won't have time to work on
these until after the Git Merge conference, but I will clearly need to
find and fix the bugs before this series progresses.  Feel free to
drop this series in the meantime if it's easier for you.


> > * en/rebase-backend (2020-02-16) 20 commits
> >  - rebase: rename the two primary rebase backends
> >  - rebase: change the default backend from "am" to "merge"
> >  - rebase: make the backend configurable via config setting
> >  - rebase tests: repeat some tests using the merge backend instead of am
> >  - rebase tests: mark tests specific to the am-backend with --am
> >  - rebase: drop '-i' from the reflog for interactive-based rebases
> >  - git-prompt: change the prompt for interactive-based rebases
> >  - rebase: add an --am option
> >  - rebase: move incompatibility checks between backend options a bit earlier
> >  - git-rebase.txt: add more details about behavioral differences of backends
> >  - rebase: allow more types of rebases to fast-forward
> >  - t3432: make these tests work with either am or merge backends
> >  - rebase: fix handling of restrict_revision
> >  - rebase: make sure to pass along the quiet flag to the sequencer
> >  - rebase, sequencer: remove the broken GIT_QUIET handling
> >  - t3406: simplify an already simple test
> >  - rebase (interactive-backend): fix handling of commits that become empty
> >  - rebase (interactive-backend): make --keep-empty the default
> >  - t3404: directly test the behavior of interest
> >  - git-rebase.txt: update description of --allow-empty-message
> >
> >  "git rebase" has learned to use the sequencer backend by default,
> >  while allowing "--am" option to go back to the traditional "am"
> >  backend.
> >
> >  The last step may be rushing things a bit and may want to be
> >  taken separately.
> >  cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>

In contrast, this whole series I think is complete and ready to merge
down.  Both Phillip and Dscho have commented that they agree with the
direction of the final patch, Phillip has reviewed multiple rounds and
sounds happy with it, and most of this series already spent some time
in 'next' during the 2.25 cycle.

> Thanks.  I'm curious, though, what you mean by this last bit -- was it
> just a reflection of my request for folks to comment on whether the
> last patch was wanted?
>
> In my view, taking the last patch separately does not make sense; it
> should either be dropped entirely or taken close to the same time as
> the series...[snip]...if we're going to change the backend names, it'd
> be better to do it sooner (while the cost is negligible) rather than
> later.
