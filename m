Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D8396B9A
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524182; cv=none; b=OyETfy84F7Vy7dnBw3h95RLoG6mq/El3QcIBosbkru1hFhInIf6c8NHKQvX0Ru3xSSQkXJM/nzzJhdIZUKxG09rX/SYy+gnnEoeAzro/g9SaIyNmD8J5T3GMGroIDgCyWcIrXvqevCYHB6mzgcgJJgJA5yQN+h7G7q3YEuTQc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524182; c=relaxed/simple;
	bh=RwmjG7Q+Awp25UnomIILHpyvtFSQVPMFmOfL5SCJWtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q1GJ3muHk8mr4NWdOZ/RXR5vjRi6L1Z+lCOGwAZ5uOvu9hHv90xMyrTDRSfUxCP3Mj1TyR9rB1nPYfnqXyfJhirB/8JWn489BQtwUnCKXYTNQTQ+AGf90qrXzmiBrutmKZNjqR/eiM+WU2SCZJ0kSZ1xpoyywAkC6JfTtGFNTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LfKJc7jc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qEGjM778; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LfKJc7jc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qEGjM778"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 811EE1D00043;
	Mon, 20 Jul 2026 01:09:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 20 Jul 2026 01:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784524180; x=1784610580; bh=jiNoJrI7ff
	uq4QA/9+RS9FTe1leKtEUNC0wQzd5Bpss=; b=LfKJc7jcqbpgSVAz+IUWrfHjHD
	h6+KeWLG0Ronjg7/vd6K2B9pRY2JdYp2LxGF711dYVOOjcn2DStcPvzGaJoU/hbZ
	5JRfAm2T5wtq7l7+Xz2BG8PYUPSdCtXRbcbFwM8ST0WJ11wmvVqrMB1UCgVwwx0O
	ofoIZGX2iFxt8iu0MDu11l/rzseClx1i1XeLm4b+4pggw7mey8Bvqa0A5IqhltS7
	koU53Cr9oxQAZ3ICOwE4McmCQ4OUTuA/vIWH3Q1h150qHeIqXQMauPDZurlJu3+l
	czAZpZamgZ8p28E0k+LIMf7WWoNIQycK9pt/H++DXESMCbgX3qBEhvdLx+IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784524180; x=1784610580; bh=jiNoJrI7ffuq4QA/9+RS9FTe1leKtEUNC0w
	Qzd5Bpss=; b=qEGjM778uZuHk24bauYkaaZLk+yk+0vcOw379skVKiPzeMFbmjS
	2PwQvevzWRd6LYHXbQcoHF+GLZbt0+MwWbD6oUqCAAzf7JOaQEXIcVawM7aKMuRD
	XqkrKnso9NT8WJkJUUBfd5TSn/jrIIE+RxcB1dckiZY3GR4diwIuocwk0d/AY6mz
	QNbkoozkDyR5iCQtxZr2OLBcV1GT3hs0yl30EhgQ+i1EskctZoNiiqg7SHa+nJRi
	Xf5nDEJwFF7yS6wuo/lNB8dZwSknB1lLcbORMI2BnmMu7XFUWvVIAPJrGrRbeSYP
	OjWvfiDDQefKNTOGPpclbEdcp9ubkISd++w==
X-ME-Sender: <xms:lK1dautTeCgWZ2R63CvUfoA3lJsc76-wWbh3fYTbklFxcXGk1wOF2w>
    <xme:lK1daqedc-BO8d6o-nldGGtKe5WvRmp7m7WB3YobRzoXG_N32agujA1zVFYvZKnr2
    B7qIFRGRo3hN7WzgYS4yQc6Ec5dHLnvJEf81RglI7JOZZy144U9rA>
