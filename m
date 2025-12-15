Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252B31DD8A
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776819; cv=none; b=l1TXfuvyR+RcrfLMG1knQbaRizsw0uK3JXI3ZXwYoivQ5aIpCZJ4N2oC9sPRbUT33u/ocOlzJ89/OHjmggtDqMa++9fbkjgdDRH6qV1gvng1CX9qizArD08r0ol26P3l98MEAGgXV8o1WGHYRRbbsqiclmF7WxkBCduFmvckBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776819; c=relaxed/simple;
	bh=gpdn2rlQUkQ2zQEN4i0zlqQxP4YquO19b3j9KmNDxp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGzHVWAUMXXQuzSz4Ob1aZKo42c4cyZehttD8avDAZsPyWODKtyXZqAp3O9y3IhRHzfzfneI2Ki6qCrmZ/zeUEeIqTiMjYWwSDDB+bNBMUVDnQyGI60YnEt/KLfA3gpPK+ZUIMiXsSt9oS7JVMvoxjnQo+6vg292grWHdSCx3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pN+poso7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7h8cqyz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pN+poso7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7h8cqyz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C154C1400186;
	Mon, 15 Dec 2025 00:33:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Dec 2025 00:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765776816; x=1765863216; bh=efNTB5Cpi9
	hW4pNZsaE5PjmCUFTNXFuHq30+JVEaF2Q=; b=pN+poso7FaPwRdlVTtPPlQjdoP
	kKHxoN/aMOGjlV7gNg9zQEjXX1qeXYrkOX8lIrlWVbk1pSU7hF0e7yIVkpBCrjT5
	W2ZdD8RcBup5RsyJHdBNGe2MQicnowpn19RcweKuEIt5dwX9/BPjYbteVG82iPBG
	7aGFG9RvwINpIIgKTogIjCgwLCXKJSBlJMxQILiwsj/XIMdwr51jlrDfRzZFntLe
	Ug5PLE2Q5iEeX0wDIvJODBCTYo7zbxOn14GbuK9Z4kqksESs1JVrVyURVscnO7rG
	Mxkp+qyRGlzJy8ai2QI6oZKhAPQQuDlsldFLJRYXuMDjU5Oc5yxsZB6WVJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765776816; x=1765863216; bh=efNTB5Cpi9hW4pNZsaE5PjmCUFTNXFuHq30
	+JVEaF2Q=; b=O7h8cqyzXovHbrru7NT+RT/t7rdso4n1/hlMNtYlQhiKyRnHnIR
	+5ysdG3jOnKmNORGP09ZRnYM+cBX4uqX7wRqPkus5y0W+pmhvTaCQ9mjBtyi3H+h
	gVVFflTJvO18afg2coOglhyQgKwFJZWGuxYtBfMN/9JD6COXfwY1yVNV3uOjAp35
	QHCCi+iFpwqS4QZKyga7Oj4fSeEXOtlozfMDXmWZ6mP5CB2zrHoV8D1tVOXcntRe
	rVckJekzqASYB8Kcn0oAoRqNWnNFPONy21r/Xm1r51aEB3LwdXJ3cxJD3DKcge+D
	jO3Pg8x9U5/qK2dtoW3jdLYD3uG1ZeBCAdg==
X-ME-Sender: <xms:sJ0_ae29FALfif8a7vR5vbsXdv6Z6J3V9Zk03SsbB5RM-oBBHz528g>
    <xme:sJ0_aYjDxdM1L5x-iPRmUtwTQTYLBgS6gNxDPLX_5bt5Fiu22ZB6wm_UcE7FS9vzV
    9rWPwWRLGK-ppkSjkap9EYa0K2qi8E08CUwC3RtYDJlO3bRSL5Bkw>
X-ME-Received: <xmr:sJ0_aUR5vj6RwFT7Lhqjc6gtQe9ueZfC-N53Ip9TyEhgcjEklxvX-3vKFwQdd4ORtmTj6Bg0935fQeax5f8kkv8Q_Xkkyg2wwN-1zrCh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:sJ0_aZg9h4Ot4kLkvzPIhDigyeUdVLu2cAUgZkooZFgM8mdPtFXiqg>
    <xmx:sJ0_aU5FbYThA4gdJHCZepnSToTdBZ2-oLMnzlxpmkj10-0meUTSVg>
    <xmx:sJ0_aWAXRCE0e5cyD9ORcH109CtxvyQUBVXquQymycG0NQFjjPazWA>
    <xmx:sJ0_abY9UZHlrRq2zm51A7afdMW0gefhD4FxSAG4eFavRmbQ202O8Q>
    <xmx:sJ0_acgn8ORx8FBUzxA8O_r5OZM-FkWjlH55KVbR1AXqV0ZrMEufdjHD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:33:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cbf2936 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:33:35 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:33:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/7] builtin/repo: add disk size info to keyvalue
 stucture output
Message-ID: <aT-drLh5WBX3vMLU@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212223644.3090879-7-jltobler@gmail.com>

On Fri, Dec 12, 2025 at 04:36:43PM -0600, Justin Tobler wrote:
> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index b18213c660..1553f3cd32 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -4,6 +4,11 @@ test_description='test git repo structure'
>  
>  . ./test-lib.sh
>  
> +object_type_disk_usage() {
> +	git cat-file --batch-check='%(objectsize:disk)' --batch-all-objects \
> +		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
> +}
> +

Using `git rev-list --all --disk-usage --filter=object:type=$1
--filter-provided-objects` would avoid the separate call to awk(1).

Patrick
