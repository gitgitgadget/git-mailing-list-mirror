Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAE496D5A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956379; cv=none; b=qEQh5tjZ04MWqNOqqvbout2Cvnz2XTlCogr8kGN3JcfVf6cN1zqeEZhhz+zgU+skV/TDoAHkLNu4WauXbc9E6rKViQtHB22LQnuGKJhIjZddc1PhXNjbELFEltwv/Y0TKdqkOLRcf/uTCpmoMp2Z4kGcYC9cdXUex7ijQp4kXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956379; c=relaxed/simple;
	bh=c8bP7bCoinIyAXFkWnERHwMVoZkev/n3TztpIq/6mFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=swK7BueNCcAmw2Ukc2zmBuflZPZG+aFDlyHyCWDuXTVynjJO+xVisq0Gz88Pn48MmfCCQ2wNZABH9bEiZ8yKk9jYKJF0n3lbNJM1tsebOwqxmj56h47gV3mMdffbU+k7LDY05O6sZNlYTR/MYtCdSLQ1Wqo/FUvgLwD3LWalFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SjEjH3mK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CglcfocI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjEjH3mK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CglcfocI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9892A7A0075
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:52:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 02 Oct 2026 11:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790956370; x=1791042770; bh=FVuyGzywKW
	6vLQjEC+AWYUGE79ZakEeAPjeCAPZv8UQ=; b=SjEjH3mKmCIqr9KFsjqmevu/Mz
	2fdtmxkjUsgQPfgUvAs40/x4kppcQw14/UjWxSQxDUTC7J2RC+/C4AZBfxEq/eRG
	z5YAi9w5/6Hno1y0ahsHefgacZzM8v2jdRFzFapLEushjhUcP13qbCbwl2pypfmk
	ZqI17Th04k8UP65fpIqCun4SoTiMDyhR0Y0BVp/qZHel6D4a0eR9odXhEffYW+/A
	Lr1rqapYPpZOYCMLAJqryslwWGmTy0L33doDSiLUZdqkCqqowii5hRR/VrfIAd/B
	YAlS8Ql4B+UHe8Jv0cVlNuwNyp6nA+z3P59/wzLmYRRmjbqPGIyImp8gK0dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790956370; x=1791042770; bh=FVuyGzywKW6vLQjEC+AWYUGE79ZakEeAPje
	CAPZv8UQ=; b=CglcfocIue8ERPo9Gl7+sVPhV0gNyaNFnlZXACWTuBeLXe5T+gY
	Tk1onVVWwzbq/Db9mRVn/pkEARIamhKt8fZhF4KVlrAKFNxaL4iDOsbbFPa1zJ9B
	tiN5QS9WZqm8Dku3Iz3GlBur5Vw1HH7sUhChdGaLUnENfMmaWanrX+42wdVoVpuM
	Id/ZMXmbThjzfGTQrjHYOTFH/YUvoZFyhDEonlfmoFRxxTsSDiaugtSK7QT5b0hm
	pTjoq5wc8USv1UdDHf4XlGuqe4YpzPeta9LrXvGPBUdFdcV6PJOmdpjF2JQC5OD8
	dtdjsZyl/otKEOa5oeXozhIdLcashKGEzAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790956370; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:WxfE2ZrRbQ2No2FyO47ZsORWpwk78DHuLOF5b8PMZ2ljt3Z
	3lQNHj2fztBRZT+SSqPwEUkxW0EaAKWoQWWUinm8IMfeVhxTAwQjOi8N5f7RYSN+
	fp+gieCMBKSf2kDNWnHTylXxcCp8YW6cxo4hPqux0n4mT3RfVn7Xj5/DQSCNBKN5
	X8TNJSDtpqwWZv2UwOMbQphHOG6tR2z6wZcmPhKlc6nZv/s7htklCSBP5slweqnu
	eTNeKd1dNAyUdM5POi0loJ4SwsLa0LzqG2+z2rPQm6qK983J/aVpDhqqEnyRm4Zj
	rKpyDnLTbIDEKpdoiQQyPH3JOHlj8UfVl6xA7bg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZMkDH6hzUU2gY/vm8mSimK822V498K6ezASVHzDxmTU=:c8bP7bCoinIyAXFkWnERHwMVoZkev/n3TztpIq/6mFE=;
