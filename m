Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54F4C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhL0Xmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:42:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62973 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhL0Xmz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:42:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 563B610E97D;
        Mon, 27 Dec 2021 18:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=I8fG99/gDh/i
        G71WxbvjSD+GmEwxQP7qUjyQzaPlz4Q=; b=IvAV1h/najVySbq6E0sY4C/EJQTN
        iOui5m+OrccFL+5vx9pWSEXDXSRwIcSERAfEfRqjKAt3fu0hVoQCrMjfR9832gSs
        dthOWgKhwhcOgbXm49b2fVncCmu2A2ppJMzWmvdjERNHN2FL5CHcbQ0SS2T53LZl
        SfNIKoTfMVOAhjg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CBE810E97B;
        Mon, 27 Dec 2021 18:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E36310E979;
        Mon, 27 Dec 2021 18:42:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 05/11] i18n: tag.c factorize i18n strings
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <6d89c23a248d1c11db0e92c4f06392272f00c3a2.1640647438.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 15:42:52 -0800
In-Reply-To: <6d89c23a248d1c11db0e92c4f06392272f00c3a2.1640647438.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Mon,
 27 Dec 2021
        23:23:51 +0000")
Message-ID: <xmqqpmphvclf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5D00038-676E-11EC-899F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 6f7cd0e3ef5..a2ab2b15304 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>  		OPT_END()
>  	};
>  	int ret =3D 0;
> +	const char *only_in_list =3D NULL;
> =20
>  	setup_ref_filter_porcelain_msg();
> =20
> @@ -542,13 +543,15 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  		goto cleanup;
>  	}
>  	if (filter.lines !=3D -1)
> -		die(_("-n option is only allowed in list mode"));
> +		only_in_list =3D "-n";
>  	if (filter.with_commit)
> -		die(_("--contains option is only allowed in list mode"));
> +		only_in_list =3D "--contains";
>  	if (filter.no_commit)
> -		die(_("--no-contains option is only allowed in list mode"));
> +		only_in_list =3D "--no-contains";
>  	if (filter.points_at.nr)
> -		die(_("--points-at option is only allowed in list mode"));
> +		only_in_list =3D "--points-at";
> +	if (only_in_list)
> +		die("the '%s' option is only allowed in list mode", only_in_list);
>  	if (filter.reachable_from || filter.unreachable_from)
>  		die(_("--merged and --no-merged options are only allowed in list mod=
e"));
>  	if (cmdmode =3D=3D 'd') {

The original died with the first problematic condition that was
detected, so it was possible to detect a condition and die, and
check a different condition in a way that may segfault when the
first condition was true, because we would have called die() before
making such a risky check for the second condition.  In the above
cascade, however, there is luckily no such dependency, so the above
change is safe.

But it still changes the semantics.  Given "tag -d -n 4 --with master",
we would have complained about "-n", but now we will complain about
the "--contains", no?

We can fix both of the above issues by making these into an if/else
if/ cascade, i.e.

	if (filter.lines !=3D -1)
		only_in_list =3D "-n";
	else if (filter.with_commit)
		only_in_list =3D "--contains";
	...
	if (only_in_list)
		die(_("the '%s' option is only allowed..."), only_in_list);

And I think you forgot to mark the message that was factored out for
translation.


