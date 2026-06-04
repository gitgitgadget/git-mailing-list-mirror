Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC22D8364
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584359; cv=none; b=Faz2qBRvvoOmGT92nftrYl9FHoo9jo4Py43dU4r3EpZwFVCrHi8vQQN+FDEfjh9s3esMvt/h6pT1XBl1X2L6r3L/cGv7UUAi6yX7wgTP4evL1YNUvZqHlLHUx/4XNw/81Pok3PnRwu0LtzoZhRaVzJNkX5wyC98AzmjkmnvyXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584359; c=relaxed/simple;
	bh=bZXYQuCass1OmTRf5YHQL679rJEUVRmP+HwPfTPstqs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JzwabF4R266Zoyq4RqGCJVAVvLxrSFnXS4YbQfDvL+Q0l3s8oskBEj/ZAtOQ+sjPVT2pEmIbAp4Q58MicdNEo64X1kYz14834o/4a6Wxp5sRlVe81cOExp3Gj3FGTq6hCaxzap4MbZf87THiKGZblgZqj4r6oZf0X3QGPxXpGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Fw5IOg2v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHihwx3m; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Fw5IOg2v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHihwx3m"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FF131D00155;
	Thu,  4 Jun 2026 10:45:56 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 10:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780584356;
	 x=1780670756; bh=vDgA9tsJxQOkM+BeuXRNZgzK8gmM03NQQfsIpsueuKo=; b=
	Fw5IOg2vy6v2sjwdNVT8l/yyy5ZMDvxqzS9b2aeYyM6k8sQY8suZuFYYLel4SM2G
	MwexTFgp/WIPG8hyBZFbxC4yv962UWMU/gNVN+h8/wFMolATmkCpHBerrT9Vl9t5
	K4qLSxwIGZphLqpWqweRfpp9stbRYp66QYl6E5oBs0o+1W+ILgCUTq1vfW4xuzaI
	4wf5LcPOePH3tA5HN7rjt3Pk5HPxoeeUejBDzCrephldFFZR/g49HD7HbTWANYBd
	OcmPbQdePrOfLnCsi7FSheiVDLwK5IsHx0mFSZy2d4aMWHmCFBeVLCfBoqhjrCFw
	2O3+926J94nRKDfjvM/ChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780584356; x=1780670756; bh=v
	DgA9tsJxQOkM+BeuXRNZgzK8gmM03NQQfsIpsueuKo=; b=GHihwx3m5qkLM0CcE
	tDFYdGTTCE/uBFqMYmycT1QwycOOcAcmvBnZkbcr4OyLVSgGERbXbqCzVyWEWctg
	DeK+WARiTFjVG57AOC1xck1Wz5MiX6thDqYjlbPgWlLXtHGAr49slyNpXmaK5G7F
	T1Ie4rmrZ3jGH928bNiXerrz/h3yu617ZzvE7XpBN8+hunhmoecty9hO3cxUe8rf
	ogjUvgBxeHkmhbrlW9koiT0dc70DEm9uZtyO2/y9pA/nUbOZQQ/LDcYI0kBjHXY2
	ZYVy/bhpzwuZiZKgLxZqKzs52YncIY6+maUo46y84iqbVchF2pKlJ+UxwuUxogWy
	VP49w==
X-ME-Sender: <xms:pI8hasTTikNjojhtKrThKagw-gt3Y9N5LA_8QvZwRXxB3Q78SrNjljI>
    <xme:pI8hakkWnYjIt56bxmDSCg_55b6_bNEJxsqyKfZbMIGITEz7_d54kJDOHA3_sJBpY
    OJNaXNN-CYpBn0eJjFOvYHQiwfQDHnIPlpnPpCweeXLjhcyMDdC>
