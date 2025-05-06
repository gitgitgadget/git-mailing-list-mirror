Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320E2153E1
	for <git@vger.kernel.org>; Tue,  6 May 2025 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746566318; cv=none; b=PlABsu35n4bBhjlhtqG8smiE5PYcjy03n3cKa1urEMJ+QlRCtcohUqb9jz6GuIc6BwArQO3ydl+Qx5k7GDVoy6J3X+UWD0P/R4HcNNoHBAGHpbJxQX/KYsSmYdlsSNY083fTXMPwYeaG1ldE4/3RCX8QFcZD7fRIA6sZZS3niSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746566318; c=relaxed/simple;
	bh=VthEC3cXGaNJB9sO1mMSUjtvq2vVWTilPjjLlXFym54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SnWfWa8p0yrwCws4l+YwWdWdKj0tZDljN6Cwwe2mL6RWqVbZNJ8n6XVLnBr36xKFuO1D46UaapC4/3nbdo/u9AIpl6SGx6RX1JQ60RgCCOstvpUbAdMp7wHBMfZRh/0e9QkMEHuhIuuf7xRMUsbRRSAMw7JDGz8hiR55G/uAp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ixSY/IIZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyEeUrqG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ixSY/IIZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyEeUrqG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 573BA254021A;
	Tue,  6 May 2025 17:18:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 17:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746566315;
	 x=1746652715; bh=wklPoagmwzVaEDCy8hPkhudZb4Rr3DIP3ZvGSPJDMpw=; b=
	ixSY/IIZ12ZMlAUfDiLCad9kAQArdM/yAdoWfNBaYlziyTHIjiVCMtADZnXOKn1y
	nBVsq5BuxhHjoAaBLiInAcHPr5T+fY/O2anlrcbVUfpnghj5pVAwtEs6Wj03005X
	rbwPNeGHoRMyA34F7Fi6nI44oXX4/vFTgPGPSW40SFOSKQELXVGNpLe1rAiMtZk+
	ibweJHlT/f1f5L56TfJlP1aYfLz+N6J7V0safSkIACvJwc8Ke6lnrFiFjtzlf31U
	YT3e3r0acsp7LuJJOu4pL5SXvMPKgDJTRsR8XvEZ0YuMYGfyF8UxnuHNXF/ThW6O
	Zly26D4mwa0gGhld5Lvueg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746566315; x=
	1746652715; bh=wklPoagmwzVaEDCy8hPkhudZb4Rr3DIP3ZvGSPJDMpw=; b=T
	yEeUrqGUuhHQphjNW5B9u2fZCYTuzQ9o3RfdDGmq2K8aX0cZtwz806s/3LIJJUuI
	b/qPNfT213zMoJdKLnO7tN1vIcylcuOBrYBIyTBUQ6IaY+Ygua//ACgj2wkWcmlC
	wOpdIcu40/T49a9xdNhL6P8LDH6zJhGYJScj2FsioeidEoqAB7+/ibGkN7QCKOZg
	TxhFTwJFYNsZLxJ6vb14h+pExQQv5SaMA1qmUxClaHmZRjcneGuORYEiWYiYFSKB
	nF5GSNLHGgUqWIhqBH008c/R7sQCO3LX8jOO0vOT7WMK0nWL4RGZZqBDje6CjnQM
	L84cxj8ztDg876rdXjGxQ==
X-ME-Sender: <xms:qnwaaK9LanFFRmUH8iLp7LHi-A2nLbWdjKmOr93nNli-SHg3C1QIKA>
    <xme:qnwaaKuPi5nqDHdk6wf3pTom2Mxv4prFG2HPioWqwsdlA1vVlJjChOVfm1BFA28AN
    XxzBbRBgcf_8D2l7A>
X-ME-Received: <xmr:qnwaaAAmhHZHhIoxKcktIjk6pVPG1pQGEVvmauDRtnwWjHfLshT9hM2RY6EMMl2n-mYU8QZddcvk-XAlBcoOh_Q3BMGVlRtM_Ljx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qnwaaCeaS30AXbWXf1t6-Z5IdMxz1FRW1V9UskiCWHMRHdI40vs9UQ>
    <xmx:qnwaaPNw529t_PQzcmr6JGjklAnQlHJjASfL9NNprwNxtb_mlOORgA>
    <xmx:qnwaaMkF8O-6YRvOFFYirXg9mgteZMXQ-ghOunAn6pQQPwTiJ9NkEg>
    <xmx:qnwaaBueTuRm5rIWE8acM1gG9Qs8oAZGA8odgBpthaskeRYJPJjpyw>
    <xmx:q3waaPMdZSZUML09F9hhyKgJViDRlJado6PY-GR3SHjdtRcqKlsn2hHf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 17:18:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: Problems with t6011
In-Reply-To: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 6 May 2025 14:32:04
 +0200")
References: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de>
Date: Tue, 06 May 2025 14:18:33 -0700
Message-ID: <xmqqa57ph1zq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> Hej Patrick,
> in case you have a second:
> the mv command here needs a "-f" to overwrite
> read-only files:
>
> --- a/t/t6011-rev-list-with-bad-commit.sh
> +++ b/t/t6011-rev-list-with-bad-commit.sh
> @@ -39,7 +39,7 @@ test_expect_success 'corrupt second commit object' '
>         for p in .git/objects/pack/*.pack
>         do
>                 sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
> -               mv "$p.munged" "$p" ||
> +               mv -f "$p.munged" "$p" ||
>                 return 1

Looking at the remainder of cdbdc6bf (t: refactor tests depending on
Perl substitution operator, 2025-04-03), the commit that introduced
these lines, it seems that the prevailing pattern was:

	chmod +w "$packfile" &&
	perl -pe "regexp" "$packfile" >"$packfile.munged" &&
	mv "packfile.munged" $packfile"

but the original for this loop used "perl -i.bak -pe" that dealt
with read-only input just fine, wihtout the need for a separate
"mv".

So the lack of "-f" indeed is a bug in that "refactor" commit.

I would be more worried about using "sed" on clearly non-text files,
which technically is undefined operation, and I strongly suspect
that it was the reason why we used Perl to munge files that are
clearly binary, like the packfiles, in the first place.


