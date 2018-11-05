Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682311F453
	for <e@80x24.org>; Mon,  5 Nov 2018 03:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeKENF5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 08:05:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34890 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeKENF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 08:05:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so7861811wrv.2
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 19:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OY5GpsqDn9W2E+Zic2N1Ns7Cjl0ZLhkSkhbzo7D2SFQ=;
        b=SAg8FRpb2m1JBcDBuOBLNSJGPJFZp7vwaBjMq0+hypps+NSlZOZ83X3I/C2hOKwHnD
         Ix2QAWjWNmxT45PxUod87tw/ZFUxLAK7uabj4lYodwpRSCUTYX2gpGzmTs46Jxg5TTKU
         g7p+LAUTb2RltqBUE4rTdrrHl+OaizHg3JuQp7lkxU9GbfD7/7+jYYzXufeq9Y1DiiCJ
         IX2ulT47vJNOClOvacflkQE+q4vNXzwiPYJm2DP5RwsM4u0mfbsb/YMT9LTg7ijPDFcm
         375t06BvZDu4ZY7KSJy/kUfxngM7OM2P8HtZ/vCt4qQDZo2uy+Mlrc1qX++28WFn+9aw
         7oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OY5GpsqDn9W2E+Zic2N1Ns7Cjl0ZLhkSkhbzo7D2SFQ=;
        b=Qtsn+s6gNojcrldwvYl0C5qEZgBPvhe+RoxaftgojYezvr510EznBQQuVO1FiRr/Wr
         Gs9baQ82VwaN0lxqfOa5hJ0EOYb0VmUBQeERcUMYi8srGd1chJyHVGJbcNOc0yKK5TqH
         8bQAFdNicyDyLV37olAgq1BnaUjvaSXKmuyN7+2f0FVurm+2MUyznsvB90F9uWEbNnFU
         zGJMYzdQnADornoDe3GqMZQoQFQAQ7qkq3D8REAPohmyvd4HQbR4WEU2YlZWXNLRb/+1
         QVirEWhBBydShwaO1v0hWtiKXZT7ge5VcKYJXtS4u4ROddNomXo8H1qA0OPnNMRFcb8X
         92mw==
X-Gm-Message-State: AGRZ1gL8stEc6gd9oKV2hdfmVWfgfq2R/cuJ6BdsaFwGz232g6mtNEzX
        8Qf1b58+imePN0pprTJb1f0=
X-Google-Smtp-Source: AJdET5cz+yuJpatyesVIUhISpi/Z8/WEPj2UdAlLnF0jCKGkeGMbFFoqGLcB/idzb4wgDHJuPVKbrw==
X-Received: by 2002:adf:f748:: with SMTP id z8-v6mr9184611wrp.237.1541389701890;
        Sun, 04 Nov 2018 19:48:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j189-v6sm683714wmf.18.2018.11.04.19.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 19:48:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     anders@0x63.nu, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-3-anders@0x63.nu>
        <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
Date:   Mon, 05 Nov 2018 12:48:19 +0900
In-Reply-To: <CAPig+cQeUxxvgNGVc_iZ4v0U77obFu6-q0QbtzTJdnEep8eq+Q@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 4 Nov 2018 13:14:34 -0500")
Message-ID: <xmqqa7mojibg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Does the user have to include the colon when specifying <val> of
> 'key=<val>'? I can see from peeking at the implementation that the
> colon must not be used, but this should be documented. Should the code
> tolerate a trailing colon? (Genuine question; it's easy to do and
> would be more user-friendly.)
>
> Does 'key=<val>', do a full or partial match on trailers? And, if
> partial, is the match anchored at the start or can it match anywhere
> in the trailer key? I see from the implementation that it does a full
> match, but this behavior should be documented.
>
> What happens if 'key=...' is specified multiple times? Are the
> multiple keys conjunctive? Disjunctive? Last-wins? I can see from the
> implementation that it is last-wins, but this behavior should be
> documented. (I wonder how painful it will be for people who want to
> match multiple keys. This doesn't have to be answered yet, as the
> behavior can always be loosened later to allow multiple-key matching
> since the current syntax does not disallow such expansion.)
>
> Thinking further on the last two points, should <val> be a regular expression?

Another thing that needs to be clarified in the document would be
case sensitivity.  People sometimes spell "Signed-Off-By:" by
mistake (or is it by malice?).

I do suspect that the parser should just make a list of sought-after
keys, not doing "last-one-wins", as that won't be very difficult to
do and makes what happens when given multiple keys trivially obvious.
