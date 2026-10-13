Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CA485CC1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912893; cv=none; b=XqhV79Wl/XYttrtYAPIYM1yWVGLQQ8XtN5JgUhS5ImK2TjBk71iJ88JtztY0kf0eClV4ztjQfmHwytoaXVnHWYmMvQrfuI3wDCv64YWAOt1infoSTIn/dlUP6rL4RMOMWC79CaO25XbmiXz8+g/1rEo3thbSMNWHqDdUYzUjRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912893; c=relaxed/simple;
	bh=bNEKyYnYWLTeng/m+VNzpZRK8a/ywbmkD/cBWZTMAeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAIhNyuLfcqXHyVy4QxAaQTY24YVtW0h0ZATWJEHtST10kSmAPOPQhheGh3vEXzrsM0gS9AgsKVx52ABg35PEfIYSSrA+P2H7jhxD7/OJBPy9qNlUMrxvu3w6pulWjl4ZRlStuhKltaoq0Vdo4aO1wAS91mqdpXJ/z5cPQwgRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fWDPNNMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HVx/xnt+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fWDPNNMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HVx/xnt+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7743E7A0106
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:34:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 13:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791912891; x=1791999291; bh=ICJVCfoALX
	UYQwSjxuUamZoQWrVyD2jx1bdaehJjwhQ=; b=fWDPNNMv6NvfSiTfC++cT1Nps9
	mQD1YHSHtzXbOy3ivy8MvN0GmdBrtmbKXhYvxYmITzn1TI/qZZ0+CILUnNnN1xqn
	rv6Foqq3gVsLsnXLhWopTAhijtosg8fYNQ/SJm8RF2PqUHyi0dLOXx9sgoVUywVf
	ABaU+UTsAlL3Q26vicC4yhgA8BE0AxIJHpUIJ5ZmaoyStvJ5oFo5D3FPWnnAc4rd
	27eDpvlFcE4molN25+O7ieJv90TJZ5VDuWWN5IqgJHOe95JDBeg78VATzPs9TDk0
	4zZGpCnCoJTxuqzCadSuu9O8GnSOfsUHMxrx5NDNjQr+9jkkmYoTxVto68aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791912891; x=1791999291; bh=ICJVCfoALXUYQwSjxuUamZoQWrVyD2jx1bd
	aehJjwhQ=; b=HVx/xnt+TWewqzoOhjCsAHur98gFzc0ms9lIDI0efFanrs/4pcO
	qqZBCpdQFVkIresFi9DD4tVH+igbte78+8UNZ/JRz83fiN5+Q2ZFHs3Ver/dLk1e
	i7Pv2EgrqfGxTpa1gSJ7GG943LPeLn+W/k5VDz0Gc+9glfTaKkdcdGQkIrR3y8c8
	GxaR4U9TK6c6g6GYzcMECYT6rN2Uf0QOcnsabaXxAhKFNSUEzUVtJbBbboj5AyjO
	zxDW9LnFgZbUbVevCDNfWTc1GjCEZLd6SOy2YI8t2SoZWJHjwBcVAZOuZNBWnMFN
	kRd3gICLSMx3rlq+1SH2/ASBnyuYvF19CkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791912891; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UE9xS6y+0bGmaYNhdr9LSH/AMETZDnXxGTMRqor/Yau4BTV
	04WMFEa8xGxYTMmIUvb8UukcYJePjHqKqGHF02jyz3XNrfXYW9LPnemS40ALMzSV
	duuRag0Pd2RbremCzKp6l9mGXaKKSbDtjrE2vsu3p1J3qt5qmANoAagswBBE7GZP
	L7n0JXqwCm71fKM9bBWoxpdMRuOwWIMd0/570MO/FAOS2CbCL9q0Sq0ZgGnySMsx
	RFHzV8IVEkDb7h98j03PjTFJygSF3wBNUgKwO0N1+MByGNC5pPX+w85DIgmwYEqb
	ARW4ZWjkcRlZLw6y1vEoimQD3vaZvmMQQindgmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7VBByIqliArsJAh7itS99IIvbOr37uXDSbPlSs2bgOg=:bNEKyYnYWLTeng/m+VNzpZRK8a/ywbmkD/cBWZTMAeo=;
