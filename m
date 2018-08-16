Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB6B1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeHQBhP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 21:37:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeHQBhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 21:37:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so5458938wrt.11
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3j0s2nBiQG0XlykJIu7Rg7x7FtkbtdSK66wV2x0xwMY=;
        b=bD5gHzYLLBcfI0trhJZORjmtF/EvqNh9ze3p7BkuuqQ0l9vsoSVzFiGk+vHLDdfpD1
         B6ksmj3s83sWcrR0ZeMWM5TuME18vUCF0d8CZVeY8lCWCJI0BbUK1k2BdLbzHzgnozzi
         t/2kOMsn3m4+ooLcpUOG0RyFEjdtdA+IfE5UszMLL6naruyuzknqa/ckTqUGptddLRin
         UQ43XE+9rR5Ees9Srf6j8Z/a4OGcPTyWMq5SmNAckXincJcMLYb4cqAXOOQvCCRRVsvx
         /PbN6kbSbuQcPfvmNHgd9KvXh0Xwe/Cg1bDwtmfNWZ17cz4/+q1UAS1h8unnQNIHju01
         QnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3j0s2nBiQG0XlykJIu7Rg7x7FtkbtdSK66wV2x0xwMY=;
        b=LQ87ZJn7nD/e6s0/wyRxGmHVyRbDoEbBGgRPaUUEM5jiT4aM2vEVWDX09L4t8jX02O
         LjB7sAtPnlCUhVg0wUmyESwd/A4wsKG+ifM17ApG3Sdn6ZEC+FA9wqKciFGRfpYoXZuU
         oOqptQM4wyBZiia6zCorGZtTlIYeRjiRwpfuKNJNxx1QurbPkUvOfXnSdAhZ7QL82wJ7
         LtTBNp2djK/2wkZ7uMuzLqQlW41Hq4tWQZ5c5cgS2+s/6n08zX5YR+3kffsdCE6zjbHp
         7Ye5plUov/iTNSQfG9UaCdwiBX+anvS7Og2cbWE/y6zSMk/6kw2+iFhZ0YrUrY6yE75W
         UgKg==
X-Gm-Message-State: AOUpUlFt1mAsjFTvdMXKxSssaglqAOUelyKRgrtYW/Qb+WslErkvM0h7
        fZ4U6qIQqfhjydlCuxiRRUo=
X-Google-Smtp-Source: AA+uWPyaXW9L3ADgys7zT/Z3IcA2c3DmTTeOOtJRmQDu5eHlwvaVMEeadT56wxncrFKEgIGPF7ZX5A==
X-Received: by 2002:a5d:648a:: with SMTP id r10-v6mr20040307wru.109.1534458978734;
        Thu, 16 Aug 2018 15:36:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r140-v6sm4593834wmd.7.2018.08.16.15.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 15:36:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
References: <20180814114721.25577-1-szeder.dev@gmail.com>
        <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
Date:   Thu, 16 Aug 2018 15:36:17 -0700
In-Reply-To: <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com> (Andrei Rybak's
        message of "Thu, 16 Aug 2018 22:51:43 +0200")
Message-ID: <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On 14/08/18 13:47, SZEDER Gábor wrote:
>> ... both
>> invocations produce empty 'pack{a,b}.objects' files, and the
>> subsequent 'test_cmp' happily finds those two empty files identical.
>
> Is test_cmp ever used for empty files? Would it make sense for
> test_cmp to issue warning when an empty file is being compared?

Typically test_cmp is used to compare the actual output from a
dubious command being tested with the expected output from a
procedure that is known not to be broken (e.g. a run of 'echo', or a
'cat' of here-doc), so at least one side would not be empty.

The test done here is an odd case---it compares output from two
equally dubious processes that are being tested and sees if their
results match.

That said, since we have test_must_be_empty, we could forbid feeding
empty files to test_cmp, after telling everybody that a test that
expects an empty output must use test_must_be_empty.  I do not think
it is a terrible idea.
