Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F16F1F829
	for <e@80x24.org>; Sun, 30 Apr 2017 23:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999279AbdD3XtJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 19:49:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35574 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032155AbdD3XtH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 19:49:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id o68so6772937pfj.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xoJsCvjXulsRClEgU/628IWtlsp7jkyoUo4C9koSMBQ=;
        b=ZBkm1wbjtsWb6NMP/MWm0HYvYd2ISBbnDoxFRA0u2R1iJdz4WIds3Iadrcx7XH+14m
         cQW9u6wwka+PkCs7BMjtPj5Gr7CAX1l5nxOT5BG05afB0rEzpFORNFHQV22Ay/S0h3hX
         /QThEMZESwkHFQVzlXScscK370lcat0BjuNT4mPrOCXCN2uF7PGGdokLSS7BUZgeCGtP
         XR9BiiZHz1ZnJGhg+wwqaAOdcOe56yOugR2W1SWJVXJqC+b7y4LXNXr9Zw9OnBiXq1ii
         OTpPApdVOa16PubD6qgaziYuMwhZMuzqRp70VOsB70s/B8cXTQxVOLMy+SLRjeg7psJA
         lvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xoJsCvjXulsRClEgU/628IWtlsp7jkyoUo4C9koSMBQ=;
        b=C7XHllz3GX+Mcb7NSKroOML0Wxeqrbkh2py1OCp22s/3TCjZwkNDvZRhDqWQVJWwb8
         pr7RGuAotycfGeDunDtk96Tq8lu8LCtmqQamV5v4tHx5194wr+YUPGx+948GsIR5vURM
         dDI1ibk2pbnqb2InAcGMKk4gM84EFQ9yPGjnOjzS5pbMNVqJwNigx74175Eh1+zKlICq
         KY0KHTWIZIHmUGE83pgcH2pW/nn+UXqUZ4lUZTe0VZ61CAW6abJAS1yYqzNtkP+wCRu3
         ZyurrbWLPaTn+FElsGLu/YDOOJfQxG/qkS33ocZPlfH3NlYwZ9HAi6QRO37UMmF4jEAx
         CckQ==
X-Gm-Message-State: AN3rC/4XsPiFpkE3fh4dH98W9MSPwJXWApzocK3bcYfjxER60OEibLgZ
        lFtR7anUJ+R8w0h7skc=
X-Received: by 10.98.192.129 with SMTP id g1mr23619228pfk.254.1493596146808;
        Sun, 30 Apr 2017 16:49:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id k196sm20965579pgc.0.2017.04.30.16.49.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 16:49:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger than 4GB
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
        <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
        <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
        <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
        <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
        <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
        <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
        <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
        <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
        <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
        <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
        <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
        <9f6cb421-db61-51ca-6a4b-ea7c94bd513e@kdbg.org>
        <d1cea1c3-f974-c839-dbdd-5bc95756be84@web.de>
Date:   Sun, 30 Apr 2017 16:49:04 -0700
In-Reply-To: <d1cea1c3-f974-c839-dbdd-5bc95756be84@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 30 Apr 2017 18:40:00 +0200")
Message-ID: <xmqqfugplamn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 30.04.2017 um 18:32 schrieb Johannes Sixt:
>> Am 30.04.2017 um 09:53 schrieb René Scharfe:
>>> @@ -178,7 +182,8 @@ test_expect_success EXPENSIVE,UNZIP 'zip
>>> archive bigger than 4GB' '
>>>      "$GIT_UNZIP" -t many-big.zip
>>>  '
>>>
>>> -test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with
>>> files bigger than 4GB' '
>>> +test_expect_success
>>> EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
>>
>> Why is LONG_IS_64BIT required?
>
> Blob sizes are kept in variables of type unsigned long.  64 bits are
> required to store file sizes bigger than 4GB, and this test is about
> such a file.  A 32-bit git can't use the pack we supply the test file
> in, so we have to skip this test.
>
>>> +    'zip archive with files bigger than 4GB' '
>>>      # Pack created with:
>>>      #   dd if=/dev/zero of=file bs=1M count=4100 && git
>>> hash-object -w file
>>>      mkdir -p .git/objects/pack &&

OK, so let's queue this on top and have it in 'next' to unblock
users of older unzip and unzip compiled wihtout zip64 support?

Thanks.


