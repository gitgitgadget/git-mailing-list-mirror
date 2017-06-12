Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB65C20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 20:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbdFLUgL (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 16:36:11 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33848 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbdFLUgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 16:36:10 -0400
Received: by mail-pf0-f174.google.com with SMTP id 15so28651746pfc.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=damCWBAcXOLh0f+eyY1zI8xD3IjYG3msDubgHFERFws=;
        b=AMN++4SldRfgiGKiovnXrNm5MGpxSZ+OcxIi9lQpixmszTBRjCSbVJR3Ig4lqIU8+m
         3SO/yaydvyW6P0eBPN28JkhXDe3sbptf0OVNEmcH17H6EEafBP8rb7JS82nI2FcCjujg
         r7y1RoDBSm3a3jZdbU9oOea1ObUC9Pv0/kWL3qBGr3/Qr2Y2JLNh5dUtFBdcFr+j7g06
         K3I0Iw1PyywQdidwyI1aeUmognVVRgSmmvFoLvmMRozLiLWhP7yCn015yfsfB+TnhsrH
         lKTmQ/lOQ+Tw8hF5VlVu6gLiP0C4j9IchAzNp1NEJy59xCaD6miZ05eoJXiol3kzBWzM
         cgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=damCWBAcXOLh0f+eyY1zI8xD3IjYG3msDubgHFERFws=;
        b=NnGmFAdUGknXHSyHV4YlI+z6jD8r/A9HjhzRozDO2fUfbl6t8B/A8Mpqk+zdVLUDOs
         wSrYMtEcYNFcGKDYDzhAsZ9yVbZmVRhLwDiH/wBedBtGcuZhn8hPC6D3xWX/zLe9M7pr
         7nXTJtudSCw5/thOn22z3Rf4yqG0VC+SP1R+HecoeM35d9d3+khgQQUmEx4ArT+ZINMK
         4A/lXr9MluM4qCsc59JDqUFzCcj7OG8wLvXb+1SsCPg+G6zgR6D9twKElzrS9cp05roH
         CvXycxd3rb5Tp4rFJRdQ9C2gkHqpVZ8KONwZCeSRzwvl5eQuSbXC7k3xWPvgTexO8VTa
         n+KA==
X-Gm-Message-State: AKS2vOw+1l8bSHQy6HXxWqNPUyhYrYp8p6Puzkx+tJAPh1C3f/Ci/idS
        Zri8ofc+LjrTnw==
X-Received: by 10.98.141.89 with SMTP id z86mr8870395pfd.34.1497299769952;
        Mon, 12 Jun 2017 13:36:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id v9sm18911865pgb.25.2017.06.12.13.36.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 13:36:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 1/5] revision.h: turn rev_info.early_output back into an unsigned int
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
        <20170609181733.6793-1-szeder.dev@gmail.com>
        <20170609181733.6793-2-szeder.dev@gmail.com>
        <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
Date:   Mon, 12 Jun 2017 13:36:08 -0700
In-Reply-To: <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 02:41:02 -0400")
Message-ID: <xmqq60g1ndtz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 09, 2017 at 08:17:29PM +0200, SZEDER Gábor wrote:
>
>> rev_info.early_output started out as an unsigned int in cdcefbc97 (Add
>> "--early-output" log flag for interactive GUI use, 2007-11-03), but
>> later it was turned into a single bit in a bit field in cc243c3ce
>> (show: --ignore-missing, 2011-05-18) without explanation, though its
>> users still expect it to be a regular integer type.  Consequently, any
>> even number given via '--early-output=<N>' effectively disabled the
>> feature.
>> 
>> Turn it back into an unsigned int, restoring its original data type.
>
> This confused me for a moment, as on my first read it seems like the
> obvious solution is to normalize the input to a bit-field, like:
>
>   revs->early_output = !!atoi(optarg);
>
> But the "users still expect" bit was a bit subtle to me, as I thought
> you meant users of Git. But you mean that the feature itself is not a
> boolean, but rather an integer count of how much early output to show.
>
> I'm not sure if I was just being thick or if that point (and the fact
> that --early-output has basically been a noop since 2011!) should be
> made more explicit.
>
> Given that nobody noticed, I kind of wonder if we should consider
> ripping the feature out entirely.

Yes, we may want to think about deprecating it, especially given
that it is not advertised anywhere.

In any case, the patch looks correct ;-)
