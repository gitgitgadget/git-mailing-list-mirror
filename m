Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD21A26B
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835286; cv=none; b=QX2ZQ3cFCSQRsFnEjxogiOixvasj7T1zEGI+rVVoh/NSXUsc8VqPmYSQmOGTV9gntyAopj6yHJGq0LbLUVdhibipDxzJhKBU08b2RLAFYtmBxMsOz9jyh+nYjRgEnRpSi9r8lfgHsC1D0HIIBiUhqdIn5/2OXY+N9tNFLJG0K6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835286; c=relaxed/simple;
	bh=DBkFHHQVJmi5wJvUZ5dFqe4zrz0kwJMHD4T8LZIEu20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsPRQ6zWqe5cRv9jFkC7cjnmd2eYrjaqvH3MKar4Ci27uAVJYF1nPS0HlUl5NXDZitomVf7WogoPzMq3HHFLFGC76IKUpHpDwjmnpkArgwiZ3eoz7VQmDgsD2SGtdmtmaQK3AFDmjcKvZ5YUPJcCS0UuR3JiBnRBNxvAb+5RzuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IkmPqER8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbruUf/U; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IkmPqER8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbruUf/U"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEB631402164;
	Tue, 29 Jul 2025 20:28:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 29 Jul 2025 20:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753835282; x=1753921682; bh=/j2TKfuXwL
	gCFTFVEj4H6a8/DgIZeqEFwYBQ8ZXoZGU=; b=IkmPqER8ZWfLnSUrNzNoDNuBkJ
	4873PkIP8Rp8M5UGrTJp1BOPVELET26xAj+m66CxuXGHIZ5eHYhawHlw/MyRx/0f
	W6reFLPRG7JKuyMVc5ttJ1q05aZLojfzN43+3vT0M+4v8mn0uHrejpRCy2oAM/aK
	3P+3a88QQClfsgnApY4XnkexXRSG0gWcMprNOW0NMTbYBJVBmzfpEQ6JosbW9/K5
	nb+AuJFizHkEtYgzcag6L65EJoznlpqQaXlKY4mUdRyOSZACxGRMDWI5gxS1Msc7
	swJyB9WDKed/6M9NA9be/91lrKKiTlPmGVrkagvMu+svP5CknKqKSjk/5KIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753835282; x=1753921682; bh=/j2TKfuXwLgCFTFVEj4H6a8/DgIZeqEFwYB
	Q8ZXoZGU=; b=nbruUf/Unl9/Fx4HWuWAGWJOgodK7+sYY2Rwc2vvTk7x/ppYA0S
	vk1+RQSDfnjku1mCwn+zYI/CFVjoW7Gw0Ryr40PtQ/su9lWqhh9eq6SnQUZCo4GY
	vuQmSDuNmV7x5iVYKISUpvi+R5psslt3KCoLY4lR68rjvisyt+vbnfymW/ijmwzB
	ALIsXlqVpNV+D16sZr46TleSf/F36lWWQ97fq6wBxtPAF5zx7BoAcaw77bBaYpJo
	9cHhNVZYRDSLHVGDqGZZyPv+sgzo+4982m7rL45E4lW2eSebE7N6VWNoYRj2SAha
	7GIEjYmH9MSIFgKmvhTRUtCzmpJbhqrk7fg==
X-ME-Sender: <xms:EmeJaJL_wJBHPaDzoHFI7p5fne6l_yreDgO2JkvEuSpu2aOHunMLFw>
    <xme:EmeJaNlXJYduKQFcViONDSENyfTI4vAqu8trc5PSd7Tt-choVKk7RGjWz_CN7oINu
    41tbCZH-i2pAGQnpg>
X-ME-Received: <xmr:EmeJaCLNzCXA36R6GSTTRj9j0EhLdfb-cbOchj0p9ANLMBg4DhFFju1UwPeWXZcewz43eTR4WDqwrNUV51txWOd1DenA4IO_ZCUTkrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelieeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhihesrghrnhgvshdrshhprggtvgdprhgtphhtthho
    pehmihgthhgrlhesihhstgdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EmeJaK6yTRbkuvgh0sDuaLo8QjWMoJdOsh-4L9LDIQuGn46U67VIKQ>
    <xmx:EmeJaO2GNXn-Wgf3hJDj4qpeSNyNnYdqTS_8cwit4FuNpp2Vmo_Kxg>
    <xmx:EmeJaIfXh6m9JtjPh7nO1ZeZOrpLATzJpBXBfTjMKPcSj0nc1KoKtg>
    <xmx:EmeJaMcSvPuL601rMm6hGMT254WmCG-esC2kXdTuzglbFHGbcCFUdw>
    <xmx:EmeJaNu536sZZ5DhIFx0RyGIx28QAId7dQ4N3-QTuFmIyGLQ3kj7WLH7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 20:28:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  hi@arnes.space,  michal@isc.org,  peff@peff.net
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <20250729081820.34626-1-yldhome2d2@gmail.com> (Lidong Yan's
	message of "Tue, 29 Jul 2025 16:18:20 +0800")
References: <xmqqikjg47qt.fsf@gitster.g>
	<20250729081820.34626-1-yldhome2d2@gmail.com>
Date: Tue, 29 Jul 2025 17:28:00 -0700
Message-ID: <xmqqcy9io73j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Previously, the `-I<regex>` option was inconsistently applied across
> various `git diff` output formats. In some cases, files would appear
> in the `--name-only` output but not in the accompanying `--stat` or
> `-p` outputs, despite the user explicitly requesting to ignore certain
> changes using `-I<regex>`. To provide this consistency, Introduces
> the diffcore_ignore() function in the new diffcore-ignore.c file, which
> removes changes matching `-I<regex>`, and call diffcore_ignore() in
> diffcore_std().
>
> This patch ensures that the behavior of `-I<regex>` is applied
> consistently across multiple diff output formats (`--name-only`,
> `--name-status`, `--stat`, and `-p`). Only `--raw` and `--check` will
> ignore `-I<regex>` and retain the original output.
>
> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> ---
>  Makefile                |   1 +
>  diff.c                  |   2 +
>  diffcore-ignore.c       | 152 ++++++++++++++++++++++++++++++++++++++++
>  diffcore.h              |   1 +
>  t/t4013-diff-various.sh |  57 ++++++++++++++-
>  5 files changed, 211 insertions(+), 2 deletions(-)
>  create mode 100644 diffcore-ignore.c

The enthusiasm is appreciated, but the implementation raises two
questions.

 * This special cases -I<pattern>, but any option that causes us to
   set the .diff_from_contents flag, not just -I<pattern>, can cause
   the raw blob comparison to be potentially different from what the
   blob contents are compared with various "ignore this class of
   changes" criteria.  Shouldn't "git diff -w --name-status" and the
   like get the same treatment?

 * Also, should we internally run diff twice, especially even when
   we are going to show the patch output and are not limited to
   FORMAT_NAME and FORMAT_NAME_STATUS?  Generally, running the real
   diff in any of the diffcore transformatin is a sign of trouble.

Also, the usual way to compose a log message of this project is to

     - Give an observation on how the current system works in the
       present tense (so no need to say "Currently X is Y", or
       "Previously X was Y" to describe the state before your change;
       just "X is Y" is enough), and discuss what you perceive as a
       problem in it.

     - Propose a solution (optional---often, problem description
       trivially leads to an obvious solution in reader's minds).

     - Give commands to somebody editing the codebase to "make it so",
       instead of saying "This commit does X".

in this order.
