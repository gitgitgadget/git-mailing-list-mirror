Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFC51FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbcKQWNG (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:13:06 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35319 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbcKQWNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:13:04 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so50761397pfk.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+eBVbzMd+dt+fPYm5weuSETOv/yfO1t/xyAgURZGig=;
        b=ECUwsQjbcTuS+JOjTuUetH9JqZNksLSsU7P8BtP0vg+g1zsYVhbsj8cyttupIdwZ7Y
         FjkW9AKFPwTq5bkeBqK/cYA2UAN7fynUTac4Va96ntha9vC0rqwuFj7kMiYR9W8HydCt
         lc/RH+avUyOCofFT5ETy8Au64ABtfUjfPN94oDbo70Kh54d5wly24u2AmbFuW+Eev575
         kUiwwZyuCGiF1KV8irCcKVSvK6TL4rfRwghSlHumdtWGpityLEqZsUnP9kK29XG1Z54Z
         rbJRHxLUAsfKn7cAhnReCieS+6adGmIBNHcjqyk8MwhGe44xXHG6/HMtWZ+5wwye2d75
         5WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+eBVbzMd+dt+fPYm5weuSETOv/yfO1t/xyAgURZGig=;
        b=mIXjMp2so2dUgaKP+AwXqcGS6HQ+Eweh96MJfJeiAqdG1SMETpC8y2FQn5cUeb+049
         X7Grg/nn7MVxeEBANquryMcLjB1Y7GRKXmSeT9JzhVoZFuYYB6BjGrCUx178O65tcnNG
         kMOK360XcMyU2stvCqpyCzAhij/kCu8j+iehNoi85brrtW/sIXzbTrd5zxU4UKCD5tJ4
         SE511daNgqJnt77YkJapAAfv/SmMTFzOq1rYjgPfuU9impS4KTy+6gNRorGHVqQYEWI3
         ddLxXjBOVJv8dNH637K7Bc3subRaAig07MundFOkSeD6cH/GGRAxbL6fAQsECDf9DVwx
         nTEA==
X-Gm-Message-State: ABUngveewkMXHvKvMYIavr8GS58qstBoyQF8WSzaWSu9XWvV6o9JWPsdQMYIQzrvGsQhJNlH
X-Received: by 10.98.133.207 with SMTP id m76mr7655794pfk.102.1479420782571;
        Thu, 17 Nov 2016 14:13:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:718b:9d6c:8235:ef51])
        by smtp.gmail.com with ESMTPSA id q26sm10633206pfk.94.2016.11.17.14.13.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 14:13:01 -0800 (PST)
Date:   Thu, 17 Nov 2016 14:13:00 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] grep: optionally recurse into submodules
Message-ID: <20161117221300.GM66382@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1478908273-190166-5-git-send-email-bmwill@google.com>
 <CAGZ79kZiAWTySJrSvav6Yuj8v9PF0JzaSJHFTOdUo6eYFTS1+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZiAWTySJrSvav6Yuj8v9PF0JzaSJHFTOdUo6eYFTS1+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> > +       /*
> > +        * Limit number of threads for child process to use.
> > +        * This is to prevent potential fork-bomb behavior of git-grep as each
> > +        * submodule process has its own thread pool.
> > +        */
> > +       if (num_threads)
> > +               argv_array_pushf(&submodule_options, "--threads=%d",
> > +                                (num_threads + 1) / 2);
> 
> I think you would want to pass --threads=%d unconditionally,
> as it also serves as a weak defusal for fork bombs. Is it possible to come here
> with num_threads=0? (i.e. what happens if the user doesn't specify the number
> of threads or such, do we fall back to some default or is it just 0?)
> 
> I have seen some other places that check for num_threads unequal to 0,
> as e.g. no mutex needs to be locked then (assuming we don't have any
> thread but grep within the main process), but as you intend to use this also
> as a helper to not blow up the number of threads recursively, we'd need to
> pass at a number != 0 here?

The option parsing logic in cmd_grep handles the cases where num_threads
is some odd value (and fails if <0).  In the case where it is 0, it will
default to 8 under certain circumstances.  I figured I would just let
that logic handle the cases where num_theads ends up being 0 instead of
explicitly passing threads=1.  You can't pass threads=0 in some cases
due to the default "oh look threads==0, looks like we should use 8!"
case.

> 
> > +
> > +       git grep -e "bar" --and -e "foo" --recurse-submodules > actual &&
> 
> nit here and in the tests below:
> We prefer to have no white space between > and the file piped to.

I'll fix that up everywhere.

-- 
Brandon Williams
