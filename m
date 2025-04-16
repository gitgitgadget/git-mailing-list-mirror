Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998C238159
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794372; cv=none; b=Xh+e8MfgkEhsrjTQq4i8WvXx/SYGJb2K8G2wF/X9finw8MtooZwRFUK1tVMCdpW4CRDyjq41Vf7plANk7sf+JrRPWStXXP6MtuhuyHqHfhpaLctIQpPpf3sG0kUVistq0IXJdyLYNRPeW2vXh/+quV+b75W/dvYtv0WunNjfpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794372; c=relaxed/simple;
	bh=GGOUca7dlSlRsAtTabeIgy+faS0SvBHo9G1R5cgVbRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOxY83QkMpBt4dn8w//zteU2wDJccwnfyNTVVxNa/chDJjLkr3shvmZtRUpuEi+MbzPgYrxz5Rd8dzQzzFmt9e+dEkee6hWlL1HC5fhMcT+jCd66OgzxuA1+MYocGY0X98QEcIQwHEu0scN45NNQkz5mu3P9hqro3XVGt4NA8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VXm0eiSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDY0YM8p; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VXm0eiSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDY0YM8p"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B0CED1380438;
	Wed, 16 Apr 2025 04:54:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 16 Apr 2025 04:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744793672; x=1744880072; bh=UboInIovjl
	C91gsmh35daekS5H6ICO3YEl82tJZQDVM=; b=VXm0eiSDe/SNCVQToCyNlL7HgX
	f3OkUDtQjlDr2BgWWK79RR2gR8lkWpGo30Y5AVxY+NYDptyx53TNL6r1rFDf1Ch+
	nG7g8P/N3OGem+Q0GSwSsO9Hz5/elHuhwGiQBT4BDWX6KS/txTdjdpIXMWr6seJz
	5KcDx1W6/iM3lesQl4SWTHJY8X2IKD4Na/v00Mo6fKKed/sB78gUTEMVDYnTBZjo
	6oIv02ONxwdEX/KGzFGz0h9qv0wmU8hR/WaXpWrm61nb9jsKiywlHPm57eck0wo0
	UM9Mp0Gx44fRtgqDK4MbPQRhB5i9ZPStyhyF4EMp5HzDDUKTYth+57D3Clvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744793672; x=1744880072; bh=UboInIovjlC91gsmh35daekS5H6ICO3YEl8
	2tJZQDVM=; b=SDY0YM8pSK4khkMKhL8OcG2Jj+YhPkCMrv2r22lWp5rcp1Is1MF
	Kwk3zD0P5O2nVGmoWqW0Jei8cjlWDdty9BWUB6+z2Axnqe94uyd/FjYLOEOtyO3G
	lktdNfGPgzBCarybLvVb1jZD4Mi9KhDqxQPGByilq1E5PNtQGiLWUQrcnV3JUw2x
	+YkOF2/hXBFLBYxG3AXRj/QnULVNHKj8vM9y/gPycCii25O7RRAkbkFNjf0ES+/x
	HHvLwgjuBuczukZR1GIyxE6I7lzTI7IDDYT5uXvtGBK8Arpgz8fviDnMx5vZLX97
	OazvP1R0gaStmVdDZ5MBghZHUFj6MVhKAzA==
X-ME-Sender: <xms:SHD_Z4gBVsHJZWk3tIUHTYG5InzzX7pl9vwjX52ztKafopls8-UuHA>
    <xme:SHD_ZxDzVDgYH8iMHt9MomHhgkIaX3QfnfznimvN4ugGTYEp3KvqZ0o3d5tARqwhA
    87BCZainXV2c1LRKg>
X-ME-Received: <xmr:SHD_ZwE2rDgzqvFiWHyF1SKPlQ764QBvt9qYXLfaRWXlBPkci4B6JdsZdHo4Eq2_GDZMVAqjXQFWIDaCfMGFz_5Nf5LPih3bTwUprcqM4_MKsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SHD_Z5RQp8W0utVkEIDAS7StyST5wzIEJ80rrGubUyBJdWsj5tJQAg>
    <xmx:SHD_Z1wLVleSNyHl_LfEhkb-Cq7UoTHmuDPBWllepV0WssjrDJKYpA>
    <xmx:SHD_Z34ajj_Ij0IVN5FYjl7RJO8eh0hNi3nPL3_YqdMjPBR3TgZIEg>
    <xmx:SHD_ZywNFN6F57lD1-oadUgQ8qlQTmmbiCTbUv7T95ve2iFhIyCikg>
    <xmx:SHD_Z9OvnvbG-IdGYWOh4SrMAXMzF91NBDOOPQBotTLZw-wTj0D_Uq-l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 04:54:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33d05317 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 08:54:29 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:54:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] revision: remove log_reencode field from rev_info
Message-ID: <Z_9wQLTtj9t45Wjj@pks.im>
References: <20250414151438.22232-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414151438.22232-1-lucasseikioshiro@gmail.com>

On Mon, Apr 14, 2025 at 12:14:38PM -0300, Lucas Seiki Oshiro wrote:
> Remove the log_reencode field from struct rev-info, as it is not used.
> 
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> 
> Just a simple cleanup patch removing this unused field.
> 
> When I was working in a previous patchset (this:
> https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.com/)
> I noticed that this field wasn't used anywhere in the code.
> 
> I also saw that it hasn't been used since it's introduction in 2006, in
> commit 52883fb.

Nit, not worth a reroll: historic information like this is always a nice
addition to the commit message so that other people don't have to dig
into history themselves to figure out why the field isn't used anymore.

>  revision.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/revision.h b/revision.h
> index 71e984c452..87f8d798c2 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -292,7 +292,6 @@ struct rev_info {
>  	struct string_list *ref_message_ids;
>  	int		add_signoff;
>  	const char	*extra_headers;
> -	const char	*log_reencode;
>  	const char	*subject_prefix;
>  	int		patch_name_max;
>  	int		no_inline;

The patch looks obviously good to me, thanks!

Patrick
