Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D8A1F859
	for <e@80x24.org>; Tue, 30 Aug 2016 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757922AbcH3KTz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 06:19:55 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34957 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757848AbcH3KTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 06:19:53 -0400
Received: by mail-yw0-f182.google.com with SMTP id j12so8325976ywb.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KRn74KzC473nJydvce194hG0MUzAlO1SacIPC6NQSUM=;
        b=zfRR42Vn6u8BpNYYiy1EqloC/hB/jGEFrDhif3BQVkgcCSR6ScEYmpKFTp27UIPg18
         wOP8khjk9PzimUKFu1if4J0vk26GDQ+71O4rKBeM+CaQ9yzrRDfnJ7f4eQMPylYhUGZ2
         crpWpiApQAtkm1a9j1hOPueEYieUKxEi6/sCnD0bBPf2zDwfFgfZ8LRM9i/fDG0E8t3h
         tdL6A8qF/fRmVayQ614GInQ00Et+CmgDSqh9o9iQjWhvYKz81biCHLZIiHeWS8mXKTDe
         zs41Pm3qPH6nlL98c20QaPnQvGdn2TZX47e205OLeoUCI8hHqvqvXjMAfZiuagvQVI60
         DL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KRn74KzC473nJydvce194hG0MUzAlO1SacIPC6NQSUM=;
        b=elpfvngblaBYIrHZnuyTmF+nboVjhgWgkwQUI43ioOh750rPG5UgdDRjcHr3EkFQ+w
         q73LnfGwjB7vkakymCN9sEZhBR9e2mkpxS/u7Na127TPqcvatJQPeVGpOZMDFbHNGuPp
         o6oJYlP/Lbn/AeLiXJ1JrGb4N7HC7LxQbt3w3PLxUYcSKYR9lQFysQ3KobHR3oh/f1MG
         ymA3GxApK62jc8zefEVRT2ANpaPRePcjuoLPMjew+jJkM5+coGnSfWG8a8andl1jlibk
         PB7GqWJ5/ZEa4UpM0mCQ4O++/gOXTPw1hCt5xtm301JoDO+w0fcY9WaqSBgyzUoO9ps7
         lvgg==
X-Gm-Message-State: AE9vXwMAxCNNIuZq99ifsFMC3BD1GhBrmC3OZDIji9ou7Rj06n2JCD2Iv64VmaXOxMAqm42l0a2Mem5DKQmKFA==
X-Received: by 10.129.125.135 with SMTP id y129mr2402510ywc.107.1472552391892;
 Tue, 30 Aug 2016 03:19:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.42.12 with HTTP; Tue, 30 Aug 2016 03:19:51 -0700 (PDT)
In-Reply-To: <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org> <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 30 Aug 2016 12:19:51 +0200
Message-ID: <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 9:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Highlevel view of the patches in the series
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> This is "part 3" of the full patch series. I am resending only the
>> last 14 patches of the full series as "part 3", because I don't want
>> to resend the first 27 patches of v10 nearly as is.
>
> Just to make sure, you are sending the first 11 of these 14 exactly
> as-is, right?  I didn't spot anything different other than 12 and 13
> that replaced the "alternate index" step from the previous round.

Yeah, the first 11 of the 14 patches have no change compared to v12.
I didn't want to create a "part 4" as that could be confusing, and
sending the first 11 patches gives them another chance to be reviewed
again.
