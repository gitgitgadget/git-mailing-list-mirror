Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCD91F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCWWFC (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:05:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36935 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:05:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id 139so6028970wmn.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IC8fp0S9caK5EQ8IU6eQ2N/iN1cYkb4E9l+rw59NrwE=;
        b=hGTamTzr2C2WNzv9JnYGJ4tD36M8UFxtsb3AcLW/s4xd1bjVznbg7/71xccNlFtWVB
         IllQcFxaSh8bXDy3iYCuW32Eio7Bjc7E1DRQE1bUJIAZdgfK+/vB/+k37hs+B/JM6ySM
         P8aEU9p7/1LivGpmICaP3EvWrnc3664yn0hFGGSKWRSp2opbbQeBBPfqo/3aVEDp3pTw
         AMtX+58zlEMjv74S5vrdaN9pNcRy4lbL7y0hfXOjdFpshcFpQGvOIUiwC/+MCD8KQPTx
         cFSo3daIpiZjdNN0VNXhebBsuijLBZBN0Q5clT22/QQJ1W/W+UjSPAIRd3f6a3LaRWpR
         15Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IC8fp0S9caK5EQ8IU6eQ2N/iN1cYkb4E9l+rw59NrwE=;
        b=Z7mOecAu7YsboKG302RNBOQFRtxUG+WkjoRNGiuG3CEXV4eirMvORkz09lEPhHH1z1
         DnC5vvWT2tB/lHfwsaY66J+z2NOYd42jfXHQaSsY16Az0gExcBa9HfCX7umioZDpzLF8
         KIKox3KMwb6QDT4dF+o3PwMdsDaSPk4EWyR7FnqkGixXO1JoyxqixQ/YAhKacf8zV9VK
         bRnoI3LOKkFf5vIf/RPjDhm8o7f87U3tnl6zdtWUWOwXO9wEzN4PYn03Pg9xaryi/AsB
         XVP48yRSUw3kDPxnWICXgTNQtsLLMeGIAv51hvFUuTEW6mNikgv/giFMZxqkcwwARdss
         DiKQ==
X-Gm-Message-State: AElRT7FQb07EMJtvX5WTXb6n+uTph+vpRJvJ48AUH2xZmBGLSfiROTl1
        ihhFXsts5kQbCvUmsDSy0wg=
X-Google-Smtp-Source: AG47ELsShRiBa8arqCMgC4eNbwcdPVbYxY2M6MNsVyTtJYSLZ4Nf6tCBCkS+lCICFEHZ/sMJ9SGgcQ==
X-Received: by 10.28.24.66 with SMTP id 63mr9467252wmy.115.1521842700069;
        Fri, 23 Mar 2018 15:05:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 95sm10118649wrb.47.2018.03.23.15.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:04:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Loganaden Velvindron <logan@hackers.mu>, git@vger.kernel.org
Subject: Re: [PATCH v2] Allow use of TLS 1.3
References: <20180323193435.GA21971@voidlinux>
        <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr>
Date:   Fri, 23 Mar 2018 15:04:59 -0700
In-Reply-To: <alpine.DEB.2.20.1803232246020.16250@tvnag.unkk.fr> (Daniel
        Stenberg's message of "Fri, 23 Mar 2018 22:47:41 +0100 (CET)")
Message-ID: <xmqqtvt6h2ic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Stenberg <daniel@haxx.se> writes:

> On Fri, 23 Mar 2018, Loganaden Velvindron wrote:
>
>> +#ifdef CURL_SSLVERSION_TLSv1_3
>> +	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>> +#endif
>
> Unfortunately, CURL_SSLVERSION_TLSv1_3 is an enum so this construct
> won't work.
>
> Also, let me just point out that 7.52.0 is 0x073400 in hex and not the
> one used for the first version of this patch.

Thanks!
