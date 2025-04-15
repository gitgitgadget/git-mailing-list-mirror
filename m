Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28C14B945
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708764; cv=none; b=No4KzL0Y72Rvq1/6oMt3PPHeTFPmh5kQr2Gg9AKDZOA0o5tXLV6cuUHq6PYDJlCREBfd3/3etxK0QgkI2ucC2RKu6bgR10ppCIuxTXwtL05FU8FMISjb8UYeaeWzlpeffAAIw2UaUiVhiMruNT9qVsrTkaNQUh4w4IisyJY9IoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708764; c=relaxed/simple;
	bh=wOL+VSHR0/UMmLl9hdGNVjI6rCYzQhWD5Km4XsrlLPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wju6aNnB19VK1f3KB0jOJFITdickSyTbBpY4Pm5OgCuxJ9wIE+JxlPyBpd+XR72vWBojHUSM+qrV2zyEdRiMpW5GEshVdSaoWi7Z0GarIRb8ya73gaHx2a8MWe8HDJI0L79gK/FX2NLC6CPJBb8RXfJfoFOVCOmQ3VLPo8jPqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6LD1+79; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKcyJp/3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6LD1+79";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKcyJp/3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 951EC25402F8;
	Tue, 15 Apr 2025 05:19:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 05:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744708761;
	 x=1744795161; bh=zM0REPFqwR9Qvaapf/Hfh8+YHtxXq2qN9eD8nXIms50=; b=
	C6LD1+79KBEqA1LhSQ7Z/4L/MES7FNVaCe3wQG9an4IMmQPWuSLaulVMCusswBFr
	wI2y9y0kTFhX9ssWSxkxYp88F9Hb/HeGR6LJiIuORyvcDBxcZ/zR234C5EcZzNlf
	F8gxfJWb82JLGdT/k/iFaquhUc9WZlL+QAJI6Y1LSsnwn06VByrt3EC4TzNDJHMy
	kyuEA5lb5DA3fJA9oZl1PDUtlBnlPYQ1aK/bmmTBM1nnI6jIZSJdg6wqVclodcOO
	zvTosEC5VOaCEbbz3POqKaWYVr4R75l/42u44uNlsfzXrHc1oA3V8ft1SigErGkQ
	5xfe47ZT3MBid5PSVj+pAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744708761; x=
	1744795161; bh=zM0REPFqwR9Qvaapf/Hfh8+YHtxXq2qN9eD8nXIms50=; b=J
	KcyJp/3q0v77FzYSlzWJIKGA29u6lKtZta/6OiLZkDosvjIlQpm0r6rHHx295sSj
	EggEbhmrHLfIbZD2BIOTq6AXlkkuZa4b/S4DMhYvND1QsZfIeseqXtsDIfsg88IV
	OITIO9YFY3wGnpPBRHcXCRNyn/lG2urI7lrkTY+TcMdKutL0ptmM2/vo7S+h/DeQ
	GSbhhBHphus5nDSPbEE8fMKPCsTQiMp8bNkV5A5VXFkMpyWzS7RXcFoJMuLNn+Jc
	zZtSKN1o7zX9pRpO6A622m+TM6g427/jUdXt4pj2ssa1nCnKyHt2SBfpX/3ll4AK
	Shzf4gIA+3kg/h7EKZDww==
X-ME-Sender: <xms:mST-Zw5wipUBO_gZjiwPpihjcZ99AfLih4G-tRtRLhjIPM8CEBk95g>
    <xme:mST-Zx5mfMWfgWNr7FrclTq0CgBtDBrZi4AYse_m6bFjBj-e0fzATnr3RDNReRpUU
    YctUJelxPWu3js3wQ>
X-ME-Received: <xmr:mST-Z_fGvvjCDmMioYukzfoJrmw8iZNqG_vYLmZSeiHhMRDcXi94mCHAMobY4IQKdd6zTdEB44fOEF8k_fA2bcWcbXunz2E3jqsVIGWZjZR8SA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mST-Z1INlDJxL96W9pD0sHrA3XFoVBPd58od9Kj2YJYNOUzpt4S8FQ>
    <xmx:mST-Z0Ic3SzwNbI9ld_dAgenpzx6DbyHooj3EE8NX6XGw7AYcoLANw>
    <xmx:mST-Z2zwRovfCKONxrvLdFUraGvKDDXigJw9ghLQpK7Hh_MW57HpJw>
    <xmx:mST-Z4L3Yseo0p7k9PV6EGGeFfPNt-A5LJDdwLPcK2hm-P14T_S0TA>
    <xmx:mST-Z9OETRJ35QJFO-zd9rxBL7urNXl3caCIirtcczsyB-_Q66IpjVLL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:19:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8c3e863 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:19:18 +0000 (UTC)
Date: Tue, 15 Apr 2025 11:19:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
Message-ID: <Z_4klRXH1wwv7JXJ@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
 <20250411-pks-split-object-file-v2-1-2bea0c9033ae@pks.im>
 <xmqq5xjampdc.fsf@gitster.g>
 <CAPig+cQ5AEwTaK2LYkV39yrZppnF_MMMnB2V0nTGWZ-PcptVYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ5AEwTaK2LYkV39yrZppnF_MMMnB2V0nTGWZ-PcptVYA@mail.gmail.com>

On Fri, Apr 11, 2025 at 05:29:13PM -0400, Eric Sunshine wrote:
> On Fri, Apr 11, 2025 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > The `safe_create_leading_directories()` function and its relatives are
> > > located in "object-file.c", which is not a good fit as they provide
> > > generic functionality not related to objects at all. Move them into
> > > "dir.c".
> >
> > It may be debatable that <dir.c>, which has traditionally been a
> > collection of read-only operations (mostly for exclude/ignore
> > processing), is a good place to host "mkdir -p", but it certainly is
> > better than having it in <object-file.c>
> 
> I probably would have expected safe_create_leading_directories() to be
> moved to "path.[hc]" which already houses functions such as
> safe_create_dir(), normalize_path_copy(), ends_with_path_components(),
> longest_ancestor_length(), etc.

Ah, good catch! Will adapt.

Patrick
