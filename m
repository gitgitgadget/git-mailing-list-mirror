Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C7C433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499BD64E28
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhAaUxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:53:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63972 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhAaUxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:53:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AB74115B98;
        Sun, 31 Jan 2021 15:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E/USyV2JMH2z
        W79773jEG3NK2EU=; b=VtN9WyCe8aryEDDmMOatq9kuNWiVolJH+NxntqkqXAR4
        SLLBxa7n/5nDvstvKaVW1MlzkAzVhGgTPtLqpVysff71ePnuUsf0FbUg4m2eWFfs
        sD6C1KzbRjiLBN9iwSq4dwRy3l+y0LBJjvCIOgc069k8kVYhReIC52UhE9c4Ia4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QnUw13
        RIBbF8YSsD+Q0k/OQrDZrr27hKQvBXpr11DXxjPy9dzI+70LWqhGewMxVkkSZ7dA
        4XCA36NEfGkk7js393q6G4DRgAZFa441iij+rjTqrEHUBzEo1T/aIx1KCrEomzLG
        4f+hdiyuxujzSjKazBZqxxTHH/p0aMkXY/IcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84ACC115B97;
        Sun, 31 Jan 2021 15:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A7446115B96;
        Sun, 31 Jan 2021 15:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <20210131172107.GA2091@szeder.dev>
Date:   Sun, 31 Jan 2021 12:52:37 -0800
In-Reply-To: <20210131172107.GA2091@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 31 Jan 2021 18:21:07 +0100")
Message-ID: <xmqq7dnsomlm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41886EDE-6406-11EB-B9F1-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Sat, Jan 30, 2021 at 04:00:56PM -0800, Junio C Hamano wrote:
>> [Stalled]
>>=20
>> * sg/t7800-difftool-robustify (2021-01-09) 1 commit
>>  - t7800-difftool: don't accidentally match tmp dirs
>>=20
>>  Test fix.
>>=20
>>  Not working on Windows.
>>  cf. https://github.com/git/git/runs/1660588243?check_suite_focus=3Dtr=
ue#step:7:4186
>
> I think v2 of this patch fixed the test failure on Windows.

Ah, I missed that.  Yes, there are all-green runs on seen and this
topic is certainly part of it.

Let's merge it down.  Thanks for spotting.
