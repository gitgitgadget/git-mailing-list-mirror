Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40DC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203B02076E
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4UVWPOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgKJPfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgKJPfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 10:35:13 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC45C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 07:35:13 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so15189721ljf.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M8MbeTAHaiDyiQW1HZ0d/kEUnqvgtEFTXKPqTGxzUVs=;
        b=N4UVWPOeufAPnt0K6Gv3NDVaVN0BbVwQ3cTvvRpLYDqXBJ37kADYMUVlH/AZqGUvZK
         v+MSzc/yuS917ufxjI9GEc6NNbO4EIwWj6seXu70ewt3VFPrQEDLig/5v/KiS7W/ZWHd
         cyvGrun2my8V01+k2BLGDPeqqXQ5jtettGcJ7yX2C359pARWsJNhSTmSApsKrceEMC9P
         N0CzQVkxOZvlqI3kf2p1q0oRSI0r3D7p0ScK/ObXxb0kdYzrTgwcGm9HpVYMxlKWCinM
         4r1UShaYAcasQ1Xl0IJdiRFcGwqug5qRVY+EUY+NI/Hh9P7sTPhKb9JJbvfLHCRZKuOv
         EneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M8MbeTAHaiDyiQW1HZ0d/kEUnqvgtEFTXKPqTGxzUVs=;
        b=qnXPsKVarm5TCYkqd3ROWQR+9kF+QHkkZOLGfKgJNg0jnnxNxuWuSvkcLsVh0hfcy+
         WH8wQLFFrI3K6M9iWNdBvtpd9ha3GVI+RkKvL9BdUUGgFHP4zUt/EFss+EDDEAJBAlWV
         fBh5yBJ/eX+k4XTKTmzFSZji7Bk0CT+ZrvzEZyBrALVgD2XnZico4kdVYNbQriiTBAy3
         1szQNf7rlnceKIegBK1atsFc5E4q9Ej1JJCcm76HfdY24PNCv1dqYYyNfuGnqZ4KC2uA
         EUjxfwvwlvttBvUTRLJyaOeUuMPJ1AMyXWKmLzjLSl47+mECX2iD9MVM92k527gVFpM3
         YXvw==
X-Gm-Message-State: AOAM532l5/3lT1RS57ljVxrd541l3fQO6yTJZ2UzhnVE+9TPa0FQQBOP
        jZzJ3b5HsWKXs4/wbMz78yZeRtKsEcBmLexS
X-Google-Smtp-Source: ABdhPJzDZbURWRyNAVTMTnT1xsyvXHZER4jdycUWtHCs77+dGo0lhO7mKh4MqeI0OD4shbGK445KaA==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr7918412ljp.315.1605022510833;
        Tue, 10 Nov 2020 07:35:10 -0800 (PST)
Received: from [10.5.0.5] ([185.204.1.184])
        by smtp.gmail.com with ESMTPSA id p204sm166948lfa.168.2020.11.10.07.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 07:35:09 -0800 (PST)
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20201107234751.10661-1-dgurney99@gmail.com>
 <20201108095739.23144-1-dgurney99@gmail.com>
 <20201110003127.GA1268480@coredump.intra.peff.net>
 <20201110023620.GH6252@camp.crustytoothpaste.net>
 <xmqqft5h92fm.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet>
From:   Daniel Gurney <dgurney99@gmail.com>
Message-ID: <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com>
Date:   Tue, 10 Nov 2020 17:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 10/11/2020 16:04, Johannes Schindelin wrote:
 > Point in reference:
 > you can build Linux applications in Visual Studio like _right now_ [*1*].
 >
 > Ciao,
 > Dscho
 >
 > Footnote *1*: It currently uses GCC, but who says it always will?
 > https://docs.microsoft.com/en-us/cpp/linux/cmake-linux-project

When it comes to building C++ code MSVC uses Microsoft's C++ Standard 
Library, and one of its stated non-goals[1] is being ported to other 
systems. I assume the same applies for their C library. Therefore to me 
a scenario where a future version of MSVC would build non-Windows code, 
let alone for a big-endian architecture, seems extremely unlikely.

That said, I understand your overall point of view perfectly, and I'm 
fine with either one of my patches being applied since the end result 
today is the same.

- Daniel

[1] https://github.com/microsoft/STL#non-goals


