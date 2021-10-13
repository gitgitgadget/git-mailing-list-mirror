Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BAEC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B3D6117A
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhJMTjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhJMTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:39:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668AC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:37:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e65so925654pgc.5
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0X6UvDzBnueC5W92RkubzNE9m34yGiEpdHuH1knHYqM=;
        b=a6YIHGImH8EeOp5duhPq8VgA8Z9LbscrV4G3AZYx0TYOrH79v69tzTOWekCIAVxhnd
         8fjS6ubkg8Yl7fAT9NGJ6Hfgyr62Q9R0XSf/AcnCx7/0AxOuoZ//IbFBahPknRD6VSXt
         4kH9+WXoMnYvytYOeab9WHUd5ZxceFVZ1tLtr2MuXFC2BBVLTaYnfXRXEcVXMz7P4jkT
         TZ+fC3sisOS5iqaavBssnGVrcRcmYyjKhPdiegE3VXEk8HusB+XU4h7TV3esZjsDTmTH
         nAWNt6jjzDo4uh4ZC5VELE5POwPPPoRGPvuM5AbUuE3WJCr1mgqXH1ziq5vZbtiCUK3n
         g9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0X6UvDzBnueC5W92RkubzNE9m34yGiEpdHuH1knHYqM=;
        b=E/InDBNNfSbckIvjm8m2P8beunlLiVRyBhZHYnxaa9H1pmgiMCNyYPP2JWXQE2Ootq
         zof2YHXDBDSk0E14Nhnx2E0EzHgSRXTNfBydVWVyH6Kpt0b0In0WJpiChjB3ro7rgHHX
         TylgjfXu24fyMYe6+Tbuv+sRpGa87LrOYeg/hx2tkE7YXZ4mtJYiNYFSI/4SsMkPLmj7
         0zoccLAZEGDzBXI8BZy026g08peeCg6KOOSdmPLJgUQOTMnWuIVsrRH3lgBE4qMg3JjR
         0G7K0FHY2NCL+9IX36ZUE8RFfx6IwDjyhck0hSUkOkPWemnXSCKmKgf0yLD7V8KrvAYm
         qcAA==
X-Gm-Message-State: AOAM531j8AAGLuHD+V/poHMZNgjonmB0m9A4bUatM2LQ4Hph5iPpnbs+
        nJeRdsCMdI7B2L8ETg0bmOfhbQ==
X-Google-Smtp-Source: ABdhPJz2i5V7osg8LaAR4f+kcdgl0gx7bTonm19vdrpVTZ0pxPu95SH4fh2RohZTKiekdz0BY6PBrQ==
X-Received: by 2002:a63:7e05:: with SMTP id z5mr873718pgc.354.1634153818692;
        Wed, 13 Oct 2021 12:36:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3db2:597e:d036:ff3f])
        by smtp.gmail.com with ESMTPSA id j6sm311279pgq.0.2021.10.13.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:36:58 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:36:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] introduce submodule.superprojectGitDir record
Message-ID: <YWc1VJgWymoPado9@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-3-emilyshaffer@google.com>
 <9fecf160-9646-7e56-478c-aa5f8defa6a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fecf160-9646-7e56-478c-aa5f8defa6a9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 19, 2021 at 08:38:19PM -0400, Derrick Stolee wrote:
> 
> On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> ...
> > +submodule.superprojectGitDir::
> > +	The relative path from the submodule's worktree to its superproject's
> > +	gitdir. When Git is run in a repository, it usually makes no difference
> > +	whether this repository is standalone or a submodule, but if this
> > +	configuration variable is present, additional behavior may be possible,
> > +	such as "git status" printing additional information about this
> > +	submodule's status with respect to its superproject. This config should
> > +	only be present in projects which are submodules, but is not guaranteed
> > +	to be present in every submodule, so only optional value-added behavior
> > +	should be linked to it. It is set automatically during
> > +	submodule creation.
> > ++
> > +	Because of this configuration variable, it is forbidden to use the
> > +	same submodule worktree shared by multiple superprojects.
> 
> nit: this paragraph linked with the "+" line should have no tabbing.

Done.

> 
> Also, could we use the same submodule worktree for multiple superprojects
> _before_ this configuration variable? That seems wild to me. Or, is that
> not a new requirement?

