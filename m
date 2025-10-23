Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0A30E0F9
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248406; cv=none; b=SJQmM4iI6RPXMS1tpuR18pVqAjLf+GmsYYclgxY/b3cklSrLXhInLll9TlxoBaTCAt9hqjBIbq85xl7wH57NFwdcgBEFPlAxdwFBsbTYqXOvohyFNih+OuBnFBL5VxrE7GMkzjo9boX6LfEggnQWkXQ99RYEuZUC13AAwzbokEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248406; c=relaxed/simple;
	bh=3NoRZlmUwO10B/uFo1i8TGufgSYiebcOfYA/xHa+lDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Reyb3gTOgUkfzD4rgsm0BFs5U/1nnWoI5vqq4haxQuTSgM3KWPKqJD2IvZDu60eTag0+7DS5QZ7YBTVEpr0Ktf07oAoqgLBcY6Q86UKnR8X3ZQl4xZJv0Ac44ZT8Pl5AuBxn/0DQPVQvGwd6xJQzgV5oFVD7kFpJy6gPsbzN64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fcmBGmtO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BBF4OhlC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcmBGmtO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BBF4OhlC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 854D71D00037;
	Thu, 23 Oct 2025 15:40:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 15:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761248402;
	 x=1761334802; bh=3Wz6Osk1QDWwrAeqyMNNT1r5IevooWGmKbcMFJrpANU=; b=
	fcmBGmtO18VAYex79Zuxf60XTwBmBAQyK+H1kyF/CPpGadFosNqEDNdLPnekkZzI
	d2+AMmapOf6T5cR10gsea4n5KPepmiVx0htG7yOjSsy1bJ28MSpXlrwzDyGr681W
	+VbEE336gNNx+qGmanRYZTaPbWPTFoRmEkNXrOlVzw+LMfW4h7DOIGDentl5Wmdl
	at0KeVk2ACCd4SPvr+R0CJHDKREadRnqKMIaEjxwnqwC6rBpspd95r1JzKxW03sb
	7NUf6kQNAyM+edutjLBOH5xE9NPpXy9NTGQHbO3dum9ng6jQoF9MFE+ZRIP9LGk7
	u7lnOtoOgd7T6FzEvdhJtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761248402; x=
	1761334802; bh=3Wz6Osk1QDWwrAeqyMNNT1r5IevooWGmKbcMFJrpANU=; b=B
	BF4OhlCKjhcJG61u+Vl8m9jtOoIka8ZG7Il1E9vCQXeqnXiNUYf014Z69zfW75Tv
	q4FHT5eBuwcWIa0OEkhRPVYnlh5ZCjNROVqSo6rIM0PSaEL3dyBHcuy2X7DVlG/E
	aPc37YaxXRNTkkhfTCT/AcbDDgQw4n5eaPe59gY72V+MqduBeQSDkx92o2nZ+hKt
	gweZuEmUMVxjEf0yTkgbYHQmOqgI4iHr4LEhOTSJi/jQSQ/engY8mJsaLRhC7H2m
	Q93IxjMYFoaRJa8i6rgVlGi5of8TtiujlM48Fu2rBXR9Q2mECBzYssK7ygNRSylR
	0M8HhlbUHRuwbAHX+a1mw==
X-ME-Sender: <xms:kYT6aLhaRoDrmd_iTfLlHuVVaa3KWYTJIqIww7PH2601jQniH_7SIA>
    <xme:kYT6aKnQyTcy80w9LbodJmXb__sv6-VTyOd2SzlOg-tnUN7_bmhjJg_rt26hcbyBE
    P-yl-dUy_mxwzR61NkS9qOS6gboADKgx9b-rheEfeVXdP5lAz3o>
X-ME-Received: <xmr:kYT6aOuCT4NJxa4w-5pakfufcP4TmZBaR-6Ra_94OlczXB1tqkdGqinbdY-w4G1UZ7NvYKKOs3TSxsd8K8-E1T0BRRmwj9K6-UlZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdruggvpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghvihhlrgdrjh
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrshhonhduudgthhhotggrsehprhhothhonhdrmhgvpdhrtghpthhtohepjhgt
    uhgsihgtsehjtghusghitgdrphhlpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:kYT6aIaVquAR3CWT-gibyFPaqQhLVt50qIGRAs1p0dKew9baf18dYA>
    <xmx:kYT6aOA9AHgb-MDis2biZh7ir__UWELtJVq1WfhQzAKd7Vr1DhhlPQ>
    <xmx:kYT6aI9O06uv-7p4sSmQAaifVoSq7hFft4xSPFGB6yBEPSQt0jNjpg>
    <xmx:kYT6aCTpZzgQlxqw8Y1b94cfoE9keGrd7ufmRf4G_dwflVV8ePav0g>
    <xmx:koT6aOjuuqqUrcvOP_QrMCg07w68iS88fI6fTsMl-fwWhU1VkLPNTBNc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 15:40:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michal Suchanek <msuchanek@suse.de>,  Eric Sunshine
 <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jason
 Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
In-Reply-To: <CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 11 Oct 2025 01:17:47 -0400")
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
	<0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
	<CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
Date: Thu, 23 Oct 2025 12:40:00 -0700
Message-ID: <xmqqy0p1tnjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 10, 2025 at 1:05 PM Michal Suchanek <msuchanek@suse.de> wrote:
>> doc: git-worktree: Add side by side branch checkout example
>
> Thanks for taking my suggestion[*] regarding a possible git-worktree
> documentation update and turning it into an actual patch. This is a
> reasonable beginning, but I think it needs more work.
>
> To begin, the idea was to document that worktrees can be used with
> bare repositories, but neither the subject of this patch nor the prose
> added to the documentation itself mentions bare worktrees. Instead,
> they mention only "side by side branch checkouts", but I'm not even
> sure what that means.

This message by Eric was with many good points, including the above.

Should I be expecting an update of these patches, hopefully bringing
them closer to the finish line?  I'll tentatively mark the topic in
my "What's cooking" draft as expecting a reroll.

Thanks.

