Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0653BB69F
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782685633; cv=none; b=WZ4snkEfpHnkmr3gkq2Cy1tYmGAAld8sutDciIiZd7Ow4ZcqiAq4JXYxpflgAuXiyNvgisenZbGvGFzpC6Rcx1PHjoGyIHJAl7O7o7XnZGGojZR3mDI0tZhfX6ISoBRo4kwokPKlSZVvGh3GUBoAOo5+0KQrIBxx1VpRVODcWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782685633; c=relaxed/simple;
	bh=4sG5qWuX3zCbBWjwScnHBgCXIwR/Yma2s9OU3hJoexM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQKnvhUfrjFBlNmfqBxbKDAFjbnqW849oD62TvOJee4mT/5LvxZqo1nZF6vkXeMgvPa7DYGhPDYYXgGSXFZ0+7qWoFeRIyqHYg6+95SeQJ6SYaanQiiQADEYakKkA/eKHvmtgfqXgWx+MoIiCYkRzeYEF2rL2WAawizrcDos3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SquHrQKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6+19e15; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SquHrQKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6+19e15"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DCB9F1D00095;
	Sun, 28 Jun 2026 18:27:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 28 Jun 2026 18:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782685630; x=1782772030; bh=SQb1ujxvtO
	GBmy5xvgRYKn1VGlW42G5zXuGNKO4UJCU=; b=SquHrQKcgU99muMT7G9qAYU75H
	ckWzzwUmMZ5j59v16dHkYL+mbOB+PgNqYbaDWalA9fdqJGqtXMwpyosw6YAsGkDF
	tVQQ8hM3K/LZDLkm3yPOspGAuK+Aen1bbXBEJ9tSPmrHBlaiwRc3wSwp1ltFUx9O
	qa6bm6eovL87RYeXHRIScXtITX2cx+3w+MPreILu/Svz0HOoZ5PQ//KG5p/9/1hM
	Fulj72PkrD9UOLpXqP5yku0jzFtxc4ogNz9zl70553AIw5nUsdx5gncSwP7LzX/+
	uqaBXTIoEULEVZSxBKUFC1Y9Ru0VjRbUXqo/aoEUxBtLydaBADN4+JN/e8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782685630; x=1782772030; bh=SQb1ujxvtOGBmy5xvgRYKn1VGlW42G5zXuG
	NKO4UJCU=; b=B6+19e15D1D4kxX41lLs8iFMkdDSeXtadbnhm6qkgnugGv9P/i1
	UR6TUQmE98Ja6dcTPXpE4opEmm7fUtfYB3wGFkNi7NQrcTUxSSP84XfQ5QfOz1mU
	SN5Va6u/UJqa4cshf9bhnEkKuTKAv9eO21qINXXi/TsRv8DZAnW3mL0KUpppQw9F
	bdcP+mk5RiWnY047ibJehBoF7iKKxxI5voOqk074ZebQkdfRkHoFJporvE+rq8u4
	xaZ+Nv04xaxinWnq5PYviJnXkKPc6sExbx2AqoSeEaOD2XjnmMaVe0z9UmAeY2uq
	UVtUjbl8hIoz+poFrLxkmHrSy0Mre0gG5RQ==
X-ME-Sender: <xms:vp9BamVsxP1Lfo3AxzrgWUb-i4FKMTJt_qZeXAi2itaYjVwu4SoDEQ>
    <xme:vp9BapfLTSSoH2LZw3YAFtS5N1s9F7zN2VYF5dacu1VX9MHD2ZM8P6hFouJF1qg_a
    voW52mqNLGdNuHS8T49Mh92OL8OIeVu9fQVE9rt2NZhfksUsg85xQ>