I guess it'd be possible to do something pretty evil with symlinks? I'm
not sure why you would want to, though.

But now that I think about it more, I'm not sure that it would work, at
least if we understand submodule to mean "...and the gitdir lives in
.git/modules/ of the superproject".

If superA contains sub and superB contains a symlink to 'sub''s
worktree in superA, then wouldn't superA and superB both be trying to
contain their own gitdirs for sub? And having multiple gitdirs for a
worktree is an unacceptable state anyway.

Or maybe the issue is more like: you have super, which contains sub, and
you have super-wt, which is a worktree of super; to avoid duplicating
sub, you decided to use a symlink. So there's only one sub gitdir, and
only one super gitdir. It's a little awkward, but since submodule
worktrees aren't currently supported, I can see the appeal. In this
configuration, a path from submodule *worktree* to superproject gitdir,
which is what v3 and earlier propose, would be broken in one
superproject worktree or the other And having multiple gitdirs for a
worktree is an unacceptable state anyway.

Or maybe the issue is more like: you have super, which contains sub, and
you have super-wt, which is a worktree of super; to avoid duplicating
sub, you decided to use a symlink. So there's only one sub gitdir, and
only one super gitdir. It's a little awkward, but since submodule
worktrees aren't currently supported, I can see the appeal. In this
configuration, a path from submodule *worktree* to superproject gitdir,
which is what v3 and earlier propose, would be broken in one
superproject worktree or the other. But as I'm proposing in v4, folks in
the review club pointed out to me that a pointer from gitdir to gitdir
makes more sense - and that would fix this concern, too, because sub and
the symlink of sub would both share a single gitdir, and that gitdir
would point to the single gitdir of super and super-wt.

All a long way to say: I think v4 will fix it by originating the
relative path from submodule gitdir, instead. And I will remove the
extra paragraph - I think it is just adding confusion around a case that
nobody would really want to use...

> 
> Perhaps you mean something like this instead:
> 
> 	It is forbidden to use the same submodule worktree for multiple
> 	superprojects, so this configuration variable stores the unique
> 	superproject and is not multi-valued.
> 
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index d55f6262e9..d60fcd2c7d 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> >  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
> >  					   error_strategy);
> >  
> > +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> > +			       relative_path(absolute_path(get_git_dir()),
> > +					     path, &sb));
> > +
> 
> I see that all new submodules will have this configuration set. But we will
> also live in a world where some existing submodules do not have this variable
> set. I'll look elsewhere for compatibility checks.

Yep, the series intended to add them piecemeal where possible, over the
course of a handful of commits.

> 
> >  inspect() {
> > -	dir=$1 &&
> > -
> > -	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> > -	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> > -	git -C "$dir" rev-parse HEAD >head-sha1 &&
> > -	git -C "$dir" update-index --refresh &&
> > -	git -C "$dir" diff-files --exit-code &&
> > -	git -C "$dir" clean -n -d -x >untracked
> > +	sub_dir=$1 &&
> > +	super_dir=$2 &&
> > +
> > +	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> > +	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
> > +	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
> > +	git -C "$sub_dir" update-index --refresh &&
> > +	git -C "$sub_dir" diff-files --exit-code &&
> > +	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
> > +	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
> > +		-ef "$sub_dir/$cached_super_dir" ] &&
> > +	git -C "$sub_dir" clean -n -d -x >untracked
> 
> You rewrote this test in the previous patch, and now every line is changed
> because you renamed 'dir' to 'sub_dir'. Could the previous patch use
> 'sub_dir' from the start so this change only shows the new lines instead of
> many edited lines?

Sure.

> 
> >  }
> >  
> >  test_expect_success 'submodule add' '
> > @@ -138,7 +142,7 @@ test_expect_success 'submodule add' '
> >  	) &&
> >  
> >  	rm -f heads head untracked &&
> > -	inspect addtest/submod &&
> > +	inspect addtest/submod addtest &&
> 
> Similarly, I would not be upset to see these lines be changed just the
> once, even if the second argument is ignored for a single commit. But
> this nitpick is definitely less important since I could see taste
> swaying things either way.

I feel less interested in that nit; I think a mechanical "strip the
useless arg" change + a mechanical "add an unrelated useful arg" change
is easier to review than doing both at once.

 - Emily
