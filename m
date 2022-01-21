Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17EC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 21:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiAUVAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 16:00:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61031 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiAUVAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 16:00:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB534184E9E;
        Fri, 21 Jan 2022 16:00:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IPnMpWLuH95X
        5c/prjBhQQeMEtavkmhlzUQQz9uZihs=; b=OH57PI5vVVgrmn/PHiL18smnNpWg
        ArkxX3CatGpEyOJmUNB53HB7B0pkQvF8CJ66AzdJZ4SyWQplNVwgs2STIjnhJuXh
        s00mEqTKBpREwqJmIuXVuCdCMnoZmz/5wFFj+KORMM4fB7jbnHBI2WOXEHr6EW4L
        PqhLrdouMpJgDuE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3CE7184E9B;
        Fri, 21 Jan 2022 16:00:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 09D58184E84;
        Fri, 21 Jan 2022 15:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <xmqqh7a0r87q.fsf@gitster.g>
        <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
        <xmqqlezboakd.fsf@gitster.g>
        <c6ab4408-1091-4d14-849e-afe5f3053e8b@web.de>
        <xmqqiluejmcp.fsf@gitster.g>
        <f6cc8042-a455-6398-9f91-0e64921252e4@web.de>
Date:   Fri, 21 Jan 2022 12:59:57 -0800
In-Reply-To: <f6cc8042-a455-6398-9f91-0e64921252e4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 21 Jan 2022 10:42:58 +0100")
Message-ID: <xmqqmtjog5yq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 180E6356-7AFD-11EC-A75E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The idea was to document the base behavior at the top and the effects o=
f
> flags at the bottom.  Blurring this distinction and cross-referencing
> gives a better whole, though, I agree.  It would have helped me find th=
e
> right place to put the list of special chars, for one thing.  So how
> about this?
>
> --- >8 ---
> Subject: [PATCH v2] parse-options: document bracketing of argh
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  parse-options.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7..2e801b3c9a 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -85,6 +85,11 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct=
 parse_opt_ctx_t *ctx,
>   *   token to explain the kind of argument this option wants. Does not
>   *   begin in capital letter, and does not end with a full stop.
>   *   Should be wrapped by N_() for translation.
> + *   Is enclosed in brackets when printed, unless PARSE_OPT_LITERAL_AR=
GHELP
> + *   is set in `flags` or it contains any of the following characters:=
 ()<>[]|
> + *   E.g. "name" is shown as "<name>" to indicate that a name value
> + *   needs to be supplied, not the literal string "name", but
> + *   "<start>,<end>" and "(this|that)" are printed verbatim.

Since "does not begin", "does not end", "should be wrapped" are
about how it appears in the initializer of the struct option, I had
to read twice before realizing that "Is enclosed" is *not* about
what the developer has to do.

Making it clear that this is not part of "enumeration of sentences,
which omit the same subject, that describe how the value appears in
the source", e.g.

	When "git cmd -h" shows it, `argh` is enclosed in
	<brackets>, unless ...

would have avoided the confusion.

Other than that, I think this version is the clearest and easiest to
understand among the options in this thread we have seen so far.

Thanks.


>   *
>   * `help`::
>   *   the short help associated to what the option does.
> @@ -105,9 +110,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struc=
t parse_opt_ctx_t *ctx,
>   *				not last it will require an argument.
>   *				Should not be used with PARSE_OPT_OPTARG.
>   *   PARSE_OPT_NODASH: this option doesn't start with a dash.
> - *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed i=
n brackets
> - *				(i.e. '<argh>') in the help message.
> - *				Useful for options with multiple parameters.
> + *   PARSE_OPT_LITERAL_ARGHELP: says that `argh` shouldn't be enclosed=
 in
> + *				brackets (see `argh` description above).
>   *   PARSE_OPT_NOCOMPLETE: by default all visible options are completa=
ble
>   *			   by git-completion.bash. This option suppresses that.
>   *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
> --
> 2.34.1
