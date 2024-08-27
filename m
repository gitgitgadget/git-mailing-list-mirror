Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BB4C6E
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724719484; cv=none; b=qxuvs3BrxVls2obdIIrNRk4pwPuPjARxnB0N2tEeY0jeq1OCrzj1uJz6CMs6RizBlZUyu2xxPq63Lvy+lGpGM/SMIhcUsC1SLsh7mW/LZZnR7jLFGldXZfG02bm54i7rCTFv990WjLDO7Rg9S7KA1EuQGIjmUir7lfxPbBwpzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724719484; c=relaxed/simple;
	bh=CiidLOMxKuaHQ2vEFmdIUxODubeK+5ZZHiocWE4+7Mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=osOT35qG8daVMvxBTdF/3amfyjoTVLjQsH+CtGsRwRLgzSQM8oETk7Zj0yTdgWUmGbf4IDrVJArLNvvbOUF7XFWSG0kv0Gx5M5YYud5wtOtU/hrZCB+ls6QV7N3iTensVs8oac/GYWTL+GqTM6dHukldGEJJOeNt/wLKm1NymiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FGl0e+n6; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGl0e+n6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7A3D2E8A1;
	Mon, 26 Aug 2024 20:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CiidLOMxKuaH
	Q2vEFmdIUxODubeK+5ZZHiocWE4+7Mg=; b=FGl0e+n6ejJy132KRt/4/cwI6QNt
	C45GU0xniqTRb/PX7SJ6Z3ofGS6a/mIaHMmLBLgU/FcMxtHhsXNm0DpyuEOUmeNK
	x+mEblepy8VoD6E1NvtECWEeGVqR3qlyDgleFnzT6eIZsNG0giTtjkDhGDlEM+Dd
	9pqE6aMiStECcbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A12962E8A0;
	Mon, 26 Aug 2024 20:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10D032E89F;
	Mon, 26 Aug 2024 20:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] apply: error message in `record_ws_error()`
In-Reply-To: <a8ce6f0d-f0f2-4467-bf16-e7ce78c6ce2d@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 25 Aug 2024 12:19:27 +0200")
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
	<a8ce6f0d-f0f2-4467-bf16-e7ce78c6ce2d@gmail.com>
Date: Mon, 26 Aug 2024 17:44:39 -0700
Message-ID: <xmqqjzg2eqvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8B941F54-640D-11EF-BB19-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> It does not make sense to construct an error message if we're not
> going to use it, especially when the process involves memory
> allocations that need to be freed immediately.
>
> If we know in advance that we won't use the message, not getting it
> slightly reduces the workload and simplifies the code a bit.

Makes sense.

>
> Do it.

No need to say this when the above two paragraphs are clear enough,
like in this patch.

>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  apply.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index e1b4d14dba..e6df8b6ab4 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1642,8 +1642,6 @@ static void record_ws_error(struct apply_state *s=
tate,
>  			    int len,
>  			    int linenr)
>  {
> -	char *err;
> -
>  	if (!result)
>  		return;
> =20
> @@ -1652,11 +1650,12 @@ static void record_ws_error(struct apply_state =
*state,
>  	    state->squelch_whitespace_errors < state->whitespace_error)
>  		return;
> =20
> -	err =3D whitespace_error_string(result);
> -	if (state->apply_verbosity > verbosity_silent)
> +	if (state->apply_verbosity > verbosity_silent) {
> +		char *err =3D whitespace_error_string(result);
>  		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
>  			state->patch_input_file, linenr, err, len, line);
> -	free(err);
> +		free(err);
> +	}
>  }
> =20
>  static void check_whitespace(struct apply_state *state,
