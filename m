Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6F01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934833AbeFYSIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:08:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45318 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934731AbeFYSIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:08:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id o18-v6so6497537pll.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AuAcm3gQeEuDW061nLDe8kjrI3NOi7rlBEstFUVI7v0=;
        b=AQrOHkW7MMH4t95r3+rz5RfvyCdzwwiW/Z3m9MaQkBuU5ksec//27zRy9H4vMgaivG
         wNgps9prAe3VSm1PqTuz6jSJjAXHdW3YFKOy++NUdJM4PpwsVIU2lWf13yx4b+p9Cxa1
         M+XgnoavWYO5ZZ9bW4RhkreoRdm3N7qx6muB48sn8WpNiQlWzjOR6qZTgvY9PYBJ0DVG
         OyW/2jinVzq/4Viq6NyTPnHlkjJcevBW26t633wUE7CIynZ3gSJOxmikGKe0VOpDunQH
         RfeDEm5Rpp5d2RjkwC+JrYgecIbbWnOagjmczgXHPfDSq7dtSthC5t+8KSykX7NgthuQ
         R03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuAcm3gQeEuDW061nLDe8kjrI3NOi7rlBEstFUVI7v0=;
        b=bT9z33I2nz05XNf1zkE9H4n1x0+oRSeLQlLTggpCdOoqkHk2WYxqBZ7AfvqY1btE4I
         pqIcHTdwX0vdv4hk7Li3A+i5YA2ZisnOMwQHKXU43IBXXQGaEvkQc8P9WrBUmgnK6XFJ
         RJtxOCQw7UQbckOQ63xZu8izRo6KK3XWvDbrWo0Rx9p1tLuwJi2+zyDzfnVLD9anf+pP
         wfaSsUNTkjbBqEVAZKrX50Myc2tjmqGlCh1cGJgZXcv07FmNqqTiRFADgVixaQ32TAC9
         glHmOXAtPUOByIdUqfFdaMIZjmcL3BDdoJFR5M28SDJRFKpRCJ5bjiF+PeH7NmBMY2mz
         Onlg==
X-Gm-Message-State: APt69E3pXulaKFkhGdfi8+GNhLjCNWamy/qTu/ZEh3AJ3HjbX0/falkU
        Hjz3HHYU7MYQo5ys3qskPfJcpw==
X-Google-Smtp-Source: ADUXVKKqTLYkcpatHUXDRxaeCy38SLznUkRPxg+96cvqBe3LtdpLt3tQ1tLSXNYd7SDP76mNEKrOhQ==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91-v6mr13445927pld.27.1529950131895;
        Mon, 25 Jun 2018 11:08:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j3-v6sm19809080pgp.47.2018.06.25.11.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:08:50 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:08:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v3 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180625180849.GA19910@google.com>
References: <20180613213925.10560-1-bmwill@google.com>
 <20180620213235.10952-1-bmwill@google.com>
 <20180620213235.10952-9-bmwill@google.com>
 <20180622230119.GL12013@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622230119.GL12013@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Implement ref-in-want on the client side so that when a server supports
> > the "ref-in-want" feature, a client will send "want-ref" lines for each
> > reference the client wants to fetch.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  fetch-pack.c                       | 35 +++++++++++++++++++++++++++---
> >  remote.c                           |  1 +
> >  remote.h                           |  1 +
> >  t/t5703-upload-pack-ref-in-want.sh |  4 ++--
> >  4 files changed, 36 insertions(+), 5 deletions(-)
> 
> This commit message doesn't tell me what ref-in-want is or is for.  Could
> it include
> 
>  A. a pointer to Documentation/technical/protocol-v2.txt, or
>  B. an example illustrating the effect e.g. using GIT_TRACE_PACKET
> 
> or both?

Yeah I can imporve the message here.

> > +
> > +		for (r = refs; r; r = r->next) {
> > +			if (!strcmp(end, r->name)) {
> > +				oidcpy(&r->old_oid, &oid);
> > +				break;
> > +			}
> 
> Stefan mentioned that the spec says
> 
>         * The server MUST NOT send any refs which were not requested
>           using 'want-ref' lines.
> 
> Can client enforce that?  If not, can the spec say SHOULD NOT for the
> server and add a MUST describing appropriate client behavior?

Yeah I can update the docs in an earlier patch.

> 
> > +		}
> > +	}
> > +
> > +	if (reader->status != PACKET_READ_DELIM)
> 
> The spec says
> 
>         * This section is only included if the client has requested a
>           ref using a 'want-ref' line and if a packfile section is also
>           included in the response.
> 
> What should happen if the client already has all the relevant objects
> (or in other words if there is no packfile to send in the packfile
> section)?  Is the idea that the client should already have known that
> based on the ref advertisement?  What if ref values change to put us
> in that state between the ls-refs and fetch steps?

I believe the current functionality is that if all wants are already
satisfied by all haves then an empty packfile is sent, so that would
fall under that case.


-- 
Brandon Williams
