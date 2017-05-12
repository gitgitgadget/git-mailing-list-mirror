Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A099F201A7
	for <e@80x24.org>; Fri, 12 May 2017 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756312AbdELSTy (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 14:19:54 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33794 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755947AbdELSTx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 14:19:53 -0400
Received: by mail-pf0-f173.google.com with SMTP id e64so33828947pfd.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jD55aqUzXFRPSA5y/J2POqAZVAVJVPQNYnnDj/xSm1A=;
        b=onsxBjOES7O6lskAFprZPyjsZDX7jATlIHbzsOCx3HCo9pNtov1MhopCNp/aoA10BS
         g7tWQdW18/ZVJRenW9u3E2yHn+yFzSJfLCP1jjGgX7dMTZHQZKWf3/15y/zKUs+4VSwp
         wDSwsXh9JHGYqZ5AMlAaTvLZ3KRWYLuDC/pQZONS4HfNs6Xoj8I6lSUdoepPdEsusgAa
         xBZcYJ6lW6BbxYmtl1Jglt4YgpNxfuNDpQjgL2vns70u6qGZ+QmfCuOK+DPBS2S8tyrw
         dF2hDtCMpIDmwYE+9PmUxk+gGggdTgoNvXmXsHSYEmuFC/OBatAy2qYT4xpkvuOe0SDO
         dTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jD55aqUzXFRPSA5y/J2POqAZVAVJVPQNYnnDj/xSm1A=;
        b=GmRNS9BbX3lXY6pk15ztDksjj/9PKBjV2vBDmDO9i1epyYBjg+DiPIrQehTv/Q7MUY
         L7guIKCEAKbq2sIXG8HdcDk19hceQcEYVc2OYmNQENyRgsfzyc6yFP7yKe/C+nREO/nG
         fSka22WC5s4WSUegRq9ODcbhfhEYcm3FrGtKGRsXdY1YV8x2e6hKaXQbEPiBJIWE6Q3+
         HGhYcdNCCdjd6sTp/kEk85ikvLPFt0vIVHeiG7o+SCR63Ev9Gf92xF3Wrd1qTDptoIx1
         OGNz++T5lPCPslYz6vEMXcdVvlbSDe1U4b78gdsNgAKT1BVLgj+LgA54DIHK7w7/lQ5S
         bTAA==
X-Gm-Message-State: AODbwcAIwsIeB3HYi410O/S1U8eqxfyTTiV3cjLmaTTO1kbzZricwI33
        z5R9keXmkQw9QM/j
X-Received: by 10.98.97.4 with SMTP id v4mr5997725pfb.23.1494613192537;
        Fri, 12 May 2017 11:19:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4e0:75e9:f5fc:bc05])
        by smtp.gmail.com with ESMTPSA id y78sm7055630pfd.32.2017.05.12.11.19.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 11:19:51 -0700 (PDT)
Date:   Fri, 12 May 2017 11:19:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Paul Jolly <paul@myitcv.io>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
Message-ID: <20170512181950.GE98586@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
 <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com>
 <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12, Paul Jolly wrote:
> >> How can I help diagnose what's going on here?
> 
> <snip>
> 
> > Welp that's a pretty terrible bug which stems from
> > missing a check to see if a submodule is initialized, and not explicitly
> > setting GIT_DIR=.git (theres cases where we don't want this but turns
> > out we probably should do that here).  Let me know if this fixes the
> > problem:
> 
> That's certainly fixed the fork explosion. Indeed seems to now work as
> expected from my perspective...
> 
> And also answers the question that I was going to ask, namely whether
> git ls-files --recurse-submodules should work on repos that do not contain
> any submodules... to which I'd hoped the answer was "yes" (because as I
> said it was a fatal error in v2.11.x, despite there being some output). The
> behaviour I'm now seeing appears to affirm that, assuming it's as expected
> from your perspective!

Yep it should definitely work on repos with no submodules.  I'll put
this on my list of things to do so that I can come up with a more robust
solution to the problem (with tests).

> 
> Thanks for the quick response.

Course, let me know if you find anything else! :D

-- 
Brandon Williams
