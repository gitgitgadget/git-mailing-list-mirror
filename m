Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFC78F40
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821854; cv=none; b=GkrVXAu2vSEtnuwszKNuTUVs6+ynfqQMlBD9iFwzqmqVZFg8nVYGrjsP4E9hZguA2/FS6f5quJebxLlrYtNoSzDgEs4qa+8GxYj42uVFkj8y3hPULmScxpEEr6Nl8Uw1kpEV9AGjYmZekZ9NLTiKZ77L4+I+MpCYYLVAZ7qHWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821854; c=relaxed/simple;
	bh=0yITxan1d5611HL/cpTcC3cqILLiAvM1MbU8iHpSDDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AfiI8pfQFaBCDwiXUjCh0hev4b+DcKAypwCDsvBhyxgSPqLhe8MrmfbQ8In4wUFx4saQJtuLvXZ+c1lHHZTpwCcWgML0QH9TnikjHwVLOsczYsnogt351eaYjaNebjVN2Rcr3yr13z1Fp9Iz1OwSCXnJzZ0/e56vs9ECpyKUw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NZdXW0xj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVgwe+u6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NZdXW0xj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVgwe+u6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 01B7D1380172;
	Fri,  9 May 2025 16:17:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 16:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746821852;
	 x=1746908252; bh=bQBK1epnUl59vyr3/DtfG+6uGu6xlFqIV8kDN7GZl84=; b=
	NZdXW0xjclEyG4ekHNXmykd1YP2pMDPAFUeUzWICNo2RZe+4faBXgUfE+dFd4jhg
	FuqXi/xOEFHzusjovNRI2954YEvCRd0DPYidSMVMEihdOJoo7pL9E19xCYD4uIqD
	17zRPO1CDQklRb7BQevWicE1fRB/JxKBFOwKbdIYMsrjLNYNfeKe3RHh6QFSsD0r
	WPq4nQ0Bh2p9iXfydeQbQ467jCV3OFtrXKFs/z5OIdKWYugUcaZ30ovu2k2ig9S/
	BnYLtk5zD/AAuGAn5Rj/TGnl2ZCFClcm5I5/n1dVX5/Yb06v49fUml6nvhWfVSf4
	PXB1YhIAeqgBA/9JEVHWKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746821852; x=
	1746908252; bh=bQBK1epnUl59vyr3/DtfG+6uGu6xlFqIV8kDN7GZl84=; b=k
	Vgwe+u6JlD8QF4HDK+Xe7NBPkMyNzXOvTPSTqrG3QLO1wgPCotLAZDdg5nHem62E
	TYYGGAFfaeR1xml1JC0qR0mWiLAl83daemtjCevua16m3lGoQ9K0dXYzdAYBJk0n
	UXSoR2Ti9S0wD4mFRnY2w2qSVMS3ZmWFTbSrdjrj64m9olnni8Tzi9qLz1dE3Ntv
	fPYOqQL1ks3OnvAkKz8ao1p1SwtkNaypoX1uOUngXHVXUV4agcsLaB9xg7W5fsTO
	cMf7SAdDFOFCjIpY7sZ6ry/qA3TQD1yrTr9IPaKpeSNA/j0drFqimREW2Jaq7V9a
	rYDaJybNCBxpLg+xJiAvw==
X-ME-Sender: <xms:22IeaMFTyCyzb45e3t5FRE1kPzB2RHa8m6tAPXoTBOgnkj3gHaAMhg>
    <xme:22IeaFUrbehVhhZJcf2Mrhx6Mdb_x0VFSmzkSdNpNoHtX7dsCzMCGV8oSltXSTNsr
    ixiRH2ZVIvs3HF3-g>
X-ME-Received: <xmr:22IeaGIpJqvV1WJ74zRC0v97-2VZ9WClW5wq7nE-O3qaU2r8fLGPLWW4L4j1_Av4YEaP1tMGl0GfZY4yNpx1SDWz0zB8ksS7STIJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgr
    mhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnh
    epgeeghfdufeekgeeuiefgjefhjedvjeevtdehgeeuudekgfeileefueetjeeiueelnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkug
    gsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:22IeaOEWqY_RZ3bxvruO5joKNsZR_MAsfE_m3C5jTmMl0pMa77ovLg>
    <xmx:22IeaCWoPIc_qIFEiJsLBlfvIFpABrK21ujrl3j-xGWJXPgokitg2w>
    <xmx:22IeaBNy56z8vq5g6Z3UpKOT52cH6xP3Lj2td4DYq5VOvhkAFAg19w>
    <xmx:22IeaJ01KqVEgqQbRU-4ismXhpT7hfYKh8eO2GCVFQXSAXeUzTbHGg>
    <xmx:22IeaFeG9ADWgwxbAu6Bev6ZICxiqOV-fKcPoIReshijZrsT4PP-6O6k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 16:17:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: fix Cygwin infinite recursion, Tamil translation
In-Reply-To: <113a6aef-7dd3-4a5c-8c0e-1acb9c0bd16e@kdbg.org> (Johannes Sixt's
	message of "Fri, 9 May 2025 19:29:16 +0200")
References: <113a6aef-7dd3-4a5c-8c0e-1acb9c0bd16e@kdbg.org>
Date: Fri, 09 May 2025 13:17:30 -0700
Message-ID: <xmqqjz6pzgh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 4a6cc6a20eeb593f1ad0f60475a9867532d7c5d5:
>
>   Merge branch 'pks-meson-support' of https://github.com/pks-t/gitk (2025-02-20 10:54:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to 3fdbf184be906b5f6abb35c02842ec8ad861e8f9:
>
>   Merge branch 'at/translation-tamil' (2025-05-09 18:01:02 +0200)
>
> ----------------------------------------------------------------
> Johannes Sixt (2):
>       gitk: adjust indentation to match the style used in this script
>       Merge branch 'at/translation-tamil'
>
> Mark Levedahl (3):
>       gitk: override $PATH search only on Windows
>       gitk: _search_exe is no longer needed
>       gitk: limit PATH search to bare executable names

Thanks, pulled.


>
> தமிழ் நேரம் (1):
>       gitk: add Tamil translation
>
>  gitk           |  221 ++++-----
>  po/meson.build |    1 +
>  po/ta.po       | 1457 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1553 insertions(+), 126 deletions(-)
>  create mode 100644 po/ta.po
