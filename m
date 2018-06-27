Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466521F516
	for <e@80x24.org>; Wed, 27 Jun 2018 20:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965654AbeF0Uqg (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 16:46:36 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:46821 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965010AbeF0Uqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 16:46:33 -0400
Received: by mail-pg0-f41.google.com with SMTP id q14-v6so1421378pgt.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OTFvzZEZSn1C4cSxK73AEQtBGhURCjvSUAkIFRpG7FU=;
        b=sGRRKHI0W8s1szDEwkeKodZ77TgDK76B6ICIlsRAIaY9Kn/wzSFnmQD9R9ZbQW8GNw
         jDUitFgFKbAune6uTN0uSJI1x+lS8Gqs6zxxLcYNAX/o/hREhEeQhlxV3/hzEDpZAXjS
         SF5aPeP5l57tG0alF0cgZHoYOFbD0dK1Ez2IeMeWzZi4OK8s79vlUJzxWZqlyj/OQjpe
         xaXPVQtOPKZ5qItV0dRwU+R5Gd5MvXzuS+dyFzrdjx7i8FHqlLL7mgt1v5K69fxWFERZ
         Hpti5PQUxLf0JVIOojtAb8Ie/Vv7Fj/GUknzXOpiuxHzTtgC9oC02wDm1H6Oh/rJvIiX
         jwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTFvzZEZSn1C4cSxK73AEQtBGhURCjvSUAkIFRpG7FU=;
        b=JBZt4LRDPR3f0I7Y7jdURYqboJV/8E+2A35l7l8BmDROe+B4YjUGS0a5OOjEn8g4aa
         nuHOG4PS+2ThAiryi6CIXhyXXR/7bZ4mtsvuXjXauTRCokeIniBi0sZrbrujEZUlaE0v
         K+ksrHOBZh0HdfjakIvBhThLjxWWZVwjFWP04yl5r3sQioIo69TtjIOIxnVpuhenZ91M
         EN+huoa2bx9zZ2k3xZM0zzXxQ59RRYaholwl1XkchFBfS06BOG2FxoPQY2iA4dMZYJ3H
         C552LH5Het0Aolb7iB9lGmSwGJBxNoSrSWLKhDXUnWQNr7LRNccQcLu+Yty5igxAYTSN
         ULJA==
X-Gm-Message-State: APt69E2tlwTuDO65sqCdwtcrrq4C7bl7cPkAcUKHyaSbUMZV4EQas8aP
        e0I2jaxcxx9hT71aO4mvTOpOGw==
X-Google-Smtp-Source: ADUXVKJ9Q/kAwgIDTLXVzeDn41aufWkO87oDeXpaK+9YEIuYRrwp9nh4su9yCtISgxaCssaiYxqnVQ==
X-Received: by 2002:a65:560a:: with SMTP id l10-v6mr6530940pgs.130.1530132392483;
        Wed, 27 Jun 2018 13:46:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p12-v6sm11092682pfi.175.2018.06.27.13.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 13:46:31 -0700 (PDT)
Date:   Wed, 27 Jun 2018 13:46:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
Message-ID: <20180627204630.GK19910@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
 <20180626205438.110764-1-bmwill@google.com>
 <20180626205438.110764-3-bmwill@google.com>
 <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
 <20180627180557.GG19910@google.com>
 <xmqq7emkf4da.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7emkf4da.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> > +	* The server SHOULD NOT send any refs which were not requested
> >> > +	  using 'want-ref' lines and a client MUST ignore refs which
> >> > +	  weren't requested.
> >> 
> >> Just being curious, but the above feels the other way around.  Why
> >> are we being more lenient to writers of broken server than writers
> >> of broken clients?  The number of installations they need to take
> >> back and replace is certainly lower for the former, which means
> >> that, if exchanges of unsoliclited refs are unwanted, clients should
> >> notice and barf (or warn) if the server misbehaves, and the server
> >> should be forbidden from sending unsolicited refs, no?
> >
> > Ok so should I change the server part to "MUST NOT" and the client part
> > to "SHOULD"?  And I can add code to die when we see refs that weren't
> > requested, but i feel like if we add an ability to request a pattern in
> > the future this will completely change, which is why I currently have a
> > client just ignoring anything else.
> 
> I did not have enough information to give an answer to "should I do
> X?"; that is why I asked these questions prefixed with "Just being
> curious".  I do not quite get a good feeling that I now know enough
> to answer, still, but let me try.
> 
> If we anticipate backward incompatible changes between this early
> WIP stage and the final completed protocol, it would be GOOD to make
> sure that an early WIP clients/servers fail when seeing the other
> side gives them something they do not understand, no?
> 
> So...

Yeah after thinking more about this I agree, we should have the client
fail out and require that the server MUST not send additional refs.
This can of course be loosened through a capability if we want to do
something else in the future.  Thanks for sanity checking me :)

-- 
Brandon Williams
