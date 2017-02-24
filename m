Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD343201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdBXSOF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 13:14:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35040 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXSOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 13:14:03 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so3867540pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B8QBYVt3K1Rpvs5n4JnjBN+duZld5cHIAA98j5fH19Q=;
        b=kYzpelqESDv8gdk6/ewXleWvs9MzCv8cxysU2ab1ATTkXVN8w89ERdwWsoEW8gheZz
         TTUIZ2T5eyItcGZThf97zybHDzir/g2FaSyICpZc2/CjcwMW6uCshaHNCh/rMFgpSM26
         en2zrqBPkDgeeMDr3SDwZmtVMxbAlKJw/DrPQvcAz4mSZ/JOpJAf2NR7DYH8bWZVYzMa
         U3pcHcaEy/UYWQ8UlIIm4FGRImE2NADqrSzHcJU4rH9YFJxDWpJ4J1wd8kBx6ZB90nGa
         SlSm7gEceJrbzdsSPfkGqfPeblKyRjJQTJkBt3XIoVpGNETiRcWNTbV4kgDlsyLEImeB
         06Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B8QBYVt3K1Rpvs5n4JnjBN+duZld5cHIAA98j5fH19Q=;
        b=bbyh9/GlchSqfDcNTnF3MbOL8h3CDVt3irdKVE57aJCsg1dKznyfAgCQnhc0ZQzhl3
         BiXrnW9cnife0JM7ilf5Wh4Bt7EpYoBLxxzp61982ncF5S2fhcBjGpQPYEvKYMDAfpIR
         JxV2iCgWzVwhwc+SoZKSLUuIJP5hksj3DZiJY6PDcrNyeyvTQL/0QUYLxf4hPhyZCsCA
         Zl5xDiELEgQyUjUK7bs4PYqIzER0/Vi32jh9E4q0K2KjNyvPK9CntHzYkHm0Kwth7oX3
         lPjSzUhQRwMc/eXSbxc8pn6EDvUyI2Qp63hQ1vewwgTgXhL89rdMoeIe/L2JeQr6Zxkp
         90Cg==
X-Gm-Message-State: AMke39k0CGi7H8Ds4J5Rlst+8/ost/5j5/FnefQ7X6IjvgXDhrN04BSlviKnMzTSNv8K6A==
X-Received: by 10.99.51.76 with SMTP id z73mr5110295pgz.137.1487960042651;
        Fri, 24 Feb 2017 10:14:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id v69sm16409132pgd.18.2017.02.24.10.14.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 10:14:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Lang <david@lang.hm>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
Date:   Fri, 24 Feb 2017 10:14:01 -0800
In-Reply-To: <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc> (David
        Lang's message of "Fri, 24 Feb 2017 09:45:55 -0800 (PST)")
Message-ID: <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Lang <david@lang.hm> writes:

> On Fri, 24 Feb 2017, Junio C Hamano wrote:
>
>> *1* In the above toy example, length being 40 vs 64 is used as a
>>    sign between SHA-1 and the new hash, and careful readers may
>>    wonder if we should use sha-3,20769079d22... or something like
>>    that that more explicity identifies what hash is used, so that
>>    we can pick a hash whose length is 64 when we transition again.
>>
>>    I personally do not think such a prefix is necessary during the
>>    first transition; we will likely to adopt a new hash again, and
>>    at that point that third one can have a prefix to differenciate
>>    it from the second one.
>
> as the saying goes "in computer science the interesting numbers are 0,
> 1, and many", does it really simplify things much to support 2 hashes
> vs supporting more so that this issue doesn't have to be revisited?
> (other than selecting new hashes over time)

It seems that I wasn't clear enough, perhaps?  The scheme I outlined
does not have to revisit this issue at all.  It already declares what
you need to do when you add the third one.  

If it is not 40 or 64 bytes long, you just write it out.  If it is
one of these length, then you add some identifying prefix or
postfix.  IOW, if the second one is sha-3 and the third one is blake
(both used at 256-bit), then we would have three kinds of names,
written like so:

    20769079d22a9f8010232bdf6131918c33a1bf69
    20769079d22a9f8010232bdf6131918c33a1bf6910232bdf6131918c33a1bf69
    3,20769079d22a9f8010232bdf6131918c33a1bf6910232bdf6131918c33a1bf69

and the readers can well tell that the first one, being 40-chars
long, is SHA-1, the second one, being 64-chars long, is SHA-3, and
the last one, with the prefix '3' (only because that is the third
one officially supported by Git) and being 64-chars long, is blake,
for example.

I do not particularly care if it is prefix or postfix or something
else.  A not-so-well-hidden agenda is to avoid inviting people into
thinking that they can use their choice of random hash functions and
and claim that their hacked version is still a Git, as long as they
follow the object naming convention.  IOW, if you said something
like:

 * 40-hex is SHA-1 for historical reasons;
 * Others use hash-name, colon, and then N-hex.

you are inviting people to start using

    md5,54ddf8d47340e048166c45f439ce65fd

as object names.
