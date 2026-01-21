Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5D4ADDB6
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009205; cv=none; b=RhG5/aFO2SJZRCjXOE5RZVgJJLJQBKBHyC1NnjHTo7RulIxWfl1Pn6jXCiZP7xkL1gzOG8D/4IQNyGKhoKHif6n93aLnKlGIBd50Cdw134iA6E8TTYxKUR0o+uZeeR03nLYSSPnM8POZ/KQAk0atioaImxH+XHfLF0WPFl3KBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009205; c=relaxed/simple;
	bh=tTZldkG9EjaAIwtMKxzkyAMhodi9O/MAT1sU3iIJ8Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iOh53x62gtMLyCrdSKcUn553cXe7B3e7hl5lcGFaARVBjNKRZ2MkVq9IyyFRb/3qJ7NW+PwxYgDOPCxqtpIo/lvIfdPRJufC6kr0L7XLFVj64kpx5gkg0AJF6FUodDq+ikDvKZZbjOhYaA9UwSEIcQbPUrK8f7d0C0xK+il8NIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o/7goSOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0arM0+X; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o/7goSOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0arM0+X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 534D9140019C;
	Wed, 21 Jan 2026 10:26:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 10:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769009202; x=1769095602; bh=aXxx6rrzbd
	HMzJYT4r+7rxMIg/mfHHc7FJN9m4JFXXk=; b=o/7goSOck3dmoKdpxFbgxukytZ
	ur/6uwdUwiHY59++T2RlfvMQxc6meWjr3tVhOM7m1e4jnS0vifJ2AffDGTpV3N5w
	k8bdGrboCld+I0mqo+ws4gHZSPn/9WfAnbEq/VTu4pGt86t0p+h3wxLTlFl34SHQ
	RJ7ZEpt5WAZ4upCJLAOqnkhZRmIT/B/QlUsTthcKM2+gUd66G/dsJ8Y6E/r+6QPc
	dqj5FovBntrOcpmOm05t8oem0jKUj5NnE+/XDqCJgl/hgT/Z485PA/VSYXWquJAZ
	J20GwPI537yqhZvMYEEvV0TT9PTDjhtzPoN6QP1iZqDClG0Q0oAWo+o1P3Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769009202; x=1769095602; bh=aXxx6rrzbdHMzJYT4r+7rxMIg/mfHHc7FJN
	9m4JFXXk=; b=B0arM0+XEtRf8qtCSGmH0Ovsd04kKL4azzBPOC6U+5SGDEIbOcm
	R6aY5PWLIq4sKl02YWyNBlRzdogdWwxV9YXM+iCcp4v13OewgIm8i5xXfvNHj0xp
	69E5uiOXvGIvAi7joXDOI4zbtffGCN9rFTU5+3sIkvk9HfYUCQfe8nqbxBqTkdHp
	4rdfyjF1uAEplZnoF9pLcgRzgjhDs1QD5+c3H1Osol2Y2RNlgMuiIPKLVDKnDGSR
	sHXJjPVoPaRHnVG/Q+Fr8EVwXeUwQXENg7GchDX8ufPiYymtY4KsuoiSuRk6hXe4
	0cP4vw4hnJd4bzn0YGDtz49QbaqxSE4OD2A==
X-ME-Sender: <xms:MvBwadehlZ8uaIvWXI6zdLUieBUUy5sl-04j1UcVurYFWTKJM8EowQ>
    <xme:MvBwaSoKI7iIgp8nlFOvwJtFwId_-vIcDuqn-AEJsCifJrOI6OAMPdJ5s1gN5eh3w
    l_KOZFdjvIGpUZxjiSw3zv1NZv-OWI6ueUBBOBKnGhxs2tG3pUr>
X-ME-Received: <xmr:MvBwaT4YQ-EpXwKDICJRLs6B1VRbll5pImllm5ArnkeeD1aiFruTClgBvtP85CzhgKOJgYC1G0evUFICGj7f2H0gNcN_UeufcDXj1m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MvBwaQqKSzdX-otnGSFM5OpXh59l2zFhtotWDDZGbRsAHGbh-sZLBw>
    <xmx:MvBwadg9yMDwOkiHW4mOSXpPvMBNKZz3jgrwOtFbQYnCW5G0qn9lsA>
    <xmx:MvBwaSLmg1q8jQfYNK9AFADP_21WKhdZH7HkIBD6hplw36WAGMzzCg>
    <xmx:MvBwaVCSFhzKZkpzdB60ZYtKi7JDzylxup_Fy7pa9DJVtfSRK-Ud1w>
    <xmx:MvBwaVOtmqahoTKius-pvxFkQCk795Wo3oFj9oWwVwvuUJOP87i-wZRV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 10:26:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #06)
In-Reply-To: <97d8645b-bae8-7f5c-8e59-0f4f0efd92f5@gmx.de> (Johannes
	Schindelin's message of "Wed, 21 Jan 2026 11:08:45 +0100 (CET)")
References: <xmqqa4y832ok.fsf@gitster.g>
	<97d8645b-bae8-7f5c-8e59-0f4f0efd92f5@gmx.de>
Date: Wed, 21 Jan 2026 07:26:40 -0800
Message-ID: <xmqqtswfvvf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  ...
>>  - Merge branch 'js/prep-symlink-windows' into js/symlink-windows
>>  (this branch uses js/prep-symlink-windows.)
>> 
>>  Upstream symbolic link support on Windows from Git-for-Windows.
>> 
>>  Expecting a reroll.
>>  cf. <5fe64b77-d10b-b66e-8622-14bec1e96f4a@gmx.de>
>>  cf. <14388349-d1b5-fc8f-b6c7-4a7b43e64494@gmx.de>
>>  cf. <704e952d-7924-00ce-b8b0-ad355e659335@gmx.de>
>>  source: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
>
> I do not quite understand.
>
> v2 was sent out on Jan 9. The three replies you are referring to as
> blockers were all sent out on the same day, as replies to the respective
> reviewer comments in v1. Naturally, whan I did sent out those replies
> acknowleding problems whose fixes I promised, I did not then go on and
> omit the fixes from v2!

Sorry, my mistake.  It is very possible that the references may be
stale for this topic, as I can forget update them when I queue a
newer iteration.

Will take a look later today.  Thanks.

