Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E24AC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiAZXP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:15:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiAZXP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:15:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BA2E16C2CB;
        Wed, 26 Jan 2022 18:15:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZJdcAeL/Jcuk
        as/J3aFG+VS170r1jNz97McNYi0RXoo=; b=dcympFBOuadvW38TucmCP60WXoEQ
        jRb/zdvDZAB4xGS1/gqulsR00wEimW6K7f35tG6HODdusMu38C0ck287h41wTnd1
        uhdct0zwTVunRyCjIqHzW5HblNjPXQcLdBRSPysEOdZbynkt54AaPRjaqzX350kZ
        U/JaC0ffpgcV1FQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03E8C16C2CA;
        Wed, 26 Jan 2022 18:15:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 70F4916C2C9;
        Wed, 26 Jan 2022 18:15:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
        <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
        <xmqqlez2qnfi.fsf@gitster.g>
        <220126.864k5qdx66.gmgdl@evledraar.gmail.com>
Date:   Wed, 26 Jan 2022 15:15:54 -0800
In-Reply-To: <220126.864k5qdx66.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Jan 2022 21:47:10 +0100")
Message-ID: <xmqqczkeozpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9BA6BB2-7EFD-11EC-A1A1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I understood this problem as being one where we do the ref work first,
> which we could start a transaction for, the user then ctrl+c's after th=
e
> ref work is done, but before the working tree is updated.

If the process is killed while the working tree is half updated,
nothing you do with ref transaction will help.

>> I suspect that the untold thinking behind your statement was that we
>> should try not to discourage new users from asking, and I agree with
>> the sentiment to a certain degree.  But at the same time, I think it
>> is simply irresponsible to do so without distinguising between
>> asking for something realistic and unrealistic.
>
> I must admit I'm not deeply familiar with builtin/stash.c in particular=
,

Then you can try to be on the conservative side, perhaps, to avoid
misleading less experienced folks next time?  Thanks.

