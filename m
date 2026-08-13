Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD492931DF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646029; cv=none; b=pYu5QAB8nJa19RDd01+8Fz85cFs9Z2Zw4mmaZxPSJcW946EZZTtpt2ABjm0+RDzWWHeK0grGveJiLaowwLuWH9fdpz+28sQUdNGR83bc9BycbETSBUEPDGIdCHWPxJgp9hltYuHlAcclU1YKxc5ISUvXhoZtQ7cqDnEp62DmS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646029; c=relaxed/simple;
	bh=Uxysf8aQuZAfJqYuzPhNiCfWSYCnhY36cYEo/+qxhCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IJ9KbXbLyEym0xuYEBUZIsCkExl0syFDQTgOs8/HWl2YQ4dVlgnptpjhDN8MwgHobRn7mE0pTiM7t0kRhNsuG3JKNXeBbuTAGyLFuYhbW/GNbnH1eFG3FCQjymcwWAwq1LM2JM2d1wAPRGrcCXaz+o3o+Jbwk7FNwMyyQc4PEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TgEiqaH0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AMkBBTbi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TgEiqaH0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMkBBTbi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D6BBEC029D;
	Thu, 13 Aug 2026 14:33:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 14:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786646027;
	 x=1786732427; bh=xRgCZJSxxLKOgK+aieDkGETTykRLPh16oGpVKQqj87s=; b=
	TgEiqaH0NquQ2Wcr90KMwR9bqrM/95Hq/5SU6XKXul47PBXTFBCoQFmwDulWqyYy
	AQs5fXH7DbeHzJ7fjf5+p3spJoAHkLe7X2sr16kQykxmaLFSyRgWP0V+Otd9S9pg
	ANPSKGqQvCayB284obMkIuQhKoUA3CIaPUqLErcHf0KxLPyJ7AnK5Gkq/zRX7gyA
	SuYEKY2MMM+xhC8bUSz2Q9zLjt3uTmMC4KcFyGBpyShDBClTfC03NeK2/5FdjarM
	qDf/nnUMeNyNSTpEbze1Cm/MAQkMxJdWLL9rEcniG5V6yDfRVkSPKjDPqKY9MyEC
	H2OtiOetKdgESADgFJQzZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786646027; x=
	1786732427; bh=xRgCZJSxxLKOgK+aieDkGETTykRLPh16oGpVKQqj87s=; b=A
	MkBBTbiq+V1iJHQg2NBtLXKeEhYjVK8W8MtcuMOs3Eu8mCEaXDYYcQfe8SS4g0Bu
	Ug3c5Cp2wjaLnWPKkDNPAGUFtZ32IYTqcTHOtI+pYbgWM1sfjBgxBn2nLfKmSQeg
	FDFTu5YN7TDCErABtEc2q71ZPvOMPAMZirS/IjhU4OjO1fk66z/6uammNMamvHiC
	6beh2TdDtUKhce2PM9ZEoW9ljUnki0ZxA5+YAC8EMZK1dcUHa5l7Q9+kIwd4uwua
	jGGqDVfd2MFVM+EIdiy0fsWD46wGqbrEszE+0rfatEfoV9YcLrB03xhc3AML2nT+
	+z2DA4sFZP+0eTR+jTVjA==
X-ME-Sender: <xms:Cw5-amS7yfu9fQaDQCq6u5LaNlKZb28YXcGyVW0l90Fkxo3G2ZWr1w>
    <xme:Cw5-ajOZQp21oC53wjMoU1AzeYKa3oxQo6dEaaPrw28BvzHC9oJG-0bwLkm_ak3Jl
    9x_Dj6ECzv1wz-BMtPNKmMiuardOR2aXgMYk17F2Gj3lhKke2sZ0A>
