Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDCBC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBF363225
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhKPSYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbhKPSXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:23:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6067AC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:20:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 200so18406060pga.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE0NOQn7n1Nd7/FJkCNP6fSsDlU3DkVtr7pM4BCzI/Y=;
        b=bBOmXzdY6WLU6Jz33Ue0MCAwFuS8WGNb3gIzWgyXuwiz+7sFMyLrPxu3jsqSJ5qG0/
         fLepnG385dxka89MGKrqVgrTvZAo89CJjKZWrnLETwYCfdXwDycHOC1ngns6dlwZCODC
         VhvSv8uK8YXljsykTbFk5RKrQ/EVBT9pXKseyR2vRCdzMjDYgTa0MneLWJFHFtMd0BE5
         zwhlEZgOy0BS62T2gKX/1KuD1nYG9fJflXtD1vMYfaNLbousYo28vPIhxY+ZBIWvmnUl
         wdy1HRRd5EEQEAMlfHoslEYY39KjNKc53C1jwgCjHe6w2F0EcLblxHIQrRNd3BVdbv2n
         /uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE0NOQn7n1Nd7/FJkCNP6fSsDlU3DkVtr7pM4BCzI/Y=;
        b=sk1FblgLQY1rdwKm9le9CKTMCO6hTkFfA4w0oRePRJNo5E180xeJSd7AXydiwC0Wac
         OkmB7Pb3Kfvluq04nW+eHhPEhRKtoPIv0paPKnrDruXYoP/2YYcL8B8K3w3lSzGEcHBU
         U/ut0uWPlFG/MEw9c27wFZg3OZx1e/XpFBkY81LTZippgNkT+YFevSeTExHP4hzC3TDs
         XsOjWFymPNT/0nIZbS+orivvbYtboCDRnUguKQWIG4QzSOImn/MkSHQJLsMs7XOFoy4M
         uReZZgCGF40Fn1sKhohz8HCLB5Y2oLom+A6tjocPC8G/opmsfGn3NjdvGCAgodl65Dro
         vgvg==
X-Gm-Message-State: AOAM5304ZvMxT6b8UrGf8Cz3b2HMMulOBEBLtDoRPGFYuRRS1TYMJDCN
        iwJlnKQcWd59T14j887dHFTGVHJP+oEq2QAXk84=
X-Google-Smtp-Source: ABdhPJxloeL7IULSICGUBYqm2YolZNHUEhYS5dUqghthF5ta5OB0wY7fNvxYBPsvoJp6zFpe2t9I+P6hXBaKBNxtTiI=
X-Received: by 2002:a63:924c:: with SMTP id s12mr696896pgn.416.1637086857777;
 Tue, 16 Nov 2021 10:20:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1078.v5.git.git.1633521772731.gitgitgadget@gmail.com>
 <pull.1078.v6.git.git.1633523057369.gitgitgadget@gmail.com> <xmqqwnmopqqk.fsf@gitster.g>
In-Reply-To: <xmqqwnmopqqk.fsf@gitster.g>
From:   Mugdha Pattnaik <mugdhapattnaik@gmail.com>
Date:   Tue, 16 Nov 2021 23:50:45 +0530
Message-ID: <CAA4dvxgNJ8eyuc5B6_GnSLHMWjdbJN5k_rTCLjWndEyjv_vOnw@mail.gmail.com>
Subject: Re: [PATCH v6] submodule: absorb git dir instead of dying on deinit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mugdha Pattnaik via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the late reply, I got caught up with other commitments.

> On Fri, Oct 8, 2021 at 1:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Mugdha Pattnaik via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: mugdha <mugdhapattnaik@gmail.com>
>
> This line is called "in-body header" that is used to override the
> author name that is automatically obtained from the e-mail's "From:"
> header (which is set to "Mugdha Pattnaik via GitGitGadget" by GGG,
> which is obviously not your name, hence we use an in-body header to
> override it).  It should match what you use to sign off your patches,
> the one we see below.
>
> I'll hand-edit so that "git show" will say that the author is
> "Mugdha Pattnaik", not "mugdha", while applying, but please make
> sure your further submissions will not have this problem.

Okay, I will keep this in mind for future patches.


> > Currently, running 'git submodule deinit' on repos where the
> > submodule's '.git' is a directory, aborts with a message that is not
> > exactly user friendly. Let's change this to instead warn the user
> > to rerun the command with '--force'.
>
> OK.  That sounds like an improvement, albeit possibly an overly
> cautious one, as a casual "deinit" user will get an error as before
> without "--force", which may or may not be a good thing.  Requiring
> "--force" means it is safer by default by not changing the on-disk
> data.  But requiring "--force" also means we end up training users
> to say "--force" when it shouldn't have to be.
>
> A plausible alternative is to always absorb but with a warning "we
> absorbed it for you", without requiring "--force".  If we didn't
> have "git submodule deinit" command now and were designing it from
> scratch, would we design it to fail because the submodule's git
> directory is not absorbed?  I doubt it, as I do not think of a good
> reason to do so offhand.

