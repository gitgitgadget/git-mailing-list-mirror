Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5604282F2C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640102; cv=none; b=rh3Ey+Vh1D9kKZtHYcqPKlCKVXPpGfvAbLX33bWZpzl7oC76WE5MIRJr3NvVb/wKDeOCr288ITP7yfDGxcQ0agtGNbEimQBuXve9nmN9lsbgJ/UExju2QJGYtKfuRCUEQusHGTSDa44fD4QjbkD5PPaKTZFvlf6u9Xz/V3lmjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640102; c=relaxed/simple;
	bh=UJE3F5DZcQkjp4NiWePN0BKtcMYCZnS3eBZA4DnJAwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DkLMwai6nGrYMLyF250tN3MCBYK+bMESZ3558uRhyHCjiquOSRzLSX/YCpSmmJyU97hxRKHhiMxwuAYVHIiPm5DTqUBfCNp9ztyQopFcPghUyArgpy5zYIKBD4PuWE/lK/onxSP0BbpMbhRxiUB8wSVEAiipuCGASECaLB1ueAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfI8IQWa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FSGhrTXR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfI8IQWa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FSGhrTXR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D7BBEC0209;
	Tue, 16 Jun 2026 16:01:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 16 Jun 2026 16:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781640099;
	 x=1781726499; bh=C8UkZYR48lhZaWfRuo48fO+U9xnEreRmRRY4YJrsuKg=; b=
	XfI8IQWaiZ6Tl9qnNkDAp6KnfIXRqi8MR2IM95LnZ/xNGjpMhPtLVYdek83vhqce
	3DNonBL8Uydv7HmIquO2HrVVNexGsdG1YB0jjiZ2+GiJ6UCpo7qJKUdOdWzF2xbD
	hGFNKJG1Y62XWSg2oGrUGReSoA8MjkN76GQKdjUqgZ7Hfz8TKlkHFivXT+m7wNlf
	Vvqdx8xkq27biail2lydF30h+hWx42+0gqNktCkMWlCR5OL2VEU/cYn5NfTT3CCx
	WpSph7koJ1GmA01Ql/HL/EeS7XnFstwTnHz1wr2euyfzEAr1cYpu2o3OcDlms7pL
	MvoVWR/rLQ1lw5tn/0fxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781640099; x=
	1781726499; bh=C8UkZYR48lhZaWfRuo48fO+U9xnEreRmRRY4YJrsuKg=; b=F
	SGhrTXRDcbbEU3KU2OFN928yfsE7x9GFWptFHNdsPznQIrAFgT3yLtVJnwpBF98+
	+o4GUpS8JEcbPVekfAQz5M3NBJZBYm2LSK3sogfRVd1qeYtlPSMCmO/4nbu9BlNz
	dBYIjeCoPPFZJiEECXYvJJ1WCfiWrdoKp77lqrGuNURZM52/ssirFAZASHAoo8JL
	IrMq3Rhh8XUr8rEdC6OkJUlLDSdBoapTlzkIKGzqcy/Au/F1gSN+2axaUcfOvzhF
	jS9bAIEv1OFyPID3bJUVn8H8nIaePBLSZ9qS8CMCPx7OXXIFmX6WxMc2GoIUCwSo
	M77EHTrTBvAy/M2/jjmyA==
X-ME-Sender: <xms:oqsxalgYeo2bjDV8Pcl_Enpr5tLd4DO1fKMjMC_ZgJu8Q4MOVzrUVw>
    <xme:oqsxahdlzWH-SncTgJC5WXBTpQR8H40bRINoBhOFq5wwJem03RGd8wyoGNMHzmz8L
    cNyspb90OYPfUfGUDyKdBETrmjUaQwGttdTkUo3Oiq8x6WEkTF8>
X-ME-Received: <xmr:oqsxaie9-ISLc2XiCJJF7Lhe8tuZkSXym69j74x_Z7G2au47o11JWjDnIqwFAKQSR3h9P_6_bPNZ4eIKQ7-zU1OQg2OVkrKxa51x>
X-ME-Proxy-Cause: dmFkZTF8I82rHxv8kCMgErreGDYawgF26ePrMNhgGvs0WVvkdcQVqIR3WwtAW/p5F5++QH
    pLfbi7ZhRamyZ3+uPAFbHhWd1sHi8Gz1In8joTKYgsVt5mqD+j2Ne1npI9DaVYJm3k2gTs
    H5L+sFSXpvJL9oiUZP3xtv3mVS5ufNTENnw5gnBUBVUqgqqVxREFv440HpyTTHCzaLE70W
    gB4cmqfIwhCBr/TVuLMuOCmXifVyVvrvVpqiL60yrsM4R7YdP3IHAZWsj0zCuhKz9/JF8/
    fL3c3o3ll9WcnfUkSkPh9bz1d2/8ksyQLDbnKbI4ifZxAM90+UM/1khnhhWvHBwahjrAPk
    Ecfm5UUPyMjyZ1Gg34Xn9R4qeEiqIJv2WzuULXe7wAxtUBeKnStAZ5S08009/lNwd62g/7
    jiu/s3gCqvzOpyJm7Cj9DK50j7d7vcqpbrDg6z+Adgau3C7rLrCXNim+XkkXpw8lHzpLei
    TqDq1YM1pqkKtqlB0KpuXfDQ0tkPirhjxjgHC21m6/I4pII3gKBEly+w2b5hlm3xcMKFOM
    /sxHvSjlGGI/Wy17h6MYl80pQvE+2+n+4//MI16dh7LeC8V1AAXtZ0he+cNEw3tfggAOUU
    NsoZEauP0fEX3yUQ+mpoBID0y6kTuoNAajbHT0vQ1HNfbC+glAVSIb2/V+Jg
