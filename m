Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418254645
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795610; cv=none; b=rDy2O6E+Yh2OMEnOUYNZkYUk2Qz2WteHh4f5i6gBXZitLXwwyPAzyslZkiMkgxuRgM/hVwjldHEH05WRjdZkok6f4VJ2Hp+YGVr18XMYWlRP2sT7GDIyhYTZlH1NQDxgP+uhuZzXlLn39IxbAwckOnwjtIyTZgNdG5SmmFkryC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795610; c=relaxed/simple;
	bh=/H+qyURNoeUKA0P/sOLseeX14fkkPKR0fTydWO3Liik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgS9/cJ22vvg+wearHjEDFj4f7eYFhsFu9sIIgAeSmt58LBuLM2lzdaKaYEDthWv+l6GslHugmXipgSHBSOohsZITg499nfXtQchO5sUPnKR/lIEyST+PtRj/tRfZbOqXxOGpyTl+aV+20+MW8PMP2txF730AnxzFtt+xHAmPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=miesidZG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjcuRXZQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="miesidZG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjcuRXZQ"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8F2CE1151AC0;
	Fri, 16 Aug 2024 04:06:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 04:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723795607; x=1723882007; bh=BsMiB55uo7
	exmfHtMX6KaPRIZCBPp8qrPtMXsLum0WI=; b=miesidZGnWhF9G8RpJ2eR+bEZl
	l2pQL+AtwKFcWm7dVy7Yjlqfj44kGx6zVf55WnzEqd+geJTtUQ3CLkCZ8WS7eTYJ
	d/eNc102nfSfw76P/+zRLRPasEprHjTrFBbymGn9xgtTERa/HmJYCYq1jmpiIwUs
	oX7iOWQvVQ8Ar4Y2wv3wh6I5buOUIIfw5Gv5sbEaCgZFx2EY8aScgCuqq+3SUD30
	goIOfq149+RZ+me6ereiibIMtWRzZx/U/TMH48mI1xqXRBorA3hCtcDNcB9+4YNq
	mIQqRaJPTK5c6f8D8STGNT9qUUu/huYDnABjXfQrkTLluFubuYmKk8P/vYhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723795607; x=1723882007; bh=BsMiB55uo7exmfHtMX6KaPRIZCBP
	p8qrPtMXsLum0WI=; b=EjcuRXZQh9Mmfg/g6wWeHreLRbevEZb2teEzc8//Evo0
	UDuBPEwJ5b4ia/nj+6Tfxa9l609yxPWHvjBizyir1jRduqvXy8hz5OpZuBl7ZUlg
	bw22Fk+RAi23ZE98l0dHjAMXg+g08HDGd0B65mjC3A1LCusX+EEXAuNbyJ/CtLNg
	vXA4bTDNGa6n8JdZyqd1r0jEQtp5ALn3rJASdSRxyV1IDx8JsYuwEa43tfwhBLnv
	n+v3RwsW3XMUm5vVhU7hbagMqC1Y/MDZyG9ZkVvE2flmxmE+eA4Y2BwRFAd5Ykrz
	Vltj3qzgev4NWI4hxGndG2skQWvTOCU7dSPWGsjW4Q==
X-ME-Sender: <xms:lwi_Zp_HL083tGvdMjH_tW7X9FMAsdhswX1gbQZk6nkxGYpKR6tU0w>
    <xme:lwi_Ztv0OtV1_AOocVRFfjc0EDEWiArkE8iI1GuL_gvL2BW_TfRRDnejdtbPLJInp
    nAI7fxINz7HA1w6PA>
X-ME-Received: <xmr:lwi_ZnBbW13g_VJS3oBZYmccNrlcjENN4OwvJJT8vgg-_HhC7YoUNKWj_W_wSIBs5jurzZ-ozpNdCg58Zj3dX5coSx5pYE6ODEudZJN2KzD5sHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lwi_Ztf6L4Sw2txX6FRGVa7eOr4vFG6HsZTr-D1nfUheAe9uqRrwUA>
    <xmx:lwi_ZuO7QlD4irq_VnaD8BaLP8cMCxy1cS1LI0a8T74_v-ljmC2ZVQ>
    <xmx:lwi_ZvmNYrHNpXyZsXE6g38Yt3Qcju2uE6NHDsxEtOrb9c0QYPrNFg>
    <xmx:lwi_Zou6rVQ3CnxfRdK80cJ7DoKd40TevsozWdIgWJoHxQSRbdEVJA>
    <xmx:lwi_ZnZC5qxXubJYJYjWAQJOPwmTbW4IAfDT8PB63tVTC8z8pXZeinZy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:06:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c02f3e71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:06:22 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:06:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <Zr8IkziW-TfotARy@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <de298972-a359-46dd-b808-4edaa8701d40@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de298972-a359-46dd-b808-4edaa8701d40@gmail.com>

On Thu, Aug 15, 2024 at 10:04:10AM -0400, Derrick Stolee wrote:
> On 8/13/24 3:17 AM, Patrick Steinhardt wrote:
> 
> > I recently configured git-maintenance(1) to not use git-gc(1) anymore,
> > but instead to use git-multi-pack-index(1). I quickly noticed that the
> > behaviour here is somewhat broken because instead of auto-detaching when
> > `git maintenance run --auto` executes, we wait for the process to run to
> > completion.
> > 
> > The root cause is that git-maintenance(1), probably by accident,
> > continues to rely on the auto-detaching mechanism in git-gc(1). So
> > instead of having git-maintenance(1) detach, it is git-gc(1) that
> > detaches and thus causes git-maintenance(1) to exit early. That of
> > course falls flat once any maintenance task other than git-gc(1)
> > executes, because these won't detach.
> > 
> > Despite being a usability issue, this may also cause git-gc(1) to run
> > concurrently with any other enabled maintenance tasks. This shouldn't
> > lead to data loss, but it can certainly lead to processes stomping on
> > each others feet.
> > 
> > This patch series fixes this by wiring up new `--detach` flags for both
> > git-gc(1) and git-maintenance(1). Like this, git-maintenance(1) now
> > knows to execute `git gc --auto --no-detach`, while our auto-maintenance
> > will execute `git mainteance run --auto --detach`.
> 
> Thank you for noticing this behavior, which is essentially an unintended
> regression from when the maintenance command was first introduced. It
> worked for most users because of the accidental detachment of the GC
> task, but now users can correctly customize their automatic maintenance
> to run in the background.
> 
> This was my oversight, as I was focused on scheduled maintenance as
> being the primary way that users would customize their maintenance tasks.
> Thank you for unifying the concepts.
> 
> I sprinkled in commentary, and most of it was just things I noticed
> while reading the series in order but then later patches or a careful
> read made my comments non-actionable.
> 
> This v1 looks good to me.

Thanks for your thorough review!

Patrick
