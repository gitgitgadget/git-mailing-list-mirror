Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E409B1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbdGaUuI (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:50:08 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33767 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdGaUuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:50:06 -0400
Received: by mail-pf0-f176.google.com with SMTP id d67so57524172pfc.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6YeNHR/IqdZJ4DRwzzrB+ZQ3ioK5GVWhCmjxAYvOm8=;
        b=eYmbFOvxQY+zH2o9fxS/LjbstY/qxDIhJAAxhMd05/O/gTL5SPmq0zeLUln4BU/hnt
         81TuBR622YWBJonOQ5RsnlCFwOpr+FUy97JIgUZRsaovC1UVdFrt3/UrI+Za6BihGP8c
         toNTR4iNy/WnUH1t9co879ovI4T5213XBBdAvJyOJVukFBUho1z69v/8LAsAXWckPw2G
         XwecIL539SGZfzyA/c+rfAdEgaeqaScmNVz4ixhF0qoR7YnF1N31Ah0/MSpF0OAnPgsi
         2HyLhD9mWmf6D7NX45ZIGVOFtz1Kdz963eDLD1etcMxKLW4nhJV5i6pV0HFBgi5a2AHt
         WhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6YeNHR/IqdZJ4DRwzzrB+ZQ3ioK5GVWhCmjxAYvOm8=;
        b=h8R2r/bI0nrxlaq9qyWN1eBZ7FzUEZSLoI6iR0bbTmSRZln5Z6mqq6/UZF/ZYbsd8n
         UIK6+EaFf5vAEYHX2MFRzy+WaDLtlUmUesNqBhXNv5q+8NP6cajvBzgLIXB4Fyz0RoN/
         8BXqi9TjXyRZ7/D27YAS1Yiv1dXrklHskycj4QD5puiyH8lkht+lq2+fexL9GY0MuRRz
         7GijMJGAlQoPCI2j5FFKCtdBZ22GJQGAzhdIi69eXcM0Q5kYxeh15G61cAd3Z9JdUhpp
         Oo1vlwXWIoSlPC5cGK3mItGHkoHgbgLbMiXzDvvLeniTalSDaqLU9fYI7c/MTqJVHw9Z
         F4Uw==
X-Gm-Message-State: AIVw110x9guSbGnrT29eYEaEYaCLFEMLFUTZTnXdoXmaAZOT+18EG25w
        I3r8fFyiggpU9oAX
X-Received: by 10.98.196.136 with SMTP id h8mr17033862pfk.295.1501534205930;
        Mon, 31 Jul 2017 13:50:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:e129:2029:93fa:b589])
        by smtp.gmail.com with ESMTPSA id t70sm55219721pfk.111.2017.07.31.13.50.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:50:04 -0700 (PDT)
Date:   Mon, 31 Jul 2017 13:50:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/15] add, reset: ensure submodules can be added or reset
Message-ID: <20170731205003.GB181489@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-4-bmwill@google.com>
 <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
 <xmqqinieq49v.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinieq49v.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/26, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> >> Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
> >> diff and status) ...
> >
> > introduced in 2010, so quite widely spread.
> >
> >> ...  introduced the ignore configuration option for
> >> submodules so that configured submodules could be omitted from the
> >> status and diff commands.  Because this flag is respected in the diff
> >> machinery it has the unintended consequence of potentially prohibiting
> >> users from adding or resetting a submodule, even when a path to the
> >> submodule is explicitly given.
> >>
> >> Ensure that submodules can be added or set, even if they are configured
> >> to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` diff
> >> flag.
> >>
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >> ---
> >>  builtin/add.c   | 1 +
> >>  builtin/reset.c | 1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> diff --git a/builtin/add.c b/builtin/add.c
> >> index e888fb8c5..6f271512f 100644
> >> --- a/builtin/add.c
> >> +++ b/builtin/add.c
> >> @@ -116,6 +116,7 @@ int add_files_to_cache(const char *prefix,
> >>         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> >>         rev.diffopt.format_callback = update_callback;
> >>         rev.diffopt.format_callback_data = &data;
> >> +       rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> >
> >
> > This flag occurs once in the code base, with the comment:
> >     /*
> >      * Unless the user did explicitly request a submodule
> >      * ignore mode by passing a command line option we do
> >      * not ignore any changed submodule SHA-1s when
> >      * comparing index and parent, no matter what is
> >      * configured. Otherwise we won't commit any
> >      * submodules which were manually staged, which would
> >      * be really confusing.
> >      */
> >     int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> >
> > in prepare_commit, so commit ignores the .gitmodules file.
> >
> > This allows git-add to add ignored submodules, currently ignored submodules
> > would have to be added using the plumbing
> >     git update-index --add --cacheinfo 160000,$SHA1,<gitlink>
> 
> Let me play devil's advocate (as I have this suspicion that .ignore
> thing specific for submodule is probably misdesigned and certainly
> its implementation is backwards).  Is the primary use case for this
> .ignore thing to be able to do
> 
> 	git add .
> 
> without having to worry about adding the submodule marked as such?  
> And if so, wouldn't it surprise these users who do use .ignore if
> "git add" suddenly started adding them?
> 
> I think the right tool to use these days for excluding some paths
> when adding all others is the negative pathspec; perhaps back when
> the .ignore thing was added, it didn't exist or not widely known?  
> 
> I suspect that it may result in a better system overall if we can
> deprecate and remove the submodule-specific .ignore thing.  At
> least, I think the DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG is backwards
> in that .ignore causes a submodule to be excluded from the diff by
> default and forces paths that care about differences to opt into the
> "override" thing, which is wrong---the specific UI thing that wants
> not to show them should instead opt into ignoring, while keeping the
> default not to special case such a flag that can only be set to a
> submodule path.

It looks like .ignore was added with aee9c7d65 (Submodules: Add the new
"ignore" config option for diff and status, 2010-08-06) in order to
ignore particular submodules with 'status' and 'diff' commands.  I don't
think it was intended to ignore submodules with commands like add and
reset.  Either way I agree that some of the things with most of the
submodules config seem a bit backwards and we may want to migrate away
from them completely as we begin to add more support for submodules into
the builtin commands.

> 
> > This makes sense, though a test demonstrating the change in behavior
> > would be nice, but git-add doesn't seem to change as it doesn't even load
> > the git modules config?
> >
> >>         rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
> >>         run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
> >>         return !!data.add_errors;
> >> diff --git a/builtin/reset.c b/builtin/reset.c
> >> index 046403ed6..772d078b8 100644
> >> --- a/builtin/reset.c
> >> +++ b/builtin/reset.c
> >> @@ -156,6 +156,7 @@ static int read_from_tree(const struct pathspec *pathspec,
> >>         opt.output_format = DIFF_FORMAT_CALLBACK;
> >>         opt.format_callback = update_index_from_diff;
> >>         opt.format_callback_data = &intent_to_add;
> >> +       opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> >
> > same here? Also as this is not failing any test, it may be worth adding one
> > to document the behavior of the "submodule.<name>.ignore" flag in tests?
> >
> >>
> >>         if (do_diff_cache(tree_oid, &opt))
> >>                 return 1;
> >> --
> >> 2.14.0.rc0.400.g1c36432dff-goog
> >>

-- 
Brandon Williams
