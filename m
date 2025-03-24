Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D578C91
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742811603; cv=none; b=qZN1+hBuyo5pUrQROLGHPb6uSVyMPY1sv2mmQMTX2m2NeXe7hT26ew7X599tmyOiHp6T7I607Hx1BTxzzAVW4Ga+5YSoLmBP1lXJY9UUngOX5sFZU1UMulUFbmBtnVQoO4TpWf8aaF6rpB8+Nrr8n7QWzRj+QD3p17lWPDSTGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742811603; c=relaxed/simple;
	bh=o7BnD2PVE66YOJacAFY/uvnCQrqgM2hrOgCDPdc2k94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQfrWCTvZoJXI2Jl46QOEKhso4xGATuoO3fJ4erWpRRS+4iEvHDCCLEtK9vxOLvEvlGP+W3jhU2UiGedqEQXkit5121o1bJUAa4bU/hSADQ7OZBRSSzM6VEeXY+QU7YHlmPV6pHQzr8dsr0QRiGd/hbHCWJcQTOpwPbx0VoOi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KNCl5973; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEEwKfGq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KNCl5973";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEEwKfGq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 034E013833A8;
	Mon, 24 Mar 2025 06:20:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 24 Mar 2025 06:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742811601; x=1742898001; bh=XsQsm72Y2x
	Tn/5LudkmOJDRLrzNDaXPnH126Hs0c8to=; b=KNCl5973usZhHpzcNrGgmzURR1
	OKNqFot0ts/2RK0zVV85sRUc72Tp+n8bMiV3FpGJVlFV4N2r9rTn05qBmevTB/gE
	idK4mQvcLzQYd5fz8VpHBY23ImozWudA3f8UihbCIPut1QP4s7DHxR+4Rdk04Cmt
	URO5NNQgYgLxSwFqgjnP65ich6tk5i6zFTImNuPATBStUv0hUG+KEEEKnI7UUPlS
	AeyNrtuTTWNHEifBkQ/RyHy3sQAwo/uJBA0TKfgaaBocE01mK7479uPr3q6X3Ece
	X2IohvVMCZxGQ060lB+g7XV0VENSM08Q4UUUObN5tI5Ow66LQgpwBm5PzlbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742811601; x=1742898001; bh=XsQsm72Y2xTn/5LudkmOJDRLrzNDaXPnH12
	6Hs0c8to=; b=XEEwKfGqYZUXtigrWmVcub4H/4SkcT3OBZb6dCn+Xy6waglS0FF
	nDyU9Z3o4VaXGlw2NVGyqeIvQsqCA3OyQNnD51baiZI22TjDYy6MhttrBeVIMFvb
	jct71hHvuevnzbgm3NDZeorcXXc/COpHhxN0HPDWOKCrdF44lz6+cWJWOcMv6ZrV
	WHNMOeM9fZ1K4kKhNjuEXkRzz68sVR+EvBkl0QRPSPgvvDW1oUu1QNo4RMRaDgCS
	vGYfoRSYcgj4UGVDFObvkgT/hEool3s8choS1fT3uSM99HUhdgXIoc92CX4aUrEc
	MaaMh2WRLcuUsW8fsQG4kqRgsu9z/YHX6Ow==
X-ME-Sender: <xms:0DHhZ7XD_oSElw_itJtJKLqCPegvdQZqi3e6E2_EN7PhmweODmdQGw>
    <xme:0DHhZzkOIC3WyqIkJ6MqebcTzZuOGa8eH8nIbNQDc053_HXM_sXNTbnrXMD_OJE6i
    HeHmnGVKTBLqlng5g>
X-ME-Received: <xmr:0DHhZ3acWYWC31A7Un-pzUWWo0CIlLW46xBIkgPMbLCCyZ6rKLCWIhD5QY9UMnC8khBxPI-NylTxlzwJopI7fAa2Hwcj4Fh-IfLF9VqEaWtjwg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvg
X-ME-Proxy: <xmx:0DHhZ2UOZR_PsGg6Uzrw6q8vQywyS8yGrh9SmYsd7DLix8pBHrywBw>
    <xmx:0DHhZ1mjVUA-5g8VW7KbhUYZv0feuGQG9jzjcvGr_ZWgjXDF2vDSFA>
    <xmx:0DHhZzcfK5oNj8kvMD1yapkGy1vFcOFiS3V65ktuTSZI1A7IqfwqWg>
    <xmx:0DHhZ_FFuU0Q9gIBcoOkSx42ArfCwGqvXNO8KI_UvLqAlzTjirj9wA>
    <xmx:0DHhZ7iUjTmfvKpQotWnGsI7X2B0aeAZEUSqE09p8XZH7OEms2esUsAn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 06:20:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12f59b78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 10:19:59 +0000 (UTC)
Date: Mon, 24 Mar 2025 11:19:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Mar 2025, #06; Fri, 21)
Message-ID: <Z-ExzkjgAor2JQ2r@pks.im>
References: <xmqqiko2tguo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqiko2tguo.fsf@gitster.g>

On Fri, Mar 21, 2025 at 10:48:31AM -0700, Junio C Hamano wrote:
> * ps/reftable-sans-compat-util (2025-02-18) 18 commits
>  - Makefile: skip reftable library for Coccinelle
>  - reftable: decouple from Git codebase by pulling in "compat/posix.h"
>  - git-compat-util.h: split out POSIX-emulating bits
>  - compat/mingw: split out POSIX-related bits
>  - reftable/basics: introduce `REFTABLE_UNUSED` annotation
>  - reftable/basics: stop using `SWAP()` macro
>  - reftable/stack: stop using `sleep_millisec()`
>  - reftable/system: introduce `reftable_rand()`
>  - reftable/reader: stop using `ARRAY_SIZE()` macro
>  - reftable/basics: provide wrappers for big endian conversion
>  - reftable/basics: stop using `st_mult()` in array allocators
>  - reftable: stop using `BUG()` in trivial cases
>  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
>  - reftable/record: stop using `BUG()` in `reftable_record_init()`
>  - reftable/record: stop using `COPY_ARRAY()`
>  - reftable/blocksource: stop using `xmmap()`
>  - reftable/stack: stop using `write_in_full()`
>  - reftable/stack: stop using `read_in_full()`
>  (this branch is used by ps/reftable-windows-unlink-fix.)
> 
>  Make the code in reftable library less reliant on the service
>  routines it used to borrow from Git proper, to make it easier to
>  use by external users of the library.
> 
>  Waiting for Acks, especially for Windows bits?
>  source: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>

Johannes mentioned [1] that we can move forward with this topic, so I
think it can be merged now. Thanks!

Patrick

[1]: https://github.com/gitgitgadget/git/pull/1874#issuecomment-2740342672
