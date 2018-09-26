Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72FF1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 01:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeIZHTw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 03:19:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZHTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 03:19:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3-v6so7857326pgv.8
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xwJxVT2SNAgFwAfc8OE6LoNx6RbuL1Hbs6M/59+pcAM=;
        b=UJ8OBtjydmn4cCnaffZqyfAWkG3MOfFuQtAGYKwc76kxeoecE0F+u40bYLyPbuDAfp
         NLZkbauvyrSBlfO3WmyFWl+yny/izA25JTJIMr39RV/e3c9SnGRQbV8vsCbLzCNdlhCH
         RAyZGu7husjKLM9U3/pxrooB63Q+Zmp0PqnZh+zerTQAelJTHfEhA77WNZulePVl2qll
         BV9CHA531f+0uW4KBmE75dJjS9oHWIIqy9GcWIagDowsPEkWPHJq0zyLMaMZJOIUh+iW
         C/dvdpvrjkMNqxUPYWxUKZwPvhWuZcasfzYJSGs+eIRn8LoPeqwkBYx6GVcdBmQIuslu
         n9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xwJxVT2SNAgFwAfc8OE6LoNx6RbuL1Hbs6M/59+pcAM=;
        b=sdJ+mpAWv6emI6CbnSTsVi94CKj0zj0iU/EzePxJUQkj4Hka5zPf0+NpJaknHmkcul
         1XU/QFs8euEWnquGrqOPMf+MVTBeiRPC6WYVYXVu7//twcVfoP9kKgMROnFQ0lO+KCbg
         VsbPJ+gbLHD4TjeyQih1y66wSBqRlcTo7KpzDjni88atS50cLpMEsbYbinO3OVzX2QfB
         Jn+6K1HpYpeQW2PzTkrPMPIQY+fqvGt422KPGfx+deRSC4JoZiJF0vHj8jCuv3yU5eED
         qM1jizNno7pJGlbgqbHyYnxNAuffCLsvgLE2TSKAq5TcPqIhRuqZ8CqpnLfyq3TT2ucX
         41Jg==
X-Gm-Message-State: ABuFfohuzvYsektDb6wAEfQ8ft4lmHGyCLr+nsdlE6GBgQiObFOKbZTr
        4TVEtL5rNddOiwM/PLhad+2UYtzYcOARNA==
X-Google-Smtp-Source: ACcGV61y3X64Av7u/TyanXBwggX2iz3QnqOrG0IWnFR71e9iuZn7tbRT+wzZEUYh97FZMAQfC4VWOw==
X-Received: by 2002:a17:902:204:: with SMTP id 4-v6mr3515722plc.281.1537924177294;
        Tue, 25 Sep 2018 18:09:37 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id u25-v6sm5937169pfk.177.2018.09.25.18.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 18:09:35 -0700 (PDT)
Date:   Tue, 25 Sep 2018 18:09:35 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926010935.GK4364@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922195258.GA20983@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 03:52:58PM -0400, Jeff King wrote:
> On Sat, Sep 22, 2018 at 06:02:31PM +0000, brian m. carlson wrote:
>
> > On Fri, Sep 21, 2018 at 02:47:43PM -0400, Taylor Blau wrote:
> > > +expect_haves () {
> > > +	printf "%s .have\n" $(git rev-parse $@) >expect
> > > +}
> > > +
> > > +extract_haves () {
> > > +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> >
> > It looks like you're trying to match a NUL here in the sed expression,
> > but from my reading of it, POSIX doesn't permit BREs to match NUL.
>
> No, it's trying to literally match backslash followed by 0. The
> depacketize() script will have undone the NUL already. In perl, no less,
> making it more or less equivalent to your suggestion. ;)
>
> So I think this is fine (modulo that the grep and sed can be combined).
> Yet another option would be to simply strip away everything except the
> object id (which is all we care about), like:
>
>   depacketize | perl -lne '/^(\S+) \.have/ and print $1'

Thanks for this. This is the suggestion I ended up taking (modulo taking
'-' as the first argument to 'depacketize').

The 'print $1' part of this makes things a lot nicer, actually, having
removed the " .have" suffix. We can get rid of the expect_haves()
function above, and instead call 'git rev-parse' inline and get the
right results.

> Or the equivalent in sed. I am happy with any solution that does the
> correct thing.

Me too :-). Thanks again.

Thanks,
Taylor
