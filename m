Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE7BB15
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360375; cv=none; b=QTUYTVHPTS4iDFYe/UErMM7Ar2pATH1V7oq2mhOfe7Oa4l3b1/MiQABEzSxPuIRCzX3a7a/czcoy0QcHOAZxnPlbUy+O5lcEd/LBN3K6O2gqpSj3H5n9/Au0nnvlusymXGXIjnU6gZb/DHJpWTUMFy1GHb5wZheS9s+W3jC0QmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360375; c=relaxed/simple;
	bh=gSVlMkTcJKPN2aPqyQx9qXQ4YcxG8v5LliD6Jj8RV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLZtOjf9PRI2k22S7BEdFWRBCznU1htqQyTPm6Zjp9FxE1J8D+VgDt+bHGIWYn7byHzCe4Xw2P0SJ6cT7Fb4TeLG3TK7UDBCiq1VM7czZUIcUsFMZHcEiE91wE24TD//ehOfSQ4Q9DDsL3T48Cp06rBUcx38kmVqd4knN+qB+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RUc3KzTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ty6HfEnP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RUc3KzTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ty6HfEnP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97EE41140223;
	Thu, 26 Sep 2024 10:19:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727360372; x=1727446772; bh=nA3iGzo/SQ
	IyamMeoDEJmwHiNFodp+wiz5wIuWWnobY=; b=RUc3KzTBeTVHk2DlHF4oTRHurY
	3XO9yYEbPbdxiSazi0Vg9auNzAdFKxHCzn5rZZxLa4iPUNd3E3c4QLQRjNHp7p3K
	xBYhozuqIS0sxKJ1Spq9ZOVtbqlkOseYUToV6kls4diQ3PblyqCRchPlYgetgTCq
	mn60kieHA/mXTfjJsPCUGmUY5dEPjWPD+osjbtqxue3YwbEFVbgHpyrqs5Yz0uy/
	b+UYpdHutghpsq9pUBIpOpCnZZFgHxCHlbPJvQcwqyFMr5gS35k0Tq7Ritcc7guo
	Bp0smOurrZS/zBd+w6Hy+tTcOHp128xoUG6D0660m4XmH8Ka+zQxwrQojoYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727360372; x=1727446772; bh=nA3iGzo/SQIyamMeoDEJmwHiNFod
	p+wiz5wIuWWnobY=; b=Ty6HfEnPwXq2EEwcySKs33pws82hMmfPVarAlnyYDgc4
	lgzi8o2CCyhKNAUX3PuXg1f425xjEOZlxiZ87u7sbDjm5Osv3OkpnnxmKV2T79kS
	SfNIMdBXeqZjdQID3qlhwMzgiU058V7MvFrfW/i42X2X+gcuH5UnHL/iLSNnO4jN
	hXB4WAEQiraJPch5yUvZyxIUx2YN/7UO0hobKcO1+o0tq7nJIsygXYMhLnaE7dMa
	hDRsCiSjtWPJYGLr2vcvQdJXfnw8/CQUzGn2g0aygPLWYbxqgSZBUhfI20cGcISn
	S3PKbF/rn3Q5EzIogiKhTCGqbw/SGOrvJs6OQ5EbVg==
X-ME-Sender: <xms:dG31Zt6HJlviZfHgsRX-J3c4yIaVI4IU-jVPBRN1nr8pCMwfijD-mQ>
    <xme:dG31Zq5pF3qdlNt7lD9_I0nKLeaKxKbW2Pqb03tP0dkSE2egutX8MaU1LOtlTwZ4u
    mbDivMKNt1oa1kW8g>
X-ME-Received: <xmr:dG31Zkerskwuu9TIaDvfN1sTACo_o8icFXz4AL01uTEGSEyIb8LYO9Uab_VzGpjb7Y2HiANFm8kP6zU1k8WFBfxJQW_0Lr98YuBV8M4nUONpVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejueekgffhvd
    euueduvedtvdekvefhheehheevheeuuedvkeejhfeiveffgeelffenucffohhmrghinhep
    hhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dG31ZmIjTOpHR7NmuQipAjkxdOUcDPv0l2ZhPFO51fx30VdrEs6BVQ>
    <xmx:dG31ZhLh0ACGl7wjobRUzBJQZ3uS4Sul31SlbHt-u76jC4sm0yIBaw>
    <xmx:dG31ZvycpJzL4LJnX2SpTxoFcL996HDmugSPzcQqBc69m-l_1xo_BQ>
    <xmx:dG31ZtLQDkr_f2gf8YSI91H1GZN2W_flrGCLkz5pgpQOUxfCaeVMAA>
    <xmx:dG31ZoU-HEkoJL7nNsXjYiQj8-MNTB1TUrEVkdpW3xvf0Jtkm_xMbYol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:19:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac73607e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:18:53 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:19:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] LSan quality of life improvements
Message-ID: <ZvVtcJOsbbrnWukB@pks.im>
References: <20240924213404.GA1142219@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924213404.GA1142219@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:34:04PM -0400, Jeff King wrote:
> I was fixing some leaks the other day and came up with a few changes
> that made the process a bit less painful, especially when the leaks are
> hidden in sub-processes (which is most of them when you are digging into
> http push/fetch, as I was).
> 
> I hope we're not too far off from a world where leaks are something that
> pop up in your newly written code, and you're not slogging through
> existing test scripts. But until then, I hope these might help others.
> 
> If you want to see the before/after, try:
> 
>   cd t
>   ./t5550-http-fetch-dumb.sh -i
> 
> before and after this series. Before you get no leaks reported to stdout
> with "-i", and way too many without it. After, you get the leaks for the
> first test that generates them.
> 
>   [1/3]: test-lib: stop showing old leak logs
>   [2/3]: test-lib: show leak-sanitizer logs on --immediate failure
>   [3/3]: test-lib: check for leak logs after every test

Thanks, all of these look like strict improvements to me! Now I wish
that I had all of these changes earlier, as that would have made my
leak-fixing sessions way more enjoyable.

Patrick
