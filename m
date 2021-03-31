Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42815C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5761029
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhCaSUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:20:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62071 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhCaSUE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:20:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4131122B93;
        Wed, 31 Mar 2021 14:20:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rh9ixweIB5uW1Ct17Jg6APTqDpA=; b=xtqFTe
        I0ZoRjfElfRKXEPnANGF9SjsDOGfpv+GL2px1KvPMmLs5dbPF/3R79PdAXRl4sZv
        v3vxRC1aO60yTNgzrpI5iQMs0U+zLAK5BoX5MJiXhQQEIoWbhaFe3tJg3xhXj/E8
        b1l7DhI3Cw0ldTX7bPY6XP+BsJpbuNuAhLxVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p9kvXtI7NiHbOnIw3cd80EAH4laBw/MI
        mcY822wqynN5x0lNwzzXv1JKcagH9sq7LFQZb7USWEKFxca0q2oprS56DC8GHIIU
        4cPLwuRicEuJ2tVbvYrZSyYk+Va9EiAYtN95aOx6aqCuu5ZD6cYNjRgk/KVjGWod
        7jXp+Q5G9gM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD896122B92;
        Wed, 31 Mar 2021 14:20:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAB70122B89;
        Wed, 31 Mar 2021 14:20:00 -0400 (EDT)
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
Date:   Wed, 31 Mar 2021 11:19:59 -0700
In-Reply-To: <CAOLTT8SLX7wVfND9ru8NPx_YhvP2Ed17UcuRdY6Uioj9XSFmwQ@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 31 Mar 2021 13:14:57 +0800")
Message-ID: <xmqqeefv89tc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4DFF7CE-924D-11EB-8F23-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> The configuration is like this:
> trailer.bug.key=BUG:
> trailer.bug.ifexists=add
> trailer.bug.cmd=echo "123"
>
> And use:
>
> $ git interpret-trailers --trailer="bug:456" --trailer="bug:789"<<-EOF
> EOF
>
> BUG: 123
> BUG: 123 456
> BUG: 123 789

I think that is quite expected.  You said the command to run is
'echo 123', and that is not "pick a directory $D on $PATH where
there is an executable '$D/echo 123' exists, and run that".  It
runs the given command with the shell, and in general that is
what we want for end-user supplied commands specified in the
configuration file [*1*].

So we form a shell command whose beginning is 'echo 123' and tuck
the argument after that command line, so it is understandable that
"echo 123 456" gets executed for "--trailer=bug:456".

I wasn't following the discussion between you and Christian closely
but I recall seeing him saying that the command is executed one
extra time without any arg before it is run for actual --trailer
requests with the value?  I am guessing that is where the first
output "BUG: 123" (without anything else) is coming from.


*1* Imagine .editor set to 'emacs -nw' or 'vim -f'; we do not want
    Git to find a directory on $PATH that has an executable whose
    name is 'emacs -nw' and run that file (i.e. give 'emacs -nw' as
    the first argument to execlp()).  Instead, you'd want to behave
    as if the user typed "emacs -nw", followed by any arguments we
    want to give to it (in .editor's case, the name of the file to
    be edited) properly quoted for the shell.

    And the way we do so is to form a moral equivalent of

	execlp("sh", "-c", "emacs -nw $@", ...);

    and put the arguments at the end where I wrote ... (we actually
    do so with execvp(), but illustrating with execlp() is easier to
    read and write---hence "a moral equivalent of").