X-ME-Proxy-Cause: dmFkZTGUgCkR9q4m4rR371MFu+0V3oKutnCnBWHfORYI7LwRpZ1SFvNDfmC3Q3GVgRTewf
    0GyKJr9T9Fj4BUAMEbg8WJVSoFL//DdZ8IsyWJUJjS9Obb2h40p1gc+HXwLpqw5tc33wzJ
    kEzZMKz1WhBIzizp/oGggPdqs0zDgwqW1IS+nPxligwu7UkawhYaB8VlHhLkMSB77glhHU
    vMH+vEjFVKGKiB6T+dwfmkqqml0ORFuI7AkKMS6sjFJB22OIbG2CE1rAi6R4RRysz6YmzS
    MqOYuHdxYOH5UClXzeZCgkihpD0W/HDT5LgoNZ8sPTRIIAhC6rUdM4Fz3aa1awgkfBWUEm
    ec4WUHj5vXkQr5uPE3iraNE1dyg0CJdgzxPDtZ7vyyIr+3W6te8aSCsiyj6pQHxQySBZTN
    q38/aIiOmC1I/z+ttSM4eMtbUxVHtzQbzWFnjRG+Msn0RIr6oUZ0592tBVTEYqHIqRINbo
    thuVuAlmmr9LiBojdvebPdN4ZrMjUlbS/GttvuRDHvNo/uXJVWeWycnCp6NAgF/YI+Dkm+
    IL5pDd5guEVCFn/AcHm+Ga9bKjN9lQrFr6Q89m9QC4wLqHHByzJRLMoHHfS3AWJRhTC/lW
    J9m5NgacNhoglz7yJqalPrG7VGB3bcjgwrGfrU2dO/Cic7QwulGHuWsobOTQ
X-ME-Proxy: <xmx:pI8hau-zAay1fGKfEgj8PRGxYkEDsUamKwupzex2R3i7eQCNahhJwg>
    <xmx:pI8hasqfkA5T_XBIf09FpzrcUz96Fb2xcwUSTX4jEAvtPn1dkkSCLg>
    <xmx:pI8harkCIodeEMfyp9__RwZ1uxE2Xqub1U1Yzp0S-hp0p-2tMZ-_2Q>
    <xmx:pI8hajJKEaYtTj7iACXB5fmwFZUCFx-Wt6lIb2CoFwdybU3SiOXgDA>
    <xmx:pI8hapBjuCxlQAyFHkgwII4j3UP0I5Ba90okw7Y1sJXBYAL1XIpAy3-L>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA118302008E; Thu,  4 Jun 2026 10:45:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4zrN4FnEVLN
Date: Thu, 04 Jun 2026 16:45:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tuomas Ahola" <taahol@utu.fi>, git@vger.kernel.org
Message-Id: <92fe3db2-83bd-4aa9-a1f4-bec01dfaf8ca@app.fastmail.com>
In-Reply-To: <20260604131457.19215-1-taahol@utu.fi>
References: <20260604131457.19215-1-taahol@utu.fi>
Subject: Re: [PATCH] docs: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026, at 15:14, Tuomas Ahola wrote:
> [PATCH] docs: fix typos

The area `docs` isn=E2=80=99t correct since you are also changing commen=
ts in
source files.

`*` could be used (as in a wildcard). Other people have used other
things for =E2=80=9Ctreewide=E2=80=9D changes.

> Fix some typos and grammar errors in comments and documentation files.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>
> Notes:
>     Written mostly as an exercise on how to submit patches that depend
>     on other topics.
>
>     $ git log --oneline --first-parent v2.54.0..
>     d19e9182ab (HEAD -> ta/typofixes) docs: fix typos
>     5a7e9cc03d Merge branch 'ta/approxidate-noon-fix'
>     f03649d802 Merge branch 'kh/name-rev-custom-format'
>     023a226b4b Merge branch 'jc/neuter-sideband-fixup'
>
>     As can be seen, these topics have already graduated to master:
>
>     $ git cherry master
>     + d19e9182ab097a722e32d459a9a58c8985831e3b

Okay, so you ran this from your branch and git-cherry(1) only found one
non-merge commit that was not already in `master`. Makes sense.

>
>  Documentation/config/sideband.adoc | 2 +-
>  Documentation/git-format-rev.adoc  | 2 +-
>  date.c                             | 2 +-
>  replay.h                           | 2 +-
>  t/t9902-completion.sh              | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/sideband.adoc
> b/Documentation/config/sideband.adoc
> index 96fade7f5f..ff007aeb73 100644
> --- a/Documentation/config/sideband.adoc
> +++ b/Documentation/config/sideband.adoc
> @@ -13,7 +13,7 @@ sideband.allowControlCharacters::
>  		Allow control sequences that move the cursor. This is
>  		disabled by default.
>  	`erase`::
> -		Allow control sequences that erase charactrs. This is
> +		Allow control sequences that erase characters. This is

Correction is correct.

