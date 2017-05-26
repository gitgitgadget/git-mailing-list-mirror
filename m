Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F61E209FD
	for <e@80x24.org>; Fri, 26 May 2017 02:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762750AbdEZCN6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 22:13:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33349 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760165AbdEZCN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 22:13:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so42687159pfe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SN1vRVbijioOfC27UzprarGPO6b7vvg0LFvuGDXembk=;
        b=hlhzIcUjAOfyeHuE3TklsQ8KDe1hglG2w0Kd93Mt/TUOTNnVl49m5QhE1cF3Go3zQW
         hXZDOZmQ5qZnRPEnYyFT1j87Cm5UryHbZzjvr0+/z6xDPs4aRBrZScwrds5yRH/nwMV3
         piTqdtviFySRPOApoSnGwLbMNLtGekk7kV05r5LdWOZBT/IvV3lzcpeC7WXPDxBqX/QR
         DYMSMs234tqiAd2ZvyW/WyqwGi4v1/TR/H39RuOQMkFtePrAXq7jxa4Obt7qCL0fhJBL
         52Sj0M1AGqZLG1LZMmMGBA4ebmViAgQDHaQAZB0sqWa/Uw6kdoCEgER23YpQykzb48yU
         jiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SN1vRVbijioOfC27UzprarGPO6b7vvg0LFvuGDXembk=;
        b=WiOw5mAbbQSUOxS4u6gLoSnc1/SIAwQbJRfaLsO8v2Qi7FOjPCIBxTZCiCw942yk9Y
         hnJ/n8aE2FMqCz38BP3bZ6IhQ6gV9q3TQm9HXNiDpTKufAFfFirt4tt8A4O4DpjovdwN
         4IeCz976HZxf0wXHg7sTqTZND88oppd6dMVAgX3TBN6xMcuhBdwCKtiI2bO+QbsBq/Uv
         h1w0ITtCu8i4qenPFJZuFZm754j+6IkJa7Ees+CLds7lTy36+PaCqv5Ej6Y1darudJ4Q
         kOYV1FOfymCsPFgops75nCflY4KW6J5dzIPobO2tQaO7uozHA5CuQ2J1MAitcr7B8/RL
         QtlA==
X-Gm-Message-State: AODbwcBVqPPnps27BLfv+AjAopjNFqPXSpwIkTn9jCeL0OElnC70+MxP
        dfrjlNRb2TKH3g==
X-Received: by 10.99.107.136 with SMTP id g130mr27586009pgc.3.1495764836579;
        Thu, 25 May 2017 19:13:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id 192sm14170972pfb.10.2017.05.25.19.13.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 19:13:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
Date:   Fri, 26 May 2017 11:13:55 +0900
In-Reply-To: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 25 May 2017 11:27:40 -0400")
Message-ID: <xmqq4lw8cql8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But let's consider related invocations and whether we're
> making them better or worse:
>
>    - git log :/foo
>       (when "foo" matches a commit message)
>
>       This one should remain the same. Like the existing
>       wildcard rule, we're touching only verify_filename(),
>       not verify_non_filename(). So cases that _do_ resolve
>       as a rev will continue to do so.
>
>    - git log :^foo
>       (when "^foo" exists in your index)
>
>       The same logic applies; it would continue to work. And
>       ditto for any other weird filenames in your index like
>       "(attr)foo".

"git show :$path" where $path happens to be "^foo" would grab the
contents of the $path out of the index and I think that is what you
meant, but use of "git log" in the example made me scratch my head
greatly.

>    - git log :/foo
>       (when "foo" does _not_ match a commit message)
>	...
>       This same downside actually exists currently when you
>       have an asterisk in your regex. E.g.,
>
>         git log :/foo.*bar
>
>       will be treated as a pathspec (if it doesn't match a
>       commit message) due to the wildcard matching in
>       28fcc0b71.

In other words, we are not making things worse?

> I wrote all the above to try to convince myself that this
> doesn't have any serious regression cases. And I think I
> did.
>
> But I actually we could make the rules in alternative (2)
> above work. check_filename() would ask the pathspec code to
> parse each argument and get one of three results:
>
>   1. it's not pathspec magic; treat it like a filename
>      (e.g., just "foo", or even bogus stuff like ":%foo")
>
>   2. it is pathspec magic, and here is the matching filename
>      that ought to exist (e.g., "foo" from ":^foo" or
>      ":(exclude)foo")
>
>   3. it is pathspec magic, but there's no matching filename.
>      Assume it's a pathspec (e.g., "(attr)foo").
>
> I'm on the fence on whether it's worth the trouble versus
> the simple rule implemented by this patch.

Unlike "git log builtin-checkout.c" that errors out (only because
there is no such file in the checkout of the current version) and
makes its solution obvious to the users, this change has the risk of
silently accepting an ambiguous input and computing result that is
different from what the user intended to.  So I am not sure.  

As you pointedout, ":/" especially does look like a likely point of
failure, in that both "this is path at the top" pathspec magic and
"the commit with this string" are not something that we can say with
confidence that are rarely used because they are so esoteric.

As to "is it OK to build a rule that we cannot explain easily?", I
think it is OK to say "if it is not a rev, and if it is not a
pathname in the current working tree, you must disambiguate, but Git
helps by guessing in some cases---if you want to have more control
(e.g. you are a script), explicitly disambiguate and you'd be OK",
and leave the "some cases" vague, as long as we are only making
reasonably conservative guesses.
