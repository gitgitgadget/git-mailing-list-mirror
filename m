Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89083E8332
	for <git@vger.kernel.org>; Mon, 25 May 2026 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701093; cv=none; b=rGbKCrrgn6tIaPsstoVEENo5fYHmKbbznUBMTw/XD2yyssC+n2XHPnazAgndpcosw14WPVbwS9wCmJYUABmcOXLCuEZlhBoAczksCHMXSUItfllZ8bHsNxpYQ2rsnAmfsnmhz7ueJqa/vhLxiEFvUcyh0j+CIV6ckUUTjLuKxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701093; c=relaxed/simple;
	bh=2wCOCHtImf9e0v6kHzs56IclXRRTaaaIoxRLSBftS8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+8dH11k/E1NkS2c8wUn7Otw71K3fjpg71pOkzKhERnIjUiREZjv02RVYy+EXmAx979vSGrTj6eM1IaxMxujl2vO2Qawxs+o3nl03ZoVvpuIm3hW1L7LMKOuJqGAzmYqtBGF0Dlia/f2+VwbLyES1VXpRUyWG8PNOh5dtAeOf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xS7XDvIL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crtSv+HY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xS7XDvIL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crtSv+HY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E7AC8EC01E9;
	Mon, 25 May 2026 05:24:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 25 May 2026 05:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779701090;
	 x=1779787490; bh=TyOY44RfqrYrknrp3DI2q/UYovWh594YPkxROKdsdlA=; b=
	xS7XDvILA5xgdt4VQxJHAJzaLAq7OOsizgrR937FvturY/4unu9vf8t2VORk8vX4
	zl9bWcdkfReQTzgBDV83mmOFW2tVItc5PJHBvtQHCAyjUM2VNIBsvVLKfa3Ij/pV
	sV0AABuUWxiBwCRg/iGOWOd/AnzO6PLtiWJ13p/RvkQcTvAJT+XtcMupmbcCnW6u
	+PQP9Q7zfD6RZx3auVBGYJ2H91kETT+AJDoI4JHA5tOjUOoIGgdOO7auEk/Y0nn0
	KGECFMR6XudLrCnF9Tter1Ra1/9tZgZUc7z4F3n0kzZjgzVpgpmK3Sus1l6jRoiF
	MjE/asmMjBabwjsZXbfJzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779701090; x=
	1779787490; bh=TyOY44RfqrYrknrp3DI2q/UYovWh594YPkxROKdsdlA=; b=c
	rtSv+HYlvnIbS9h3cQqR7fv5zORmz6fkAcunCIgNxwPLAD7tS5Y/y8ViVfOgs/S3
	wTla0i1B1yfTIqenUHIBeunmkoYNQNxKd+lw5tjDC0/bmoUpq032YQK4PRKGCkFa
	RbaNtrd/7YTbDyjfoi3e2JUyRYf+V/E73xiBm5D6DtrrsY6M569lgOycms+92U5w
	/oEp/vYXOHrKedVgyDxd3AK+FKfZXZqEruP4eaxxmj0BFOpovWJtpIxqa5jTnXKs
	d9fm7xn7/IyFyZAg+Q9nRf6aRNQVxAuSjBIa+AIyTwLIH+V+xMKYeFEbI2ogAKVi
	l1pkkl5IDGIM/s0qOeZxw==
X-ME-Sender: <xms:YhUUavyujgG00ALH9KnCica1-sEv0SomQARpFJXTezwyRrN2mnWdzg>
    <xme:YhUUan9X9kGVz3Y0e44XM4398GJOyRr8OByFSuqnrfzzOyWz_hct23zAEGd-FSpnW
    u4Zz-mZA0Tr4A4owD0E9Cb6ikVxOdIR7H5t0wUmCkJ6nNBAlSVU>
