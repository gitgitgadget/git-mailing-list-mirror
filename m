Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B36EED8
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854718; cv=none; b=mCPSv1iZZJTkYyoGNDJGgi1y7SjXsFJ53Qj+EMyrt+ftYABQ8Y6B2QaP2lfqmDhIqP0aC2vGu0vUIzPHH2qGO10FHPAWP2Mh8cSd3XLarO76VRClinNel+thAQrRArkVQtWeW7B8Ek9vt5hC+0zmCiKvUeASFSPTXp2BfmOblnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854718; c=relaxed/simple;
	bh=ZTn+4IfB4ZEmXkyNJFM+/Rrg3M256LQ+aAwixcee85w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvXHwsYp8D8TlcNlqTpnb36gDyDKcCRVeJuMYxB4i3IS4bmaMWxoh9ziogdHTokLdLGe8B52dyoWQrdGMPjLeUTreYiNveJmuR6A+dli6cZU5xxCwHZst5Af0ocpGsjAfCTxjJH6wRaQFuKQYpwf0RJfb2EzAoYTmADj67zeMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nAH2YEoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I60VLVIQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nAH2YEoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I60VLVIQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DE9C81D0015C;
	Fri, 19 Jun 2026 03:38:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 19 Jun 2026 03:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781854715;
	 x=1781941115; bh=mhvET2wYMZ/pYOQXoh6tuZD+lykxtaRjnIrGtqUTxFY=; b=
	nAH2YEoeCEAJTbVEHN7yP/ep2t8kql6dhq1Thfn5EXovB7tf01qNNWqZvNP/XUTI
	LLXRdkVoud9Bsi2m+pcN7oV6A1a0q1oPqT3/QYkMUTSa4Y8bEiVSIghmchM6SdNs
	7mUgdXEWvfzXrhJrPOL52qdKICh6AV83wVbxd9FB02MX6j4gqQCUtbOJmaNo4hCh
	JujyUeW/bWqrCfGvx15g9ZkaqXO0Sm8xZcio774mQaTvZaNEXcJJSmTEJQBpoYBT
	49zRz/2E9NhdiQKrLXXQYaoOD7VPkqrRfjBvoFF+/un/YHmLD/4tBfVxPamkiklg
	mXXfLLNxg8vDeAVurShrEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781854715; x=
	1781941115; bh=mhvET2wYMZ/pYOQXoh6tuZD+lykxtaRjnIrGtqUTxFY=; b=I
	60VLVIQNwCZL+GOHvpXIiSxBuvUpWCXoTHBpnPQsCeDKT1avHgFm2nAbKq/3CLLt
	5VKDLIMVu7QKOpHDnxwEV7VLorJzvHFMtLF63hrmlUHQPQiNx4sXLNY9bDX7owrq
	3G1ccZEne6e2OUW1VGqXqTzcHHMObYGVaFEsYBd2DtT1UzcYfMk0oIoU3Gs/E8Bo
	4P6p4KwcdgNX8+z4QAfoFzitKmXUKGQoinf5FjEvL8rq5Pxa+9n8zsuXRL1glCHN
	SthTUbvipWX80VtScHyjbvpicyNw8kmbMEtd84al8mGtxKllSQV9E0mZpevQ2IKT
	RsBCeR+XqIZuYTm4aAlLg==
X-ME-Sender: <xms:-_E0aj-RodYfuTvxPy7xR9mSiYxmTbMIoW-a_gckQy2EwpSE6hyQVg>
    <xme:-_E0alsR8eutv9leJT_8yI0tZwtQVipIXnJx-GqS7aqy04mmnQiAIO9PuGaj5vfJ7
    uCGO6sNAHKXI25ZV4FpIt49h0r_U8aAUqgYnPgCaqQtKdRtMLq2MQ>
