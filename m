Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175691F404
	for <e@80x24.org>; Fri, 20 Apr 2018 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeDTAI5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 20:08:57 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34440 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDTAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 20:08:56 -0400
Received: by mail-wr0-f169.google.com with SMTP id d19-v6so18386773wre.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7cj+cECM9wnqX5B+3BcVqicpbusOvh1/Y02nhC0xZ+g=;
        b=Y+a+vEFPTu0iHKZ0Mwjd0SIh12JTPjo6SZlt2IbWzAF0dhi/F3Be/O3HZTirG3ms7Q
         K5+MbahYiyNpTBHm4AbEKonfrJ0ynwvjW3xHSCaI2swRBFr4b4HT71fj0rvOx8nydIPE
         UIFSLzsTb5bjhqIBSWL+7+u79WQ4/mETsAAttVUoJ7K7uNXe62Kt2S/S4p4uJ4btVqxG
         02OUUgTdf7u0i3w/ENrKXmWvHBmdzIGlExbizTJDE8iXPccJ0Ja6bUMe0ZX35K15pILn
         2zerYOxnnxmM8sxYm2ytMc4MNfvc1ZI/tRcgncAfyXedSZp6G4eLuojVML2mAlRpqPRT
         Ne5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7cj+cECM9wnqX5B+3BcVqicpbusOvh1/Y02nhC0xZ+g=;
        b=kixoEclJmVSwqReL3d3W0bFibmmZhsy3cjQzuoa7ZaZve3oW03K5UWbElXgKMUPp3+
         sg/DKMtWNEoWZXBGuSfeiWK2fyZ/1Jcm+Sdb0Hmn7POF6Nel3WauzbxsxNUVcZgRxB9N
         IlQ8XA2dSTfNb9ijtDgwCpBUMrlkoNWH6S1/JIdxPVANSObmTWUHKRCMLGKi0MeItoV1
         CgbsKf6NQRf6kykWJK6xDjwnPKWkTd5/ttjyQRZ6CpuLwSF6KNxde3u+L2vMDUP8/SD+
         4d5URk1ridPSBeW5MVrrVvL8GO47LcO6CMmehv2jG08vGMkbEWdZ0UJl9DIbRxPddY2B
         TTjA==
X-Gm-Message-State: ALQs6tCHTb196ihlP0lS0Zw4YC04n7yTN5BXvEjDGJAQoUnGJIvLn5ZS
        2P1zEFw1NeqZUFswqb8W7mk3ffWh
X-Google-Smtp-Source: AB8JxZou1AF14QkWhJlouIGtc3js873Qwjww7KDPa97YTT0vnVa7FUs8nOFojaDNRddQk4QqgnSrEQ==
X-Received: by 10.28.114.22 with SMTP id n22mr223151wmc.1.1524182935377;
        Thu, 19 Apr 2018 17:08:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s22sm347502wma.45.2018.04.19.17.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 17:08:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
References: <87sh7sdtc1.fsf@evledraar.gmail.com>
        <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
        <87r2nbeh1r.fsf@evledraar.gmail.com>
Date:   Fri, 20 Apr 2018 09:08:54 +0900
In-Reply-To: <87r2nbeh1r.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 19 Apr 2018 10:28:32 +0200")
Message-ID: <xmqqpo2ud9ih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 19 2018, Junio C. Hamano wrote:
>
>> This question has nothing to do with your "-s theirs" but let me see
>> if I got the above correctly.  Suppose you have a deployed branch
>> (say, "prod"), all developments happen on "master" elsewhere that
>> can be seen as "origin/master", so you may have a few fixes that is
>> not yet in "prod" you would want to cherry-pick from origin/master.
>>
>>     $ git checkout prod
>>     $ git cherry-pick origin/master~2
>>     $ git cherry-pick origin/master
>>
>> Let's say that "master" had a fix at HEAD~2, HEAD~1 is a feature
>> enhancement that is not yet ready for "prod", and HEAD is another
>> fix.  Up to this point you successfully back-ported the fixes to
>> "prod".
>>
>> Then you do merge the tip into "master", i.e.
>>
>>     $ git checkout origin/master && git merge -s ours prod
>>     $ git push origin HEAD:master
>>     $ git checkout prod
>>
>> to make sure that the "master" at the source of truth knows that
>> it already has what our "prod" with these two cherry-picks have.
>>
>> Is that what is going on here?
>>
>> I am just wondering what would and should happen to the non-fix
>> commit in the middle in the above example.  Perhaps your workflow
>> automatically does the right thing to it, perhaps not.
>>
>>
>> [Footnote]
>> ...
> Yeah this -s theirs is redundant to just doing it the other way around
> as you describe.
> ...

Heh, you responded to a much less relevant footnote without
addressing the main part of the message which was a more interesting
question to me ;-)
