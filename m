Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F8F1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdBNS41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:56:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:34943 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbdBNS4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:56:25 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so45632693ith.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igL2hmO7122ogVdAbAjCNN+ACLq6H/PXAs/iEjxMezA=;
        b=SHPaSEkEKswpqM1IJqtx6rRKWmIkYv1px5/tT0PAQifO8ufQERBR8USikpqrMte3OC
         tegOKqpR9r1RQyyg3ctL/3lUwX6X+t0LzBnLHN4Rvr3dZEhpHU+iwp7pWo8LlaWFFnY0
         f+i+8VWAT3xusdcb12bjH1QyzFEK3bKbKBvuGNWnRKAy7MBvbDlLl2AbBvBfjrNVVmyO
         X73yhThdbmhiku5kX62TflIMACviQHzMPD0g/eGJ10rUB99hL9Kf+C1+64BwSDNfkx97
         xtsmvUCT0XihGz2oIyTMtMpHWil9nfaLF2stQLSzng0Eup3x+Uo80CbwpOwc/R3Xa2Or
         7C7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igL2hmO7122ogVdAbAjCNN+ACLq6H/PXAs/iEjxMezA=;
        b=l1obr1Gm0+ue/ujT6uzl1hqkf6DKa6C90Hn9xtFN6w9Q6TwPWOhzHbgJBSO5zUrIAS
         COWpSPUED59Xg1aZq6zggxgSzdLPwliX5RQsGehSNlHadPJdrbrlNW1Tq2DEHijQUgh5
         tUEnOkZHSpZ7bRfJt+64+jfS8efkXw11LDmxdqdnAJFMFTYDxB3xYlaT2YpBKH1wQQDa
         cSB9IAMEq/OTfwRjxM+7jAPQxLvgHG6pIG7O3lSJXBEvBzuL9M8m7i8VemKNLtpsj3r4
         8hW5+V4CiRvpTAyv1Uy175MWRXvRKFCBxykKw1wgOGih7LC3P26/kf7w3C/GsZ8/W60Z
         Op8w==
X-Gm-Message-State: AMke39m0vpBd/xd+dGJUV93jcw3+mCnF1i2ThgZ5gALu1U4xbc5R73pMbnWmGfVxFWKV9JWb
X-Received: by 10.99.123.68 with SMTP id k4mr34379972pgn.101.1487098584264;
        Tue, 14 Feb 2017 10:56:24 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:35a2:93b7:75dd:e184])
        by smtp.gmail.com with ESMTPSA id m136sm2736855pga.22.2017.02.14.10.56.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:56:22 -0800 (PST)
Date:   Tue, 14 Feb 2017 10:56:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 5/7] grep: fix "--" rev/pathspec disambiguation
Message-ID: <20170214185621.GC44208@google.com>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214060555.yzh6hhi2t7pkeqvi@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Jeff King wrote:
> -	/* Check revs and then paths */
> +	/*
> +	 * We have to find "--" in a separate pass, because its presence
> +	 * influences how we will parse arguments that come before it.
> +	 */
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			seen_dashdash = 1;
> +			break;
> +		}
> +	}

So this simply checks if "--" is an argument that was provided.  This
then allows grep to know ahead of time how to handle revs/paths
preceding a "--" or in the absences of the "--".  Seems sensible to me.

> +
> +	/*
> +	 * Resolve any rev arguments. If we have a dashdash, then everything up
> +	 * to it must resolve as a rev. If not, then we stop at the first
> +	 * non-rev and assume everything else is a path.
> +	 */
>  	for (i = 0; i < argc; i++) {
>  		const char *arg = argv[i];
>  		unsigned char sha1[20];
> @@ -1158,13 +1173,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  
>  		if (!strcmp(arg, "--")) {
>  			i++;
> -			seen_dashdash = 1;
>  			break;
>  		}
>  
> -		/* Stop at the first non-rev */
> -		if (get_sha1_with_context(arg, 0, sha1, &oc))
> +		if (get_sha1_with_context(arg, 0, sha1, &oc)) {
> +			if (seen_dashdash)
> +				die(_("unable to resolve revision: %s"), arg);
>  			break;
> +		}
>  
>  		object = parse_object_or_die(sha1, arg);
>  		if (!seen_dashdash)
> @@ -1172,7 +1188,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
>  	}
>  
> -	/* The rest are paths */
> +	/*
> +	 * Anything left over is presumed to be a path. But in the non-dashdash
> +	 * "do what I mean" case, we verify and complain when that isn't true.
> +	 */

-- 
Brandon Williams
