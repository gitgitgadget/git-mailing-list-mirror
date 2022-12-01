Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB74C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiLANZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiLANZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:25:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39EF88B77
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:25:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id td2so4192736ejc.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 05:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umyZyKO8LJ0i+mHCKOX8lJeoydynlbCKNArS82n1Pxg=;
        b=HD+htG/PeOqDQmzhOmh5mfDnttcZNt3M7NAJQL44LkhikkWo4/LCvh+ZMffviDmo6r
         BD1claReu00cP5f8Z/rUzeqoBhYqN1VqdTp8HsndtWH7oiX7llNPIZZtUoHTFpK8c1ag
         TnK/ZmP3mqE2v1NTQK6ix0suD/TwR0CfqF2/drsaUDmwEviCQycBxsqDdKNuJ8rriC87
         CS8lkbXviIHHJFjV0/hYVvYzNnzH7RJat4vq2cHXu9tjhrzJf5BKe0ysOfKvPbsF3SBt
         14IGoe+HViOF1OhWznQar1AB5MglPYRui9IJ1O6jCMEJx0xin9oK6zMPzK1AaBfr6oBb
         WQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umyZyKO8LJ0i+mHCKOX8lJeoydynlbCKNArS82n1Pxg=;
        b=mlZIXn1vZnhDJLzm91PSlmjDHvN4VBbqQgYhg7/V0yCxLgrgIe4GsbLYzCjSzW6k0+
         gTER94wc+/XPQLty6K3GjCUhTHJJPmvhfn2uzgLRGBMY9SARPHaIEBWFD17brBxbZ5a0
         ze9o+FX9MF3eDgtdDkwPit77o9S+xW3NYi+JAiJR8I3IbR5sYVZ4uViaSXeKP4kUqPlu
         ar0y/M6VlLmPGmynD1q3Q7btI+nGSJfdepdsIH78Ocbp1s1vI+RS1X7fDuV/B2AwcELf
         /w4Nz04v/gmN8R+e4A5wwNrUZ2dydI0VMyw+tBgibVINzAQcyhwUha6tHjh+AX5m1pHM
         IW0Q==
X-Gm-Message-State: ANoB5pkHo4f9+dCfs8ZwghaMFGiglucMwtGDonE7ajGVDVOrqipzmR11
        CTGfEs968rsTBQztEJv4qpVxaYGjJus=
X-Google-Smtp-Source: AA0mqf7inMhM4YsM1lckO2PHfkSO+uesUQbVTUgl6wBzL21JIwVp+m7jnkEwg1+E8cz9HnStt6boog==
X-Received: by 2002:a17:906:660d:b0:7ba:5085:864 with SMTP id b13-20020a170906660d00b007ba50850864mr32954832ejp.357.1669901152936;
        Thu, 01 Dec 2022 05:25:52 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709061d0c00b0078ddb518a90sm1737794ejh.223.2022.12.01.05.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:25:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0jZY-002Dso-0I;
        Thu, 01 Dec 2022 14:25:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     psmith@gnu.org
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
Date:   Thu, 01 Dec 2022 13:37:09 +0100
References: <20221127224251.2508200-1-psmith@gnu.org>
 <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
 <patch-v2-3.4-6db7dd74e52-20221129T140159Z-avarab@gmail.com>
 <xmqqk03dyskc.fsf@gitster.g>
 <25c59966c83cdae078bdefa49f47ca8d3199475c.camel@gnu.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <25c59966c83cdae078bdefa49f47ca8d3199475c.camel@gnu.org>
Message-ID: <221201.86v8mvgsrj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Paul Smith wrote:

> On Wed, 2022-11-30 at 13:28 +0900, Junio C Hamano wrote:
>> I have to wonder how many projects they have broken with this change
>
> Some, but not that many.  Most projects don't try to investigate
> MAKEFLAGS, and of those that do many were already using the recommended
> method, because even prior to GNU make 4.4 it was possible for
> MAKEFLAGS to have stray "s" characters, in unusual situations (for
> example if MAKEFLAGS were set in the makefile).
>
> There were various bugs filed that various options could not be
> investigated from within makefiles and also that running make from
> within $(shell ...) didn't work right because MAKEFLAGS was not set.
>
> It was just a mess, trying to keep the value of MAKEFLAGS set to
> different values at different points in the processing of make.

