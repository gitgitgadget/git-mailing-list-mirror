Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04311C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A3A6100B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhDGWte (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:49:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52038 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGWtd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:49:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60E8D135E3A;
        Wed,  7 Apr 2021 18:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dQ3ckYNcFEud
        rhlV+s6ZQfMqtEo=; b=PggA3pwUaAPFc41km0bgv2C23BRQGIIy3gjF08OOuVVD
        Pg9GDcSP1vztYICUnve7H2xeYlF/m62MIOEyZH8iPyU6fQRL1dDzL8nObAgspldJ
        klPi6Q9j4agHWp/G+240+TiM3ndgRUTjg0V0wKd37gY93BWfWFJk2FHbzPzmEvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TQWJ2W
        2yiwOWiBQClHMmZZek81AkhauWzB9Yuh9K7nFFP6T/Kd3m27MSmxq7J/Og9q0C26
        kT/d+o6MYk854w2cW4eevDzkjEV0xz9f0tPds1sxF1M17OUOfcD2JheMq09Eh7rw
        PErvqAS1Tbusho3g4r4u8+aGrUQNZXhzB5rMw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42805135E39;
        Wed,  7 Apr 2021 18:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68D61135E38;
        Wed,  7 Apr 2021 18:49:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
        <87r1jmjxdg.fsf@evledraar.gmail.com>
        <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
        <87czv5kaxw.fsf@evledraar.gmail.com>
Date:   Wed, 07 Apr 2021 15:49:18 -0700
In-Reply-To: <87czv5kaxw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Apr 2021 00:05:15 +0200")
Message-ID: <xmqqy2dtww0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D915F46-97F3-11EB-9606-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Apr 07 2021, Derrick Stolee wrote:
>
>> The purpose is to allow us to modify a 'struct refspec_item'
>> andproduce a refspec string instead of munging a refspec string
>> directly.

Ouch.  I thought the goal was to take

    [remote "origin"]
	fetch =3D $src:$dst

let the code that is used in the actual fetching to parse it into
the in-core "refspec_item", and then transform the refspec_item by

 - discarding it if the item does not result in storing in the real
   fetch

 - tweaking $dst side so that it won't touch anywhere outside
   refs/prefetch/ to avoid disturbing end-user's notion of what the
   latest state of the remote ref is.

so that the "parsed" refspec_item is passed to the fetch machinery
without ever having to be converted back to textual form.

Why do we even need to "andproduce a refspec string"?
