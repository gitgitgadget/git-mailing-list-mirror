Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C2C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5A61152
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhDOShn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:37:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53014 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOShm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:37:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66CDD134A4D;
        Thu, 15 Apr 2021 14:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p4XRDISrvHBR
        FYH8MQdGpJqx24g=; b=jYtLfB4uMMH6C/N3yWC1nyHyENB1LWgh1e8sYZ45Vwi2
        VixSNrLTYcgB3EhPO/Az0K/E+ZILMmcoB6VT1oXRhxKd+VFkUrDy4CJJNnj/yxhp
        3ekmGWUlZ42UC6DYOf02CWWZKIVjawGTDV+69TWr6fKPc+FTVzyRSNuZ5h/QbQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WKEj/+
        618ZGOoQy2zTrL+1qOLp7hTtR2BNDFbgwjmNA7aRRH5J9qZW8KGLDLLqFhOSUMOv
        Az2QcVU30RUNAZ20YXA2m0IJze5hbquMYgGNlJ2XCbPbCabDUD823+CUWRVCM60w
        WtIgyObJsVAwW4FJetQhoZQZyEj8jgM0lgsQo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C604134A4C;
        Thu, 15 Apr 2021 14:37:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4992134A49;
        Thu, 15 Apr 2021 14:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to
 test_commit
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
        <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
        <xmqqk0p7b3d5.fsf@gitster.g>
        <CAPig+cQSS8yp-K8Z5q9eG1t-7sFAyuPEvFDNvX_JaY07BKcMhQ@mail.gmail.com>
        <xmqqpmyzm71v.fsf@gitster.g> <878s5jvl3i.fsf@evledraar.gmail.com>
        <CAPig+cRJ1j_FJcuf-T2xhPhJBWGH0_84SfbZ7V9NbSP+QdJpXQ@mail.gmail.com>
Date:   Thu, 15 Apr 2021 11:37:15 -0700
In-Reply-To: <CAPig+cRJ1j_FJcuf-T2xhPhJBWGH0_84SfbZ7V9NbSP+QdJpXQ@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 15 Apr 2021 10:52:33 -0400")
Message-ID: <xmqqczuvqtr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9A6943FA-9E19-11EB-9509-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Apr 15, 2021 at 7:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Apr 13 2021, Junio C Hamano wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> I don't care for `--raw` either but couldn't think of anything bett=
er
>> >> at the time. But perhaps a name such as `--allow-escapes` would be
>> >> clearer, or perhaps not. `--c-style-escapes`?
>> >
>> > It's printf(1) style escapes ;-)
>> >
>> So, the conclusion of this thread is let's keep it as --printf?
>
> It was bikeshedding on my part, so I don't feel strongly. As
> mentioned, I only brought it up because my first thought was to wonder
> how interpolation would work. One might suggest --printf-escapes or
> --string-escapes but the audience for this is so narrow (Git
> developers) that the short and concise --printf is probably
> preferable.

After seeing you raised the issue, I wish we had a better option
name than --printf to be even more clear, but the wish is not strong
enough to make me say "let's stop until we come up with the perfect
name".  I am OK with --printf

Thanks.
