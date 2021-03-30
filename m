Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0797C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A006E619C0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhC3ROx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:14:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63584 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhC3RO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:14:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 636C4118EEA;
        Tue, 30 Mar 2021 13:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cboXQd/9+KcUtGnBcQ+gSy3loCY=; b=kWldw8
        eXHwQWGskiNQBx6HCIF+PJibdR1pxHohn85PAbGjDajBS+kPsC1PWUKJjMoEm0ld
        0f27kXxbJrpULYd68xbDdllIYTS+7eMp613nVXDsm+9W5F1nfnDkl3ZSb+y6oulo
        39/MWjQKtxMlLCgrgEmU5Gx1+Sh6ZT3wqB9rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QCdvKZaVAFP5yEGZ+que/msIhVQYE2VL
        bxioiBlf0xjaozfrE54LCYnL6bSdFEnWGR5Zhix6ViZsnwRGMMMzfpdw9vruMjTK
        hm8MDXh9XSzVK+IC79yq9v9eI3VSizExFNvVvuHxJ2V7iRloThqE8kaQ8CNxq0Po
        hCGamtQeqtA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CF2C118EE9;
        Tue, 30 Mar 2021 13:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DCAD118EE8;
        Tue, 30 Mar 2021 13:14:24 -0400 (EDT)
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
Date:   Tue, 30 Mar 2021 10:14:22 -0700
In-Reply-To: <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 30 Mar 2021 23:07:19 +0800")
Message-ID: <xmqqwntoef81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60341642-917B-11EB-AFB7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> The `prepare_shell_cmd()` in "run-command.c" seem to use "$@" to pass
> shell args.

Yes. "$@" is a way to write "$1" "$2" "$3"...
Since you are passing only one, 

	echo "$@"

and

	echo "$1"

would be the equivalent.

I am not sure what program you fed to the gdb (and remote debugging
over e-mail is not my forte ;-), but let's see.

> Before exec:
>
> (gdb) print argv.v[1]
> $22 = 0x5555558edfd0 "/bin/sh"
> (gdb) print argv.v[2]
> $23 = 0x5555558f4c80 "-c"
> (gdb) print argv.v[3]
> $24 = 0x5555558ed4b0 "echo \"123\" \"$@\""
> (gdb) print argv.v[4]
> $25 = 0x5555558f5980 "echo \"123\""
> (gdb) print argv.v[5]
> $26 = 0x5555558edab0 "abc"
> (gdb) print argv.v[6]
> $27 = 0x0
>
> Some unexpected things happened here.
> Maybe "abc" was wrongly used as the parameter of "echo"?
> Looking forward to your reply.

Observe

	$ sh -c '
		echo "\$0 == $0"
		count=0
		for arg in "$@"
		do
			count=$(( $count + 1 ))
			echo "\$$count == $arg"
		done
	' 0 1 2
	$0 == 0
	$1 == 1
	$2 == 2

i.e. the first arg after

	argv[1] = "/bin/sh"
        argv[2] = "-c"
	argv[3] = "script"

is used to give the script the name of the program ($0).  Are we
getting hit by this common confusion?

It is customery to write such an invocation with '-' as the "name of
the program" thing, so that ordinary positional parameters are
available starting at $1, not $0, like so:

	sh -c 'script' - arg1 arg2 ...
