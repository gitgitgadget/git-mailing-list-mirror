Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A689920441
	for <e@80x24.org>; Wed, 28 Dec 2016 18:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbcL1SNj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 13:13:39 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34086 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbcL1SNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 13:13:38 -0500
Received: by mail-pf0-f182.google.com with SMTP id c4so59460300pfb.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zfWU5F+qfM1NOsi5gZXChMCSNxb3s1fwv+SlUt58dMo=;
        b=q98GXRSmYIf6Ksji3L+E9RgMir2lBQYsbmdoUMIbpfkP2uHAGiPHFn0FdslmUSB9kH
         HfDnOFHQfZdTQs1SReazXq8YMPdPUApBfZdhrTsOunqFMQtpSruGyHc1IlXQBA7qDwob
         6QO4EzwMpjJbRYVR94y3ftt1cfjbqIU4rRn2Qw9egAtJXT87nIAnSFuxGk1mM5yFlGve
         TfoieLGlo1OZxug2+Hn4h3Pad34f+Hjj9ILCEQKd2qaBO6uEgpi00VuNiCwVxNHpnPsC
         82OHoiBqRy275QccZe/cHXBtc8o3uAQSfvnfn+cK5HBLJBusAce9ZowqeG2P/FLCVIo2
         956Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfWU5F+qfM1NOsi5gZXChMCSNxb3s1fwv+SlUt58dMo=;
        b=jlMOXfRVmS/VyyU0PaCGhH4RaI8ElMEPZv/+MRZAkvNdWABFZt/5zHXClRGG3bVykb
         XJ1Ig6Wax7bLRtOxOkQWjP8BZY8n+mkij2fDR9ohbtpibb9BP5NHpjz55kToCM88tjT6
         LKG1c4MPEXKDmiEDNErVz/8ObV+6dSrpGzP85iS3kzJXzWr9XnFzlSQIr9dR0CqMtDdU
         HEJw++hWWHV9D0BavpLEmOQpi10AWlbgbt4n9syuIHsFwedP4JOcz7uVpg5ltcoIkJ69
         C1GbRbjFvvPXpZ+QVr0QKF+zzcwR1wQ8JWm/K5tXLO74AJaeZByKE7Gzg71FJ86m1xSj
         JTEQ==
X-Gm-Message-State: AIkVDXIOHjdppdXAZIP6wm17rlIidQDI5pauuGWhKAXgQK3uJ1nAnYRcaguDPQa+0jOsW3fk
X-Received: by 10.99.246.5 with SMTP id m5mr70721972pgh.9.1482948818153;
        Wed, 28 Dec 2016 10:13:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5916:abad:d441:dac4])
        by smtp.gmail.com with ESMTPSA id p68sm98888594pfd.11.2016.12.28.10.13.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 10:13:36 -0800 (PST)
Date:   Wed, 28 Dec 2016 10:13:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20161228181335.GA33595@google.com>
References: <20161228000559.17842-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161228000559.17842-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/27, Stefan Beller wrote:
> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1].
> 
> The usual response from the mailing list is link to old discussions[2],
> and acknowledging the problem stating it is known.
> 
> For now just improve the user visible error message.
> 
> [1] https://www.google.com/search?q=item-%3Enowildcard_len
> [2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
>     https://www.spinics.net/lists/git/msg249473.html
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> If you were following the mailing list closely today, you may sense
> that I am cleaning up stalled branches. :)
> 
> I think such a hot fix is warranted given how often we had reports
> on the mailing list.
> 
> Thanks,
> Stefan
> 
>  pathspec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..d522f43331 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len <= item->len &&
> +	    item->prefix         <= item->len)
> +		die (_("Path leads inside submodule '%s', but the submodule "
> +		       "was not recognized, i.e. not initialized or deleted"),
> +		       ce->name);
>  	return magic;

I haven't been following everything on the list these past couple days,
but are we sure this is caused by submodules?  Also variable 'ce'
shouldn't be in scope here.

-- 
Brandon Williams
