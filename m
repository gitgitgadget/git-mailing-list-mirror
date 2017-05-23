Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A8920281
	for <e@80x24.org>; Tue, 23 May 2017 21:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162380AbdEWVFa (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 17:05:30 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33380 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161919AbdEWVF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 17:05:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so125901747pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NEufYwcYrNYCgNRqBRlqKPhNrotJyKzUXW4B3WjfzVw=;
        b=a2XE2N++dkVNXZwOu+R29oOorXY3/IoAW8WeJ+39+WWsBw6CV59EWsSDEj7WGB9KD9
         Hr61E3WP91FX2NVD7yFK4/6ZaKeWsFWUW1YIKT4cyqi2mR/XqQBuYNvg78GbpPqR70V5
         Nk/33abLIzf+dwssn9TfjNMTVDmO1Zxeejoi81Qs043QlBqkD0MsK8aIpL3Py1srdH61
         Im6zY4U/JEdYiUoxkG/05fYCaNVuCU8MK/P17ll+ReOXdsXKNNOuxPA41/TAt3zssVE6
         TJERTvIs8b3PW7TXARqivJ0jji8KV02RX9W2TwAyYlxhrJPhaUBfhsUN+JSJYMugzovb
         nHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NEufYwcYrNYCgNRqBRlqKPhNrotJyKzUXW4B3WjfzVw=;
        b=i72H84KzDPTU8zn7hfWZBNNBC9FfPfdp7iShL0SBTZxVyH6IdVAZjVrMqXk30EZSmo
         +CgKNvalzzGZvwq14HNmM6Enx14IqRECaWCvIjkcRaQI74u/uH2NJ9vAEWInvV1zY6z/
         c3rt4EwmuMLR1NJc0yMc9dXN7BYXp3ejn8Ia9TWMQECrFBxqvtKiSjWdNuXKYzjLr/5Z
         E0RGt/Q982DXPRKlICgwJC2jj7Z0QFF6NzfrSVgD9dM5jLqhREd6n2jJeWSt+H/duJN/
         bM2PmmXSECGXNDlxz2u10mOFnPh9fHHmt/K6/0pHNR0fmqrDaiXg2LOzE49W4oQjaYD9
         zkSw==
X-Gm-Message-State: AODbwcBuzf9jqEjvRaBMnQ7uLwi78qXHBv3RzYObkckTSC9ik4qbJEk4
        sypYplyuXBFnz1j/
X-Received: by 10.98.12.142 with SMTP id 14mr33292042pfm.66.1495573527268;
        Tue, 23 May 2017 14:05:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id z14sm2964069pfg.109.2017.05.23.14.05.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 14:05:26 -0700 (PDT)
Date:   Tue, 23 May 2017 14:05:25 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170523210525.GH115919@google.com>
References: <20170515183405.GA79147@google.com>
 <20170521125814.26255-1-pc44800@gmail.com>
 <20170521125814.26255-2-pc44800@gmail.com>
 <20170523193627.GG115919@google.com>
 <CAGZ79kYPUO34YUVR_u4sRuYz+Geo=wxwNEfCnyx+NQWQCQTkaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYPUO34YUVR_u4sRuYz+Geo=wxwNEfCnyx+NQWQCQTkaQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/23, Stefan Beller wrote:
> On Tue, May 23, 2017 at 12:36 PM, Brandon Williams <bmwill@google.com> wrote:
> >
> > You can set .git_cmd = 1 instead.
> >
> >> +             cpr.dir = list_item->name;
> >> +             prepare_submodule_repo_env(&cpr.env_array);
> >> +
> >> +             argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,
> >
> > And then you don't need to include "git" here.
> 
> even if git_cmd = 1 is set, you'd need a first dummy argument?
> cf. find_unpushed_submodules, See comment in 9cfa1c260f
> (serialize collection of refs that contain submodule changes, 2016-11-16)

Different subsystem, you don't need a dummy first argument.  The
revision walking code does (for some reason) need a dummy first
argument.

> 
> >> +
> >> +     info.argc = argc;
> >> +     info.argv = argv;
> >> +     info.prefix = prefix;
> >> +     info.quiet = !!quiet;
> >> +     info.recursive = !!recursive;
> >
> > If these values are boolean why do we need to do the extra '!!'?
> 
> Actually that was my advice. As we only have a limited space in a single
> bit, strange things happen when you were to do:
> 
>     quiet = 2; /* be extra quiet */
>     info.quiet = quiet;
> 
> This is not the case here, but other commands have evolved over time
> to first take a OPT_BOOL, and then in a later patch an OPT_INT.
> (some commands take a "-v -v -v")
> 
> And by having the double negative we'd have some defensive programming
> right here. (To prove I am not telling crazy stories, $ git log -S \!\!)

All good, I didn't notice that they were bit fields.

-- 
Brandon Williams
