Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2F21F463
	for <e@80x24.org>; Sat, 28 Sep 2019 04:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbfI1EG0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 00:06:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60099 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1EGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 00:06:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A018A32F09;
        Sat, 28 Sep 2019 00:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=DX1SxbsjmN1Dc0HvjlcDqwLYG
        mo=; b=CBHaq7J8GrcWx1Btn502bTMAnCn3roSP//UVFF4Yb7owJIK3+UPicNbF4
        AIpBC3u4VNgjlabKwyD6xXBy/j7hJ4nSe1dQgWDy4EmICrMKhr61ooBt6aNDsUyg
        jS6x/VDBVopZQCvM2MKdVGnBz8Vw2/T6QGresdaW5YCd4cuxAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=CUxfeSQk2C1tIbMaNeO
        3pzNYzVylxsSrUvb8EfYIa2ta8+0Bugfz/DFE/qlXiKIpO63NS7Kj4jObQvBlaSz
        etdhQQTtI6399MT4bfaQQBEKMyq9JErXE2SKHjw9B2YlvsQpF4dEfTLGZR/oHliE
        T5flsrbso2FSktwr1t4VT890=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97F0D32F08;
        Sat, 28 Sep 2019 00:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED49232F02;
        Sat, 28 Sep 2019 00:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/15] t6120-describe: correct test repo history graph in comment
References: <20190919214712.7348-1-szeder.dev@gmail.com>
        <20190919214712.7348-2-szeder.dev@gmail.com>
        <xmqqv9tmskqt.fsf@gitster-ct.c.googlers.com>
        <20190920222920.GE26402@szeder.dev>
Date:   Sat, 28 Sep 2019 13:06:21 +0900
Message-ID: <xmqqzhipjc8y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 55625BE8-E1A5-11E9-BBF8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> Hmm...
>>=20
>> > +#       ,---o----o----o-----.
>> > +#      /   D,R   e           \
>> > +#  o--o-----o-------------o---o----x
>> > +#      \    B            /
>> > +#       `---o----o----o-'
>> > +#                A    c
>>=20
>> What's the first parent of the merge between 'B' and 'c' in this
>> picture and how does the reader figure it out?  What about the same
>> question on the direct parent of 'x'?  Is it generally accepted that
>> a straight line denotes the first ancestry, or something?
>
> I've always thought that the parents are numbered from top to bottom,
> i.e. 'B' is the first parent of the first merge, and the unnamed
> commit at the top is the first parent of the second merge.
>
> Would it help if it were arranged like this:
>
>   o---o-----o----o----o-------o----x
>        \   D,R   e           /
>         \---o-------------o-'
>          \  B            /
>           `-o----o----o-'
>                  A    c
>
> This is basically how 'git log --graph' would show them, except that
> this is horizontal.

Either is fine as long as they come with your "for a merge, earlier
parents are drawn near the top of the page" rule clearly described
near it (without such comment, I do not think either is clear enough).

Thanks.
