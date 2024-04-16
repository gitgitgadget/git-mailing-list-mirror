Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE11272BA
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263200; cv=none; b=s34zuKt5ZW+oxk1OC2X+RvxmkFvjvpLGnyeFycdjS4jT3kv2NPYv8U7MgqW507vmUEQYd5OdJWi2In0EOX4riEa24vJTlB/15Rdb5TyF/iSxBXEmss6gGHHq5ym2up+uQjfQRvOTawcKI97jfd3GQp1ECjqNuZM9Y7WvP5aopOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263200; c=relaxed/simple;
	bh=lSzEPs2g4o6X/dIq09CUewP3IQsVuAXGlfq2+sMXB78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P71/P6ziAHnag28/mcENsw0xtJ/br2avRDsoj8xwCSDTLunRyIpfivDz5ol+a8k+oGPeeEflrmHXQVziQcMCgb3RCvxCy+FhIrS36o7ti12RkQDwageGFNZBPxZu/u6+izCeuFxyNhjWNoZShDCLDQEwv6yklrutnFYbSVZimz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bE9wOMqH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bE9wOMqH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BCB0236FE7;
	Tue, 16 Apr 2024 06:26:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lSzEPs2g4o6X
	/dIq09CUewP3IQsVuAXGlfq2+sMXB78=; b=bE9wOMqHpNE6FmzO6IpEmPP879DH
	qATS0uudCls5G2M1ONJBFRmzucBFJNp47KPsGxf9MCzP6Bhqy62QkxzS1P2oWhlD
	d3/FdwfrDCIN1wChsq3Y0Z6xQOUZB9c19+vk97kpwOFc9dvc0Zvp/t7lQSMXQXcv
	rJE/q6fQ5UIQ//M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B4B1436FE6;
	Tue, 16 Apr 2024 06:26:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 966B536FE5;
	Tue, 16 Apr 2024 06:26:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: response to invalid option
In-Reply-To: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 15 Apr 2024 21:00:28 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Date: Tue, 16 Apr 2024 03:26:33 -0700
Message-ID: <xmqq5xwhhacm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CCBB9D44-FBDB-11EE-A572-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> When the user introduces an invalid option, we respond with the whole
> help text.

The verb "introduces" in the first sentence looked weird to me.

    add -p: require two steps to get help after mistyping an option

    During a "git add -p" session, if the user chooses an option
    that is not offered, the help text for the entire available
    choices is given.

or something, perhaps.

> Instead of displaying the long help description, display a short error
> message indicating the incorrectly introduced option with a note on how
> to get the help text.

When you wanted to 'q'uit but touched the 'w' key that sits next to
it by mistake, you do not need to be told about what any of the
options would do; you may want to be told "the option to quit is
'q', not 'w'", though ;-).

On the other hand, if you are truly lost and do not know what each
of the listed choices mean, you'd type '?' anyway because that is
one of the offered choices.  So the only change needed here is to
make sure that '?' is the only thing that gives the help message,
and all other unrecognised option 'x' are made to say "we do not
know 'x'".

That flow of thought makes sort-of sense, if the choices that are
offered are too numerous (say, around a dozen or more), but with the
current command set, I am not sure if this change is an improvement
(note: I did not say "I do not think that"---I simply am not sure).

If we implemented the UI this way 20 years ago in the first version,
perhaps we would have had happily been using it since, but given
that the way we implemented the UI 20 years ago has been used
happily by our users without much complaint, either way must be just
fine. =20

Is it worth changing it at this point?  Does it improve the end-user
experience in any noticeable way?  I do not think I can answer these
two questions with confident "yes".

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  add-patch.c                |  5 ++++-
>  t/t3701-add-interactive.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index a06dd18985..c77902fec5 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'p') {
>  			rendered_hunk_index =3D -1;
> -		} else {
> +		} else if (s->answer.buf[0] =3D=3D '?') {
>  			const char *p =3D _(help_patch_remainder), *eol =3D p;
> =20
>  			color_fprintf(stdout, s->s.help_color, "%s",
> @@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *=
s,
>  				color_fprintf_ln(stdout, s->s.help_color,
>  						 "%.*s", (int)(eol - p), p);
>  			}
> +		} else {
> +			err(s, _("Unknown option '%s' (use '?' for help)"),
> +			    s->answer.buf);
>  		}
>  	}
> =20
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bc55255b0a..b38fd5388a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -61,6 +61,16 @@ test_expect_success 'setup (initial)' '
>  	echo more >>file &&
>  	echo lines >>file
>  '
> +
> +test_expect_success 'invalid option' '
> +	cat >expect <<-EOF &&
> +	Unknown option ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	EOF
> +	test_write_lines W |
> +	git -c core.filemode=3Dtrue add -p 2>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'status works (initial)' '
>  	git add -i </dev/null >output &&
>  	grep "+1/-0 *+2/-0 file" output
