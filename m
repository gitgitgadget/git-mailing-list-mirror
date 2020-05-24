Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489AC433DF
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2731520776
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gZ9sQ+iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgEXQQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:16:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbgEXQQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:16:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 345DED8A7B;
        Sun, 24 May 2020 12:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ogwuEfKMISR0
        mMkgN9zEpl+Ka9g=; b=gZ9sQ+iAzBJzMn9OgsIirSQUmEShjLnbJO/POwAOT/jB
        cVkwp7e7+f4BuFlLjmX6jF6+ojHPwnSA7ahcmeowh497FiUh7T9CIJdSNMtEG7m1
        4ZDpwyZPVpCyCinU7Yxz2tIgVtoY/Z+wWyG7jUX38VihVUBQWHRQNnALBTfyS4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QMK8Rq
        uhp8ORjjeohI6FRzT0bUQ0YdgyJ9H91G/IEu12Rr4UGVCrlH6Kc6nLZeImVF+p7A
        4rKNmbfLECQEANBFYLIdfGkhu923ew1JoVkw/1vXzfpEhy2LG3wTKKibnrTVlMED
        9RYGVD7p1LGjKcNfTve1nXjzKxdBgtYZUUsKo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C961D8A7A;
        Sun, 24 May 2020 12:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51B3FD8A79;
        Sun, 24 May 2020 12:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5608: avoid say and use skip_all for consistency
References: <20200521230510.13077-1-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2005221459190.56@tvgsbejvaqbjf.bet>
Date:   Sun, 24 May 2020 09:16:49 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005221459190.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 22 May 2020 15:04:23 +0200 (CEST)")
Message-ID: <xmqqeer9qpe6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9DA49F6-9DD9-11EA-8161-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Carlo,
>
>> Subject : Re: [PATCH] t5608: avoid say and use skip_all for consistenc=
y
>
> It might make quite a bit of sense to add a visual indicator to "say" t=
o
> make it clear that it is not a verb, but a function name. Otherwise
> non-native speakers such as myself (and maybe even native speakers) wil=
l
> stumble over the grammar of this sentence when trying to parse it.
>
> These would work better for me:
>
> 	t5608: avoid `say` and use `skip_all` for consistency
>
> or
>
> 	t5608: avoid say() and use skip_all() for consistency
>
> On Thu, 21 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>> Printing a message directly to stdout could affect TAP processing
>> and is not really needed, as there is a standard way to skip all
>> tests that could be used instead (including a message).
>>
>> While at it, update the message to better reflect the use of
>> booleans and get rid of the prerequisite.
>
> Makes sense. I would have added a sentence to say that _all_ three test
> cases were guarded by the very same prereq, so `skip_all` is just much
> faster and idempotent.
>
> Otherwise, the patch looks good to me.

Thanks, both.  I see a v2 has already been posted, so hopefully that
would be the final version.


