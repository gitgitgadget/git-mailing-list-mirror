Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EA8C43461
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EB06108B
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhCaS3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:29:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51912 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhCaS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:29:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D95C4B79C4;
        Wed, 31 Mar 2021 14:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZhfqCdYACujNoC5NFaUJfud39U4=; b=Gjd3AW
        eBYoaqD1qE25LHm5kbN1hfG0Lj/YeYweQBuW0gdnXjGSIOGi2W8IE7NLlRyb38jK
        5/Yy55H2Y97s23gX/kYcpbxtbD6BA3kFzz1mbbma8ZNue7j1WVLAinVyIAnh9aIl
        EEkgjc/cCL3Otce1wUS6sbTwwFwpJhIYN42rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dSrx/dXyhilbdG2KGCvI6rfGEQSBoM98
        k4lZLytyt3MPbXmUN+J08BpO2SGVqf8yL7xyjccHs1dRihxV7Ko94QM5/TRjOWHE
        8wDK3VPTzFCvhyFN55SMifM5n77axnhU/1coB1shE0Vnxd76A4qTa2Y43E0uoPax
        ba/T3wUVuQw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0BA7B79C3;
        Wed, 31 Mar 2021 14:29:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D289B79C2;
        Wed, 31 Mar 2021 14:29:35 -0400 (EDT)
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
        <xmqqeefv89tc.fsf@gitster.g>
Date:   Wed, 31 Mar 2021 11:29:34 -0700
In-Reply-To: <xmqqeefv89tc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        31 Mar 2021 11:19:59 -0700")
Message-ID: <xmqq7dln89dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B43C540-924F-11EB-9AF3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ZheNing Hu <adlternative@gmail.com> writes:
>
>> The configuration is like this:
>> trailer.bug.key=BUG:
>> trailer.bug.ifexists=add
>> trailer.bug.cmd=echo "123"
>>
>> And use:
>>
>> $ git interpret-trailers --trailer="bug:456" --trailer="bug:789"<<-EOF
>> EOF
>>
>> BUG: 123
>> BUG: 123 456
>> BUG: 123 789
>
> I think that is quite expected.  You said the command to run is
> 'echo 123', and that is not "pick a directory $D on $PATH where
> there is an executable '$D/echo 123' exists, and run that".  It
> runs the given command with the shell, and in general that is
> what we want for end-user supplied commands specified in the
> configuration file [*1*].
> ...
> *1* Imagine .editor set to 'emacs -nw' or 'vim -f'; we do not want
>     Git to find a directory on $PATH that has an executable whose
>     name is 'emacs -nw' and run that file (i.e. give 'emacs -nw' as
>     the first argument to execlp()).  Instead, you'd want to behave
>     as if the user typed "emacs -nw", followed by any arguments we
>     want to give to it (in .editor's case, the name of the file to
>     be edited) properly quoted for the shell.
>
>     And the way we do so is to form a moral equivalent of
>
> 	execlp("sh", "-c", "emacs -nw \"$@\"", ...);
>
>     and put the arguments at the end where I wrote ... (we actually
>     do so with execvp(), but illustrating with execlp() is easier to
>     read and write---hence "a moral equivalent of").

So, learning from that .editor example, what you can do when you do
not want to take any parameter is to explicitly ignore them.  

Let's take the very basic form first.  Imagine you wrote a little
script and wanted to see three "123", ignoring end-user input after
"--trailer=bug:".

    .cmd = my-script 123

would run 'my-script "$@"'.  What should you write in my-script to
cause that happen?  Here is an example solution:

    #!/bin/sh
    echo 123

Notice that "$1" is completely ignored, even if the machinery that
drives .cmd makes three calls?

	sh -c 'my-script 123 "$@"'
	sh -c 'my-script 123 "$@"' 456
	sh -c 'my-script 123 "$@"' 789

The way to do the same without an extra script on disk is for you to
use sh-c yourself.

    .cmd = sh -c 'echo 123'

And if you do want to use $1, you can do the same.  E.g. if you want
to double them in the output, you'd probably do something like this:

    .cmd = sh -c 'echo "<$1 - $1>"'

You'd need to quote the value appropriately for the config file,
though.
