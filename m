Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D583D1C5D72
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727447; cv=none; b=L71koaOPtK2qNd3m0iC26XjM+L90ph5dc3Ix6w50IZ6jHEhzZ8Ft3JFIO7KGLK8O3wrBUBsSspEBRdDoRKLcgagogl8EOUu4wohsQnJlxRF1Ych9BWoFuSnIyGsYclnelW4biNy8yotCSzXegpMsW7i+3DMyoYxgq/ELaMc2uHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727447; c=relaxed/simple;
	bh=H6QA21V+ksFdAsP3Rlx5wCoC8S3/CmtftfTMJKBw6uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzTpAwiP/vM4cQJ7Pomqu+kEz6Ivmpt+eyUt87YyFiDQ416G/OI7DTr6nayNqhOg/AKzTVactQ4L6ukysqN/SH++ClcpWCmBK/aTdahY07XbaTlSuYnPcsFLI5h00Hb9onVDpp3WkGnrbvzgEqLPShQUSWCVVdMPI4OU4Xqblb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QARpP/o2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ubswfuoy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QARpP/o2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ubswfuoy"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CE09E1D00162;
	Thu, 17 Jul 2025 00:44:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 00:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752727444; x=1752813844; bh=cW5WVfIX6V
	Y3wpNGySN6Q80//sp9TvOGBaWEDyzTGq0=; b=QARpP/o2kuTpwITNFEFl+fe4AB
	lJxOUm+b9UeBvfNTtYxv6zabqfogLfiRi4RAdlam2iWh+oMUISiF9PZH9JqswXMB
	mlV5FGtvUZiNtxzUErNCb3+X9b1L753wEvXVmGRXDpv8PNiPE+mU9qVt/aI7PYC4
	AaLfwLJMvQvb8U081gd27JPGjRB8/CofuaiTcONwVSNxV8bup74gVH/cnS8Z6yMD
	JrHVxeQjEzRiHcVwTXq3Kl5KvZe5LbnR0Z7Ky/cpucsJh5Bg0h7hRntjSm90g3eB
	tfLsqGqRWtr76Xr8d4QCvM0wMmazgsWv/emaex7tE6mJfEY9HkYC/DiMfCmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752727444; x=1752813844; bh=cW5WVfIX6VY3wpNGySN6Q80//sp9TvOGBaW
	EDyzTGq0=; b=UbswfuoyZ1tv64BaF0BYGjisHBgFXen2C0ZZkEut/5yfnqEY28D
	Ilk5IrD3GkDbR08hj0QImmiith5GMvmTMaonWQBZao5+EKnlAc1yB4R7sEeNfagf
	KGRFjrZ6GcIwHsVKbxCiWGE+ywq5wnNtd5u/i+b28SAVI1NCl3i4giBDKa2rW4WU
	nejl1Msm4I25uDJlR/gJmow+Czd5M1j5nyzQNhq7ea3MLU4Qk4WRmMdjnKdfoR2W
	lUh/EyibmXUVio/tEz2wRjKHAnpMXyJPz3yYKrZCyQf8t4ZojO5lodr/hco7PCqK
	dZdQsHP+gMXBqogtHak9NiovJuFoc3nbSlQ==
X-ME-Sender: <xms:lH94aGoqZgqzOuwy51KzU8-Era9OkxwlxVLCB1-1sNxiaGxj-VoHfg>
    <xme:lH94aN-6QCHIqEsIFOlaekW2qzrOvlLm0z0doBVu5qhSreHmxVIRly8JQvU4cHQwg
    wNrpuQdmv-VgjW6Dw>
X-ME-Received: <xmr:lH94aCe6fV7LyY4HhA0sxc11RbQLtc2wYe_uUd7a-Ru2YlD3AZbULKSS-ZGxJMmPYRJf5gvfmxCXoX6-T58lnVRjpph17u-fBk18okk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhiheslhhooh
    hpihhnghdrmhgvpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lH94aHJr6y0ujSTkyEmXACQPZfgYZkTdbsE5yQKW0wNd0y3xb0_QlA>
    <xmx:lH94aCii5QZnG_MRmn4Bzbixu8QU-0F_ZIf5SGl9_u6MmJiUbAhLYQ>
    <xmx:lH94aFT_I2tSj90ki7noe097tURkRUJR55oPqL7QCtUoPHBYIMihXQ>
    <xmx:lH94aMUKbRr79k_T9lirxGO9cWQtnuPollRfCmB7AxpjgbOGF9pqDg>
    <xmx:lH94aHupVURCpN1FeOitfzJC-Adc0pMz61sdkglsndjsrOI569lZ76FT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:44:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,  hi@looping.me,
  j6t@kdbg.org
Subject: Re: [PATCH] pull: add pull.autoStash config option
In-Reply-To: <CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 16 Jul 2025 23:27:57 -0400")
References: <xmqq5xfsdv3w.fsf@gitster.g>
	<20250717030732.75106-1-yldhome2d2@gmail.com>
	<CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
Date: Wed, 16 Jul 2025 21:44:02 -0700
Message-ID: <xmqqfrev8m0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>>                 if (opt_autostash == -1)
>> -                       opt_autostash = config_autostash;
>> +                       opt_autostash = config_pull_autostash == -1 ? config_rebase_autostash : config_pull_autostash;
>
> You may want to wrap this over-long line. Perhaps:
>
>     opt_autostash = config_pull_autostash == -1 ?
>         config_rebase_autostash : config_pull_autostash;

Alternatively

	opt_autostash = (config_pull_autostash == -1
			 ? config_rebase_autostash
			 : config_pull_autostash);

