Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561423EAA0
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648781; cv=none; b=MQ7p+4H1/hwWvLQhCPe5jNaZtNE/shuPdUTBFOXtPu09aU+aFSHrnfzmZo0tIPu7wyunQEhuERLIlWqwf8NZFeLUrAMpZs8UuoC/tkNDFCi6lNf0deVu3MBXWIRF7Wf5SmKRSK5ScAPJXTokKPAxr7AZngr4akPHP2fi0e5NQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648781; c=relaxed/simple;
	bh=25F7EL8FHmxLwMS3cqFehJDRr26ZvtjUbXSaQQPdHqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNf+/Dkro/TqXIK/PMXDoA2LlqktjR+x4M+N0MRvA4eNJjxFDW4WlSeOnS4yP42YEVK+ridrkpm6P6QNJ0s1YeJfCzq2nSL+7vPDYXZYCLClLgImcSHf6GFi7zQK0EeTJqUCI6isOOLgeztUZVCJjkoXGMRo1b3yATD/xDvFNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jousPfQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z81I0Zvf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jousPfQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z81I0Zvf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0064D7A00A2;
	Thu,  9 Jul 2026 21:59:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jul 2026 21:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783648778; x=1783735178; bh=Q0KHXmWhPs
	3lcKYMM31PAQlHTj23ZRDlH/wy4pfZ6zI=; b=jousPfQXopwZnPZNEP0Y966cC7
	UIh0Q8SHb93+E+CtwKBhDNtptNMr3pXgzPGSu3kV/iQv4owwhgV251M7v/qn1jIn
	1PT+1DJkxMP1AZ2v2Zt6c6/23lT//JjsYOXOhvE3ZTJst9DK7B9c37KjqxGr30co
	e1SI+lEaWP2qWDoWPrBAaE0NUmPG2QyeCvBbyj0MjhbAgUelnkWkJnHkhuCfnfGZ
	dYGmHd3bjFWp0Etx/dYJ51b9Tpv+bbdLDm4B2P9asfUTawOd7IMthUJ6XWRcMSRm
	nUXE9NvhSJPzFX8iA2YoEjylt88wjKlF/0Z43QKTZlQtUMqzkcWHXyPM9DfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783648778; x=1783735178; bh=Q0KHXmWhPs3lcKYMM31PAQlHTj23ZRDlH/w
	y4pfZ6zI=; b=Z81I0Zvf5lpTFEcKSj3wd17dh/sLZgFAEN28KlaHiCNjJ1pcJzj
	YKwi6ILRAaIvMnWURHfd+pJe+z/iIpCNoPzyVxELgv5lQbKxZ/hMXOpiZEVEEgph
	Aa7bF4nspi64Ar+JvcpayuAWUSJgvdEQYzbFxJRalJuo6L2waObJs9PeQNZptGFE
	LUBngjjT7pbJBMoKrHojuJoiAH+b5m+M4jgboMqiXiTJWhS2qSeYJNBvjJAWiurM
	x9tO0+X2X4ShIgBvlv9c4OLVohHUgU1SgSlJaLRpf8NPonEGqTLOGSKpIo8fMew1
	l2aT2slGtc4f5Br6U3TKRdKDLGaepVHwpOA==
X-ME-Sender: <xms:ClJQavlz5AdLQ3jfGUoFaRaeLxMGHi0yNBwlcHJF7r9BUY0Wz3Q0qQ>
    <xme:ClJQah4SbAImEA_ea8fvv6v5dnXl4JahXKsu7t0-q1vZzM0UrkKC_4tfJtFVNh0LZ
    7sRNzIMYxmYqDeucK3DuMicAaZSJYV7CxQEVDYiXbwF8MnKxQK4VFk>