X-ME-Received: <xmr:-_E0auobaSnvRObJ7IrIrOF1_rXypwVnwCu693UTF7FtaxQBcASHdGDpoP_ljH488J5C1Yezt5BcpJHAU0W18NLTHkqE9l1wR8GzhNUdDFY>
X-ME-Proxy-Cause: dmFkZTGV7uSQ/Nc0k/n/ujj7FsGDpq3Mj4tKtUJoMbwctH05UgJ67Tp5xp6IaIPMK7IJfi
    TYj+CIlQUc+n559kC9HyG6S/fynQLNx7qlrNXTxwtJBDi6VPGtHDBgOTyW32iIQrZkCln3
    lwVPefg3BqFT3cs3MsGW6EJLcC4Wy2t/sfGfsaxlZCtwzgOsM3YWgQ+wHHPeFPwb0vEN9/
    Xw2ipAKkwMcMbhzxgMswn3kVkwuqzser9bZe0jzlrb3Z9lrGv5pX2aOEhTgAPTasLFaYA3
    XBwhmZrvx5vwGRdGe41Ih/eBErVw9P4r8NG2DZlR13s7dNDomODQvBC0s8kxkC2/+4Wdjp
    EtnYq0oEhplbnHwdoWuGEZCUlqDWVZvEbAQG7R7G5c4nFQ/Ci/Lr9zglbcWQ4LUjcPfiDm
    GP9yf/vtrHN/ZdI1sZJ4M9N6JKDYUy/Y2Lmx+w00HTtbDoiTJ2XrGADAitkGGIYaXgMcP3
    G7Iq+38APIcuUTtZu/g/vmltVxtXW5/HzbaKqDSiShs13080tvCMUE7iLPKXH+imfYrKmM
    yCBjI4Nh08HY4Wjm7+JrLlU/ne2tEaOZ3HUFH2fhDYCGDh68A2r2rDln7qfGEwy4syPW4v
    inUCN4GBhQexopzvcUK9OWJmfecZnE6Ov4FUa6VmrBOxobWfUBZ7bVzPBv1Q
X-ME-Proxy: <xmx:-_E0aqlnZ-CDL2p6yA8QZtr6QthTkHpVuLHZl32U_lZijbJpCcUPtA>
    <xmx:-_E0aqx2u3rVpTM_USERM4kk5Iy3d_BHWGAtinhfxWUco3x1K9Lzew>
    <xmx:-_E0aqn6l9pLqFSGQyiY1hOI6Z0zakWT9obSK1Irc3vMG5mMlKtjcA>
    <xmx:-_E0ardCShutbPHzoYif8VLtXh2S_g2P_nkjS_jFFlvP65Uc5jZCHw>
    <xmx:-_E0aitINz_EVjFcL9M70atMCauOz13FUSFIBLJ6YaqtvORvqzz4pBZZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 03:38:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2e3af09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 07:38:33 +0000 (UTC)
Date: Fri, 19 Jun 2026 09:38:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Erik =?utf-8?Q?=C3=96stlund?= <erik.ostlund@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Pinned references?
Message-ID: <ajTx9vLIWK5wvTHM@pks.im>
References: <CANE2Nt_LP9odF9tVsy8di54eSH=QJxif2WQfHC+TQGGFeVcjvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANE2Nt_LP9odF9tVsy8di54eSH=QJxif2WQfHC+TQGGFeVcjvg@mail.gmail.com>

On Thu, Jun 18, 2026 at 08:37:26PM +0200, Erik Östlund wrote:
> I'd like to be able to express a reference together with an expected
> object ID, for example with strawman syntax like:
> 
> refs/tags/v1.2.3?oid=a1b2c3d4
> 
> The intended semantics would be that both the reference and object ID
> must exist, and Git should fail if the reference does not resolve to the
> specified object ID.
> 
> Tags are nice because they convey human meaning. Object IDs are nice
> because they are immutable. As it is, I often have to choose between the
> two, or represent them separately in external tooling.
> 
> Is there existing terminology, prior discussion, or an accepted Git-native
> approach for this kind of "ref plus expected OID" invariant? I
> searched both the Git reference documentation and the mailing list
> archives, but couldn't find what I was looking for.

You can already kind of do this:

    $ git rev-parse v2.54.0
    0b13e48a3a30cdfa94e8ef842e24d6045ab3d015

    $ git rev-parse v2.54.0-0-g0b13e48a3
    0b13e48a3a30cdfa94e8ef842e24d6045ab3d015

    $ git rev-parse v2.54.0-0-g95e20213f
    95e20213faefeb95df29277c58ac1980ab68f701

This is described under gitrevisions(7), `<describeOutput>`. The only
gotcha is that this format will not verify that the tag and the object
ID actually match. But other than that it gives you the ability to have
both the human-readable name and the machine-readable commit ID in
there.

As said, we don't verify that those two revisions actually match. So in
the case where they don't the result is certainly going to be lots of
confusion. It certainly is one of the more surprising syntaxes that we
have in Git.

Patrick
