Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD4C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbhLAWpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:45:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64258 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbhLAWpR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 17:45:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06F1B158240;
        Wed,  1 Dec 2021 17:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HFCl0iP1M+oq
        /6TviD8j+lHcaIlZzY/KZvVpL0qD/w0=; b=h9TAsHQY9ZYcTXTzGeQGAuIwIevb
        jauY/aFzz8l4TbKolE362WNXrwMHjlkfiEZfYFP5Xs1KeAHoeoOk2qmenCUJNENw
        9J/pjijrEzhxrx+J6KSkidQ+JOq6rBVbpbZ41W0ex0No+aIunNqGnuCgGofGxeUt
        bMxw+M1t7+RTqvg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F192715823F;
        Wed,  1 Dec 2021 17:41:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A655115823E;
        Wed,  1 Dec 2021 17:41:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
        <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
        <211201.86pmqgbful.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Dec 2021 14:41:47 -0800
In-Reply-To: <211201.86pmqgbful.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 01 Dec 2021 14:37:47 +0100")
Message-ID: <xmqqa6hkyml0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DE9F5ED6-52F7-11EC-A99E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  add.interactive.useBuiltin::
>> -	[EXPERIMENTAL] Set to `true` to use the experimental built-in
>> -	implementation of the interactive version of linkgit:git-add[1]
>> -	instead of the Perl script version. Is `false` by default.
>> +	Set to `false` to fall back to the original Perl implementation of
>> +	the interactive version of linkgit:git-add[1] instead of the built-i=
n
>> +	version. Is `true` by default.
>
> I think this would be a bit better if we just stole the version you
> added for stash.useBuiltin entirely. I.e. from your 336ad8424cb (stash:
> document stash.useBuiltin, 2019-05-14), with the relevant s/shell
> script/Perl/g etc. replaced.
>
> I.e. that version encouraged users to report any bugs, because we were
> really going to remove it soon, as we then did for rebase.useBuiltin in
> 9bcde4d5314 (rebase: remove transitory rebase.useBuiltin setting & env,
> 2021-03-23).
>
> The wording in the opening paragraph is also a bit more to the point
> there, i.e. calling it "legacy" rather than "original [...]
> implementation".

After reading the description on stash.useBuiltin, I'd agree with
you, except I do not see the distinction between "original" vs
"legacy".  I very much like the way the last paragraph for
"stash.useBuiltin" delivers the right message.

    +If you find some reason to set this option to `false`, other than
    +one-off testing, you should report the behavior difference as a bug =
in
    +Git (see https://git-scm.com/community for details).


>> -	if (use_builtin_add_i =3D=3D 1) {
>> +	if (use_builtin_add_i !=3D 0) {
>
> Style/idiom: This should just be "if (use_builtin_add_i)".
>
> I.e. before we cared about not catching -1 here, but now that it's true
> by default we don't care about the distinction between -1 or 1 anymore,
> we just want it not to be 0 here.

Yes, if we are redoing this step anyway, we should lose the explicit
comparison with zero here.