X-ME-Received: <xmr:ClJQar1of2u3R1FlEZF9QBcDhc5vr6YFoXPqS852YQJZ-GSFA5lH4fk9xVBSAYhjmxqnRYKNfdYgkECbL3NXD_rcBPS6zIyflcrwyJs>
X-ME-Proxy-Cause: dmFkZTE0ucq7GxAonm5muMJkm4HPLB9vC8kq5mlRYTra7dH19jwl70dhINQBoySj7DGVDQ
    8ml7VWmOnfW3amSEyjG2eipSuKeTUoGH+9397dvvhv0oUH7sGD65avWnQg4eR6wuby2VuH
    ltFKdq2zxog/0oY2sOqhsIDMr7keXDRNypCwyibqFpVmdkyR4vYEGC6EZNs3uz3WaQyuut
    6zeDTk/6vHHLVQctdcyVLGNv2QWtpKLRToppeO+hTDaMGUNCtTvj3K6Uz0d7dxBqOUGKGE
    ogYrOA+o1hhQer3Q+JJLwsrtWiQWMOQ3ZzHviWb5nGXCFexFZnj2A3WcaaNaveOLKkw1Z+
    t1ENZhN6AjNgOr00s9PN4ySH64YRRNQ7n7wqN+ZSiPm7/bKw8NnrtcO4E4vHMA9Je77cVG
    bCFjRDNkGMk096HoVi4pDAVR2lg/7NEQxDJqFh4GVF7OsVMR5KkRYD7sFFzmUj/YyPBrZ5
    f6Kl0lDS0Tcdcx0u+l3B17ZM9R2r5bb7M1g+2SPAKlsNa7ccD1J+BkPcT6LYd838SF8LE6
    rcYPCxNzwDPScG/vW+t51Kh1cgKDk4X4AVbvPb0+sAWmDPZk7oxCqQEZzgCd9gTFrFy12J
    7XPpzi3XOb4wj3t2237WQ59EqH68CBoT3kJYDFoOjYJzrvQOR6GuE0Lpyd8w
X-ME-Proxy: <xmx:ClJQakGEfiYez1WzUzA2B6ZKnw7qebyoSfmigoCXS5TmeHtkg4ziLg>
    <xmx:ClJQaihE24DteSCH7RRCYyvWvgWX2v4HDzoVb5bWZ5HS-sg05-mY6Q>
    <xmx:ClJQavDyL0JDkD251l-AYm9XX-2aPgg68iiSzheh1a8eS2WaiUhi-Q>
    <xmx:ClJQasRgsdoWNyMnBGMr4ItoQZl7Ri93BNSIIIPzb3zD91zYFiU4IA>
    <xmx:ClJQanwt5XOI5o_TbcFXL_glwfft8KiiRpAuv1PXaSyiXup5Fr2L4is7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 21:59:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Grayson Tinker <graysontinker@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Fabian Stelzer <fs@gigacodes.de>,  Jeff King
 <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] gpg-interface: still print ssh signatures when allowed
 signers file is not set
In-Reply-To: <20260625194330.3711-1-graysontinker@gmail.com> (Grayson Tinker's
	message of "Thu, 25 Jun 2026 12:43:11 -0700")
References: <20260625194330.3711-1-graysontinker@gmail.com>
Date: Thu, 09 Jul 2026 18:59:36 -0700
Message-ID: <xmqqtsq7haev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Grayson Tinker <graysontinker@gmail.com> writes:

> "show-signature" errors when the allowed signers file is not configured,
> which means that the user can't see the key that the ref was signed with
> without creating and configuring the file. Change the logic so that the file
> is only used when configured, and so the signature status is always displayed.
>
> Example of previous output:
> ```
> error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification
> commit b437db5ddc38ebda223bbae2087eee90a7b1c6e2 (HEAD -> master)
> No signature
> Author: Grayson Tinker <graysontinker@gmail.com>
> ```
>
> Example of new output:
> ```
> commit b437db5ddc38ebda223bbae2087eee90a7b1c6e2 (HEAD -> master)
> hint: Configure gpg.ssh.allowedSignersFile for automatic principal matching
> Good "git" signature with ED25519-SK key SHA256:yTU4KFs/g6MY7biDSlVStB63Gi1rCKg7dOFDXbe0yuw
> Author: Grayson Tinker <graysontinker@gmail.com>
> ```

While I haven't closely looked at the parts of this patch that I did
not quote here, this specific section caught my eye:

> @@ -528,6 +528,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>  		pipe_command(&ssh_keygen, sigc->payload, sigc->payload_len,
>  				   &ssh_keygen_out, 0, &ssh_keygen_err, 0);
>  
> +		if (!ssh_allowed_signers) {
> +			advise(_("Configure gpg.ssh.allowedSignersFile for automatic principal matching\n"));
> +		}

If a user runs 'git log --show-signature -100', they will be spammed
with this message 100 times.  Because it bypasses the
advise_if_enabled() mechanism, there is no way for them to disable
it.

Since I don't use SSH signing, I'm curious: how common or useful is
it to run log --show-signature without allowedSignersFile
configured?  If it serves no purpose at all, then perhaps this
warning is acceptable, as users would have to configure the variable
to get any utility out of the command. 

However, doesn't cryptographic verification still provide value on
its own?  Even without allowedSignersFile, the signature at least
guarantees the commit content hasn't been modified since it was
signed, even if the signer's identity remains unverified.  If some
users rely on this purely cryptographic validation, they probably
won't want to maintain an allowed signers file, and they would
definitely want a way to squelch this repetitive advice. 

Thanks.
