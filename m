Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83158EAC5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664091; cv=none; b=IuZfIOKv3Lm4lV9u5PjZJL6l+agIeDcbYwIrkrehxe8ERsXrtP9BN3nyfNR60bfgD3vb7Jk8AdFqtYn7yVZHXaf4BVYH6cHK/PQnrvG9Wa7pDIsgCMITleh7yu7M90ih5MJhwZhGs3IPuBaCW2zXF5IJSGgAOtmI+DJiGG3uy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664091; c=relaxed/simple;
	bh=P/aLjaxNyFYNSvL1KyREVAe5+/sIKVLCYylm2XssLVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNwa5UEodvsZ62RkeDtM6lDt95x0aCCovByItIbD+RuI8jOnIflD7DbfqZETbjyYfpKPoYgPjwSba3BPP3tXCJu+PB8Q/fBFiJAGeep6AF/4+py0ByQn0Q9kJ9KWWs4KZKMcCOBUNVOSeWj6SfpzC52m16VOjcGlKnYy4d99wPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NX+ZryqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQfnvUfy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NX+ZryqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQfnvUfy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6873A1140117;
	Wed, 23 Oct 2024 02:14:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Oct 2024 02:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729664088; x=1729750488; bh=4JGMhJQFOH
	74LG8HFHtbh9e1HvrdBXDiZNeZqoR4e8s=; b=NX+ZryqWE+pAxzNrIdh2BOc7lJ
	NsXB5z5huaC1BLI4bBGxmvrA2e9Q7EXid56PIjz1z2m2SR3Sm/QtxqloVaMKeX1e
	emQ28OZ8ziQzwxspZc6ASwRy3jUlmq2lqpXVmGc6ZX643a1Ivz1Z5sCwUxZE8/my
	w6119mGTY+nmEnzYmcFWQA4skGdfQuJhOAX3glcJiarV2L/o4+WRR01Tbpr5fMPz
	Rm0kqwoimBJQiHoQjbNn3Jg6OFYnp1s2akWqkB7cTV2WaUeZeZ8WgScqL94LaRFL
	CzGZ9f7A3bbJb2vWmzLbyAmZCQYv1EiOha2VL+0OTCGB0VAk7kovAxB2510g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729664088; x=1729750488; bh=4JGMhJQFOH74LG8HFHtbh9e1Hvrd
	BXDiZNeZqoR4e8s=; b=ZQfnvUfywX9wUyGv2lINldjKRrJwHqbWn/fFSiSxPpMq
	NuKxj778xgheaTu3Ug6D+PWWRj/sRPBgVqknkwLYZpkm79nnF3fZpUDsrIAD7iOo
	POEfeXQpouA5FLJFyCIdw+FPnBzfA9FpOw/QTVxhS2/7Plez1npW/8bJuc1TbTMG
	krY0dlsUORGjmPeptiNonLIScYwFfibG14v3nfxiOQp9nY4RZFSYdpfb/RzpF4Ve
	BTpw1RhWlTB+3+GBp1B4ETJGPbR9rjojLbLLwWL2Z7XeWF+4tqKwYcepdixoQCB4
	QD5c4f//pDaMpI6Dt3Gdk2sDBgFGIzbr56VEQYpjAA==
X-ME-Sender: <xms:V5QYZyhAVwjdExtP75LfSRWcwyk-wXHKabMrnjQ-SdfIZLVMkKVRhQ>
    <xme:V5QYZzBdoA2aTSyIlS8JJl24WbnPk4LtcPAIY51d60QiZ7mFThF08F8fc_hCdtI6r
    fuH4xh90aYYDN-2GA>
X-ME-Received: <xmr:V5QYZ6EloWDA9gw7qiLEymXq-NG0fFpU6XPGWvz2U1b2tdhDjsAN6FgezDNlXQ1fki4hfvxhM_P5FsyoByte4-PdeJTHJcw4Sx-oC6MSpCic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:V5QYZ7QXu398fkOYIccP3_Qqebm-T1L3II9ADw5UY9YCbmmehtnGPQ>
    <xmx:V5QYZ_yTKKje5SLQOQRVLGxRmB9IqIWjrXtX6Kfxq-Emo_tPARlgiQ>
    <xmx:V5QYZ54GcoOye-ESfynG_YtGe8REw3cmgnzRfzRXvMzMtcyJlNJBYA>
    <xmx:V5QYZ8xWxPkeLp2KUW96c4M9RodFI3y4OlfNO5WYiYw_gkkEbnAPQQ>
    <xmx:WJQYZ2m42G98rpvGhEbPslW2cizbi6PxlBStW0-Dft-cesGn3F5VWOpu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 02:14:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2ee0377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 06:13:13 +0000 (UTC)
Date: Wed, 23 Oct 2024 08:14:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v4] notes: teach the -e option to edit messages in editor
Message-ID: <ZxiUTbmGpeK3KnOx@pks.im>
References: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
 <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>

On Mon, Oct 21, 2024 at 06:12:20PM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 99137fb2357..813dfd8db97 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1567,4 +1567,67 @@ test_expect_success 'empty notes do not invoke the editor' '
>  	git notes remove HEAD
>  '
>  
> +test_expect_success 'git notes add with -m/-F invokes editor with -e' '
> +	test_commit 19th &&
> +	echo "edited" >expect &&
> +	MSG="$(cat expect)" git notes add -m "initial" -e &&
> +	git notes show >actual &&
> +	test_cmp expect actual &&
> +	git notes remove HEAD &&
> +
> +	# Add a note using -F and edit it
> +	echo "initial" >note_file &&
> +	MSG="$(cat expect)" git notes add -F note_file -e &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
> +	test_commit 20th &&
> +	cat >expect <<-EOF &&
> +		initial
> +
> +		edited
> +	EOF

Nit: we typically align the contents of HERE docs with `cat`. I'm not a
huge fan of it and had been struggling with it initially, as well, but
coding style is subjective anyway and it's totally fine that one doesn't
agree with everything.

In any case, I don't think this warrants a reroll of this patch, just
to keep it in mind for future patches you may send.

[snip]
> +test_expect_success 'git notes append aborts when editor fails with -e' '
> +	test_commit 22nd &&
> +	echo "foo-file-1" >note_1 &&
> +
> +	# Try to append a note with -F and -e, but make the editor fail
> +	test_env GIT_EDITOR="false" test_must_fail git notes append -F note_1 -e &&
> +
> +	# Verify that no note was added due to editor failure
> +	test_must_fail git notes show
> +'
> +

Nice.

Thanks, this looks good to me overall.

Patrick
