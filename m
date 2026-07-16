Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F810349CF6
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784233263; cv=none; b=PJn65k7fvbkg3WiKS6EvL3udEXuNcCuZsDdJzyGETRlc2/T9MBV/o8MbWA6z1PWXZw9x3Cs3R+Sn31CNLKUFtVovds7HTXo3sfcDJF/ez9/CkcE17CcnjWH1b1yZxuQ03mGElJEOtW6wxrzJ04wW49WXUcGeK5c0MmlfsUFM6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784233263; c=relaxed/simple;
	bh=djGP9hvntJeiEvYGqCj06KErJFiwfgFMFqWg9LOIvjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rIZLf6aswn2OcHnuf3C5/3sM08BqkqYRBgBhqGjc0y1oenngGO5NaNupJoH0vyKbhZ0zNexM7Q0yEXLg1O298QiqkzrcuY/CESSUe37ALU899RVL0RgzcA1Kn/FCpTgkIP6E5oJg+xr4nlTrrdHWjMT4ilchTTLENbSR+gbtInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WF6BEUzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUaJKDnK; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WF6BEUzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUaJKDnK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B46CEC017D;
	Thu, 16 Jul 2026 16:21:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jul 2026 16:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784233261; x=1784319661; bh=7Hru+iV3HE
	KJ/dO8K4ru/2+dFM96RYqOXdpPS8ZScjM=; b=WF6BEUzRUzcAhKAP3iaa8m9m6W
	2XGGAQLtWAGYb2/EopuKvQvz67+zvVngaS9gpgvvcBxDU1GOfzpl2ASWkDEAVOwe
	XXfR3VQZ9KDLGIgPdUWbKgz04gUapQimOGMqcCmAzvusR6PTqx4RTAJ+ieRCN5Cz
	JhZ7CWXDgIPzImytsJhs56elFkL5lLDzcvS9Sui4MWSuyleF+BL8jYqm5XE4N5zc
	dr7oVKfC6v61P3uUV9zjfJhba5Do9ySHo/R+EhCeatjvLwyj1kV1rrb0R8f83FL1
	mrIPPCulaqI/V9TvGfVLw36xxi0ImKYdr3zJXbTndmR1dnxOEMNoQNnGj8Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784233261; x=1784319661; bh=7Hru+iV3HEKJ/dO8K4ru/2+dFM96RYqOXdp
	PS8ZScjM=; b=bUaJKDnKV5wtac81aanGp6SV/hdg1Zn8tm/thlu6+fBjL0dWbCk
	MV1oUP9TXCeT5ZJ/5c/XyD2APZhp4eWSipqgvB4rffIvqX4FiQbpyNAXwRWdjg3q
	uV/Nw06+nmS8GMViMzpiLfQT4WgU7Otx8amcoSNhGDdoJptad5DnH6VJU2y3oq2Z
	2+OdvyGLoBCTE+ei9PmhyStwThfMXnWrN5b/oQAigHeS+RUBv6OTLpcsejKszIOS
	Zb4Q5COBqjmmQRzOIzchzD/cxyQ9q/duNrPBcKc7NdZbHqyrFNiQHCUin0rMEhYx
	xMJn1wP5Jh7QKA1u+dG+kcNPfcwXhRddphg==
X-ME-Sender: <xms:LT1ZauRZTIeKRa_CJ9uMyghRRG0xs_3BjtO7Ki3F-xnf1Yo71XsC6g>
    <xme:LT1ZamAiQ8k-NMKrDttAHhDhNsDdAJ2nnqFd5GkayfdLx5QIzcuVQEO8bGmekJWXp
    E8vkqcn4O0s_81tnrEvOFnfx71PYYGyU-K3e8nGPRJ8oXYuXZMiaA>
