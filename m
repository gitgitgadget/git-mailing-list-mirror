Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BBC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BF923D9A
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 19:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbgLJTBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:01:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63909 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390510AbgLJTBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 14:01:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DFCF91414;
        Thu, 10 Dec 2020 14:00:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DSY5qDmCwxe3
        aWyRzVxzvm2TQ8I=; b=hMJHNHFKyvqPuT24LZiF5QD2LSi5wQnbbH22mrxdRsH+
        HQu5c+Ja+p6/7P7tmUXFetG1g679w3WwdT864JjAh7WJBCgVqF/N9m8qMBjF20db
        wLae/2Z1ytezxkgmMIaZ/96k/mkMC0blO0EZ02V+te8BrL6Wzi4HQUFFFq+zSPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Btg7Ay
        RgIVYeaJS1iHnKRzDfKNLv4nJ4x+5xjk0Fgb9U7xUE6HF7T9oin4NXck0ftHD53V
        TP+KYGh54Vswxv7a247QugTgnEDySnojHyLwK1hendj2g/t+8eJtnsph/k7sRjit
        zgAGwnNXruJZnd1/fG6QM3emxO1q8wdZixafU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 721B991413;
        Thu, 10 Dec 2020 14:00:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3E2491412;
        Thu, 10 Dec 2020 14:00:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Anders Waldenborg <anders@0x63.nu>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/5] pretty format %(trailers): improve machine
 readability
References: <20201206002449.31452-1-avarab@gmail.com>
        <20201209155208.17782-1-avarab@gmail.com>
        <CAP8UFD0A-wLb3eAHWtnkd-kUbiEt=BReP7pKjgHOktcNrtRnTQ@mail.gmail.com>
Date:   Thu, 10 Dec 2020 11:00:37 -0800
In-Reply-To: <CAP8UFD0A-wLb3eAHWtnkd-kUbiEt=BReP7pKjgHOktcNrtRnTQ@mail.gmail.com>
        (Christian Couder's message of "Thu, 10 Dec 2020 11:48:01 +0100")
Message-ID: <xmqqzh2lv63u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FE0FA600-3B19-11EB-9D91-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Dec 9, 2020 at 4:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>>
>> A minor iteration on v2 with a commit message wording change &
>> s/=3DBOOL/=3D<BOOL>/g in the docs, as suggested by Christian
>> Couder. Range-diff below:
>
> This one looks good to me!
>
> Reviewed-by: Christian Couder <chriscool@tuxfamily.org>

The range-diff looked minimum and didn't introduce anything funny.
The unchanged parts I only skimmed, though.

Thanks, both.
