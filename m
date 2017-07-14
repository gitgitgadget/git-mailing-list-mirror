Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8097420357
	for <e@80x24.org>; Fri, 14 Jul 2017 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdGNW0O (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:26:14 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34327 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdGNW0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:26:13 -0400
Received: by mail-pf0-f176.google.com with SMTP id q85so51325162pfq.1
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pvBbXnAIaeHPzHoOsc29DtXAVX5XRtf4uNKelTNOk8I=;
        b=LKrWo1uTZPlPlIhm+9dmaxFG5osz525KtWaYRdOJMVJ3MSSPLtI49CSIpMuSz/a1KA
         vjKSinkGiKhBm63u9uW9mHIMNLduX+7ZstB0lfCCxyGd2BRLlHXN83Nwj/hYR+eXcXd2
         TCsIrsKdEsXResIJmBktc76epqQDNGxxDv6EOO5AXzSZ0qBsqBtio604reyhjgpV3CD9
         s0M3xDe/xKZC2g3WS2y6hvfZra25p1lbUYsmwGbts2NDwEjbgD95OO12r17dRZbFVTWV
         voGb/xzsrHJqDvgQ6h/U3J3LY1QXmiT+3h5dTu3q0fR5uUSTrA4PeX69JWxpf6iU76xV
         5AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pvBbXnAIaeHPzHoOsc29DtXAVX5XRtf4uNKelTNOk8I=;
        b=l59tf7e0gO1sNp0yo9HwJI/B5y7lKtNE0D5ZyHMd8QSV0eEkoheXSwlKUpIm76R54v
         WNI7xZDxxdTH9LxbkiItimXRhOSMSiC18Eb+AQ5uR8sZtteCkE7xthzfN90igln4gA1V
         jQL6JqGgleZDhiDHAJBNcEpkZnvk5GADG7u3uus8O6RvDUBfKChRCGKekAupcBVhpJas
         oNDyunrQBznZO7XRs3JXnHlHmD9i/AWKmzC3T9p6qwfnUwn+mvSxKDl0s3/JkIPAD2vg
         ZmaVt5FU0i8ykNEvpKylflelvx+TYx55eOv22uVYKw/KjBDh6c8BjfJIZALOvWhZstYC
         JEPA==
X-Gm-Message-State: AIVw112pYepF5BL4OmznUigvn28y9EpBupjaamgMbRCOSHNUIjmJk/Hl
        zbsand2Tfc7GcsKpW5Q=
X-Received: by 10.99.54.138 with SMTP id d132mr17510678pga.156.1500071172898;
        Fri, 14 Jul 2017 15:26:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id d74sm20839851pfb.31.2017.07.14.15.26.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 15:26:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
        <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
        <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
        <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
        <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
        <87pod23jix.fsf@gmail.com>
Date:   Fri, 14 Jul 2017 15:26:10 -0700
In-Reply-To: <87pod23jix.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Fri, 14 Jul 2017 21:28:38 +0200")
Message-ID: <xmqq4luer6yl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 14 2017, Junio C. Hamano jotted:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>  - This may be showing I am not just old fashioned but also am
>>    ignorant, but I do not see much point in using the following in
>>    our codebase (iow, I am not aware of places in the existing code
>>    that they can be improved by employing these features):
>>
>>    . // comments
>
> [Feel free to ignore this E-Mail and my fascination with C syntax
> trivia]
>
> I wouldn't advocate switching to them on this basis, but since you asked
> for cases where things could be improved with // comments:
>
> The other day I submitted a patch that included this line in a comment:
>
>     +        * "t/**.sh" and then conclude that there's a directory "t",

Yes, obviously I am very aware of this one.  

The thing is, I had to do this only once in the 10+ year since
project inception.  I find that much more relevant anecdata ;-).

