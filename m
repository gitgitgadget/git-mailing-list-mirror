Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C5020282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754903AbdFWUWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:22:16 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35745 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754880AbdFWUWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:22:15 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so7385969pgc.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Twej0i76m+3H2fk0AbnY3AQ9/qZavdE2xvbXEXlwB4w=;
        b=NKEhwDPQsOC0d1hrEWFqKon412vHlcSIShWiy3D+wOKLeExZX4w38230DqKMydWDXG
         /3h3M5fvMb1DUQXmhR0Bu0MfcywmPZoPNaBgaJjXnQdet4/CRtRS4I5cz6M/ja8Pv/+G
         XvDERbTAGKyJFmb2SNRkKrEDIylkSQihyyYyEy/sookyoXi7lIM6AGGmYCG4hUSOuSUt
         BQk7jkqU08lMYFLMcKw5bOEiiXNsTFAahxhzF6pH2uAezwA/cpfQ7HnGnWqdwfuB22ZP
         motZp9l5h2CZsu373qRLaz/EQ+gIi9VfMcETDJfydvHn21S0IfquFU/9lqkJ4DVJzCvF
         blLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Twej0i76m+3H2fk0AbnY3AQ9/qZavdE2xvbXEXlwB4w=;
        b=IG+Uanr+UZKwN6SxzlFB40cma5ZOZwe4ygkBDhJNOzC8zfwhcK7DmRx5xnCliagIQw
         nzvMWyFDd7vDEwCahpbIfMu3poaOE8dy9xo7DyrnNcIu0ubMcUfqzd9+qlgYmiwajmi0
         rwixVkrpIARNsN7phYXCBahrRs45F5VsCGD4L0+RU44FsOc2FLJeaozYTfY3e6SxfIvp
         oW3+7XiT6ExDzYgQaOnIriFTwPFQlWT9107DaPT9oUlYksbwVmOoe3jNIFnq8aDcEZHU
         YAY49PVpVjE1v2QsIwHQdWMt7yFmLg8vSBj+ljrSzQ84EuIVR916XJr4nhPYudAdzsE5
         UoHA==
X-Gm-Message-State: AKS2vOw8KEXs7y5t66vOQy5sGKZerwjmZ0ercBSLwhBqFAYYz5Btp3jc
        qbiTJJ2jIotU5g==
X-Received: by 10.84.195.131 with SMTP id j3mr10841991pld.147.1498249334690;
        Fri, 23 Jun 2017 13:22:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id b28sm13397654pfm.9.2017.06.23.13.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:22:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/29] t1408: add a test of stale packed refs covered by loose refs
References: <cover.1498200513.git.mhagger@alum.mit.edu>
        <4eca5010979e86fa25d95b68d3f266d7f74d168b.1498200513.git.mhagger@alum.mit.edu>
        <20170623185943.noczrssjjigomezx@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 13:22:13 -0700
In-Reply-To: <20170623185943.noczrssjjigomezx@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 14:59:43 -0400")
Message-ID: <xmqq60fme9oq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 23, 2017 at 09:01:19AM +0200, Michael Haggerty wrote:
>
>> +test_expect_success setup '
>> +	test_tick &&
>> +	git commit --allow-empty -m one &&
>> +	one=$(git rev-parse HEAD) &&
>> +	git for-each-ref >actual &&
>> +	echo "$one commit	refs/heads/master" >expect &&
>> +	test_cmp expect actual &&
>> +
>> +	git pack-refs --all &&
>> +	git for-each-ref >actual &&
>> +	echo "$one commit	refs/heads/master" >expect &&
>> +	test_cmp expect actual &&
>> +
>> +	cat .git/packed-refs &&
>
> I think we'd usually drop debugging "cat"s like these in the name of
> keeping the process count down. Unless they really are intended to
> confirm that .git/packed-refs exists (although test_path_is_file is a
> less expensive way of checking that).
>
> That's a minor nit, though.

Sorry, these two cat's were what I used while debugging the test and
should be dropped.

Will remove while queuing.

Thanks for spotting.
