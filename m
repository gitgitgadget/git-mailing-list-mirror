Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A1C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiCaTfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiCaTfK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:35:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481A2A3
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:33:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso390758pjb.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z3Qcp/1jjCuS07JoY7Hz4+Uf68XuaYoTkU8hxS2wMuk=;
        b=EeGdZBTi4+G+kXY3PiXFmCINPPWB7D0ejq8oHXkaFcWBSTdYlzXxgA6dxFUvgAmkvK
         vz9nO1/x7toGgkg6ZSn7qMIRKQIjylIA9+Xrbl5gU2v9o6L5ZlpOLzgpuY32Rs7TX/YE
         M+gNmEWrm+dWvlXZq2+iZdiZoeS/EXsYKKDP4Qsl7ZVIuZUPrHFwJwa5YG9j68bnUju0
         XqLZcSIw1LH+kOBBH61GrHaAF6+MMITbI/n9BfM+ZXchdE+nk/RjoDJ4bA4xdA7TMSh/
         y48QBly7/y7RN8v9F4/Z2XxLP5pI2hKyBwoc6+zlS2ZJYDJq3jGFSx0x+IQcZcLDi+7N
         xpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z3Qcp/1jjCuS07JoY7Hz4+Uf68XuaYoTkU8hxS2wMuk=;
        b=Ezm3cdW1o277NAE1K2jGiPPJ9a9IeKReHZi46tt7bH2LvNf0F4mwKsLkO/LYf44NwK
         vkXazBG+ooR5fsBLxKyw7KRcJMoLo2IOuufN+4YlP8caT9PqSZ4F58afxJUWXzN02k6g
         HX4cSXD56JX+rANHlZ4uG708W2TvGzXEgmy3wVF/SlWYmV9OT4KLl6EsEb2UboI2bQqM
         HnPew1CVfVy8ESIkyveOyXdUUl92odNc5K1P0ATRJ03FYDMBNHjTsyVlxIm+n6llBVNb
         Mu0QJLQzvLpil/LOdIbtULMEdfN6QtNcdoXjl4dWWRGKipP3AuYdfmcMYuAZaZ2EWfJr
         MCPw==
X-Gm-Message-State: AOAM533B09+55A/HlP0g/hD4CiDRtnVOUYJL/JVjbJAjPr7C5PTCaemX
        uBvcfUlwh2xsHi07pBRKAhehD0dUTj3wNg==
X-Google-Smtp-Source: ABdhPJzjosnulnpR+ymMBuWwjlifTsk/hk95bovPgVKutFTFqeZzMHri3iQNyDY48Eb+oy06QJ8XAg==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id q7-20020a17090311c700b0015172900cccmr7000756plh.95.1648755196589;
        Thu, 31 Mar 2022 12:33:16 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm252776pfh.177.2022.03.31.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:33:16 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:33:13 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH] trace2: add stats for fsync operations
Message-ID: <20220331193313.GA24336@neerajsi-x1.localdomain>
References: <pull.1192.git.1648616800529.gitgitgadget@gmail.com>
 <220330.86zgl7o8l8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220330.86zgl7o8l8.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 30, 2022 at 03:29:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 30 2022, Neeraj K. Singh via GitGitGadget wrote:
> 
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Add some global trace2 statistics for the number of fsyncs performed
> > during the lifetime of a Git process.
> 
> This make sense.
> 
> > These stats are printed as part of trace2_cmd_exit_fl, which is
> > presumably where we might want to print any other cross-cutting
> > statistics.
> 
> [...]
> 
> > diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
> > index d164b750ff7..299999f0f89 100644
> > --- a/t/t0211/scrub_perf.perl
> > +++ b/t/t0211/scrub_perf.perl
> > @@ -59,6 +59,10 @@ while (<>) {
> >  	    # and highly variable.  Just omit them.
> >  	    goto SKIP_LINE;
> >  	}
> > +	if ($tokens[$col_category] =~ m/fsync/) {
> > +	    # fsync events aren't interesting for the test
> > +	    goto SKIP_LINE;
> > +	}
> >      }
> >  
> >      # t_abs and t_rel are either blank or a float.  Replace the float
> 
> This part doesn't, per the comment at the top of t/t0211/scrub_perf.perl
> and the rest of the code the reason we scrub trace2 output is to get rid
> of variable output, i.e. startup times and the like.
> 
> If I omit this and run the tests only t0211-trace2-perf.sh fails, and in
> exactly the tests it seems we should be updating instead of sweeping
> this new data under the rug.
> 
> Maybe I'm missing something, but your comment/commit message doesn't
> discuss the interesing "why", we can see that the author of the code
> doesn't think "fsync events [are] interesting for the test".
> 
> But why? Unlike the platform-specific APIs fsync() is something we'll
> call everywhere, and surely any platform-specific API calls will be
> guarded by the relevant options, and we could skip this there for those
> tests.
> 
> Here I'm eliding that git_fsync() we are calling the platform-specific
> APIs, but that's something this logging is explicitly hiding, e.g. if we
> call it in a loop this will log once, so this shouldn't be variable
> based on the OS, we're logging our own git_fsync() and
> FSYNC_WRITEOUT_ONLY v.s. FSYNC_HARDWARE_FLUSH.
> 
> > diff --git a/wrapper.c b/wrapper.c
> > index 354d784c034..f512994690b 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -4,6 +4,9 @@
> >  #include "cache.h"
> >  #include "config.h"
> >  
> > +static intmax_t count_fsync_writeout_only;
> > +static intmax_t count_fsync_hardware_flush;
> > +
> 
> nit: stray whitespace change.
> 
> >  #ifdef HAVE_RTLGENRANDOM
> >  /* This is required to get access to RtlGenRandom. */
> >  #define SystemFunction036 NTAPI SystemFunction036
> > @@ -564,6 +567,7 @@ int git_fsync(int fd, enum fsync_action action)
> >  {
> >  	switch (action) {
> >  	case FSYNC_WRITEOUT_ONLY:
> > +		count_fsync_writeout_only += 1;
> >  
> >  #ifdef __APPLE__
> >  		/*
> > @@ -595,6 +599,8 @@ int git_fsync(int fd, enum fsync_action action)
> >  		return -1;
> >  
> >  	case FSYNC_HARDWARE_FLUSH:
> > +		count_fsync_hardware_flush += 1;
> > +
> >  		/*
> >  		 * On macOS, a special fcntl is required to really flush the
> >  		 * caches within the storage controller. As of this writing,
> 
> Isn't this making this very low-level API thread-unsafe?
> 
> I.e. shouldn't you be using something like the tr2tls_locked_increment()
> API to keep track of this instead?
> 
> > @@ -610,6 +616,12 @@ int git_fsync(int fd, enum fsync_action action)
> >  	}
> >  }
> >  
> > +void trace_git_fsync_stats(void)
> > +{
> > +	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
> > +	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
> > +}
> > +
> 
> Is this logging really all that useful in this form? I.e. if we were to
> log these as they happen they'd be attributed to whatever the open
> region is, and you'd see them "as they happen".
> 
> But these sorts of aggregate statistics just seem no give us pretty much
> the same thing that strace and similar tools would give us, i.e. we
> don't log the number of open(), write() and close() calls.
> 
> It *does* abstract away the OS-specific syscall though, but for anyone
> looking at the level of detail of "number of fsync's" is that going to
> be that useful (and the same goes for logging this v.s. open() on
> e.g. mingw).

The overall question about the benefit of this patch is a good one.
The idea here is that there might be some 'countable' things that
affect the performance of Git, such as peak memory usage, fs operations,
etc.  Fsync is the one I happen to care about at the moment, but certainly
number of write calls, opens, or other such stats would be interesting.

I've got to switch gears to some non-Git work, so I'm not going to push
too hard on this patch in the near future. I'll be focusing my efforts on
the batch patches. This might be worth reviving later if people want to add
global stats of this nature.