X-ME-Received: <xmr:Cw5-ahMVgXTgKwP4iaP_76iYupOmGqslYNZ_PWFDyNzvGFFoVQvbNOPHlacK9C8N6VquSqcXaAcZu7CpjXGcoSASlyQmXz7dFw>
X-ME-Proxy-Cause: dmFkZTEJkHm+gtU4P28/GpgKjY4iekAtsD/nAztwxZzgrw2qDLtXk1e3GOeQmfpRLjLLJW
    mggh/jmCh2Cp95Lx1+8yOZIV9QBqxnJLmI+LLhNbIxLWppVmjhno2fZZp3dhofyZ1RivCm
    ke10YkcBO6fIHb+bWDQBalszs+YjPxqkbaqMRMNmBhQMn2Wc9ADnOoD9WpDsI9NBafI0z1
    QaJEGZSYwKHzyqLI+YOdIJHhXG2vcO3E3MsmILy4MBlagZvyVu2OxuL7MsPLD7bIZEc5ts
    2pMh5Zkluf6C8UCFPZkfjD4xFzz+PtEA5lNEIE0pK8A883B/Sd/IcY+ac1mKwIx9lPTcVP
    YrVy5+tYXdhO0Arl0JytzEVvpJUwxENDX1fIiHLlYYFEkrx810bsMtwnLxTqEZfwz+g8H1
    VKe9QpWlnCc12nYocPJE1cgABBWc01a3hW0EMACw5rKbuyzLKKce1dj9YY/hH5xcQrM2iU
    djSAqm6uJI43nCPpA4PgAWV4WteNSFfDzNCwMTRoL1fQdnQ6Vir47aw1f06/KLmszS7Z5e
    TUDuIaRzRRytPBxke3NqW0SaQXxnUvsicJM2tp4FPIQtP675zdXtbCj7+qteP89aZ6Ze0B
    rvU0/HKXUEWeldgS7TEyeWx+fV3K0HNBJKV5QpBeQYsoyksduk8SUUZuTP1A
X-ME-Proxy: <xmx:Cw5-aruOM2RMg5n3S8I-QL3eczcftVgn6kUccEW0yCNWlMiHkw-asQ>
    <xmx:Cw5-ajVD9SS7eCEk4pBB7tiYcp_WhBg3S4Kj-fGM-lP1PowhEmhkEA>
    <xmx:Cw5-aru8PAyHXojJP9SPr3UaSIcDvGRc8fT2XA4Y2uXBe7bP-ak8Zg>
    <xmx:Cw5-anVno1uWn6h8B4lFURV4E0UB_0iKvHwhYFZudC8xIrgwXBufVg>
    <xmx:Cw5-aozlLEqhV_KODDhPeFSJ5vV21O5z-9oBfzM2llGczwkLgwu17bEV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 14:33:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: kh/trailers-no-urls
In-Reply-To: <6e990986-2d7e-492f-aa40-d26cca4f58f4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 13 Aug 2026 19:35:18 +0200")
References: <xmqqcxvmvda1.fsf@gitster.g>
	<6e990986-2d7e-492f-aa40-d26cca4f58f4@app.fastmail.com>
Date: Thu, 13 Aug 2026 11:33:45 -0700
Message-ID: <xmqqbjb5swdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Thu, Aug 13, 2026, at 06:45, Junio C Hamano wrote:
>> * kh/trailers-no-urls (2026-08-02) 2 commits
>>  - trailers: stop recognizing URLs as trailers
>>  - Merge branch 'kh/doc-trailers' into kh/trailers-no-urls
>>  (this branch uses kh/doc-trailers.)
>>
>>  The trailers code has been taught to avoid mistaking a line that has
>>  '<token>://' at the beginning as a trailer line.
>>
>>  On hold, waiting for the base topic.
>>  cf. <20260803152025.GA189075@coredump.intra.peff.net>
>>  cf. <xmqqmrv42lrg.fsf@gitster.g>
>>  cf. <xmqqtspbz00x.fsf@gitster.g>
>>  source: <URLs_not_trailers.b13@msgid.xyz>
>
> The status of the topic kh/doc-trailers is “Will merge to 'next'”. I
> will wait until that topic is in `master` and send out a new version of
> this topic then. Thanks.

Once we are reasonably sure that the base topic would not go away or
change drastically, it is fine to depend on it before it is merged
to 'master', if you choose to.  kh/doc-trailers is sitting at the
tip of 'next' as of this writing, FYI.

Thanks.


