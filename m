Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776D209F4A
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402806; cv=none; b=tf5TNEYgqpRNZy8Vc4rpw1+L+wommjfuXNZCvSEp4ZAiEy0j0LlQFtx+Fx9eTCT53O6tUT0EWZXu1JwhGeQIqEOd4RxmA9NqzyVd8WO0/4WgBuKyoRMLR7fHCuore1MnCVkkc7F5RIHx4w7YFtmPV6u040ds1k7tTkP7h3XBlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402806; c=relaxed/simple;
	bh=UiPt+PcDBwgnVfG5DRhHd65zxyYYdgh5RhC8QbeDylU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2TEfBo1q3tC690BMtsIXIruqBfSOO1+CjzcBgsXHG1cYCjd/MBJur6BL0mR+nCFO9s1bpZZX8znMQrCZEq2fW49jr92BuNtqd8Qigb6TsgX9K+sHMWvh4i47VdTihjFuiahUr2u0MVN3kuDjCuQCl0LMo6t1Ox84Ey8zzEmwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WYrqqhYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UuUyE0aX; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WYrqqhYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UuUyE0aX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DF4C254015F;
	Tue, 12 Nov 2024 04:13:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 12 Nov 2024 04:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731402802;
	 x=1731489202; bh=NpxpoEF50PEDCT8YprEGZOQUGQv+lGvZH+lxYTSV52s=; b=
	WYrqqhYvoujOhw9GebfkasaifRD2UoSr/3TM4YHhBSHR5Bpa7hSyP8AtsoC5i38V
	7SrGB4d9E8IlOXq4MfBNsY7G9Kh4LOpkGzwGflSKQK4mHILctUDDD2hoOs3dWiOo
	RAw0unApHtRUtodXypb9hxN708ItnoU++Z/pUgBnPAZLwtBP44DE6Cuu2fuScmOu
	zoBiozJ/x7f40TqKpd5ruZUYCkLb2V3E6zVAW0FAz+Ou9cjeXiCvD2T4gofyrm6S
	04kDS7N0eE2GyJ+lEalZLIa+4Me8lTUotQc3LarOkzaZWe/G9KzjykhE13JodEoE
	hRLYnvoDPkg9rZ6KeA2iMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731402802; x=
	1731489202; bh=NpxpoEF50PEDCT8YprEGZOQUGQv+lGvZH+lxYTSV52s=; b=U
	uUyE0aXSSmD64OVF/2E8mV561I1muV4Q/5KJBdDf0JOcGfqgn7Q5eSui7lSC8jRm
	OAYm1T1V8632kxo/gTn7CNEwel+ArcXpXczKhBnk/snndPLo9+XzCT+xEsvzpZk1
	YZ52zbK027RWQ/RzVC1mrbSSt0AVgv3jtyhy4abNaBaO9g/kCHFyUqxBHXakWnd7
	FYeFQBC7B/hOLdNN9SdOVuJ7F44aVfOEeKrQuk1PLAKECNmvUHPB5iIPbI1qEaGC
	/n8HsIYbDfOwzkliS6ncoaywbZHb3tdbMiCmSmeaN7ogaQ3uXS3iGJBLtKPMU0YC
	00OQZD5lZMzp/0F76fGvw==
X-ME-Sender: <xms:MhwzZ8X34EyKiyXpvsKb55QKr6q1pgIGNQYCwoZGbwL6MM385cYl-A>
    <xme:MhwzZwmZ9mH669uhkCAsKzy8WcL4lMD95AlXKf1EzM2cxWzU7f9VbSkSYSGTCapNl
    9xtP_ONIL4CTQZ7Pg>
X-ME-Received: <xmr:MhwzZwaXKR3L3fChMuGG_vUF8htcFq6s3f4fqgp3JIrtTcQSLFydKkPefQmDWohhg7Pa1WBYV7rqUKiy6EtsgBxcWVFwNLq-2orA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MhwzZ7Ud0HpCktOMlguCIZFEzQ2-K94oRHjfKzZ22aIIJabsf7QkQA>
    <xmx:MhwzZ2kIbdqc7rUGgHpdzhkMPtr1JJw5IZ9Kz6ePS7Xw_ZbMS-rNqg>
    <xmx:MhwzZweHrUWIw6WYVoO3v3PMN6ZlnE4e9fxcfvRl7PNQ5hVYWR2ybg>
    <xmx:MhwzZ4FZRJFCnkkoWWoftTaTJJAcT4sKj4uRiBXSFdOXvVQSc1hbzg>
    <xmx:MhwzZ0bYvxfcULLLu_VbgHHVezcwQ6KurF9nAlqSbWTo8w43Tf0S2g12>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:13:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 1/5] doc: git-diff: apply new documentation guidelines
In-Reply-To: <7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Tue, 12 Nov 2024 09:40:13 +0100")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
	<c104bd50b646646e980905a9294209f381b9e61c.1731343985.git.gitgitgadget@gmail.com>
	<xmqqo72l8egu.fsf@gitster.g>
	<7b42828a-2cbe-47c6-b21e-b8c1e3a2ad01@free.fr>
Date: Tue, 12 Nov 2024 18:13:20 +0900
Message-ID: <xmqq34jw6ci7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> With the new document processor extension, the back tick quotes have
> become smarter and they behave basically like an inline synopsis
> section. Here, this means that the line will be formatted roughly as
> follows:
>
> `git diff` [_<options>_] [`--`] [_<path>_...]

Ahh, yes, it is the key magic how your "enclosing the whole line"
works.  It's been so long since we adopted the topic that laid the
groundwork that I forgot ;-)

Again, it is very pleasant for us writers to be able to just do so.

>>> +`-1` `--base`::
>>> +`-2` `--ours`::
>>> +`-3` `--theirs`::
>> 
>> Why aren't these `-1 --base` and instead mark up individual tokens?
>> 
>
> Here, it is quite awkward, because we are mixing alternate spellings of
> the same option (`-1` and `--base` have the same meaning) with the fact
> that these options are meant to be alternatives. The latter meaning is
> not what is usually conveyed in the lists of options, which blurs the
> following explanation.
>
> To clarify, from what I understand, it would be better to fully spell
> out the way these options are used by using the synopsis syntax:
>
> `(-1|--base) | (-2|--ours) | (-3|--theirs)`::
>
> Is it how it works?

Yeah, that may be a more sensible rewrite (regardless of this
"better mark-up" topic).

Thanks.
