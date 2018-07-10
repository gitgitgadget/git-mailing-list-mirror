Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC801F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeGJTm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:42:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40230 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGJTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 15:42:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id z13-v6so187650wma.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/UMeqT9V+7VkHLkOmRHNatAIPbbW2F5ESctYQGU2CwE=;
        b=JAYpAeq8d1DXWTb6gkcwbrjtUtTbMlUIeIwPMStwqXYeyr2LnZCiYiEMTE+rxfTfq9
         5H31mF/eWR5sL/GshwHcMGX2nZX0G+I7TzY5rC/99vETglKBoSLYtRIzlf6pw3bo0N9O
         5/IARkoC8jbgTPwNLAGomcsbiH8mngE01BM6hZHf9+JX++NGhtb5gLKxutoMi9BHXSK2
         iH7othEcm9XmqZ6TdcY4BLNWL7dh3HT1NQhxxKfD31o4DkQaYHV8RReuZBgkPXATRgzD
         SU13kO4R4rtM4aAvJCqfWmW3RpW27b+uUw16vKj3ZUH/IEyM6DIqS/3FxrkrEbFBOlr2
         otGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/UMeqT9V+7VkHLkOmRHNatAIPbbW2F5ESctYQGU2CwE=;
        b=hdSXou/fW+rwTFhVWZp/h9TSy6LJaevJnFkvDfNphLtka7envX38wVfOF9SKbgFSEM
         HPq/J2hHRBpJQiWSV/0AN+8q5a6xd3sxvE2oZDHkLElTlQXvtmYLqkkIVft6KaQRKjnv
         ArtMuuPynb/YU4KcQLWDTVYKWA/nnGNd61Mem/EaKr82Bz7v72RMzzF8isDLPXSDa/O9
         YcTfOUk9pWDE+OCuYkeH9cu0HsyYv2K510RB56nqbX1Z2bMrBzbmHaAZSDG1JqE1LCYF
         X41raG6fGZHI/Wue31VdZy1Vs1rlZuyT1c52vzMLdfr6qF2Phasbnd3x9zueMsHpB7++
         J1Mw==
X-Gm-Message-State: APt69E1opbVJlMuj2oeKmhqEGg+IloFhR8jHyR9yD468G7V5tlnNNXHl
        iuNdDevLixT1/t5/dUHAWgo=
X-Google-Smtp-Source: AAOMgpeuqSp3XFgX1R6WcQKAUubxHBHIQmJD7CoeT+i3wYf4UYlKG8dCSdNF1gxpWPs5yKNsIXYSLw==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr15281562wmj.124.1531251714184;
        Tue, 10 Jul 2018 12:41:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n8-v6sm236403wmg.27.2018.07.10.12.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:41:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH v1] convert log_ref_write_fd() to use strbuf
References: <20180710182000.21404-1-benpeart@microsoft.com>
        <20180710184534.GA27535@sigill.intra.peff.net>
Date:   Tue, 10 Jul 2018 12:41:52 -0700
In-Reply-To: <20180710184534.GA27535@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 10 Jul 2018 14:45:34 -0400")
Message-ID: <xmqqsh4q6fpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> -	while (buf < cp && isspace(cp[-1]))
>> -		cp--;
>> -	*cp++ = '\n';
>> -	return cp - buf;
>> +	strbuf_rtrim(sb);
>
> Using rtrim is a nice reduction in complexity. A pure translation would
> include a final strbuf_addch(sb, '\n'). It looks like you moved that to
> the caller. There's only one, so that's OK now, but it may affect topics
> in flight (and I do in fact have an old topic that calls it).
>
> But I think it's OK, as the change in function signature means that any
> callers will need updated anyway. So there's little risk of a silent
> mis-merge.

It is interesting that we came to a slightly different conclusion,
after doing pretty much the same analysis ;-).  Unless Ben has a
plan to use a version that trims the trailing LF elsewhere, there is
no point changing what the function does, especially because the
existing and only caller does want the terminating LF at the end.
