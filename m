Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA8C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398D164E40
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhBERdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 12:33:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51181 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhBERbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 12:31:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E30771238A3;
        Fri,  5 Feb 2021 14:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9wycNGOlWkMbHj3/pSXDc9Hsy8Q=; b=ii6aXy
        IYyxh5fYX43CSQvCPuDAZ0oOXNI40BPfof2cVttTbrvy7icm8E6Qi7rB6ZWVnHUn
        tyHun9uga0YE3WG/C4tzQTS1nfAa0y7AJHR1+njFOeKNWlfoxCXgPmCQCbh1nXgt
        2RBJ1pWmUiEJHLQqdBkYsKcxSLVbz5frJe0H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pKmeIt/AJQtXVBrs6pu2TI/EWviQe55T
        0QL7Rs3J9DlewZKV4WR8RwoBYqTPhSewepHpstm/iwXBU6ZpBkW2+CKuzAY2FaqQ
        jb/99iDVrw5Fj359jE6z3KDNx8iEBJeX34OybX5wXDW6ookSzVJvZj6Xiy63efkY
        eo67QKWdqJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB2AA1238A1;
        Fri,  5 Feb 2021 14:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B27A123898;
        Fri,  5 Feb 2021 14:13:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
References: <20210129182050.26143-1-charvi077@gmail.com>
        <20210204190507.26487-1-charvi077@gmail.com>
        <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
        <CAPSFM5f0Jk03tWCTerZP1JhcMHG4MXjVSZjPKm2uzQYc+cOwsw@mail.gmail.com>
        <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com>
Date:   Fri, 05 Feb 2021 11:13:13 -0800
In-Reply-To: <CAP8UFD0VpgT=mTydWQRmqo9TFQvdfDiXuA1TcwAqG1BtXXdKxA@mail.gmail.com>
        (Christian Couder's message of "Fri, 5 Feb 2021 19:25:27 +0100")
Message-ID: <xmqqmtwi1g6u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3279EB28-67E6-11EB-A7B9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Feb 5, 2021 at 10:42 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>
>> On Fri, 5 Feb 2021 at 13:00, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
>> > > * changed the flag type from enum todo_item_flags to unsigned
>> > > * Replaced fixup_-* with fixup-* in lib-rebase.sh
>> > > * fixup a small nit in Documentation
>> >
>> > These changes are still worthwhile and can easily be done
>> > incrementally atop what is already in next, I would think.
>>
>> I agree, these fixes are required. So, I am not sure but now to do these
>> fixup shall I send another patch cleaning this patch series(v4) and rebase the
>> patch on the 'next' branch ? Is it the right way ?
>
> Yeah, I think you can send each of the above 3 changes in a different
> patch on top of the 'next' branch. That would create a new 3 patch
> long series, which you should give a new name and not consider v5 of
> the previous patch series.

Correct, except that it shouldn't be on top of the 'next' branch.

Please "git log --first-parent --oneline master..next" to find the
tip of what got merged, and build on top of that instead.  I.e.

    $ git show -s --oneline \
	"origin/next^{/ branch 'cm/rebase-i' into }"
    4f9aa6cec3 Merge branch 'cm/rebase-i' into next
    $ git checkout -b my-follow-up-topic 4f9aa6cec3^2
    ... work work work ...

That is what we mean by "after getting merged to 'next', the topic
gets polished incrementally".

Alternatively, you can have branches from the broken-out repository
handy, e.g.

    $ git remote add brokenout https://github.com/gitster/git

and you'd find the topic as I see it like so:

    $ git fetch brokenout
    $ git log --oneline brokenout/master..brokenout/cm/rebase-i

HTH; thanks.




