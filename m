Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6C1A0BF1
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768672360; cv=none; b=sbMWQ9EV2Wne3NlLXINQpllHLjldVSyvVaDOqeSueaK43jwd1LnxhdVMMjbCyb7sT34OXgHbLI0ejJ7e0P6AT95l9QgnzCsmDIVR2bSrrtTU7GBdjOeZOBdHkoadrahkNeOsGykGmwaDxF16k9r/I2zFOgWVmca7Mx0XVaDgwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768672360; c=relaxed/simple;
	bh=of+qh89PijhH4SCTlBH5PQsr2wbUM2puE9nwNXJ/O54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G8Wps5zVBdvJkAQ8YRswDuJWd16ajLP/z5U32GDZU1lqqT6DHqwroljI69i6WraYRzT8xUVKun+Ha7TRO14e3ciNw2iHHYk0/asdp6aabFFENgRxDvE8nvCw0Ffvp+grN1lsafHEgJqso/4iRuOZWYHZ8lMyffs6LReX1AODFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WcbDmta9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pxfvp37y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WcbDmta9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pxfvp37y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E7451D00151;
	Sat, 17 Jan 2026 12:52:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 12:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768672357; x=1768758757; bh=oskgNyM8DN
	Sc6i7A4A06X31kNdsJpMsh3lMK+SBdCqM=; b=WcbDmta9QAitekcAkehfZhDAxJ
	TUvmWfdjG8M4haMJihvscYwskPH3mqSMJm6pfLaNU/TfeZhKszNS6jUd7aButxpX
	iXJxSS5K6teKdHAI3NW/Sha9TW8EQKDRrloCKAHG9ql71lmb3wXdfA/5+SopSwPE
	JsBSQIci2qYngZ8yKSmYv2nn55o+NLDqneyWcvTIjNjHKQ+H2wb3gRJZw1Tpnd9a
	VO5vgPIlGiARcCvRTaZyk7S/Xc/PNAqG1cuNUcdrrLN8QgDHzdvKDwH3TKs90JSZ
	NlYc5Zkb653u66PkLLHE8WKpv6iQMDOzD4imyCq4GMrQf8MC2niqwk9SFORQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768672357; x=1768758757; bh=oskgNyM8DNSc6i7A4A06X31kNdsJpMsh3lM
	K+SBdCqM=; b=pxfvp37yfJWmA+UkbYRrkW+NDdQibt3sWWKrnAfoqhwzOWUHfO6
	gHDAXrc9Z/0oYeBS5ES7mYci6KYES3z8mZU6cjPqi8qhuxMiRdg5sEnLF8dvvrzz
	YZ3Yp5Un7S6sJEHujhas4q91k5m4N4NPr4hXu4B3xx6EwshoKby7uLSF+Vd7UyfK
	Kw5K2liR96luwOl128HrCD6y+RidTq+FbNcVEWypYvSLbXPhedTBl9XZb35dwBTk
	8yn/flh+GYpTWBXbTH13Sb5Y83CwcfRX1ou0ZzhletcxuSWl3WhSKxblTPkMAtlx
	4cMLdF/wNAhL7/L8SNQPsu7+VULBINQoPfQ==
X-ME-Sender: <xms:ZMxraeHWr_9vBzKpXt3VxwEtkXeOxixoMiCTB_aL36Z_Du3WYZu88Q>
    <xme:ZMxraZXBQYNGV0Uep7GAH2OZ0WeftTaxDauxCsrAAIIqmDMwxoFB_2zr7FNNkITO9
    YVGLpm0FwGjfTy3eapBd74YZ1c4Gt45e4Hy-RccvUN0_rR5ID5q>
X-ME-Received: <xmr:ZMxraezYhcoIxo3ju8FgTUdbMFN0tYJb1EjpVnuOsIkPoXiqEQZhYNHnmQKGUl5N1_8eFZBhkauvtmYYgrPOZYC-mSrwkd1Hmep2kvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhdrghhlohgunhihsegtrghmphhushdrlhhmuhdruggvpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:ZMxraWRiKf4Q8B30kiC8lLLgVhEJt0y4VLlqX79_OKYLcbqK_Us6WA>
    <xmx:ZMxraSgN-FS0ySJK__qg3YQVfgv5GJpx1Ae0uS47uWhlAWwMsGvUJQ>
    <xmx:ZMxraVlqAw25UikBQpMtpGScm3kFd2T6sTA6LW0Ru6vlC0ZHiIwSLA>
    <xmx:ZMxradsSKltiKqKiG8SMwn2XYpw-j-dan_MjvV3wD7pn2XKvPGFjbg>
    <xmx:ZcxraSCBOM5cHTThfuGeQJu7IYKMFsPalnhSsEk9oOvWh8AvgVTW1fkX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 12:52:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Toon Claes
 <toon@iotcl.com>,  Justin Tobler <jltobler@gmail.com>,  Niels Glodny
 <n.glodny@campus.lmu.de>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [GSoC PATCH v2 2/2] t4073: add test for diffstat paths length
 when containing UTF-8 chars
In-Reply-To: <ee088ea6ef91f0c349ed4940feab807d421dde66.1768520441.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 16 Jan 2026 01:05:38 +0100")
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
	<cover.1768520441.git.lorenzo.pegorari2002@gmail.com>
	<ee088ea6ef91f0c349ed4940feab807d421dde66.1768520441.git.lorenzo.pegorari2002@gmail.com>
Date: Sat, 17 Jan 2026 09:52:33 -0800
Message-ID: <xmqqecno6s9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> diff --git a/t/meson.build b/t/meson.build
> index 459c52a489..f2ad6d2f12 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -498,6 +498,7 @@ integration_tests = [
>    't4070-diff-pairs.sh',
>    't4071-diff-minimal.sh',
>    't4072-diff-max-depth.sh',
> +  't4073-diff-stat.sh',

This name ...

>    't4100-apply-stat.sh',
>    't4101-apply-nonl.sh',
>    't4102-apply-rename.sh',
> diff --git a/t/t4073-diff-stat-name-width.sh b/t/t4073-diff-stat-name-width.sh
> new file mode 100755

... must match this one.  I already locally updated the former to
match, so no need to resend, but if you need to reroll the patch in
the future, please make sure to correct this part.  Thanks.
