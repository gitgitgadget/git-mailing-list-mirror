Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E0B1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 17:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAWRy3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 12:54:29 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52756 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 12:54:28 -0500
Received: by mail-wm1-f52.google.com with SMTP id m1so299242wml.2
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6tLOzzDt7yWxvjNoCA1GjgV4eIkNCU73lfVxnttigu8=;
        b=cEDK42Iuq58SYIRGGsbE73LaS21fyTlamv9msIK4gbSxxYT7o1hZvu4cR55fyL/Azi
         hvESzcFT843wrtaZpdKTFWahc1Q+bapNpA+7YPYqPEmI5uFxxYI5qA0GgDK3pvUYmVGA
         Tlv+q70g1oNprq69QtIra0RDmTiouSDHoD6YBYh6iOiwE6NJYEyBg4BAvOIcXr+nX+oA
         jGYuahc/g4ozA+tNHzqP2KN39K3jooDzuyC806HG1j991KY/3vNe0F1hudF8K2Ds5b5W
         8YT4AeH5Mk2UFq0SM+HKcOMP2eWYDkw28pFN7leT5XabLOgQhJXCLJTYKx8J0DYY9Lov
         3uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6tLOzzDt7yWxvjNoCA1GjgV4eIkNCU73lfVxnttigu8=;
        b=IMS1Suz0+FWKDVwHf7eZKu2WMDrqOF8RLeJL13VPZj+tETyAFTK4fN4u5Nq70wqlPb
         GsZZ8l1DbOIbbtxwZyQRWDFTLLLJdbd5G2A80252l/bjFzxmwEcORwrvSv5qFra6yXYs
         nL/6ikPBmLS75immP3my5JhQ77qiGlJgt+Ni0svKXp9kaoTasTfoOnF/FWqDuWn7Y+FJ
         Yqn0ZHYSYUcj1GKsylbGbgHlXvJI1iO9g9KhOQCllW2U5bWUUyEKjMR1afXeB5pjIYx2
         I+smmyIi7l24gThXR352WXBmB/dju/KeIDAvzfKk/PKkrpKDq4a991cAOF01XQ6z+bBz
         x1fQ==
X-Gm-Message-State: AJcUukdbd5NoDY58adZ5X/JnN1lZRu1z49rFDGI6kLUWqxtN4YMzt1+5
        cD4IyUhLu7w0RsCnfFIwP1A=
X-Google-Smtp-Source: ALg8bN6rdyVYRMgp3QixMpwqfv/CmxB6bcAu1PKKp8FobaV33stfflz+8sgHEhk28MLxttKgI/U+UA==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr3576350wmf.77.1548266066631;
        Wed, 23 Jan 2019 09:54:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t63sm50582199wmt.8.2019.01.23.09.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:54:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command] [-f command_file]
References: <20190110115704.GL4673@szeder.dev>
        <20190120075350.5950-1-tboegi@web.de>
        <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
        <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
        <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
        <f7871d8b-a19b-5816-120b-ce583debc4ca@web.de>
Date:   Wed, 23 Jan 2019 09:54:25 -0800
In-Reply-To: <f7871d8b-a19b-5816-120b-ce583debc4ca@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 23 Jan 2019 07:35:24
 +0100")
Message-ID: <xmqq8szbcl9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> I'd still prefer to see a more terse[1] (and not capitalized) message
>> to be consistent with existing error messages and to keep the reported
>> errors more compact overall to make them easier to digest[2,3]:
>>
>>     err 'sed option not portable (use only -n, -e, -f)'
>
> That's OK for me - lets see if there are more comments.

Thanks, both.  Eric's proposed message looks good to me too.
