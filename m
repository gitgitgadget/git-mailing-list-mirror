Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC2C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1302611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhI1Gsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Gsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 02:48:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1504C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:46:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so27736023ota.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqAszlaLy5ZWa8wVxN1a4YPKK2K9mz+0Dm+/hKityvc=;
        b=aYgFtARnPlUHxjiegu6a3+lvhBcSAeqSbnvq29hnq4v4EtKOf4MGdnQ7v8/fmA1X4d
         /+fJboCgTf2WgLdzM2CtHn7UEZvQ3A9ll8hhW2MAxENTSgHggl3FA7wgBtbaOo+okSi+
         HdQuvFNAZd1NmmzLhfTwDWr7YwDI/Bf5t7AQHkMHzIB/MLiyOrT9UNmknbYJPNQJPgJP
         A/pHG1382N3H0Rsi60W86AlYzRbrPTyr/9VIfNGWC34ixGJmNTHYq4eCv9k2j2S1Xpfp
         G+SLOAo7SvFHftkiO2ZAwOoAsF/5uIMksvUt0qvfldt7uQvcjBjq7Q7muETJrbx6S7FF
         2k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqAszlaLy5ZWa8wVxN1a4YPKK2K9mz+0Dm+/hKityvc=;
        b=C01U61tAlGlUDitdmy1Ju/GL1bXZNpuNrvoKN/GNHWn5iq4umJ2t9/bFYJM13i9gn0
         bwMXrA4qzacnexBVupcnO6p46nrgzYeB8pgG3ny89tcxI4ZNuWKH2c5WGo50jH7bvW+T
         tB310goI2wUHhHhRMyktfk2MsAGBPZcS6dc1DEdNS/pJJoeyQfX2hnMB1k8l5ntmGviK
         O2gnf3pHMhB1v2oONnm0vAXOC9UC2cGtODiN6/G81g8YRZ6kJjYntVWenRf+TYFYcdJV
         KW4Tdo/FNU/+d9yW+tKanlQt+oCBtpUW3+/qB2t0md55b/NlozUrCD6WwfCplUgSKaSM
         IOnA==
X-Gm-Message-State: AOAM531C1LZF2ur5FP3KLnBH7YZrrJflYTc+Odn2FHn9kZth0iQuecO1
        wjumNIeU/uWqTmd2W2YiO3sPj9K90I+kfM9bfVaCkZfrx3s=
X-Google-Smtp-Source: ABdhPJy5DphLGn4x7cHU4uW7/gfBc+FJy2zC2FEPUtqebyYCfTKe61VBRJxdjPQvNzhzuTdpv7WDct214yOQCDncRKY=
X-Received: by 2002:a9d:7f17:: with SMTP id j23mr258746otq.25.1632811611941;
 Mon, 27 Sep 2021 23:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g>
In-Reply-To: <xmqq8rzhmsi7.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 23:46:40 -0700
Message-ID: <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Did some slight re-ordering of topics]

On Mon, Sep 27, 2021 at 5:53 PM Junio C Hamano <gitster@pobox.com> wrote:

> * ds/add-rm-with-sparse-index (2021-09-24) 13 commits
>  - advice: update message to suggest '--sparse'
>  - mv: refuse to move sparse paths
>  - rm: skip sparse paths with missing SKIP_WORKTREE
>  - rm: add --sparse option
>  - add: update --renormalize to skip sparse paths
>  - add: update --chmod to skip sparse paths
>  - add: implement the --sparse option
>  - add: skip tracked paths outside sparse-checkout cone
>  - add: fail when adding an untracked sparse file
>  - dir: fix pattern matching on dirs
>  - dir: select directories correctly
>  - t1092: behavior for adding sparse files
>  - t3705: test that 'sparse_entry' is unstaged
>
>  "git add", "git mv", and "git rm" have been adjusted to avoid
>  updating paths outside of the sparse-checkout definition unless
>  the user specifies a "--sparse" option.
>
>  Will merge to 'next'?

It would be nice to see the --diff-filter=u change, which you also
seemed to like[1]; but after that, yeah this is ready to merge down.

[1] https://lore.kernel.org/git/xmqq35pppwsm.fsf@gitster.g/

> * js/scalar (2021-09-14) 15 commits
>  - scalar: accept -C and -c options before the subcommand
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>
>  Add pieces from "scalar" to contrib/.
>
>  Will merge to 'next'?

I feel bad for taking so long to take a look, but I finally responded
with a few comments.  Mostly, I'm glad it's a contrib thing; a lot of
the config makes sense to me (even if some of it is 'meh' for my
repository sizes or setup), but two of the config settings would be
very objectionable if they were a core git command.  Since it's
contrib, though, it's probably fine to be very opinionated...and
perhaps even excessively so.  ;-)

However, since Johannes has been away for a couple weeks, maybe give
him a chance to return and respond to myself and others (and perhaps
push any updates that occurred to him while on vacation) before
merging down?

> * en/remerge-diff (2021-08-31) 7 commits
>  - doc/diff-options: explain the new --remerge-diff option
>  - show, log: provide a --remerge-diff capability
>  - tmp-objdir: new API for creating and removing primary object dirs
>  - merge-ort: capture and print ll-merge warnings in our preferred fashion
>  - ll-merge: add API for capturing warnings in a strbuf instead of stderr
>  - merge-ort: add ability to record conflict messages in a file
>  - merge-ort: mark a few more conflict messages as omittable
>
>  A new presentation for two-parent merge "--remerge-diff" can be
>  used to show the difference between mechanical (and possibly
>  conflicted) merge results and the recorded resolution.
>
>  Will merge to 'next'?

It has been a month that it's been cooking with no issues brought up,
and it's been in production for nearly a year...

But just this morning I pinged peff and jrnieder if they might have
time to respectively look at the tmp-objdir stuff (patch 5, plus its
integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
(patch 3).  I don't know if either will have time to do it, but
perhaps wait half a week or so to see if they'll mention they have
time?  Otherwise, yeah, it's probably time to merge this down.

> * en/removing-untracked-fixes (2021-09-27) 12 commits
>  - Documentation: call out commands that nuke untracked files/directories
>  - Comment important codepaths regarding nuking untracked files/dirs
>  - unpack-trees: avoid nuking untracked dir in way of locally deleted file
>  - unpack-trees: avoid nuking untracked dir in way of unmerged file
>  - Change unpack_trees' 'reset' flag into an enum
>  - Remove ignored files by default when they are in the way
>  - unpack-trees: make dir an internal-only struct
>  - unpack-trees: introduce preserve_ignored to unpack_trees_options
>  - read-tree, merge-recursive: overwrite ignored files by default
>  - checkout, read-tree: fix leak of unpack_trees_options.dir
>  - t2500: add various tests for nuking untracked files
>  - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes
>
>  Various fixes in code paths that move untracked files away to make room.
>
>  Will merge to 'next'?

I just sent out v3 this morning with five new patches (included in
your list above).  While I think my patches are good, and I'd like to
see them merged down to next so I can send my
current-working-directory-deletion fixes that build on top of it, I'm
a little surprised you're proposing to merge this series down this
quickly instead of waiting a little longer for review of the new
patches.  I'm not complaining...but was that intentional?