It was definitely a bit of a hack on our part, but to be fair before
this 4.4 release doing it this way was recommended by the
documentation. I see you changed that recently, but maybe this on top
makes sense?
	
	diff --git a/doc/make.texi b/doc/make.texi
	index e3a3ade4..9e9a894e 100644
	--- a/doc/make.texi
	+++ b/doc/make.texi
	@@ -5069,7 +5069,7 @@ Variable @code{MAKEFILES}}.
	 @vindex MAKEFLAGS
	 Flags such as @samp{-s} and @samp{-k} are passed automatically to the
	 sub-@code{make} through the variable @code{MAKEFLAGS}.  This variable is
	-set up automatically by @code{make} to contain the flag letters that
	+set up automatically by @code{make} to contain the normalized flag letters that
	 @code{make} received.  Thus, if you do @w{@samp{make -ks}} then
	 @code{MAKEFLAGS} gets the value @samp{ks}.
	 
	@@ -5085,6 +5085,10 @@ option has both single-letter and long options, the single-letter option is
	 always preferred.  If there are no single-letter options on the command line,
	 then the value of @code{MAKEFLAGS} starts with a space.
	 
	+The value of @code{MAKEFLAGS} does not correspond to the order in which
	+command line options are provided. Both @w{@samp{make -sk}} and @w{@samp{make -sk}}
	+will result in a @code{MAKEFLAGS} value of @samp{ks}.
	+
	 @cindex command line variable definitions, and recursion
	 @cindex variables, command line, and recursion
	 @cindex recursion, and command line variable definitions
	@@ -12378,10 +12382,13 @@ influences such as interrupts (@code{SIGINT}), etc.  You may want to install
	 signal handlers to manage this write-back.
	 
	 @item
	-Your tool may also examine the first word of the @code{MAKEFLAGS} variable and
	+Your tool may also examine the first word of the @samp{-$(MAKEFLAGS)} expression and
	 look for the character @code{n}.  If this character is present then
	 @code{make} was invoked with the @samp{-n} option and your tool may want to
	 stop without performing any operations.
	+
	+Note that this is not equivalent to checking for the first word of
	+@code{MAKEFLAGS}.
	 @end itemize
	 
	 @node Windows Jobserver,  , POSIX Jobserver, Job Slots

I.e. that "Your tool" part seems to still be assuming 4.3 semantics.

> Also, ensuring this trick for searching MAKEFLAGS continues to work
> would have meant strictly controlling what new options we could add to
> GNU make.  I haven't seen any other project use the filter-out --%
> trick that the Git makefiles do, but even with that it won't help if a
> new single-letter option that takes an argument is added.

I'd think it would probably make sense to promise that GNU make will
never add such options, so that what's currently documented continues to
work. I.e. it supports:

	--debug=all

Not these forms:

	-dwhy
	-d=why

But if we're on the topic: The only reason git's Makefile uses these is
because it's trying to fake up some pretty verbose-but-not-too-verbose
mode. You can see this in our tree at "shared.mak", the kernel does
something similar.

For our Makefile this is pretty close to what we'd get from a simpler:

	make -B --debug=why -s |
        sed -E -n \
		-e "s/.*: update target '(.*).o' due to.*/   CC \\1.o/" \
                -e 's/due to.*//' \
                -e 'p'

I.e. when we have %.o" targets this is emitting " CC $@" lines, I've
left matching the rest as an excercise for the reader, but it would be
e.g. "GEN_PERL" or whatever for %.pm and so on.

I don't know what this would look like exactly, but it would be neat if
GNU make supported some way to emit such friendly output in
general. Something like a sprintf format where you'd have access to the
sort of input that "due to" string gets internally (and perhaps a bit
more, e.g. something indicating overall progress through the graph...).

