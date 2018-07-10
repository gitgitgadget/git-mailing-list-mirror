Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F811F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeGJQf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:35:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeGJQfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:35:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so15296039wrd.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sLaaotVDmvFfFxvliwtk+OQVmKPdWDpOozQZYPu7wbY=;
        b=S51HCwZLM0KT3pEMWZdYMrsBLxpAKUChps3uN3Axh9rc9ZObBmSSTrmmDrXrN59W4W
         5EtkKFxBOwqx5GtwHL+PdNJkw6/YTKkWk6XMcEBsPoo17szU80t99LilbxTV2e5VhBxn
         tIw1m7MVrwEAKdy/bM86sAF9424X4ddyZqEeAdNFGZqTLSmnY9Nun5YjNdvuTvhva7m4
         DLZCGbynLmh5rwlcEupd5zye3BA/SWDwAr+O40f240lj2rTZZjVDRU81TBnJf4aVeixe
         JA3btnxaUM9NXSA2i3afi4ODAllSUeatzY3xAMqVzm8SMtOIJwy1SI1MG3Xr8cyVcE1T
         KhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sLaaotVDmvFfFxvliwtk+OQVmKPdWDpOozQZYPu7wbY=;
        b=qpm/Qljcc4Avl7jb5X/4My6zeuouBEnCoK1Rjvrm6u5LrniVZGgB+KStfdw1wO2B2k
         MW3lH8Kn3UyrmhsZ24UcfI22tdhKZy49r8VJq4O8EB8po4XeTdQL4sJRoMLOyB4f/gFL
         a1VTaenm782G2ZKoFc4jN/Pxh83DPrabDwHqGPgD/D29P5ExfVN3/IkrfUMMCbdeGykX
         ZhPjGYLWY896xfMp/Jqmzqg0dMlAiLfrWtWiMYRraZ1IGJQ64xvwfn9NJ6r0lreNk31i
         XdV95K44tABcaqoHf49u7skpYQQ/Xr01rvEJJOz/UCEIqtK+3/3qIh4cPaUt8nrYKP9d
         tSTw==
X-Gm-Message-State: AOUpUlHQTJ0nbIdQeCz1ZYOjkknZyo28oijYlwqofaCLIDGMa8L9xUYE
        KvR825U5kOcOpmQ57YgLBpM=
X-Google-Smtp-Source: AAOMgpfUgaeZAomQJI0Va0RqBZIzCVxnWz4WQVcPsg0UDnnY7fGDOHPtCfJWaDAhYQqnWZy/MxBlpQ==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr2165686wrg.56.1531240554542;
        Tue, 10 Jul 2018 09:35:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y5-v6sm9752702wrs.86.2018.07.10.09.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:35:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
        <20180708233638.520172-8-sandals@crustytoothpaste.net>
        <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
        <xmqqva9oe20y.fsf@gitster-ct.c.googlers.com>
        <20180709233952.GB535220@genre.crustytoothpaste.net>
Date:   Tue, 10 Jul 2018 09:35:53 -0700
In-Reply-To: <20180709233952.GB535220@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 9 Jul 2018 23:39:52 +0000")
Message-ID: <xmqq1scb9hg6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> As Brandon alludes to downthread, we probably should use strbuf for
>> things like this these days, so a preliminary clean-up to do so is
>> probably a welcome change to sneak in and rebase this series on top
>> of.
>
> Sure, I agree that would be a better change, and I'm happy to reroll
> with that.

Or we can do the clean-up after this 17-patch series settles, which
probably is a better order to do things.  It is usually better to
make a longer but more mechanical topic like this pass through the
system rather quickly, which tends to minimize disruption on other
topics.
