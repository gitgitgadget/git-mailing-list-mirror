Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FE38F95C
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098790; cv=none; b=nCIs3913MC6Ih4+Z42vltp56OANW8fdIJHmM41cWLR+15WeALPFBnhQyfIfunfWlpX6JLEmkK5ad8QHoA1fEF65P+ufchX45KACzflZ3rA80Z3P1q6vc7ppEaUEhCSwLoD4MPU9pve/bO1FSTKmvplvYljMJ6FpRI0b7ULsZ3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098790; c=relaxed/simple;
	bh=pQP9NaBI27pQQcdUtjbSShsMCY7u9N8YPcHgDtxe52w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFuJmGkXUReD8j6jV/St0uqLgFDKu/TqCX9HpKdk4aeiId9rxUwDM82v0/Busbz6gq9+Zl6Xis8LSfTiy+CVARwSMEftk+ogt+RmUXhnLb7BDXzDDeg+BfJJHsRDAJDiU/RlOTV91jDtqvsfIQNHyDwflpckBLEBSnXUsbRNGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kdPJHka4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smsjoS2p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kdPJHka4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smsjoS2p"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0DF81400176;
	Mon,  9 Mar 2026 19:26:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 09 Mar 2026 19:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773098788; x=1773185188; bh=azR5B2lP9m
	0DE62Fv/u+oikU30YekWxweOWTO3PRz7g=; b=kdPJHka4/X1p8aa1hwi9T+9Yg5
	n3UFvO8C5taNZhsS2ct+ZMdWwSbE7eo5xMgpSAQrk16bgy/knVIcVH79KFRtUQ1G
	ydYAbL7irxg1mn+IEYv5RuER/BH1GKcDlB9nOr8oeSvA96cjxjv4hEBYke2uuFeF
	7qmx2LCfBx5kP+IGOKSJQsZrnmH5CB7ozCa7iuGLys8N0IRdTBZtiwCWWWMrQfwt
	rh3fG5v34KrIFhXYT5+a/YM4GJfdtsXnGArLgFZgfT56x+Z9AmhtZE/fPIb3PJIP
	EGlqcdFDhJ+TDZw1Y0wif1NDMzya/RB2RoLXfx4sFWCsBekJyAZQyh02P/qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773098788; x=1773185188; bh=azR5B2lP9m0DE62Fv/u+oikU30YekWxweOW
	TO3PRz7g=; b=smsjoS2pyI8oMKPQ5bHI34/f05ugpxfywrHnj2TkI5umUkYT/Sx
	3IevMX3Qxa3/qjK1VQREnAs+rBw5bsJdpTS0AkaPgIJN4J/zrEuwoZjSajPp+fle
	+pBODNd0uzA5Y0olMexDsYE3piLul8EswwQbrjjJcboDgBDW6b992/vvVT6EJTv+
	xMQxEDSD4IgQ7NP67GWfmX9hVwNj7QYemabIQ/3eocvgvBcbj7omX4LaHlJEOLAP
	kSBVNQHFUZ1s6k443nVcGZdI9dhVvfqt014pi1ffljDxolLPxIWjkqnNa/IJ/6nh
	JvH+pKHOttHvZzvywbsUd5nggDCCxq8gdxg==
X-ME-Sender: <xms:JFevaaKTxaymEhnnPiP59pRHj0_6ET5VNJBZSPg_EaOLcWHES5yJwg>
    <xme:JFevaZlf7VnDl5m_kwxNYGrlWdRk2Kwjg4KL-X6WxeUixYWpCE6b92unfwDzd0KEg
    u3sI2s8k6vR9VYDfFewxSGlnOFys1WouhvEOHfyp3j1L95oxej5kQM>
X-ME-Received: <xmr:JFevaYEyf5Ei2Ofjtq8OWcEj6jOc44Ij5z7YI_RfRqYUoVjeRksqLnuuyzX87whTWRAyRVDNlSGPAVBODmEY4JfWf1PcP90lGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhho
    ohhsrggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:JFevaZHqPpBiLRT8BXZsPijfFhIZdZ9oGUbj5PYqjXrBI6MHCw822Q>
    <xmx:JFevaVOhlVde225MtNeUXrsdUrGM6oRJBxx30CHPVyxotf13t9_7DQ>
    <xmx:JFevaYHDu3ajLt1p_LCogCoyN9s7fkaV169fSw2Jdy9cjnltJYUNyQ>
    <xmx:JFevacMtV8Y7xMAFJYb3fuLpx9Hw0iN7iIfM61uUTzCQvw35Q0ZaAA>
    <xmx:JFevaUtyGqEfgGUQ_xIEXYn4x2_g9xRA4wirujhsrs6M87wgzgBHifrM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:26:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
In-Reply-To: <20260309230134.758107-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Tue, 10 Mar 2026 00:01:34 +0100")
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
	<20260309230134.758107-1-pabloosabaterr@gmail.com>
Date: Mon, 09 Mar 2026 16:26:27 -0700
Message-ID: <xmqqldg01t5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Replace old style 'test -f' and 'test -d' with helpers
> 'test_path_is_file' and 'test_path_is_dir' respectively,
> which make debugging a failing test easier by loudly
> reporting what expectation was not met.
>
> The instances were found with:
>
> 	git grep "test -[efd]" t/
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t9200-git-cvsexportcommit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looking good.  Will queue.  Thanks.


> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> index a44eabf0d8..4507e8e6db 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
>  rm -rf "$CVSROOT" "$CVSWORK"
>  
>  cvs init &&
> -test -d "$CVSROOT" &&
> +test_path_is_dir "$CVSROOT" &&
>  cvs -Q co -d "$CVSWORK" . &&
>  echo >empty &&
>  git add empty &&
> @@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
>  	git commit -m "Added attic_gremlin" &&
>  	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
>  	(cd "$CVSWORK" && cvs -Q update -d) &&
> -	test -f "$CVSWORK/attic_gremlin"
> +	test_path_is_file "$CVSWORK/attic_gremlin"
>  '
>  
>  # the state of the CVS sandbox may be indeterminate for ' space'
