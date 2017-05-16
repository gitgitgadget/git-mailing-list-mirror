Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37CF1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdEPRav (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:30:51 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:32863 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEPRat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:30:49 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so79576623pgb.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPfCdFG06k3koHifvMLmS7eD4MKK99gYHm4SxYMRyGY=;
        b=V9uhK+mP6r2s1rJKEE8D49GNF2iQzGmmvL5fLF22HE5L3TvjuRZSjMzzMMBexP4TLd
         LIp4wx6KmGj64srnyBKfhHA2m+C6dBDtvBVPWs/x0PbOBi1X8OwTknK7cXWz8H25oAU/
         KPPg0iZKf6D757KpL5WQ4maleSCKEYJtaV97ZE1ArATDQCVGzC29k4gaD/dndV1UoWPG
         JfnaywsvBvLk5biTuCLxGMwE75ErclGelN4Jo7yZSUyAQK9VsYVZdvO3+gy3xIlivTEI
         SAOTWPbHnkA7vKsqYExI5ALZhZIoKaZrKUNHz3ZGKSIcqxv/X6e73Y3rqy7IxNhgF4Qn
         q+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPfCdFG06k3koHifvMLmS7eD4MKK99gYHm4SxYMRyGY=;
        b=U794OTstZ2m3uM/mHBJAI4HYfI7UegJ4PrY50hr4SfnnwV0mdmhq45uLlQ99ARtKhP
         tLlEZj2lS5MsDh9IjMU4fWAMufq+Exhs+ST2BFOwyqPR3840TrUaNcIAy6CRrXsy6LCJ
         mxhibb72C7SjP7xZ9H/PsXWBqEVEYoeLZ+izmEqMU0Ozht2ygZDPpITbcwJ1qBAAiC/o
         C8DijAiGG/fIFJwUcf7d3M02Y1mO1+W/mo0RP3PEQvrRTKA8jqonYf9cFOumRb8Cx1p/
         WV8NpHc1LEKeePCbNdLmvpgr4W48wJFUkWCoQonhD33PnOMjiYZ8YxdE9ym433Tvub3b
         8GHA==
X-Gm-Message-State: AODbwcDRSHrP354TMt9JQQg6es2DFEwCN8Re0mOQgHlZQrgL9gDy4ZX7
        zwaX3y8u9P6atMCm
X-Received: by 10.99.42.199 with SMTP id q190mr13191330pgq.13.1494955843561;
        Tue, 16 May 2017 10:30:43 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c78:c1b9:36d1:fa23])
        by smtp.gmail.com with ESMTPSA id g20sm27243977pfk.21.2017.05.16.10.30.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 10:30:42 -0700 (PDT)
Date:   Tue, 16 May 2017 10:30:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516173041.GH79147@google.com>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com>
 <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Jeff King wrote:
> On Tue, May 16, 2017 at 10:15:40AM -0700, Brandon Williams wrote:
> 
> > > > > So I was thinking something like the patch below, though I guess
> > > > > technically you could look for BASH_FUNC_$argv[0]%%, which seems to be
> > > > > bash's magic variable name. I hate to get too intimate with those
> > > > > details, though.
> > 
> > One concern with that is what about all other shells that are not BASH?
> > I'm sure they use a different env var for storing functions so we may
> > need to handle other shell's too? That is assuming we want to keep the
> > old behavior.
> 
> Most other shells don't do function-exporting at all. Certainly dash and
> most traditional bourne shells don't. I wouldn't be surprised if zsh
> does. But yeah, we'd have to support them one by one (and possibly
> variants across different versions of each shell). Workable, but gross.
> 
> > > When execvp(foo) falls back on ENOEXEC, it is not running "sh -c foo".
> > > It is actually running "sh foo" to run the script contents. So it's
> > > about letting you do:
> > > 
> > >   echo "no shebang line" >script
> > >   chmod +x script
> > >   ./script
> > > 
> > > And nothing to do with shell builtins.
> > 
> > That's correct, and is the exact behavior I was trying to mimic with the
> > changes to run_command.
> >   1. try executing the command.
> >   2. if it fails with ENOEXEC then attempt to execute it with a shell
> 
> I think the logic here would be more like:

Oh yes, I was just saying what I did not taking into account how we
would solve this issue.

> 
>   1. During prepare_shell_cmd(), even if we optimize out the shell call,
>      still prepare a fallback argv (since we can't allocate memory
>      post-fork).
> 
>   2. In the forked child, if we get ENOENT from exec and cmd->use_shell
>      is set, then exec the fallback shell argv instead. Propagate its
>      results, even if it's 127.
> 
> That still means we'd prefer a $PATH copy of a command to its shell
> builtin variant, but that can't be helped (and I kind of doubt anybody
> would care too much).
> 
> -Peff

-- 
Brandon Williams
