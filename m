Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEAC00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4C322268
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 00:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhuJFzNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgKCAcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 19:32:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61474 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCAcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 19:32:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7782F1030BF;
        Mon,  2 Nov 2020 19:32:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mID16z8BFWnA
        oTpRln0EFmKlKhk=; b=YhuJFzNsXfFuoyMiq+IEdlyKfkjmBBvYeFYY8q6yE/Ds
        nHPBDzMtyzt+7igO62wXLTEfI4do3PAYq+/wsWzqluZNY0UPe6apz4dU3XYtbfSC
        d070JnCKBgJd0zr4D6uIuw+rKdKKAcgtV3kgKIK3Saxv+XdiNbdx4OXpmCdOZl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xAROoi
        1rklBljzNzGxSnLlBK/+ohFdBkErj+RioVbngi3YfcGDud8hTxTdwvQIPm8NNLl5
        2mU0qbidOcRAuzJlccjlDVgDokfZn/psDn1aQdgUBw2P4cDJGpbdnPiQJWaZPRjw
        bw6aEW4LF3003hs+UFXq/umR3VmA3AgrBL0/k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 705F51030BD;
        Mon,  2 Nov 2020 19:32:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5BC21030BC;
        Mon,  2 Nov 2020 19:32:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: ag/merge-strategies-in-c, was Re: What's cooking in git.git
 (Oct 2020, #04; Tue, 27)
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011020333440.18437@tvgsbejvaqbjf.bet>
        <xmqqv9ensao7.fsf@gitster.c.googlers.com>
        <693f417c-5612-7878-a055-2810f62af3b4@gmail.com>
Date:   Mon, 02 Nov 2020 16:32:10 -0800
In-Reply-To: <693f417c-5612-7878-a055-2810f62af3b4@gmail.com> (Alban Gruin's
        message of "Mon, 2 Nov 2020 23:31:12 +0100")
Message-ID: <xmqqlffjqnzp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 037A2992-1D6C-11EB-91E3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> I just went back to the thread.
>>=20
>> https://lore.kernel.org/git/20201005122646.27994-1-alban.gruin@gmail.c=
om/
>>=20
>> It seems that the topic saw quite a few comments and help by Phillip
>> Wood in its earliest iteration, but I didn't see any review from
>> those other than myself on the last iteration v3, and the review
>> comments on the iteration haven't been acted upon yet.
>>=20
>> That was why I threw the topic in "needs review" bucket.  The later
>> half of the series got no comments (I lost steam after reviewing the
>> earlier half) and I suspect they would have be adjusted for fixes
>> and improvements done to polish the earlier parts, so I am not sure
>> where your "ready for 'next'" comes from.
>>=20
>> Thanks.
>
> Sorry, I am short on time to work on this these days, but I=E2=80=99m s=
till
> planning to apply Junio=E2=80=99s latest suggestions.  So I agree with =
you, this
> is not yet ready for `next'.

Thanks for a status update.  Be well and happy hacking ;-)