X-ME-Received: <xmr:lK1dauw3vAbLZcEH3mnpyfApML_-MPmi7NbgrjKaTjA_nLVa9evoafhkFmnKmOiYddaVbGyhTKLUhfC0qc7-d4HIwkrMn9P9PA>
X-ME-Proxy-Cause: dmFkZTGO/bmvr19MHL6cvyBb6h9I46i1bnRnuLDlhOyuL8EUmGoPMLYYyu7WDKl7ktBnst
    qaAjRw7H52Faq/FjxFS5IRANJgfTmedz5yq6lksztNQiwuxZYBkZTXn/TK+/uQ1qWdak6o
    yKR5qIRBtj8fpeb6LY0YZSncBzXXfd0zdySdSA2JZuoZpaSn22hDv9MY3Np991RmPq+jfs
    vcVOzhm3AnGxszalE2ODfwzerwy5M6OefLikOvDeTvMj8Skk6tILQU+ViMwiHcnUCvN7/R
    4cB7/ZzmPu2r2YvVzeNq/lbhPB0Uq0BRo6Sn9ozJce3laDHzEzYbkfQzsiDhs0Ke6DOmEu
    DhDKvqja92Qej5A1QjNsWYzpigzO1yBis+icE1CIk2L4/9t3J5lWPtOt69VlqdQPBQE/qN
    Jy1UrNOkgRt63PDxoQiPZLpGGhZXnFOlj3lXmCwt0GVNAgNFpkzmCejNo95r/jTyD25EG4
    wocGTlrYHAxNimThtezx8dDBdVlvEb4fV98P2V4p/2OSRQB4bQAHmxFS0ES95KWA2MYu+G
    UYYmy7AUuQ/S3cbVGpoQdfHmEsbrLnaJTQbS8qhPCjHy9RSZIeL6Y+F5X4ykbFBOwxaCBB
    p/r86llblROEPbH7gzf1qixBb+S1E9GD/+tuALYRaY//0mbpZA6h1KfMlulw
X-ME-Proxy: <xmx:lK1daoHlEQc9Ku3FaG3fwu-8E8w5a9H0oSnb_1MPQCxXnVeam7AZ7A>
    <xmx:lK1daqzT_TRqacYxE1puY9I7tdoRBETlcrzkjGcAdNPEUfTiedjXmg>
    <xmx:lK1dahv2ZTWw9wFYpohOeGjvQGsVmkMS7v4190q2vUz3VEUFhF1PbQ>
    <xmx:lK1dav0eVSrUwFewGF2pigc2IlaGD76j_DVHFezc3VAyrJwHCkhKGw>
    <xmx:lK1dasIogsroV3PYlYkI0O_eiakpoabtOq02c8RoT7hMP7lswk4SbtxI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 01:09:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/11] bisect: check strbuf_getline_lf return when
 reading terms
In-Reply-To: <xmqqh5m1qcfh.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Jul 2026 18:17:06 -0700")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com>
	<xmqqh5m1qcfh.fsf@gitster.g>
Date: Sun, 19 Jul 2026 22:09:38 -0700
Message-ID: <xmqqcxwii6wd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> ...
>> diff --git a/builtin/bisect.c b/builtin/bisect.c
>> index 798e28f501..fe66d84382 100644
>> --- a/builtin/bisect.c
>> +++ b/builtin/bisect.c
>> @@ -498,9 +498,15 @@ static int get_terms(struct bisect_terms *terms)
>>  	}
>>  
>>  	free_terms(terms);
>> -	strbuf_getline_lf(&str, fp);
>> +	if (strbuf_getline_lf(&str, fp) == EOF) {
>> +		res = -1;
>> +		goto finish;
>> +	}
>>  	terms->term_bad = strbuf_detach(&str, NULL);
>> -	strbuf_getline_lf(&str, fp);
>> +	if (strbuf_getline_lf(&str, fp) == EOF) {
>> +		res = -1;
>> +		goto finish;
>> +	}
>
> We want to clean-up terms->term_bad when we fail to read the second
> line after reading the first line successfully, no?
>
>>  	terms->term_good = strbuf_detach(&str, NULL);
>>  
>>  finish:

--- >8 ---
Subject: [PATCH] fixup! bisect: check strbuf_getline_lf return when reading
 terms

https://lore.kernel.org/git/xmqqh5m1qcfh.fsf@gitster.g/

This fixes the immediate leak introduced by

https://lore.kernel.org/git/17c382fdf46eada79ce03a7604dd7e0454d8bea4.1784069325.git.gitgitgadget@gmail.com/

but many callers of get_terms() should all be fixed to check for
return value.  If it fails to grab the replacement word for "bad",
both terms->term_bad and terms->term_good are left NULL, since the
function calls free_terms() early.

diff --git a/builtin/bisect.c b/builtin/bisect.c
index fe66d84382..69ab7ea248 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -505,6 +505,7 @@ static int get_terms(struct bisect_terms *terms)
 	terms->term_bad = strbuf_detach(&str, NULL);
 	if (strbuf_getline_lf(&str, fp) == EOF) {
 		res = -1;
+		FREE_AND_NULL(terms->term_bad);
 		goto finish;
 	}
 	terms->term_good = strbuf_detach(&str, NULL);
