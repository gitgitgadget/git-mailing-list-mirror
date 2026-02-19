Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288B2E9730
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536886; cv=none; b=QHro4vCiADqElnn1T7fypFEvUeIlU74lLVzX+AtIpIJW1HXHNBc8U1X5pxp5J1nVvBI2v/IsjZLUEQ9LtJulmPKsok5o3/ckkxLRGg40PB6crLjV8A2XteJj/nppyp+hyA4KBUrAxkbSM+dQzIJLo+X1t9WhzmeUaZ1WwxXBP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536886; c=relaxed/simple;
	bh=LvxNRhQY5T9zbWxSJuCAj9LdJSM8xOL9IxQYQ/AITyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTiQAmWu+eh9QSnNeNdm7nSakgBX1fMHXPH+69gH5nbKA+yr2FNURRspzUN5AfrIUdkB2QIi6KRxCuHR+mmqyLG/VyuK5KufXpjmsJSlWjoLpzsqE/GYcOAVfSDAie0BZyKHEqxz6xYZKK2MpCfKXUqKVEjeyEMxRJ66+GyFKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kc6YXNYd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gS/tS+UC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kc6YXNYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gS/tS+UC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B474EC0031;
	Thu, 19 Feb 2026 16:34:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 16:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771536884; x=1771623284; bh=WFeI1X5c2O
	mrhs8ZZVDjZDXZQnfmn0bSsamxImY6xG0=; b=kc6YXNYdsXU4I0s4dfHBKiBa/v
	jSKKs+u9rg0eY5m6AEc8j9BKsQxETszuPaj7Sp1yaCwhT6HsOga2HnNRCUOtgZAh
	UpqKrmpztvfP13JxtyyqzQFSWRdffQVBfFG9WqMo8tC/vq0Y2Shgl5V0FyoT7B6j
	nsYZrWngSXCiyBkZHG2lnHdKjcbftbyCK2o/EkGP33nI00D04XYYD4xCgcAy3yVH
	btelzLkvBhijR8VXTIS031YrFXTq1zSw3tqxKcB+2EleFHW+VOQtstpvS+WWK08G
	QmO8JDHBVpGSM+gpLbpsBFeRwpaD5D4jNiEx9vieuJoPPCHhzoDtBwzmIjeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771536884; x=1771623284; bh=WFeI1X5c2Omrhs8ZZVDjZDXZQnfmn0bSsam
	xImY6xG0=; b=gS/tS+UCIJieQx0YsQh9iiv+eJQmeYr66Ggp9j2Itl3L3FGhGQ6
	cpIcHS+hVluC3sPj4ouU9Q3wfz4sXaHdbIYGQpatARt/ubI7w1B+nu/CLUNPJ+vx
	LRl+MkfdDBEaTcYWKD/A5RDGzqjmvElCdi7XGRY1HXQdD7M7mYmK6I4vzUeEXrvU
	wBVzoLULrmeqjChOuh4WcfSUcEBA31FscMl1XLjkZeKsJn9xa9LPKA6XXKYFw8SJ
	LThkvoHvJUtL+p9+EsC+CdmQ/QDhOdWCb8T+TjJWt7vDDIadfBtZLwSgQGzpZlms
	dgqZ/Sdgks32IKC/hq43KJxHnqe7WMxMYpw==
X-ME-Sender: <xms:84GXaaZ8Wvlk0jsS0FnVH9GrCR7EuPJBBefTKF96Upj-rxXJs3vdfQ>
    <xme:84GXaccx9eKSPaXNCESmbCbb4mqJIWjXwq6K8yH1XYt37UzgSgkllnb1zCSIrYO3S
    bVBKGpUNqhLsFREsxA_z_2wWZb-0fusf853MHwTW6I2aGT4SxeeSw>
X-ME-Received: <xmr:84GXabK5H_aC3VlHIOgdS4BBunIWQ2NiO-32sPNCklKgufD2oTZoHoYTvmzCbHYWpubNEcnrE78G-xvzg7g8tcbG0NzQsT_Rtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:84GXaZIaWU1Td20eKn4lXt2cNsH2IGw7cXnJheX4UjufRCkN7tU8eA>
    <xmx:84GXaaUKpj8FuDPaXRv2qZvZoFIAflYrm6KjvgCwDHIZpcz3ejdILw>
    <xmx:84GXaSnEFg73PI9ae-_DGVtJiRZ-kq3DeC6qGtPTSsKpfkT18uumfQ>
    <xmx:84GXaQmsfVrJg8nP-b8Uv6g_2DQu5vBOlF0ri1JJEH8uJS-OSjZbPg>
    <xmx:9IGXaSf1lsvcla0hZFDe_urQkhQYs1zbmoQq8MeEBSwvAoc30eprtTRS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 16:34:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/8] Specify hooks via configs
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 19 Feb 2026 00:23:44 +0200")
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
	<20260218222352.55393-1-adrian.ratiu@collabora.com>
Date: Thu, 19 Feb 2026 13:34:42 -0800
Message-ID: <xmqqcy202z9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> v2 addresses all feedback received in v1.
>
> This series adds a new feature: the ability to specify commands to run
> for hook events via config entries (including shell commands).
>
> So instead of dropping a shell script or a custom program in .git/hooks
> you can now tell git via config files to run a program or shell script
> (can be specified directly in the config) when you run hook "foo".
>
> This also means you can setup global hooks to run in multiple repos via
> global configs and there's an option to disable them if necessary.
>
> For simplicity, because this series is becoming rather big, hooks are
> still executed sequentially (.jobs == 1). Parallel execution is added
> in another patch series.
>
> This is based on the latest v8 hooks-conversion series [1] which has
> not yet landed in next or master.

Thanks for a reroll.  I was a bit concerned to allow configuration
files to speicify hooks as it would reduce discoverability (i.e.,
today, we can "ls .git/hooks/" to see everything that potentially
will be triggered, but now we need to be aware of what your sysadmin
dropped in /etc/gitconfig to get the whole picture.  "git hook list"
would solve that issue nicely.

By the way, the discussion thread for the base topic hasn't seen
any activity in the latest round after it updated for the comments
received in the previous round.  It appears that it is ready to move
forward?  Let's mark it for 'next' in that case.

Thanks.
