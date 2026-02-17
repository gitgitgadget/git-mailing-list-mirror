Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D92F5A22
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368232; cv=none; b=Wm/zwUwnZgGSEy7mKGPhZk6jMzyut4f2GfSPTwAvkGKSm2sMocbOcDthjr/7OnzQgCQS+bZHJdQ5H1FnjbybOPWDe5S6PaoEB7+W71oIJvCDVWjjiXWyCxau85NVFKtqhUB8L9pFyVGuJ0pUthIlWvqxk0AWQYYm+JVxX1VuFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368232; c=relaxed/simple;
	bh=tkmNwf3hXK0n83qgDCsNf7SOe7fOVc692IhGXJ3Bd2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSbq0f+RRNL2sXfyimSgbDzmn+fG15u4mI7nRHw5kn9ipo8BGW7xD7BUUiZQtNkzLKcztdFTyYJtYYiHjC43FcyTgsF/L6HySeqQlZWtPiWtqoXB4lUrIhsv6LaG8GYQ9TlGB4kHSc0906JUzuch00FmFtRzFujQURlMnrYrBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TSy+fWXF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPy7hGrh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TSy+fWXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPy7hGrh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A12E7A00B6;
	Tue, 17 Feb 2026 17:43:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 17:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771368230; x=1771454630; bh=9EbpnH/I8V
	5tmO5jaK0kKlR2nYZUngTa+0C04yR7bvQ=; b=TSy+fWXFCrsH1I3xvt1a0duzYY
	ZK4YTlIw/NSTdNzqTYprBwmSy39UqqQaOkQj6+jbe5xfZk0knHEtW3dMSR2UvM5k
	5DCUO1SW3J/uurugHR7SvO7U+yCs/2AUNFMRLNep9k+XQjJZSVBI/4g6mXkEgltX
	BMQ9Em3sbWtaF4owGn7GQXCkD84d3QSvjyJqaO8tJBGtKcLkXnBbQUKkIgXqYlph
	HjrjmEV+PKRPHYEAboEdWpCd/fGkz8ZkwBEH+ilhbN0zA6xdDuRwR5FKxnKeSxNd
	5PYO7aXY7zJMeKO5kSvPvqzBF+c3hy6D55u4YU5seWT56v4zpXei4y/TDE/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771368230; x=1771454630; bh=9EbpnH/I8V5tmO5jaK0kKlR2nYZUngTa+0C
	04yR7bvQ=; b=WPy7hGrhcg+YLNh4WSmx6MivmIGNNz20GRod3a/S/kY95tyyNPf
	+iQBeFXNNamY0pvRRUf46UKZI3BPjvNIDHlM/Um+RCl3m0F8Z5phr+6epZb+Tj9J
	eUvhbyxQTA14Qc3fiIQGGcWaFRgRuNg+ns50XMwGwhTpqJdxPGE+EdPaMxMmzL7t
	LWLQwDHoDoxVsEmDys18JpnEs/CDsIhKy5+ibJpj4Ra8gJeM4Phbe6N+7iCYHr79
	nRrab5kaeYKgXIt1PxJDX9TXfj9ClRrxlrERZR8GDbjVSu/RJg2nogr3c4o2w86n
	2gcLvk+X2MT+sLDRVesbxm+E3wsE+o9pjvA==
X-ME-Sender: <xms:Ju-Uab9ps64ri--PqK0YQLmaY6mUKJaEGPkPK7EYzmCxvtmuI4TONQ>
    <xme:Ju-Uabbh6qghcW6lD_ZdPWW-pQG7U8q_8aAvTotp4m2ucFHEi9QJTkVdZsvo58DyF
    OA-ssgPLGiqgUZY8DiLD6lYqSo-1_k2vKBVBJiI2LJeraJJq3wiyg>
X-ME-Received: <xmr:Ju-UaS35ViMqOi3LXA92WW9dBtfzEzyC2FOc5mTrN7K2gTvhr6QjpgYo0dqoouaymVQTh4AqcA14Jub7K07VYC9PelFUAd5eYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ju-Uaeb1T8-LsH22PlsfLSPHgbM3RLsJoCUdYzdFkmAnZTNBLfx_0Q>
    <xmx:Ju-UaSImdqZ275f9u5lpDZk-E-fdtBJM3hdqmsHc2BVVxxY22gcQBQ>
    <xmx:Ju-UaVHnGDm9dBGCrG4anxNsx5jbElaCmxzKojzmrVv3Pc7b5pJMPQ>
    <xmx:Ju-UaRu6ITrBLe78cM5lEKvlG16zOIMJQ9Zqqw7r_AsgDYfhWGT1qg>
    <xmx:Ju-UaZtFDT8ypIVcbBW51tk_F8XjR6hzx098oo62BEfj0fDE0m3QZzPM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 17:43:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] format-patch: fix From header in cover letter
In-Reply-To: <aZTnmXcLm1MNcIxO@exploit> (Mirko Faina's message of "Tue, 17 Feb
	2026 23:13:21 +0100")
References: <20260216152730.37478-1-mroik@delayed.space>
	<20260217220515.14127-1-mroik@delayed.space>
	<aZTnmXcLm1MNcIxO@exploit>
Date: Tue, 17 Feb 2026 14:43:49 -0800
Message-ID: <xmqq342z9eje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> I'm sorry, I forgot to mark as v3 and to change the sender name.

Heh, the sender name (as long as it is clear who the messages is from)
does not really matter very much.  Thanks for working on this.
