Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A58C41604
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2909F206C9
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 22:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8CfCCCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgJCWOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 18:14:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63708 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgJCWOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 18:14:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EEECF49C9;
        Sat,  3 Oct 2020 18:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hFQj0PNymiWM
        5w8Xt8gTF1DdcD4=; b=f8CfCCCqYerQK4QEv1u8ojItxrF9niAPJ9yivvjJLfCB
        eJRxcONRS+n+1mCuKggCkBZ/9HFxTOeL7K0CwJHHt+NVyYA1Qf2zwm8SkhmJwoES
        E/GpsNXOwuVrXTPvJK329RiWDjh3LPaPca6Pl/GwR5GWrjtwcfaSzPKno1y7AWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fK06Ms
        EvR+wZq2sw1pUapwAYwrqlGQkYozYkHStuadS/12CFILafO7pzVIbnOFkx0Yi18m
        6kEK8f4Nb3z7hhpuUO7EpKhaRmsH97gFk7Vi2LHyFVm/TZ7JBQ++SglLZaOHVe6K
        aw71pQcpQhb5+A9pCetBedpvL2Hkt79VzcJro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 151E6F49C7;
        Sat,  3 Oct 2020 18:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 529E2F49C6;
        Sat,  3 Oct 2020 18:14:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Shengfa Lin <shengfa@google.com>, git@vger.kernel.org,
        nathaniel@google.com, rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <xmqqlfgqes95.fsf@gitster.c.googlers.com>
        <xmqqtuved70y.fsf@gitster.c.googlers.com>
        <20201001034350.GB2930867@google.com>
        <20201003195325.GL1392312@camp.crustytoothpaste.net>
Date:   Sat, 03 Oct 2020 15:14:08 -0700
In-Reply-To: <20201003195325.GL1392312@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 3 Oct 2020 19:53:25 +0000")
Message-ID: <xmqq5z7r7ya7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C39E0A9A-05C5-11EB-81AF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'd like to make one suggestion here, and that's that instead of writin=
g
> "+0000" in this case, we write "-0000".  As far as I'm aware, it should
> be parsed equivalently but it mirrors RFC 5322:
>
>   Though "-0000" also indicates Universal Time, it is used to indicate
>   that the time was generated on a system that may be in a local time
>   zone other than Universal Time and that the date-time contains no
>   information about the local time zone.
>
> This is exactly my case.  As you can tell from my emails, I'm not
> physically located in a UTC timezone, but my system is in UTC and uses
> that for timestamps.

What you had in the header of the message I am responding to was:

    Date:   Sat, 3 Oct 2020 19:53:25 +0000

I cannot tell if somebody in the middle rewrote -0000 to +0000, or
your original already said +0000 in your message.

> I use UTC because I know and work with people from
> around the world and it's more convenient to use an objective standard;
> my real time zone is unimportant.

It cuts both ways, and there is a small downside, though.  As I
assume most people are not actively hacking on Git in the early
morning say 01am-04am in their local timezone, I may delay my
response to a message from a contributor if I notice that the day
for that contributor is already over and my message will not be read
for some time even if I rushed it.  "real time zone is unimportant"
may or may not be true.  A responder in such a case is actively
inconvenienced by the zone information being hidden [*1*].

Having said that.

> That's materially different than
> someone who's located in Reykjav=C3=ADk, where we'd want to write +0000=
,
> since they are physically located in a UTC-equivalent timezone.

I agree that it would be a good thing to have a way to say "I am not
telling which zone the timestamp is from", that can be used to
differenciate "This timestamp is in UTC because I am in UTC".


[Footnote]

*1* How much the person feel inconvenienced is very subjective, so
    let's not go into "it's just a small inconvenience---my privacy
    is more valuable" kind of discussion.  The value of privacy is
    subjective in the same way and we shouldn't compare subjective
    things to decide which side must bend their way to accomodate
    the other side.

