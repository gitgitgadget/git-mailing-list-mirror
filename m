Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EF51F404
	for <e@80x24.org>; Thu,  1 Mar 2018 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161913AbeCAVFD (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 16:05:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40962 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161904AbeCAVFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 16:05:00 -0500
Received: by mail-wr0-f194.google.com with SMTP id f14so8002355wre.8
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q8AZgJlHVHFEL3YwDteeGOisJu/a7mOb0mGjnTRgb+o=;
        b=Eh3VKDHyMHttazq1EPAiQrJO034o/bTG2KEhHRwBU1c9CbqBi+5+JAeZXKd99A78fW
         0cKaRXr4P3+0YSGDEvUUmk7kl+MuwXKQvcI7xcXVWlloZE7cCMCc4ZuUAA/DSF8TKBvM
         5X+8rvUW7i/pqg5VDCb3p42UTHKPF9pq1SPer/m/cpEdEHWhYj2xABEwiuXetn00H/aK
         Lad1z16fkTogCtHiIY+TzmO/T5J5b6zZDf6BPkUwtdQ3xeSFJkTnb8InNW89jRwhUfl3
         +Ka0JrOqDFzFT/LjWkgaKDnVJwtO2FIgfm0FX6rMpRiOfKF1D+JFMKQENk6JXV6Qwoxg
         DYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q8AZgJlHVHFEL3YwDteeGOisJu/a7mOb0mGjnTRgb+o=;
        b=WvPC5jmz5HtspCf0cJTM90otxYRaTagiShEVYRYB5sTOY7845j5NvsRJm/SIOytDl4
         yPes9dxrqEZ+/r+uZVPizQSujn2K6LisrtDDGPRIeK6AWwnuDD+VEg3qpWt4S6a/xByh
         Z1f9JUEgPsKtajcG3lPWBSoxYYj5vZgZJSDwQXt1X2Cz0aBYikYJZ31Au8kEm/qBDmr3
         gFCFwdUq2lpgzqURQrzZK6TL6RVF9zalmqHB0uR06g/AIxE/R2sGidhBPmJbrGTrEG3A
         r6PIDO3kbsjo98XowZzxwaxU6hH1rsesng+gQZJmLthex5r8q++5EkYsR4FZyya7/+Dy
         kQ1Q==
X-Gm-Message-State: APf1xPDVhCukEYH339MIafiA0JWpbpfU4dSUEaZBGJSdgH8QWKihIcPh
        mC6bHG2woTN/0io++i2mxvc=
X-Google-Smtp-Source: AG47ELvlhmyOG5lMl5zaS4iEELMGRSqmAMXHeQROyaTIfz/Q3ap1oiB9o/qeaWXc8ew9hQz/Yi4z4A==
X-Received: by 10.223.169.4 with SMTP id u4mr2772572wrc.170.1519938298977;
        Thu, 01 Mar 2018 13:04:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d8sm2313874wrf.8.2018.03.01.13.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 13:04:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 03/35] pkt-line: add delim packet support
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-4-bmwill@google.com>
        <xmqqfu5jfrlb.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 01 Mar 2018 13:04:58 -0800
In-Reply-To: <xmqqfu5jfrlb.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 01 Mar 2018 12:50:24 -0800")
Message-ID: <xmqq7eqvfqx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> One of the design goals of protocol-v2 is to improve the semantics of
>> flush packets.  Currently in protocol-v1, flush packets are used both to
>> indicate a break in a list of packet lines as well as an indication that
>> one side has finished speaking.  This makes it particularly difficult
>> to implement proxies as a proxy would need to completely understand git
>> protocol instead of simply looking for a flush packet.
>
> Good ;-) Yes, this has been one of the largest gripe about the
> smart-http support code we have.

Hmph, strictly speaking, the "delim" does not have to be a part of
how packetized stream is defined.  As long as we stop abusing flush
as "This is merely an end of one segment of what I say." and make it
always mean "I am done speaking, it is your turn.", the application
payload can define its own syntax to separate groups of packets.

I do not mind having this "delim" thing defined at the protocol
level too much, though.
