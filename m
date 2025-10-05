Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838D86348
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697745; cv=none; b=BVByu2avbevgcFYGBViTRGlFTQbQCoVVNTHiBFkndcsVMxek90yGS2OaeS7zkUYpKIOtnTFxJhDJZouP79JAEebOU3H/hGRtbA2QzrIUlYNIYdMUy5Oce6ISFAfw/pMWtQi5/HHo0g1ObsGs8GqIALXzfxw03ov5kopSz/XnYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697745; c=relaxed/simple;
	bh=BP3vXwCbcvcHaBplwhYrXnBBkq8K8hy+firmE38oV54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aei7njnLBOB6RhiWv02+1yK0NV3uep81m+mhvyiZ3tYx+TNoKm3zwyNir051jhqb0xp/GPQuxM1XIHPut3DFmueUCQoShO0DL6k4ZxVc/xcwyTNPUbRDr9CvuRr1PwHgXk7wlb119K26rf+rM2dbIG5daFgiQT2HEwEmma8BeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RvvD9Qt4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbMYrQWr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RvvD9Qt4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbMYrQWr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4BCD7A00B1;
	Sun,  5 Oct 2025 16:55:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 05 Oct 2025 16:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759697742;
	 x=1759784142; bh=GZzT+YoCl3nV07KsXqzLgWxLOMgxUq9Bo9Ha6xzvt5o=; b=
	RvvD9Qt4vbtheDArz75ko3+InBwpR4Qiva8mY/12xx1sRaEc9oS2OojhEXWxkxaS
	UgtBhH9oP3wIrLT1qhLSPg13qZi7v5Suj4Ck5dnSU3p5C0tEnbVkt1jhrua/s6/c
	X2chZhS7XD9aBgvl+O1Bl3CpTlDhwcOmIG41lypeV4fy8VhkXjhrugTDveg/2H7R
	PrK1e1Sw74RTldRb+t4oY+nIJdUQFyXtJnbLR16vbLSHVa9ExCPk4ZbkFZmBDH+k
	bjxWHgkS3fN+zs/SdZPQIA+iXiPwbKiyn5s7Eqc3YQpu0Nxp7zyysHSPvixN3Q/E
	+15DxlPrY0JmGEum7HgB4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759697742; x=
	1759784142; bh=GZzT+YoCl3nV07KsXqzLgWxLOMgxUq9Bo9Ha6xzvt5o=; b=C
	bMYrQWrfIFXcB5x/BnL+RlVuAaq+TULasMw1iyj/BxjMzuJyMAM6sgMFF3Q8Ojhz
	nBNGYpkP+R3qEc3K2mNspiT31ti2X/GgkFnl0mPZoCtIpwhMA4HemKc9FPCn2lvB
	a9Nhiqgk7FO0z9XBu8ttrhN9zjuiz/15LxUUhqLB9md9NxsPEdWPIxTP1VwuWlB9
	xOLf0djkRwqVAZ48r76rVhiMu4DK5Ucs5aDy70jOlUO5l5eJUkWym8KlrSGcuy0r
	o36fogV9dapfHSi+zCFPkiELMGUs6sIJ6kPYZjfWXEhP8sfM39GJ4lN6cVzXmwlR
	6cOjftShU9HnyduTyl5Rg==
X-ME-Sender: <xms:TdviaL52ju63J4Q4Bimpiaq8PS3u4aj1ZjrOC22Uc78TJQFmNpAKYQ>
    <xme:TdviaCZtIFL_suI98sdr2-qiy9YqTI26HSS1UEkR1ML_JLcTrSAGd59AZHJkPa6_5
    YHykGPV_QhaJa2ex7V9wvQ5fQv__rx5xTtT-uJigDqrjsGD7VRHVA>
X-ME-Received: <xmr:TdviaCha_OGyLl0BSHcGHsOTlwarJGopfgA-tHDFs6zZwN2g_prxi1OjZJ8awTi7BcO-6hMcQhSta0NoDgW2JGhe5tNwxWlWvVcC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehurdifihhnughlsehu
    khhrrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TdviaL-sTsKij2k4c3rt_DPedhTYEMPH0DPL5a3XSVhfM1jPyQPLVA>
    <xmx:TdviaFpvAKPYhRFUMO0TrvAeM6w3Ydtyb3qQJilJblfapdlxPhzy0A>
    <xmx:TdviaLWGo3UjdJzmJpNli372F617PcRC7MJQ9YS76JtdQjk3m4hueQ>
    <xmx:TdviaMBTRm_nr1HALxKQR8oHF_gKM6lTC4kdc9YEtYjoSN3cSxE5RA>
    <xmx:TtviaIx4hyrLhofARklUeY9SXLHwzNvY4_Mrm-k-PYI7-FtJSofiNQ6w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Oct 2025 16:55:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  "Windl, Ulrich"
 <u.windl@ukr.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/5] add-patch: let options k and K roll over like j
 and J
In-Reply-To: <f99b93d5-3de2-4077-8818-9272e812c289@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 5 Oct 2025 17:55:46 +0200")
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
	<17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
	<f99b93d5-3de2-4077-8818-9272e812c289@web.de>
Date: Sun, 05 Oct 2025 13:55:40 -0700
Message-ID: <xmqqh5wdrrub.fsf@gitster.g>
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

> @@ -1584,7 +1591,8 @@ static int patch_update_file(struct add_p_state *s,
>  			}
>  		} else if (s->answer.buf[0] == 'K') {
>  			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
> -				hunk_index--;
> +				hunk_index = dec_mod(hunk_index,
> +						     file_diff->hunk_nr);
>  			else
>  				err(s, _("No previous hunk"));

I was wondering if we want to always allow J and K; even when you
have only one hunk, you can still wrap around to come back to the
current hunk, and that we can do without any extra checking logic.

But it is also OK to require 2 or more hunks to "switch" to the
other hunk, which is what you do with

			if (file_diff->hunk_nr > 1) {
				permitted |= ALLOW_GOTO_PREVIOUS_HUNK;
				strbuf_addstr(&s->buf, ",K");
			}

to require more than 1.  But the error message "No previous hunk"
sounds somewhat awkward.  If user accepts the circular nature of how
we decide what "previous" is, then when we have a single hunk, the
current hunk itself _is_ the previous hunk, but because we insist
that there are at least 2, that interpretation would not work.  With
"wraparound" semantics, "No other hunk(s)", would be a better way to
give the error, no?  The same comment applies to 'J'.

>  		} else if (s->answer.buf[0] == 'J') {

This makes perfect sense, but then, after this post-context we have this:

			if (permitted & ALLOW_GOTO_NEXT_HUNK)
				hunk_index++;
			else
				err(s, _("No next hunk"));

and it sticks out that the post-increment of hunk_index here is not
using inc_mod() for symmetry.

I am wondering if with that updated (I would not say "fixed"), if we
can lose the "oops we overflowed so let's wrap around" belt-and-suspender
code at the beginning of the loop, i.e.

	for (;;) {
		enum {
			ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
			...
			ALLOW_EDIT = 1 << 6
		} permitted = 0;

		if (hunk_index >= file_diff->hunk_nr)
			hunk_index = 0;

or if there still are other code that rely on this "oops we
overflowed" adjustment?

Other than that the resulting code with the whole series applied was
a very pleasant read.

Thanks.
