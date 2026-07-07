Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD5340419
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434409; cv=none; b=NWXgOe/6aOR3cr+2STZchPiIfbwVucMgIPLRfEhdADecc7M6S/9SS22hxP2y+w4sGWJeqDiuMHDq7MBDXGdMUY3j6m4BTUuL7nn3AGRdIShriZZcIuTGnL0m2s0/MuPKyWWBrTm0GV4wag2A8oyW5yhDu8U3T3WJNh11YMBTcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434409; c=relaxed/simple;
	bh=sr4rMXDxXsSO/0iSMZRpwWgW9PHf8Fw4Wyy6N6E+yU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDWTex3EOdUO7b5ZNxbj/2st+qyVfPSpNtLcNKS0eyKSBkhdY82yPZo/VeUvQ9O9Zy1rNFW+MwhARAj2+iQJC1NKdsouL/l82TYa9ov6dFD0bx7gw9VfPKrRpzyv2wX2pwrDTpDgYn8B14p2QwK/oOmzX8vLsJqCXLUX3RnGVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O8WmzpHw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvGIg5dp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O8WmzpHw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvGIg5dp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFD6D1400144;
	Tue,  7 Jul 2026 10:26:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 10:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783434405; x=1783520805; bh=EuwXkgcpDj
	NgGOMNHuLJmD+Kl5lqyZB3PTnBmSzNKEg=; b=O8WmzpHw+94MCCF3BFphRFW5Wc
	8qChE3hcZeAYm6Ao7ZjxzgoHh5Gc2Clk1swO04+KhwaBB7LdCAaitmsqzarxBJB/
	SELKSfSdbKuV1vbMMFOzUVHrj9+UhqD/14Fjja1Jk/OetAm9IpKsFqfpVA+JKTqv
	JRUTEWEe7LQYBcSXB5XTZDVV5TLmHmxPolFrGr3GfspeRieg8cYP3dzqA8PKIEZ0
	YbVYHBEOeqcVtqiLPFVevO9KBrcdIYdMZzJWvSibwSVZeulPqJYWSA2lhhk1ufAo
	HlAEsR3Yp1CjfuDH9kb28jWO2JDqAfv+rjlHGmDf5bMPTKG5pxyq3LbZNIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783434405; x=1783520805; bh=EuwXkgcpDjNgGOMNHuLJmD+Kl5lqyZB3PTn
	BmSzNKEg=; b=CvGIg5dpVZmR5IHlpNYSGemQlyaYP9akaNgT4yLhtfivdEKlp0P
	w1CWCmFiVxxJwHfW7PBSMjMrbNjaE58aG4MEWFPTTkJWJBW0juJLH8u9DKpSM8HV
	Kizzda1BeKICYSoKEiUpVVhZ79scSHc6JOvBVuLpgCndQLFXbhniGOxRugljHBBh
	wrdrQYJxEOCW2i/Nn6YKeSSebowwl8p+6YnFsTRbuZX+K3DLkI+m1oq603eww7/p
	VVQm1haChqKRsu2CCnpzxof0hIYuVTcwHvKHf8hKVmLJF/jfAlwlRoJ4sI1qMfB3
	YvkjUb1aeuRt7SOZeUCkUajeGkxEGtlGsCQ==
X-ME-Sender: <xms:pQxNaow2k-AG879qKbXhJV-9626vXDHuHxGnz8JKrpnzc76H2E1vQg>
    <xme:pQxNajv5kUTU15_tN914rXHzSfAMyqJsA0xYV7GUSEwxmWDv65JlGCldnScKLom3Y
    IeNXUhhOX6dXF27Qj96xteRZrHvMEDIec5kKmT2klyHlHVnLz0FAO8>
