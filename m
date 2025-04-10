Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AC28C5D7
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311493; cv=none; b=C3THiE+8X9b5zDKcbSn+Nr8iQz/GUjkhflzPH4i34tMqTuNK7HoBALuIiWkkgBrJ7qVf5s9ra7pY/FwwQ8Mo1+3qEHDG1g50WQNLpKUX+4zC39z/k9weBPNHr5N/tuzuBnI/vf1iW3hdW629rjydopfu9Ak6zOw0yXnc8/Luu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311493; c=relaxed/simple;
	bh=YuLm8uAaEpEiFyc6oLf/+Erky+l80311d1F6vLQDlqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuQKx5xZoRbmeL8067nihF2tK0wzcGK/IlZWS03luw0Cxn7fDujnAwGnqOkZYuVGDX00qMKQ2kfvk9SHMPAZgOcY8SM6WJKh4CNqebbd2oK8ozoxLe4IhhHRAbj9DeZFTTevB5WtwZE0IGXmDVP4labi29+BpiGH9A2wrwmZRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LI5GdkUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoYlkXHD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LI5GdkUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoYlkXHD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9BFDE114013D;
	Thu, 10 Apr 2025 14:58:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 10 Apr 2025 14:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744311489; x=1744397889; bh=es2cXArCDY
	chMoTcGYIaJM2rAMLCQoC888u674dm/jw=; b=LI5GdkUwa4cAnIpaedic1ODvQX
	j8cy/R89GAHnomG5dZlttaxknhFBJ8BUi2KiEgM1uzD/NTQgxEcrD4otavWh3kOl
	tEZ3rYtxjwEcIEGmQZLPziWTPYsjwAQAOsWajVUTNqDIK3DpT7eOn6d+w0Zwn/y2
	uze2dYgX4BRMOKMdCRctGLH3hSgoQRl2aId2/6Fzq6T2SnjM+GDdumr5dmqBCVr+
	Bnd2eh6QO8A/WYXIoC7GdIWsVFeG4PmM21/rprlNdOZ+cNLsnhuSUUZ4gBDzy/0F
	yHOCmvkMRoaw3GsbCUP0f2tlXNLQqzfXK7K+LrJo6lCZOQnYVgwTK0RTPc1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744311489; x=1744397889; bh=es2cXArCDYchMoTcGYIaJM2rAMLCQoC888u
	674dm/jw=; b=IoYlkXHDJ3J/4XcO3D28/6g6znGCHFWhMrJHpN9RoQ6VOUezNoV
	h/LOzJ9RaCZKNJurHHoPJ5messUZGUGQy7kThQ/1dI116zSKhRULEIl6F9KN3uMK
	pDRXCtyHIEV//J/Jqeb0m/2/fbZkf2GqC22JyUoTkJNzcpnAbEmuWSR7UD352J3x
	vXsd6iliorjJj2O+QVrzwrNgSvn4h4Re29mxud3kxlnchYYflTnlAQIy0rmYXRQw
	hzP6gHv2tAlg9dI8cSiHr4gP/DTleYOYKEehttzIhUJD0QlAS6vG4zaryce3HmEq
	gfXlpIEO+9lhhRG8uldw6h749e2fyzQfLmw==
X-ME-Sender: <xms:wRT4Zy-mcmzXksem2zBJp-A_dOQZD_2VZ9hR4MuJsVGrMLGAKcIskQ>
    <xme:wRT4ZysYaWueod2Uxiwvd7PMv_wCIsjuUysquay7kTTabUsMW2oIfPRb243-Nljpa
    NwWh5-NiP9o9WWKHg>
X-ME-Received: <xmr:wRT4Z4BEerB4QkUQdnCFYETxQM3ObHVLZWGrsbHrHMJ6fBcTdoXku6UZL60i8QGq97c6XhfxSq5lMuFz3jINbwgzBRCizdd5yo5v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:wRT4Z6eWfWg-5BMcG10tRxYVT3DtOz-OqaWAADVfObyVjWp0-f06YQ>
    <xmx:wRT4Z3PzCkOHG9pz5m64f1Zsq9qVN679Owr7cqZ0L8sW1CWcmyOibQ>
    <xmx:wRT4Z0mWTQtguNxHnR_yi0kELkChszFz6nJn8ZoHjOyb9X77XB8fCQ>
    <xmx:wRT4Z5sk-NATVIDMj3e09KCWtLn1z8njgqwed249w1-v7wPFyBliDw>
    <xmx:wRT4Z8ySjUFtfGmbQ7ZctduvH5cNjD-tyJchvhq5lZCeIS7IQWm028eo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 14:58:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  toon@iotcl.com
Subject: Re: [PATCH v2 4/4] makefile/meson: add 'headers-check' as alias for
 'hdr-check'
In-Reply-To: <7eaa33ca-0ccc-4789-94b5-de1a068e1599@gmail.com> (Phillip Wood's
	message of "Thu, 10 Apr 2025 15:50:45 +0100")
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
	<20250410-505-wire-up-sparse-via-meson-v2-4-acb45cc8a2e5@gmail.com>
	<7eaa33ca-0ccc-4789-94b5-de1a068e1599@gmail.com>
Date: Thu, 10 Apr 2025 11:58:07 -0700
Message-ID: <xmqqtt6voncw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/04/2025 12:30, Karthik Nayak wrote:
>> The 'hdr-check' target in meson and makefile is used to check if headers
>> can be compiled individually. The naming however isn't readable as 'hdr'
>> is not a common shortforme for 'header', neither is it an abbreviation.
>> Let's introduce 'headers-check' as an alternative target for
>> 'hdr-check'
>> and add a `TODO` to deprecate the latter after 2 releases. Since this
>> is an internal tool, we can use a shorter deprecation cycle.
>
> Can we call this "check-headers" to match the other "check-" targets
> in the Makefile please

Excellent suggestion.  If we were to change things, we should get it
right just once.

Thanks.
