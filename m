Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF136B92E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330353; cv=none; b=hbAFcnAYu2s0semF/NC2O6cdx3S4cBqMnPCFRWUrUAlR0MEauxy/nXXroF0rckR8dP59SrIkTlRzp3xtE91uXEXSsRfgoBbRPGsGL6ibNvvs0O7Sp9ZYroMlG/22tWrQZ2uSzPLlEMKEv0No+M5FDhxP65MQKX1Ln8p+pJDWpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330353; c=relaxed/simple;
	bh=6WmvBtWX0zkvT8mh+arOMX3HqsrjBgS2LIF8IAWPWmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npZ81N5sRDY49tGZfwbeP2YdxfD2NFhRKWZu1upNdl9Q5ryNh+n8IbY3SbpiEvj31Q8+MvoqIpahz5J2VEgNWRGaQFdGymTvdWUSUM/R8A1XicmeuGW1SFhIiiHGtwCVx5gAw0sbQJ5XRJu4rRH6cvWGsSBqM3xFm3jmqfJpOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgXujVM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNSZuqvp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgXujVM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNSZuqvp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AC80FEC024D;
	Wed,  2 Sep 2026 02:25:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 02 Sep 2026 02:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788330350; x=1788416750; bh=6de15sKgm1
	1rUagFGyhzzOomdYC3QxmLgQTVuXxYNxc=; b=JgXujVM462lrI3+RSA/mcV/vA2
	ZgG/jnfKz8Fj0SJFhRMz+Q/1XvirD1uupTriwSY9fmtualN90QL0N97rZceKOcUw
	4YrHt6Ekv3uQiCxaCtMKJCG26wxXADg7JEwcwdW/O0IFno1G7WMbbyFSX4sLlvMb
	3u6nV6Vs+LoYj1BKaBQsbsP6c2FKLwfOIKJQO6/exnlouc4ExTCQE3Zpitpq/iLK
	HD4gXCYlNF+dCnyEOdpbzDspaauKuZjaCGlJVjdRU/kGHpqCRQlY/E5Q10mw5bMd
	h3o0XW6hGZJmxd41EhWllzAv9tWp1M7Mr51DYH/RkC3CbyRbLY7nLtfd0Asw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788330350; x=1788416750; bh=6de15sKgm11rUagFGyhzzOomdYC3QxmLgQT
	VuXxYNxc=; b=PNSZuqvp8dfhqUAuJ2Gi88ZRcmRNtJC1hqADf0iYKUsKM2GQWDE
	KWL7oaX9RP8jbZ03rRDrOfMmFSpPkgnxgnOrrnGDn7nWBEJlG7SYRQJbwPSHKW4r
	vSpnXdHZlb1NhnyXwkv+qwEiHz+C5B7HmG+SZQ7xsKg4nNGql7T6nnOWWrbrCk3+
	BAdYvjwMhgyBJIXwSc1oU7aLkQcpnVG7JP19jKU9gtgh3eGJfikaIhAqm9z9AsSe
	fjAKPvutmGPivLWVhtSITCX7WtdfajUmYs+qMkT1dL14J/zdpLMXiJYf8wZOqFvV
	OwPBz4MoV8+jdDalN6rW5FEzGpg8ZDepeJA==
X-ME-Sender: <xms:bsGXapQrqkR5snD2ZKgNZKcBhSnagLOU_0uz-xH6lZeNQDngERpb0Q>
    <xme:bsGXappsOL8cGiEROGuKGYZlsJDfLiTFfgzROeJIEDxPqD07spEQ9NIVK68KWWmvr
    8J4RCzqtOzh3BMHya6Tte4EyVza1PPtdV5HE56eULSuhc8MniUt9vY>
