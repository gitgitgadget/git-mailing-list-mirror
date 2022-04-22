Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66756C4321E
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiDVSMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDVSGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB151A66D6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:03:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1244918045A;
        Fri, 22 Apr 2022 14:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tl8D6t4W3Awgkd9HAJEAHLiaSBxFB1hd9N5Qpu
        g/jbc=; b=w9RsDOi00kPfQ4UZUW4YyNGJO56TIGI9LsneKT4cpR7Yv9sL8bc9Zx
        OPWYRCb45+OntpgSREVWyBNWwk3q0XSHW3n1ce3hR+9Nautf3WWKVB18H0YgVhwl
        0CCp/klsKySDhJyz4UjQuC3DWtk1P31/l0m02G6beA1HYmt8DF3I4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 091CA180459;
        Fri, 22 Apr 2022 14:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 882C5180458;
        Fri, 22 Apr 2022 14:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tapasweni Pathak <tapaswenipathak@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
References: <CALOmtcX4+ON7+J7K9X4rSYfWYnkciJdFE=v=Oeb7rUqwRt8_JA@mail.gmail.com>
        <CA+CkUQ8hf5m0GZEwcyqLgxMw1vavYey_R4P7oq8=OXc7iAj6MA@mail.gmail.com>
        <CALOmtcW=2skmUPXpnano=21i38b7sq2MEWQjH5yF2jLacZ8sQw@mail.gmail.com>
        <CA+CkUQ9ZnBXU8E=XKTk95hwM4qtZ1M_nX3LTCr5q5njPG3Es5Q@mail.gmail.com>
        <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
        <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
        <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
        <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
        <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
        <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
        <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
        <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
        <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
        <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
Date:   Fri, 22 Apr 2022 11:03:08 -0700
In-Reply-To: <CALOmtcWTw=bo=AqGBN8z9Hf602Peu9AVngwKUZZsCt0cr8jbDg@mail.gmail.com>
        (Tapasweni Pathak's message of "Fri, 22 Apr 2022 15:58:28 +0530")
Message-ID: <xmqqilr19esj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77E71F10-C266-11EC-A802-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tapasweni Pathak <tapaswenipathak@gmail.com> writes:

>> > > As you can see "contrib/rerere-train.sh" is a 102 line long shell
>> > > script, so converting it to a new `train` command in
>> > > "builtin/rerere.c" seems like a not very difficult and not too big
>> > > task (especially if done the same way as the script). Junio will
>> > > likely be involved in this, as it looks like he is interested in it.
>> >
>> > Can I take it up immediately, if Junio is not working on it?
>> > ++gitster@pobox.com. Hi Junio. Do you suggest otherwise?
>>
>> I don't want to speak for him, but I don't think he is working on it.
>> In fact, as he suggested it for a GSoC, I think he doesn't plan to
>> work on it soon. Also he might not answer often to emails that aren't
>> also sent to the mailing list.

s/answer/see/ actually.  Other than that, everything you said is
correct, Christian ;-)  Mails to this mailbox that is not also going
to the list are usually sent to the spambox.

>> So if you want to work on it, I would suggest starting right away. You
>> can of course send an email on the mailing list to let people know
>> that you want to start working on this and to check if anyone is
>> already working on it or has suggestions about it.

Yes, that is a good advice.

If we were doing 'git rerere train', especially outside GSoC, we
would need to make sure we won't have to redo it later.

A GSoC "easy" version of "git rerere train" would probably write a
loop in C that repeatedly calls get_revision() to enumerate each
merge commit in the given range, and in each iteration, spawns "git
checkout --detach" to update the working tree and the index to that
of its first parent, spawns "git merge" to try merging the other
parent, and when it fails in conflict, updates the index and the
working tree files to match what is recorded in the merge commit,
and spawns "git rerere" to record that resolution.

The thing is, many people on the list are unhappy with the approach
various past GSoc and other tasks took to rewrite scripted Porcelain
commands to C, spawning individual Git command just like the
original scripts did.  These people will be very unhappy with such a
rewrite, I suspect, and would want it see done totally differently.

Now we have ort merge machinery that can be used to implement
in-core merges without touching neither the working tree or the
index, a proper C rewrite of "git rerere train" should work quite
differently from the scripted version, so "easy" version would
likely be discarded and rewritten later.

>> > > Another thing that was discussed recently is that the git-scm.org web
>> > > site could be converted to not use Heroku anymore. If you prefer
>> > > working on this kind of web oriented thing, this could be another
>> > > possibility.
>> >
>> > I have worked a lot on web-based projects, SAAS, IAAS, PAAS, FAAS,
>> > would it be better to share a proposal of comparison of those keeping
>> > git-scm.org in mind, or is it pre-decided where git-scm.org will make
>> > its new home/work?
>> >
>> > This shouldn't take more than 3 working days with no downtimes.
>>
>> Nice that you have some experience in this!

Yup.  This is not in my area of expertise, but it is very worthy
work.  If we can wean ourselves off of Heroku (the only thing we are
doing is to serve a pretty much static website) sooner, it would be
very good.

>> I added Taylor in Cc as he is involved in this and might answer your
>> questions much better than me. Now if you are interested in it, I
>> suggest starting right away and perhaps also sending an email to the
>> mailing list asking your questions and asking for advice there.
>
> Hi Taylor. Great if you can let me know what you want to see
> happening, and if we can discuss tech specifications, you have already
> decided or plan to.