X-ME-Sender: <xms:UtO_akO0rMxH46Lp43dAwnKWUS6b3D__ASHv6CmjzPUAK5rTSjA82A>
    <xme:UtO_aibqEkmwcJns83wRSZVjIaSo-SFmgiNXx72FZQdV5dNowG5zFYgWhnS_JBu3i
    K2KwsgNovWCuSrZ6pOS2BnWofHs2S-wickKLxS0b7Y2vyw-CEG5yg>
X-ME-Received: <xmr:UtO_aore8R7sgyyKuNIQCjnuvMNhIDJIZC9yOYq1pyh4kFcjxihGZuVKrUDBAIG5UmiV_IOj0UgcVDZn0XQp3dlmpX8vcVo1NtHE>
X-ME-Proxy-Cause: dmFkZTGWhgRPA7jTldj8b9xUK1zuBD4V30Osfx4rbkrnMcQtWxHV0j4dH24RQ7dbqyeZEf
    RUa6cRCze8pfUgchu/1puXQzSL03N2Pm81iK7sxtF3HI0cVMhEeOZTyl1KaheEiaxBqX22
    1oNfNryTnlzxFvFJZuG9cZunqUr7CkKvrGh9KD84lIHFUpIGo2B9pdaUffDDxA4WkC7vAx
    7+YkjvaFF/kfSu6YjuCHLR3AZMTQVSZmqkXEUpcxkWGYAg49BH7vGSoFgE2W1LNbnAeair
    qr2XllACyFqnO67TEsNJ9SmlO1HI5LKM9ifFrTk585UbYF+mHv8TAJVynXDdv+LrkK2quK
    26V6+oHF/n92u3snUXpkJ4+vyfzzPcGZP90m9J0MxglMqRFG8/X7ZQ+P95J6XZqVD2jYY8
    /ceJKqZrWpMNn6h9tvVzcc3/xkTA3HTWg8kx3C45JV1xI6TGauE0NELuGXmZUGcnIaW0Wu
    ZTJj0ID2tawwdLm2S3L+HGRGm2yp68dPzobC0rWpM4yfutHssz/yjtdLiTunc6FFLgXuZP
    idT5ndySGXEGCWo93QcHoARuFnWXAT1xGKSehJVfnpfvWL1Jr56EjUK+yzv9yQ6JRVOXOc
    nxAJTde/KD7ow68sI3DguM1tJcApegUf5WpNBlOUbYGS/ICOhFjmT0iRzM2w
X-ME-Proxy: <xmx:UtO_amZA7jam2hLbDgsMFFbaHG23G1f9qEZQ8x5CfM_PwKNJLDQwuQ>
    <xmx:UtO_agSLtq3GJuru4Gk9Rq5Ac24ZU2UO1boKNfTpmEScka_JSgcjkw>
    <xmx:UtO_at5J4KEL7ocJVlChN2aNvhPRd4Jfu6kkyR4Cx6wgyQKeuoVMPA>
    <xmx:UtO_alzxV3kWpqeYqai-0nwjFjtAwsdBK2NUwRzMxhDq9NM6GseS_A>
    <xmx:UtO_aiAyu0KgMG0X4mTHclEZsU4Dkv7b0gizRY4B_R00QImqSZ2wxnHz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 11:52:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <scott@gitbutler.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits
 and tags
In-Reply-To: <20261002081846.25144-1-scott@gitbutler.net> (Scott Chacon's
	message of "Fri, 2 Oct 2026 10:18:42 +0200")
References: <20261002081846.25144-1-scott@gitbutler.net>
Date: Fri, 02 Oct 2026 08:52:48 -0700
Message-ID: <xmqqjyo0yu9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Scott Chacon <scott@gitbutler.net> writes:

> I'm concerned about the ecosystem impact of moving the `git init` default
> hashing function to SHA-256 in 3.0. I have suggested that it may be more 
> feasible with similar benefits to add the ability to inject an independently
> calculated and verifiable tree content sha into signed objects instead.
>
> This RFC series is meant to demonstrate how this might work.

I have offered a few minor comments on the implementation, but those
are conditional on the assumption that if this is a good idea, we
would want these improvements.  I have not yet formed an opinion on
the overall direction.

Thanks.
