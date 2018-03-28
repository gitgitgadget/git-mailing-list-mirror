Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA931F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbeC1Wfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbeC1Wfw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id b127so6717263wmf.5
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qULeNTl+kIgO1i0r8pnfhK/2Jlg2DndhCVLzn9dUvsw=;
        b=vbamtypqqpsxMKm1gE7sy8HOGvEL88JXLfrr2B1EGWG+EtEiqTL42tBW5Vbps64mGm
         fU/CyGtPmBVFmhbnGi4U41POOf6wM3xzYs8ZSFbIbsx6VwLOq6ceuel8aLBb94R5x3R4
         TN0i6Xlc5DMGhYiii+FiueqpkVYHEDXtJC28kO/ILsc1GBRRCv8KAa4gGK9Lxx5587wt
         QnYwz6nf2hN+2WOXcjci8BLjCdnQEEUnoxBhWkTtRfYrgoyH+//ruDb4KnRCtHQtICMj
         f1LtMiAWyqoKfYTIWmAYJI0HMnOy2yk0gFa9/KFX+bQzJkFH7+S4Qp8zGtviAcOugVYG
         JyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qULeNTl+kIgO1i0r8pnfhK/2Jlg2DndhCVLzn9dUvsw=;
        b=Cr+wU9rHJz+qDEENh4PBtvQ3qs6N8MLLVEqwAB2nAyD/9buvRaXbQUb4KUT7dNpMN6
         /j6s9veMIQ/TxeiQm4vQ2CptjKb1Imr71bMXZzYVpZ181TzBY2lKjvlIlth7lMkLZQKx
         C0DmuLuHIphye4SDF53u1M+2SOwLaKhfcv8+90fUO4V1jy7n4k7hB6UAY09nnOBqsdR3
         Z/K8W39NZaUA47P+NGYwd6kJvBs8Xjqjcmz63GkIayn8w11lyiYVNzZoI4u/+OuJkqMI
         L2smjPFGIGugV74/tTXHym8FTKBr7hu3QLrcZ7y7/kcxBlYldhqfr1g8/QwjgdNOIF72
         gdew==
X-Gm-Message-State: AElRT7HkR1qXPIvHb8kXpoYIHXAVPRfUl4hYaxRSyPfHPFcQLlfGjmd9
        KnjgBtYaB+whJRHGMMQMEos=
X-Google-Smtp-Source: AIpwx4+hAbSoPrZurkrdUq4UeVHLgZiFzhT8fjXWMWLjQmvvdMijXo1zIf2XHO3RsBB3XXam37v6PQ==
X-Received: by 10.28.143.149 with SMTP id r143mr4189216wmd.24.1522276551344;
        Wed, 28 Mar 2018 15:35:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f22sm768924wmi.39.2018.03.28.15.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
        <20180328183832.243036-1-sbeller@google.com>
        <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
        <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
        <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
        <38570708-e166-0004-878a-2d8442c12b65@web.de>
        <CAGZ79kYL55+=9UbW7H-c7OUg6CHbnzdkxs0ZMsFnEAaoVXRwLw@mail.gmail.com>
Date:   Wed, 28 Mar 2018 15:35:50 -0700
In-Reply-To: <CAGZ79kYL55+=9UbW7H-c7OUg6CHbnzdkxs0ZMsFnEAaoVXRwLw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 28 Mar 2018 14:37:31 -0700")
Message-ID: <xmqqd0zn7rqx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> This looks nicer here in the script, but doesn't test exactly what users
>> type most of the time, I suppose.
>>
>> So how about this?
>
> Looks good to me, though I had a nagging feeling at first that the
> regex could be made more concise.
> Why do we need the optional "[^ ]" inside \1 ?
>
>> +       sed -e "s/^ \([^ ]* repo\) .*/-\1/" <actual >expect &&

At that position there's 40-hex object name.  If we want to go
looser, you could say

	"s/^ \(.* repo\) .*/-\1/"

and if you want to go more strict, you could say

	"s/^ \($_x40 repo\) (heads\/master)$/-\1/"

I think "Here between the leading SP and SP before the pathname
'repo', we expect an object name which should be a run of non SP
bytes" is a reasonable mid-point that is stricter than "anything
goes" and is still concise.

