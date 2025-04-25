Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044217AE1D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574579; cv=none; b=lv5TsG9ANtJ7bbZkKjoOMIu4eo0NE77QfMQlHmeIrQfOt0rhxn7on5YMn9Na3vjRlLMVCEdJj+6b/CenQsaIdZ92GmOK7QLEEmTGcPGT5KsugyFW5OZO4lmvEhn8qKRc7ITMZVbW5yiA40Y2G0YeAxYgf8Sc9rtDZJRx6lBpIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574579; c=relaxed/simple;
	bh=+gVa2LdfN8wERPJXwg4fpEw4GWfO1wYOcEgg5IF/ifs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CoKW9E7b/9/mnSwtpHQU0xI1lt0ObY/vWrwz1qt28TrW153hEEWcTKhZHxoegiCtVeOw/xp+EERgt4fuxqsZtGmvugBkCGQrE/x+g5Bnq70iy015Z6qcROkJvdOaWJSZ7jrP0tepCp8H/JD6ET872i1YZpvJqGmeD5HU7ZGZIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jhkdxReP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThjcydC7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhkdxReP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThjcydC7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DCFAD13801EA;
	Fri, 25 Apr 2025 05:49:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 05:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745574575; x=1745660975; bh=+gVa2LdfN8
	wERPJXwg4fpEw4GWfO1wYOcEgg5IF/ifs=; b=jhkdxRePBbkv+qDA8KSQ9/CcOC
	PcitlGcWp6L6kpqE9Pni45UlluvrvsK9aeghu1gBedkFy2cMxwFKzZBPu+uazg9C
	fL3Vhg5+7bapIGCARd0a2EN/QXzG44NddZ1caWthGG4+AN+HU7GP5Uk0rgevgiC2
	/dltD9u0qBE4hQ3R21Z+Cq3ZMr4K6XC5x+zFbvaPEJzNLTyVLrC6uAJ4Ii7+YChS
	kMmc4Ii+1YC+X+rtuyEJ6kDWDBzEAP4ckIpCxxyfiGCwtnd0ZjHuz70vD9LGzwHj
	JjwyO9c5jAzD1o+n3a0nkYrnS6He9B01RqjmEzbEwwgJRNlgScWJGuyk99iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745574575; x=1745660975; bh=+gVa2LdfN8wERPJXwg4fpEw4GWfO1wYOcEg
	g5IF/ifs=; b=ThjcydC7VGpLteF5KwhPljvtRHsiH6QBfppv2OTBCbGA47/0c/b
	L0B2EGx4nYoEHoX1g2r08Z/+39xd81izu9PJqV1I9QX4ozG52fEHgXpGT5oLjk+6
	GrF65UmHzX9feYMLMjkRjE+RtJAd8vLPAg8m9XerH0/w1PpLjzWKPo4xJmy8f5jc
	Xq4iK0GOyqwooy2tRSwWQLsVQ+JseW4Ln7RkVch2/L1OgyBdcFCcPXX7SAZsNgOM
	AXPGhI2E/UDcaEilNAwMzqI0YPfcqXbkFjzvpYxuKVRrhEVqp3mlIaZAy/R9CAJP
	P6qS1fGYPRpKrpYvqTsJCAUYc7dBg8rf0cg==
X-ME-Sender: <xms:r1oLaFDEZXP4Hq2ukBuFKGzdPg6208OQhN66B_-cxqxKfCxgYL6dxg>
    <xme:r1oLaDiSajIaFN0tJe7BckURJ83e24jHAVmc-lgPboEHXswTYshIOpTTHIXY-IHoX
    nrVJ8uMp_FcdHqD0w>
X-ME-Received: <xmr:r1oLaAnqvok5HSp0-83xQhYqIn57wRwaNMSrLwNIZyTOGS1rKeXLhyAPHHjbk94lwV_QanV1_M0rRS-_0eLguwOj5YzRmovWLwYm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r1oLaPwnvf-GdFHrrFGSUXmK8b1H7rNLxa40z5nM5fGcrlKou9DGaw>
    <xmx:r1oLaKQyCnbkhp_5fNaPd-fRyCpZLWYXOVWa0-GRf-qjbXaFh5jw-A>
    <xmx:r1oLaCaE7dP9VkF9YfiRLld_zna-0hy-f5Fet_lzLDrYx4QSCWmpEQ>
    <xmx:r1oLaLT5gNqSvwJhWIte6hHZmtrUwL7HE92vGl9KIwNW-0x-Fd7ZwA>
    <xmx:r1oLaDD-vE3WP2SbgKXVZefzQN59cuEW4pWiKxNhEc3-rD5Yoq9Gyfsw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 05:49:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
In-Reply-To: <aAsNUYUKJZbrMCf2@pks.im> (Patrick Steinhardt's message of "Fri,
	25 Apr 2025 06:19:29 +0200")
References: <xmqqfrhxtdg9.fsf@gitster.g> <xmqqmsc5rw94.fsf@gitster.g>
	<aAsNUYUKJZbrMCf2@pks.im>
Date: Fri, 25 Apr 2025 02:49:33 -0700
Message-ID: <xmqqh62cwoya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think it would be preferable to only handle failure of wget as chmod
> shouldn't ever fail if wget was successful. The same is true for the
> other downloads -- let's be as strict as possible but allow failure of
> those actions that depend on the network.

You may think so (as I thought so too before hitting a snag or two) ;-).

The thing is, failing "wget --output-document" leaves an empty file,
and an empty file does not still cause "if type jgit; then" to take
the "else" clause, and the invocation of "jgit version" would fail,
taking the whole thing out, due to the "set -e" thing.
