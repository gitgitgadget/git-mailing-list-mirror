Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E154F81
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636875; cv=none; b=O6McP5+Cu2hpTMv3EZQVzllBWZaPoh+MH7IT/o0dp87bQsvKST3VOUA/vO7POfJjbXgzA/24UGEDzm5aHQKBoo7BxAMFFMbM2D2qqey25gzA8cqX+4Be11tIFsT3sQ8ARDXgdUuSyfq+7xp/Kof43Vf0CpKYOjOEJ5FNvGLqYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636875; c=relaxed/simple;
	bh=qGHKY8NThF0gtqWYws6LqST34UU20Gfil0SJr1yeFn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRIwDPKz8hK5wpB2U5iRbmfoDwQ7yX2Rp7IlCVHbWi9d3EYhc0vHZ9VnVYz1A9zB5g6jYyiCHpz5sAS0rCxO0M7hRJTt1dGFZZ8PBuiQvN/hL3z8pOv6rCy+0G+8K4E5LdMkUsKpEmhTUNXpmYR2TO1zvvloY/1yV3s5LBGytX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w7Ik6W5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3rHrUyj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w7Ik6W5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3rHrUyj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EC0091D002A9;
	Tue, 23 Sep 2025 10:14:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 23 Sep 2025 10:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758636870; x=1758723270; bh=AuVdbUeBk2
	gFQ5+bONFdR48AuYfgHlB2jCdhYITbor0=; b=w7Ik6W5mjdz03mXXAwG3PvkCqF
	V4sI3t5NtIrujDxdNbD77K8y9dcR4OoDltmv/8fNfNGhTD9wAiarVtBn+n6X5E9c
	caqyhaviaBW/VPSVgUB6Yauul4Vza+6XKZFUzFoBvRXWF5BqCmEy/j0JIb1cuxUA
	VXyd9crj+qEL+h9kJzeh/TcpPq0iDPDbJt1P9rKhU4DXDhZaPd6U03sjo2PjKht0
	5k//XeRrI/h+NyeykZw97D030f7xLfQYR5XXFdzej5ALWNyGQXe4PD85tnJUS1Sp
	tH8v5tAx0nyj2EZgXsWSgQ5VzIyVKa+xHQDIm0ZlyTkQekqzpoTmCx5qLYvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758636870; x=1758723270; bh=AuVdbUeBk2gFQ5+bONFdR48AuYfgHlB2jCd
	hYITbor0=; b=V3rHrUyjx4oyvkr1b7r0GCj7GTEt4aNJ5nDROE3LHYccygVSNix
	grPkfIk3simTXSBeJpx/0+dO04tPNOcDQdNXPu7KBgKdnJvu1Cjm2vAXsWecNK1S
	G1+FYzbLqkfegffFaZUCvMK2b2CCq/DYTNNYcfG1TA9+gsI5hRThzz2wVd5ew2f0
	rqk/nybggAasRy1RSAkfRtp3/fTj5yOWI8GNVM+Rl0ItpahZNa0oZyA7J0II9QIG
	gkdWITWlFRFbxnwiE2SWBQQc3RCOykhHZkl4sQccsCsX0z915ItrtzBEE4DZbrUE
	EhrCGV9As9CB/YM/P2+SN6E2zMeBXUeGXag==
X-ME-Sender: <xms:RqvSaBLvgzHt3biA6rVHAsa2H9xaciHHyh-DHkEG__GPIlUwFhgTqA>
    <xme:RqvSaEnuYFCYRtYnYcAepgDbY5p92wjrY2d1HUm2Q2UYqFSXsCP5E7231NNXu9EJ6
    PdHXfcHQOI0Wz7GR5HTFl5KEU3ZWKbt_zSLpcjoiUPhwGpPvfUe>
X-ME-Received: <xmr:RqvSaHETJX3jlMWqHjZiDOGiGYdIjNnfRazRZjPCBwyPVCgdzDw8ELVa539XlFru5lCoIi6nsD91cjPix-ejgeUOODoBQ7kUTS3R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RqvSaMFQN2uAlama7W_76j4I33KKOMgtSBCccvOdKONphYgjIs51xQ>
    <xmx:RqvSaMNDaJPCUiLNNTmsD6EeF3zonEitsuP54nWOduVWuAvx3AndMw>
    <xmx:RqvSaDGNmwxAqdGG0d-nmIMTnSx8c0D-fyT79wq1w3zci6cs_fqmpQ>
    <xmx:RqvSaLMtFDT-dA75UAip-GuYXOYOfbMJPWkwdKOySdpS0uH4PT8Gmw>
    <xmx:RqvSaDU33stUKQR5RfYnQsRgpIevy4pxCvenkp2R57jKUkP6JnvhrtsX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 10:14:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
In-Reply-To: <20250923031942.GA1484@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 22 Sep 2025 23:19:42 -0400")
References: <xmqqldm6qehe.fsf@gitster.g>
	<20250923031942.GA1484@coredump.intra.peff.net>
Date: Tue, 23 Sep 2025 07:14:29 -0700
Message-ID: <xmqq348dqmre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Sep 22, 2025 at 04:01:01PM -0700, Junio C Hamano wrote:
>
>> * jk/setup-revisions-freefix (2025-09-19) 6 commits
>>   (merged to 'next' on 2025-09-22 at b178f27e6d)
>>  + revision: retain argv NULL invariant in setup_revisions()
>>  + treewide: pass strvecs around for setup_revisions_from_strvec()
>>  + treewide: use setup_revisions_from_strvec() when we have a strvec
>>  + revision: add wrapper to setup_revisions() from a strvec
>>  + revision: manage memory ownership of argv in setup_revisions()
>>  + stash: tell setup_revisions() to free our allocated strings
>> 
>>  There are double frees and leaks around setup_revisions() API used
>>  in "git stash show", which has been fixed, and setup_revisions()
>>  API gained a wrapper to make it more ergonomic when using it with
>>  strvec-manged argc/argv pairs.
>> 
>>  Expecting a reroll to fix t3903
>>  cf. <xmqq1pnywkwv.fsf@gitster.g>
>>  source: <20250919223351.GA3906184@coredump.intra.peff.net>
>
> Hmm, I was surprised to see this merged to next, especially with the
> comment at the bottom here.

Yeah, I am surprised too ;-)  Will fix.

Thanks.
