Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D181C388F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AFC2071E
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 23:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRxNubYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgKPX4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbgKPX4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 18:56:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566AC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 15:56:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g11so9205302pll.13
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 15:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YVlPu2MyX8XGt2HF1U4smeZ7scf3TepV0IDTyrLZRDo=;
        b=TRxNubYKPvtiAiByXoMUYFXgzLNsQAU/VoepA+LLQywbili8/VpKp/4++A+KX9OT24
         fvzNh2guBEwOfU03f6W9BpvMulP2iqS8A7/MGa0mSuzOjeIheBseTwSCJ1Q8f3NPSgSR
         9dJcqFKGzJicSyl/plNtExiUG9LZe/jFzpZs8P01mT6NwzwVbt6/HIxINJ2VmBW8mefr
         w5YzvF5hZ8dhEH9Z7niPPlaEXRDSvx/0zr3OQrVZYubnOV1FgRwsLm+Lzr+Cr5/mwYue
         hdKlVPPHQktbgbecT7STIT6h5/PkKs1CQKZZ7GdNeAY5GMeKPKrwQvDzv0dQI2aE1I1V
         Dodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVlPu2MyX8XGt2HF1U4smeZ7scf3TepV0IDTyrLZRDo=;
        b=f/Ne/I1/F7ERr05Rd/P13mJDPklAh60ZAcfnCk3Fe/UfzJoCvAftM8iID4W0Mt02uv
         TVuw3lHhmn4VWqvzXxAAVmNcECgBH29PfCedITwK6xNzgxHM6NGJDAT/J48AmqcmfBlV
         62CZIBnvEuj0TS0N+TfbjMRAHB7FAAiw4Fj8xFh7iUmYOXWy6ej+XO1v0sq8QBhbnPHV
         jM88vdfRDuzNdPs9oRBv7AvOvKWhK7oSjoedDdqgR53xO9Pp/yKSHm0erJkP+12vDWg+
         uqJGubZW/0+zGm0b6HGQEjjhdcfbCyFivh40Gsbol4J352mMlD1qrzeh6uzRq1B2A+Ct
         2O/g==
X-Gm-Message-State: AOAM531pJU2L3FqSnRziAzVttdrMcgeGyvnUk2B8wesjF0o8pOp00y3q
        9I9sjwVBaU1ff9AA50FHO6Neug==
X-Google-Smtp-Source: ABdhPJz5pNhFW4sNfDqwE6SfppKnoxuA1TWqelLEiK5JimmEKfFqPv/hTtTAtFyfkreKGr447/7FYw==
X-Received: by 2002:a17:902:8d95:b029:d8:c2ee:7dc with SMTP id v21-20020a1709028d95b02900d8c2ee07dcmr15355501plo.57.1605571008941;
        Mon, 16 Nov 2020 15:56:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id h8sm602656pjc.54.2020.11.16.15.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:56:48 -0800 (PST)
Date:   Mon, 16 Nov 2020 15:56:42 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
Message-ID: <20201116235642.GA15562@google.com>
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
 <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 08:31:35AM -0500, Derrick Stolee wrote:
> 
> On 11/9/2020 6:42 PM, Junio C Hamano wrote:
> > * ds/maintenance-part-3 (2020-10-16) 8 commits
> >  - maintenance: add troubleshooting guide to docs
> >  - maintenance: use 'incremental' strategy by default
> >  - maintenance: create maintenance.strategy config
> >  - maintenance: add start/stop subcommands
> >  - maintenance: add [un]register subcommands
> >  - for-each-repo: run subcommands on configured repos
> >  - maintenance: add --schedule option and config
> >  - maintenance: optionally skip --auto process
> >  (this branch is used by ds/maintenance-part-4.)
> > 
> >  Parts of "git maintenance" to ease writing crontab entries (and
> >  other scheduling system configuration) for it.
> > 
> >  Will merge to 'next'?
> 
> This hasn't changed for a while, and part-4 is also sitting
> after some initial feedback. I'd love for others to test
> these background maintenance activities in their home forks.
> I certainly have on all three platforms.
> 
> Perhaps part-3 could merge to 'next' soonish? I know we
> discussed only merging part-3 and part-4 to 'master' at the
> same time, but it would be good to have part-3 start cooking
> in 'next' sooner than later, right?

Hiya, we found a bug in part-3 today!

Because 'git maintenance unregister' spins a child process to call 'git
config --unset maintenance.repo <cwd>', it actually fails if "cwd"
contains a POSIX regular expression special character:

  git config [<file-option>] --unset name [value_regex]

You can demo it for yourself like so:

  git init repro+for+maintenance
  git maintenance register
  git maintenance unregister
  echo $?	# returns '5'
  git config --list --global

I see two paths forward:

1. Teach 'git config' to learn either which regex parser to use
(including fixed), or at least to learn "value isn't a regex", or

2. Don't spin a child process in 'git maintenance [un]register' and
instead just call the config API.

I'd suggest #2. The config API is very nice, and seems to have a simple
way to add or remove configs to your global file in just a couple of
lines. If there's a reason why it's not simpler to do it that way, it's
my fault for missing the review :)

 - Emily