X-ME-Received: <xmr:LT1ZauG-O94Gg23tIzykm5XWh7IC9WKCm3c72_uGb2KHi4HbhAPqeOZyutrV807F-kqtankC452f-nI46jICC3XoxLZa3WrxMn4X7bk>
X-ME-Proxy-Cause: dmFkZTFlkJ4NplxfAMPuSlHiepUMqQk0Z2QL2hLX33T+KOG/NX7TJZyFF9ZhUTnez5RXMk
    bQ57IdfMEQj7El5q4yVAAH1nXRhlBo/o3FH7kuEw8qPrGGrqUIwIaH2BcvZveHI3LsRg2V
    AS4PEaKi5jwjId9hNFjh/FLt+bFRYZjJccJAOSp2IODfdKbJiLgFOCJbnGeiZG8lOlpvQp
    bLw8bln5pfYMTV+6eTPf35rok6fqgA/5WNgBmUI+gcprHEv/RwKQbxnvtQvSa0uTQZlUHP
    z8rHhKzobbPbecVB3bFFIm7POT1zDuQWUBQWgUrOPlxG0chRB17M+uyZCVpFAuzZmNvMWo
    oAkYfKtIo4iynYM343HNmJQ4qtjllqibntmdTzQYi+QsWg9WHdDOoRUaaF0lY1o+IXpVfn
    ziAKne8yVSlLxSS1p9B7PWe6VnS0Ayha0PElKsjFxw8BwHo+1JXa3JwT9izDMq6FDLbWiR
    PORD5t+LdBLF9EzShI33+LalDi8td4rvuTL28wLmpVt0zZDK5/+EZtuadB1TiCA4h/B0eX
    foTBNwtqb3WUw5D56vFxqKoBwDUbZ6ETvuFFPYeqmO3zi+YxDW/0/bjX99ooWRj4gWgSMX
    ohsjdUXfLPO2irV16kug2SYNPLLTm5teYBa04B2ftlcy9vlSo1Qh9x9ysShA
X-ME-Proxy: <xmx:LT1ZagDaCfEm04BNcCqbJ9Gt10ULhxGdtY4MD9eT_AxnSoetoqvBvg>
    <xmx:LT1ZamWmwrpCV7iln66My3jMVTjqQCiFvsyCKI5ycICvju87-Vs13A>
    <xmx:LT1Zasr2yLPZ6z8mzcw-LsbGoko8ftC-c8fTYsxM_yB9Qc4QA6PlFQ>
    <xmx:LT1ZaqTrXDzCRyU_YGhR_z348Psz5k3xdRmO_xEw6QpmZc2lmcq3gw>
    <xmx:LT1ZarvRF9uKtmUHZNwOcg66o2xqlxXlvWh4dNnR7vL0-BhYDMLEbrWW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 16:21:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v6 2/4] read-cache: move 'ce_mode_from_stat()' to
 'read-cache.c'
In-Reply-To: <20260716084941.1101918-3-cat@malon.dev> (Tian Yuchen's message
	of "Thu, 16 Jul 2026 16:49:39 +0800")
References: <20260715035501.48271-1-cat@malon.dev>
	<20260716084941.1101918-1-cat@malon.dev>
	<20260716084941.1101918-3-cat@malon.dev>
Date: Thu, 16 Jul 2026 13:20:59 -0700
Message-ID: <xmqqa4rqfzys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The ce_mode_from_stat() function is declared as a static inline function
> in 'read-cache.h'. As we want to migrate configuration variables, this
> helper function will need access to corresponding repository-specific
> configuration logic. Move the implementation to 'read-cache.c' to
> cleanly encapsulate its dependencies.
>
> Note that the 'extern int trust_executable_bit, has_symlinks;' line is
> discarded because it's not necessary when the function lives in
> "read-cache.c".

A "static inline" function in a header typically signals that
it is expected to be called from the depths of a performance-
critical loop.  I am not sure if this helper is still in such
a hot path, but I wonder if we can keep it inline and still
teach it to take a "struct repository *r" (or whatever extra
parameter you need) to move these two bits from being global
variables to members of a per-repository structure.

