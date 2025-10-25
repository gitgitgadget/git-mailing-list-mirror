Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3322068A
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406925; cv=none; b=X6KY4hZbzfz8NLTdsr6w2GJFhwFTejy8+r0LroaXSXz4Maw6TNXC8xQl+4endmjAoH/Us8usFjUTjVsIKbgGvedvuJuCQlfI6inGNvN+DPPL+xK/JjtFE1NQ2bauzn25FMWLgVDzGCoPsNTV4eFHednWH1MhnXW+PLtGRqo4Ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406925; c=relaxed/simple;
	bh=F8DSrEFR7U0yihN9diVrk5dxXwI2X947cMD5T7Wp9po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YfiEIQiws/RyOyKVHr5foO/eAZc//tBf2dRnJg39nkjwUlcnZc0Fe63Zbmi7V1FDKZtI/bQySguIr2eIuaPdv5Bcmrq88leCjdATLE+pkSkDJF6QTTr559BEHzRNsc5Il5KR1w/amqxf15/PhrLtHizRzDAybQ/QFLaiDxyq4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+gGLBDo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RnKlsnXs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+gGLBDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RnKlsnXs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 37D69EC0093;
	Sat, 25 Oct 2025 11:42:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 25 Oct 2025 11:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761406922;
	 x=1761493322; bh=Kl3o7Kuio8sSWLK1VPrdjuIS3nsHjb2shEyU5KX1DPA=; b=
	E+gGLBDoyoQPbsntlTmmJ6TxoQZP27PrlcGM9s152ySJ5T+oDjRO2T7Sa36Dnjxf
	a9zcvmE9zb+dVZ1zcnTAmmOTea3csK4hZIryn1KUMJgTi5Nm1xNlgeNCmBgLcDp/
	E4QsXK9IkX4HUOH8+K1QdcRVFm07rh6/GUp1ecG+RCUIeAfGnZWCJjQXw41Tn2Q+
	d64EMuW+f9zVrDLDgZRTi6jI+qwdPvt/ABzWwNZxuGB1fB6k4LDL1/AlT2kXhIIO
	4a3HQ7VP36MuEMbPxvcHq6SsIjt1qjz+c6WL9kjG5E3tZQW7VSRmo/Wre1E7PIZO
	aZ+JmODwmKybsBiVu1+KzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761406922; x=
	1761493322; bh=Kl3o7Kuio8sSWLK1VPrdjuIS3nsHjb2shEyU5KX1DPA=; b=R
	nKlsnXsIIJccRKzknsNz6Cj7pDNYYqvKsgeMOkDvxLnRpUZkeBQH5Yczj3X/LeEE
	D/h26kHnzjH6a6RhUx7klK2lBK+Ejd0jEOp32yKWbTXB7G2x15AZ+7Z25tkcz5CN
	8NOG2or6m++V6CUgpPMhxSjGVX//z3/OYT0j1Dmx7rZU8TJubWxOecUgvCx0Rfmu
	eUSnx+3h1GSuDzzO3z+nMeKEbHA2LU9cbI+VLo3nO4roq+6ycVVDpzpGQIvTHOXk
	LdvfDOXV39p0TCP3YnaiDUIYbeJQu0TweU/+AVOKnvmryT4kqfvEvKqWDohxuskc
	TDvn/vGpA0G5Wc+T0qsUg==
X-ME-Sender: <xms:ye_8aNnc0t-kPuJp48SvhTRO41uH-Jq3t6c6Y8p4MoaFJgKZ6QW4Ww>
    <xme:ye_8aAT2EDfd3CL0gFngsRtRbSFaFEKr2_VT2VQj8ZPhjd3_1BHreWKLAVthzHL5b
    oxTmqGK7Ta62whrenwdsBQWca-wXxqnrboZfDZmBcKMRFTLU-G21A>
X-ME-Received: <xmr:ye_8aBBgbic39dqOdxIICWjmQORnm3JIqdsQkSFsfFiSq4cpo2ENLL-biS66-maKgENUaV2FoFlz0cDslIaE7spPMkJmQtIYbkGz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yu_8aHTK10vMYMvr6VKgdDNnLv5I0hVZ6SgekAqQ-g-zwNsxaY58Gg>
    <xmx:yu_8aPrmFtBIEaR_bM2AXvTJtY7pWT4sqcuNunIQIvwH_6gkewDr4A>
    <xmx:yu_8aJx1TvK7c7aP2OSCtXZ8VdIWDR5HUozJQWQXluQZoJetkUwuAA>
    <xmx:yu_8aEJFtcoGQP7ylS3EScoB1gxuWT39nxbn3zZeyH5tVH_EhlJ91w>
    <xmx:yu_8aJ5udot4CaKoi8Nj9bxdDVOKb9YvXHDUNMEbLiGlOwQgGeu-W3Dk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 11:42:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] add-patch: quit without skipping undecided hunks
In-Reply-To: <0985f775-fb01-4de0-99a8-4775b602829a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 25 Oct 2025 07:46:42 +0200")
References: <0985f775-fb01-4de0-99a8-4775b602829a@web.de>
Date: Sat, 25 Oct 2025 08:42:00 -0700
Message-ID: <xmqqv7k3ng3b.fsf@gitster.g>
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

> Option q implies d, i.e., it marks any undecided hunks towards the
> bottom of the hunk array as skipped.  This is unnecessary; later code
> treats undecided and skipped hunks the same: The only functions that
> use UNDECIDED_HUNK and SKIP_HUNK are patch_update_file() itself (but
> not after its big for loop) and its helpers get_first_undecided() and
> display_hunks().
>
> Streamline the handling of option q by quitting immediately.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  add-patch.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

You are really into "add -p" for the past few days, aren't you?

I thought I knew this code fairly well (after all, I wrote the
original version before it got ported to C), and cannot believe an
idiotic mistake like this one remained in the code X-<.

I very much appreciate your careful reading.  Will queue.

>
> diff --git a/add-patch.c b/add-patch.c
> index ae9a20d8f2..a70def1f81 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1601,7 +1601,7 @@ static int patch_update_file(struct add_p_state *s,
>  			} else if (hunk->use == UNDECIDED_HUNK) {
>  				hunk->use = USE_HUNK;
>  			}
> -		} else if (ch == 'd' || ch == 'q') {
> +		} else if (ch == 'd') {
>  			if (file_diff->hunk_nr) {
>  				for (; hunk_index < file_diff->hunk_nr; hunk_index++) {
>  					hunk = file_diff->hunk + hunk_index;
> @@ -1613,10 +1613,9 @@ static int patch_update_file(struct add_p_state *s,
>  			} else if (hunk->use == UNDECIDED_HUNK) {
>  				hunk->use = SKIP_HUNK;
>  			}
> -			if (ch == 'q') {
> -				quit = 1;
> -				break;
> -			}
> +		} else if (ch == 'q') {
> +			quit = 1;
> +			break;
>  		} else if (s->answer.buf[0] == 'K') {
>  			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
>  				hunk_index = dec_mod(hunk_index,
