Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02361C41604
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936162087D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CTtRXV1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgJGQVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:21:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59285 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgJGQVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 12:21:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39D8D8C192;
        Wed,  7 Oct 2020 12:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+dcsU1pm3CTB
        nPdbqTk5yKVY8Tw=; b=CTtRXV1iAD6+m+SdntY2xZIZSGsVliK7TwUNPwYLah3c
        rbaBkcxyKfyEUuftsesU5W9kUriO9ntUoRx4OXHWAn9XNK4UyKbpSDgHxsxeufag
        esVplQe91hGLKMdrWkqM4KT51zOutcVJLqrjGXe/YROQye8EJiZvv8UGfK+Wpho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c8MyhY
        Mg9jp527fL74Ld4D/KtIS8bWZMDItv78g7edffh1wnT6pF5MhrGKlivgFP5wJYPY
        OypvqDfAgjno6EBSOVADBhUaaNpBbwP/BEEe0HGmyJds1IG6rv3AaqHpskdQHeJm
        C7rmxS3jTizoHAVYF1xSYTFZlTVesNEQ3i/o4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 280738C191;
        Wed,  7 Oct 2020 12:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 597248C190;
        Wed,  7 Oct 2020 12:21:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5534: split stdout and stderr redirection
References: <20201006150818.15698-1-congdanhqx@gmail.com>
        <xmqqft6r5fwb.fsf@gitster.c.googlers.com>
        <20201007001551.GA10178@danh.dev>
Date:   Wed, 07 Oct 2020 09:21:30 -0700
In-Reply-To: <20201007001551.GA10178@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s
        message of "Wed, 7 Oct 2020 07:15:51 +0700")
Message-ID: <xmqq5z7m3t2t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28F21F6C-08B9-11EB-B567-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-10-06 12:11:00-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> wri=
tes:
>>=20
>> >  Arguably, I would say it's OK to change the:
>> >  =09
>> >  	test_i18ngrep ! "gpg failed to sign"
>> >
>> >  to:
>> >
>> >  	! grep "gpg failed to sign"
>> >
>> >  since the latter will be correct even if GIT_TEST_GETTEXT_POISON=3D=
true
>>=20
>> Is it because we haven't managed to translate this particular
>> message, or is it because we should never ever translate it perhaps
>> because the message is meant for machine consumption?
>
> We translated that message.

If so wouldn't the message shown under GIT_TEST_GETTEXT_POISON as
something that does not even remotely resemble 'gpg failed to sign'?

... Ahh, hmm, cute but true.  As long as our assertion is "the
output should not have that message in it", '! grep' would do the
job.

But that probably is not a good example to leave for others to copy
and paste without thinking.

Thanks.
