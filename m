Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6330AD00
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712876; cv=none; b=plJyUFaR5j6dMkj8ti+aAPgCTcSvefEsCHY1bC9mfSIyU25WxELlkWV/2YsJjSVwHBaaDus/vzJav3jdGFJinx/8b4ZJvTMshKfO+R1rAg7cVJoSIbYL7xkDVCzYA3D+w9BylSUJ/GTeKL9BkCEaiyAZylXuqF8eihXWRK7vLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712876; c=relaxed/simple;
	bh=V/ILjVUJz4Ti/0E2WdmQdoLEX9ft55KxcwGmOUPGCLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNrw4uMmqT7Vv/7M5YuWj/4S0VQtuEytN5BPPUaHVEZUKiDIAozqZWDZP5TJ6nSctbd68DTyfxY9zR5cHOAzv6T55paQLTDFZz83/LTZ3p4AdQ+Ux+scIJylLxc7FvAemcFgIM6bHJ4p+f1ULjJvbRs3QcyDdpGirCMlwuRToOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AKULP8le; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwZInyu7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AKULP8le";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwZInyu7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2A4F140019C;
	Thu, 29 Jan 2026 13:54:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 13:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769712873; x=1769799273; bh=VLKS/VNbBF
	ELnmrpmq4VS/PYw5ao+q7M/gUsQJEJ3mE=; b=AKULP8lehCKhJ6cD0k1YWbRFgg
	CVrxmSxSbRWilsv3yagPeBnWogQCb6q+JdntEMTJFZ8fNmgjFbqELdd5abkKQKKn
	m1RzHuGk74BaiGcVF6BowArWaeacBwY3JcxwEtCNdkjs8RuYdlXK82u8vFthnS7t
	mHVdvCCkanaGwhZzTx8tGD2c4LsSeBEdDg7IQ6bGxexGVU+v0YpaWdyZCdUxQAwO
	ZCh2B7mwogqOnysdPx+Yu48cNZnFSEX8CpztuxF7KoufVOAA8IuzeOjL4HDvVCFh
	Ps0y788kcnpnHklzUwEGoKzBu7rvEINBFIonrN9LR1O1/Ty+la0iRmxnRKVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769712873; x=1769799273; bh=VLKS/VNbBFELnmrpmq4VS/PYw5ao+q7M/gU
	sQJEJ3mE=; b=EwZInyu7iyGHMk8IM88zaWPoBBlHrsmauhvjyDP/Akoj/OuHe41
	0du9o+vwsotkJImVWTZhD8VwCAd+VZif5jdfkwpxEmyiKaobAL4P9Q8CPHlPXtzm
	pGz7QPFs7Ujh2IXCrH8/efnZEv00GeSVXo/7jBKZ40rOCguvU+ZywdplAfUM0ryr
	btY1RXB1cKMcZjvqwwCj4+VCwjRD2yjYXgoWtMPQ9oOOhcH/ncTB92FtwQp6ftjf
	/ng2Zfcpi1O6TGalU7i/h1e5ibDxjqEozyQeiv5AFjMDDTmNZU6K9Tx6vWo/lwgj
	7+l3P3vxUYPvF87amjQDY+Gyyb10NTPlMWA==
X-ME-Sender: <xms:6ax7aaah4Fe3exA0flfYgWDiHBqAadsuoxKzsiPzgsKThYtJAvmUAw>
    <xme:6ax7aUa4FphHU7CIXH2hRMk0srg-BSwnssK9Tf0rW3cuTIaFx0mizIp8vVBN1T6RU
    uCvfmbgnAENyHK4KZzLsS4upczQbk-eb9imPzV2U02aIjZS8CSz8g>
X-ME-Received: <xmr:6ax7aZ9nrS0tfJACn-CQrU22mrLOzdDDdQa9u6ePtAqS93YRcans73Q9Y5TBcBJ58KuppL6f2fFfvk8z2MPsPcb9xg-w-W3gE87xIWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvedugfejvddvgedvtdeuueeffeduhfdtheevffeufeelteeiveevkefgjeeu
    veeinecuffhomhgrihhnpehprghthhdrtgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhushhhkh
    grrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6ax7abgGon8DNBK4QpKjqhHiZGusdDdvZFSYB_I2iz_6NYmVB6ga5g>
    <xmx:6ax7aRdi51gUS1K_pljsviJcz0joV-fR3AizzW7UKqdk_29OEefQDw>
    <xmx:6ax7aaq7b2oRxaqXoSa53PExjim6guJTCMmFJxGHVNWfNLw5smzxPA>
    <xmx:6ax7aeC20Kij36OWIH4y79rUezHbM4YTWFyn53DKHJ4hXKgWDRny6A>
    <xmx:6ax7aX443nxjtqNGEGzBej_CFZc1TBNHxzD75nAd8kAn4c3Q1jWYHfXu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 13:54:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] path: refactor normalize_path_copy_len()
In-Reply-To: <20260129145434.29123-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Thu, 29 Jan 2026 14:54:35 +0000")
References: <20260129145434.29123-2-pushkarkumarsingh1970@gmail.com>
Date: Thu, 29 Jan 2026 10:54:31 -0800
Message-ID: <xmqqh5s4b66w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Refactor normalize_path_copy_len() by extracting helpers for skipping
> slashes, handling dot components, and stripping the previous path
> component, making the control flow easier to follow.

The new helper for skip_slashes() may be a clear win as it extracts
away verbosity from 3 places.

Moving the logic to the "handle_dot_component()" helper, however,
dissociates the actual code from the explanation on the 4 special
cases in the comment, and at least to me, made it a lot harder to
understand what is being done and why.  Also the "goto up_one" logic
was easier to follow in the original than with the magic return
values given by the new helper.  Quite honestly, use of that helper
function looked like worsening the readablity of the logic.

Giving a descriptive name to what is done at the up_one label by
using a single-shot helper function strip_last_component() may be an
improvement, but I do not think it is a clear win.  Adding a
single-liner /* strip the last component */ comment without moving
the code may have made the result even easier to follow without
disrupting the flow with an extra helper function.

 path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/path.c w/path.c
index d726537622..53a87ab67a 100644
--- i/path.c
+++ w/path.c
@@ -1182,6 +1182,8 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 
 	up_one:
 		/*
+		 * strip the last component
+		 *
 		 * dst0..dst is prefix portion, and dst[-1] is '/';
 		 * go up one level.
 		 */
