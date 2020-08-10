Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E34C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D720774
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sL8/dGgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHJPGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:06:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55777 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHJPGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 11:06:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8881EE89C6;
        Mon, 10 Aug 2020 11:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mspCXIeSo4Gg
        uZhgv7fhAxUDjlM=; b=sL8/dGgxkZhwEBJZbRWAhiBQ9pKOa88ivG8M8MkfF0sN
        8CKEIgGkrd34mSKw3Rq+iWPk5zX8JrAGbBChEYFzxsBuQ6gXJbmo0wssIz1s8oxV
        QRR9C/0czIu8FK1boAMSZ2qhsvHtpgmTFJdBghSBeVgQu+CzZNw/Mq2WoeMrz6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AQbgqb
        2/m7o8GwDSkZwwDaKFI5kZoCDKlELieKA9obOIymkOdOp4SyF3KOUt6KJaRr3Otb
        Jg2FIXfpIckK0+qYxuJtwCoGOnPJTr9B4i/c49vvSO39hDrWmZII4B2HWp9cDaqN
        sAqt9aZi+jxtTIreJaZYJPKmeJjhAmBbjDMeg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CC02E89C5;
        Mon, 10 Aug 2020 11:06:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9585FE89C4;
        Mon, 10 Aug 2020 11:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] extend --abbrev support to diff-patch format
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <xmqqd03zej8w.fsf@gitster.c.googlers.com>
        <20200810100038.GB37030@coredump.intra.peff.net>
Date:   Mon, 10 Aug 2020 08:06:07 -0700
In-Reply-To: <20200810100038.GB37030@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 10 Aug 2020 06:00:38 -0400")
Message-ID: <xmqq364uee1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05CEEF90-DB1B-11EA-BE01-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Aug 09, 2020 at 12:01:35PM -0700, Junio C Hamano wrote:
>
>> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> wri=
tes:
>>=20
>> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (2):
>> >   revision: differentiate if --no-abbrev asked explicitly
>> >   diff: extend --abbrev support to diff-patch format
>>=20
>> It was not clear, at least to me at all, what these patches are
>> trying to achieve (i.e. what end-users appreciate) until I saw the
>> code change X-<.
>>=20
>> The changes to fill_metainfo() make sense to me.  It just needs log
>> messages that explain the intent better.  They do not even make it
>> clear that they want to make the abbreviation length of the object
>> names on the "index $from..$to $mode" lines configurable.
>
> After reading the original including cover letter, I'm still confused
> using why --full-index is not the solution for most cases. Perhaps that
> would be worth touching on, as well.

True. =20

Presumably you could force some stability without sacrificing line
length limit by using --abbrev=3D12 instead of --full-index but I do
not think it is such a big deal.  But it does look odd that we use
a special/single-purpose option --full-index to control the length
only for those two object names on the "index" line, when all the
other object names we see are controlled with the --abbrev option.