X-ME-Received: <xmr:pQxNanso9HhDkqE7AIJ7oZXGl-jPU26Li663hhxCijKvbKX4ZGBFrPoFXWuE2Nc72qZmvNGvYQo8moYXIe1lYfQk1Xgz38LCAcsK-dq2KA>
X-ME-Proxy-Cause: dmFkZTEScA7ABI9ns4lKEXfxl0bT3+T+UiUO7zyzksbxGqZvlRksnJYENM1Wphz7Pgkfem
    HcFs5m9q+PURM5V7hTrcjB43I4jG9RXsSkZG8fQkZf4w6WO0StdrZfvnW78DxCNtUaV2KO
    GMgf2vugToPP7zG0KvRWl+NEILcPv/0EiLdv7CWvkffUO/F0McsABEMh478SEMjpc+o5S7
    36rCNB+yWsbLP7001xKZzjdi51aTKsbZjVvJjpmB5wLIClpjT3G0DVzKaqzVr9yu5N2Ee6
    bnq3Q2PzQX/iBO76K9ZOYvJu6tRvbXOOQadBXPwiyO1TIOA0CjCXQClxHiglKWPNjYFgMB
    OGyqYl58of7bDWMY6VEezHCjp2iwBONOVoNWk62U6xh8F8mIR8HRzp33NPCFD9Xx80NbfJ
    H5LvpRaOMpIVPotrPmLzhfbn6mHj7v1qC7wkndDlVAcTIES4xIyOAEMpOMa47WbR2C0HQD
    F34IhAsT+WrJRZDb1XFo2K75WAZzHkx9RiNMUdXHLndc1TDdp//dUm0/lzPrzEdyUgtjz+
    C4IrQHoGHL183OikhW+SQqf99PLinvT6DkiI5ZurjQGJ4RINEzh6YvjKiaDeH8qMhdr98c
    afxYLa1XOAx+/yAsdQ5JhvFHu24Rp0ZHefVm68ndNubOV7O4xsxJ1TUj3hvg
X-ME-Proxy: <xmx:pQxNagNCgsCIjHKwYn0aPIAGl3q3BDZwSeR3J3mfFpHDP0uw1Tl2bg>
    <xmx:pQxNat1I6t1o-rOZjH5RMIQWaIC-Dh7kDyzw8asUS6C_DxS6dNIuxw>
    <xmx:pQxNakMVhdZYz9g3W02adQPTXNEmVO93KL3qTx3ZmwlS80vbPwNvFw>
    <xmx:pQxNal1JWwm8G1GU7SCKjlkdp68Cvlbrj-qVZp4Yd2ItBMiB7hQIYA>
    <xmx:pQxNanB0a5dUaalygw1Ri3ksiVr8tQk6WkFAvwOT2FL5-MeZPTzLVFS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:26:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffdecb72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 14:26:44 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:26:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 7/7] hash: check ctx->active flag in all wrapper functions
Message-ID: <ak0MoazdNNj1_7OQ@pks.im>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
 <20260707050952.GG1288294@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707050952.GG1288294@coredump.intra.peff.net>

On Tue, Jul 07, 2026 at 01:09:52AM -0400, Jeff King wrote:
> It only makes sense to call git_hash_update(), etc, on a hash context
> that has been initialized but not yet finalized or discarded. This is an
> unlikely error to make, but it's easy for us to catch it and complain.
> 
> It's especially important because it would quietly "work" for many hash
> backends (like sha1dc, which is just manipulating some bytes) but would
> cause undefined behavior with others (like OpenSSL, which puts the
> context onto the heap). Checking the flag lets us catch problems
> consistently on every build.
> 
> Note that we can't do the same for git_init_hash(). Even though it would

You probably mean `git_hash_init()`?

> cause a leak to call it twice (without an intervening final/discard),
> the point of the function is that the contents of the struct are
> undefined before the call. But calling it twice is an even less likely
> error to make, so not covering it is OK.

Right. We could of course enforce that the structure must be zeroed
before calling this function. But I agree that this would become quite
awkward.

Patrick
