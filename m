Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7861D1319
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298481; cv=none; b=j0BScoFFlJ6rdn+n9ERY+nXRraAiniE1pRdQVq10Vp257GOcUR/S6DlmK7OIYVV4p23GuxdrFqRKUVe45tRn0AJZu5iWj8nwxb5qd/veFWHV5kGu0rFHxxJ0qNd6h6scfhLalzhnLqAuFp94MDP+LGv/pjffJhFlJxzHXfAhE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298481; c=relaxed/simple;
	bh=NmnReqsyQA3LG+OFZL63RaI9ZhFZKo5RXEKpc26LS+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6qr0Wo72ja9SUmaYIJqVrphTfOOQxDvbC4m2DvoowJc68pQRh5Fqdprv/PsrNmT1qvLHIsovr2GH8sVL94+F3An967zJ0sYF6yIO4dMjtuwxdKlsqO1LcSEHsdlX2NlxfoF4Fr32ApP0njzHTHiAJ29x2hLMWeOrLyFTj0tVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KMjzgFQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRK5YPGs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KMjzgFQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRK5YPGs"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 96C7411400CE;
	Mon,  7 Oct 2024 06:54:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 06:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728298478; x=1728384878; bh=Zm2fXMd6h9
	5V7UMF7Q9/CcTcFpRkNyBPDVh+2VSAg7w=; b=KMjzgFQ7RU5ccufFraGTpF+DoR
	ztMIE384amDi6iyzwIYkoI7mXVHo/WKzRi8kGKL40eUNVzlT5Yioff0ITxdCBTyI
	EWmF/1BAHsI4jTiTAyK2KuwcOEHID6Qh25WobY8YiOMpA+psW4Bdz8fe8CkPz0A4
	A2+G+WjtK12EvGClt62V4wpT0tKAdNqi3W1qkP2+U0xqhBJ/Qbm5Y1az59bOhoMw
	0oZrU8mDXxiwacQ6RNK8x+DC/oYS3k13akvSjBV0CIX9O8ylO3+ZTZFeARVOiRJ0
	rldE1D1zpUyjaNm6hjBykn/8uikywj1xB2gBH7sl5yTPqk4nEsa7qrzxKleA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728298478; x=1728384878; bh=Zm2fXMd6h95V7UMF7Q9/CcTcFpRk
	NyBPDVh+2VSAg7w=; b=QRK5YPGstMdtLGoysoVN5pi6ObFsmbFkpG+PFHU2nwg+
	ns16CI3I9g1KhaGHspweuwiNJ+dmlq15LksWaFrSMXFprwBcdsJjSImqq/t+/QYE
	DIlZlOFCyJJp+eMQoPmnN56CORhrGQ6VQ/PNxBL2Q3A8SHiQvbeaoRddbs5Akohx
	1VyioO8I1Y9EFX3VlzIYMHHGQBFIueFclE4/x9D1IpIJ93lSP4IP31d4xm06Mdvd
	wuoLZSJ8+sKYMmMFOgm6u8oiUMbjYko8ZqqyLteCjKcuH9Vmlt3VRBgCzPFPdT2c
	mIGDHvKv82fMqPn8MhJnCzoeAhjHHMDsuI/EQ8rpsg==
X-ME-Sender: <xms:7r0DZ31iOp9P5LlIntqSbAdnS4SybqxkX2eE1bVD1iL-OTD5Q29Jvg>
    <xme:7r0DZ2FZirkhdTJ-EC6jZduDLZRiWLRPdo-IB6HaqY0XjUD7j4tVRMzNV2RxDK5zH
    CXi2cpRNnv98NYxfg>
X-ME-Received: <xmr:7r0DZ36MAccgLwuxZ01Rz4UDtH_DjukuQHLb-nGbpxkLNQBzLj1JCZA3XIS1TQ-RAZN6OmZoHhi6N-BW7auq3UhI9jgyXolJInjCbEVmcVo8B1WEJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7r0DZ81x7Sx7DeYkWqmjELc2zxbqW67xwk9rZmQiA1ffOSP-yoHkpQ>
    <xmx:7r0DZ6Fml2BKAP2tCtEuIvs6tkZ8-xUzW5oaoe6PAHq_PLU0ABVVUw>
    <xmx:7r0DZ9_0_eGJYR674L_Rss6UZLYsE2vw2BnSKzhsegEyx0L7vbRQ1w>
    <xmx:7r0DZ3kuU_UPbVgzYgORJX7FrTIguf779Jrev4nCvEpTbVr2H75ckw>
    <xmx:7r0DZ2B3tqe2jozfs-4XXyMYGzMs-xUoTd0ONmWdB9H-ypL0lf2dxCyY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 06:54:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1bdf6be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 10:53:37 +0000 (UTC)
Date: Mon, 7 Oct 2024 12:54:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v5 2/2] t3404: employing test_line_count() to replace test
Message-ID: <ZwO96ACW05R_9DPb@pks.im>
References: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
 <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <0ce40300fa32bde27c789fae9e0c642498710a25.1728298308.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce40300fa32bde27c789fae9e0c642498710a25.1728298308.git.gitgitgadget@gmail.com>

On Mon, Oct 07, 2024 at 10:51:48AM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a65783c47..1073eb88fa2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
>  	test_cmp expect2 file1 &&
>  	test "$(git diff --name-status |
>  		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
> -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> +	grep -v "^#" < .git/rebase-merge/done >actual &&
> +	test_line_count = 4 actual &&
>  	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
>  '

There's still the space between `<` and `.git/rebase-merge/git-rebase-todo`.
But overall this version looks good enough to me, so I don't think this
requires a reroll. Thanks!

Patrick
