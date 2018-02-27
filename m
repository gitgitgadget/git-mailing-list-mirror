Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2027D1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeB0SRS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:17:18 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33784 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB0SRR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:17:17 -0500
Received: by mail-pf0-f195.google.com with SMTP id q13so8286031pff.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+w7eDMLj1iY/rsbpLpcJPnHu6RUqQu3iUVLZk88Bnxg=;
        b=bHO+4hVsx3qdOLBJ+VN+FRnmYqG/SsHRtm92YIR6dGLO7a7IX8TTowrYDkB/l/SspF
         8Jjt4HmMw4xHtxLcfxBFBalWNJMIXTBCXjPR0gFsc00JZcqZN3/0w/JTscKaAyu/sa1Q
         /Cm7bivejzujY4/KU0rO5M0ikNj71QT/0JWJdtYqoOaarKNIqLx+Na6oOJe9qTOggpHp
         DE7YAtu8eSbHoq7DlBzplskWf4iT97olIYkHHwRHGUvPv58oJL2pO0+R8Ip7U88pa4y+
         jkCm3aBjeSzCVpkxWstmknPpayobYrb7Q7ejobfVTKgUTbKg2Jm4gWJT3nZJpYZJ7j7h
         X9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+w7eDMLj1iY/rsbpLpcJPnHu6RUqQu3iUVLZk88Bnxg=;
        b=maqzohiQGIqXO/jxyPo/BkkOg6MfGEZ9HLznVS73FRbyLyLNcyWF6aPPixTtoEuWL9
         MFHMkoGNbEWRIgjq+qQ3lO5yInH0Jo44NlR2qA/QG7hmgZKuBeO31yEeWniJcIuk9oE+
         wd2J40gvSts08wywYJcNnWDJ1y0Pee71+LYr0I/oUTa6vyjOIq1Pgwds9xvGjdFrNF7D
         D4Y48mCQQ2o1GsIlPT1J+h14x+sVr7FBFYXxu1BKb5AMYj09lzP51DqFQKM58md03E3R
         02vrAe/615mT9cz97GZpwJlrZawALhO69B0Twl/czDRQd1RZaWSb4nm60A6VkbV64d/I
         VuAw==
X-Gm-Message-State: APf1xPBa7h4Jxpu0nj0aso5Po6zgPK6CQsN0D5lcFS6wmP0UTE0Neg0U
        thPv4HBX7WVeZeUO0b5Qrcy/AEXJtP0=
X-Google-Smtp-Source: AG47ELvw/cr4ffl/xYSTfKT/7ep7tX/7MqIZVVynCtNIog42QKLxlZN8u82y3B6yJS3uP53b/JVnIQ==
X-Received: by 10.101.98.137 with SMTP id f9mr4583251pgv.6.1519755437210;
        Tue, 27 Feb 2018 10:17:17 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f5sm17704129pgo.58.2018.02.27.10.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:17:16 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:17:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 06/35] transport: use get_refs_via_connect to get refs
Message-ID: <20180227181715.GC209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-7-bmwill@google.com>
 <20180227060840.GD65699@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227060840.GD65699@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Remove code duplication and use the existing 'get_refs_via_connect()'
> > function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> > 'git_transport_push()'.
> > 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  transport.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> I like the diffstat.
> 
> [...]
> > +++ b/transport.c
> > @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  	args.cloning = transport->cloning;
> >  	args.update_shallow = data->options.update_shallow;
> >  
> > -	if (!data->got_remote_heads) {
> > -		connect_setup(transport, 0);
> > -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> > -				 NULL, &data->shallow);
> > -		data->got_remote_heads = 1;
> > -	}
> > +	if (!data->got_remote_heads)
> > +		refs_tmp = get_refs_via_connect(transport, 0);
> 
> The only difference between the old and new code is that the old code
> passes NULL as 'extra_have' and the new code passes &data->extra_have.
> 
> That means this populates the data->extra_have oid_array.  Does it
> matter?
> 
> > @@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
> >  	struct send_pack_args args;
> >  	int ret;
> >  
> > -	if (!data->got_remote_heads) {
> > -		struct ref *tmp_refs;
> > -		connect_setup(transport, 1);
> > -
> > -		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
> > -				 NULL, &data->shallow);
> > -		data->got_remote_heads = 1;
> > -	}
> > +	if (!data->got_remote_heads)
> > +		get_refs_via_connect(transport, 1);
> 
> not a new problem, just curious: Does this leak tmp_refs?

Maybe, though its removed by this patch.

> 
> Same question as the other caller about whether we mind getting
> extra_have populated.

I don't think its a problem to have extra_have populated, least I
haven't seen anything to lead me to believe it would be a problem.

-- 
Brandon Williams
