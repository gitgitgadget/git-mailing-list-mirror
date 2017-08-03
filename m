Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2821F991
	for <e@80x24.org>; Thu,  3 Aug 2017 17:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdHCRot (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 13:44:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbdHCRos (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 13:44:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE65CA4FB9;
        Thu,  3 Aug 2017 13:44:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7zOwQ2H1Zbc4
        5EFphi6F9927G5g=; b=xqkcn39UegDUxW5vfzlxoxz7uzIUTUM2mO86P7ROb+PZ
        fgagurmHv80xtuGX4LsPwJgwZsGQhDkCwpGQaIKwZ6ub6eTUtTJkSQNi7HPBbOXt
        LqvgONAICublV2TTTWXLQBXvMrwlyEsQroocKGjmXaSMdXKYIo3kc6x7RnUC6Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ciSdLL
        JwrZh1tKw8MnHeARUxaDnXMOVdh/VXvqvvgP8TMD4gX2i1VDWjkPUmAbvhKjTH/3
        NEn9xj0fcohyaAu+PM+7Mw2CPTc19HT3b1mvLd1+gEVkDYr8OZIfRgJvmKZ4DAYz
        1LnmcON2TwaxACpQKtlg/L0B0iiOH0NEnLeNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6720A4FB8;
        Thu,  3 Aug 2017 13:44:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B28CA4FB7;
        Thu,  3 Aug 2017 13:44:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/7] builtin.h: take over documentation from api-builtin.txt
References: <cover.1500321657.git.martin.agren@gmail.com>
        <cover.1501701128.git.martin.agren@gmail.com>
        <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
Date:   Thu, 03 Aug 2017 10:44:38 -0700
In-Reply-To: <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 2 Aug 2017 21:40:49
 +0200")
Message-ID: <xmqqpoccpmux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6CE00BA0-7873-11E7-A55A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> diff --git a/builtin.h b/builtin.h
> index 498ac80d0..8d87d06da 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -6,6 +6,86 @@
>  #include "cache.h"
>  #include "commit.h"
> =20
> +/*
> + * builtin API
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * Adding a new built-in
> + * ---------------------
> + *
> + * There are 4 things to do to add a built-in command implementation t=
o
> + * Git:
> + *
> + * . Define the implementation of the built-in command `foo` with
> + *   signature:
> + *
> + *	int cmd_foo(int argc, const char **argv, const char *prefix);
> + *
> + * . Add the external declaration for the function to `builtin.h`.
> + *
> + * . Add the command to the `commands[]` table defined in `git.c`.
> + *   The entry should look like:
> + *
> + *	{ "foo", cmd_foo, <options> },
> + *
> + * where options is the bitwise-or of:
> + *
> + * `RUN_SETUP`:
> + *	If there is not a Git directory to work on, abort.  If there
> + *	is a work tree, chdir to the top of it if the command was
> + *	invoked in a subdirectory.  If there is no work tree, no
> + *	chdir() is done.
> + *
> + * `RUN_SETUP_GENTLY`:
> + *	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
> + *	don't chdir anywhere.
> + *
> + * `USE_PAGER`:
> + *
> + *	If the standard output is connected to a tty, spawn a pager and
> + *	feed our output to it.
> + *
> + * `NEED_WORK_TREE`:
> + *
> + *	Make sure there is a work tree, i.e. the command cannot act
> + *	on bare repositories.
> + *	This only makes sense when `RUN_SETUP` is also set.
> + *
> + * `SUPPORT_SUPER_PREFIX`:
> + *
> + *	The built-in supports `--super-prefix`.
> + *
> + * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.

Not a new problem but it will become much easier to follow if we
moved this item between the "implement cmd_foo()" and "declare
cmd_foo in builtin.h", like so:

 . Define the implementation of the built-in command `foo` with
   signature:

	int cmd_foo(int argc, const char **argv, const char *prefix);

   in a new file `builtin/foo.c`.

 . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.

Alternatively, we may merge these two into one item (i.e. "in a new
file `builtin/foo.c` and add `builtin/foo.o` to ...").

But of course, this patch 1/7 should not do any of the above.  I am
suggesting a possible future clean-up for anybody on the list
listening from sidelines, and you do not have to be the person who
does it.

Thanks.
