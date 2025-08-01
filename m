Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCA220F4B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037084; cv=none; b=c/4FcVCIoy4TA2yd1YB+6J3mU3TtR3Oy5v5v4zDFrOBWTrIWdG/eOGXBr4BJc45wHDjD+58yawtFrzjKqu62Iw0cVXUen/6ZVbQBTgzxx1UdQgdUWnRZ3LDiLIX8fjulfrB7N873+YV8rooVxsSe/41oIDs70RHxUT53mkCYEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037084; c=relaxed/simple;
	bh=sCPHeqghAOiwGFTsxET01sG2c5pcvPnXFuY35KdBk0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dED0IUmgzxCQjeY2qv2Gk1F2COkW6LT0FUsxewMNas1Es4juRg1VypMsSFGQwjRStwZF+TEsWpMl8KDAOz1Vzw3d6OEAZhZXey3m5HwYfU0w6tetpViH6qFSQmW1pYqr5kEif/AaqyjYyf3wJfkFAr+llB7hrmVmT38DcmiX5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bp7D52Xg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMGDwCDA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bp7D52Xg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMGDwCDA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 70273EC15C9;
	Fri,  1 Aug 2025 04:31:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754037081; x=1754123481; bh=JM5YF0+8su
	eJ0NpDZ8d+pJ6SEuGMpj3Ob10q7JYs2XA=; b=Bp7D52XgUbHfWaVQ1FkzgwmPTn
	S9tkVodLuOHOyYIsJqulIU6s1XO8KFUmnCGz1L6KfmMHaCcNU92+YcGW17yjxq1p
	YwnQMu1Ue6qpCf95uqdCBAGiRLTlRNJ1ffhyk63QCHmbgw0COoAmP5pxTthdM8zI
	mSjrTO2z/raYX2aHAgwGjzuinhGu1sDdmYRSf+f4zJ1PJnErYJwtyUZTG4WzE477
	WugwGLixwBTo2Sy4xXkiJRXHLq1dpwxYgdi52xop/+cOT9ulQGNXV3NhwUMYKJcH
	tLoD3SF/gqU0xhXHpUvEZTZrYY+ZnF7i467G/e4qOhq2oGAL3izhq6hUKN6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754037081; x=1754123481; bh=JM5YF0+8sueJ0NpDZ8d+pJ6SEuGMpj3Ob10
	q7JYs2XA=; b=mMGDwCDAHp5BZ5YjRnIrQzIx6vxvkARYpduy5MwmuXXdZb/M6T2
	zR7g+ej8CqYWWWaiYvD+h8Yp2++xv3AQ+euG2Ienaj97TIp0P5YQFZwNnTGSaIGM
	eAMLguAs+0bnNADZgHnAIqWXr/Yy7k315KGIhK4DJCkWjSFuHRHbBKbSNyOJLN6v
	QjSF62npzTThuOhRcxa6ewTVe4BEBd0eu1lksa06lSGdl23wBMUOYMh7ljyxe6Aa
	3zVDTIfuU1bLCERVdPMzaKfWMEBMIsqkPExKvdGSOTGSmzVM0LTtPIIZtdJpqIyV
	dgA9OyrYOAPUz38UZ1XrAY4OwKUq2y4xUsQ==
X-ME-Sender: <xms:WXuMaAnv-XlUNFoJw0gQ68nM47UT6Mm0EfBtzWqT_CjX2uZmhScdfg>
    <xme:WXuMaDHl9tol-qeSlRoD2WCYsKkjzEXUIGbMiPJD8pJvrdLr6DUUnnlb8ntBG21XY
    -z7iPJn7lTkskVFTg>
X-ME-Received: <xmr:WXuMaIEfAL3ni03mtEG4EfscngPXHS15YQGRfJy0qeAb4-GeCKw5ynRhVIrw6Hjp9cMHxJNW32NxOnJYBzQslYOK7rGse51QRuIz-E-5YPdD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:WXuMaIPLqOgiiQiZbw1AAAea9qf2_ab2ALTi0WznaV_vHwtnox4tYw>
    <xmx:WXuMaPHZC_imgB3oIac23BZc2-rZMlk2aJKValRipmZdzqyrxyZeRg>
    <xmx:WXuMaHNb2ZhSXyWCinUtohKuaAMMdm9a2FBLgy_YKrXAzZnUCFUrEg>
    <xmx:WXuMaI8C6MejLOnN5NTL_frrNfJzKbb6d-iz6oSa7s3KQHtJnLlnLw>
    <xmx:WXuMaHBKBdxbbaW4bEecM6YQauK5MgCmafJ7ZA-9CEMW7Qpm0eGcJyrb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:31:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdbb48e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:31:20 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:31:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/6] Fix various rename corner cases
Message-ID: <aIx7VOgyFoPt8del@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>

On Tue, Jul 22, 2025 at 03:23:05PM +0000, Elijah Newren via GitGitGadget wrote:
> At GitHub, we've got a real-world repository that has been triggering
> failures of the form:
> 
> git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.
> 
> 
> Digging in, this particular corner case requires multiple things to trigger:
> (1) a rename/delete of one file, and (2) a directory rename modifying an
> unrelated rename such that this unrelated rename's target becomes the source
> of the rename/delete from (1).
> 
> Unfortunately, looking around, it's not the only bug in the area. Plus, some
> of our testcases in tangential situations were not checked closely enough or
> were weird or buggy in various ways. Adding to the challenge was the fact
> that the relevant renames optimization was sometimes triggering making
> renames look like delete-and-add, and overlooking this meant I sometimes
> wasn't triggering what I thought I was triggering.
> 
> The combination of challenges sometimes made me think my fixes were breaking
> things when sometimes I was just unaware of other bugs. I went in circles a
> few times and took a rather non-linear path to finding and fixing these
> issues. While I think I've turned it into a nice linear progression of
> patches, I might be a bit too deep in the mud and it might not be as linear
> or clear as I think. Let me know and I'll try to clarify anything needed.

I had a read through this whole series and it looks plausible to me. I
won't claim to fully understand it though given that I don't have a lot
of experience with the whole merge machinery.

Patrick
