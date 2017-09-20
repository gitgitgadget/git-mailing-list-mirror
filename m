Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A9F20281
	for <e@80x24.org>; Wed, 20 Sep 2017 22:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdITWse (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 18:48:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33488 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdITWsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 18:48:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id h4so1729726pfk.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uyebRwMNxrxP068fCuOX2I80Il+rGVfuRqcCZ8qoIE0=;
        b=Fd94W/vCefu8lqmGBLRLETJj4uJuwQYUAEHz3LO7vU2Hm+9qbq1mWun7h/1X/Zw8lG
         RvM9k3QzqjPwvATQnXOOE+yUIs0mXtla2FWlf/rvBgUkskmVhMcK4CF7uPArQqbzQXnY
         wo3b7jwcTHZ7dNI857xNFe/+/ObXXLp6so9CNcy3CCW1psO1YfIIhU4oeJcK4bVFj8cQ
         KxPyMN6RNxurC/2cEmwpbo66HtKrvI+bNurwC0/9DEdInyXsYmTnpMGSwqnvqZRrZ0Q3
         P8b259kG3uOhT85d062dRltcSeF7gaVrPUpCBcgMvKx8aHn+Gp/lqKkdQe9akFSmoLPz
         C8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uyebRwMNxrxP068fCuOX2I80Il+rGVfuRqcCZ8qoIE0=;
        b=Bk3+xwXEJPhCUlFQ6wF3bSQJQcuwo1bCV9a23tANvdDzGHdPSAgDJB3BAGJCWw/2W2
         sbGShsg/eVOzrsRC1ztdK7dqUdtaGFaFIttxmRjA6vmiIO0u5nNvlP08bDap5gxzGoy6
         /fhmc/x6OjF/e9qOc2RFqhLsYDGRc8aLvbASNoLWs0lpOo/evyk+wQMTetbWjlHyPOQL
         M2ub8v/TmK6T65MZPqbIlFAvmCaARaGkhrNeTvhZlpVtgx2t+pDkR2UEMVUKHBoFa6o2
         2JpLMCdFdkJoEtHL/c2HeJqfte5c9rzspxR8HCmrFx602l60ScPjduggEuwopoZJsvBX
         qQRQ==
X-Gm-Message-State: AHPjjUikuvd6yVAdNwlFJ9PHUqA8KAF8b0KfjiFpuAy550Rb5H5qMuWD
        ZdNmvsSWl3QaR3ksPx3qkaE=
X-Google-Smtp-Source: AOwi7QDchM5lAXXe0zlSCML+CGSgeVcKsNfGlP5aUGKPy47GFsv7+Ywt53TFbySZW7axgfiTqoMJhA==
X-Received: by 10.98.34.149 with SMTP id p21mr3698756pfj.322.1505947710066;
        Wed, 20 Sep 2017 15:48:30 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:da9:ac38:cdcf:de91])
        by smtp.gmail.com with ESMTPSA id b63sm8566pga.27.2017.09.20.15.48.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 15:48:28 -0700 (PDT)
Date:   Wed, 20 Sep 2017 15:48:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with
 argv_array
Message-ID: <20170920224826.GH27425@aiede.mtv.corp.google.com>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net>
 <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> Subject: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
>
> We assemble an array of strings in a custom struct,
> NULL-terminate the result, and then pass it to
> parse_pathspec().
>
> But then we never free the array or the individual strings
> (nor can we do the latter, as they are heap-allocated when
> they come from stdin but not when they come from the
> passed-in argv).

To be devil's advocate for a moment: why don't we use UNLEAK on the
paths passed in from stdin?

It's true that there can be an unbounded number of them, but they all
coexist in memory anyway.  They are not generated dynamically on the
fly.  Being able to free them doesn't have any obvious advantage over
using exit().

Except... is the idea that this allows the strings from stdin to be
freed sooner, as soon as they have been parsed into a "struct
pathspec"?

That sounds appealing.  The only risk would be if "struct pathspec"
holds on to a pointer to one of these strings.

Fortunately parse_pathspec() is careful to strdup any strings it
borrows (though it is not documented to do so).

In other words, proposed changes:

 1. Could the commit message describe what effect this would have on
    maximum heap usage, if any?  (In qualitative terms is fine, though
    actual numbers would be even better if it's easy to get them.)
    That would make it easier to justify not using UNLEAK.

 2. Can parse_pathspec get a comment in pathspec.h saying that it
    defensively copies anything it needs from args so the caller is
    free to modify or free it?  That way, it should be more obvious
    to people in the future modifying parse_pathspec() that callers
    may rely on that.  (The current API comment describes argv as
    "command line arguments", which I fear would send the opposite
    message to implementors.)

> Let's swap this out for an argv_array. It does the same
> thing with fewer lines of code, and it's safe to call
> argv_array_clear() at the end to avoid a memory leak.
>
> Reported-by: Martin Ågren <martin.agren@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  revision.c | 39 +++++++++++----------------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)

The code looks good.

Thanks,
Jonathan
