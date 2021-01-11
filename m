Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FCEC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5776F22A84
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 19:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390694AbhAKTFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:05:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51879 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390691AbhAKTE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 14:04:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02EAD125E7E;
        Mon, 11 Jan 2021 14:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4EdUFm2BrUsR
        wRKeMjynUg0YifQ=; b=uyCDOjJZNQO0Qw6h6IEBlA23X0J5ppDD6OhHmSdEoaeX
        VXh1bmhGxpqmVHyJ15MnCxZ8a9m4fRFNms5YzFghmdEuxGngMA+wSDpAIQTNKy2u
        nsyZX+W2uFs++mVU0yDmS+4Jm92vEH+otY/Cy+80IaHnvwZzVqqzrlsxC2z4kQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=s3DoZ7
        gpFaaHirC1DySzX9MfVfghg4FxVb0jlvUpOQlpu2Vw84wdHq5rqtLB2XaWPCrWdn
        JXPLg2qIXhRTJh/Z16TaszLYt0THNiXSfkDHAjbgM5LYSE19zQu2Duxukg1NWZS9
        rzQ9BDzleSN+VX/h2Sqzce6TWdn30MR0Owdvs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFEA3125E7D;
        Mon, 11 Jan 2021 14:04:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27684125E79;
        Mon, 11 Jan 2021 14:04:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
        <871reu752k.fsf@evledraar.gmail.com>
        <xmqqk0slg5ph.fsf@gitster.c.googlers.com>
        <X/oosXBJlyt/IrOr@camp.crustytoothpaste.net>
        <xmqq4kjpelza.fsf@gitster.c.googlers.com>
        <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 11:04:11 -0800
In-Reply-To: <X/uvhc5Hpu792qA/@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 11 Jan 2021 01:53:09 +0000")
Message-ID: <xmqqeeir8fdg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB154A18-543F-11EB-AA20-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-01-09 at 23:20:25, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>=20
>> > On 2021-01-09 at 21:28:58, Junio C Hamano wrote:
>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >> > FWIW there was since a re-roll on 2021-01-03, but the discussion =
is
>> >> > sort-of outstanding, so maybe that's intentional...
>> >>=20
>> >> I had an impression that those 4 or 5 patches haven't gained
>> >> concensus that they are good as-is.
>> >
>> > There will be another reroll.  I'm hoping to get to it this weekend.
>>=20
>> Thanks.
>
> Having read =C3=86var's latest comment, I've decided instead to drop th=
is, so
> feel free to do so whenever it's convenient.

That's kind of sad.

I view that this is the kind of topic where perfect easily can
become an enemy of good, as there is by definition no perfection
available to us without breaking existing Git.

I do not know about =C3=86var, but to me, my initial impression while
reading the discussion from sideline was that the goal was to
prevent a mechanical scan of a recent version of .mailmap from
learning that Joe used to use Jane as his/her name, and that was the
reason why I asked to be convinced why encoding for obfuscation was
insufficient.  In the above, I meant "mechanical scan" as something
like "a web search engine crawls and finds a .mailmap---a query for
Joe produces a line with some garbage on it that is not Jane." and a
casual attacker would stop there.

But of course, a casual attacker who knows urlencode or whatever
obfuscation in use can read that "garbage" once he/she knows that
"garbage" is worth attacking (i.e. it is known to be associated to
Joe, the person the attacker is interested in).

If your goal is to make it harder than just urlencode, even though
we all have to accept that scanning "git log --all" for all names
that appear in the history and hashing them all to see what name
hashes to the "garbage" in question, then @sha256:<hash> approach
does make sense as a stopping point.  Perhaps we need to sell this
with a clear definition of what kind of attackes we are protecting
the name data from:

    The attacker is required to obtain sufficient amount of history
    in the project to uncover the obfuscation; a more casual
    attackers will fail to uncover, and we declare that it is better
    than nothing and it is good enough in practice.

or something like that?  I am not sure if I drew the line at the
level you intended to draw in the above, if I think that it is good
enough in practice, or if I agree to a change that is better than
nothing but not good enough in practice, but having such a statement
would help to see where we agree or disagree.

Thanks.
