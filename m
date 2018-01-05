Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E631F428
	for <e@80x24.org>; Fri,  5 Jan 2018 23:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeAEX4D (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 18:56:03 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37620 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeAEX4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 18:56:02 -0500
Received: by mail-pf0-f196.google.com with SMTP id n6so2814025pfa.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 15:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVKr9150gwZzlKN3zFJ3UOPixH/W1G2u6u7f3rvD4QU=;
        b=dBEDYxJIfhUEWrttV/3fHzpvyVISEaJdxBiffTKSqu3HQl+dePsfmpDZFoj/W+MzEx
         QudPBa3OdOvbrT9YygCXL1NPLcdvoKXaSOeOOa+PLQNPgYWemKFGski8SGwUTocisKOn
         KWFv+TjxstSA6E5nHCv71dy+aeu75zDvdeFOu4g/a+hlynFdnJqmCWQHDGp7m+7Fyb/g
         BSgtFxZfu91C3nTgx5gwU2nKJA2E4i62pK5ijoRPezj3Z8SDS4eXgbCCUbRVRMmVjPM4
         OVEeBy83Ylg6ID96knc6j4s+plNh8c1m0DhFu2P8HTQgDOOtaWv3y/oib6oay/Qp6TJ6
         aU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVKr9150gwZzlKN3zFJ3UOPixH/W1G2u6u7f3rvD4QU=;
        b=XagYOrmx3CjOtdDFAJK9CwVnyXQACE98yKvd4QLOlTePzVgg69YiUYyD4VYtzdfngO
         uZ+EvBb0Q9RzPB9iVlIFG3aSxuCAzoTrBsMB4TkZD37Jxyt+nsZ7AgOeC+DxdPGh694u
         wnIak3ylcLVcDeMelXjxRDDm5xzFe3ToebRTmwXW68Gsje4uoRCaNO+BNXWEX8SZOkPS
         AJYm/35B/69z9RnkfRBetAkoMO75JhnvSn/Qsmieom0CSPoG04lj4RdArO35UVaS5JGc
         TiepLvvIaqcWwL6EQ2HvR/Mz/pjMj2o4ogzYwwhVwdOBXp6wvFciqAobZlQ/juxev0Ud
         75MQ==
X-Gm-Message-State: AKGB3mLcvbUEvLakAtGAOFSY/A4IxgXxXTGjX1Hkf665tj2+/yS/hMjj
        0sIRpnME7EiPN5KhATKFlZONqA==
X-Google-Smtp-Source: ACJfBose5rx8giw57UmgaE9Gbo9qpbufWUAARGqFaIMt7nHAsrnYHXyVYZV0caIr5jFuA2mhXEsZHw==
X-Received: by 10.98.192.149 with SMTP id g21mr4320350pfk.49.1515196562158;
        Fri, 05 Jan 2018 15:56:02 -0800 (PST)
Received: from google.com ([2620:0:100e:422:b962:214:60b3:c1cf])
        by smtp.gmail.com with ESMTPSA id t66sm17348558pfa.153.2018.01.05.15.56.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 15:56:01 -0800 (PST)
Date:   Fri, 5 Jan 2018 15:55:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 20/26] fetch-pack: perform a fetch using v2
Message-ID: <20180105235559.GC172942@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-21-bmwill@google.com>
 <CAGZ79kbM4Jk=aHJu7+U3AcgFMh0-jbbu4RPLUkKwM0mDWge+gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbM4Jk=aHJu7+U3AcgFMh0-jbbu4RPLUkKwM0mDWge+gA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Stefan Beller wrote:
> On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> > +
> > +#define FETCH_CHECK_LOCAL 0
> > +#define FETCH_SEND_REQUEST 1
> > +#define FETCH_PROCESS_ACKS 2
> > +#define FETCH_SEND_HAVES 3
> > +#define FETCH_GET_PACK 4
> > +#define FETCH_DONE 5
> > +
> > +static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
> > +                                   int fd[2],
> > +                                   const struct ref *orig_ref,
> > +                                   struct ref **sought, int nr_sought,
> > +                                   char **pack_lockfile)
> > +{
> > +       struct ref *ref = copy_ref_list(orig_ref);
> > +       int state = FETCH_CHECK_LOCAL;
> 
> Is there any reason to use #defines over an enum here?
> 

No, it would probably be better to use an enum, that would also get rid
of the default case of the switch statement.

-- 
Brandon Williams
