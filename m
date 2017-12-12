Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD101F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdLLAwZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:52:25 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37828 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdLLAwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:52:24 -0500
Received: by mail-pg0-f44.google.com with SMTP id y6so12203324pgp.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 16:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=El4W9DmrUvF+AADuMGrMcV4/0hUnZjoFVW5QVBUqy2M=;
        b=VEyBwtbRVnhBpuZCsTdrfRqEh6H0T5cjEPKY9ibfodDPi2DmiuXCGts0mGw19kccCu
         1TMQ5Q9ozlDKT+qHrT/xhHpyIgwa0+f2+U9WvUoyKILY6JfSVBo3s8R5PQ0o1osVhhwR
         WLHGePrflOXkmV2017UKM8oIXmKM9gqgGu5MhVy+lNVYmdXV8PhCGPd2E9PipyPwjMAs
         jAip2WvUiPF1bvr0M1/Y3XXhTrO8Ot3n9DU+iDbf1U7pHIKrFNPHSH+5k0L2goziq5Vw
         el+y7JVyFbnMYoOqs6BsSibCYTt13RdPOihOT13/vQoNhC6Fn4TOSm6wuD1LBopHGOXe
         15xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=El4W9DmrUvF+AADuMGrMcV4/0hUnZjoFVW5QVBUqy2M=;
        b=fk1ycSJSb6/bm4QXcV22LBUN8+4CeWB+UxsBXA88TZLTeS/ldcnqFzd67/pK/7uymC
         Y1TjIAhIZGAlIwiwwZz6O3pduwDDIveh0T+09o+GiZ8hziWJrVbRwX93+Gdxqb3Zr8rD
         mbKdlQyreyvuks7aP4wAhbZcosbB4dtAKd0fH6i6ew1kmXdQMaT0ex4MxN3108t3pBPC
         osDeFDUSna9jatTkBftyB+cX+o69RD9UGR21VYrpz/mXRM0+EGyKF6kScSp4pLqE0l5o
         ElRGiDhYBHltEpwCMEHIcM/SkV90VYjMlUep7FmlZUQKru5zRtyapepImMd+p/QsslX9
         jGBQ==
X-Gm-Message-State: AKGB3mKlwq/s6n7YbgDG3ZIe29D4cuBvYOFaBM8B84O5JiLHJqMIrUhr
        NpYfT4ggUBeryy3l+NVePwFFmQ==
X-Google-Smtp-Source: ACJfBosqdtixQ9EDZ5iwzbEPjvSF64knJjsduOeBYfJ9fc9obkWMpc5H5tjK0q3qAhcIVJ/K+jl9vA==
X-Received: by 10.101.92.138 with SMTP id a10mr380781pgt.6.1513039943653;
        Mon, 11 Dec 2017 16:52:23 -0800 (PST)
Received: from google.com ([2620:0:100e:422:bdc4:e5a2:2ef4:d600])
        by smtp.gmail.com with ESMTPSA id e26sm24607451pfi.10.2017.12.11.16.52.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 16:52:22 -0800 (PST)
Date:   Mon, 11 Dec 2017 16:52:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] clone: support 'clone --shared' from a worktree
Message-ID: <20171212005221.GD177995@google.com>
References: <20171211231612.29275-1-sunshine@sunshineco.com>
 <20171212001802.GC177995@google.com>
 <CAPig+cSTsuHdAqdBMvO80ybTSzfxncX8yQODSKd1bmaoNRQOjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSTsuHdAqdBMvO80ybTSzfxncX8yQODSKd1bmaoNRQOjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, Eric Sunshine wrote:
> On Mon, Dec 11, 2017 at 7:18 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/11, Eric Sunshine wrote:
> >>               struct strbuf alt = STRBUF_INIT;
> >> -             strbuf_addf(&alt, "%s/objects", src_repo);
> >> +             get_common_dir(&alt, src_repo);
> >> +             strbuf_addstr(&alt, "/objects");
> >
> > If you wanted to do this in one function call you could either use
> > 'strbuf_git_common_path()' or either 'strbuf_git_path()' or
> > 'strbuf_repo_git_path()' which will do the proper path adjustments when
> > working on a path which should be shared between worktrees (i.e. part of
> > the common git dir).
> 
> Thanks for the pointers, however, the above fix mirrors the fix made
> by 744e469755 (clone: allow --local from a linked checkout,
> 2015-09-28) to code immediately below it in the 'else' arm:
> 
>     get_common_dir(&src, src_repo);
>     get_common_dir(&dest, dest_repo);
>     strbuf_addstr(&src, "/objects");
>     strbuf_addstr(&dest, "/objects");
> 
> It would be poor form and confusing to use one of the mechanisms you
> suggest while leaving the 'else' arm untouched.
> 
> Re-working both arms of the 'if' to use one of the suggested functions
> would make a fine follow-on or preparatory patch, however, I'd rather
> not hold up this fix merely to re-roll for such a minor cleanup. (I
> also considered a follow-on patch to reduce the duplication between
> the two cases but decided against it, for the present, since such a
> patch would almost be noise without much gain.)

I didn't look close enough at what you were trying to fix, you're right
I think what you have here is good as the alternative would require a
lot more reworking I think (at least to change the above part too).

Either way though, I'm a little worried about what happens if you have
GIT_COMMON_DIR set because then both the src and dest repo would share a
common dir, I don't know if that is expected or not.  Maybe something
else to consider later.

> 
> By the way, is there any documentation explaining the differences
> between all these similar functions and when one should be used over
> the others?

I wish, I probably should have done a better job documenting it all in
path.h when I added the repo_* flavor of functions.  I'll add that to my
list of things to do though :)

-- 
Brandon Williams
