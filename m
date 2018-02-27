Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6CB1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeB0TqI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:46:08 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:39981 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB0TqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:46:07 -0500
Received: by mail-pg0-f49.google.com with SMTP id g2so2589pgn.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w8O7lT/6OvXXiDZhGHC/7ZQF6Uie+7es4f8mAHaV85g=;
        b=hUvTtPs7lyyvXXde5LJfmFcr6WFC3hCbuPvQgeZiNZZI+83w+LQZLtLrIwy9Rm1zj5
         pFb1hUnFMoFNiWWz/hR37sQT4qfJJZctVdBMVGcxOnmer3klYibFzsVWzy3mRIKsH+K/
         N830RZivtai5+E/+H06jl5urfk5pTmzoCkILNgDTkjCrbDvEhfEitenTO69NXURUz4ee
         ZWkRbbVUMAZ93RitgdDmIb6KpmWZf37DNE1ca6u1kZEmdsT6CVW0fecwwcUKU4lEi9o1
         Cu9ND+TbPwcphP3/RvCJ26/uYT+pMuowngEOoBeoQk8+4ssMF3vt/qTMJH94dtegZW/m
         nq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8O7lT/6OvXXiDZhGHC/7ZQF6Uie+7es4f8mAHaV85g=;
        b=XHqWP7pyDPgMsOi/DVgXrwoSfcL0cJhrHuzKUiDpIgOzmOGEh6DrWZK1kUdIK/tdbF
         4+qZqEeVLaoY5P3LWYp5WFxxzvat1GtuLtf3XDqiyZKiJV36wJ530BUsTOB0PkwnzMZY
         X8LHVzEtx0QRdCgUvG74fET7KNmZ3Je+SeOog7dsr+3pqawusC3ivTPdY6xyBcMQ+Rr0
         54NLjKhaTfo3i8wid0gixOKl/+sbxM8K8PRWkTSbMn5yYSFQqwVuVDs8nC2dWjOMAm4w
         IIpufUVm4uAqPu/8ueiW8nqS+zT8/JtLUE9NqI5bsdPiRbheaLTnWGWC2loupXxLHEo4
         MkSA==
X-Gm-Message-State: APf1xPBSkhaigWc+JVS9jG5K8LC6Ol7DTgCVKyDzIsinkrSbODlnqMA5
        Ft+3RQNB/5yM2Jcu5QdMJAtTXSVIFa4=
X-Google-Smtp-Source: AH8x227/elQbyqRXeylQl4rBpHV4E26+5p2NNdYhBngX5f7XaBt2yy+CozDQ8iCFbcb4C0ublcpE+A==
X-Received: by 10.98.247.9 with SMTP id h9mr15187912pfi.212.1519760766881;
        Tue, 27 Feb 2018 11:46:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k192sm13023645pfc.98.2018.02.27.11.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:46:05 -0800 (PST)
Date:   Tue, 27 Feb 2018 11:46:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 06/35] transport: use get_refs_via_connect to get refs
Message-ID: <20180227194604.GI209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-7-bmwill@google.com>
 <20180227060840.GD65699@aiede.svl.corp.google.com>
 <20180227181715.GC209668@google.com>
 <20180227192514.GC174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227192514.GC174036@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:
> Brandon Williams wrote:
> > On 02/26, Jonathan Nieder wrote:
> >> Brandon Williams wrote:
> 
> >>> +++ b/transport.c
> >>> @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
> >>>  	args.cloning = transport->cloning;
> >>>  	args.update_shallow = data->options.update_shallow;
> >>>  
> >>> -	if (!data->got_remote_heads) {
> >>> -		connect_setup(transport, 0);
> >>> -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> >>> -				 NULL, &data->shallow);
> >>> -		data->got_remote_heads = 1;
> >>> -	}
> >>> +	if (!data->got_remote_heads)
> >>> +		refs_tmp = get_refs_via_connect(transport, 0);
> >>
> >> The only difference between the old and new code is that the old code
> >> passes NULL as 'extra_have' and the new code passes &data->extra_have.
> >>
> >> That means this populates the data->extra_have oid_array.  Does it
> >> matter?
> [...]
> > I don't think its a problem to have extra_have populated, least I
> > haven't seen anything to lead me to believe it would be a problem.
> 
> Assuming it gets properly freed later, the only effect I can imagine
> is some increased memory usage.
> 
> I'm inclined to agree with you that the simplicity is worth it.  It
> seems worth mentioning in the commit message, though.
> 
> [...]
> >>> @@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
> >>>  	struct send_pack_args args;
> >>>  	int ret;
> >>>  
> >>> -	if (!data->got_remote_heads) {
> >>> -		struct ref *tmp_refs;
> >>> -		connect_setup(transport, 1);
> >>> -
> >>> -		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
> >>> -				 NULL, &data->shallow);
> >>> -		data->got_remote_heads = 1;
> >>> -	}
> >>> +	if (!data->got_remote_heads)
> >>> +		get_refs_via_connect(transport, 1);
> >>
> >> not a new problem, just curious: Does this leak tmp_refs?
> >
> > Maybe, though its removed by this patch.
> 
> Sorry for the lack of clarity.  If it was leaked before, then it is
> still leaked now, via the discarded return value from
> get_refs_via_connect.
> 
> Any idea how we can track that down?  E.g. are there ways to tell leak
> checkers "just tell me about this particular allocation"?

Hmm I wonder if that code path is even used, because it just throws away
the result.

-- 
Brandon Williams
