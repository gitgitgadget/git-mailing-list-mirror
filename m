Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFACC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A4B64F92
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBEVvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:51:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53405 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhBEVuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 16:50:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D20612483B;
        Fri,  5 Feb 2021 16:49:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UMIbp/ND4PCx
        9fWLoIsKe63DNzs=; b=hDZ20reklRPVfEn60EzK/zAqKtprvidh9ppGnWJip3Sd
        VYC0qnwjnAiJPmmWd/yg346FOV5XxZ7jvZvi+aCpnupkTBzfeyxpdZJ4IFspzcR6
        /bxjIskII/ZXgHMPgfxyUERjOC/jjKsf9nhDDaQzwkHnsM2yaaYiV4vgoVwlBcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e3pujL
        /ogJO0SCn9ekqrT00HluyBxM3ZrJS7NE30ZRoNxd9KyGXBl38a/5pdKlC+T4UeUo
        vq8AgzESZuk0G+Qda9OG6uo88AMvFsXqt48OycCQPw64YCZjWVkgHmERCD4wopOY
        sXFzXtrI0lE3cKMYBMCbirYxCQ7r/J5jdPv/U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0549E12483A;
        Fri,  5 Feb 2021 16:49:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49832124837;
        Fri,  5 Feb 2021 16:49:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH v3 5/6] doc hash-function-transition: move rationale
 upwards
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
        <ee0fa2ec1d0fb4875c6a10af26686d2d5b3cb489.1612549349.git.gitgitgadget@gmail.com>
        <87h7mqckb7.fsf@evledraar.gmail.com>
Date:   Fri, 05 Feb 2021 13:49:21 -0800
In-Reply-To: <87h7mqckb7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 05 Feb 2021 21:48:44 +0100")
Message-ID: <xmqqr1luyyla.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 025012FE-67FC-11EB-B81B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I missed version 2 of this. I don't think it's an improvement to
> completely remove the description of us using sha1collisiondetection by
> default, i.e. effectively revert 5988eb631a3 (doc
> hash-function-transition: clarify what SHAttered means, 2018-03-26)
> ...
> I can see how my comment on v1 could have been read like that. FWIW I
> didn't mean remove the whole thing, but that I don't think it adds much
> value to our description of how we use SHA-1 to go into the level of
> detail of mentioning several researchers by name, there's Wikipedia for
> that.

True.

> I think what we should instead do is have some brief summary of the
> vulnerabilities and how they're impacting git.

I am not sure.

> Maybe I'm barking up the wrong tree here, and what I'm describing shoul=
d
> be in a "man 5 gitsecurity" or something.

I agree with your that it belongs to some other document, but not
here, where the primary thing is to outline how the migration will
go, and the part we are seeing is merely giving a background story.
At this point in time, readers would not have to learn the details
from this document.  People already know that we are not happy with
SHA-1 and is on our way to migrate to SHA-256.

> But anyway, I think it adds a lot of value to somewhere have not just
> what amounts to "sha-1 sucks, see research papers", but to have some
> brief human-readable summary of what the practical impact is on users.

Yeah.  I think Thomas has in [v3 5/6] gives our readers about the
right level of details.  If I were to change anything, I'd do "but
SHA-1 is {+considered+} still weak."

> In 2018 it was true that sha1collisiondetection was mitigating the know=
n
> attack in practice, and that's also true about this new attack[1] (mayb=
e
> there's others I missed ...).
>
> Then there's the fact that we don't *just* rely on SHA-1, but e.g. the
> "don't re-write objects we have already". So as a practical attack on
> someone using git ...
>
> Oh, and the attacks currently all seem to require file formats like JPE=
G
> or PDF for anything practical, i.e. being able to spew in lots of
> arbitrary data into some data segment, as opposed to e.g. creating a
> program that compiles.
>
> None of this is meant as some overall defense of SHA-1, just that most
> of our users aren't security researchers, and will be helped by a
> summary of how this system they're using using SHA-1, and having read
> that it's "broken" or "believed to be weak" translates to a threat to
> them in practice.

All of the above are good thing for somebody to write about, but I
am not sure it fits well in the context of this document.  This is
primarily about how the migration should go, and the target audience
is those of us who are already committed to the plan.  The backstory
on how the plan came about makes a nice introductory reading but it
would not be productive to spend too much bits for the purpose of the
document and its target audience, I would think.

Thanks.
