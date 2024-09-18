Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64432868B
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651357; cv=none; b=FM2hkh4P34sIiyOxpkctoxrvT8qt7336RkvAnXrAFAOlCtPXZjLe7Ofh+QygZOdWbXUvgO+Xi/fcQL304AeLJ93+2KKczinYsjaazXqEeF6BhPdl5gf0OoRzVNtM2w0N7Lzv8xfhApXhlDlu5gGQfouGCWSFFJNVQzbs8pBlBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651357; c=relaxed/simple;
	bh=qX7OUN7aoaqGPAmNsidWcVIiQV6l+YTwnLglIFEW148=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=EhVh5aom2TJvVFDKO+zFEFpANTiXmhr6EO5yBHz8/oO8M89loNnFhxRw9deZveHxEIb76Q5TZVpvmPkSHX17Cimwx1YdSn41XTNM/ZxT3babn2Pu36ASJcLgLj+ziTHcfdqNnI+7RSc5hRRyjPNkrjsNqUuaYC3AiBU0JEQ6kL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=pDFKWUyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lPH0ggH3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="pDFKWUyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lPH0ggH3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B60121380260;
	Wed, 18 Sep 2024 05:22:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Sep 2024 05:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726651353;
	 x=1726737753; bh=4nbIHkDYFbQIZ03eMBb9ju6VmSDAmlXbX9GfYnD8uVQ=; b=
	pDFKWUyJnqtlhbdElrVqLs4WUlCr5mtP3DQ7iRcOSf02SYnjUhhq0c6rEDEEab3i
	qprNk9ZtgzVoYv3ZyhwZfwMtPJ6dliv/RRBJKZKUziyBwWkZynk2vcFoETh3/xva
	zKk0tyJY4WALQRqjzJ06LS2hivYY7R58YQ8V1o8O32crbakncC+NBWtRv/Bd1Kb+
	WHiCzRGVqadFo9Yb6gIa8djw/39EUwpnvzsMHCSY3KSad9FxglTJQbecQyycSsQE
	RQnzxyJ0cHWNwvoi9XqOj6Du8xYUy12J6XL1KKbyTGYju5emMIpSieuof10+EEKM
	B0c0qjosp8WeoS7URQKk6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726651353; x=
	1726737753; bh=4nbIHkDYFbQIZ03eMBb9ju6VmSDAmlXbX9GfYnD8uVQ=; b=l
	PH0ggH3PIX/hfSDyP35XfsEKSZJGYBB3ryCNBFSfxG97Xa7D/49+yDYeQmP7b8wT
	GHO/CKRSnH2Y3cWtXaLamgNRsK6bohXDn21CCBl7gZr/UHG9N/U1D8ksQjycFmC+
	/JeB4oSXSd9nhp9ZZ7ybaujptk8VK6mglJ4jhd2RjT1Jl4WxqhE9qy5Aspyvyyvy
	NYhQIz18jmsKgIv1Fpw/AL9UyCCzfVIhD3XfzykdDX75iUVzD6GYnZ+bIFX40Fx5
	ZrFAT6/dI4mFLhS+n+qMhlrbvnbX6civsooFfW/DPFZnc+cOmQ8CaoP+FUhH/tyl
	apEuIHhT+5pAIHkW00Deg==
X-ME-Sender: <xms:2ZvqZixscbxk_DZCqre-K99eTzRRZmKNPRGeZxLH7I-10qwvNPhZFg>
    <xme:2ZvqZuSyAEzrAb1o9IxMDmlhJ4MtcYijYGcau2Z6Zfj55mfJ0CjNqlIsXIKGjL09k
    nklG8eN9ZNVJrADXQ>
X-ME-Received: <xmr:2ZvqZkVblZYPiJ_re7unIk9maenNFdqgKJmPOUwcPveWg8dipVa3-wTAV2a1tT2oW5Aq_vnhSXKWfZUA69oSeJ8JE33M0eInz-ZfwaFr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffhvfevuffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhepfeefgfduveegfeduveevveekieffhfetffeukeff
    fffhgeelueekieffhedtveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:2ZvqZohGF4yVLkzcR81psGnVnpNj4XOC7RmBleU1sKMOHaaRcGTxZA>
    <xmx:2ZvqZkD86sAHfRP1q8wunfHUt7S6PCUS8ivYL79McjO_RpbDdO45GA>
    <xmx:2ZvqZpKDlc48X1v8JQsNYwyz8YKPAgFKNSmbojGWsafCAcGYTsneWg>
    <xmx:2ZvqZrDCE6MRcTh-f4l3YW7zyWMh07VfKsF2-OlDor8EuMF0uZcXww>
    <xmx:2ZvqZn_32BN-LawtA2Mj1MIrb5dVU5lyQBvfVfzdm8qtnlLjL-WE1Z0M>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:22:31 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 19:22:28 +1000
Message-Id: <D49ATJ4EIEG0.3A1RCYNFQG0XR@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "karthik nayak" <karthik.188@gmail.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] refs/reftable: introduce "reftable.lockTimeout"
X-Mailer: aerc 0.18.2
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
 <700a35df125eca6639d08d30720332dbc1ed15a1.1726633812.git.ps@pks.im>
In-Reply-To: <700a35df125eca6639d08d30720332dbc1ed15a1.1726633812.git.ps@pks.im>

On Wed Sep 18, 2024 at 2:32 PM AEST, Patrick Steinhardt wrote:
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 1c4b19e737f..e90ddfb98dd 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -256,6 +256,9 @@ static int reftable_be_config(const char *var, const =
char *value,
>  		if (factor > UINT8_MAX)
>  			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX=
);
>  		opts->auto_compaction_factor =3D factor;
> +	} else if (!strcmp(var, "reftable.locktimeout")) {
> +		unsigned long lock_timeout =3D git_config_ulong(var, value, ctx->kvi);
> +		opts->lock_timeout_ms =3D lock_timeout;
>  	}

Do we need to support the `0` and `-1` values that are possible for
the "core.filesRefLockTimeout" and "core.packedRefsTimeout" timeouts
here as well?