X-ME-Proxy: <xmx:oqsxaj8XmDLXEUQGp1lZBaSmQRceHLdrS_6eEme13tJ14swCi-bEJw>
    <xmx:o6sxamn7GapP4cJNxuka4akSL96GdJ05ph3VC3Xph5NKxTPs3i69hw>
    <xmx:o6sxat_iTaKdyB1xFX3NMT26AZ1Y7Zv3RRJ8m_RlBd1vMwqq7VMsFg>
    <xmx:o6sxasn8ZArsfYKsdilWq7mPC5nK0MLWnpSWp3J8LA5XE7ad4qC1yg>
    <xmx:o6sxapo_sT6JUEUHn2CGVvbk2fC8J77iW6rh2KvhHkAnMk2bf7otiswr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 16:01:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: SHA-1/SHA-256 interoperability work is functional
In-Reply-To: <ajCWBG9RHBrm8jMZ@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 16 Jun 2026 00:17:08 +0000")
References: <ajCWBG9RHBrm8jMZ@fruit.crustytoothpaste.net>
Date: Tue, 16 Jun 2026 13:01:37 -0700
Message-ID: <xmqqldce2r1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm pleased to announce that I have Git fully passing the testsuite and
> CI in interoperability mode, both with SHA-256 and SHA-1 as the main
> algorithm.  While this is very exciting, the work is not ready to send
> to the list and is effectively a draft, since there is still cleanup
> and efficiency work to be done.

Great to hear about a great milestone.

> Features which are currently unsupported (and which may or may not be
> supported in the future):
>
> * Filtered bundles are unsupported because there is currently no way to provide
> 	a mapping.
> * Multi-pack index cannot be used as the sole pack index format because it does
> 	not yet provide mappings.
> * Pack index v1 and v2 cannot be used because they do not provide object
> 	mappings.  Git automatically uses pack index v3 instead when necessary, which
> 	does handle mappings.

> * Packfile URIs are not supported because the protocol-provided packfile is not
> 	complete and its objects cannot be mapped.

Not that I specifically care about packfile URI, but this one is
curious.  How would regular "fetch" and "push" traffic work under
the new world order?  Presumably we will keep one characteristic of
the protocol, that the packdata stream is the only thing that is
given to the other side and no object names are given, because the
receiving end would not want to blindly trust the object name the
sending end _claims_ to have sent and instead recomputes the object
name out of the packed objects in the data stream ("if we rehash
and recompute the object names from the datastream, the other side
cannot lie to us" IIRC was a security measure).

For a regular "fetch" and "push" to work, we would need to recompute
the native object names and also somehow compute the compatibility
object names if we are in interoperability mode, no?

If we download *.pack files from a packfile URI, wouldn't it be the
same story?

> * Large object promisors cannot be used if the server does not actually have
> 	the entire history, since the server must have a complete history in order to
> 	provide object mappings.

Again, this one worries me a bit, but perhaps I am not reading it
correctly.  Does this mean that the server side says "this is the
data for object whose name is X in the SHA-1 world, which translates
to X256 in the SHA-256 world", the receiving end blindly trusts
without having a way to verify?

> There is new documentation in `Documentation/gitformat-hash.adoc` that
> outlines the requirements for using the protocol.  The protocol
> restrictions described there are hard technical limitations that cannot
> be avoided; I've intentionally made things as featureful as they can be.
> This imposes real restrictions on using protocol interoperability with many
> projects, including Git and Linux[0].  Interested parties may wish to look
> at t1017 to see what's tested vis-à-vis the protocol and
> interoperability.
> ...
> If you're interested in testing or perusing the work, you may get it
> from the `sha256-interop` branch of https://github.com/bk2204/git.git.
> Please note that it may be rebased, rewound, or otherwise folded,
> spindled, or mutilated at any time.

Sounds exciting.

Thanks.
