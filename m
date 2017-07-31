Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9861F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdGaUKu (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:10:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58383 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751113AbdGaUKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:10:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8B19A4950;
        Mon, 31 Jul 2017 16:10:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uO5J6AX6GOQP
        Lw5zd1SUyrM2noQ=; b=ExlIJdiJgZ6BZx+XKZN11b8F5yxoaKbWN4+6hB/Yi0jm
        uP8LTuVv5bdJCkgHGN9b2IYOCv8TuTKuYNtWUdELktbjPsVzyA5fSS4Q2kKBkVfi
        JidvH2uOwdow9KvCuZiXNSCz9h8Au7FEGhSiG/9rkQBtkiZ5JOiVdM/Tt/X42XE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WTg91t
        BcAHJ3/6uzu+DFMgTwEf+hyfTo+ebViRgyU5BQ92j0jdtM2h83I93YYT5mBkQ5oc
        l8qZSXiTdNTUo6qyKfe/hq2KAhaGYeNQt2eCogLKgSIABPC/1nI33xCgD5SYlj4f
        KiFDq0scoxMQYjzCjluABZXiIjEer0sz+74jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C18B7A494F;
        Mon, 31 Jul 2017 16:10:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 36706A494D;
        Mon, 31 Jul 2017 16:10:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 00/10] tag: only respect `pager.tag` in list-mode
References: <cover.1499723297.git.martin.agren@gmail.com>
        <cover.1500321657.git.martin.agren@gmail.com>
        <xmqq379qkalj.fsf@gitster.mtv.corp.google.com>
        <CAN0heSokk9RAYx7pB_qC5dbZ3N1ZJQgKkrmhrPXmyHjFsnJu7Q@mail.gmail.com>
        <20170731034632.r5m3ncgb5scqvltb@sigill.intra.peff.net>
        <CAN0heSonTXWPf-iTbwRbUc8CpYHoX7GBS5uCFFXn3bEPmWtitA@mail.gmail.com>
        <20170731174509.w5hwujpsa4dt3jxv@sigill.intra.peff.net>
Date:   Mon, 31 Jul 2017 13:10:40 -0700
In-Reply-To: <20170731174509.w5hwujpsa4dt3jxv@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 31 Jul 2017 13:45:09 -0400")
Message-ID: <xmqqd18giczj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53A9D27C-762C-11E7-9A76-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 31, 2017 at 07:44:27PM +0200, Martin =C3=85gren wrote:
>
>> On 31 July 2017 at 05:46, Jeff King <peff@peff.net> wrote:
>> > On Sun, Jul 23, 2017 at 08:17:42PM +0200, Martin =C3=85gren wrote:
>> >
>> >> On 21 July 2017 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>> >> > I tend to agree with you that 1-3/10 may be better off being a
>> >> > single patch (or 3/10 dropped, as Brandon is working on losing it
>> >> > nearby).  I would have expected 7-8/10 to be a single patch, as b=
y
>> >> > the time a reader reaches 07/10, because of the groundwork laid b=
y
>> >> > 04-06/10, it is obvious that the general direction is to allow th=
e
>> >> > caller, i.e. cmd_tag(), to make a call to setup_auto_pager() only=
 in
>> >> > some but not all circumstances, and 07/10 being faithful to the
>> >> > original behaviour (only to be updated in 08/10) is somewhat coun=
ter
>> >> > intuitive.  It is not wrong per-se; it was just unexpected.
>> >>
>> >> Thanks for your comments. I will be away for a few days, but once I
>> >> get back, I'll try to produce a v3 based on this and any further
>> >> feedback.
>> >
>> > Overall it looks good to me. I left a few minor comments.
>> >
>> > I actually like the split. I found it pretty easy to follow (though
>> > squashing as Junio suggested would be fine with me, too).
>>=20
>> I assume that by "the split" you mean patches 7-8, not 1-3.  Anyway,
>> I'll squash since you're fine with it and Junio prefers it.
>
> I actually meant both, but as I said, I'm OK with it either way.

I am OK with it either way, too ;-)
