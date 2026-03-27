Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159D17B418
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636143; cv=none; b=WlnQEGPGWe4fEMpho5qDJrp7j6h0QGdxuZQU+pGIWuN5HTuTQtD7CNFzjD1oNKaS0W7OQ2mSlpW6/eXtHe7JvXD5thnWYPA6UcbsplQCOxzn3MSJPQVG7Jhn5JUaouagLz1OrX6FgoNX3KfHlmqzncHUuIxhuMW1P/+U2UxGHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636143; c=relaxed/simple;
	bh=qFkNatOn6130Pc41zMeSNNkGH0B2bhVI0odSwPIdSV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjZzgGimpbz1pHzdYGCHw7W6oBFx4WA3ead/qAod2wrmk6I5p8+OaN02auubQcoiJGB9ffkksiCARhDKmQXJXiWODv0ZvGKFn3TznKfQzEYwOV1CxUwfHOVLyiRZ3HqTxpB4ulvRYtRQeq5wyacRHyHn4ZzrhoUl+27vIVsXgE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KudM0TvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2T6Nyzoa; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KudM0TvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2T6Nyzoa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F1DE1D002B4;
	Fri, 27 Mar 2026 14:29:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 27 Mar 2026 14:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774636141; x=1774722541; bh=eOn4Jclto/
	nxrVIF69+629Z8xfDa5prOKTNLtyDAVXY=; b=KudM0TvPNgargMl2cGYWuOKITj
	8AMAzk+lvuyxXE3ABlDfU8QupL63/8XZtxPlM/4MwiLBDQJ0BhoJv7EiPioC26j6
	rWAa4+SLzDzAAwBNhY9u1lPZwDYz83xtIAg6JdKddJvvquWZgYTyGU+oUJdVm2mP
	GxccV9ayYiI5NDx4BtR2OK06LsHO8dMwNhGaXKoAlu/7fBCsnxsdqSJwSmXBCY9H
	PRchkyj7/h45X/rtA9Zw1+C+K7jqcgx5Re18TgsQSOc3PVnmjHQpPFn7GoUV3XD1
	5c3xFHxa1s0NDoAuQzLgmmSGvgQKmUmoy63IBFDb0pbDTDunGbhBd+fuQWVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774636141; x=1774722541; bh=eOn4Jclto/nxrVIF69+629Z8xfDa5prOKTN
	LtyDAVXY=; b=2T6Nyzoal4AiXLyu2DUm3U7BrbKYjL3/e7hSsjUsF55225M7qsj
	FBBXBnMn+sDncIm5gcDXD3gECrnok/5qpI2H4Sujg3vveSGx/DJnC08N8gdxKDx/
	o9RTVB3RvnDVTDTQJPQ9w4xcHHvFKYKI7aYu20FLorJDwTkiUkWSBlZUwJ2RE907
	brqPLnzvfHvaOcDUxWwywmcSzzWZmF9Zc7fT8BSZW13ZxXN8XaYOLD2Lmy5DD725
	RG/EDbXz7XhgsPTl/9Jjo1AnlX+8GV8p+d/0TVKT/u3wzeXkJ0gVSwjUGxotdlfB
	kL0SGrhhvXGbvZSDC2R3Kp1ptGolK4s4xHw==
X-ME-Sender: <xms:bMzGaaCuJ-RnlYyIK2VcOtfeMaGAzBqqA-ORHegtvI6XLI8jeoqbCg>
    <xme:bMzGab8RGzmq19jHh-lXa0Ma4SHBsdy3nCivUHM5JaJUwQytIw2QKEwzkrdqG7_s3
    DlA0fQa2Qj6CWT48F8aTybPZKPA0-XxjsNE24saZlAAuhJ0pt5u>
X-ME-Received: <xmr:bMzGaa8wCtVor-d7VVCC-5QB1f9GUSUuG_Dbtzg8inEUtyR6vC6M54n5T7OMaQNWUlZ61Zdx_icebSCLCxe1rQUcHuG0L3DLig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:bMzGaSd4MmmZSZ76cwgJx80RCTn77VXAFpwf4EXkqn-wtuYhreFfMg>
    <xmx:bMzGaTGuxSJmvu2FS8TbNwn4JDg74tLRrooa3x79T975Sggt5Tc4_g>
    <xmx:bMzGaQeyaIZ42JXJ3-z6hrhMgBMrfN51BRwocKGKGuK3lJdRE2FdKw>
    <xmx:bMzGadEgzeijwIKz88Z1z4CErxkUfi-xyeiDPqgxbOWlliYb3kqUTg>
    <xmx:bczGaQKb5-F_FKkUCu-p6up4OI4lX05rRyp85y24nDjSDGk1liTY2ikj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 14:29:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1] replay.c: support replaying root commits
In-Reply-To: <20260327180930.104563-1-cat@malon.dev> (Tian Yuchen's message of
	"Sat, 28 Mar 2026 02:09:30 +0800")
References: <20260327180930.104563-1-cat@malon.dev>
Date: Fri, 27 Mar 2026 11:28:59 -0700
Message-ID: <xmqqh5q1jfdg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> 'git replay' does not support replaying root commits, as indicated by
> the FIXME comment. If a user attempts to replay a root commit, the 'die()'
> in 'replay_revisions()' will be called.

Please be aware of your surroundings.  I think there are multiple
topics that work on this file and among them there is a topic to
address the same issue, if I am not mistaken.

The list archive is your friend, for example, you can try these:

    https://lore.kernel.org/git/?q=replay+root
    https://lore.kernel.org/git/?q=dfn%3Areplay.c+%22root+commit%22

Thanks.
