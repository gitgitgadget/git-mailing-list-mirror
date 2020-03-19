Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F475C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C98D2076E
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 22:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMteexmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCSWCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:02:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCSWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 18:02:41 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C738A9BEA;
        Thu, 19 Mar 2020 18:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6A2DpfRm4ygh
        AAzIQbmHwYeLzDI=; b=yMteexmoEvTUWaRUntfuh8rUzzXvZ7NS3X8Ejy125iTJ
        QN5+a2ZpXtuG/aEjf5gKw19o+92sxu2cSGhcrPcVafFtgx1xkkNiZXlLzzhyh/4o
        eJPjQpXE1xLmSmJe7cZgjI4hmITXvbSOa+53iAyP79YWfkIpvYAd6pu4JYQeynk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cf1/6A
        dHY5vq0R6wnmrrQYfvOTO5Ca3IqQiH7bySCSkUy1/rfB+eyPaqtYM6/IRyKMLMUV
        BPcZJI7WZYMK88DaSS8wdpOtczqofvXa9K5rcV3FZbIiiZ/CV64BJQloeNKR3pFe
        oEnEOCoHBijhocQ1kB55N8PIRFPrM3gxq+nn4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93B4BA9BE9;
        Thu, 19 Mar 2020 18:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC2D2A9BE2;
        Thu, 19 Mar 2020 18:02:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] t4061: use POSIX compliance regex(7)
References: <cover.1584625896.git.congdanhqx@gmail.com>
        <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
        <20200319155307.GB3513282@coredump.intra.peff.net>
        <CAPig+cRzHtGu2KfjoO4DaPWzDrJOhEQGkgo2Fm7egUPM9m7Vyw@mail.gmail.com>
Date:   Thu, 19 Mar 2020 15:02:37 -0700
In-Reply-To: <CAPig+cRzHtGu2KfjoO4DaPWzDrJOhEQGkgo2Fm7egUPM9m7Vyw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 19 Mar 2020 12:01:28 -0400")
Message-ID: <xmqqwo7gc8aq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 591A7598-6A2D-11EA-8E6B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Mar 19, 2020 at 11:53 AM Jeff King <peff@peff.net> wrote:
>> On Thu, Mar 19, 2020 at 09:00:02PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n =
C=C3=B4ng Danh wrote:
>> > Fix it by using literal `+` instead.
>>
>> This makes sense, I think. It could hurt a sed which is expected ERE a=
nd
>> needs the "+" escaped, but I think such a sed would be wrong (and I
>> imagine would break things elsewhere).
>
> I had the same thought and considered suggesting a character class:
>
>     sed -n -e "1,4d" -e "s/^[+]//p" <"$1" >.tmp-1
>
> to make it painfully obvious that "+" is not special in the
> expression. But then I thought better of it -- for the same reason as
> you (to wit: such a 'sed' would be wrong) -- and decided against
> saying anything.

I have only one thing that needs fixing, which is s/compliance/compliant/=
;
on the title.  Other than that, it looks good.

Having said that, I would have done the [+] thing if I were doing
this patch myself.  As long as we see no "wrong" sed that is broken
by this change, I am OK with it, though.

Thanks.
