Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6793B8D6A
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264996; cv=none; b=phTKzIoE0MrwcJX+rqBKb/sKrMnRA1VA/S+MMaknSBw50Ycn7Og6SbhrarMPHULtrhmHBwITHMl0swd7GYS8pD3zhACe57XXRnuG0tFeHSDAXOb1+kB7dZMAMEQfc+Z/Z94L8cKt9UwecRUBQIG/Ada7yqlA72jsFPedLKraEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264996; c=relaxed/simple;
	bh=D2mwZEnKBudkBIR8toq2NszJq7XeEpPdf/qAvVN8ib0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSuAsqwYelPFbUFJXPvysxkIBPc4v/mqVJ5ED9MUcrjbl6FWYSOoWyxBKZhcSm805+0r0SKsmGRvdFE9vNnikKWH2lHx4e61bmv1I4VCjz6IWt/ZYWm6DlEqePB/hKFxRj5IsKHajp+ZzRn7vjEukyy2tsMJxs5QQ4ngJKppUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Emo+W14B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qGWWUDvm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Emo+W14B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGWWUDvm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A4AD0EC048E;
	Tue,  9 Dec 2025 02:23:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 02:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765264993; x=1765351393; bh=gnEE+6jUFD
	lYFfXJV2LM3JJd5xYLTMWQwiPvxD2qNUM=; b=Emo+W14B/4Om5x4opeZS2yEzzt
	tB+HAfM8gURj6DzHA1aA5L4huuAgQAGHXBuoHWPWiONuvwkGEirbTS+6IOh9oWCZ
	IaUxbu7vlamgaXNFKn71SydH1n1XWpuHZDXIHDvRSNxuFuYzyvblPdD8xziLfFo5
	8gIO+cOdKl3++Mwuo1IAxIu+TMAMXyR9CN+qFTvtTXG+jq0qUHYnbCZMWtKtgANK
	7T/RBYBHObU9ZpNayvOw3/4p+DUBD6sKOXKV1j785IcZq1KOImiDxAnGeAcRVacG
	EXCYsQ0gShYiIp4YqZ/gILpytv6hixfxWEF3FXTqcyvU9bubl6Wn50cbALQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765264993; x=1765351393; bh=gnEE+6jUFDlYFfXJV2LM3JJd5xYLTMWQwiP
	vxD2qNUM=; b=qGWWUDvmBX6HdH55U30jrjkZo4KAVWiXnUMX1FqtfryR2G7xXvf
	wqht5YkJGRR4VnsM/nNRncyjJaS2Hh5N4U8C/xF4HsKdzRLG4SZ/myTtwQFVtCwR
	ZtrR4JKAjbGlDi1CyWvZDWXeDCP1HPGmvyDze25KeNsoj63zrJzpmJLvuacXUoS+
	phbDT1BHLYdAeaiGeZcFUJLMEqibIXpbU575easI/Cj841etXkLhCXkZd9vm1N6r
	EKKSs51BoG9bMelloaNqBqR3QYZuWmhMddpuuog/j7CU6s6kzf7IvivFckHcd0ro
	ZpdzMx+wV3cXI9L7cELacy13W1DESQLIrpg==
X-ME-Sender: <xms:Yc43aUviBYmoDsAJSLvkvKCqZWcg4WvoA3wDWfBfk8-ihmdZ9wl_Uw>
    <xme:Yc43aY6zxvkEdtnKXvoLeGchWrdt11IQ7NHaowEn3_PpxFDNBQTh33836NYNaT64Y
    dpL796CcWOlCtus9cMAh96T0Pt4NMkIlvJyf2QDGnTjpY_K1XBa>
X-ME-Received: <xmr:Yc43adIPUr4mrpyElNTqAc9mvdB2MTcj9Mpng7SP5E7gqqfkhdmaK_gIBeLTyTvnnB0u1gxKJqXL4GMogMeL7y0KrOFpGARFRHF8Uik0Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsrghmsehsrghmsghoshhtohgtkhdrtggrpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Yc43aQ7siV3uUOjyOrgOGYKeuF2WIjyCcj-qYvpGHGsBLGpxEN975Q>
    <xmx:Yc43aYyRF-nfh5f_eHQJ94UsuZo1hekcUUfIPbozkyJfXVINIkgu1w>
    <xmx:Yc43acZBbgvIeDg4bXLmVNwO0w9bOMhbS3AJYvEcMFkEjXnNTn57Uw>
    <xmx:Yc43aSTvZLF-HRNUIOQh3IhB5A3NoePl75g4qvkh_lcIu-0qm3FGIQ>
    <xmx:Yc43ady-N81eHB1qok2d3WLSPkTurRPebxcxmgu5OaSXAoWHsUd8s-MK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 02:23:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5bd2632b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 07:23:11 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:23:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH] doc: fix `update-ref` `symref-create` formatting
Message-ID: <aTfOXDi4Ku0nGVnF@pks.im>
References: <pull.2123.git.git.1765261419802.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2123.git.git.1765261419802.gitgitgadget@gmail.com>

On Tue, Dec 09, 2025 at 06:23:39AM +0000, Sam Bostock via GitGitGadget wrote:
> From: Sam Bostock <sam@sambostock.ca>
> 
> `symref-create` should be followed `::`, not `:`. The lack of second
> colon (`:`) causes it to appear as regular text (`<p>`) instead of as a
> description list term (`<dt>`) in the HTML documentation.
> 
> Signed-off-by: Sam Bostock <sam@sambostock.ca>
> ---
>     doc: fix update-ref symref-create formatting
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2123%2Fsambostock%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2123/sambostock/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/2123
> 
>  Documentation/git-update-ref.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 9310ce9768..37a5019a8b 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -119,7 +119,7 @@ verify::
>  	Verify <ref> against <old-oid> but do not change it.  If
>  	<old-oid> is zero or missing, the ref must not exist.
>  
> -symref-create:
> +symref-create::
>  	Create symbolic ref <ref> with <new-target> after verifying that
>  	it does not exist.

This is an obvious fix indeed. Thanks, this looks good to me!

Patrick
