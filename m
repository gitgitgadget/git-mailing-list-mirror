Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E625E452
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668099; cv=none; b=AK4jN/JMUzRBnxq5Fm/0idXOn1spPBf/wZ2kYzb0KccpWR8U6uKco4SKY9ghSY+TfinjHxilvfZYJsVzDaKdStxMjT/bOV9ojCHa/oBvMNHHBtz5r9RlYOIeGubwyAz89Ch4shMGnYvZZOi6OWL1/JOKTFeZx+H3Dx+piC0vQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668099; c=relaxed/simple;
	bh=G+rZNNj5ooDEWweSc+gFuJeYFf5YjFIQNc3hEi944Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQLnDoGfB94/vtfbBlmpvCxTRRDWlPVRJ3Xn4UTPx26GSVngEX/ExtLxPVs9BA8imwjV2KURg2NFIILB8gGuJek4kYzoxCpg2HRGe3cZfr2InWjas81fbsIvoVLmxowRcINZZGZDWoGURFJkztALFJ3asETGeD+g5/c9aUM0fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pw8/b7lw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJQzWI5H; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pw8/b7lw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJQzWI5H"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id DA8D71382775;
	Thu, 27 Feb 2025 09:54:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 27 Feb 2025 09:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740668095; x=1740754495; bh=fOFqP3G7i5
	ByesAxa/AtK4ZbW/7kVyujXYOb02hCgYs=; b=pw8/b7lw4xhcLsSMRM4GQ3NIAG
	+qH/Rxw3if7rSnY+AXdsTlIeafhLP32SrpPBrXG85u5mVG9/hNpqQ7PLX2edhUlm
	vmXHStG94PxjLHwLMlMH3XxLZw/U2WgIzn40uSOxsYgGJs/Oxf42EDRi7FpK3Tii
	jiclYO4SgmSS1a0V+7/dHbun1Zs0MdfQJb2S07jLSVAOe4IflWhz5eTfE6mL+pur
	o7V3XJCctQFbkBQOyDaLbXBm03OgHEYq2HTvyq8qzK9dxoWRZVIIHEBk9DLUOChc
	DIoP4ufimn43gke4BMgGmb11mcgIC1BRBXa/SbsPVqD572S72Feycrhu1qBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740668095; x=1740754495; bh=fOFqP3G7i5ByesAxa/AtK4ZbW/7kVyujXYO
	b02hCgYs=; b=QJQzWI5HWH9e1HX8Xx4Y6VYzEiBR87svxbs+gUmSHi76DefRl9h
	TBojbuRhaLKwoUXJeZ78NU8bt888NDfUiRvmrdYu0W8K1ZEz+xTgYYuMfNHq3dY3
	lZHJghieufJxdHmvHWD5z7+d8a86xon94PoQld+FgFe/5rwooxUQLBBr0+dgviKx
	uCT0QPxNJI6Kc+UQry63zUmWgJoeP2S4kgHhbB+DXRT/xkTn2VTHtZ4u0+7GoonA
	uQGhk29IGX3DdtuVEo6PUHq/jPoSrVsKom+hkNJfRVXZ+QZVophx0NWCWISMI1Ii
	GxPURGMcRmbduRdTEUQTC+1/ItZO7xYbywA==
X-ME-Sender: <xms:v3zAZw7MllYy7bsirEkqHPwcmoheA6INMFJsg2qCBRQmYYDbZzRjyg>
    <xme:v3zAZx6SZ-KkN6tAyBCMVXLBivK5615sXoZr-nvRkYl93En4-d_zR352ta7-18Cxp
    VQ4GzQWdK2wPBsQ2g>
X-ME-Received: <xmr:v3zAZ_eCaCI_mHRceJWbgfz1IzG1srTbkMWWoxcj_1zC4O0tNdvjz-Q4t-3nRJPNR0wOb2y_BJCviUrUICic-lw9RYYTmMg8oNrCCcwwayfC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrrgeltdejsehhohhtmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:v3zAZ1IZwb4_OtDjGDf2ZKKe2Y7BDwsavbl1Mo4XA9ln-_eJeMSMfQ>
    <xmx:v3zAZ0I402S-qPe3zT_HZekgXN8zWy5rkBzUcFfBmEN2j0z5izhmMA>
    <xmx:v3zAZ2zcOEwQPs-Q1XyHAExRUpzHcaj9FZI0b--yH_Ka0RP38sA2nw>
    <xmx:v3zAZ4JzbNiq7pWimMaL3TIQogJvdoWP9aoJI7OipeL7UXVjSDcbZA>
    <xmx:v3zAZ43jf_lNhvygFM1hj68m5qLzhwOyDSN1ZcQp8ip9-5rEFBzqEhO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 09:54:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6bdd71e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 14:54:52 +0000 (UTC)
Date: Thu, 27 Feb 2025 15:54:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SURA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, SURA <sura907@hotmail.com>
Subject: Re: [PATCH] upload-pack: no longer use hidden-refs as
 exclude_patterns
Message-ID: <Z8B8u_d37IFOpSln@pks.im>
References: <pull.1866.git.1740660371583.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1866.git.1740660371583.gitgitgadget@gmail.com>

On Thu, Feb 27, 2025 at 12:46:11PM +0000, SURA via GitGitGadget wrote:
> From: SURA <sura907@hotmail.com>
> 
> Signed-off-by: SURA <sura907@hotmail.com>
> ---
>     upload-pack: No longer use hidden-refs as exclude_patterns
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1866%2FSURA907%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1866/SURA907/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1866
> 
>  upload-pack.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 728b2477fcc..9ae42a463a3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -609,21 +609,12 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
>  static void for_each_namespaced_ref_1(each_ref_fn fn,
>  				      struct upload_pack_data *data)
>  {
> -	const char **excludes = NULL;
>  	/*
> -	 * If `data->allow_uor` allows fetching hidden refs, we need to
> -	 * mark all references (including hidden ones), to check in
> -	 * `is_our_ref()` below.
> -	 *
> -	 * Otherwise, we only care about whether each reference's object
> -	 * has the OUR_REF bit set or not, so do not need to visit
> -	 * hidden references.
> +	 * config transfer.hideRefs of upload-pack is diffient from arg exclude of for-each-ref,
> +	 * We should not set exclude_patterns here
>  	 */
> -	if (allow_hidden_refs(data->allow_uor))
> -		excludes = hidden_refs_to_excludes(&data->hidden_refs);
> -
>  	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
> -				     excludes, fn, data);
> +				     NULL, fn, data);
>  }

This message is missing any context _why_ we want to do this. For
background: setting up these exclude patterns for hidden references is
quite an important performance optimization in large repositories, so
disabling it just like that is not an option without a good reason to do
so.

So what is the issue that you see and why is this fix the solution for
that issue?

Patrick
