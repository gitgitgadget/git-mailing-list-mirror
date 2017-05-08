Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F032B20188
	for <e@80x24.org>; Mon,  8 May 2017 04:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdEHE4a (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:56:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35428 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdEHE43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:56:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so8916493pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Yfw52eAybRrfM3rIXhvaUKUrJdaMSzRU4G+j2mEsgpg=;
        b=NYyd25NuhGR9w3rT6lZI4nX1qIt0QlGfu50d6eEUS8r58ZJifBFkaN/VjTNefJMNRo
         HXTOIxKtU9hldIYLoVNoK/HBpBpmFsLZVcIbXHpXupaaeyneC7ieXrbSz88yJhrXH6dv
         1fxbylNIO+EVzNLB9jaWiN28d1FgyT7Pbt+SOrIxdVbE9mXtH1oss0t4lJJLmbzwAvZz
         oPAzZRGgnFFD65BBdpkK+5DWFl1dbnrqdL7rPWcpLyjSapbvR3DNk8wfHP7VDvN8fmxG
         9/rSVrS48Ri+elG2uIe6NkekPYykJoEFCeEa52jVT4yOZ4N9bDa042AG0EzOLMU0970t
         Ufew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Yfw52eAybRrfM3rIXhvaUKUrJdaMSzRU4G+j2mEsgpg=;
        b=lBJYDwGiZ/fMbNFkXYhY1cPGDRZFk+WlP7YIezGv17RDdgSxtUIdBGiIRkTzjE0tiR
         95Fj9xBDBJgytEwa0TdTsDIwdUMkgN9u3J6qmlzf2xEhujHpHhD1kypHiJ13oQAFcao6
         od+YVD2FQKrdQI+ONWQxrSMzq7GPW1Ok1/RBMqHUoYm/8JHff9uBnTNGZLjUdm+1l/nr
         hCZJD14eA6C3jopx9EnG4J6piAumsJmopuxZfW3NNT6UH8UteV51HxNfglRcL6BhQgWL
         XYDKxoGUeMiroI4bcxWOdDIR+8imUTEwmUYos9MyZqsHVPCA+Je3QjhMgfngOp+xHqmf
         QyZg==
X-Gm-Message-State: AN3rC/5juAKLeRwkX3Ee4qd43m5YkyAqYptFezC56zQIPdSJ7DdQKSxQ
        +aUNHWvZUNLlrbDEjmw=
X-Received: by 10.98.215.85 with SMTP id v21mr25964142pfl.121.1494219388950;
        Sun, 07 May 2017 21:56:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id q27sm2772937pfk.4.2017.05.07.21.56.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:56:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: disable pack reuse for object-selection options
References: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net>
Date:   Mon, 08 May 2017 13:56:27 +0900
In-Reply-To: <20170502084326.65eisqmr4th5cbf7@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 2 May 2017 04:43:26 -0400")
Message-ID: <xmqq4lww9cas.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If certain options like --honor-pack-keep, --local, or
> --incremental are used with pack-objects, then we need to
> feed each potential object to want_object_in_pack() to see
> if it should be filtered out.  This is totally contrary to
> the purpose of the pack-reuse optimization, which tries hard
> to avoid doing any per-object work.  Therefore we need to
> disable this optimization when these options are in use.

I read this five times, as I wanted to understand what you are
saying, but I am not sure if I got it right.  One of the reasons why
I was confused was that I originally thought this "reuse" was about
delta reuse, but it is not.  It is "sending a slice of the original
packfile straight to the output".  But even after getting myself out
of that confusion, I still do not see why we "need to disable".
Surely, even if we need to exclude some objects from an existing
packfile due to these selection options, we should be able to reuse
the non-excluded part, no?  The end result may involve having to
pick and reuse more and smaller slices from existing packfiles,
which may be much less efficient, but it is no immediately obvious
to me if it leads to "need to disable".  I would understand it if it
were "it becomes much less efficient and we are better off not using
the bitmap code at all", though.

Is the real reason why we want to disable the "reuse" because it is
not easy to update the reuse_partial_packfile_from_bitmap() logic to
take these selection options into account?  If so, I would also
understand why this is a good change.

Puzzled.

> This bug has been present since the inception of the
> pack-reuse code, but was unlikely to come up in practice.


> +test_expect_success 'pack reuse respects --honor-pack-keep' '
> +	test_when_finished "rm -f .git/objects/pack/*.keep" &&
> +	for i in .git/objects/pack/*.pack; do
> +		>${i%.pack}.keep
> +	done &&

Micronit: style.

