Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8361E20899
	for <e@80x24.org>; Wed,  2 Aug 2017 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbdHBSAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 14:00:52 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36450 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdHBSAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 14:00:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id z129so23936712pfb.3
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iru614U2Gk5A96Yv9YzDEiXJRThXxeMkHnnpxG3acdA=;
        b=bWd0RxHgugBlLNyNmsDkiJO0VRqxyt/nI9/ZGa+WMgMwWb/b1XHi0SP2WTjLVS9BVW
         lSLeJ98uptFHEyG2LgxzlFzd7H63iVGNvYqJxjJel20z+rkfOff8cQ88SGbZ6CtWX6hu
         YoZaJMpiO4Dv9m+vTgBVhjJnnu4JPQDbeIiIz6ZOjXbrEGZJSPzvYlIk0ArddC+LqcYe
         KI9gN8CbM3Mu+6ULvI5fmZoM3gEKrZF2JkjAfBQvchbyaiXxNn6+lhuu7AeU9FGnEuhI
         kUD3ZGEyRXaqbPwXHWW5UzPrQaYesmMmYJoejMg300si9ZhuLPyyUiiPb0OvBiUCDrbA
         kKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iru614U2Gk5A96Yv9YzDEiXJRThXxeMkHnnpxG3acdA=;
        b=AajBBj7KxOZz5jZg0Rbv/4mpgRLuX/940U7wmktk6tSQu1yyF7m6+a1i9mx4mrMbkU
         TmCy5IOXGdscp/ZkFbPZisD9h2gPYxd6mLFwvCoS5bdUxJzlFMVWRnq6Ell3x6Ru0OjB
         S6NdzL0kVEimlsDe57EV7zBTuXSd83bNlwNJIICaqEEBoD99OG4NmuLEWqnjZeYcolL3
         ePjyTuK/tmLr+TnfFCaCQG2m/g9PxvOivwmYVbJSYiPc2hfBxRvW1OVJvPitiiPLw0wF
         b2duiqgBeJSKwvUxLYuVcWewSYLmdnZhoIjsQBMjyKsvJnT9bz2/1THS/NY7jZRByoSl
         5+SA==
X-Gm-Message-State: AIVw111GK1r/1MDXFSdSl7hdVHgPVFLGRU6SUmnm/8vud8+EMl5uGhAO
        iZcAqILZBSIPs49tsdkwWg==
X-Received: by 10.98.18.131 with SMTP id 3mr23219229pfs.19.1501696850590;
        Wed, 02 Aug 2017 11:00:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:5415:3cb1:21dc:39fd])
        by smtp.gmail.com with ESMTPSA id t199sm47088777pgb.30.2017.08.02.11.00.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 11:00:49 -0700 (PDT)
Date:   Wed, 2 Aug 2017 11:00:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] submodule: check for unstaged .gitmodules
 outside of config parsing
Message-ID: <20170802180048.GD36159@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
 <20170718190527.78049-1-bmwill@google.com>
 <20170718190527.78049-8-bmwill@google.com>
 <CAGZ79kYWd5WdwkC74+AdRt0anTUtngD7jt=aJv7iLCLf-TAfbA@mail.gmail.com>
 <20170802174104.GB36159@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802174104.GB36159@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/02, Brandon Williams wrote:
> On 07/31, Stefan Beller wrote:
> > 
> > So this is where the check "pos < active_nr" is coming from,
> > introduced in 5fee995244 (submodule.c: add .gitmodules staging
> > helper functions, 2013-07-30) as well as d4e98b581b (Submodules:
> > Don't parse .gitmodules when it contains, merge conflicts, 2011-05-14).
> > 
> > If I am reading the docs for cache_name_pos correctly, we would
> > not need to check for the index exceeding active_cache,
> > but checking for the index not being out of bounds seems
> > to be wide spread.
> 
> I can drop the pos < active_nr requirement.

From our conversation offline i'll leave this just in case there is some
subtle reason why it exists.  Also makes it more of a 1:1 conversion.

-- 
Brandon Williams
