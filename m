Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2293C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCC72072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICudEK6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBR6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:58:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 13:58:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B51AD751EE;
        Tue,  2 Jun 2020 13:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0NP1pTf5bimO
        v4GDbQp4YbeehIM=; b=ICudEK6MBGS8Z1r3cWdSJl79mV/G39aKSq4fJSpMKHw0
        ctI2ABsWcjyXN06n5nOGYhVIz0bJGNHIf9D0WBY8hYTTrr0YbTmV8caypn/r5+oh
        6kcTx4RhrHgrOBJmDhIhNpWoQjWByVnjGnXfRjONczsRQUxRtmUVEa2BiFablI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e8ETTY
        CrmD1hWnMEj0NJwHo4E3dSggle/ya6ndiwyhO1C4RbZXFSyZTwTHdqw5WHr9yVnC
        PUpo1rcZ49eKir3YYPvpYntdZqiwOSFl+npZJtIpqN6uenLP3VH66Snk9TbAiUHd
        C8MUFjqEYyEk9Oy2xUk9SSnQA4HlUYGx/rS9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC02A751ED;
        Tue,  2 Jun 2020 13:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B416751EC;
        Tue,  2 Jun 2020 13:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from shell to C
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
        <20200602163523.7131-1-shouryashukla.oo@gmail.com>
Date:   Tue, 02 Jun 2020 10:58:45 -0700
In-Reply-To: <20200602163523.7131-1-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Tue, 2 Jun 2020 22:05:23 +0530")
Message-ID: <xmqqzh9ls622.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4570176-A4FA-11EA-9C00-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Convert submodule subcommand 'set-branch' to a builtin and call it via
> 'git-submodule.sh'.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Denton Liu <liu.denton@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> Here is the v5 of the subcommand. Thank you Danh for the feedback! I
> apologise for not replying on time. I have taken into account Danh's
> suggestions on the `quiet` option as well as done the fixup Dscho
> suggested (fixed by Junio here:
> https://github.com/gitster/git/commit/77ba62f66ff8e3de54d81c240542edb42=
a2711c7)
>
>  builtin/submodule--helper.c | 44 +++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            | 32 +++------------------------
>  2 files changed, 47 insertions(+), 29 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f50745a03f..a974e17571 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2284,6 +2284,49 @@ static int module_set_url(int argc, const char *=
*argv, const char *prefix)
>  	return 0;
>  }
> =20
> +static int module_set_branch(int argc, const char **argv, const char *=
prefix)
> +{
> +	int opt_default =3D 0, ret;
> +	const char *opt_branch =3D NULL;
> +	const char *path;
> +	char *config_name;
> +
> +	/*
> +	 * We accept the `quiet` option for uniformity across subcommands,
> +	 * though there is nothing to make less verbose in this subcommand.
> +	 */
> +	struct option options[] =3D {
> +		OPT_NOOP_NOARG('q', "quiet"),
> +		OPT_BOOL('d', "default", &opt_default,
> +			N_("set the default tracking branch to master")),
> +		OPT_STRING('b', "branch", &opt_branch, N_("branch"),
> +			N_("set the default tracking branch")),
> ...
> +		OPT_END()
> +	};
> +	const char *const usage[] =3D {
> +		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <pa=
th>"),
> +		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <bra=
nch> <path>"),


I notice that we gained back -d and -b shorthands that was
advertised but not implemented the previous rounds.  It is a bit
curious that we are adding these short-hands that nobody uses,
though. =20

Will queue.  Thanks.
