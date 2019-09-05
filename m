Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B371F461
	for <e@80x24.org>; Thu,  5 Sep 2019 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfIEVUt (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 17:20:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbfIEVUt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 17:20:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so4395902wrr.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=35dlMPdXMc9s1A/GuyCidIszPEjePLoMPoVDCwqC3Zc=;
        b=F2gJ49GkajABxeTOfypTb0gNQy9yMj7DfWwV2cbjtnPouVeQri2GFo799M245Gc4dS
         J94BVuZes2fB3KvsiakLSR2zO16Q1zHEHiUqqzZQgojqJMSQpsSaQQ6dp/e3kX6HXMx7
         sMuZ08WDs6A03IzO4WZYe3xmgQwJRs8hImqD86BoTVupwLzsb0FBhfYZZ24j84gK/pHL
         mssi1A4rdoyg2fbyk2BpCSw0TkAz/Z08YkbMOimUSW15J2EcqWPq9Rboy5BEF2nsFs/G
         L6rUiJzgB1cRRU3UpbHi29X8zAkyTsOtXkjaB+/eO2KzuYAaqZKTwMc/i/acYZKAFEVP
         CXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=35dlMPdXMc9s1A/GuyCidIszPEjePLoMPoVDCwqC3Zc=;
        b=G8seMUt7z2aLXZgwj5XreV9OoqR6yvAwS9G39GfXRNZAYZphqNGhSDRomI/uip+OZ0
         YsIr4KlFUCfk7EOCIpqPBg0a5AVMVhQbWczPn4HaZSNk7bHZUgCjIKRFujj6JqIE2Nlg
         ozuUQM89QvRYEQmwNbWuylaNjnjZILm3DKYBrnu942g0goi7shjsRAXaJmUZ3d+K0sBE
         tDwnAzkegcM49ZNXMUBcglZNz0tlQLDQHcF6t4o9xwwhb7hA+ovdlm0vv4x7w725pbDy
         dbhEdkUhI1Tc6Jsnk7pk2+Z0ZJlL1hB3D/Vx7sJq6AL6aXAYfjdLLgr/JFBokpzxCeR4
         PRrQ==
X-Gm-Message-State: APjAAAX8RcWjmHgtQpShyJjo+zsIqCtFtKqfGGG3kGoMMQQe0/busq19
        1I+DipMOlKPDBRGv0JLSIzo=
X-Google-Smtp-Source: APXvYqzrLosBWagoSSXlIQHTG9Oz6+lcTAc22U4zbKoIRloGMv6gmx+5WoaqigZBTHfz5NhgSYi5iA==
X-Received: by 2002:adf:f151:: with SMTP id y17mr4227545wro.244.1567718446629;
        Thu, 05 Sep 2019 14:20:46 -0700 (PDT)
Received: from szeder.dev (x4db65166.dyn.telefonica.de. [77.182.81.102])
        by smtp.gmail.com with ESMTPSA id g185sm7071587wme.10.2019.09.05.14.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 14:20:45 -0700 (PDT)
Date:   Thu, 5 Sep 2019 23:20:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH v2 10/12] clean: avoid removing untracked files in a
 nested git repository
Message-ID: <20190905212043.GC32087@szeder.dev>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
 <20190905154735.29784-1-newren@gmail.com>
 <20190905154735.29784-11-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905154735.29784-11-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 08:47:33AM -0700, Elijah Newren wrote:
> Users expect files in a nested git repository to be left alone unless
> sufficiently forced (with two -f's).  Unfortunately, in certain
> circumstances, git would delete both tracked (and possibly dirty) files
> and untracked files within a nested repository.  To explain how this
> happens, let's contrast a couple cases.  First, take the following
> example setup (which assumes we are already within a git repo):
> 
>    git init nested
>    cd nested
>    >tracked
>    git add tracked
>    git commit -m init
>    >untracked
>    cd ..
> 
> In this setup, everything works as expected; running 'git clean -fd'
> will result in fill_directory() returning the following paths:
>    nested/
>    nested/tracked
>    nested/untracked
> and then correct_untracked_entries() would notice this can be compressed
> to
>    nested/
> and then since "nested/" is a directory, we would call
> remove_dirs("nested/", ...), which would
> check is_nonbare_repository_dir() and then decide to skip it.
> 
> However, if someone also creates an ignored file:
>    >nested/ignored
> then running 'git clean -fd' would result in fill_directory() returning
> the same paths:
>    nested/
>    nested/tracked
>    nested/untracked
> but correct_untracked_entries() will notice that we had ignored entries
> under nested/ and thus simplify this list to
>    nested/tracked
>    nested/untracked
> Since these are not directories, we do not call remove_dirs() which was
> the only place that had the is_nonbare_repository_dir() safety check --
> resulting in us deleting both the untracked file and the tracked (and
> possibly dirty) file.
> 
> One possible fix for this issue would be walking the parent directories
> of each path and checking if they represent nonbare repositories, but
> that would be wasteful.  Even if we added caching of some sort, it's
> still a waste because we should have been able to check that "nested/"
> represented a nonbare repository before even descending into it in the
> first place.  Add a DIR_SKIP_NESTED_GIT flag to dir_struct.flags and use
> it to prevent fill_directory() and friends from descending into nested
> git repos.

> Finally, there is one somewhat related bug which this patch does not
> fix, coming from the opposite angle.  If the user runs
>    git clean -ffd
> to force deletion of untracked nested repositories, and within an
> untracked nested repo the user has ignored files (according to the inner
> OR outer repositories' .gitignore), then not only will those ignored
> files be left alone but the .git/ subdirectory of the nested repo will
> be left alone too.  I am not completely sure if this should be
> considered a bug (though it seems like it since the lack of the
> untracked file would result in the .git/ subdirectory being deleted),
> but in any event it is very minor compared to accidentally deleting user
> data and I did not dive into it.

We briefly mentioned this "ignored file in a nested repo fools 'git
clean -d'" issue in an unrelated thread as well, where Philip
suggested that the gitignore of the outer repository should not have
any effect on the nested repository.  I'm inclined to agree.

  https://public-inbox.org/git/e221aaf8-7d0b-6feb-3f58-1e9e4382939b@iee.email/

Now, 'git clean -X' is supposed to "Remove only files ignored by
Git.".  I'm not entirely sure what 'git clean -ffdX' is supposed to do
(or whether it makes any sense in the first place), but it does delete
files in the nested repository that are ignored only in the outer
repository, both tracked (and possibly dirty) and untracked, even with
this patch series.  Without this series '-fdX' is just as bad, but
with this patch (i.e. by not descending into nested repositories)
'-fdX' becomes sensible and leaves the nested repository alone.

> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 3ab749b921..ba31d8d166 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -37,9 +37,9 @@ OPTIONS
>  --force::
>  	If the Git configuration variable clean.requireForce is not set
>  	to false, 'git clean' will refuse to delete files or directories
> -	unless given -f or -i. Git will refuse to delete directories
> -	with .git sub directory or file unless a second -f
> -	is given.
> +	unless given -f or -i.  Git will refuse to modify untracked
> +	nested git repositories (directories with a .git subdirectory)
> +	unless a second -f is given.

I like this wording.

