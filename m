Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E521C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 01:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhLGBfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 20:35:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53293 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbhLGBdG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 20:33:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0424F104665;
        Mon,  6 Dec 2021 20:29:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AonP520B9aDF
        cF5Q+s+XQGBW5J6rCfhUQNK0h3y32X4=; b=CP3+PeMUHE+kIqyKL3IWXTG3yAoR
        gCK6DpjjtqJ912MWeuTNck5PQKFZWOW1j5c4k6qkD/KZOXTAGx+hQ4hEcyu6iUkt
        BsjZZatJB21M3T4w/4eQIL4obHY808zmS4K436krG9V8jBWF4IUlmMxNEnqa6Pye
        t6YLLOkuL92BvRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFCBC104664;
        Mon,  6 Dec 2021 20:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6578D104663;
        Mon,  6 Dec 2021 20:29:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     "Elijah Newren" <newren@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        "Aleen via GitGitGadget" <gitgitgadget@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
References: <xmqqzgpm2xrd.fsf@gitster.g>
        <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
        <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
        <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
        <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
        <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
        <211203.86wnklqx05.gmgdl@evledraar.gmail.com>
        <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
        <xmqqilw2i6w1.fsf@gitster.g>
        <6fa17536.18b.17d8e7c7a09.Coremail.pwxu@coremail.cn>
        <xmqqwnkhhck4.fsf@gitster.g>
        <584bbe43.e.17d926d909f.Coremail.pwxu@coremail.cn>
Date:   Mon, 06 Dec 2021 17:29:34 -0800
In-Reply-To: <584bbe43.e.17d926d909f.Coremail.pwxu@coremail.cn> ("Aleen
 =?utf-8?B?5b6Q5rKb5paH?=
        "'s message of "Tue, 7 Dec 2021 09:06:33 +0800 (CST)")
Message-ID: <xmqqa6hdb3sx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22ED85D2-56FD-11EC-AA55-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:

>> It is my understanding that the ONLY reason the patch proposes to
>> add an option other than "skip the step" and "create an empty
>> commit" is to allow an earlier "--empty=3Dskip" on the command line to
>> be overridden by a later "--empty=3Ddie".  If that option does not
>> make the command behave identically to "--empty=3D<anything>" option
>> on the command line, i.e. ERR_EMPTY_COMMIT case, it does not serve
>> the intended purpose of overriding the earlier option to revert the
>> behaviour back to the default.

[jc: do not top-post, as people read from top to bottom]

>     I have doubted that since that the default behaviour is that stoppi=
ng
>     when meeting commit messages lacking a patch and giving control bac=
k
>     to the user, is that necessary to provide duplicated '--empty=3Ddie=
'?
>     Should we just provide '--empty=3D(drop|keep)'?

Adding an option that aborts and trashes the state directory is much
worse than not having a choice other than drop and keep, which is in
turn a bit worse than having a way to countermand an option that was
given earlier on the command line.

If we were to have an option other than drop/keep, as Elijah
suggested, it may make sense to call it "stop" rather than "die" (I
think "ask" is a mistake, as we do not ask anything to the user).

>> By the way, I agree with an earlier comment (I think it was from Dscho=
)
>> that these names should say "${DO_THIS}_ON_EMPTY_COMMIT"; the above
>> without "ON" feels somewhat strange.

This still stands, too.

Thanks.
