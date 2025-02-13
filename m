Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EA70810
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420180; cv=none; b=RfACRANJUt7hDqT/s5YlXX/Mi6Q6pf/e70e8/E3esZIJ/BhLt1lfL0r6Wh1VcmDPBkXgCU6loXpsN8xVFQQ1P1b3ljLgXkCVVAXBvtAHK5611q4NcQauVB3ll5ZRbwXaKj/e6XkICof894Uj0GAXsoN6jibS8woKE1X5ewkDJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420180; c=relaxed/simple;
	bh=Qh23eDEr/BcznLj2nHUAAJxdrsw0rFEM0TFLGdhIors=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MXM8ulZwAUWOs9DRpM+Xq2iYhPVFlAqk9pz1NAavXYpPGoyxysRCQCsbvdI1EuSccB/oWlAWKgfqh92E9D63RIncQpfQwT5tL9Xx4tKSa7uBJaVWOUWd47iLmDhWG4MQ3M4LNq9EnGucJ4j1ADjFAKLgpF/CTOxjg41cHkMxy4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUoelbTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djN4IGQ5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUoelbTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djN4IGQ5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D870A114018D;
	Wed, 12 Feb 2025 23:16:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 23:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739420177; x=1739506577; bh=vOmrvmG8LY
	WMTZF4i7Y7ak7WJBCu4hE+5unSv3atHSA=; b=KUoelbTfhQB0JAGXTXKJdKQ3zG
	1IVMB9d+8Drvc57bNni+nsRGvamigzTyNifw1/2zVFao+Aev4LbDeICni4b4/vbF
	1zLIyg1m2iJTv5ZCT5SShSkWm3AJIpD/GqXHeYF06Qqo63UYcYHTOdVCRRp1EGZM
	zZ1X/V9xl3PXuq7iLZhebjReXqDxvsgYZcgsCWEjhmMUE3oGLgYXiDLgfnDP8BD8
	G9YGApRZCSOSCX8wgm5zlJqCHR+mHHcl+wHVfAIFK9WWrio4GNa+yllxDHt1Qieh
	0AIQGpVKKWr6nGpsYMQU6MZp1r4PUzE0imkw46+CjyIRmgcvhCK0VQqALJhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739420177; x=1739506577; bh=vOmrvmG8LYWMTZF4i7Y7ak7WJBCu4hE+5un
	Sv3atHSA=; b=djN4IGQ5u1DJU4J8aaY4rADTurE+ssv1C7azBCJEZ2cRp6uFr8L
	Sw8r5JslsUflmZyuic3PP5TojqMrTCfr0Pe6UiqeZzL1CSsRebzIdKe0BOD/YKTH
	2HSivuzrAmjZzuldAk246iAq+ogJS1Gd8xYIHC7eNmSzgIfgOPqIS67V1c0JagT0
	d4gC4tTTneu9HOD+XQachjWg2UF2pJQd5PFb+R4b9kTHxToJ0oXlzFn4Fi244E7i
	WtDyIF4YBe002hNb4pTlV9o9WaPCZn95CCD26fudPPdWWEA5mGF1zlmDTi9lQRUU
	4kaJTP5awOqrNcfa8gUl8fsqC05uA8/lr8g==
X-ME-Sender: <xms:EXKtZ9wQ8wi0I0gQoZIGfYt5k-aerqdr9rm6Mpk4ykXmz85qSTIPmg>
    <xme:EXKtZ9TxacuBs7lP9My7rZjXD94_9nLAeWUjE6fb2iqI9hf9g0kebxH0MX2aJv2IB
    D7ykj-_e97s_nGa9w>
X-ME-Received: <xmr:EXKtZ3XHMIqHC8RdG_APl7ezQqCELZbb2X5CWHjCPhB_HlgKTR4GrYs32_aaLSAqffxztMWWbku5Pb-HJHNoVn9fGueilliQRTtUgHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EXKtZ_h2t0RhNler_ofXso1VGhy3nyksmZsEAbPZbhYpSm0TgKkvFQ>
    <xmx:EXKtZ_A75A-PXgWjgHVOmvoax-DWUFRdsj0HQBeO8BZIlqXLUCAL2w>
    <xmx:EXKtZ4LBLbS2sYtR68Kdf9Z6EgbVyVilvz-1jKFQY2A_YqkTMkgWjA>
    <xmx:EXKtZ-DBy2Xt1LUrDwtu3G72y92IG_A_PG5RcZ9GIPGoM3tIfULbMg>
    <xmx:EXKtZ2MViED99513dKXcApnRDrbzJchzdmbMQlxolyV_HrGgloEkkSli>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 23:16:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 02/10] diff: -G description: Correct copy/paste error
In-Reply-To: <20250212032657.1807939-3-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:46 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-3-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 20:16:16 -0800
Message-ID: <xmqq5xleqy27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Current description for -G is incorrect, seems like it was copied from
> the description for -S.
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

[jc: I won't point out about the title and sign-off, which are the
same issues [1/10] had and maybe shared with the later patches]

>
> diff --git a/diff.c b/diff.c
> index 019fb..bd9db 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5866,7 +5866,7 @@ struct option *add_diff_options(const struct option *opts,
>  			       N_("look for differences that change the number of occurrences of the specified string"),
>  			       0, diff_opt_pickaxe_string),
>  		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
> -			       N_("look for differences that change the number of occurrences of the specified regex"),
> +			       N_("look for differences where a patch contains the specified regex"),

Yeah, but the updated one is not all that great, either.  -S looks
for string, so either "occurences" or "contains" would work, but
a patch that "contains" the regular expression would not necessarily
match with -G ;-) 

"a patch contains a line that matches" is closer but not correct.

What the option looks for is if there is a changed line in the patch
that matches the given regular expression.  If a context line shared
between the preimage and the postimage matches the regular expression
that does not count as a "hit".

    N_("find differences with changed lines that match the given regex").

perhaps?

Again, this is "preliminary clean-up" (or "after-the-dust-settles")
material and shouldn't be part of the main series.

Thanks.
