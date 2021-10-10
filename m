Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441FC433F5
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0FA610C7
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJJVff (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 17:35:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55503 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhJJVfb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 17:35:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47CF3155186;
        Sun, 10 Oct 2021 17:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7a0hYbBNZNmCIZGDF8PXtT2u9aRjSwg50eG0qv
        86H5s=; b=pCJKWdCvv1OLM4wnKaCn/NF3JLRkfRTKm2qT29Zjt2OSdr5URq13Fi
        DM+WzDjSWMI/UFfPAqgz7TCTNIqstJrvIoN6ps48eNLfZLqvJdR7B8pv4361U2MA
        hCykXRV9CxJU9tnDPFTRUaFE4mgPaw68aMb9SNUyzVu7tOLs3VG/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DE1B155185;
        Sun, 10 Oct 2021 17:33:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 79AEA155183;
        Sun, 10 Oct 2021 17:33:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        tbperrotta@gmail.com, avarab@gmail.com
Subject: Re: [RFC PATCH] Documentation: better document format-patch options
 in send-email
References: <20211007033652.80793-4-tbperrotta@gmail.com>
        <20211009083133.4446-1-carenas@gmail.com>
        <1d6ec04f-6f89-5da6-75a9-3099e2437df5@gmail.com>
        <CAPUEsphrNMPO_KaAmae02-DsxB9m1tBEK_Gnv29_mLQn0j2MkA@mail.gmail.com>
Date:   Sun, 10 Oct 2021 14:33:28 -0700
In-Reply-To: <CAPUEsphrNMPO_KaAmae02-DsxB9m1tBEK_Gnv29_mLQn0j2MkA@mail.gmail.com>
        (Carlo Arenas's message of "Sat, 9 Oct 2021 02:32:42 -0700")
Message-ID: <xmqq1r4sftuf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5D54C68-2A11-11EC-8EA4-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > +If you give a single <commit> and nothing else, it is taken as the
>> > +<since> of the first form.  If you want to format everything from the
>> > +beginning of history up until <commit>, use the `--root` option:
>> > +`git format-patch --root <commit>`.
>>
>> Supposed that we have following commit graph:
>>
>> a --- b --- c --- d --- e --- f (main)
>>              \
>>               --- g --- h --- i (mywork, HEAD)
>>
>> According to your edit, `git format-patch <c>` and `git format-patch
>> --root <i>` are equivalent, right?
>
> I didn't change the definition of --root with my edit, but I guess it
> is still confusing.

The explanation you gave Bagas describes what these two variants,
i.e. "<c> alone" and "--root <c>", mean and how they behave very
clearly.  In fact, the 4-line description is designed to encourage
readers to compare a pair of cases like these, using the same commit
in the middle of the history you get two quite different set of
commits with and without "--root".

You can ask for "--root <i>" to get a-b-c-g-h-i but it is not
a good example as there is no useful contrasting example that does
not use "--root", as "git format-patch i" would be showing an empty
set.

The fact that somebody wanted to compare between "<c>" and "--root
<i>" might be a sign that the 4-line description is still somehow
confusing, but I cannot quite figure out what needs to be improved
in the description to avoid such a confusion (IOW, I fail to see how
the description can lead to such a confusion).

Thanks.


