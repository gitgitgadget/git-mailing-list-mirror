Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC71ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiH2KQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiH2KQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 06:16:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA746111A
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:15:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t5so9452680edc.11
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=N5eGwpjoCAlKh/bcQn1bGgDK3ikUi/LwF4ZANybsavo=;
        b=casgUzoi1W+R+3pJ6q39aR1ZMswAN5G4shZllNr8KhGU/aU0kpGZyTMGxPg1TP9FPi
         OZbyuKaFWuFejgETgVnU4ehOERYP5Px/IWk2nPqUY029Bg+4HD7y+Kx0HaMJz4rRc9+3
         kgr+wA54xOBD1Sfa9aqL7Bc/0Q0SR5LgOlxr9Kty62NGtLnnTDDYji6lGCRnWutWFuUz
         UOBAW2LxXCzS/IrAg72TTbw8M8o0g7nUSYbDEb/MFUjgij7mkaSZr9db0AmpcfKLvIJz
         /ba2UfSAvenb0csBvVPxum9Y8xRNHT11VbmkQvPsYs32MRFqk1qD18iVtfAaF5Bxh1FU
         0bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=N5eGwpjoCAlKh/bcQn1bGgDK3ikUi/LwF4ZANybsavo=;
        b=Q5kmUZH8QaGKbL+oziYNWiwc/woT5+fz8b0q27LyCJ70ESykdRBZhNM1UhydaEX88k
         qQY9mpJIX7Pl5QWTP2whuGdNlWMyoAqNn3JXXXhY9+cTFQMAPWdUUnCyzbihRHFqxv0T
         E6LVJaUfVniYpCQQS/ZhpKMjprbGXatJUDgT/ZLr0xm4hAorIrmf/iZfUDLJU/mA0Cak
         yTMDAMS674uN/epyzwA5aLR43UFolHkIpKW47GBgcQllwPCNJKua5KMyFelc5P4bjezU
         JmWUhMNBdXzl4PHTGWvCPMAYmYig9IxtT62BD97J5eYK+BxSEqOzzmWG2kPA4s+t5LaQ
         asCw==
X-Gm-Message-State: ACgBeo1LYOEzet+XHp49meNrCwbrbpCPAdaY1nAKajT2YU+4XfZ4DcqT
        oqWtPDV9j8dF4c8Mpck8zyJgNzyY7Bk=
X-Google-Smtp-Source: AA6agR4J+CJT6PA6UnPewK7QLBV1d3jjuWMb/ZW54ghQQaWIygS3DeT1PG+CRkHN6XBwTdsg7iTG/w==
X-Received: by 2002:a05:6402:11c8:b0:440:6513:be2c with SMTP id j8-20020a05640211c800b004406513be2cmr15771982edw.45.1661768133875;
        Mon, 29 Aug 2022 03:15:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906304d00b0073c8d4c9f38sm4354680ejd.177.2022.08.29.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 03:15:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oSbno-001eW6-1s;
        Mon, 29 Aug 2022 12:15:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 11/16] bisect--helper: calling `bisect_state()`
 without an argument is a bug
Date:   Mon, 29 Aug 2022 12:11:21 +0200
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
 <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
 <8a0adfe3867157102e75d53ed928603ad634b904.1661604264.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8a0adfe3867157102e75d53ed928603ad634b904.1661604264.git.gitgitgadget@gmail.com>
Message-ID: <220829.86sflf2w57.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `bisect_state()` function is now a purely internal function and must
> be called with a valid state, everything else is a bug.

I'm confused by the "is now purely an internal", when did that happen
exactly? That wording is new in this v5.

Before this series wasn't the only caller "internal" (git-bisect.sh) as
well? From the CL:

     -    bisect--helper: using `--bisect-state` without an argument is a bug
     +    bisect--helper: calling `bisect_state()` without an argument is a bug
      
     -    The `bisect--helper` command is not expected to be used directly by the
     -    user. Therefore, it is a bug if it receives no argument to the
     -    `--bisect-state` command mode, not a user error. Which means that we
     -    need to call `BUG()` instead of `die()`.
     +    The `bisect_state()` function is now a purely internal function and must
     +    be called with a valid state, everything else is a bug.

Before the migration to OPT_SUBCOMMAND earlier in this series:

	$ ./git bisect--helper state
	usage: git bisect--helper --bisect-reset [<commit>]
	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]
	   or: git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>] [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
	   or: git bisect--helper --bisect-next
	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
	   or: git bisect--helper --bisect-replay <filename>
	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
	   or: git bisect--helper --bisect-visualize
	   or: git bisect--helper --bisect-run <cmd>...

	    --bisect-reset        reset the bisection state
	    --bisect-terms        print out the bisect terms
	    --bisect-start        start the bisect session
	    --bisect-next         find the next bisection commit
	    --bisect-state        mark the state of ref (or refs)
	    --bisect-log          list the bisection steps so far
	    --bisect-replay       replay the bisection process from the given file
	    --bisect-skip         skip some commits for checkout
	    --bisect-visualize    visualize the bisection
	    --bisect-run          use <cmd>... to automatically bisect

After that:

	$ ./git bisect--helper state 
	fatal: need at least one argument

	usage: git bisect (good|bad) [<rev>...]

So intra-series we were showing the wrong SYNOPSIS for this
internal-only command. I don't think that matters per-se (and the
end-state fixes it up), but doesn't it point to some ordering oddity
here?

AFAICT we couldn't call "state" without an argument from git-bisect.sh
before, and that's the only (and internal) caller, so shouldn't this
BUG() come earlier?
