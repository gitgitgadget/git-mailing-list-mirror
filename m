Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B311FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbcLAUys (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:54:48 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36117 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbcLAUyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:54:47 -0500
Received: by mail-pg0-f41.google.com with SMTP id f188so98420855pgc.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZIBfw9zWBqPt9LoJvm4XlWZvLYY72IplKrDEfHwWWg=;
        b=Mu/M+U8/z4Pfwt+MpxqshUxpx7OsmzEyi/y0f02GQH/wB+b8NQ+3H4Fq6198/AurUx
         XUqBSsUH0COmgiOSHVamhMhVndZeA2aM9gj/V3Hj5fjAAwVbInXF/qQeTHuLpuEzSbDI
         mizs2eMpRBtFFYl8bz3/rqJkruyuHCBoKIqeThFBsOIOeVuro5iH659buQXVuNQ5ZdeK
         25HkDWCsMCGA2P6TnOm2YJuH5m/B0vEjgHFbKHTg+uqgrf+hE2fT8ij17FZ2WGQO5sAS
         2ZqetG+p/yDDR+L/1KqZD/QRaF/4dvGIaBUpux4096BhVO47kPv77lU8OROrj7UtZ5Pw
         J43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZIBfw9zWBqPt9LoJvm4XlWZvLYY72IplKrDEfHwWWg=;
        b=USWShiP4XhAnGImWPaeNxjzy7kLhkaSmUVF79Hye6P5cuDZ2aoPGyr/XGAm/vlD3T3
         JGixE9qz+31t9QYNJ+pWgulerezgOUgFcp7L6HAeOaHQkdt4tpf4neqzNh3QysJJ+lxb
         /RDGNT/BQd6JQEDVOea3rJwJzduqUgyHIYfEZm8nS6FFpUCNdcS+0lnSdi0OIejQZAbC
         UTPuhm+b7Y/SNfTLhHBl3/gbarnoyEe7E5X6oaYl5OXLbxt9bYvCfeR4YPK5ClgA5qSH
         S/YoeZbc8s4GVmQumwmwJQ+0xkOD9WR6LlzdU6Tko0Qu/aKEaeBBGgPnDWMqMwTzUULN
         GHWA==
X-Gm-Message-State: AKaTC02FkXvpVaS79gYZMOa6w1MnPZOp7Xsj7ZF+qxSObntY92gZzpZREUZdB+5v8Sp15d/+
X-Received: by 10.99.153.26 with SMTP id d26mr73368218pge.44.1480625686591;
        Thu, 01 Dec 2016 12:54:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id b64sm2109615pfc.74.2016.12.01.12.54.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:54:45 -0800 (PST)
Date:   Thu, 1 Dec 2016 12:54:44 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
Message-ID: <20161201205444.GG54082@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com>
 <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com>
 <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201191603.GB54082@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Brandon Williams wrote:
> On 12/01, Jeff King wrote:
> > On Thu, Dec 01, 2016 at 10:46:23AM -0800, Junio C Hamano wrote:
> > 
> > > > mkpath() is generally an unsafe function because it uses a static
> > > > buffer, but it's handy and safe for handing values to syscalls like
> > > > this.
> > > 
> > > I think your "unsafe" is not about thread-safety but about "the
> > > caller cannot rely on returned value staying valid for long haul".
> > > If this change since v5 is about thread-safety, I am not sure if it
> > > is safe to use mkpath here.
> > 
> > Oh, good point. I meant "staying valid", but somehow totally forgot that
> > we cared about thread reentrancy here. As if I hadn't just spent an hour
> > debugging a thread problem.
> > 
> > My suggestion is clearly nonsense.
> > 
> > > I am a bit wary of making the check too sketchy like this, but this
> > > is not about determining if a random "path" that has ".git" in a
> > > superproject working tree is a submodule or not (that information
> > > primarily comes from the superproject index), so I tend to agree
> > > with the patch that it is sufficient to check presence of ".git"
> > > alone.
> > 
> > The real danger is that it is a different check than the child process
> > is going to use, so they may disagree (see the almost-infinite-loop
> > discussion elsewhere).
> > 
> > It feels quite hacky, but checking:
> > 
> >   if (is_git_directory(suspect))
> > 	return 1; /* actual git dir */
> >   if (!stat(suspect, &st) && S_ISREG(st.st_mode))
> > 	return 1; /* gitfile; may or may not be valid */
> >   return 0;
> > 
> > is a little more robust, because the child process will happily skip a
> > non-repo ".git" and keep walking back up to the superproject. Whereas if
> > it sees any ".git" file, even if it is bogus, it will barf then and
> > there.
> > 
> > I'm actually not sure if that latter behavior is a bug or not. I don't
> > think it was really planned out, and it obviously is inconsistent with
> > the other repo-discovery cases. But it is a convenient side effect for
> > submodules, and I doubt anybody is bothered by it in practice.
> > 
> > -Peff
> 
> I think this more robust check is probably a good idea, that way we
> don't step into a submodule with a .git directory that isn't really a
> .git dir.

Looks like this is a no-go as well...the call to is_git_directory() ends
up calling real_path...which ends up performing the chdir call, which
puts us right back to where we started!  (as a side note I was using
is_git_directory else where...which I now know I can't use)

-- 
Brandon Williams
