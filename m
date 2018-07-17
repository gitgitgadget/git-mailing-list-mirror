Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375271F597
	for <e@80x24.org>; Tue, 17 Jul 2018 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeGQWSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 18:18:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38212 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbeGQWSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 18:18:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so772656wmf.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TFI/szuh8YygOLdK/q36258i5Lk1HzwqWIxdyhYsGVM=;
        b=JqIl6CyAu/2d8sdP+Len6qeO1eRF01yPod2l2s5jnFAwpND55JavZ+gg7L52h7wj2d
         cWDB5SKuithhlhFTxC9EkOF//n9lvj46yGp3rvJnb5pRBDPuHtR9L/M0c4P7GBV6Hlpt
         jBVt++FEANtWzl1RmhnSEQ3L3t6F7CFFKooRGasN09nziVsQOI32YGsE0R7nAKnRkgO2
         Am42YO5zD3XTuaatkThMoyQhPIxmnlki2nDZDqCSAqWsbmHIMMtu70/fhrBfRL1ue+SI
         YulaHPdP8+CaX6cea7UhsZzb7vUPlpQ4YrScP/96d34LUHbjjayRkv3uFQgnjZQKKwDj
         9QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TFI/szuh8YygOLdK/q36258i5Lk1HzwqWIxdyhYsGVM=;
        b=pR5d6bOzHa/3zLlsccN6Dx+IGuw6HWRZhiTXY3i80UYGmOKigZ+utNMUR0aqpNtIJF
         QioFSxZ1wnMW+xab2kY3LcdwBHfooDD9hU48kUgjU1kmO2iGPCwfB6hzcSVyNwvmZRmt
         rD1maSL56T8EpH5QH0A4ATv6V0YmkBCRGdcBJjm0MgTULUkGHXJVGd+O/7PnKjqovL+8
         ujfdBBMtPDNKPVtoKnmqUZONdcsdimEG5qgJthmib/CPmjNTV6gJGwt2vB9eDDx3W4sQ
         O84fHbJZSbpaPSqI1+KNZfok0QpWMbyrGj/qzvrAyg9KxqkmdGR6HfS5PaxgMGyKWdvD
         z6FA==
X-Gm-Message-State: AOUpUlEU2KHrjULuSEaqFgQ4QnMu7gchO7UPhEQtg/Fdjdds8Jen2km7
        S69mdL5Na+0xh20IU5sAOi0=
X-Google-Smtp-Source: AAOMgpcQ3Q0Lt/7ao15Vub0HYSmbjrBXj1hGj/Ng6Y2oMBY520viT13GeJFN4Y1rBS80iyls7Puu8Q==
X-Received: by 2002:a1c:ec1b:: with SMTP id k27-v6mr2270994wmh.157.1531863851935;
        Tue, 17 Jul 2018 14:44:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z8-v6sm4398335wrp.54.2018.07.17.14.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 14:44:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] submodule--helper: introduce new update-module-mode helper
References: <20180717002654.120375-1-sbeller@google.com>
        <20180717002654.120375-7-sbeller@google.com>
        <20180717075959.30594-1-szeder.dev@gmail.com>
Date:   Tue, 17 Jul 2018 14:44:10 -0700
In-Reply-To: <20180717075959.30594-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 17 Jul 2018 09:59:59 +0200")
Message-ID: <xmqqy3e9leqd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	fprintf(stdout, submodule_strategy_to_string(&update_strategy));
>
> Various compilers warn about the potential insecurity of the above
> call:
>
>       CC builtin/submodule--helper.o
>   builtin/submodule--helper.c: In function ‘module_update_module_mode’:
>   builtin/submodule--helper.c:1502:2: error: format not a string literal and no format arguments [-Werror=format-security]
>     fprintf(stdout, submodule_strategy_to_string(&update_strategy));
>     ^
>   cc1: all warnings being treated as errors
>   Makefile:2261: recipe for target 'builtin/submodule--helper.o' failed
>   make: *** [builtin/submodule--helper.o] Error 1
>
> I think it should either use an explicit format string:
>
>   fprintf(stdout, "%s", submodule_strategy_to_string(&update_strategy));
>
> or, perhaps better yet, simply use fputs().

Sounds good.
