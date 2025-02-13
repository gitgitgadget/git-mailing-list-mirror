Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5635961
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 00:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407369; cv=none; b=Kzy9Y+sxIjgbiJrv1JWUnDAvXaxJNtZFO853+54RUTSVK1I2JVmv+6hRtLvLrmgtg/K8HpIfvKF7O5bqrI3TDdfnAUejA1BurP7jJ4hLtzH2a95SA8t2K/xs3ncc1PY71+gFXD33Rs7vp9WN6bPMiJJjEtrSl+ITCDt3Ittfi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407369; c=relaxed/simple;
	bh=sAPoI7Qrmx8SioeaqwnrgTpN0JAodfYxuV83juCvKjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DFnEVec2KdVe1a4cRWsBgXKzTxYVO926yPvzNhcD2eWs1KpdLFjmo2saKL/GUM5EQ0e2exvaAOJE6/O9xet1cuWZef6cOvZXOHiN+cXuYYTSbPqRRgMKjqSRs2Du3Qu5LuDP8SMgvEViI0p/sShi01zUXpzAcG8aq3fiz3vzdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nzYH108q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcz0QXtj; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nzYH108q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcz0QXtj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 42C871140153;
	Wed, 12 Feb 2025 19:42:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 12 Feb 2025 19:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739407366; x=1739493766; bh=sAPoI7Qrmx
	8SioeaqwnrgTpN0JAodfYxuV83juCvKjM=; b=nzYH108qtwROyScDCSavQ1LDXg
	kYbPVthfmsMAwaLp4NBSKiXjUwdIl/097+vGfwS3i0Ce8avLWoKqBjfzdejtEq1f
	L7KcFmG5Cz+PlIBJPof0QfCu+0tVNkhC4o8Kbs+Iwala1JF8IYuOUWqE4k4BOIQr
	m9ECHmPMW7qxRHQGhMMNgkS7gG6i14rgQnduKFl17x2AFwHqWKhyTXWjVBnZyOWD
	Qz6PajFjqj0rXRd0n/oLYNQqe6+0iA7n+UsbZrMlgIjPOZ5ScXNXgAo63STMQOBh
	HwWItDQBULgjhJ/L6qB0fZkit8qK6AHJ0xvZXfmRSSR/bwdsE5x0yJGNCxZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739407366; x=1739493766; bh=sAPoI7Qrmx8SioeaqwnrgTpN0JAodfYxuV8
	3juCvKjM=; b=gcz0QXtjDwY8kga354LmXt8IikDQmnQhWhFYrtK806pAH6IPtvp
	T0YqSxNV5A8ioGB9T5fk/PHH49iD8fQHOrEIMbZU3ieVSVDy9LvHIOOHR5Wd58cI
	8/LqVxW66AHh1rc2pIlsNl4LC3E7WX7xQ/qXOJb2Rh51fLtLkCiPnZBNgudl9oLw
	bnBV8t2+TunpcCbbADGLQxVnPQ0cLWuMkOU7mxKbNXjlF+teRGDXiyJ721+EGBtJ
	qCNYE8OIvCvuCHzF1c6S7ke4obd5m+7JOa8DhA52WdEWFdJKHDdvW5wg+5ag2Dye
	quyu3a8/snszi9ZixCvgTj5hdUSG+ihdjzA==
X-ME-Sender: <xms:BUCtZ4p_WawMbEVFHDiOAo36t8mzx7qd56I4phmc93LbnLdHBiE8WA>
    <xme:BUCtZ-pl31GI1vC9U2dx6Wx7zwpw3iL80EsudXrf5U9p5hcuHoMYx6cRblJvTyFH5
    0By6a8esaJLC3TOVw>
X-ME-Received: <xmr:BUCtZ9P4xmjFSwRwDAdVu-gPtTFCshe8SXYhzSEt_UkboM_WSEt8vtb07mjiIjnTY5fUN1Yrf2UYnLKojJFwAQ1ixs2XS9KkHKgFzGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfhhorhhivhgrlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:BUCtZ_7vrAG8B5CjQ_TeowMDLmx0_G1HfByTwZ_F0ZEUrsYBQoRTyA>
    <xmx:BUCtZ34nrNTLw2yqbpgL5geqU3xYq7E4u-pNxvAA5bEjpLczvh6zKA>
    <xmx:BUCtZ_ig1mWwDQ_WjQPe9pW2jprGjGoFDfmXNalzK0qn5eyxPt0Uuw>
    <xmx:BUCtZx7rPhi66IQRbdeVtJ62ZtwcW2YxMss8HxGJ6lbCfb0Y_a9ntg>
    <xmx:BkCtZ5ktJaAyF_ex06snrNosNNOlInnay4YNWFkjlW9Y2OXWgHWomLcq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 19:42:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Klassen <forivall@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: fix missing null for freed memory
In-Reply-To: <CADY4h_o_wfUpjSBhWa9TPU_G-G8qpENpUeOKGQDY8dq6Zb2+qg@mail.gmail.com>
	(Emily Klassen's message of "Mon, 10 Feb 2025 12:56:17 -0800")
References: <20250208061702.88469-1-forivall@gmail.com>
	<xmqqtt91dbzt.fsf@gitster.g>
	<CADY4h_o_wfUpjSBhWa9TPU_G-G8qpENpUeOKGQDY8dq6Zb2+qg@mail.gmail.com>
Date: Wed, 12 Feb 2025 16:42:44 -0800
Message-ID: <xmqqh64yr7y3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Klassen <forivall@gmail.com> writes:

> Awesome. I'll also add a test before re-submitting, as mentioned in
> your other message.

Thanks.
