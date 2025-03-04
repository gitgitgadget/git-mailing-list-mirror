Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5141F5851
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117326; cv=none; b=swYQpRElFniJUOZ/c5W7sfSc0WtU9txxlvq/sAuaBIIKvXf9G9a8wN3+W7SVyBzHV6ClnCJ7GuBGlWCFQNGczNf2yAtPeMm7UP3lrcxOgA6a2KmyYs5ZRrO+ZHWATfIF4GMRc0iJAJ62/VB+KDSc1zMG40qVUmemUUzBX+y9jOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117326; c=relaxed/simple;
	bh=+9LpRHyF53zYczMldkpsRZtMIuOzgjBHb8nb2D4PWOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pcBfBMfmVzg9mlAIAO7O8gK4Od06vR3N8aByeb4y9Yn1QScGQ/Q7HAaLIIgEgUKiHrgAggcK+HfgD5nG1KUB3HQi7owXrCwY9AL/291Hl2WYj0uyD1iDGeHwANLeNJKg9R3kNutkEq2grbgWSZxDKwTiZaUvuxdNnv4a7tmckDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fCmZVM6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZ5GBkha; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fCmZVM6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZ5GBkha"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB76311400FC;
	Tue,  4 Mar 2025 14:42:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Mar 2025 14:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741117322; x=1741203722; bh=SQ5EtVKGHd
	2zPuKDj9k7IeMFNFg3gnwN9ZK/aoGVCtI=; b=fCmZVM6V0qen6F7aOe+POu7Ldy
	r41TRulLJ1+xk9xunmX6Do4Py7womlWbvHH90xRu73wkOpPoQCOOKAmv/tpCMFmy
	pvxEkEut/QHAqwkqWgQP3M9/ojHgjL7S7S8s9VYON+Mzp3rn4e5PQZWvOZlfvlra
	q5Rgv/mMCkw+jE3NsiwZc1jLPQ4GJz03Ji5+lDYaaY/ZGzKugpi9RsYrNJ2wixPd
	LhEDB6lOqEBXviLiDE7G27bdqEjA9s1+Tr6PkxKrHzXy7KM9N+o05R0qnbbuUfNp
	CY3keKYBHCsZ4yLt7g2Ct+2egFOymOZs/M9RW3zeFzottFbmTg3tPmK35J/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741117322; x=1741203722; bh=SQ5EtVKGHd2zPuKDj9k7IeMFNFg3gnwN9ZK
	/aoGVCtI=; b=mZ5GBkhas6vvYVW/B2C58/eVMbidKqdmyZs34TgyIxA7UJP/Ymi
	DkpBC41uFrg35rG9x4m+PIXFh5bNdN024Ck1xYsxrDoZzs/i8jvhH6+b2DZT7hNG
	pZ/7kPXiyTipIPFyLUkcc6eG1WhnW/HP84MWv0ur+xjTurTMYTvzSNYdl9WE+dhU
	7tnoLOX6wLJkru/XqtN9LAc8WZono7Ll/113OJad0K88UpVkIdYBPigM/1aPtXB8
	LfNp+dE++M5IEyE3FzvB8HWOO5H0qTlUqLsFwOPf4HaUrvFS1MS/RoPFTTSx/tvz
	Z2NUzeujvUDCFPF5k+98ufoylY504SpjwlQ==
X-ME-Sender: <xms:ilfHZ3uOQGzGvzo_s5YWExRcaf5eXpKmG5vaerZ_qgfyWlaodslStg>
    <xme:ilfHZ4dI2WLz_EybAgvNSkYMKCSkWY0E0GIZv22l-gHZnNtsWonaEXCsa6XOhEZVW
    GHCoRL3sp2r8qqsEw>
X-ME-Received: <xmr:ilfHZ6yDgTNhUKWUcbVYfLe5KPth7Os9BtCLgjZyUsbgHJoOhNRLWURheTwXmOkK0QRos9UzovqOT8d6TZsXIR_EzZfE6qS-l5FZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdfffedvfeevfeeiueehfeetfeelhfek
    jeekjeelledvgfdtgeegheefteefhfefnecuffhomhgrihhnpehfvgguohhrrghprhhojh
    gvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:ilfHZ2ME5RnGOLG976_wG9bkM5zIN0w99Qm6EHnH2NrUbriFG4hV1g>
    <xmx:ilfHZ3-U--lqfV7WYkbu9dENSFZij015OlqKyHYvRUu9sORkNqo-_w>
    <xmx:ilfHZ2Xwgi8EzuE0whFyDvP6rPlR_c2MJyVBVN-eOTaLF2ntjBgL8w>
    <xmx:ilfHZ4eqdIRl-FrMkdvkY-GYA4YthBBsAkj87L888A9WXk-Ztuxzbg>
    <xmx:ilfHZzZjaFz94MjbGAFeQeDSKH4JXUob9fMWMtpe-5VXU5WPOl4ipI_p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 14:42:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.49.0-rc1
In-Reply-To: <Z8dIZmscTdi8dZAY@teonanacatl.net> (Todd Zullinger's message of
	"Tue, 4 Mar 2025 13:37:26 -0500")
References: <xmqqjz94r8p0.fsf@gitster.g> <Z8dIZmscTdi8dZAY@teonanacatl.net>
Date: Tue, 04 Mar 2025 11:42:00 -0800
Message-ID: <xmqqldtkoa5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Being a new command, perhaps it's not terrible if it doesn't
> work on a less popular architecture, but I don't want to let
> it slip past without anyone noticing.

I tend to agree with the early part of that paragraph.

Thanks for caring.

> As I mentioned the other day, I don't have shell access to
> the s390x host, but can run the test suite with additional
> debugging if needed.  I have the test-results directory from
> the build as well.
>
> If anyone wants to poke at it, the full build log (which
> contains the test-results directory as a base64-encoded,
> zst-compressed tar archive) can be found here for a few
> weeks:
>
>     https://kojipkgs.fedoraproject.org//work/tasks/7999/129807999/build.log