X-ME-Received: <xmr:bsGXanIso2mNLXUTF17dqo5Ed1dBOlSkyOK_d0VmDHOSF8ELIhvkoak7Ot0oaGcchQM8IkkR6wcsci_Gc7D55kRsyPsxGbvkyw>
X-ME-Proxy-Cause: dmFkZTGilXaknvXtWaFAnuRXp57ZppvJ8VdeFqIIdLNnO5RBP9EllAJpUeG2pukRHsh1iC
    avsLYjJrg9j7UbJmPCgmCNC9g2HdTMWH51agX1Lo48wIMEEYePDvID9R3s3U0znnNfJsKr
    nzFdAiv0hZCz4y4bHs+ICodSeJBzzTjoVy7peSZtVXEYbFvN/EFNapYO5Bu9AXcSoQR1wC
    RvxNZZObHpzurVGNKDSq6kh7va0mGS8tRme3eWeL2VQm9XGOtMAc1v2eT6utEwG0rZh9yZ
    fE4oYcQq0u+xajDutFVnRjeQCfem2R9orhDxxNDjFaXE06Ufjx1kc4bFHw8lCvh9DIoLdG
    1QhL7uL2+7ODUo7xfkod2de1XQRIcNJHeogmNBjNnWLigUJ04/Y1pJRxupuTsoRHa8BMT+
    ev5/1dOYdaUbUzn8jY24Jn3GoKWyocgUUzdep7SFapRsH7gykxIpcNbi0kz0Q0FUF6XBHz
    hiNqSfOcgfIOuLqlq9krt0ySVtumLWzm0mosfNqs8wXi9h+puFamb5fey70jrF1VK0WKaE
    by8a0UOpKPfcZeIhiPJk2zxoD/ACVFjBeWVJccADvumF8qLZC8Mbnizi8KchctJDj7W+/t
    ZU1rTO77h/9TQ958LmjKLiyflGioqu/bx3v4RDrACaRCw8x3mihEUU3aEjQg
X-ME-Proxy: <xmx:bsGXasqCIe8ZXxCwGJHEDUUKezm1B8qRTwzjAGpvlL1BjwKgySSI4A>
    <xmx:bsGXavzoE-CK2JWMKLBicYnvjfnTwKBz0JfrOD7ThdthuQdvpQTJkg>
    <xmx:bsGXagP1GKDIp5_LgqYkxNfD-pECoGdkpo41IQBmXEuIS5vWoPHOHw>
    <xmx:bsGXak5MvmU-aIIwa9JS8JQ8cADLexirXpItOQGOLfmURYQzlUIPXA>
    <xmx:bsGXajB0orylZVVo7LH_aDEfXMLztT6yVibPRAOrsbjLP7c-HfLAp77t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 02:25:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
In-Reply-To: <2b7f58a037592325c2cb9b52bf8f1ef434bd6202.1788272509.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 01 Sep 2026
	14:21:48 +0000")
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<2b7f58a037592325c2cb9b52bf8f1ef434bd6202.1788272509.git.gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 23:25:48 -0700
Message-ID: <xmqqy0dkjhjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +                ifneq (,$(filter %ARM64, $(MSYSTEM)))
> +			HOST_CPU = aarch64
> +                else ifneq (,$(filter %32, $(MSYSTEM)))
> +			HOST_CPU = i686
> +                else
> +			HOST_CPU = x86_64
> +                endif
> +                ifneq (,$(filter CLANG%, $(MSYSTEM)))
> +			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnullvm
> +                else
> +			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnu
> +                endif

Assuming HOST_CPU is x86_64 in the above, as UCRT64, unlike
CLANG{ARM64,64,32}, does not match CLANG%, I presume that the above
gives "x86_64-pc-windows-gnu" to builds with MSYSTEM set to UCRT64.

There is this "we only need MINGW64 but the switch to UCRT64 is
imminent, and others are for documentation" part we see in the
[PATCH 2/2]

+        case "$MSYSTEM" in
+        CLANGARM64) target=aarch64-pc-windows-gnullvm ;;
+        CLANG64)    target=x86_64-pc-windows-gnullvm  ;;
+        CLANG32)    target=i686-pc-windows-gnullvm    ;;
+        UCRT64)     target=x86_64-pc-windows-gnullvm  ;;
+        MINGW64)    target=x86_64-pc-windows-gnu      ;;
+        MINGW32)    target=i686-pc-windows-gnu        ;;
+        *) echo "::error::Unsupported MSYSTEM: $MSYSTEM"; exit 1 ;;
+        esac &&
+        rustup target add "$target" &&

that maps UCRT64 to "x86_64-pc-windows-gnullvm"

I do not know if it is intended.  If so, please ignore.

Thanks.
