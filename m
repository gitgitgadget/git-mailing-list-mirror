Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED6C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D717206FA
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh2fzicS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCLQdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:33:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40215 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgCLQdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 12:33:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id y71so6087175oia.7
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVFfeW/BAIK3C/hyXJKMAh1Orake+dO76ocGO1WBI2Y=;
        b=Jh2fzicSIzkCVpvyoavqaEAv8fZ2DbLeGf2Jrq/HT0aogKOaHCUFVlW/ug1ldX/lsE
         kFQK6C6GZ38Vf5GaxftXJv7/b8fwR3o7T2MiBTY90m6iWsK4TKGmgxdJowk22ZObR/0X
         ut58zAED6vscYIouxuKnnr6jmDVTu8TpZY8FM3ONIQx+tB+2vW+2+XjHfZZMOPqizu4W
         v9Y/3/skSpXYjMT7wYdXwU86rmd1S+IMlTpHar5XLs9suWfUdoAHaENfRerJYo+IHmlT
         CG6+JbNrawaQ0Lo5Rfl+1FiuSianfT01xCzao0UbgFhnYZkVmZpPukT0dQiXpd6pqfn8
         r0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVFfeW/BAIK3C/hyXJKMAh1Orake+dO76ocGO1WBI2Y=;
        b=aecUWCIUcLolqsQjDBcYQflbHnuQDgZPs8anfPF4tppcmoW3pX32GjRWG4NQvdcBvB
         hEjwjNINUOMzwFdbZucUh3syiyQfciTvyWIZEByr6IwbkTEDvscQMjzUjMSlgt7Fcdp/
         nrhAGkOWe2qoGZWCnPf5CQWZsWVNUFiN9TxZaVMvNHWPpbewaJfK+p2mVTvdb2hSPcR2
         fBG9ncfNLGLnVNTqBDGx79vtOZ19jfCzYCwclBsWTUqT3+qzKN8xqo2rmgDyo1OccgOa
         oujOJjK7Yo7Ed6tZ1AvVMgZ+Ul8lydjb/j1zWpNtNKaEqhU7OGAmO6BaxdYn7y5Q+YdZ
         kW6Q==
X-Gm-Message-State: ANhLgQ2u5Sw7JxqxCsZpTmxsO4iKbD3ubrI/0uRjJUQvJYxMRGMRwHkX
        q/P8pdwYZLBT6fH0aCgX9ZbQ8mEv7GkO0hDJkeTfSwbu
X-Google-Smtp-Source: ADFU+vvaodPCIpenPwaIL6jjacjsA1dyOTh/YQ+f9CPSS6x1CvJTNW929fhdNpsWcBOlgx2j4BIYPU7tbcCGA/xbFi0=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr3318201oig.39.1584030793634;
 Thu, 12 Mar 2020 09:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com> <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
In-Reply-To: <20200312151318.GM212281@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Mar 2020 09:33:02 -0700
Message-ID: <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 8:13 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Sat, Feb 15, 2020 at 09:36:41PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Two related changes, with separate rationale for each:
> >
> > Rename the 'interactive' backend to 'merge' because:
> >   * 'interactive' as a name caused confusion; this backend has been used
> >     for many kinds of non-interactive rebases, and will probably be used
> >     in the future for more non-interactive rebases than interactive ones
> >     given that we are making it the default.
> >   * 'interactive' is not the underlying strategy; merging is.
> >   * the directory where state is stored is not called
> >     .git/rebase-interactive but .git/rebase-merge.
> >
> > Rename the 'am' backend to 'apply' because:
> >   * Few users are familiar with git-am as a reference point.
> >   * Related to the above, the name 'am' makes sentences in the
> >     documentation harder for users to read and comprehend (they may read
> >     it as the verb from "I am"); avoiding this difficult places a large
> >     burden on anyone writing documentation about this backend to be very
> >     careful with quoting and sentence structure and often forces
> >     annoying redundancy to try to avoid such problems.
> >   * Users stumble over pronunciation ("am" as in "I am a person not a
> >     backend" or "am" as in "the first and thirteenth letters in the
> >     alphabet in order are "A-M"); this may drive confusion when one user
> >     tries to explain to another what they are doing.
> >   * While "am" is the tool driving this backend, the tool driving git-am
> >     is git-apply, and since we are driving towards lower-level tools
> >     for the naming of the merge backend we may as well do so here too.
> >   * The directory where state is stored has never been called
> >     .git/rebase-am, it was always called .git/rebase-apply.
> >
> > For all the reasons listed above:
> >   * Modify the documentation to refer to the backends with the new names
> >   * Provide a brief note in the documentation connecting the new names
> >     to the old names in case users run across the old names anywhere
> >     (e.g. in old release notes or older versions of the documentation)
> >   * Change the (new) --am command line flag to --apply
> >   * Rename some enums, variables, and functions to reinforce the new
> >     backend names for us as well.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Hi,
>
> This broke quite a few upstream users for us today when we rolled out a
> next with this patch added on top. To shim around the post-commit hook
> issue, we had set a system config for all our users to use
> merge.backend=am; the machinery is pretty intolerant to a wrongly
> configured backend name (die() rather than a warning and fallback).
>
> Would it make more sense to deal with an unrecognized backend by falling
> back to the default backend, instead?
>
> >       if (options.type == REBASE_UNSPECIFIED) {
> >               if (!strcmp(options.default_backend, "merge"))
> > -                     imply_interactive(&options, "--merge");
> > -             else if (!strcmp(options.default_backend, "am"))
> > -                     options.type = REBASE_AM;
> > +                     imply_merge(&options, "--merge");
> > +             else if (!strcmp(options.default_backend, "apply"))
> > +                     options.type = REBASE_APPLY;
> >               else
> >                       die(_("Unknown rebase backend: %s"),
> >                           options.default_backend);
>
> At the very least, can this die() explain that it found that string in
> the config so the user can have a guess as to how to fix it?
>
> (I realize the complained code is from earlier in the series, but this
> patch - renaming something that used to be valid without a fallback -
> invalidated our configs, highlighting the problem for us. So I'm
> replying here instead.)

Sorry for the pain.  The earlier part of the series had only ever made
it to next, and was reverted there, and thus, in my thinking, in the
new cycle no one would have ever seen the intermediate state.  (Oops,
I forgot about cases where people tried out next towards the end of
last cycle before it was reverted and decided to set config based upon
it.)

I'm a little worried about ignoring the setting and just picking one;
if the setting has been marked and they set it to e.g. "appply" (one
too many p's), then does it really make sense to just show a warning
but continue using the backend they didn't want, especially since they
may miss the warning among the rest of the output?  I'd rather go the
route of improving the message, perhaps:
        _("Unknown rebase.backend config setting: %s")
Would that work for you?

Also, I thought that you and Jonathan were going to be changing the
post-commit hook handling[1][2].  Does this mean that you've punted on
that, and I need to make some kind of change here to get you to switch
over?

Elijah

[1] https://lore.kernel.org/git/pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/CABPp-BHONuRyt8VJqRuoCF2rGYZ5EhH9KJXQZ3NO69rYwA5J3g@mail.gmail.com/
