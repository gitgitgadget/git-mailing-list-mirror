Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B636897F
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042629; cv=none; b=K5ilIzmGmQYxqiuBKmR1rho4OMlQxUw3lbLj9ppWH7pGg/qvUx+gSlT9vWIlVAcEndrAvY7qFylk6WfwS+tEkLxbBD5KHSyJvopbJZ06CAaoAkmkYYJD+Ji2Grvps3eHj/zyDx3eaqr47qgl+WNAeLSUOnYdaPUhl3XSmmZ9uUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042629; c=relaxed/simple;
	bh=OJ75XuqHjGW8tFEv/l004R5UAI9lOCJFwFvSlHEKlO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etcBx1Ws8/4jGeQ50UdPgvUVuhcDobKxzGpB1fU9waWbHLWLGpsNaSGrtiMk16wRmMpJduB718cHrhww5fzI7ZOy9+ZVWLBRvA7Bg0mlD9T+Dcwm39+kUhnNG3yrsJNu/6VVRoPkvqsrvq56/Ms64HhEy0jdSRJPy8ABahjWF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wk+mLHXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXDliv+s; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wk+mLHXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXDliv+s"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 37DE11D002A8;
	Wed,  1 Apr 2026 07:23:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775042626; x=1775129026; bh=OJ75XuqHjG
	W8tFEv/l004R5UAI9lOCJFwFvSlHEKlO8=; b=wk+mLHXWVHmMi5IybmuzR/e2ak
	qRDl34IZ3TQbmJc917VK2VoVclAskVj1w0loCKB1hnmmvVfBYjHDe8Cwkn0DIPSl
	O/EE+udfjjTsaJ6mOMnh8/7Ir31Vz8NwIk3ba9ItZGJQbB+b5u2QTwvkYXtXjxPP
	i9LyQAb/gM7uBm13zelY1utyMvc40Ze9ToUcIHdQUrNq+kdGO5KDo/hWnuJx74Je
	/rZQhOQlviVUvQ8yQNYy1DX83VCQIwsgBWoJlqDOFu4R7ydKoT3Vn0jpeO4yo8P+
	EbzMaLGVYsjp4H6eHeoHXQ7Tvfp4DOZOWpww369j6rl52eRd+DeY2dapi9kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775042626; x=1775129026; bh=OJ75XuqHjGW8tFEv/l004R5UAI9lOCJFwFv
	SlHEKlO8=; b=YXDliv+seNMVQbTlNTo7AM4A/UMtVLAkKxEG+ihJUk+VXeDUisJ
	0QnYUkndKAk7+PuN1npgcGVIMk8qo3HFP3WP2952puI02eTfPaGsqyQmzoG0ICd+
	7fszMz4wEV49Y8add6jdrKUetKRV6O3CQyp3YpIv66jMs10T5Wfh0BWhEuHB4Hz1
	t3k6nm4P3JQ8ge9fTpg3QR/7gJGfbDqIQtB92jI74J17CrdgUO9WtvNdYWwdOLzP
	Z45jZOTb66Haqtl4RJWIPKzYIVGlqhy+oIet0sChxTGTBZGaX92OgLrSh3Bxt63Z
	rogYKb4p945bNGRO7H3hslyi+QfAl9DSVeQ==
X-ME-Sender: <xms:QQDNaRGdBDo3LFrtilm24Pw6J4L0viGNmCPD9rCiMXu_prJcMsa9NQ>
    <xme:QQDNadwdkhSh9_TEEQT-0IBTG7Kod7nslY8LdKx6Ip8uT2FFROWd2cnHOqHRDA4tb
    ibGOD3t98m6okMRXpXHCDqudhDxtdaRwU_VYvzqVP5H9Et5KSXJow>
X-ME-Received: <xmr:QQDNaQhnWIyCHrWjJsbr886bRa1PYAlzchqHxbrXkEdVFwSGvje0GCflNTwa0Yu58laiDBV9ho1oh1GwQdXJcNcm-bDij8Q5eiY1TXuA2l0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QQDNaQySXwJYM6RLVypdefyWVMLzuiW1olane0y8eSFbf956lXE2ug>
    <xmx:QQDNabJyWVWJRN-JtA2BKjJz9vyR4xQuJoNrMjGCzNYKSN7WzpgHJg>
    <xmx:QQDNafRCy9YueDDGwvg4JHWcEYb9Vl3t_OecazpCrmqbcTkf2EhGjg>
    <xmx:QQDNabrDddFDEcnBGBVwkPQ5DZfAKUse13YR_O5jmYQyi9GvouMGKg>
    <xmx:QgDNaRwzAYivZFpLywN2oDPDOTOY-BHOvRWweffKy4HyJllhzQOO_pdB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 07:23:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b76d659 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 11:23:43 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:23:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/7] odb: update `struct odb_write_stream` read()
 callback
Message-ID: <ac0AOEonqMnA20A1@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
 <20260401030316.1847362-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401030316.1847362-4-jltobler@gmail.com>

On Tue, Mar 31, 2026 at 10:03:11PM -0500, Justin Tobler wrote:
> The `read()` callback used by `struct odb_write_stream` currently
> returns a pointer to an internal buffer along with the number of bytes
> read. This makes buffer ownership unclear and provides no way to report
> errors.

Not only that, but it also means that it's impossible for the caller to
control the chunk size.

The changes all look straight-forward to me.

Patrick
