Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5ADD1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeCFXHe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:07:34 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40098 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeCFXHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:07:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id t6so1235225wmt.5
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z3lg4U5yE2FgjmlSxAcHrMsNzPd50gp9Sbyo4gPtQQ8=;
        b=jkNv5G7Oxs41Z5Hi872gfbF/35fxo3uT/EpM5fTcCAvyd1RcXat8kkMG8UgmaG0mAm
         0VQ4G/8eLFd+szK/nI6/bKiFZ5droLyK2GdF3jACCp7vVt+yfZ44kKfE/csZIINMNMIE
         iZ9m21sbkNiNFe1VZN7LWAYhocS3ARjDcpKR/yJLCF7h3KnVLUdtrGGWrOih7cF9AyKU
         f2nm/t80izZegymxXbd4yYi9t41A7rz9kTS+Vi3+Hx+r1mN6b+KIkfoz2A1mZnoyOZeD
         aX4FUFt8MyiHeX7PcmUovd523fQhq7szKYr0TzZiq7e7TL/7DuGCUlfh7GNY4cAyPUvk
         vJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z3lg4U5yE2FgjmlSxAcHrMsNzPd50gp9Sbyo4gPtQQ8=;
        b=WVy/GuqmrLja0R73HyliaEAc6njNnonnOp+I9vCwEEi752XEPSiLBfwqG3BfQ+7En1
         ZDrbtmHTpGUsraMWfAmc+7g/Wv5jhIM3cJ3HKuQonYx5zAlf0dxIikmC7MasgQK8Btg9
         JfuzlHSxozNgCh0u/0Ns9S1HkECDowuUMkf0r0HWxcxCsREzulIqigflEifzy6daBTfI
         MqKKlCk6kWV4loeQMdssmWi7sJomDGBHwuOw0PFS50kHg9kK1KyVgWLq9+rTF3sjJnwK
         I+ccWDD+mx8+pPA+hZDGMgmNAWAKYFo5Yt6Cn9KqfAgFS15h+8LfAYLLhI9nKUez2GrN
         Cs3g==
X-Gm-Message-State: AElRT7EcTfjN1q8Dm6g1eEzfvgHG948oMrtSjduNMvF0HrKDiQE8VGe4
        tLvoiHUR6B4L2BzKRUPq8KA=
X-Google-Smtp-Source: AG47ELtldDfA4ALpuS1UbttmaEWG39l3H1o6e0sJfF+YRKJVZMicBYk6b1u6MWn1qP5qOZLxOLIe6w==
X-Received: by 10.28.74.199 with SMTP id n68mr12149101wmi.83.1520377651740;
        Tue, 06 Mar 2018 15:07:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c47sm16994672wrg.22.2018.03.06.15.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 15:07:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-5-lars.schneider@autodesk.com>
        <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
        <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com>
        <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Mar 2018 15:07:30 -0800
In-Reply-To: <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Mar 2018 14:53:25 -0800")
Message-ID: <xmqq4lls3irx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>>>  Also "UTF16" or other spelling
>>> the platform may support but this code fails to recognise will go
>>> unchecked.
>>
>> That is true. However, I would assume all iconv implementations use the
>> same encoding names for UTF encodings, no? That means UTF16 would never be
>> valid. Would you agree?
>
> After seeing "UTF16" and others in "iconv -l | grep -i utf" output,
> I am not sure what you mean by "Would you agree?"  People can say in
> their .gitattributes file that this path is in "UTF16" without dash
> and that is what will be fed to this code, no?

FWIW, "iconv -f utf8 -t utf16" seems not to complain, so I am
reasonably sure that people expect downcased ones to work as well.
