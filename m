Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C71F63FF
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526330; cv=none; b=uCQ9uMe0wCOtoH7bQaON/Vd8Z50qkiHTxv+jHakWV7EDc0niZ9XzbQSGAAD2R0s0JVQsaDzEtiNhr5RvB+h42Ppu9JT0JjkAUZoBHah/Bb1vlpBtfQFEDjfZeWBuv0h08grpX2nyY8i4dI0KoSZ9KrycULNOwuuoSqAQJtXK1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526330; c=relaxed/simple;
	bh=MhyQ2OuDxSFl5Jo6x4rA2fW2NDHG96AUUcH2NyTYxoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJIgxUGUmT9kZ0Rt0nMH4PMLNfl0CyAmcNhibiLh6sCu/8Xp2GtvjCwnIFegvoGb+OyhbbS4M2WrbQtfrEhlz5Bzgrgb0GLDx5KcAI7HUf1C6JiVw8Hn4VbaKR4cAz3HTrN3RrJag4fAUKS0bsI/3MVzjZv29bdqDoffXSFJlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cpe46xaP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iq8hYRzg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cpe46xaP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iq8hYRzg"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D12C21400215;
	Fri,  3 Oct 2025 17:18:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 03 Oct 2025 17:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759526327;
	 x=1759612727; bh=HHe90f2AkxiT8XqcXTw0gcLGGaFJpIw9Dq6z/bM/CJ8=; b=
	cpe46xaPxrCQ8wP2/0idx3nnyeEUHTndEUFG5WCZA8+q39Ac39yWbgExIl0jWK2T
	kKqsV/2SbIMhzosl/IGgab9mXdIf+8ygZhgZzVb/FcZiJI5a5T8UIkC8QM2yNGAJ
	E5jCOiWYWBbe7+Qe7UeuSmOBjII5OhS/+dPXdBkexTVav8u/xYAsVG1VL7rgt2hl
	ViwpS7YuW7FbDJ103vccMWULpQUpQjpfD8u3bUCYI2n2UmA8lJTGsimNgRZZbNf+
	Yb1NXL+AJzgi6nL+TUSWv0GOYGuPOJ5OllCU1QkG3tyqbCcN9Jupt6VeS4Q7PLSC
	Hvmj7AM7BJVuYo4St1k7vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759526327; x=
	1759612727; bh=HHe90f2AkxiT8XqcXTw0gcLGGaFJpIw9Dq6z/bM/CJ8=; b=i
	q8hYRzgz4yJAkUrgHLkQfpAOCQaZKwPoPnHjOX5Qp1Rb5r+mQPuSKzwXZUKEyLzv
	aOvxKFCnuV6iwlpRqwTYcJ5R+Mgg9voivFUNttyEpJ2TzS+0sNCxxyibwjYmtKeu
	kRQDVAZxhRnGxbjTpq1eX6UKXksHy14xFj8TEKdM+IgZOD8f2g3ZIeiezLwpqqTi
	L9r1m9e1rQlVUUnXNHIxENs5hBx9MeBlIS+AxSV3HutgSGc0cL0HuGpCY427h8wV
	08btrBVAQRBZ/b/rmCQKW98jFp+idEvw42jZRkyCnMm1w8LAbfztgDq6OTnDnT51
	Wz+ZXElI9VNh9Q/DaZFBA==
X-ME-Sender: <xms:tz3gaKXMU2BVwjIiF83csylk0132BokWMTNXzeS7iXtUqbDjT66J3g>
    <xme:tz3gaNkg1W7ME1fpV6aWaxwehIT1wuLDjaOnhGzm20aNzjQOMvY8kquSEV0cmqqbP
    7oo7OZQFdugq1xRCfBzqD-LePki5mUrex-lSaVZ5cg88gKAohVJlg>
X-ME-Received: <xmr:tz3gaDYAOJCHGE9BremAeW5pYd-7HMtoMH_l8KpCbBmo6RGeIGT-BSi3tLCNyEn_Y4f5tlgkDOv_0H09VAy2W_BXEC1Wwi9tVeu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepuh
    drfihinhgulhesuhhkrhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tz3gaAOp8JatX3-eHA1rWZeAb9d8wEQFCqP096TbCTmpWtg4dk_VnA>
    <xmx:tz3gaAbeVZJO45ubbD6DJQQ2CSbwqHut4gpNeSsk_inSumKLFvmWaQ>
    <xmx:tz3gaG06J6SnXPut-qJawXon2xl1h39T5bER8IHHxrb2O_1Eh7zkZg>
    <xmx:tz3gaOfhmA3Zkuv3zaCwIeQ6O9mRwx8fEILEcXV-KSOBYfRnMIDXCQ>
    <xmx:tz3gaI2NROmKkaJZOmTyWbUbMafgprAnbcFKamuzKpte5vOfwQCvbF3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 17:18:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
In-Reply-To: <76665b6f-cb92-4694-bc89-5eb21197df34@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 3 Oct 2025 14:16:44 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
Date: Fri, 03 Oct 2025 14:18:45 -0700
Message-ID: <xmqq1pnju1je.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> git add --patch presents diff hunks one after the other, asking whether
> to add them.  If we mark some as undecided, e.g. with J, then it will
> start over after reaching the last hunk.  It always starts over at the
> very first hunk, though, even if we already decided on it.  Skip
> decided hunks when rolling over instead.

Wait a bit.  With 'J', the user wants to walk the list of hunks,
both decided and undecided ones, no?  So ...

> diff --git a/add-patch.c b/add-patch.c
> index b0389c5d5b..42a8394c92 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state *s,
>  	render_diff_header(s, file_diff, colored, &s->buf);
>  	fputs(s->buf.buf, stdout);
>  	for (;;) {
> -		if (hunk_index >= file_diff->hunk_nr)
> +		if (hunk_index >= file_diff->hunk_nr) {
>  			hunk_index = 0;
> +			for (i = 0; i < file_diff->hunk_nr; i++) {
> +				if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
> +					hunk_index = i;
> +					break;
> +				}
> +			}
> +		}

... why is it a good idea to skip decided ones?

With 'j', the story is probably different, but I didn't dig deep
enough.

With 'K', we seem to do

		} else if (s->answer.buf[0] == 'K') {
			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
				hunk_index--;
			else
				err(s, _("No previous hunk"));

and there is *no* guard around here to say "hey, hunk_index has gone
negative, so we must move back to the last hunk", similar to what is
happening here that does "hunk_index has gone beyond the end, so
let's wrap around to the first one".

This is another bug that is maked by the fact that hunk_index is
measured in size_t (even though there is no reason to do so).  Using
unsigned hunk_ix is simply crazy here, especially for a code that
wants "just do hunk_index++ and adjust if it goes beyond the end"
and similarly "just do hunk_index-- and adjust if it goes beyond the
beginning".

In any case, as the result, going back with 'K' when we are on the
first hunk is broken with the current code because we'd stay there,
and with this patch, we'd move to the first undecided hunk.  Neither
is correct---we should move to the last hunk, I would think.

