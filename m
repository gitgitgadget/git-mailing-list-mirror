Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31DD1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 01:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeKFLIw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:08:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKFLIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:08:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id y3-v6so11335745wrh.10
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 17:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tH53flpxxw1Y/Lfnb873u/C8h27f6HD7wl1/i6IsBqc=;
        b=VKckDJkGR3OrFIOhowR8ev9lV7+951dFi5eYbqoBcDH9g3qmMKPSW0qejuxxO5Xqlq
         dnLkZavY2IubCmZjJBDuD7ayTdN6SHG78/loEi33wSJCiluTGvXzQJIVlgrwJq77O0D6
         MBEUZ5WBMIVhQG7rzPWgCCh291aemjTuEiQkmDRdDi9x8rQrFr9LTQhWAd4MkjCwQyHq
         SqAQYJqAcOTFcquDpknSf+kk0Xpyx8DcB+d716JAZqNG5RgbqWss0tXtael0Qvtcw+kt
         q/mscrbcUq+gWc/xRMMmAukjshHrpY0wwDELn0XrnhffF5lAiwZYE5g1EjhF/nB5KED3
         4g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tH53flpxxw1Y/Lfnb873u/C8h27f6HD7wl1/i6IsBqc=;
        b=mrK14nkaID6i1hzdGqrb5Hnim20SBszzKMp5wELtQuHjgCfZMvUx4q1Z9hid+j8a6F
         CkiXozsse82FXeYRLn1SQDCPDM8VyLjfJzlcOcisa1UARU/75zjLXducFreBs1iDC+aY
         wfGCcbWK6FJ59m7F8GFSNn5a1qfIvULEIJ9TkDSpakbgdFZ0prRyS45NY7pFgV9r4i6K
         4PH8bzFiFbcTfwHLmkSuGsVlXFDaFWvFdkk3T1PgLuKXEQ3SRAEBrXkA/wCOLIiUPZtt
         OtggDAKeOvpPbRc6njaLEJzCq02fwy7qzNEJSoulBX8KKNsfcQ/My+2JVmzH2Sej/7wo
         UP7Q==
X-Gm-Message-State: AGRZ1gKXZ/NbnJSY+86LV7IKoiX5dHayff/8ewD6oEvYxjLJWB5CqCb0
        Y6c1SlQ3lgK1e4vZX0eq5t4=
X-Google-Smtp-Source: AJdET5fFiQZKS+pnGrz8wDmBKLAmefqD30vnc0JSDfJvFglT5k8RslxVkD5hYZQgbNRd6IFL+Dm7/Q==
X-Received: by 2002:adf:8224:: with SMTP id 33-v6mr21357354wrb.160.1541468770137;
        Mon, 05 Nov 2018 17:46:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 21-v6sm443948wmv.5.2018.11.05.17.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:46:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 4/5] pretty: extract fundamental placeholders to separate function
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-5-anders@0x63.nu>
        <xmqqtvkwjn1k.fsf@gitster-ct.c.googlers.com> <8736sflya8.fsf@0x63.nu>
Date:   Tue, 06 Nov 2018 10:46:08 +0900
In-Reply-To: <8736sflya8.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 05
        Nov 2018 09:32:47 +0100")
Message-ID: <xmqqr2fzgeqn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> Junio C Hamano writes:
>> I do not think "fundamental" is the best name for this, but I agree
>> that it would be useful to split the helpers into one that is
>> "constant across commits" and the other one that is "per commit".
>
> Any suggestions for a better name?
>
> standalone? simple? invariant? free?

If these are like %n for LF or %09 for HT, perhaps they are
constants or "literals".
