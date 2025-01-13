Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BF4D8CE
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787686; cv=none; b=g6kmxNjIFgzgPxuuIljmA+zGLlCgWQZFOG1KhqRxakJzKayjfUTbLoBl2ir1Yoz3pQCBMPWIqHkOvNPrgtJaErjjWNAflOVsemZ7SXDEMaYy2kp/dvJ2mWaZA3Eo1EkVYcAOHM85ZJnDBW1pdR1/SNXICJ9IunbFQoAFHo/C9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787686; c=relaxed/simple;
	bh=5N0XhyusXDJibir+dfg9GOWo4Ai8QRijIxDb4MFFU4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mL3RGix58AwIaV1uazb3Q/FHu34albJzhG3DY6y70id6wPz59/gtXCE5/8oW1l+IOEyZXfbz5n4lQ7LUv9vCpdJNio0OmPYqQPI7ycQudNNMTOIe5qa1nw7uz8TAIf0kEL1EIJ9BTbtWzshKDWzrCuICYN1iUeKwZSSXkjGWmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mEozWmV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ySUKtg7a; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEozWmV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ySUKtg7a"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C145625400DE;
	Mon, 13 Jan 2025 12:01:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jan 2025 12:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736787683; x=1736874083; bh=G8n10i69t9
	rZ0Mvmnzqe+pCnSZ0ZtWErsMgZlspfbPU=; b=mEozWmV5JDy3Xzcd+ircv3jqdT
	j/6aeyMW0kRU4nm9E0qWVn5C6G5+0/GsXktMZ47fBK9xgkSTSwdLCs7ob5hKm7lo
	OZxzlI822MNXgQ3uo5FIYnEd14JqGnBHyWxnfVU8aqJq++8T86hOMXnEzfZSMkve
	X44B9fq32D9FlI8Dv5+JbUebs8NtH3QDzBXYqcYQtT2hJTtLORhs3Bs+BXLeXHSg
	wcGPFoYiUAwDcOaoA4fpo1kG1kbYeo9E5gqtvh9aq22hz0Rv0/JTzLeC02kSVXsb
	38SzWPd4ylDCaTdYKhlBMH6Gmbzat2TTKrCxtDOMIhbZk4Fbacre+XP7tx1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736787683; x=1736874083; bh=G8n10i69t9rZ0Mvmnzqe+pCnSZ0ZtWErsMg
	ZlspfbPU=; b=ySUKtg7aG7+ac9We2TFW1KjKvo7yOxhiznIZos/k9GGoBGVUewp
	H7q1CK7lyXRPEgu+3bDdyGHH83RMXxvOFMqlwWIZwrmMudcpuqX9/xePRp65amFY
	LEsiDiyjDSyHqXoZ9lKC9IbTAJOojLaJ0K5s6sLtausA3hJR+yPZnQO7apsAWGnJ
	b7adWuEGREirBdn2tkjmh6E+p3Hh5oxqBTBpoK1nIIEGiAMeBaRkt3H+OFu3OYaT
	1QKg99yJcRYjvpw92xdtEz+15J4swySf51Frvsa5QEXBagAcMqI/HHNiGIExcFsa
	AMHp4zkm904KLoESP05nF8/VnM7Ly3muOkQ==
X-ME-Sender: <xms:40aFZ2lXAwM_NPbFZRtyOLtFBkaLAknIPxfQIh91ggLTt1C_MzXJmA>
    <xme:40aFZ92ptjMc-aXlRT117npgpapUiGlXUNZKDYfkk1pdABw73jT7qwOuaduioCp0g
    MoNqlIeFIVTvEuJBg>
X-ME-Received: <xmr:40aFZ0o5f1b1b-8NdRKNc-5iIgNM1y4IY13EgDtVuB3hy3DPqYsVamL6PlT0FIO6kfLSr9R6ytw4_ZQVXTz09WaUdrSAgPyqH2Up>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:40aFZ6lMv2Kn_7bhHnOO8_0p1UoUtSlNeoTrM7Wq-JDW3GDKqozjYg>
    <xmx:40aFZ00-Y2CilIOKqQQoUMQAs5UwC4ocj426PqENSsVLAPOTsDkqEQ>
    <xmx:40aFZxtRHer0MBFUoMTQaihyPoATkOPi5Afz3fg66tOkgl7Fb_Zt1Q>
    <xmx:40aFZwVc26afZ47C0FHK-2pUiAIv5Nqr0AxX0K7L9t4Kr2IUAiz9Dw>
    <xmx:40aFZ3SGGH0Ka5ERHrgiaCeaSHjx24uiLm0V8GDLH3SsdZfEDcovJj9Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:01:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] meson: ensure correct version-def.h is used
In-Reply-To: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
	(Toon Claes's message of "Mon, 13 Jan 2025 11:28:04 +0100")
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
Date: Mon, 13 Jan 2025 09:01:21 -0800
Message-ID: <xmqqr056abry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> have a `version-def.h` file in project root directory as well. Because
> `version-def.h` is included in `version.c` using the #include directive
> with double quotes, some compilers will look for the header file in the
> same directory as the source file.

What happens if we use <version-def.h> to include (which is how C
standard tells us to do), with an explicit include path specified
with -I<directory>?  If it solves the issue, that may be a better
approach.

Thanks.

