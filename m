Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E218FDBD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861168; cv=none; b=IJqT9sbg0qmF5a3ebe5j1iDG8sO+6cLV3SDeil+j9t2QIURAZOE2bDPx11/d47zDHJam0MuJzB7DhVUuDo34gGDPD2x/Nx7Gp4ZNTqtsSMQC6ToeLWfA3Pyw93FmPidoKPUYFkn+LT8kshHzriFZGbS8qMy5Hz6A//ccABheLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861168; c=relaxed/simple;
	bh=pjuxgfHNaifrQPoldjF54eOH7KgBDVkXyoHTMG5ognU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ml7fDpeUAdqYq1b/7Ay6t5NGv8FQlfYCYHRyBZlp7rfbSLsMlPWWj9ReNlWC5ztmiXn7ZAJ6PRREpIQePE0c4dtivJIjUUA7m8X7K7GD7magSNcLHI9z/BZ8llz81zb68jl78mO4JmGyNLYLbpej84/B/mTCHL5r0pIiXJmPuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jqnapNHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTeM/rGx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jqnapNHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTeM/rGx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F4135EC054E;
	Mon, 23 Feb 2026 10:39:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 10:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771861165; x=1771947565; bh=gsPSS5efUr
	YVADaBVHOYjVLwbpx5++uMfL0QHJNOFlM=; b=jqnapNHamhQQgmwOltnT6ALzul
	mESMPtA65MRzHTPgKyJBMOIdEjQNcvoYYlBZx3e3edAqObbp5pDNiJaAhlJQfRJa
	KSsN2ScFif+G9H6M4DObwQafhbMUtkXEoIh7TSNln6RbrFBpElKC5B2kQYuv3xJz
	1g+XXVGsDk9IIpPt6f+q4dl/xD/kinm/TZhm/VmlKRN+PR7eCL52nexnDM0WI5em
	B/uuf1aDG6ZphYBq1E22fisy8V2NCbxgoFo46DpJIRBAHSXZhKePoEMA+Y1I3rxx
	ND96irk/aZZ2QnCLEIhKRQUwvC8oISJxgDc9a0V4el6laRrSb337L+TVCuYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771861165; x=1771947565; bh=gsPSS5efUrYVADaBVHOYjVLwbpx5++uMfL0
	QHJNOFlM=; b=jTeM/rGxlU2XKl2wGhqyCrcwHNGP3tIxk+qeL6wj+mBH0Hjxard
	8Uf3mqJ+igrb53PtNS+ghJ6ZWXV+zzNNxLRmzIKrWz6JuP1/Iv292dqhZgsezAjB
	cgvOQ5Hh/5lMRJR0yat2uY6kLsw4U+LeRKH3cs/Mtk2iemHJsRITWFSDXqQjchLB
	+IbDIJGcHkAH+HwtlrimA/fO+LRuCZ0LHpiRe3rXybb/sQuhfQJ8iDaG8aNeVQv2
	pen3hIb6magJziNAy0M37OcENOv+BgW2AWkvQQCxf532BeJgpYs8xN41kCys6MWP
	24bk2RA2nVK4denbkdzw1petnwTkHJkykJQ==
X-ME-Sender: <xms:rXScadyv5xnb7B6tbKMpTPnb8LEvju428VLpA2iQF9Iy4yy8r49H9g>
    <xme:rXScaURJpHmx8k1BTwum-13ov8CXwnd_w1rxpmsSwdMYnlAbS_xhCqdpXDs_sWfPL
    31Qo_58MCcv3koxYtTvb9k-WYTvQO9TE52cWnQkRxSGRmzure462Q>
X-ME-Received: <xmr:rXScacVXYFWYHhdij4SJPr3dvMx6jqh5zcaUI0maK6hiXsohKTJ_YEPUW1qsqZMn9ZIctoeJ-HrnOtuMYoN16fKLo05nyO0NfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rXScaeZqnIEVftMecMw0SK4tMIPQPs4ZY9nFFs_egXuuaa23z26yYw>
    <xmx:rXScaa1d7WR1tg3vFM__GeRMWBva-4ifvKujzSDpJA4ZQRFOUu_lBA>
    <xmx:rXScaYieTOtErU5mdNhqD1eCE0sMca6LcJs-AFyo4U90O8AzREK3EQ>
    <xmx:rXScaWbDWKO94a3Gcb2dbo0YszBqbzeLMJmQlDdr1zqs0jdc3di4BQ>
    <xmx:rXScaT0GEG4x3SKm4LeoudWf8zNxOTaum0LlsOfE1hJ0wmleH7_KxNJQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:39:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <xmqqfr6soxjq.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	22 Feb 2026 21:10:01 -0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
	<xmqq4in8quxn.fsf@gitster.g> <xmqqqzqcpatz.fsf@gitster.g>
	<5263825f-163c-43af-bac7-152d670919d9@gmail.com>
	<xmqqfr6soxjq.fsf@gitster.g>
Date: Mon, 23 Feb 2026 07:39:24 -0800
Message-ID: <xmqq7bs3piz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I think MISSING is more appropriate than STAT_MISSING.  Our stat(2)
> call positively identified that the given path does not exist on the
> filesystem.

If you prefer to have STAT_ there, I do not mind too much.  But at
some point, we may want to drop _ERR in those two new "these are not
errors" return values.