>  		disabled by default.
>  	`false`::
>  		Mask all control characters other than line feeds and
> diff --git a/Documentation/git-format-rev.adoc
> b/Documentation/git-format-rev.adoc
> index c40d52e9f6..505a52fecc 100644
> --- a/Documentation/git-format-rev.adoc
> +++ b/Documentation/git-format-rev.adoc
> @@ -33,7 +33,7 @@ OPTIONS
>  The argument `rev` is also accepted.
>
>  `text`;; Formats all commit object names found in freeform text. These
> -	must the full object names, i.e. abbreviated hexidecimal object
> +	must be full object names, i.e. abbreviated hexadecimal object

Correct. It should have been =E2=80=9Chexadecimal=E2=80=9D.

This also corrects a bewildering =E2=80=9Cthe=E2=80=9D where =E2=80=9Cbe=
=E2=80=9D should have been.

>  	names will not be interpreted.
>  +
>  Anything that is parsed as an object name but that is not found to be=
 a
> diff --git a/date.c b/date.c
> index 05b78d852f..014065b419 100644
> --- a/date.c
> +++ b/date.c
> @@ -1074,7 +1074,7 @@ void datestamp(struct strbuf *out)
>   *
>   * The tm->tm_mday field has an additional logic of using negative va=
lues
>   * for date adjustments: -2 means yesterday and -3 the day before tha=
t,
> - * and so on.  The idea is to deref such adjustments until we are sure
> + * and so on.  The idea is to defer such adjustments until we are sure

=E2=80=9Cderef=E2=80=9D could have been =E2=80=9Cdereference=E2=80=9D bu=
t this must indeed mean
=E2=80=9Cdefer=E2=80=9D. We are putting off a decision until later.

>   * there's no explicit mday specification in the approxidate string.
>   */
>  static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
> diff --git a/replay.h b/replay.h
> index 0ab74b9805..90ed299ff0 100644
> --- a/replay.h
> +++ b/replay.h
> @@ -19,7 +19,7 @@ struct replay_revisions_options {
>
>  	/*
>  	 * Starting point at which to create the new commits; must be a
> -	 * committish. References pointing at decendants of `onto` will be
> +	 * committish. References pointing at descendants of `onto` will be

Correct.

>  	 * updated to point to the new commits.
>  	 */
>  	const char *onto;
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2f9a597ec7..7c6db76c9d 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2446,7 +2446,7 @@ test_expect_success FUNNYNAMES \
>  	>repeated-quoted/2-file &&
>  	>repeated-quoted/3\"file &&   # ... and here, too.
>
> -	# Still, we shold only list the directory name only once.
> +	# Still, we should list the directory name only once.

Correct, that=E2=80=99s a =E2=80=9Cshold=E2=80=9D typo.

Second time looking it over I see that you also drop the doubled =E2=80=9C=
only=E2=80=9D.

>  	test_path_completion repeated repeated-quoted
>  '
>
>
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> prerequisite-patch-id: f827362e061e199150f149dd36c67664c77406bc
> prerequisite-patch-id: e5b32f0b916ec86eab6631b9bd9bafd639191765
> prerequisite-patch-id: 567a1832a220b2dbf095796cc8093b526d6a076c
> prerequisite-patch-id: aafa4bd4ceb7836a92d28d4c89b57032f74332e9
> prerequisite-patch-id: 2e073762fc9dceafcc6f16711bba425384a24305
> prerequisite-patch-id: 0aa605f0acdb71aa2eb173fdf3c57713c9561fe2
> prerequisite-patch-id: 5163040262c89eed4bcb04228b445d76497c9d58
> prerequisite-patch-id: c06c0461bf75ed638214ce98a54bba6578941c10
> prerequisite-patch-id: 571fdf3570f30fd41f6d681e99acc37df94d09a3
> prerequisite-patch-id: 54e7102e880d24a6b2d22bef9aa90a3078086d4d
> prerequisite-patch-id: d829fff1fcc8b6d086fcb6a40c62f835226ae32f
> prerequisite-patch-id: d1d8e2f2e274565e1d7437aa5ccfe44c3f3d8355
> prerequisite-patch-id: c79ebac6894b9a206f5699e9811e0348e111753d
> prerequisite-patch-id: a7750d7d2ec637d906f975f27ba3d03b33a4a34f
> prerequisite-patch-id: 083f554bc5e09ae54c6b545628196e11a9e90cea

Okay, these must be all the non-merge commits from the topics you
merged in.

> --
> 2.30.2
