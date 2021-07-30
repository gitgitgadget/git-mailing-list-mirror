Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCE0C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0D60F46
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhG3OeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:34:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55858 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhG3OeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 10:34:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83E24140F23;
        Fri, 30 Jul 2021 10:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hBPjAEFk+K7U
        IyOB3qCq64E4GJCqKUH4YDDbeMF7uew=; b=noIkgHLGZNUZVdVVlu5f9k0w9V1g
        80a1r1vmLLdsUm6BgNvTJrecpbQLv1cuc2TCno5C+un2cyCZRFH2zmqxHQThFPxk
        UX3kKabTwNaaTOfTZuwE3bPt7nzUN9fb6umrweQZHGQvMVaBAsWHMwZF1VKkbgcX
        a0PUpKQTqDt0gS8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C714140F22;
        Fri, 30 Jul 2021 10:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6766140F20;
        Fri, 30 Jul 2021 10:34:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     git <git@vger.kernel.org>
Subject: Re: Should "git apply"'s option "--3way" imply "--index" in option
 description?
References: <a9c2851af11011ebb8e40024e87935e7@oschina.cn>
Date:   Fri, 30 Jul 2021 07:34:07 -0700
In-Reply-To: <a9c2851af11011ebb8e40024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Fri, 30 Jul 2021 16:32:21 +0800")
Message-ID: <xmqqeebf3m74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33C05F12-F143-11EB-962C-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> like this:
>
> diff --git a/apply.c b/apply.c
> index 44bc31d6eb..0b353af96c 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -5024,7 +5024,7 @@ int apply_parse_options(int argc, const char **ar=
gv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOL(0, "ap=
ply", force_apply,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 N_("also apply the patch (use with --stat/--summary/--check)")=
),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOL('3', "=
3way", &state->threeway,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0N_( "attempt three-way merge, fall back on normal patch if =
that fails")),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0N_( "attempt three-way merge, fall back on normal patch if =
that fails(implies --index)")),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_FILENAME(0,=
 "build-fake-ancestor", &state->fake_ancestor,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 N_("build a temporary index based on embedded index informatio=
n")),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Think twice =
before adding "--nul" synonym to this */

It is not incorrect per-se, but because "--3way" implies "--index"
only when "--cached" is not in effect, it may do more harm than it
helps to mention only just the "--index" half of the story.

If we were to touch that line, I'd just chop off "if that fails" at
the end---the phrase "fall back" already tells readers that it happens
only when the non-fallback action does not work.

Thanks.
