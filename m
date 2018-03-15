Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B921F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeCOPnB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:43:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54422 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeCOPm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:42:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id h76so11371231wme.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VMordlUbRmihH8daoh2kxzcztOdHPCVpyFrO/d8I+UQ=;
        b=ukGgb2bexTaP6j9Q9VqDjIsf45l1ZAjFI3SebFJFMed5a0aKNt3Lq/ffba8a2qyCy2
         6RrqH+F5eBr4HmYqZjxo8XpIjWcu4SP+L8f5RuRnO8XANcVlB7yfHa++ylykdT8VAVnk
         QBbCqTdr2u7Vg4BLdmJbX4I24NYnxmr5DV6YvzFTvIPXeEm4Mjx1+WY1Mj67Gu3BMIzY
         5MO/xSkzPkXWzp/KBWDUFhd5I4Z0LBiVJPCbxfXorgRy35xAhualqlMgzfKQIEBlXlMF
         ZhJQxaJdnbcM3KrEJgZUW92qKXSLCoGVSdEbgIi2q7D5ivFD1xyph04uSa7+SSqA2rGA
         6eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VMordlUbRmihH8daoh2kxzcztOdHPCVpyFrO/d8I+UQ=;
        b=qLHYoKwfVO7HSnHABJBfrixlEh3iKFYBPeVCCS62bhc5YuheFe+NOmd48BJEttavig
         KVMNlNxcKb9HUtf2dmBXphtPvwITVfa9wCuiWqmH0Xxknn8nXfCHbBdILPkOgN1N6Xh9
         9hmp44f6gWp+jEStdW/piCca3KVhufttiOsGSjN+lPdol7Xi/zeS0wMKyGPkbG6Q6k13
         SdT308oZbbXo+9n31h+Tb5EbRvbWef3fufcNi6QLAFLKqMcq0lCJuNRv08r8SYAEijdM
         a/pPgvRet7jm8b6qH/Dp6EGP+PIGJIr0kSfLZWk81thjr5lykTrfnwkA8qn55xov65Wq
         ecCQ==
X-Gm-Message-State: AElRT7GaOTMGP/s5SZGwZ+BFDDKRb8DWH2UT5RCi9VZk0DARcv/Zj6G+
        maR8JGCzsX5QZcxtb9SWGAq5Hl/e
X-Google-Smtp-Source: AG47ELtn18ycOuUPDi30Y958pNZKLdK11KsD/nObA1c/OmUpbKXM6SVXRaJvCgdKghYC76fEttq7AQ==
X-Received: by 10.28.103.9 with SMTP id b9mr4925355wmc.32.1521128576880;
        Thu, 15 Mar 2018 08:42:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f3sm4082110wre.72.2018.03.15.08.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 08:42:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michele Locati <michele@locati.it>, git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
References: <20180315130359.6108-1-michele@locati.it>
        <20180315141220.GB27748@sigill.intra.peff.net>
Date:   Thu, 15 Mar 2018 08:42:54 -0700
In-Reply-To: <20180315141220.GB27748@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Mar 2018 10:12:21 -0400")
Message-ID: <xmqqa7v973b5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 15, 2018 at 02:03:59PM +0100, Michele Locati wrote:
>
>> Using the --state-branch option allows us to perform incremental filtering.
>> This may lead to having nothing to rewrite in subsequent filtering, so we need
>> a way to recognize this case.
>> So, let's exit with 2 instead of 1 when this "error" occurs.
>
> That sounds like a good feature. It doesn't look like we use "2" for
> anything else currently.

I do not want to sound overly negative against the first
contribution from a new contributor, but I am not sure if this is a
good idea.  While I do agree that the caller of filter-branch would
want _some_ way to tell if the call

 - got some new stuff,
 - got no error but did not get anything new, or
 - failed

and act accordingly, changing the exit code to a non-zero value for
the second case above would mean that existing scripts that have
happily been working would suddenly start failing.  Due to the lack
of an easy way to tell the first two cases apart, they may have been
doing _extra_ work after calling filter-branch when it found no new
development (resulting in an expensive no-op), or perhaps they
implemented their own way to tell the second case apart from the
first one and efficiently omitting extra work in the second case
already.  In either case, these scripts will get broken with this
change.

So I'd respond with a mild "no" with "can't we allow callers to tell
the first two cases apart in some other way so that we do not have
to break existing scripts?".

>> ---
>>  git-filter-branch.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This should probably get a mention in the manpage at
> Documentation/git-filter-branch.txt, too.

Whatever solution we eventually end up with, it needs to be
documented.

Thanks.