X-ME-Sender: <xms:u2vOagurNMqJFVAk2aZokLTRjSVRakWM0yjn-jg4LMKd8dOgNL9rgw>
    <xme:u2vOakWcab2GYgSLB_zy_LLZ_vHfuEVouLiqzihHBg-XOAUiASSXLxeEyahPLitoZ
    by19OAUqCgd9zuX9ZPMDcAi0jiXRedclACG7QhX_-U8zc6Rhp5T6OE>
X-ME-Received: <xmr:u2vOakEaDBHCd0KMaZJ9FmHcSUBJ-mcbgq50tCl76svfqXS7myzh8Vx-hLiy4-TiCnvdwUutMCdy7gUjMP0Ktn9_59flYkaCuIoB>
X-ME-Proxy-Cause: dmFkZTEcGaKyiYVAdkzDFei3qJEyJF+sVI9SatkegmWiDBkismyUN4RUq/AkshZBleG/4W
    v9ZnwmMLMnmAKP5txIRhmvNUYcrD9fv0KCYedNMYeGGZl946E65vDcwikdS8BAqtv8rAYa
    EVnUANjNjnMTd4TQotuJDskugN471wC0epSCf6MtMgXJobjerdufreu/j5+zigURayXeQf
    tvtnRuuX9Xl/W8A9xiJadsb9BPOki8qb5K6YGYJszAV00RT8wouPUyVM7v6njecd+/jvSY
    Pfgk1kJt4czY+rQhRELsQ8rrSVBVPV8PfI0HnjYVJ/gef1NcgbWKbX/hsS6wHxBc3FWJtg
    qHUMacMrQ4VOuCSFN7kbtyLCiVEF/ggHBrWJ7/RaVH+Zm12fPuCr8BRpT2pY60BCEPV973
    /8EShEdxxN6GKn7VZUkaVtsDWsNL7wHBVHni/evsnROVbrwXaz8FxMJyuk+trzQG/UancY
    YRGMyBzyh1Hf0Sw0/Fc3Flb3qkLuHswT1dv+XEJ7HC5e7flJbuDFmV5khXJJFe5LqZxTp9
    M+qINF5RHLLd+7/8ef+e97LrVjQFu/EF71rUYk2TzTaaTLwnsm7riHf8rPCtQPf/MfoVgX
    o/gjUWmCFbPJ7gaNrz79l/mAoAJvPyULD25tRBy9Iny/hz2s7ru4pZMlXu2Q
X-ME-Proxy: <xmx:u2vOau29Sjk1bf-HYjkqbXXvAfVuL-dl5lfYVEso3edH2Kv_mdLCoQ>
    <xmx:u2vOauOIB126uCgp9nND7esDbIlVdELNCM_N2GPVEYU0pd0ImOlcpA>
    <xmx:u2vOal6UcXC6hJGcMOTGZCIw4xGMkb6bP27IEOznQSH7Cw6W-tWoRg>
    <xmx:u2vOag3oiYwuTbI5toJgHkEg7WgpQmc4MoHz0Gg4x6fv6OOLL5SWsA>
    <xmx:u2vOall2kp6wd-lncyHjlL9KUyfGrRKzzGJG1CH6ZeYyg91aBu5vHoiv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 13:34:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v4 0/3] checkout -m: recreate conflict labels
In-Reply-To: <cover.1791906474.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 13 Oct 2026 16:47:52 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791906474.git.phillip.wood@dunelm.org.uk>
Date: Tue, 13 Oct 2026 10:34:49 -0700
Message-ID: <xmqqzewhy05i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> When "git checkout -m <path>" recreates a merge conflict, it uses
> the labels "base", "ours", "theirs", rather than the labels used by
> the original merge. This short series teaches the ort machinery to
> write the labels to ".git/MERGE_LABELS" when it switches to a merge
> result containing conflicts, so that "git checkout -m" can then read
> that file and use the same labels.

Both range-diff and "git diff @{1}" (endstate comparison) looked
sensible.  I may take a deeper look later on individual patches, but
so far this is looking real good.

Thanks, will replace.

