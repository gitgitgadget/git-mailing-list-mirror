Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F501F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeC2BbT (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:31:19 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40700 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2BbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:31:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id y66so2066501pfi.7
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4Pgv8wiq1HXgcgnrX/qh+GlATJXXICNBLK8SEn8HkU=;
        b=HhUmZJH29LLzP3fffK0vhf+eZgXpslnw4Mk/wqWmeV+SWR1vEw42Gl+S5v083k39/f
         KQXxzJikkC+Nf6lZkbE1Ci0uYWOGVRx258YvKT9kf6fEvOB3D4LpG4+mmzy4OiIApIm0
         Jk0jYlt+nG9vvCNfNZHdOdCdYKjI0DjF2lbvMTxLEyhIp7T1dw7lrE1akoHwGks94SKw
         E3nnh69kl25m+/839GNvEo8Ruu6xRYZRwR8smc/4Zqm0qNlM2VhrY1BgibwesF7U5N2H
         MImRvSoelFXbtOAUgdowUWFJNhpCdzyBMdRZSW8y2nQLDCWGy1yCTzDW1fhr5d18vN1h
         DzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4Pgv8wiq1HXgcgnrX/qh+GlATJXXICNBLK8SEn8HkU=;
        b=WYURIp3yW6x2NZcONUSBBxgpadRId96YHQCzkj8E56G8gwBmPzRZ7C0CqhTD5tRI6p
         B+UcBCAt1GZ9dXTbrSaUv4d8RAr+eYC0XA6EPVsavUn5vr3hwcjPAsKj3ueIZ9Ninfah
         MtIyDwHFbGI3YlGrU77iHCXjcMY5gnKnTpI6FRcQmw3IDUF/KSPFnRtBWvITfefGQQs4
         2mOCdo6/8wV3nE4uByTtL/QC4dMcWuS2ZPMl8ja59voeOrYo1fe2DwfiaO92Ap74e9nO
         m+/epEg//6JnSTjldViKRA5e6uD0z19SlqKRm0t8gGoVJpAXvbSXLPf3capNjOy8tjW2
         m2QA==
X-Gm-Message-State: AElRT7EMsJ56t7AH2u9SR7FICHCJaIBulK6tizdCxfottmh5gA455VkN
        UFmLP29Iuwrx4CHF5SnFz6h/lZhLqME=
X-Google-Smtp-Source: AIpwx49y3KCzfj+k7MvIoAEbvmkS7WjFE0uaQAFBK5wCXev7zZLSTPYnQkKpiaJ5XugsT+JIj5/Aeg==
X-Received: by 2002:a17:902:341:: with SMTP id 59-v6mr5852397pld.407.1522287078323;
        Wed, 28 Mar 2018 18:31:18 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id z78sm9585419pfd.23.2018.03.28.18.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:31:17 -0700 (PDT)
Date:   Wed, 28 Mar 2018 18:31:16 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/4] builtin/config: introduce `--default`
Message-ID: <20180329013116.GB71044@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
 <20180324005556.8145-2-me@ttaylorr.com>
 <20180326083442.GB18714@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326083442.GB18714@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 04:34:42AM -0400, Jeff King wrote:
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > index e09ed5d7d..d9e389a33 100644
> > --- a/Documentation/git-config.txt
> > +++ b/Documentation/git-config.txt
> > @@ -233,8 +233,10 @@ See also <<FILES>>.
> >  	using `--file`, `--global`, etc) and `on` when searching all
> >  	config files.
> >
> > -CONFIGURATION
> > --------------
> > +--default value::
> > +  When using `--get`, behave as if value were the value assigned to the given
> > +  slot.
> > +
> >  `pager.config` is only respected when listing configuration, i.e., when
> >  using `--list` or any of the `--get-*` which may return multiple results.
> >  The default is to use a pager.
>
> Hmm, what's going on with the CONFIGURATION header here?

My mistake, I have correct this erroneous diff in v3. Thanks for
pointing it out!

> For the description of "--default" itself, do we want to say something
> like:
>
>   When using `--get` and the requested slot is not found, behave as
>   if...
>
> That is hopefully a given from the name "--default", but it seems like
> an important point to mention.

Ditto.

> > +test_expect_success 'marshals default value as int' '
> > +	echo 810 >expect &&
> > +	git config --default 810 --int core.foo >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'marshals default value as int (storage unit)' '
> > +	echo 1048576 >expect &&
> > +	git config --default 1M --int core.foo >actual &&
> > +	test_cmp expect actual
> > +'
>
> I'm not sure what we're really testing in the first one. The storage
> unit conversion is the interesting bit.
>
> TBH, I'm not sure we need to separately test each possible type
> conversion here. If we know that the type conversions are tested
> elsewhere (and I would not be surprised if they're not, but let's assume
> for a moment...) and we check that type conversions are applied to
> "--default" values for some types, I don't think there's any reason to
> assume that the others would not work.

Agreed. I don't think that this test (and the ones that your comment
below concerns) are testing anything meaningful, or that would catch any
interesting future regressions. I have removed them from this series in
v3.


Thanks,
Taylor
