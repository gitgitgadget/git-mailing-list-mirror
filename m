Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02793A2ACB
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119799; cv=none; b=J976uxW8Flw9rI67TF611Znqj+k+wg6b014oCvvMFY/jU3WjMKAvSAqKVnbJxSdFxHPVIpHGB6PqLEHcmCaxktXCIV1cDctSgFL0xROhFey3uHC/ffGaJnbohVX4eKLq9bvWTDvlIury1N6BFQZVIpQu8o/+2CWdMI8AHa1e+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119799; c=relaxed/simple;
	bh=QLDWuaPbSdgkyadd3rE4mGYz2qT8SWsOmS7FhR1JF2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N8oMgiy8JlhWOoifvncd5vqWOnOR/Id8zpoiGE9IufK202qkoOEPsXtAWbE49FTPKTXM0wIbc9GmQtiMsU5ekcEcdCdf5qQlHx9gPfXfigRDOMGzoy4Rm7+54TAvILTdEjpc10LBnvlRqE/1nsPTSs/qDHBHhBYEkWcYafmxv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VGN0qMPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xTvMFjHy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGN0qMPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xTvMFjHy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A6F2140104B;
	Thu, 22 Jan 2026 17:09:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 22 Jan 2026 17:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769119784; x=1769206184; bh=5PaFQGDvj0
	xQrQZRhreQgx/W/NTsNJlbWAcQwm10M4I=; b=VGN0qMPHXulfTsniqAnHSr7iis
	nMKpGRyL6LiduMwlpC2chJfudoeCkS0gbtE+7roavrZoMij0mw54aOfW8HaCm+ms
	cTUW9ByVXsni6fui6pP0BlrK3OICbwb5uC+poW/IN6JngbKmuqzd73GgmQXImyWQ
	8Q+qXMMIJwQk2sD4Oe7ixjwZczKWWI/gcjtrQOIc6ys5G0wAhovj4u4L72D1tuGC
	SXG0IBqThVYAWh6kRxeoBrwstfBsTwYpoItcxC5/jVIDEUFKzkju2da50RRvWFie
	+imb7nnjDmaRXwdc7igObqGgMU0FYLF1UZF/sBV3yIDN4MLHIEBej3gR1Z3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769119784; x=1769206184; bh=5PaFQGDvj0xQrQZRhreQgx/W/NTsNJlbWAc
	Qwm10M4I=; b=xTvMFjHy2NnVa7RVVut8AMNMp/cHbVMLb6Gff/frWow5VC/PvrJ
	FAJ5UlZZdZftZJxpPJjoH8eesXBLvN80Am/ytzKeYCcmA2TaZf0XtIUCprOUfYh5
	k6zsx5PsnrHeuBKdfHhveW0fWrBYgarStz8/uty749SjemQZGJGBtG6CHlSfXSk1
	BJ8VSOUJ3z3VROzux7A3zsUoiIMAY3L5q4meBkDtpPhWqNJpiQCvConSaE1gLBUY
	9gHZRhBzIbWz9vvVSmBc23Fffb30GmWFW+Y/E5YPs6cnUhYcae1SjBQxbgjH1icT
	VSM+dFd6Rgbpc8VBdJ4Khi71FL4PeHOGQCA==
X-ME-Sender: <xms:KKByacm04OQgMj71iiO9LOoDZMDfzAbye54nzOd-ElYcNFLrzdxG9w>
    <xme:KKByafjQ1kRM95HPv_Coxm7OwHr-rPbCn0ToBFJ2jdTugpn7m7esTn9Lbj_Ucl6_9
    DZCmg0THhLncU_6-FZATUUyLi32eXrPvM_hVCEU5CM0_Hor6Rwgyg>
X-ME-Received: <xmr:KKByaUckmUzkhISfgkedB5QN9wxC7SpArpvElx1UEpDnduNzDiJFWA4PS8ozw8hEjmjedb7N2NvnOocfC3OBj0lhlfi8lTf-4IEJLUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KKByafirLRuCa429NIFZYnDfrsgkSZ0RkGyPig_w_hiKWoh2ebQ4hg>
    <xmx:KKByaczXCJrEi913GzqebE5UnlCfFyAMV5-4BgDsVMPyjorEhzQnzg>
    <xmx:KKByabNI5e47qeI-xO_Oq7RJbJur_DZdI42GYtNNz2WtZyl4vAe8lQ>
    <xmx:KKByadU8_QMETcRcLBOIoTqIfBJYq91LmEKZ_oIyCghRQajltc9Jrw>
    <xmx:KKByabWw4aqkgT9-jWfx5vCWIqu5Bf09RvMWE69r0XjMUOJhnYXXzOdu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 17:09:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/2] Adding string_list_sort_u to replace combined
 calls of string_list_sort and string_list_remove_duplicates calls.
In-Reply-To: <20260122171523.94234-1-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Thu, 22 Jan 2026 22:45:21 +0530")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
Date: Thu, 22 Jan 2026 14:09:42 -0800
Message-ID: <xmqq8qdpl2op.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> I was unable to write unit tests for this new method in this RFC PATCH
> since I was quite unsure why no unit tests were present for string_list_sort
> and string_list_insert.

t/unit-tests/u-string-list.c has tests for remove_duplicates,
though.  If one discovers test coverage is lacking, it is perfectly
fine to enhance the coverage, especially the low-level unit tests
are ralatively cheap to run.

Thanks.
