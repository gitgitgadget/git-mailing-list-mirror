Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008429A32D
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159042; cv=none; b=YSuze7oOjrWe4TW8o9LoP2wtOPLdgQvgXeQ5q1gip+bRCABtRLskZOHOkRuK8q8rWYhmikGMfpF0XncuUg4r69VBsWz8fsJ7r+B3tl3VLfOmJYQQNTo/Mh2HQAWOtL/3dWzZM6XXc3fTtmuU0ODZ0k2poIqt4N2NmPvZJeetPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159042; c=relaxed/simple;
	bh=47o4V0cpnFjdDr+XFUmTwH7wCukLYEVLr7MAjdkiJT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhKXvYZP+FNwmAw/5nIKO9lginnGVqQ6lyM4qSzEkNATHoMdsF03s+PQvUWdX85WsHZyFtLLMQkCY+XLNc6rGrT6HkXBeE8ZVzUGoeGeOHuYHYE01j6szsT31XnxeWzIGDNeTpMmwMcVEqEah75Y114WCPAwdukdGwdzd+zWJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1BgKc+Um; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDStJK4s; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1BgKc+Um";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDStJK4s"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 477E27A014B;
	Tue,  3 Feb 2026 17:50:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 17:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770159040; x=1770245440; bh=47o4V0cpnF
	jdDr+XFUmTwH7wCukLYEVLr7MAjdkiJT0=; b=1BgKc+Um6VUaPzG4yXXWcVd2dX
	7ZeeUNX7s2V8MQ3GDezjqLEgUI4qPpQpNQA0Oax/Gui4Oao8ek/W1R9rsW7sVp7l
	dHROWz1iV/SzRKKt2hlHiG6iCC4ldTpPRZcTaaBZtcNs8Fp75M5/rd5hRTE81E7B
	MYLiZFpjI2jzlV0Jl/pB4rjWZsTq1r45LZycaLkSIf8+PuHZgwIfU2HTfrKDqhfd
	ayqXpUZnAafTlHxowS+Bom3RiydaFFZ2xeW2fD9cVbgSarHzEF7D/85uLM81/GCe
	PD/QwQ6jUcTkOCbMkd/xNY2HgY8I/LBEQkbaW7FmzyUIK+eIgeJIV0pfUHTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770159040; x=1770245440; bh=47o4V0cpnFjdDr+XFUmTwH7wCukLYEVLr7M
	AjdkiJT0=; b=hDStJK4s/U1LWWqUd+3V15B86v14mvapZriZ3YUsq9R+lSmQ9Dq
	zaW8CJRK5LD93pzQXYQq9rQuzSZhcESeEX5BWMtVru+rm8tPzqYhjLk2HRJVgNR0
	Q40gn05bgGZ8Wq1JtW4P5YyP1hGbpspFOV0Eh9uQ8lWN2xdCMIVAv36uaRS3FaRs
	/mR1sf0JR3YEAqFRYmUVAQGnTJsSNjLWo0neVSd51V46J0/cjy6ZUAnujg6kmaBX
	jldBueNdFtQ3RgT5kqBIi2uzJoHRhGbY29UmCteY0xGLTA6dwOy7exmm1xz+ixvy
	KCaUkdD0CIvDi8bTHhYWygXdIqHL257mPWg==
X-ME-Sender: <xms:wHuCadlvAgjDhsSkhBR4iidvF6Kx6ox7sONpIxmleauJSYEq8pbHPA>
    <xme:wHuCaQSNZJXFoNuGpXKQ4ABBJhwYql95LtKVjzUbVTdG8JZm9Sur9KGQqRb9f0rXZ
    yc9tgYg8gMPrvWubAYxRTztBufK-MtFA8rsmIzdfxqh5Cb8pRYehA>
X-ME-Received: <xmr:wHuCaRCrr55Wc_c_dIetSn7GDO5hzucteKQNXB7QsJsOQIBs48q6DjuNRA_piyayCnP_JSnEjM5ItnrGOIcLIoigYeKwxd030w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wHuCaXS5BuAXO-ayDvIpk38uyhcrBf0ObC5cw3f9XroXQZT7ZBXR9g>
    <xmx:wHuCafqpzGaaAeyHrooGVy7yK0v_iDMyExmrKaF3PrhTk1f4oUBfeQ>
    <xmx:wHuCaZx85C79kHl5Qd3b9AbwhCj13CRBs6q-6oBxQW3JvhG8WdFA-A>
    <xmx:wHuCaUJA4NTmzs0zuNn686kRYUXvJeyeJvwGRD7NVof7IPndQQ0-OQ>
    <xmx:wHuCaUQkXyZC1X_BirRh-O9fpmZTc63RVPh-pv_QbK7BPslsVNV3VaKj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:50:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] builtin/repo: find tree with most entries
In-Reply-To: <20260203221758.1164434-6-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Feb 2026 16:17:58 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-6-jltobler@gmail.com>
Date: Tue, 03 Feb 2026 14:50:38 -0800
Message-ID: <xmqqldh9qw5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The size of a tree object usually corresponds with the number of entries
> it has. While iterating through objects in the repository for
> git-repo-structure, identify the tree with the most entries and display
> it in the output.

All of these "largest" and "most", it would be a lot more
interesting if we can give not just these extreme values but
distrubution, possibly in a graphical way for bonus points.

;-)
