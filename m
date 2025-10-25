Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC72E7BC1
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761413012; cv=none; b=sG0hZirzjDj1m+ayw67IGYzQPxHKt0q3owBanhDu4r9AhYj7LIk99usb8NaiFB4ZyBuwaJfZilk0zrEml1uNRvxTnPfnCFkkM7a2CmD4DfkIWZogzBc3vweiDiQZRMSqKlGiMrvEaYS/POfJ8EOlmHBoVvw5V29SKs3IobGMAEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761413012; c=relaxed/simple;
	bh=avI7zfCzlr/AB55R3w+v18jEDRwd3frgNHdZw1+Er/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htOztASVtawlnJVS09kYNoJnKRbHx3g+x6WXf0RzW/SLEpcxYTOET/QVM6hboWLLMnYjW+bUPaz4Vyz01UYu02KVbNv5wMTShq42SP7UJ9Vdx3bwzk0odH+mbklBG6h3uBZv21wFuqzzLuhOUbd5dV+RCnGzfxZ0Y0X3mc4TvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gYRKBO7L; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gYRKBO7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761413007; x=1762017807; i=l.s.r@web.de;
	bh=iCTVwTSBZSsd9PyjQ2VBIH87rV1pagz3L2WNRjaYkRs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gYRKBO7LUjiX6/TRbVvjTCnMhshEFePbzwd+qIzDfR/kJsFqnXRKKDeeR8S0/NlF
	 1vt5dOxcsipsajHQC9luBhyn8BfbUBiZb+NABWM3Bn7DFhaeoEmbj8plYeikFEPab
	 LoJrvW1BGsmzGymDHx7+lOMNVv68cF0Zbchkyf4XRbvv9Yn6I6nG4tbJ7EOW0eo0R
	 qa93yaeEQlFKgMLLXk3js8QfkdAOQn75/lJyWZ6sOAsBL+X1eaLNTJvJz5xMxNEip
	 fCeB1adPxXwRG7rYC8NYAumTl5x8luhS0jWed++Qy+9ckysQAU0iozL7lcz4H/RKr
	 76CZWdXlJaSjwim5cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.30.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ept-1v4kpm0Vq9-007mRo; Sat, 25
 Oct 2025 19:23:27 +0200
Message-ID: <06b8485e-1e64-4c57-be3a-34b1f900c526@web.de>
Date: Sat, 25 Oct 2025 19:23:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] add-patch: quit on EOF
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
 <13529bee-1e02-4c20-9461-6569312bfe4f@web.de> <xmqqfrb7nebp.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfrb7nebp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OHjFeIyAw8ibiMh+3/+hRmlImmy8i8aUA4bZWSv+JLFKQmQmm8i
 PtxuR2xyUzvY7k/4eKnozvtfhsUmeo8pDP9GCYI7hBTb7N4mAaSNDxromMYHk1potETxT+9
 cK790I2VIdnlL9/elZcz51slhAGnPG8K2ewHr8vcY099x3wl3QpC2AMr8sp6mCSvMQLs6a6
 ORc7FpXWfnIW1tdiLQeAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2I55xkFRxq8=;x651/unJEH2JIK33E7x0GbBZ0JJ
 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

On 10/25/25 6:20 PM, Junio C Hamano wrote:
>=20
> I wonder if we want to 'echo" something in this case, though.  If I
> say 'q', whether interactive.singlekey is active or not, I see
>=20
>     (1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? q
>=20
> on the last line before getting the shell prompt back.  With this
> change, I won't see anything after the prompt.  Perhaps it is OK?  I
> dunno.  Perhaps we want to pretend as if 'q' were given instead of
> EOF, like the following?  I dunno.
I'm used to no feedback when writing to a file using cat and finishing
with ctrl-D to signal end-of-file.  So I don't need a q "echoed", and
would actually be slightly surprised.  But that's just me.

Ren=C3=A9

