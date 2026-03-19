Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA453BE165
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914764; cv=none; b=YkspXQOFV2vWY217073bcT/nZmv6LK7rhhirNXI8p3jXM6tdpeItj9Ws8mnbv6CXs989H4T2oCd6f5yX51/XeLpNzVKqF49MQk8pYpAqdwIzacrcGUxaJe6ePTE/5Xg+TNrtAXs0Bcos/kkSdgKSjoGHIPrg2s+RXMuCtWf9E5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914764; c=relaxed/simple;
	bh=pty87DOZARRmivJMSK0gvcu83E8+NBiYPb61ctr6m+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC2tjCshmXvv9THqw3/SE6Lj/kUdIXJi7j+QmJzfTGXZEc3TQeubhbEKDsR3uXAnyz1wS22VSRy6mTPT/OnkWf1Ljc/hSX+sPqpPSHKw7hMlEwutjUNYJll8UK1jeSepJA/mkrpqNQ4tZxruijaCwwSFZVk1KPEUMNsE2RFmCI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rvt+5nOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGd+1CQF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rvt+5nOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGd+1CQF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D154814001F7;
	Thu, 19 Mar 2026 06:05:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 06:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773914759; x=1774001159; bh=BXLDw1MdQJ
	tL5rNFNYkn6lDZ3VuTFJZSXr6b9ySVVAo=; b=Rvt+5nOn6GHNfnT6zAat6PiFfu
	UMgR2CIqQFjf0VrrTaKk6R1fGPPwjDp9Wkj6/jYcGYo036ry0oiXFy0akCWCNssl
	hrENJMU3KI+84ewRLpDJ85Zs3rwQ1YzfPmw4dOChJkuE0UrALw4jk6U8/MPMsYk9
	YwBIRkUX0p+10yT1qC5BLyznsr4pZ2w4inGG5fdXvFQ3knKFklXu3otI0uIKnV/U
	19Q2/qzhuTYwsXU+96Ccoa/RSlHIv22eDIZjKLWuJDNf1KHX3NHQ0Wwzh+VRAu1z
	+imZX7MJpkX5wit5wsBvNPQq+w3nisixYu+q9e6mwo+2BdjMAjO8xZ8Ajupw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773914759; x=1774001159; bh=BXLDw1MdQJtL5rNFNYkn6lDZ3VuTFJZSXr6
	b9ySVVAo=; b=YGd+1CQFc23alRiEteltvw72qgDl3+V9wMGZ31Vtvz62ihOPJha
	SO77hCte868MLs8W6TVltzuDRDx5flx3DIIQ0pP/3QSvt2DAEFaEVjLlCwCE4z7h
	EBjS8461nv432rhhHKDP46lQbZZJB5UFMQWNiwI2o0dL7eIg24Spxsx47h222cYQ
	0e4ka5CfpVop53ZxFlaGaS2+5lHwHvtnAl5KvfEJOhQxVapYPCCOa+oqjhTXmB5p
	Ti0/N45+pfDFPySkOzf4RNCKg1A7uSczuyRD4ridrQd4inv6Rf6tzyP4y4kdtuT/
	LowIpNMWNDrMOuhctrDDm7Bm5Gj6gz5LfhQ==
X-ME-Sender: <xms:h8q7aZQFBcS6L9YKQYPMplAm1uZNZ2eo0TR5-CRnuUcc95EzDf8J5Q>
    <xme:h8q7aZwYxdgzHc9urrU50s9Bv5qmFkxLKwbsN8uOhEWzkiULj-2iIM1tSnuwv38C4
    DwbbmNWVDhUJQArZXaCpF1W9ZCrPcu1g5cK9tXfWP9aLbM_NdG5>
X-ME-Received: <xmr:h8q7aT2wwcWlfdZqRQsboVXUQLtZxsqFSgzGFvFpqMShYaZdLHVGiClukYklCf6u9EzYc8Jc-v_Ryw6-3yB5EtaUxEdxcndHnYynluI-Qi_u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprghprghtvghrshhonhesphhmrdhmvg
X-ME-Proxy: <xmx:h8q7af7lKm_FA9CXQVGdNIAZPT6YEhLyCEtrlxLW05Thi9u6WmR5TA>
    <xmx:h8q7aeVWT9dPHNC9Hl5ZuQnmHYvxmwEgr3yPcugogE54wmPefW0whw>
    <xmx:h8q7aWALjPToK0eqkuC2IkizOd3VCEuHQz7WUyGs77dzkFmAFW2ZSg>
    <xmx:h8q7aV4rRDajGYIbGBrlxpH9lEQToHjFLnHM8wx14bXUhPsvPVm4gA>
    <xmx:h8q7aVBqaZEyfDFDvJ3zek1MlrD6lb7vQ7Mzrrj2mcEZQCP9n25QriBf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 06:05:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60a25ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 10:05:57 +0000 (UTC)
Date: Thu, 19 Mar 2026 11:05:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Paterson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Paterson <apaterson@pm.me>
Subject: Re: [PATCH 2/2] odb: use odb_source_files_try() in source-chain
 iterations
Message-ID: <abvKgsCe1V5g6c0s@pks.im>
References: <pull.2068.git.1773674983.gitgitgadget@gmail.com>
 <a8303b1427a41fd4b3ca107eabc49e8ac6d02410.1773674983.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8303b1427a41fd4b3ca107eabc49e8ac6d02410.1773674983.git.gitgitgadget@gmail.com>

On Mon, Mar 16, 2026 at 03:29:43PM +0000, Aaron Paterson via GitGitGadget wrote:
> From: Aaron Paterson <apaterson@pm.me>
> 
> Convert all source-chain iteration sites that access
> files-specific internals (pack store, loose cache, MIDX) to use
> odb_source_files_try() instead of odb_source_files_downcast().

I have to wonder what the motivation for this is. We don't have any
other sources (yet), and we're still in the process of bootstrapping
pluggable object databases. So it's expected that things won't fully
work yet that we'll die in lots of places if an alternate backend was in
use.

But the solution to this isn't to simply skip non-files backends, but
rather to adapt those sites so that they are properly abstracted.

> These loops iterate the full source chain, which may include
> alternates. When a non-files backend is added to the chain (as an
> alternate or additional source), these sites must skip it rather
> than abort. The _try() helper returns NULL for non-files sources,
> and each site checks for NULL before accessing files-specific
> members.

The big question here is whether skipping is actually the correct thing
to do, and in most cases I would claim it's probably not.

I'm a bit puzzled.

Patrick
