Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F714D2A0
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773997; cv=none; b=sNyJ5UPx+BMkkvZbIwoE5vtXl+ZYywYaPxZlO+k8nxIh/aUpcmP+YSkYccT8PZHVfiK6IbSfWFCk89dFVgfvOhALsMhcJ4rJdG89t/VDVILINw72NxBpVHbc9P3dEDqEhAnGwAVqBn3eg/mXsrWYwt4x+0x7lKM7i69RoDjyQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773997; c=relaxed/simple;
	bh=fLfKjglSbJSyZOIOYKfpr3A3gx5QbqFSM0HWL8/ad24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E81GUvTs3Fv6JBG7Q1iE90qobseDx/EaNzxVDzIvBmuJKb6x1Bcv65O5O/aOiWdTqD8o7jrNEuX61I3jUcqxMReQQV8Fn+S/yEVxM2o4tuYCYI9aF/IdfKQr15Zi194GTNwte0Q3r/jmh2Zxumdr/uxszAdLHDHfS6TrBpQu6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VA/83ESp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=COmWbL7a; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VA/83ESp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COmWbL7a"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 254A42540120;
	Mon, 17 Feb 2025 01:33:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 17 Feb 2025 01:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739773992;
	 x=1739860392; bh=4s5gdQL4lt5NF+Fum4+K83D+xiuzNsn6dYoV8+8k2xI=; b=
	VA/83ESpFbH2EWfZoR0MQFzXSWxThqYk3NC9j8u/DTv3/PLun09kw1S59GTJ0ScQ
	wS1jQ50PdO5BcCPwdga6enN4mgk0jNeKPV2DhmBlT/FW5K/+eN+tg5ulQ3Q0mJNB
	tpn+VVK9OWLoHWNrlps9lORYygBelocyclT6tXCrpx5EZPAhXfHbizdhzhmDdPOi
	h3e+tYYtzbayl6zWgOpuqJoyTqnJVs1J0vOqICNj3/6qA1yyTpE7ywY6YUzAHM3f
	rqszSKBMJMmWkXZ61jdho1uCBAN8gog5bdPtp9F8bJxVJ2SooXDNSBhOJKeBgGmP
	xAUyCZDmzKMxHTDut//Skw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739773992; x=
	1739860392; bh=4s5gdQL4lt5NF+Fum4+K83D+xiuzNsn6dYoV8+8k2xI=; b=C
	OmWbL7awY6Bd6QEu98AIIrPd2WvIInZIKTRToORg86Ji6lqrE68SOJSmnxgOIRa8
	cud/jciBCXcRUb/6zaD51uAZPZWqLwMHCCzDAQCHfhqoivxsq2RtCv2jeIpxUR38
	2vAL0hZoQfTjYovOoGPxXePlb5jG6eW6SEU58iNGwiRamDsnKw1lqBWCCPw6ciRH
	cWKKcEwN0Wcxfk6TshF2vHKpEmBtdR5JNaeoc1WXz9+ihRi2aDvDvfA9kHG9h+kA
	+X8Rbe0gvECXS5W/InGSdJG5X3MAgML+0/c85ExSYk1vEPF6cMJ2h4GWPILLOa0O
	SmqCQc2Hyhh3HasZNdvfA==
X-ME-Sender: <xms:KNiyZ_ZJuMdwI65LkwXRrmhH3vyAseIOsDupacdCz1DFgtzwvrzqJg>
    <xme:KNiyZ-adqGYGyHcXQN69xgmYIliruon5J4Jdh2hhnSZVaLKegQ9bbcDa_MkcIMkmj
    WMh7aYjI25YnyL3EA>
X-ME-Received: <xmr:KNiyZx83EC-sa7kNj-hquhSsxHr1cLlTZ5ydsRjkHDEgZxWtynqeUON_emyRW6VLYzDXKF79JzcnH6BBj7gfNtja0k-us2tOEljYuknJ593zFAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:KNiyZ1q-5JIuKCaofS2ZlKMEo2R_colGJ39AwYdA26iS1k8n5ivW2Q>
    <xmx:KNiyZ6qspdHe_bHjs2D09Sx5BVyjEpmYX0A6Y-pPs_JfauPQoH15cQ>
    <xmx:KNiyZ7TcSTZU3ON3jCBW0h0LgiJIqBzhHXu4u0AMzbarjUF4mZcveA>
    <xmx:KNiyZypCSnqiWQKTNHHns_E6urcHmlaS7ZYMtclolRq1ruoSFYhxFA>
    <xmx:KNiyZx3l9TMmTZEbo2iq3_snf3zGmiyhBnIllOjOlF0U9M3NcmWp0h1H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 01:33:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0309a27e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 06:33:08 +0000 (UTC)
Date: Mon, 17 Feb 2025 07:33:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: avoid parent list buildup in
 clear_commit_marks_many()
Message-ID: <Z7LYI4tqGZzZ2Vaw@pks.im>
References: <16a7b572-0a3d-4707-9034-0dac69ea99ac@web.de>
 <Z6xIPowXnL-awm6g@pks.im>
 <69909785-7f7a-4164-bdcb-bed61d006cc8@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69909785-7f7a-4164-bdcb-bed61d006cc8@web.de>

On Thu, Feb 13, 2025 at 10:38:51PM +0100, René Scharfe wrote:
> Am 12.02.25 um 08:05 schrieb Patrick Steinhardt:
> > And this is fixed by immediately processing all commits that we
> > currently have in the list. As `clear_commit_marks_1()` only processes
> > immediate children of the handed-in commit we know that it will have
> > processed the first parent, and `list` will contain remaining commits,
> > if any.
> 
> clear_commit_marks_1() processes the whole ancestral chain of first
> parents down to the root or first clean ancestor.
> 
> > We also end up adding grandchildren to the list, so this change
> > essentially converts the algorithm from depth-first to breadth-first.
> 
> It's still depth-first, but all second and higher numbered parents added
> to the list are cleaned before starting to clean the next commit from
> the input list.  So we go from "clean straight down for each input
> commit first and clean their side branches later" to "clean all
> ancestors for each input commit".

Ah, fair.

> > I bet we can construct cases where this will perform _worse_ than the
> > current algorithm, e.g. when you have branch thickets where every commit
> > is a merge: But I assume that for the most common cases this might be an
> > improvement indeed.
> 
> I won't bet, but I'd like to see such a case.  Can't imagine one.
> 
> > The question to me is: does this actually matter in the real world? It
> > would be nice to maybe get some numbers that demonstrate the improvement
> > in a repository.
> 
> Well, the maximum list length for clear_commit_marks_many() calls with
> nr > 1 in the test suite goes from 12 in t6600 to 4 with the patch.  Not
> that exciting.  The question to me is: Why pile up parents in the list
> when we can clean them earlier with no downside?  Or is there any?

If it really is without downsides then yes, it's a nice improvement. I
was mostly wondering whether you're fixing something where the old way
of doing things performs _significantly_ worse and where the change
could lead to a user-visible improvement. Like, requiring us to store
orders of magnitudes less commits at the same time.

Patrick
