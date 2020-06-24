Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB12C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CA520706
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KG2iq+be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbgFXPoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:44:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54089 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404199AbgFXPoK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:44:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 622CEC8C16;
        Wed, 24 Jun 2020 11:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XApRwpDLryMy4nXs6pU439rp0fo=; b=KG2iq+
        bewnVHaTJ3rPWBjPhWI29IBNCrw/Eq1nQWfCoPdMC+0wKEFSlwkH4nsK+zo35Q2V
        U+bewvguaF3mC7jjIjPw8RXIG+6Vi4CKB3wdfLbDZ6+UhvVJ3ZT1AYhMXx9VIFi+
        v9Ax53DWAbufc108KTRNw+xhEMti0pi9Prlnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n+JxW6B3is/WSUFXDKukNq+eCvM0zenf
        wxXvQPgtBRIaANi93nkW7F9NBUdZVXtHPJTFUgujb+nm0U2wUJwycpxvqFKarz0y
        b2JJpXpG8tuXRrkUU1/MJ0UU7/rkJVOw0AL2vGeBPJWZmDkIjnPQo08jP9SFfqJ9
        p54AgYzi8og=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59600C8C15;
        Wed, 24 Jun 2020 11:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A47B7C8C13;
        Wed, 24 Jun 2020 11:44:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 2/8] send-pack/transport-helper: avoid mentioning a particular branch
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com>
        <xmqqr1u59u5f.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006241443200.54@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Jun 2020 08:44:04 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006241443200.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 24 Jun 2020 14:44:20 +0200 (CEST)")
Message-ID: <xmqqlfkc8o57.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8908CEC6-B631-11EA-9B46-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 23 Jun 2020, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > @@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transport,
>> >  	if (!remote_refs) {
>> >  		fprintf(stderr,
>> >  			_("No refs in common and none specified; doing nothing.\n"
>> > -			  "Perhaps you should specify a branch such as 'master'.\n"));
>> > +			  "Perhaps you should specify a specific branch.\n"));
>>
>> Hmph, not just "specify a branch."?  Maybe it is just me, but
>> "specify a specific branch" did not roll well on my tongue.
>
> Oh well. "Perhaps you should specify a branch" sounded too judgmental to
> me, but I'm not a native speaker, so I simply removed the word "specific".

I'm not either.  Note that when I say "maybe it is just me", I
usually am not asking to change anything.
