Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244138C640
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982690; cv=none; b=H9SQ5uvlSCWn2jakwk4PvVnMO+Y84dSp5AlYAf1lYwH2Izl0Cm4LPpumObyyWAMNhh4hqqVkKq8hoqPUaOs0T4lN5CV0lKOWWvnSG5lm4nN0hPj5P/1mGsyxHPvV15n5t7j7gFwE+jz1x5W8Plgn3WE6i7sNEQ32pmWTxAKZU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982690; c=relaxed/simple;
	bh=G2VuNu57Um4JiO+85rRW11zo3DOaTi18bAK8UBmTWxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3U844QTOxjT9RUCX1qri6UDwnBTtEnCVXg0E248FbmMoXBr9AjP3OgPDetVxGFDfIY/6me0YYejAMocaWSTaaW5K0KyTiL7tq5mhaIuTsfgVkheiV2Jaby3SSNHMRWm5RC4wJye2hvSfA5WXW2ASCNQDBQl2yKxd6/zbH1Bd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oNy1z6qy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tl6qWXO6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oNy1z6qy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tl6qWXO6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 611AF14000C1;
	Wed, 17 Dec 2025 09:44:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 09:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765982686; x=1766069086; bh=EI+RW08rfD
	WtXcU5A9dWRo2GTyxTLL+UUdsJ/M2IhkU=; b=oNy1z6qyOh8LZOnWcRB5BTKJef
	OH9BU0+t6QV+lylvoqTZo1qzjTEcA5tIAQxO8iJ9VRIjD3o8UN0Kanb3CTdbmZRQ
	dtA1V5sSAwl6wh1pr4rMVo8/SyfePPydD+bp7qHuwpFgYgo3iOI0ft3++xjUVeLF
	DHORYkyTRx+/JtT+XGNfa16fAGQlBtxo6xQXKEzSRz3W6WPVLN4AdGErMe4YcG6z
	qdPq6kIPFNDHRoeivAveBZhNFYOZdD3yju2dN+Vf4aCJq1hg45mL+wzE4YsmTrPu
	squuorHO4g67iuwZeX3wWtpe+INtQn8n6n68LzeMpMWtdksDco0N6HVuX0Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765982686; x=1766069086; bh=EI+RW08rfDWtXcU5A9dWRo2GTyxTLL+UUds
	J/M2IhkU=; b=Tl6qWXO6d969TUINyzPRdAEsw2/VxAlOGYq5HTUIPh+/rPNcd1C
	gHgRbN52bOj6bF7RhOOtR83L0Kk9Y5CRlyT7oPWjZGjEH3EkJN90aSnLNFZCEPU/
	FMhDZptaq6hHPQkeIJuRTczyWDArpPrcVHE5OIGKAmYE0xKNDewJ9Hwbo40ma8tr
	Ak8r05awpU477HTsBhA7SZ7iWxYxRagoBxnjGg7kTzO8lnGPZdKkEXG36bBcMZx2
	Td32JG3ppBGnVCw07dhfgpXboWODTIefGGFQLpWEczKp17HDcYrtuRvRGflSPnWI
	BHxDg9bq9csBdbYSVIfdRt+F5PXUl8C+4Fg==
X-ME-Sender: <xms:3sFCaUQSxnr8tnB_mpqPl5Dy4KZGGuqpnLwcTPJH46KrPkYPv94krw>
    <xme:3sFCaZPWQLsd0mufGyAzzNPQr2FggCiPYIlMyWdIiLxEcIg9YBaquzAm4Zoa3BjxL
    0onI6tExZu3BehaEoSD5VMqMTAOkzJSkDJPsUxFF5tfnfSWueE3BQ>
X-ME-Received: <xmr:3sFCafN2ZXms5c_ZxUGX3HdMjIGD1Heg0sQgbnbB4MimTsEKVvEjlnzImkBxMwTZBOjFUyVmRt3twSc-enUUzz7AzCUuky5q6c-tLi8N2-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3sFCaRt74COKNTeSwh-NyBXC3gj6JPaiS88oWDCTtZ0PSPbSliOkKw>
    <xmx:3sFCaRUodEb9un0iYHLD55BeShDfb7FbfZubyesxY6T1auzV2hIhkw>
    <xmx:3sFCaRtwZY-qBlSqSc0EMw_6rhVKb9cRFjVAFpqFukAzP2lqairYUQ>
    <xmx:3sFCaVUHoGG1moaeXB_lHunssztkvnCdb-01AI05Hvd0yKXaEaRWJQ>
    <xmx:3sFCadURwbepMGJLyNocF0Qur8QqkJb14Be2KZfnvAGeWLLY-iCmnJ2g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 09:44:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26de925c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Dec 2025 14:44:44 +0000 (UTC)
Date: Wed, 17 Dec 2025 15:44:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] init: do parse _all_ core.* settings early
Message-ID: <aULB2TGj_qFFFvCu@pks.im>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
 <31497b019886698aacebbbc6a464a7c0124f31c4.1765899229.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31497b019886698aacebbbc6a464a7c0124f31c4.1765899229.git.gitgitgadget@gmail.com>

On Tue, Dec 16, 2025 at 03:33:46PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/setup.c b/setup.c
> index 7086741e6c..42e4e7a690 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2611,7 +2611,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  	 * have set up the repository format such that we can evaluate
>  	 * includeIf conditions correctly in the case of re-initialization.
>  	 */
> -	repo_config(the_repository, platform_core_config, NULL);
> +	repo_config(the_repository, git_default_core_config, NULL);
>  
>  	safe_create_dir(the_repository, git_dir, 0);

Two lines further down we call `create_default_files()`, and there we
end up calling `repo_config(the_repository, git_default_config, NULL)`
as one of the first things. We do so after copying templates though, so
indeed this comes too late.

We also cannot really merge these two calls: we need to re-parse the
configuration after having copied over the template, as the template may
contain a gitconfig file itself.

Furthermore, `git_default_core_config()` already knows to call
`platform_core_config()`, as well. So we're not losing any of that
information, either.

All to say that this change makes sense to me and should be safe, as we
don't end up parsing _more_ configuration keys, we only parse a subset
of it a bit earlier.

Patrick
