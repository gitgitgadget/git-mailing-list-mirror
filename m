Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145BF1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbeGJP4l (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:56:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:53818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933796AbeGJP4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:56:40 -0400
Received: (qmail 23689 invoked by uid 109); 10 Jul 2018 15:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 15:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27990 invoked by uid 111); 10 Jul 2018 15:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 11:56:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 11:56:38 -0400
Date:   Tue, 10 Jul 2018 11:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/9] gpg-interface: add new config to select how to
 sign a commit
Message-ID: <20180710155638.GC23624@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <911565bda250ebffc9a87203f2a5ae453f87e5da.1531208187.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <911565bda250ebffc9a87203f2a5ae453f87e5da.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:52:25AM +0200, Henning Schild wrote:

> @@ -138,6 +139,12 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "gpg.format")) {
> +		if (strcasecmp(value, "openpgp"))
> +			return error("malformed value for %s: %s", var, value);
> +		return git_config_string(&gpg_format, var, value);
> +	}

I know we discussed names and case-sensitivity a little bit off-list.
FWIW, this name looks good to me.

-Peff
