Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B71E378C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455300; cv=none; b=clLSMlnNDl5xG4q/y+P0sVefya9ehjy6kFrP6Y8O8eCFn8C2elZL2+KKyj8RO7Dv+UzVV1f5uIEMgcQVSVAAVvN2f30z/bMbcVI/rtXydO0CnlIjmsVgB7w0cn2TbQAzE4S+GfC/wH52NIQxMggWb7t9qhgxeJ8NSVkdfPDS3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455300; c=relaxed/simple;
	bh=iRZsFEFQb1dXksu0G1x6PpBWKVR/ahUv/Fgf/bibT9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRwZrtDVaujhECc9XTYeTmUL2+kO+LDf8kx0x8YrYjzhifCKU1f/N625E0NPujr9E/d7TtSehFx8BufH6XyGuH4JgguaZWYz6wmwqxOZUoTu93O2sZHlg8g2v/55UCLsCte/fIyV7IAwbJOr2htgbuu1wcY1ntVslxAOneO2A8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ouFBXT4t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tw/rwvTe; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ouFBXT4t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tw/rwvTe"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E50D0114010C;
	Thu, 20 Mar 2025 03:21:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 20 Mar 2025 03:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742455297; x=1742541697; bh=h+QaARZ07F
	qII1bWkx3sg0Dd6A2gxwuSNztQ5Mi0V1w=; b=ouFBXT4tBQ+lR2hPH6H2PQNa41
	HGrBEZU44TcH7GhwGPUfXsWlPCCItaGrPmZLhP2YBDdLdbv0IS5U/arWtHcDVv4b
	yQkvBUTreJTjmPvknR6+a1eJwN80qJ1SlJyi63pezdQ2+9Cnq2zSb55UTrE1KWlo
	FJz6ONtIUk58asrGER5pikDapupo68KGbyDwjo4XViioiNnzIfkNJzE/NqqgYwDB
	dhxsiPeUPIiSIhdOMQoKQEIDGjcOdfZxg4yCXqMp9yLH3MYe7hW6eynqe9e9JZji
	o0v8Zj+U7xq22nxOkQLvU7vMmk7uibh83/fgmARLlTw5SE/WTbIlp4dPdXHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742455297; x=1742541697; bh=h+QaARZ07FqII1bWkx3sg0Dd6A2gxwuSNzt
	Q5Mi0V1w=; b=tw/rwvTenZSQT7pLRFXX9M0wMGH7zw5V3/gNo6vFY0dU6qz1G+4
	U2ipSfqv0n9J2sZo5lH6MpZeQ76j6s+jYO44SXPlydoRaLGJTWQJoP4s0BPbC/fb
	Q8MeUTiyXmsnLhemwDFxapIIfueiuCQS1nsqXeV6Fkys5UJG7+DySNVQeTCP+mpZ
	Mk+DUzc8DmYD3/UTWJv1IXaVNYes3eIUet2606trMVwJBAnGlBwvy337j31w2d+0
	ulXphQ+N03ysYU8ioOE0Pr0UosI/IutsPNddZk5aidfc4Mz+nQ3QaLw4sGXrSG3j
	/Zp8O9DbIvfiv+SPa8X8itfcfgogRuvfbdw==
X-ME-Sender: <xms:AcLbZ6BQQsVj-KQwOXlHss8rd46GyUGxV4NJQ-bAa8ACUNtWCzeptQ>
    <xme:AcLbZ0gwIu32oEOzs7Duzqp6xJ-U31x8IFatgTsbqnxZAZmiFOrK_-0p4D_3u7Fbe
    hlfjEpRV1v5iGVd2Q>
X-ME-Received: <xmr:AcLbZ9mWr5gRBjlm3GzYT9atKt9mGMsqlft0avWZGF9pxUnOKd_50Jt9PoG-L-XyoZWLkIYLlpkmwQHWQ5IfiMne4JCwh4rmYh44YmQknolTwCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehu
    shhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AcLbZ4ycOUcI9lU8VNskKTTtiOKjamtmyQxh9a6HsT51a46IzMNTPw>
    <xmx:AcLbZ_QzgQsKc72xjYL_uY42tUcD--81rb63dMw6YbjHIZ6Ml_7zug>
    <xmx:AcLbZzbzhvhrjH3fBWOhz8s-RGsDhgM52Rej7p4dKLJPzkfLcx8c4g>
    <xmx:AcLbZ4SjXYy8q4XyA15QF1ouyB-TupR6t2ODgcxl18onB7uuqOvGPA>
    <xmx:AcLbZ0_4XhVwzrf1oUkxU4Zoo_P9DtdxAjPXQAc_F6kSAc9C5-Es05Wp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 03:21:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2d00c03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 07:21:33 +0000 (UTC)
Date: Thu, 20 Mar 2025 08:21:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johncai86@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
	shejialuo@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9] config: teach repo_config to allow `repo` to be NULL
Message-ID: <Z9vB-Mm9YpIcv6UK@pks.im>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
 <20250318115912.2978992-2-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115912.2978992-2-usmanakinyemi202@gmail.com>

On Tue, Mar 18, 2025 at 05:28:53PM +0530, Usman Akinyemi wrote:
> diff --git a/config.c b/config.c
> index 658569af08..e127afaa8f 100644
> --- a/config.c
> +++ b/config.c
> @@ -2521,6 +2521,10 @@ void repo_config_clear(struct repository *repo)
>  
>  void repo_config(struct repository *repo, config_fn_t fn, void *data)
>  {
> +	if (!repo) {
> +		read_very_early_config(fn, data);
> +		return;
> +	}

I remember discussion that `read_very_early_config()` may not be a good
fit here. Most importantly, it ignores any configuration passed on the
command line, which I would think is very surprising behaviour. So
should we adapt this to instead manually call `config_with_options()`
with the expected bits set?

Patrick
