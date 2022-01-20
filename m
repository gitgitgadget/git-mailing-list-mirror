Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C828C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 19:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377407AbiATTIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:08:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377408AbiATTIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 14:08:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F85F180079;
        Thu, 20 Jan 2022 14:08:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=qlIgW78uTweW3Q/zVQByWLn7L
        ATDvMEbksRVYXZfkkU=; b=DB6ktDrsqgH5wBCEUWLECaea6X1ROY5RQKalCvQBC
        KNjfAse0gB4qOsu3mjByxb3W81NZ+fwtxcwjlELyTmpjrmsYQD5pfYL5B6uKjrP7
        Chuy3F1QrKK8QoEhmmcpk73DGU/A2ENXCrDUntpqggxD13+e1pxCoTEI5pCdh5gO
        vk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47D4F180078;
        Thu, 20 Jan 2022 14:08:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B199B180077;
        Thu, 20 Jan 2022 14:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        chooglen@google.com
Subject: Re: [PATCH] branch,checkout: fix --track documentation
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1640039978.git.steadmon@google.com>
        <dcba40e2c4001611f837f612cc5ee7890c653aff.1640039978.git.steadmon@google.com>
        <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <55d5327a-9c6c-7fd8-b540-e710259c0694@web.de>
        <220120.864k5ymx55.gmgdl@evledraar.gmail.com>
        <c3c26192-aee9-185a-e559-b8735139e49c@web.de>
Date:   Thu, 20 Jan 2022 11:08:37 -0800
Message-ID: <xmqqk0eui5sa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5FDD9D20-7A24-11EC-AA69-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Document that the accepted variants of the --track option are --track,
> --track=3Ddirect, and --track=3Dinherit.  The equal sign in the latter =
two
> cannot be replaced with whitespace; in general optional arguments need
> to be attached firmly to their option.
>
> Put "direct" consistently before "inherit", if only for the reasons
> that the former is the default, explained first in the documentation,
> and comes before the latter alphabetically.

;-)  I see too many good reasons to modestly say "if only for" ;-)

> -'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname>=
 [<start-point>]
> +'git branch' [--track[=3D(direct|inherit)] | --no-track] [-f] <branchn=
ame> [<start-point>]

Good.

>  -t::
> ---track [inherit|direct]::
> +--track[=3D(direct|inherit)]::

Good.

> @@ -216,11 +216,11 @@ This option is only applicable in non-verbose mod=
e.
>  	upstream when the new branch is checked out.
>  +
>  The exact upstream branch is chosen depending on the optional argument=
:
> -`--track` or `--track direct` means to use the start-point branch itse=
lf as the
> -upstream; `--track inherit` means to copy the upstream configuration o=
f the
> -start-point branch.
> +`-t`, `--track`, or `--track=3Ddirect` means to use the start-point br=
anch
> +itself as the upstream; `--track=3Dinherit` means to copy the upstream
> +configuration of the start-point branch.

When "-x" and "--long-x" both do the same thing, we list both in the
heading but omit "-x" from the text, but in this case I fully agree
with the updated text as "-t" and "--track[=3D...]" work a bit
differently and there is no way to say "we want inherit" with "-t".

> -`--track direct` is the default when the start point is a remote-track=
ing branch.
> +`--track=3Ddirect` is the default when the start point is a remote-tra=
cking branch.

Good.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0c8d8a8827..4ce2a24754 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -638,7 +638,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>  		OPT__VERBOSE(&filter.verbose,
>  			N_("show hash and subject, give twice for upstream branch")),
>  		OPT__QUIET(&quiet, N_("suppress informational messages")),
> -		OPT_CALLBACK_F('t', "track",  &track, N_("mode"),
> +		OPT_CALLBACK_F('t', "track",  &track, "(direct|inherit)",
>  			N_("set branch tracking configuration"),
>  			PARSE_OPT_OPTARG,
>  			parse_opt_tracking_mode),

Good.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6a5dd2a2a2..0bc2e63510 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1549,7 +1549,7 @@ static struct option *add_common_switch_branch_op=
tions(
>  {
>  	struct option options[] =3D {
>  		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at name=
d commit")),
> -		OPT_CALLBACK_F('t', "track",  &opts->track, N_("mode"),
> +		OPT_CALLBACK_F('t', "track",  &opts->track, "(direct|inherit)",
>  			N_("set branch tracking configuration"),
>  			PARSE_OPT_OPTARG,
>  			parse_opt_tracking_mode),

Good.

Thanks.
