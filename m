Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB761F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfBDSK5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:10:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55505 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfBDSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:10:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so866430wmc.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gWiGc1RECpupwDqpwVt/YH5XZ06OMXUQj6nFp7tJKD0=;
        b=i3HpM/U0l+6IsteR5zLg/Y2KdwlGsiMk1fId7w098vUqd+iHHSrLuvlCL87mnt3a15
         HBnDdeUx1Y3sRIr09nPv5Fi7A3nV/WhjCf8WVcJF49h/bnPHNWLYKYW7brguJQdO1WP6
         IbBWK2OdWej+fYW6qqwaAYgRdqp+KQC2N9kKyFbwjd6a3C4k+SLAusREZauldPEVRCM0
         7rUw2fFE9Oz98lYwMWkH3NMVLQCLVhbnqa2TiL7RZbKqMfVsF6BpTmYWt/ly6KMBFHhw
         T6DFN8UsTahvzTGnmi7UL+h7jbnEjclyuMWgc2A4VwjDlhLQUl8QMuKsFDu7IDLP7mY+
         sppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gWiGc1RECpupwDqpwVt/YH5XZ06OMXUQj6nFp7tJKD0=;
        b=cOJWWBJoVfAym2HPZkYMWwvGxUp0kH7fyaZeXV0ZcM3K6A+Gx49/y/4X4BOClP6Ykw
         lWyWbKzKCCoZyY1rxn2ebXmpdr3+4sQU4742YSz020zmLLkNvcienRurY2HrQ2yC8jjZ
         vKcEGth/O/i8oSEAUw6GYhy2EqGjY8+eOfLkqz2LPrpm+OE0Fpvk/RKO7AbSs9z5T6K0
         rtwwKNgPlJNRFP9bIokTqXRmPWizy+X4G5/CJ+GLanOsEt2idWTwiKtsiozb0TYiqPaC
         +EQaAT5PwIZe/jMb23AQCkSWAk2WGJyxL2Jugwe3ejODPNG3n+QjvPm1b9Lzqs+stHVz
         bbjw==
X-Gm-Message-State: AHQUAuZRW9nwxCbgFZ2YEpuAeC90TCvfrgNlMLIXMTrE818Hxcs3vr7j
        fSCHXNkO10K/jMxYzDSkfb8=
X-Google-Smtp-Source: AHgI3IYGICFFahOwFOTCF6RMXxZ5PL+ENi8saqJvbdeLuMlsmji70AlH+sf4N8L63LloQUasmkZ1Sw==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr486711wmd.103.1549303855286;
        Mon, 04 Feb 2019 10:10:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z15sm2581235wml.15.2019.02.04.10.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:10:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Dan McGregor <dan.mcgregor@usask.ca>,
        Git Mailing List <git@vger.kernel.org>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] http: cast result to FILE *
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
        <xmqqr2crxl7o.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B_=qbeimp5=RS-r2gwEjVV9rDE_2_tk_DDqz6rJazvFw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1902041243220.41@tvgsbejvaqbjf.bet>
        <CACsJy8BtaxMRTG4-r3iJfUuR9k-=r=4QTRxCkFt3k3p7826Z9A@mail.gmail.com>
Date:   Mon, 04 Feb 2019 10:10:54 -0800
In-Reply-To: <CACsJy8BtaxMRTG4-r3iJfUuR9k-=r=4QTRxCkFt3k3p7826Z9A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 4 Feb 2019 19:13:06 +0700")
Message-ID: <xmqq1s4nwhjl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> The disadvantage, of course, would be that other call sites would not
>> benefit from a manual auditing whether the argument has side effects (and
>> thus, whether a macro using the argument multiple times would result in
>> very unexpected multiple side effects).
>
> That's just a better reason to "fix" it in compat/. If you define a
> git_fileno() function and map fileno to it, then you won't have to
> deal with side effects of FreeBSD's fileno() macro. All evaluation
> happens before git_fileno() is called.

Hmph, so the idea is to have

	/* do not include git-compat-util.h here */
	int wrapped_fileno(FILE *f)
	{
		return fileno(f);
	}

in compat/fileno.c and then do something like this

	#ifdef fileno
	#undef fileno
	#define fileno(x) wrapped_fileno(x)
	#endif

for FreeBSD in git-compat-util.h or something like that?

I think I can buy that.
