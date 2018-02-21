Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91931F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeBUWWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:22:09 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36387 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUWWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:22:08 -0500
Received: by mail-wr0-f175.google.com with SMTP id u15so8647012wrg.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WSBcGWcLAAu20HaFLBcBSdOmL47+wFVXOdwlr3VESRs=;
        b=Ei8IUTFxksJpX9F/C0HcGjq8at2g0E6pREMWKo0UQJc/7ycMjxwtl6uH8S0AYoHfVP
         6PWtng8MbACvaBIzZPKhSa0YN7603AR62ftHPiaVg0Z7cdIr9uK/hDLg8GuD9Gc7rT5n
         npmdXrwt8eKbcxGpw/quN8opStboLu62oSC/+sOFFrSetRLpfGdzXhGwMFErBcnKc/GW
         YTDf+XSgTPqotlrTooN+ohQpL+yzMTfBas9eVqxlMd1wfY8a5UkYalRFp4NBb/M2tS2a
         Vv+JjDMLxGe5KS+LiFVKq3rmaB3znGEdNKbw7avv3HHUFOsqmHXCcvBpMIZu0x7syWBf
         6Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WSBcGWcLAAu20HaFLBcBSdOmL47+wFVXOdwlr3VESRs=;
        b=Amhrqvu3QCNPgFMiIohGKQt0mw8SbauGSNwvX3mSlKWbMURF5moiobdErayVLaL5IP
         Erk7M4+X948+iSWGSytjEXZxM8+wW56WJe8xGU1Tn7ey8sYZ3S+/NlabTqX3p0OCnNPo
         aIGeIML4CiHatZtFK3wUeArmJZLLSVBLfifWWl12j2YlDZEu6Qr4QJAiMCpUZ3CFGs0X
         bg4MjPF9IK+NO20a7BivG3sb7YQNDTbbtzEi74mmuwHmHYdqOYGMQeZMSCXsUhW4W1JN
         4rHEBnXABdZ+cdeyvkQWrjeS92KrAih2E7g1RJBnv4banllYdFlqgVgkDRABmPF7ONtG
         khUw==
X-Gm-Message-State: APf1xPASxfP5fCDzBgRTmYQDK08uLVwzB+VmRuiFJegfS/pMvXIMGL63
        rkYja9f1wB0Phbul6bCFkQU1zTeS
X-Google-Smtp-Source: AH8x225pk7nx+5Hd+GndMf7ap/pEiVVaHq2/6p0oI51Jo2OK85HHzev4mTWsuH3AKyTwc1YtfKYwQw==
X-Received: by 10.223.182.17 with SMTP id f17mr4488141wre.194.1519251727078;
        Wed, 21 Feb 2018 14:22:07 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v13sm32540820wrf.71.2018.02.21.14.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:22:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Question about get_cached_commit_buffer()
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
        <20180220225726.GA17496@sigill.intra.peff.net>
        <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
        <20180221184811.GD4333@sigill.intra.peff.net>
Date:   Wed, 21 Feb 2018 14:22:05 -0800
In-Reply-To: <20180221184811.GD4333@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 21 Feb 2018 13:48:12 -0500")
Message-ID: <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that repeating the oid is intentional; the point is to dump how
> the traversal code is hitting the endpoints, even if we do so multiple
> times.
>
> The --oneline behavior just looks like a bug. I think --format is broken
> with --show-all, too (it does not show anything!).

I do not know about the --format thing, but the part about --oneline
being a bug is correct.  I've known about the oneline that does not
show anything other than the oid (not even end-of-line) for unparsed
commits for a long time---I just didn't bother looking into fixing
it exactly because this is only a debugging aid ;-)

> Though I think it would be equally correct to have set_commit_buffer()
> just throw away the existing cache entry and replace it with this one. I
> don't think there's a real reason to prefer the old to the new. And that
> might be worth doing if it would let us drop get_cached_commit_buffer()
> as a public function. But...
> ...
> In my opinion it's not really worth trying to make it private. The
> confusion you're fixing in the first two calls is not due to a bad API,
> but due to some subtly confusing logic in that code's use of the API. ;)

Yup.

> So I'd probably do this:
> ...

Makes sense to me.