X-ME-Received: <xmr:vp9BaivsT54yDMPaY_pKLI3yO4HQ1wd7SR-qV3_sepTv2_LHSLUJMyRLPxRXT9EWMOugLi2lh36Q3rKJ7EEwjCzubaNowriRBkVy0lU>
X-ME-Proxy-Cause: dmFkZTFrZSQ7wclU7TIfd1Kt0Cisk3J01e2vK7dCo5Irb8IOYXKIspF+aQFE7W61eERBqj
    BaEGao2T5hDwX6OZcOxskrfnd5LJkdwBvnec1J1K//HFJGaW61aQlaYUEAo7g7iD0H98Ax
    nSrUAy+ezFO9HZgMuVcAOno25QCWVchUHL4SIdCtCPgJ2ibpJhNz6h3N9DATAIoYSmFOtk
    T0CVbzRaZg7jSarJS8i2IHAlKhWy/CzwltETbLrk2xVcXEiySx6y+es/R9CaeHW8p0UDTG
    HHclya13GkmHzktpb4iPR74fZ7El3Gy8GIa+vikkvExcjcx33NB8XfC3w3Zk2ucmt1WQR2
    gJw496iDw4wejykEuRWAwca9yVJ4qD552mvffAzulIbbS10bBygLOFPwEsH+Ck/tnov/gp
    IihB5RVlDtEmWbUPZco/nM+GR+G8rcXp1jav0BlYhDENIzkXpbWSVXm+rEhjqhxeuG5/rC
    2pVKvPEVYveunLeTT1MFY570F2HXvGyzgkjLF4BGn0n62HV/a0BeQ//OVUwajZDICeAfhV
    WT4D8RctrAJ9PIcnUUzpvVhYxqJ1QKku+9KnN+O/rSVF387ydE4olaAuuUvwO9T8/eW/uq
    jkSaaRZnQL9yUw2SjSyY0vzN4D3K2jtBjKMZTBD2ZLjFOzsR6ZDB4bzpScsw
X-ME-Proxy: <xmx:vp9Bao9ae70qi3NBTbg7XJxRxw0JV0su4SlkWZvytNmdCQxW638K1Q>
    <xmx:vp9Bat3FyzP0u6hKq5BkpPoCFfNYHyoKnpVFRNP9NZZS8LYRXubCTQ>
    <xmx:vp9BatAmQDOxHPW34fGNna-a6sq0CmRhsaqV72nzZYifr2db-aQVFA>
    <xmx:vp9BapeuKPM5s5EdnZW3wCxFuM2aAKLK4OmfeQMTWFaJo1vj1DL3vQ>
    <xmx:vp9BanXfhPD_80I7UU7SHV4oOcJUfKU5VFHDSm8BKW5HFpNbIIdZOhfT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 18:27:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aliwoto <aminnimaj@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: accept https:// proxies again
In-Reply-To: <xmqqjyrj2qsp.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Jun 2026 22:10:46 -0700")
References: <pull.2161.git.1782580676734.gitgitgadget@gmail.com>
	<xmqq8q7z4eg3.fsf@gitster.g> <xmqqjyrj2qsp.fsf@gitster.g>
Date: Sun, 28 Jun 2026 15:27:08 -0700
Message-ID: <xmqq1pdq1etf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> From this function nothing returns an error anymore, and looking at
>> the preimage of 663d7abe (http: reject unsupported proxy URL
>> schemes, 2026-05-05) that is the source of the bug, the original did
>> not do anything when the corresponding code did not find and set any
>> proxy settings, either.
>>
>> So perhaps it is a better fix to make it just a function that
>> returns void with early returns?
>
> Nah, I was being stupid.  Disregard the above.
>
> The whole point of 663d7abe was that we wanted to reject what we did
> not recognise, and we cannot do so without returning "good/bad" from
> that function.  The bug was that we did recognise https:// but still
> returned -1 because of the bug, which the patch in the thread fixed.

And as an important bugfix, this patch of course has been
fast-tracked.  I'll make sure we have it in 'master' before Git 2.55
gets tagged.

Thanks.
