Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F28820951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdCQVJs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:09:48 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33772 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbdCQVJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:09:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id e129so3640754pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TjQn9/v+wTkMIyuPSD+b8se7M0HgPAcyQpUQDmk4Pxk=;
        b=jKc4RQWhhJqCLJeadWkAX5g9ZLBdXpop/CFhtdVfJqW2aix4mI6ITkj1TNAQoXKz2T
         Ty0eLux3RhBCV6WbVTkmjW3PpI4Vrc+t00HbNzpHJZaF+4Q8yE15UMDAlvsfYN/M2M6B
         zGpkRIqZjT590GDDIwgKcupt7guy7dxrciicWM9Gz5ps2/ynR4vta97KZu4MN+MeIWuB
         VDVGmu7tdbisO9BWfPzjOCUpAALTLnQwBmvcv4ifrRH5EaGOP7CMdD1xtw7i0Y4urqfD
         MLDxdtsRIIKYBkEYKQDORiLCqw32FTCa00R3dseSuyclR1egLBfbmXxFiRmS12tGd+DN
         LoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjQn9/v+wTkMIyuPSD+b8se7M0HgPAcyQpUQDmk4Pxk=;
        b=rla344L85DNWZ6hJvySOAyQNqSaKtNMUF/lBE2W+pNE2dnEHXLDBzYut0T/AXczi5D
         Ie0Nk5GwzCVZfjuFGJb4nrcbuk2C/Bx8nxtrnT3/vSgDuTAyF9o2ScXGzF/8b+iJayOM
         wB2c0gmPCjneXFm2yl7k2m4NIbp28b5CXMghM3RNH/ER6CoZVhczkL8x8Tr+ZqXhpXMf
         HF11B9tzRZk613yrZ6Dk2iaQHrf+h4A8kQ7piNsABMxG7WgCEDy1FNJXRiXzcB83WGzZ
         Kql64Y3eBhohtTWhQZvAmlw8l1wADo0wXTowJueDNkTwggKKf/PbJNg5BNqcIbAw6Jpq
         w6vg==
X-Gm-Message-State: AFeK/H2yJYcJbknvbsG53E0vSzTWLx0g+OgPtR27MiE1/vyjJo7FSAoFCIrr21JSgIue9f2U
X-Received: by 10.99.149.6 with SMTP id p6mr17808327pgd.122.1489784433753;
        Fri, 17 Mar 2017 14:00:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:c001:d329:ba91:25ca])
        by smtp.gmail.com with ESMTPSA id q64sm18493518pfi.69.2017.03.17.14.00.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 14:00:32 -0700 (PDT)
Date:   Fri, 17 Mar 2017 14:00:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git
 commands
Message-ID: <20170317210031.GA63813@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
 <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com>
 <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com>
 <20170317192103.GE110341@google.com>
 <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > ...  I was being cautious with this patch since git didn't currently
> > read GIT_PREFIX.
> 
> Ahh, I forgot about that.  Processes we spawn do expect GIT_PREFIX
> to tell them where the original $cwd was and they also do expect
> that "git" invoked by them would not be affected by GIT_PREFIX
> environment variable.  So we cannot change that now.
> 

Yep.  I just ran the test suite locally doing this...it fails on a bunch
of stuff :)

> If you recurse into sub-sub module, it is likely that you would want
> to update the TOPLEVEL_PREFIX relative to that sub-sub module you
> are descending into.

So the idea would be that 'super_prefix' would keep getting updated when
recursing deeper, but the 'prefix' should stay the same (in what I'm
proposing here that is).

> 
> That probably also means that processes we spawn now need to also
> pay attention to TOPLEVEL_PREFIX in addition to GIT_PREFIX, and we
> should NOT re-export what we got from TOPLEVEL_PREFIX to GIT_PREFIX.
> I.e. if a "git" process started from src/ subdirectory of the
> superproject that goes into module/sub1/ submodule, top-level prefix
> may export ../src/ to point at the original location, but the
> process that is running in the submodule will be running at the root
> level of the submodule working tree, so its prefix should be NULL or
> "", no?

I don't think that prefix can ever have ".." in it.  From what I
understand it is always a path from the root of the repository to the
cwd that the git command was invoked by.  So in your example prefix
would be "src/".

> 
> Adjusting pathspec and other file references on the caller's side,
> instead of exporting toplevel-prefix to have them adjusted by the
> callee, started to smell more and more like an easier/more correct
> approach to me, but perhaps I haven't thought things deeply enough.
> 
> I dunno.
> 

Yeah, doing all of the adjusting on the caller's side is quite
difficult.  Getting the pathspecs and file references right seems to be
overly complicated if done by the caller.  That why I opted to punt to
the callee; given enough information (e.g. prefix and super_prefix) the
callee should be able to handle both the pathspecs and file references
properly.

-- 
Brandon Williams
