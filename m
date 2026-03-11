Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397033BADAD
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228032; cv=none; b=HRmJoQGsZgVQTGPYASm3dNv1zgC99OHV9DRDZciyzIiogbOxTpKVDUzB+kNEc7ezXrgpttObvnS/iy65RG+f17qlg34em7569zhaBjkxFQYOwWvmxSkZu8AmtiDxT9LbIQ57A2THeD8YoEtZd2c1F4reuPCKxYC88aPrEdzy2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228032; c=relaxed/simple;
	bh=8h0TxSNW/X6dTsNSCpmDcxgP8X5OnsdqMQxgyMFR/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShG2VpxTjOWloJh5SK3D2L5dOwgJSYJNoaPVMSwIsb6oQEqYBcX8ACJtTfSyM51WiFMCr5xiGiRcv5/HZGtqMDrkefy/139GaNkytdZu/2brpJEHWbpZ4NagUPSbNlbqMeX7LPXIK0UWWSgtYAiMd25Abfx1ANYeIrPEOq9/4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AocODiN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kyBbfcti; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AocODiN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kyBbfcti"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C48C7A01B4;
	Wed, 11 Mar 2026 07:20:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Mar 2026 07:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773228027; x=1773314427; bh=I6erjVRDTd
	agUG2AnRrzdsHdR66f+A1xDl0JugsFKIA=; b=AocODiN/4FhjKoLbzduTo8EtJ8
	2GhqjOMOoHuILOdRechlU2tjKLMStCUPnnArlaMuoFTloxkgV9/xX6UWHMhpuIGq
	jbKqBzZsxqJnA06q9scgkMjZJI3nns4tznmFUQBuXm/GDa0WuDNVH86XIx8M9iMY
	58PgslYk2yHHGI+fJwYSFOVnVUHCyr5cPJPcX+WIvIzg49fYbIP+m6i54FvqBQco
	gT0pAbAlQg6b+DHIdHLTn89D1VVeZaERXSt3TanPTtGowejyfOTaqHgYWsw5LMT2
	llKk2hIl3kyV70UmyHFTxyN5UIVK8hsikg3flRzjswY1vogthofFtPRHxODw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773228027; x=1773314427; bh=I6erjVRDTdagUG2AnRrzdsHdR66f+A1xDl0
	JugsFKIA=; b=kyBbfctiXZPDx3vAYalAFXV017NkSFrhCK9cLfnpO8hVNtvr9Sl
	m1QBIdW+HEDtYTCOiQlVIfXp77Y38gQvRx92/EkYphtRt/JNVJn8aq+GGtjn3zhm
	OMJrwZajCaZ0dXdk9z+jJnwnl+I1PkPO5PSL+UzWLnbb5dYDcvI82Jb7Bp2oMAOK
	LBWrnpVrrjA2LQ1myGYuhhDH4K64k77Q21PioGeTH/zf5UXq4xcm3J6bmdcrLZrO
	US5WA+X2stNJdrSqSJ0K0HK3LwQevAvHKHqhE6IpHf+II/c14Pcgv4+xwwQtd8A/
	2M2xsHdExPp6Hf6Uvcm3A9HnR+e4fy6uzLA==
X-ME-Sender: <xms:-0-xaVrEQjZUsEdGbSrRwUCjl3OpPRRvjKm25J660RtxMjeuVSUxgg>
    <xme:-0-xafFtoNcvDN6ZxKQMkXyFCcXZ5kDvKxfUFpK5wphnBpiClSGu22WYZbfDiUx_e
    k9ikOVRVDTGg7FiqXkeQ1NCJ7qyLVN4p-D_20K5WXnwP1M5FViKS6E>
X-ME-Received: <xmr:-0-xafldv37f-kFYhHAqJSJNJaWYDvsmC8huuKO6cpYsKaga-VpisL0gh5Ki-2hFYaxE1grHR-U_WR5AeQTXnBbWgZ_64YE90J_YEt6nsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhi
    mhgrlhhisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-0-xaak8P149Rij9DJza5Ws21npth-yfiOI_4czcdkRm4zItIJpDyg>
    <xmx:-0-xaYslmtWnqcrLbhX0tOZWbRAndSHHYtpWg5Uuw-0Ns9lIDptcJw>
    <xmx:-0-xaVlfEqHxj40VndA-r_n53fvdAv8bn3-8pyKKEoEYL5CsZvV2GQ>
    <xmx:-0-xabuYW5hBff3cnJh8lOYGAAuBRohKCz4b2PnaSXZIYMJXVxIFdA>
    <xmx:-0-xaXGP1-YLSHlrXpdkxG6VdtTs07a333aIfedpr63qZ_I91uCl9Scn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 07:20:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c51b7f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 11:20:24 +0000 (UTC)
Date: Wed, 11 Mar 2026 12:20:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t3200: replace hardcoded null OID with $ZERO_OID
Message-ID: <abFP9vZOVHGI536G@pks.im>
References: <20260311105829.60508-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311105829.60508-1-r.siddharth.shrimali@gmail.com>

On Wed, Mar 11, 2026 at 04:28:10PM +0530, Siddharth Shrimali wrote:
> Taking into consideration the SHA-256 transition, the test suite must
> be updated to support the length of the underlying hash algorithm.
> Tests that rely on hardcoded 40-character strings to represent the
> null object ID will fail when run in a SHA-256 environment, which
> expects a 64-character hash.
> 
> Replace the hardcoded 40-zero string in the 'git branch --merged' test
> with the '$ZERO_OID' variable which is provided by the test framework.
> This ensures the test dynamically adapts to the correct null OID
> length and functions correctly regardless of the active hash
> algorithm.
> 
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
>  t/t3200-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c58e505c43..ed317a75f5 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1494,7 +1494,7 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
>  '
>  
>  test_expect_success '--merged catches invalid object names' '
> -	test_must_fail git branch --merged 0000000000000000000000000000000000000000
> +	test_must_fail git branch --merged $ZERO_OID
>  '

I expect that the failure reason before and after this change is
different, right? And likewise, I expect that before the change, the
failure with SHA1 is likely different than the one with SHA256.

Taking a peek, that's indeed the case. With SHA1 we get:

    error: option `merged' must point to a commit

But with SHA256 we get:

    fatal: malformed object name 0000000000000000000000000000000000000000

So the only reason why we didn't detect that the test is broken with
SHA256 is that we didn't verify the error message. Do we maybe want to
make the test a bit less fragile by using something like `test_grep
"must point to a commit"` on the error message?

Patrick
