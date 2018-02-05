Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42911F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeBESeG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:34:06 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45713 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753681AbeBESbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:31:37 -0500
Received: by mail-wr0-f193.google.com with SMTP id h9so17660483wre.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+BOh0pNF4BfpJOuRECRY8Y+rUc8H0GZg7Oo1R0lcZwc=;
        b=jGJqnnOfKpJeZtvvaRAKweUVg9ZJkXlwC96VHQIm4mQQCyccQy7DLPcRfAhCaoTBf+
         diVscZBwB2jfSDmFDF69pkBLJllIckehBwZtIUiJqVQ6NJnZmvpGiRG0fHJZFcnxwlsR
         96qZHFrJAoNnW1J4kzBxHu5nCTUDRbRLc3sMdeGS24ptCEE/B7fsxhnh69ElDxUbhfiu
         6DamM3lKld3rLjxFD1Vpm2xLbL8FY3/BtY7Lk7FfKMFsgBELG2IIZMNsYRDz1TzFsy6S
         NAn5RCpzcXp3utl86r2SWK+jaFIMcmxvtfX59L+CmyGE1Z6cL44zY9jjeyLeVEUm4dQS
         1QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+BOh0pNF4BfpJOuRECRY8Y+rUc8H0GZg7Oo1R0lcZwc=;
        b=ZZeoRAw+odgHCJWcvK7npUdYO4ubaEyLneXZiXk6jE7kDd8jXMw/X6J83taxeG5/lU
         jkOKokUzl72GPKzwgoVLDWykA0X0NXoH07ZsG1ZmURd9JR1ux9TOSzzC1FZdJq7OM/ow
         jxSJbQZOWfWm2bIkQRFWDI5yVpos0DFFnqpUE0dzLwZ6vrWW7JpyUpL8i3usawtDqyRH
         UAZwS/VI5wDpAV1qatrCm8HOGftHj9Xtk47StaoSYzWZFu6xdY+S0rw/GtYD3upXIQwF
         Tt7wnMJx62uuKowhscYB0x68EZhl4zcfgZM8BlzzF3k/7V6uCrSB17V+wJ9XmOjUiyhV
         4AwQ==
X-Gm-Message-State: APf1xPDm33Km2pVkbVBsDjJW8THyaCMYOXAy49x5EqQ3926gifM1IpSJ
        YGMR32+qoGvpqZZnn1dfv8c=
X-Google-Smtp-Source: AH8x225yWNkx6PsT0HDufGkuJQMdwfoBS+mi0i5VHkde8V4RtOSlsxiJW3Cds/EQHWcZztLF9LQS7A==
X-Received: by 10.223.201.147 with SMTP id f19mr4943904wrh.61.1517855495935;
        Mon, 05 Feb 2018 10:31:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 204sm9241482wmx.0.2018.02.05.10.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 10:31:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lucas Werkmeister <mail@lucaswerkmeister.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de>
        <20180204183037.23162-1-mail@lucaswerkmeister.de>
        <CAPig+cSOH-V9aZDALOEX56ENXChexOVWzsgKgtvDULryqP0Kyw@mail.gmail.com>
Date:   Mon, 05 Feb 2018 10:31:34 -0800
In-Reply-To: <CAPig+cSOH-V9aZDALOEX56ENXChexOVWzsgKgtvDULryqP0Kyw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 4 Feb 2018 14:36:14 -0500")
Message-ID: <xmqqlgg7b855.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Feb 4, 2018 at 1:30 PM, Lucas Werkmeister
> <mail@lucaswerkmeister.de> wrote:
>> This new option can be used to override the implicit --syslog of
>> ...
> Thanks. With the 'log_destination' initialization bug fixed, this
> version looks good; I didn't find anything else worth commenting upon.
> Ævar's micronits[1] could be addressed by a follow-up patch (if
> desirable), but probably needn't hold up this patch.
>
> [1]: https://public-inbox.org/git/871si0mvo0.fsf@evledraar.gmail.com/

Nicely done.  Thanks, all.

Will queue.
