Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A5C433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E60261492
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBAWa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:30:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51667 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBAWay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:30:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99789121F0A;
        Mon,  1 Feb 2021 17:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ka+BzeuYNpG5
        EGYOzI+bfWzAPxE=; b=dZZDlIqWdGK1GcE8QotWdwwsin0TkWqb+CkZbG3/vZT8
        iN4pzjxVZF2/Oa3fJuBRtQM5ID/vbwWd5x/OXz2geCg141KBjkxrO+kQUJGQ2uWi
        F4IVSb3ykNl8WaJr24eKKAr8LPXhKPSEEBPJEmn5RucbDtHE4KFR1wMw+iqgFVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VfGcrY
        ZGq1E31yD6cGFlCdsNmE2aQi/jtkK7Fw8gqmbkY7tGhQ1E2n0TtEenuetHsVb3RK
        Z24vW+C4RIwPTWZZfUH5rvFWrCdkVdroBgXFhFHESF7wy0MSGv8QUzYgn/gsnMq1
        HVe7rj7TIqRBq7WYM3P5efFIPnniaWEw5HJrE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91CD2121F09;
        Mon,  1 Feb 2021 17:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA6A1121F06;
        Mon,  1 Feb 2021 17:30:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/6] Makefile: add {program,xdiff,test,git}-objs &
 objects targets
References: <20210128182310.26787-1-avarab@gmail.com>
        <20210201111715.10200-7-avarab@gmail.com>
Date:   Mon, 01 Feb 2021 14:30:05 -0800
In-Reply-To: <20210201111715.10200-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 1 Feb 2021 12:17:15 +0100")
Message-ID: <xmqq1rdzjuaa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 091DB09A-64DD-11EB-A4FF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add targets to compile the various *.o files we declared in commonly
> used *_OBJS variables. This is useful for debugging purposes, to
> e.g. get to the point where we can compile a git.o. See [1] for a
> use-case for this target.
>
> https://lore.kernel.org/git/YBCGtd9if0qtuQxx@coredump.intra.peff.net/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)

If you are not actually depositing files whose names are *-objs,
please mark them as .PHONY: targets.

> diff --git a/Makefile b/Makefile
> index 07763353423..31123639f65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -683,6 +683,7 @@ PROGRAM_OBJS +=3D http-backend.o
>  PROGRAM_OBJS +=3D imap-send.o
>  PROGRAM_OBJS +=3D sh-i18n--envsubst.o
>  PROGRAM_OBJS +=3D shell.o
> +program-objs: $(PROGRAM_OBJS)
> =20
>  # Binary suffix, set to .exe for Windows builds
>  X =3D
> @@ -2383,13 +2384,16 @@ XDIFF_OBJS +=3D xdiff/xmerge.o
>  XDIFF_OBJS +=3D xdiff/xpatience.o
>  XDIFF_OBJS +=3D xdiff/xprepare.o
>  XDIFF_OBJS +=3D xdiff/xutils.o
> +xdiff-objs: $(XDIFF_OBJS)
> =20
>  TEST_OBJS :=3D $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/hel=
per/%,$(TEST_BUILTINS_OBJS))
> +test-objs: $(TEST_OBJS)
> =20
>  GIT_OBJS +=3D $(LIB_OBJS)
>  GIT_OBJS +=3D $(BUILTIN_OBJS)
>  GIT_OBJS +=3D common-main.o
>  GIT_OBJS +=3D git.o
> +git-objs: $(GIT_OBJS)
> =20
>  OBJECTS +=3D $(GIT_OBJS)
>  OBJECTS +=3D $(PROGRAM_OBJS)
> @@ -2399,6 +2403,7 @@ OBJECTS +=3D $(FUZZ_OBJS)
>  ifndef NO_CURL
>  	OBJECTS +=3D http.o http-walker.o remote-curl.o
>  endif
> +objects: $(OBJECTS)
> =20
>  dep_files :=3D $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>  dep_dirs :=3D $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
