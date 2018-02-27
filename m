Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229771F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeB0Fqn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:46:43 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43542 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeB0Fqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:46:42 -0500
Received: by mail-io0-f196.google.com with SMTP id l12so19868837ioc.10
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 21:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASkhw6pdOjcu+tudQkZqWcMgTAVJnLmgFzeMHqYZo5M=;
        b=g+My8nhvkqv8ROIm+CRrk1miTSczv4yusVoivj0QN0d5JA2AXKcv+x7LM7j9BZbDEd
         Ei+9mjGrcZgz3rVCokncawS0afHJaPedqY8NxMXr2u/MYXAWJ/0NmEY618Eynr7MdNL1
         EYm1l59QcqvmimTFhC2Jp5iLO2Juybc279KAwlXjkbeFmuyNbgPlCNHubK3CwtRMBtZ4
         KhXhDf9b97EXrkC2DRLRcUdNPErQCpdCVRi5MKNcHS7GGpgyWcQY4K5Anuem6jvk6Gnv
         XtJSf2qjO/vTmuaFV3n3ly3s67ZYZUN3mp6y7kjSmb6fcpCzaY7u6yIU7lPRDTG5MaIa
         u2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASkhw6pdOjcu+tudQkZqWcMgTAVJnLmgFzeMHqYZo5M=;
        b=nes8aJgWX8G75H5CsyOJUY4ez7an8hYfYQ4Y8HwdeOpieT3UmVpCfTDzErY0PWjV9j
         k+vAQozIvP1nbjIgE9MXihNTL2yBxiEkmfZnMx8F218BdZMvl2VjNZBxUMU4i34czrIH
         9NgOx6VZlJ3Ja192kbXjIi6MSknY4VpwohLabqwtaQWcyUffNRaREhCHyeVSXKxQZSzo
         4hVHIVh7S4zgXxYagXNjp4rA7o2SfDg6Q7wIzgdiTY2j9Ekn9t6D+zu8xHfGpKkh9Xtb
         M+kJMB12ke89Gj4YdxErVmfsd/goRKFl+nATyFdsCIM5q94DAkwXxbPOn0Dl6jZlCNrE
         Z4+A==
X-Gm-Message-State: APf1xPCnAf6rrAz6A8Z6A7FE+i8k1JGJrxqDgD0WOKcRA7BOuy8hQRp0
        BaRVi7Q0n60j13HqFa+7KhY=
X-Google-Smtp-Source: AG47ELtVU2SAOcSt2C0wDL6wrxmBZ5+59O8JVH4tjOsh2qqGHnGoWyLeIlt2Mnf48hroF9kp8WFlIw==
X-Received: by 10.107.63.131 with SMTP id m125mr14268948ioa.211.1519710401763;
        Mon, 26 Feb 2018 21:46:41 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g3sm6653900ioj.6.2018.02.26.21.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 21:46:40 -0800 (PST)
Date:   Mon, 26 Feb 2018 21:46:38 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>, stolee@gmail.com
Subject: Re: [PATCH v2 12/27] serve: introduce git-serve
Message-ID: <20180227054638.GB65699@aiede.svl.corp.google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-13-bmwill@google.com>
 <CACsJy8BHh+Kv=om+rc6=TM60E1j9=wq4rRBvKB8HLfNTMa51Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BHh+Kv=om+rc6=TM60E1j9=wq4rRBvKB8HLfNTMa51Rg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

Duy Nguyen wrote:
> On Fri, Jan 26, 2018 at 6:58 AM, Brandon Williams <bmwill@google.com> wrote:

>> + stateless-rpc
>> +---------------
>> +
>> +If advertised, the `stateless-rpc` capability indicates that the server
>> +supports running commands in a stateless-rpc mode, which means that a
>> +command lasts for only a single request-response round.
>> +
>> +Normally a command can last for as many rounds as are required to
>> +complete it (multiple for negotiation during fetch or no additional
>> +trips in the case of ls-refs).  If the client sends the `stateless-rpc`
>> +capability with a value of `true` (in the form `stateless-rpc=true`)
>> +then the invoked command must only last a single round.
>
> Speaking of stateless-rpc, I remember last time this topic was brought
> up, there was some discussion to kind of optimize it for http as well,
> to fit the "client sends request, server responds data" model and
> avoid too many round trips (ideally everything happens in one round
> trip). Does it evolve to anything real? All the cool stuff happened
> while I was away, sorry if this was discussed and settled.

We have a few different ideas for improving negotiation.  They were
speculative enough that we didn't want to make them part of the
baseline protocol v2.  Feel free to poke me in a new thread. :)

Some teasers:

- allow both client and server to suggest commits in negotiation,
  instead of just the client?

- send a bloom filter for the peer to filter their suggestions
  against?

- send other basic information like maximum generation number or
  maximum commit date?

- exponential backoff in negotiation instead of linear walking?
  prioritizing ref tips?  Imitating the bitmap selection algorithm?

- at the "end" of negotiation, sending a graph data structure instead
  of a pack, to allow an extra round trip to produce a truly minimal
  pack?

Those are some initial ideas, but it's also likely that someone can
come up with some other experiments to try, too.  (E.g. we've looked
at various papers on set reconciliation, but they don't make enough
use of the graph structure to help much.)

Thanks,
Jonathan