X-ME-Received: <xmr:YhUUangvSHuX9e6mw7wVk8EAHamIDbAEauqWXBGEMbSy04PCpttjRbZR8rBPSZ9hiYR8gxfVpICP2jFdqMjAMOmHYX2C5LSAXz2i>
X-ME-Proxy-Cause: dmFkZTGPIVCBbxgt6CIuC/800kOuE7zwYFqOtT6xCfM5m6rnoFsnfY3Gcb6loF4W2Yj5j0
    KZsiw23kQSh0hu7PlBdEFRe9yV+hnQzGO046PakEvHko2Qb7zyjU3TYK/2z2+pXMUG6RX6
    GtIzwTZj315jHTpCWznDyMT69S7RHAiFhxt9YZ8rqNq383LnGHv9TCpbB3D8fZ5J5at795
    PjFlAR9jKbe0c9salWZY537CW745dGaRk6Bh7F9xw3aL/tiK/nCKs+dK5wlYBcwlYPxugT
    Uo+fwnAdMkaIt8oeaP4/5iML05qavxGQF3Y/g8uaiLv60MEH5/t7NWeTyTFIvV0rOvS9MX
    QlLYF+nlubtd4WBrBRW66wQdzGvBZ/A4yYk9KToSr5Tl65zRazFOn0CsPZyUxWDlJvVugs
    S4xcvpl5J2d8kNLDk+4cQPQMQKLMVRb5rp+2Gup3/8k6PSrCr3q2lfXTKkEkZthdNABYsw
    4u5Qjt/eMGuos3tpH3eLf+i3qaVoqedbSALkIuwztYqNU2wqgiMvjEhlC4uPeSj4LFcJfh
    10O6q4PQkIk2j9WWNyVjTlcrvgw6Ie4cPjgCsFNufDLkuQuvx1Rbui4cvskx+cHqPkVpvW
    OAJfa/VIPqBdHNVSz60JYEumLjpd/GVfGdjkpVQeUyqYfjihGg70Rn3fP3fQ
X-ME-Proxy: <xmx:YhUUauFlT31gqheaJWFL8cFYTTmqjLnz1cqTbrlhPxWlN6Uc5yilvQ>
    <xmx:YhUUam_inC1-_Is9TrhNM6r-1ySza9P9VxjQQHshPzhX9vzdmGtGkg>
    <xmx:YhUUalwe-e2bqmQ8N147ECK8AntdIQjze8DDqFz2b8mF2YUZ0IfB-g>
    <xmx:YhUUaiNTtXw8sAySMfEgaP-cdJT_5kb6tEqVzT8qUwxCHqqFZD4OyA>
    <xmx:YhUUalEOIbRTKPwJhbSobeVUOb_7BRerPjrKz35xhGId9ZZH9JGN_dyH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 05:24:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan <me@black-desk.cn>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/2] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <CAC1kPDPbyxs-aTrAOi_PNTZF7EApG31iLYwm+Eddpeh2hT8a-w@mail.gmail.com>
	(Chen Linxuan's message of "Mon, 25 May 2026 17:00:23 +0800")
References: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
	<xmqqjysseyid.fsf@gitster.g>
	<CAC1kPDPbyxs-aTrAOi_PNTZF7EApG31iLYwm+Eddpeh2hT8a-w@mail.gmail.com>
Date: Mon, 25 May 2026 18:24:48 +0900
Message-ID: <xmqq8q97et9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chen Linxuan <me@black-desk.cn> writes:

> On Mon, May 25, 2026 at 3:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
>> writes:
>>
>> > Changes in v5:
>> > - Fix Windows CI failure: use `**` glob pattern instead of `/` in the
>> >   "worktree without repository" tests, since `/` as a path pattern is
>> >   Unix-specific and does not match Windows paths.
>>
>> Would it have worked if you used something like "[/\\].path",
>> instead of "/.path", to cover directory delimiters for both systems?
>>
>> I am not asking to make further changes.  I am trying to understand
>> what the extent of the problem was.
>
> The root cause is that on Windows,
> strbuf_realpath() returns paths with a drive letter prefix (e.g.
> D:/a/git/...), which does not start with /.

Ahh, OK, so the "Changes in v5" description was misleading.

This exchange suggests that the use of **/.path in the test deserves
some in-code comment to explain why we use such an unusual and loose
construct.

Thanks.

