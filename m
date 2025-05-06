Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E238382
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551818; cv=none; b=G5htWaMa1KWj0ZURg3ryD+WNazU3rF3YHfzH0zYY1/Pijx9LMKq49rWXr0TldWZaVLCYci0fWVA0/Go6psTeTcZM8gxLbiMTjCejjGPBYUe9D+SQjLfo8cTjEfRv0OFjAnGsZ9qDGECQ3U+Q4xxzwIvx+ir5+mYUQs45ab7Le+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551818; c=relaxed/simple;
	bh=PHrzSvLiL11zxgytIXoMWlMkLiCtzkyRzH0/IIvVXRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=shu7P4obj7QamVxe9IPE8Ul4NmHXe2uLokJm4TpYnoTzyKoH3TgFfJikUHMtA8kgc+zjhjM4UkVuXPjjf/C+/dvTFaRAyzNoPYIneGAFf+adyNq5zBt9En/D2ZgICry0zp8HByGwznxY2QXEc60s17I2+TKnyxcUXnJkkLb4dKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eYmLrUyY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmfTl9RI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eYmLrUyY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmfTl9RI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C24381381516;
	Tue,  6 May 2025 13:16:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 13:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746551814;
	 x=1746638214; bh=/w/gKyAFsiV6fFqy3eFSiIlWiex578Cr/AsL0FOPMfE=; b=
	eYmLrUyYqQXPRX1cfa7T7mBvB7OtTRgYexWaSNso9fmmnS+bd8HIfmXi/5cX1Fev
	/67zB/bdGESN8yStWUm2KBIDCShdOt10XSFhiGEpfSpdcs835Ht9YXcy2QoFgage
	89e897zdrBXovUvP5TCEvQHq60LgsKFTINSsh/dYDPEP+ND8AfY0yzKScVmliE0/
	P6zQgfdpX43ov2tOgRzt6U6INTfkFXLoo0r4ldgw1CvyU+BMz71VPJPUuxMmVfJ8
	LIaPAH2zk87ROhkGVeJPSbgfdAfZC6WEL7zIzDHNe6AICZbexABc0/37jcZrSwmN
	8vxhDxRbKLGKrYAsbCJV7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746551814; x=
	1746638214; bh=/w/gKyAFsiV6fFqy3eFSiIlWiex578Cr/AsL0FOPMfE=; b=H
	mfTl9RIxLu5+fcZXqrYgVU/G9G/VGm2UHrKs6Hq0Hv3AiBcNjVyxAgt+pn8Ws43C
	PuRSD1KtA29/Tym1APDX8toppvibeGvCFSu0pR3u+yfWhN7VPMFi1bs0or5E+BSd
	9NnbHxhZcji+UxvtM1u1Clh6t63PpT4sG6iYt7NC4GD6iuM1iEosjJBL9sT+6pZO
	cm+JutL+T0bT9Z0my4Asq9GMJckfr7eKvGhgfAPlz1sMv70P/9nlchDEzkpGBzfy
	9+hGPX+BR3MvxjCPehlkS4w9o8NdHeIT/ykaqdtORF7Js30z3bdqlPDLqQsSjwzR
	le1i8iafjgQgSaZFgFaAA==
X-ME-Sender: <xms:BkQaaHSF_hOi4oIrKAudjLkDIjKxjJgDu_i4KmH2CyPQb8xUNtc11g>
    <xme:BkQaaIwmKxbpJ11q3cOg57Ea4_IVsijBZ6ry0SDkwhhUf3-UfNe4FFxAyim3cTZ_f
    dYq3lCKoU9y25frCw>
X-ME-Received: <xmr:BkQaaM2JcR31hP_rgT7fSgcrT91atBLsnj9eRidmnm20O6eVia2edLoMgxw46L2tVbifCDjFu6P0GWKZEaO80HV8dyy7tTJL96Xf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    eptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghr
    uhesghhrvggvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BkQaaHBGBZ-UYfskASsGeCcmSsti9m1wk8c4BqrdTWbQ_YLOqtSs5w>
    <xmx:BkQaaAhiC77zQNGzAv0ifv5R0ovLW6nwADUnenDlfuqBPEh8YUw7eQ>
    <xmx:BkQaaLqJMvUaCXwQ2pZ77znR3H7bqDGpgANwtzME35FbHU0eKEUm8A>
    <xmx:BkQaaLhRV4SrcNE7Bg9TSYPizbshOMpimJMrENDDzVD7TIiNGuzsaw>
    <xmx:BkQaaKYxAUWnyYoF5cJjFV9-b70fJNdGXXBGz5riU1KB9odM4VY5ADJ7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 13:16:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  koji.nakamaru@gree.net
Subject: Re: [PATCH/RFC v1 1/1] intialize
 false_but_the_compiler_does_not_know_it_
In-Reply-To: <20250506120644.186968-1-tboegi@web.de> (tboegi@web.de's message
	of "Tue, 6 May 2025 14:06:44 +0200")
References: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
	<20250506120644.186968-1-tboegi@web.de>
Date: Tue, 06 May 2025 10:16:52 -0700
Message-ID: <xmqq5xidlkvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> Compiling/linking 82e79c63642c on an older MacOs machine leads to this:
> Undefined symbols for architecture x86_64:
>   "_false_but_the_compiler_does_not_know_it_", referenced from:
>       _start_command in libgit.a(run-command.o)
>
> The linker doesn't seem to pick up the symbol:
> "false_but_the_compiler_does_not_know_it_"
>
> Initializing the variable to 0 fixes the problem:
> The symbol type changes from 'C' to 'S' and is picked up by the linker.
>
> Helped-by: Koji Nakamaru <koji.nakamaru@gree.net>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  compiler-tricks/not-constant.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, both.

The alleged ld bug and this fix I can sort of believe.

The resulting object file from the original code would not have any
data, but just declares a BSS symbol in common, which may be
unusual, and this forces us to have an explicit initialization
data.

Just for reference (as the proposed log message refers to an "older
macOS"), do we know if the toolchain on a more recent release of
macOS work without this workaround already?  It may be nice to tell
users what version they need to avoid the same issue in their own
program.

Will queue.  Thanks.



> Koji Nakamaru: Thanks for the digging.
> This patch fixes the problem here -  as a side note,
> the change in Makefile alone doesn't help.
>
>
> diff --git a/compiler-tricks/not-constant.c b/compiler-tricks/not-constant.c
> index 1da3ffc2f5..9fb4f275b1 100644
> --- a/compiler-tricks/not-constant.c
> +++ b/compiler-tricks/not-constant.c
> @@ -1,2 +1,2 @@
>  #include <git-compat-util.h>
> -int false_but_the_compiler_does_not_know_it_;
> +int false_but_the_compiler_does_not_know_it_ = 0;
