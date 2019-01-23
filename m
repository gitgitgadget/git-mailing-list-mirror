Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86301F453
	for <e@80x24.org>; Wed, 23 Jan 2019 20:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfAWUrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 15:47:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37338 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAWUrY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 15:47:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so1753989plr.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N5mY/xV/NBC3t1UTNAptg9qWJV94Nh5i9Cqbb1bZlJw=;
        b=XM8S8a2c7V3KC7cL278uG0/gfG8o6s1rc0yXY5/ve+eBfCCKimzw1WEaHzga/5p065
         6naeke+G8M3cEvT194cYH0WSoDhTXe/XbpH04UFhcov2z7F1OvjiVfy71F+Xp2lt1k+i
         cnYy8j5ATZuwE3/q5xTrZu0qLPwrgt717zrJMCzB+DufpKjsssedGcD3UHQ33zt4KGA0
         L7TtC4tehO5l/MO6tny02uQCVuZX2fgfPGKdwAfRZER72Ika6c+jlDehwsxJYPomGp/1
         yNh0kZKieCrpjYjenhk6vnb0SnND9w1zLHxAMTdUAROdBn5waFcBuU25WwmgRYPItX09
         ge7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N5mY/xV/NBC3t1UTNAptg9qWJV94Nh5i9Cqbb1bZlJw=;
        b=Hm+lW08h+PsiyGaAEURR6GE5LaHvjpxPPkxBHBfsScq8pLbgPw59nCaRcXJbx9RkZ3
         +kZ06ayjboXmh9PhMEmsiW85wl/PEW4WL7r02wL6YxhrogwQNXlRq1cgPt7ZIdWDHh1c
         6n1uNvXSnXfmRBUtZyBK8Nm5jhTGrMB6ldY+5JodLZXI30wjsgck9WPxtPRuLZDNHVe4
         HaEqmwWafJaiFuX1f8jb9wzE2Yz5qyIYUJG3XOZQvIIA7+dWs89o/BcxiyC5LCnG8+mr
         +8isWcLsHtIlpR57/N1BmvQqC7U9SLG90DceszSb686utHYBfoivBj8uff5iTHs8hFSQ
         Qjgg==
X-Gm-Message-State: AJcUukf3dtBCBU3o9DqS4omuyaecMjQ0LwQURcsXXiHXr4tgGcMB9HzK
        o/4zu9ujf5meCt174ZtF9U8=
X-Google-Smtp-Source: ALg8bN4Bb0HhN5xSHZNCjxTEFiDGdBMsQVmmvrIJOpWxJB4x4PrO9VH2IPuTIMKFeZJl4F/5Tw8uuA==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr3855887plm.212.1548276443713;
        Wed, 23 Jan 2019 12:47:23 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o84sm40173392pfi.172.2019.01.23.12.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 12:47:23 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:47:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190123204721.GB34357@google.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123202156.GA11293@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer wrote:
> On 01/22, Jonathan Nieder wrote:

>> I had no idea what --overlay would mean and am still not clear on it.
>> Is this analogous to "git add --ignore-removal"?  If so, can we just
>> call it --ignore-removal?
>
> Yes, it seems like they are very similar.  I'm happy to rename the
> option.  The topic seems to have made it to 'next' already, so I'll
> submit the patches on top, unless reverting the topic out of next and
> replacing it is preferred?

A patch on top sounds good.

[...]
>> I'm nervous about the config with no associated warning or plan for
>> phasing it out.  It means that scripts using "git checkout" don't
>> get a consistent behavior unless they explicitly pass this option,
>> which didn't exist in older versions of Git --- in other words,
>> scripts have no real good option.  Can we plan a transition to
>> making --no-ignore-removal the default, in multiple steps?  For
>> example:
>
> As Junio mentioned, the plan was to just have this mode default when
> we introduce the new checkout-paths command.
>
> As checkout is a porcelain command, I had hoped it would be okay to
> also have this as a configuration option, for the time before
> 'checkout-paths' exists and while I'm getting used to actually typing
> 'checkout-paths' instead of 'checkout'.  However I get that there may
> be scripts that are using git checkout, and expect the previous
> behaviour, so I'm also okay with dropping the config option for now.

Yes, if we have no plan for flipping the default later, then I would
prefer to eliminate the config option.  Scripts very frequently use
human-facing commands like "git checkout" when they want the command
to produce (unparsable) friendly output to show to humans, and I don't
think we've provided a good alternative for that use case.

> If we still want to make this the default even after 'checkout-paths'
> exists, the plan you outline below sounds good to me, though maybe we
> can make the "flip the default" step once we decide to release git
> 3.0.

I would really like this, so I might write a series for it.  Please
don't wait for me, though --- feel free to send any patches you're
thinking about and we can work together or I can just appreciate your
work. ;-)

Sincerely,
Jonathan
