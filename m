Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA6C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17989610D1
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDATtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:49:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhDATtC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 15:49:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37A01B17E0;
        Thu,  1 Apr 2021 15:49:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AxSW3lykl/4k9quhwRGpfQIg+E8=; b=J28mch
        ExALwstt2eh/bV00cNB9GZZ2GjdfC5BLmXKbg0qonjxSzK2d+TF97o6IGW96k2el
        lfN7iAYZqGyGMZBlGuWADy5hik1Cvb7odJwff3gR2vMOygHgN5/YMuGE45cn8rNX
        IX90eVLffljrHJvkChAr/1mq0t6YYdlTVF55M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nu4UMyvij2TbwZ1GAQAjyxjGvGcAn7Mn
        AD3VbysQi5TO3LBl8dqCVgQfw9qr4nSnwVRTB7Nec9S203GuLgVJ/Vvu9c3iIAkD
        kt2D7tAZxZ84J9k7QA5kucQAn+MOyM7ItYBZF+QK29EDZ/WL7H+VzK7B7LVN/SXz
        6YuONzNJICc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E869B17DF;
        Thu,  1 Apr 2021 15:49:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 983D7B17DD;
        Thu,  1 Apr 2021 15:49:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
        <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
        <xmqqk0psqxqo.fsf@gitster.g>
        <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
        <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
        <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
        <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
        <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
        <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
        <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com>
        <xmqqwntoef81.fsf@gitster.g>
        <CAOLTT8SLX7wVfND9ru8NPx_YhvP2Ed17UcuRdY6Uioj9XSFmwQ@mail.gmail.com>
        <xmqqeefv89tc.fsf@gitster.g> <xmqq7dln89dd.fsf@gitster.g>
        <CAOLTT8SV_ixYWTV-83vY6B6HUTwW1hTWJqamstf=F6tzkJm3aQ@mail.gmail.com>
Date:   Thu, 01 Apr 2021 12:49:00 -0700
In-Reply-To: <CAOLTT8SV_ixYWTV-83vY6B6HUTwW1hTWJqamstf=F6tzkJm3aQ@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 1 Apr 2021 11:56:30 +0800")
Message-ID: <xmqqlfa13hw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E94C86A-9323-11EB-85ED-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> The way to do the same without an extra script on disk is for you to
>> use sh-c yourself.
>>
>>     .cmd = sh -c 'echo 123'
>
> This is indeed a viable solution, But the extra "sh -c" seems to put an
> unnecessary burden on the user.

Nobody forces you to write long script in the configuration file.
In fact, the "find author from history" is so useful that I'd think
people have an alias or a script in ~/bin/ already for their own
interactive use.  E.g.

    $ cat ~/bin/git-who
    #!/bin/sh
    git log -1 --format="%an <%ae>" --author="$1"
    $ cat ~/bin/git-one
    #!/bin/sh
    git show -s --pretty=reference "$1"

and with them:

	trailer.key.cmd = git who

that is internally wrapped into 

	sh -c 'git who "$@"'

and fed "gitster@" as the first parameter when "--trailer=key:gitster@"
is given would work just fine.

> Sometimes I wonder, why not recommend using environment variables
> like $ARG?

I am also fine with that; when we discovered the design flaw of
.command, I think I suggested either would make a viable choice.
The only downside is that it would squat on a good name $ARG and
forbids end-users from using the symbol for other purpose, but as
long as the application is limited in scope, that would be fine.
