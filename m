Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A9620281
	for <e@80x24.org>; Tue, 23 May 2017 19:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760530AbdEWTJb (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:09:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33628 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757621AbdEWTJb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:09:31 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so123430627pfh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TkIqtYyE8BcckyK28s1+nWSppHh8EwSTqrxuy8ZL3vs=;
        b=CS0Byrs56pVWxUMv2ZTwJAtM2o86WrlT6WQWyMbLp3RArfmbxchLvvFG1g0LxTXMa2
         nDwMkmgOxIF4bvJUrSdRQBL/H7O6TgCGQGO9sDrqtkfUeTO3Wgdtwnp52o6br8oSSctg
         dgkVtkXHILZBcFxKhqn12YG8fI0gYeVhhk+FgNqI+qnGrZu81JLTOrZHIbTOItr/S1rS
         TpbsNseIqWYwmnsdVtf5VZxlE2w8A91HjxReXo8kDz4Y1LSMbKOwNJHX1SNC25Kai4/s
         Lj/DUF49YlZ4db39L5U+xLNVZYHOeBJILpaaKMGMAt1mB7nNZ50zhTi7kTJu3ohQTf2K
         ywiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TkIqtYyE8BcckyK28s1+nWSppHh8EwSTqrxuy8ZL3vs=;
        b=QhKaJ703KUxEFvDn4xvx9yICVmBUvcRA9CMseterd48rY+8OA85GoXwTK3pn2zUD2W
         9l4szWMNbCVtvIG1iDSXo4Vo7aYO1Ta+O58aILUhi3V2h5qygZTD1mBgUzZ5aTBqHIm6
         VjSJiJqlJyCkPlNZN1i+jATX2+twisHtFXIZRdGvdZiCL8I7heZAgF+IIa4cB+Z+8GKv
         MG05AB75c0mVZJEpF3uriwN4ZNn2rX3rFxJsjssgA7ARpqwz36RD8c+/LUQKKZfiDVs/
         XbMF4bNoxmNF12ZlU0OcZOGamNDt+mO8/cigYegwl6uDpsdpHwSS8y3cjHpZu9exZUL7
         LfkA==
X-Gm-Message-State: AODbwcAiTpT1HvT2LgWq+8IqSQIMMg0v2EHHULbkIqkvPtVZFvyj/XCZ
        O0HxYWjvo4TtmJjd
X-Received: by 10.99.167.75 with SMTP id w11mr34191688pgo.148.1495566570177;
        Tue, 23 May 2017 12:09:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id m80sm3144088pfg.107.2017.05.23.12.09.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 12:09:29 -0700 (PDT)
Date:   Tue, 23 May 2017 12:09:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from
 shell to C
Message-ID: <20170523190928.GF115919@google.com>
References: <20170515183405.GA79147@google.com>
 <20170521125814.26255-1-pc44800@gmail.com>
 <20170521125814.26255-2-pc44800@gmail.com>
 <CAGZ79kbmQ5_Vb8BSoJkA74-+e0FoKwz=iJkSk4sdSnc46s+qUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbmQ5_Vb8BSoJkA74-+e0FoKwz=iJkSk4sdSnc46s+qUw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/22, Stefan Beller wrote:
> On Sun, May 21, 2017 at 5:58 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> 
> > I have also made some changes in git-submodule.sh for correcting
> > the $path variable. And hence made the corresponding changes in
> > the new test introduced in t7407-submodule-foreach as well.
> > I have push this work at:
> > https://github.com/pratham-pc/git/commits/foreach-bug-fixed
> 
> This one seems to pass the test suite by having the bug fixed.
> (The patches posted here seems to be
> https://github.com/pratham-pc/git/commits/foreach
> which does not pass tests? These two series seem to only differ in
> the bug fix commit, which I think is a good idea to include, as then we
> have a bug fixed and the tests pass.)
> 
> > +static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
> ..
> > +       return;
> 
> no need for an explicit return in a void function.
> 
> > +struct cb_foreach {
> > +       int argc;
> > +       const char **argv;
> > +       const char *prefix;
> > +       unsigned int quiet: 1;
> > +       unsigned int recursive: 1;
> > +};
> > +#define CB_FOREACH_INIT { 0, NULL, 0, 0 }
> 
> This static initializer doesn't quite match the struct,
> (I would expect two NULLs as we have two const char pointers).

If we ever move to a new version of C, these initializers would be much
more readable as we could assign values to the fields themselves.  But
that is unrelated to this change.

> 
> > +
> > +       info.argc = argc;
> > +       info.argv = argv;
> > +       info.prefix = prefix;
> > +       info.quiet = !!quiet;
> > +       info.recursive = !!recursive;
> 
> as you assign all fields of the struct yourself, you could also omit the
> static initialization via _INIT above.
> 
> 
> Apart from these two minor nits the code looks good to me.
> However we'd really want to have the bug fix patch as well.
> (At the time of submission of a patch we should not be aware
> of any tests failing, which we are without said bug fix patch)
> 
> Thanks,
> Stefan

-- 
Brandon Williams
