Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5784EC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F5C20870
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="czSzG2LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCQ6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:58:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63999 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKCQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:58:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D3CEE2E34;
        Tue,  3 Nov 2020 11:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8J2p2VS8WHqe
        nqbcmI/nPKFTjfg=; b=czSzG2LM1Q8fLmwtHuDC+RFc6hVR/HdJV2IyxEqPEVg7
        3LhdF7t92XuyzbF1PAGjBURwvTEDTegAa3ZhIVZ1gzDlj9ZbM4pBXJZ4dODlWm9E
        z0CsRBv1ak9XrkHpmPdmgKw4pMQiZbYgAHg8kVJ1pjUk0ykRCO9buxH78zPAnsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ewiEEm
        kG1DRybvWOgUIYq+rKh3csaVY/Rkgv3vIJQq5DG+tk6D0itR9f1tFgUfTQK0b6cS
        Pb1lOni9AdKoQEAu5K9YTi975gwZ9Zv0GrPhGTZm6o/MHvkhaoaiw5N6HjewACuH
        Yv4zlhTJybxEl/0Akqwo3z5lKbiXDBTHgZCPs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75C7FE2E33;
        Tue,  3 Nov 2020 11:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2103E2E30;
        Tue,  3 Nov 2020 11:58:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Barzilay <eli@barzilay.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git <git@vger.kernel.org>
Subject: Re: git-diff bug?
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
        <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
        <CALO-gusRt4J5ar45mo7un-EENyt5cX2SQvcXgyMmaHNZg5bFUg@mail.gmail.com>
        <xmqqlffjs8ws.fsf@gitster.c.googlers.com>
        <CALO-gusFac+GNrB9Rcbqteyv+gs5h0A-PTxnwRswZMhTnNBFyA@mail.gmail.com>
Date:   Tue, 03 Nov 2020 08:58:04 -0800
In-Reply-To: <CALO-gusFac+GNrB9Rcbqteyv+gs5h0A-PTxnwRswZMhTnNBFyA@mail.gmail.com>
        (Eli Barzilay's message of "Mon, 2 Nov 2020 22:14:07 -0500")
Message-ID: <xmqqpn4us7hf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF3B50DC-1DF5-11EB-8B1F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Barzilay <eli@barzilay.org> writes:

> On Mon, Nov 2, 2020 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote=
:
>>
>> Eli Barzilay <eli@barzilay.org> writes:
>>
>> > How is it valid?
>>
>> Just this part.  Any patch output that correctly explains how the
>> preimage text changed to the postimage text is a "valid" diff, and
>> that is how Ren=C3=A9 used the word.
>
> To be clear, the "valid" in my question is about the correctness of
> the expected behavior,...

I know that, and that is why I clarified that you two are using the
same word differently.

> In any case, I think that I now see the problem: the (sparse)
> explanation says "Ignore changes whose lines are all blank.".  It
> would have been helpful to clarify with "(but blank likes that are
> *part of* a change are still shown)".

Looks sensible ;-)
