Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670B01F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdB0TIz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:08:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35857 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdB0TIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:08:53 -0500
Received: by mail-pg0-f66.google.com with SMTP id 25so1892622pgy.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IyhBhNOUgwStQO/7Y1hQ8IJ8Vx0pj2pXBFuWWEGUhGE=;
        b=UCDemByUbSKxrcYqJshmN5SrzN42qSLjBQu8MMM0Lho/awKD5il+7hwMqhMoEzSNmK
         TAhOw681f9TH36QftYul6N+ci5zBg4ONQR+cPXR60WyMRC+IQNlolrPqkDkJpkVoBnL6
         g7sGCv1lNDfEySSqPnRHmr+XNSKdxtqyGJqc1dafNnbtyRtVaB6e4ysA8O3fX1E+U7iW
         BBThzowzX7YzWeyJFeFVw2uv8rlCHVEldEeaBuG9dlLuDZidALLNinRvInGWfu6x/nJn
         qI0yNWs+t4HC3mv61bNgVug5Mde1ai80CP6X+inynCZ41smeOpo7yMrOdC5Qbi2hDg44
         1loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IyhBhNOUgwStQO/7Y1hQ8IJ8Vx0pj2pXBFuWWEGUhGE=;
        b=XeFREwiUiDJS0iq8U5YTKOd511b7YLD7+Y8dk7nPfCI0bQ+vYvfRhdb40Hf7oX6FEV
         /BDTmqKEl756PWW/Jy3nndW+5kUHSAljmwUrT3H/3DGyH5VvepmKtyBwclBI+UkWfao3
         raqL4BjLrRDAD5Jo88x7UPHkyFwhXYQf6WVZcT1tbrq3K5+T47vJ41aRZDvqf9SSZYDG
         RQWbDd/W6gj14SloCjoxTcTYd25lQjDcBJClXcw3i7xBjIrtm8Zv+AotoJb8OqHV0KDE
         BTHRrxF54leJeCJFV3x0efbxwUXeN/QMViPfj6JPaHdlOspBI1F6uAvemLniiR4yCDc7
         kLtg==
X-Gm-Message-State: AMke39nmOdxaYu+5fuREb9KUhT+ljYPa6vOcUo8j61mBMVZJg1jXxQZqYMe9ieGNKhv5RQ==
X-Received: by 10.99.166.17 with SMTP id t17mr22538804pge.196.1488220507409;
        Mon, 27 Feb 2017 10:35:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id f188sm32062831pfa.35.2017.02.27.10.35.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:35:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: add an "auto" mode for http.emptyauth
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
        <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
        <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
        <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702251243390.3767@virtualbox>
        <20170225191506.4it7pdsi6ijanfft@sigill.intra.peff.net>
        <20170225191831.dkjasyv3tmkwutre@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 10:35:05 -0800
In-Reply-To: <20170225191831.dkjasyv3tmkwutre@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 25 Feb 2017 14:18:31 -0500")
Message-ID: <xmqqpoi3xz1i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The auto mode may incur an extra round-trip over setting
> http.emptyauth=true, because part of the emptyauth hack is
> to feed this blank password to curl even before we've made a
> single request.

IOW, people who care about an extra round-trip have this workaround,
which is good.

This, along with the possible security implications, may want to be
added to the documentation but that is outside the topic of this
change, and I think we would want to see such an update come from
those who actually use NTLM (or Kerberos, but they know they have
minimum security implications).

> +#ifndef LIBCURL_CAN_HANDLE_AUTH_ANY
> +	/*
> +	 * Our libcurl is too old to do AUTH_ANY in the first place;
> +	 * just default to turning the feature off.
> +	 */
> +#else
> +	/*
> +	 * In the automatic case, kick in the empty-auth
> +	 * hack as long as we would potentially try some
> +	 * method more exotic than "Basic" or "Digest".
> +	 *
> +	 * But only do this when this is our second or
> +	 * subsequent * request, as by then we know what

I'll drop the '*' that you left while line-wrapping ;-)

> +	 * methods are available.
> +	 */

Thanks.  This looks good.
