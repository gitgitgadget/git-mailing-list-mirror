Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61312DCF44
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010699; cv=none; b=uJFw1KD9GZCmf65oz9nDt2WrDF10cbsZ6v55R2BcvLYNPBlhbMEYq37hKRm1HdEUNOrsOxEwBc+7tKofDU0lPfJ+XxURnLlIdvRQ0HyB7HHFwrM0oCDxYK0VJiCj27DN2gN3L9SlxvX5Wxv6ZQG4Q65dM6iK1SpEpmFy+VnOfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010699; c=relaxed/simple;
	bh=Xr1ayWABkl9JwzDN421wZqB+UDg+Efpzf5qtQOYa5IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdPe4Esmt71XFpNA1ztFsRPqspBxu6kBYUp6Q7BXZhJpLyJaD3WSh0s05tmbpvBZ4rmNJlRQYhqyq00h6Aa0HNdsjwE17HuiiVNtMEakcTdN1XHb7KOfkXf5IPXNcG77ZbipxWtyRB7W0lmuLumit4v8rurNWTawFJMDfhpwGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Q1CgUzj6; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Q1CgUzj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755010695; x=1755615495; i=l.s.r@web.de;
	bh=acDkx+rDKKBVbIkwIFTojq0QGxQA2pLUFzJer2JpxMM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q1CgUzj67MBPTopoSBpX+HX/aEpNVhvyG7YyAigK09cYOHa0PtoBzebSjxJXn3Fu
	 31Uey7Tf9NfGayNreDhEmeU/wRLvqLvTeBIpWCO/QMXHGmSQJb2x5N30D8Z6jClws
	 sYHw7+telCpB0VNKPoUfWCZ42LcQ1NojFEPhKlh9/A6uvyshOEHz6Z/Kr8BW//hC7
	 8OXe+nJvltmW3FSLGtUgeD0FD2MKFLkzmoDE8HxVtvbLDn9b0D/vNsG5st2CeyvhC
	 xsLXUIJx49xHohjTYJLtQ8bu20vsHkD2sNQHVP/rpno+ktVB9WKLojb6Tz0jpph9x
	 FvTfJK4/L5o4jYOcgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1uaxPq4104-00r6Xd; Tue, 12
 Aug 2025 16:58:14 +0200
Message-ID: <9ae4a718-b00d-4435-8739-cf87b2c9df7d@web.de>
Date: Tue, 12 Aug 2025 16:58:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] abbrev: allow extending beyond 20 chars to
 disambiguate
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Jon Forrest <nobozo@gmail.com>, Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g> <xmqqzfc51xvk.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqzfc51xvk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:48uN9/vSotlSyRj7h1ewwROt8d8OIkZXkAoq6A+r2Mp1h/JzW2a
 S+u5mj14NZlwljkR6zoiapDdDTkLsUDAwX2DdzdASoX7AgHNPCyVOuFUG+D+pL88h4gcwmW
 IBcKM0DvIFBlmxuPgO/MSI+XOGCeUlNgEwEBiXvS3OVR1xM8c71n1Kzbm/2GZh1mfJutdUS
 JXepQUmlUKgEjv6UnKGoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0NPJNHz39yw=;ji9LcUzZXDqDjblrgfe3qDrrQv3
 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

On 8/11/25 9:06 PM, Junio C Hamano wrote:
> When you have two or more objects with object names that share more
> than half the length of the hash algorithm in use (e.g. 10 bytes for
> SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
> fails to show disambiguation.
>=20
> To see how many leading letters of a given full object name is
> sufficiently unambiguous, the algorithm starts from a initial
> length, guessed based on the estimated number of objects in the
> repository, and see if another object that shares the prefix, and
> keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
> which is counted as the number of bytes, since 5b20ace6 (sha1_name:
> unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
> change, it extended up to GIT_SHA1_HEXSZ, which was the correct
> limit because the loop is adding one output letter per iteration
> and back then SHA256 was not in the picture.
>=20
> Pass the max length of the hash being in use in the current
> repository down the code path, and use it to compute the code to
> update the abbreviation length required to make it unique.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  object-name.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/object-name.c b/object-name.c
> index 11aa0e6afc..8f9af57c0a 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -680,6 +680,7 @@ static unsigned msb(unsigned long val)
>  struct min_abbrev_data {
>  	unsigned int init_len;
>  	unsigned int cur_len;
> +	unsigned int max_len;
>  	char *hex;
>  	struct repository *repo;
>  	const struct object_id *oid;
> @@ -699,12 +700,12 @@ static inline char get_hex_char_from_oid(const str=
uct object_id *oid,
>  static int extend_abbrev_len(const struct object_id *oid, void *cb_data=
)
>  {
>  	struct min_abbrev_data *mad =3D cb_data;
> -
>  	unsigned int i =3D mad->init_len;
> +
>  	while (mad->hex[i] && mad->hex[i] =3D=3D get_hex_char_from_oid(oid, i)=
)
>  		i++;
> =20
> -	if (i < GIT_MAX_RAWSZ && i >=3D mad->cur_len)
> +	if (mad->cur_len <=3D i && i < mad->max_len)
>  		mad->cur_len =3D i + 1;

This combines two checks: Whether we can increment and whether the new
length is greater than the old one.  Only if both are true we take the
new length.  Shouldn't they be separate, though?  Why reject a new
length that happens to be the maximum?  And max_len is not explicitly
needed for the first check:

	/* One more to disambiguate, if possible. */
	if (mad->hex[i])
		i++;

	/* New record? */
	if (i > mad->cur_len)
		mad->cur_len =3D i;

Ren=C3=A9