Okay, I understand now. I'll remove the condition that checks for "--force"
and will go ahead with absorbing the gitdir after displaying the suggested
warning message. Currently I suppress the warnings when the "--quiet"
flag is set; I think I will continue to do that, even after implementing the
above change. Do let me know if I should be doing otherwise.


> Does "git submodule" currently reject a "deinit" request due to some
> _other_ conditions or safety concerns and require the "--force"
> option to continue?  Requiring the "--force" option to resolve ".git
> is a directory, and the user wants to make it absorbed" means that
> the user will be _forced_ to bypass these _other_ safety valves only
> to save the submodule repository from destruction when running
> "deinit", which may not be a good trade-off between the safety
> requirements of these _other_ conditions, if exists, and the one we
> are dealing with.

This is definitely a situation we want to avoid. How about we try to run
a check for uncommitted local modifications first? If these are present,
then deinit can die with a warning. In case there are no uncommitted
local modifications, deinit can go ahead and absorb the gitdir and do the
rest.

The existing submodule--helper.c file already has a check for this, but it
seems to be doing it below the check for absorption. I can try to switch it
around to see how that works.


> > This internally calls 'absorb_git_dir_into_superproject()', which
> > moves the git dir into the superproject and replaces it with
> > a '.git' file. The rest of the deinit function can operate as it
> > already does with new-style submodules.
>
> This is not wrong per-se, but such an implementation detail is
> something best left for the patch.
>
> > We also edit a test case such that it matches the new behaviour of
> > deinit.
>
> "match the new behaviour" in what way?
>
>     In one test, we used to require "git submodule deinit" to fail
>     even with the "--force" option when the submodule's .git/
>     directory is not absorbed.  Adjust it to expect the operation to
>     pass.
>
> would be a description at the right level of detail, I think.

Noted. I'll apply the above changes.


> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index ef2776a9e45..040b26f149d 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1539,16 +1539,24 @@ static void deinit_submodule(const char *path, const char *prefix,
> >               struct strbuf sb_rm = STRBUF_INIT;
> >               const char *format;
> >
> > -             /*
> > -              * protect submodules containing a .git directory
> > -              * NEEDSWORK: instead of dying, automatically call
> > -              * absorbgitdirs and (possibly) warn.
> > -              */
> > -             if (is_directory(sub_git_dir))
> > -                     die(_("Submodule work tree '%s' contains a .git "
> > -                           "directory (use 'rm -rf' if you really want "
> > -                           "to remove it including all of its history)"),
> > -                         displaypath);
> > +             if (is_directory(sub_git_dir)) {
> > +                     if (!(flags & OPT_FORCE))
> > +                             die(_("Submodule work tree '%s' contains a "
> > +                                   ".git directory.\nUse --force if you want "
> > +                                   "to move its contents to superproject's "
> > +                                   "module directory and convert .git to a file "
> > +                                   "and then proceed with deinit."),
> > +                                 displaypath);
> > +
> > +                     if (!(flags & OPT_QUIET))
> > +                             warning(_("Submodule work tree '%s' contains a .git "
> > +                                       "directory. This will be replaced with a "
> > +                                       ".git file by using absorbgitdirs."),
> > +                                     displaypath);
> > +
> > +                     absorb_git_dir_into_superproject(displaypath, flags);
>
> Shouldn't the first argument to this call be "path" not
> "displaypath"?  The paths in messages may want to have the path from
> the top to the submodule location prefixed for human consumption,
> but the called function only cares about the path to the submodule
> from the current directory, no?

Yes that makes sense, path is the better argument to pass.


> The second parameter of this call seems totally bogus to me.  What
> is the vocabulary of bits the called function takes?  Is that from
> the same set the flags this function takes?  Does the called
> function even understand OPT_QUIET, or does the bitpattern that
> happens to correspond to OPT_QUIET have a totally different meaning
> to the called function and we will trigger a behaviour that this
> caller does not expect at all?

I realised I was passing the wrong flags. On investigating further, the
flags in submodule.c do have different semantics. I also noticed that it
checks for recursive submodule absorption. I believe I should just be
passing the recursive flag to the function that absorbs gitdir. This way,
nested old-style gitdirs will also be handled.

I intend to incorporate these changes by the end of the week.

Thanks

--
Mugdha
