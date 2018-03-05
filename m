Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDCD1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCESV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:21:59 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:36019 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCESV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:21:58 -0500
Received: by mail-pl0-f54.google.com with SMTP id 61-v6so10152278plf.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SwVfM5Fe6N+ju3a1d1A4GUTz2WEk5g9tkjuEdY4m8NI=;
        b=hbiLnhlyfwm28SRsduUx1NLzZ3eHvy1DRGDvaR/qC4XU7SHggb1rCd48Vbj1EWMqvq
         pBZVm2DIiiJphZRnH6erUnVEaP0FMiESaxwCOuXr1EhhEncjhgcLdMXmWwmrv2y+7ev3
         8jAMSd8nQyRtpjUUwSNNwRbrcR+KkOGd1bzFX8+z1y8uZGFrkfoGH+u6WOIcHOL1vYY4
         OU09vxBjp1WevNMIXKgQcKcJuAqWeYYWNKNcLJsxXUPPXQ8gCauudKvN+hijkJU45NhE
         zxXYlr9lHL2DI4yM3BuTDjR529NzdnycHuKKBTBdPVF2UnenmPeqkVMxv33TzGVJXnVo
         y6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SwVfM5Fe6N+ju3a1d1A4GUTz2WEk5g9tkjuEdY4m8NI=;
        b=hJAD7x5CNDiguQDNOiPUsG5UX9mpYo33dyuy6v+FpAYCzJcZJw4C3qPDUbW9hrLzk3
         3a+/p/VT5aOSKLV2H3Jz2YAr7Rts/qvQrA86O+nTg/zkFD7FdJXpJJbAbVxCP3ClLnc/
         JcyLY+n8HqEZyOSmco9CpoDi7cCo+wyUm4DYq+jMjyBASgiTbfFr6sEYA05SJMgIUkDT
         NJmuh4h+G0759UUrZMXDLQJ7xD6KPwaT8K3gi9Zy4vws+Ry7EiOo4owPY+eR10X/ny8W
         7F2QL8ONDtPIj3pnyDI4oxALGgbhBOXjkug2rYgTzgbBmAEgArWbSGao39zXMTCbEzpA
         9sNA==
X-Gm-Message-State: APf1xPDdMxbwDcphIfN0LxRr1W8uLlHsJZQoXQ7j33Q/mJkpQK84gtT2
        VQ8E4sW/k/ay3bUhUC8Evv34SA==
X-Google-Smtp-Source: AG47ELs9f3QciwBYQUenMGloZ5fN72/9RxtklsoZKrHni+4Ef12q2SGBR0Y6KyngUKNZmiw8Z6y67w==
X-Received: by 2002:a17:902:3124:: with SMTP id w33-v6mr14305495plb.119.1520274117272;
        Mon, 05 Mar 2018 10:21:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z6sm11587645pfe.187.2018.03.05.10.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:21:56 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:21:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180305182155.GB72475@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <20180303044338.GD27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303044338.GD27689@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Jeff King wrote:
> On Wed, Feb 28, 2018 at 03:22:30PM -0800, Brandon Williams wrote:
> 
> > +static void add_pattern(struct pattern_list *patterns, const char *pattern)
> > +{
> > +	struct ref_pattern p;
> > +	const char *wildcard;
> > +
> > +	p.pattern = strdup(pattern);
> 
> xstrdup?
> 
> > +	wildcard = strchr(pattern, '*');
> > +	if (wildcard) {
> > +		p.wildcard_pos = wildcard - pattern;
> > +	} else {
> > +		p.wildcard_pos = -1;
> > +	}
> 
> Hmm, so this would accept stuff like "refs/heads/*/foo" but quietly
> ignore the "/foo" part.

Yeah that's true...this should probably not do that.  Since
"refs/heads/*/foo" violates what the spec is, really this should error
out as an invalid pattern.

> 
> It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
> it's worth going for the most-restrictive thing to start with, since
> that enables a lot more server operations without worrying about
> breaking compatibility.

And just to clarify what do you see as being the most-restrictive case
of patterns that would should use?

-- 
Brandon Williams
