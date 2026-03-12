Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F332264C7
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309671; cv=none; b=i/XztJypjYToRl9rSV7LiM9ta6ujxD7rMovMpf0V3di9dcBzNH+RN7RKJUqefdJMNOYvRgGO3r5Aa4w0J5Gf9sCCAb5cNy96+pYxNE+DQi1/GotqXYT5lG4SzFnX3NutsCBG36kGI4GgrxN/RHShXTDg5KvB8STsnW1IX/7ePUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309671; c=relaxed/simple;
	bh=cNHQXM0RD6A7uja0MUr7q6iFgzyZroq5CndNwjvpwok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPNAKMHiJwoEzaDoNCMApTCdMAggQ01zJf/nNFKj0L27fTSlJqMsc5i38XZ53EfgvAURFmRB3yRbEQALuZjJtAG1gJ9mTjK39Y9PLGUJx+/X/Srp60L7f7CPN37rLtm4+H0tnz0p8Y/FLia9ngsFGaiQy9QM42t0YkF+tV/Jpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9geBt3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAAt86hD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9geBt3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAAt86hD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3139EEC0B24;
	Thu, 12 Mar 2026 06:01:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773309669;
	 x=1773396069; bh=c6dDyYWt2NuuRPoULvNFKAt/1GEuNIwzh8qgg79fRc4=; b=
	L9geBt3dd+4c2XxjAONFMpSppO1m6Cbg2xi9TUw6N8oIbEPVeZ5GkfPWDbjW+x12
	XqZzJfK6k045mKddegQ9IXg+Aa5qc69lrcR4nxsYlP7YGONYC6bLL8CmT88YutpM
	lEp3s2LcEKwUuyiqx2J1q4n7OBtVNesRhaLWwiVv4VuTd8FrKS4Pgw8RcRV5aW72
	Eks+JBn/1991/G9Ud85CWgB8Hxdnuw+lXw1yjR9JwMhvVD4X4dRJXvD9deBX0FZH
	7yxhk7occFVpXziaOO9kFFrSQ3HpAEvjFB8yPcdmvyQV0k5iSo+qpD4+kQY42y4O
	q8b5nles9W5V809CwPXT2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773309669; x=
	1773396069; bh=c6dDyYWt2NuuRPoULvNFKAt/1GEuNIwzh8qgg79fRc4=; b=b
	AAt86hDffbDRPhwmLpynVYctVeC9itv82glFXv5CBRwuUqL+/kMI2g9bRxVI5AYw
	7nUiWAMYeCTmpScQkyZ5v5EEvZ4AbICUGXfwuDJOJOyK6E+I73D4T6l8DdeZo/PT
	haWZ8JiN9rJUqKsYSktDQUWiD2QDWXpaUS3qDHdR4bznFwU6UUTRkEMnmqmppK9z
	pSlQSjvuFIvi7u0mrOcWZ31Q5/WC9az6TNn3dQ9+lM5tB6VekOI2wFDIZtg4hhmU
	GgZ4I7NJWD14TKgFC2l3OHU8lqEjwE+6hIOBu9/kVHIr3wqsA5LCAEhPuVLi2buV
	0vZUskzzKbLFt++xmtlqw==
X-ME-Sender: <xms:5I6yabGndHaxim3FL2U9dVzUcwgBN6ea7SxiruuW0S8m4b4c4czjgw>
    <xme:5I6yaU5TTMviJRvHRG-TgI804hVGfUoQiR2YTSy47F0a5J7zGO3FpT-xWBKi1CYKE
    io72PKoQMxdh8s0ak5O5zvCrDDQCXOrGbOuEqoSRjHtrtYCspvdD7E>
X-ME-Received: <xmr:5I6yaRnF5QWnH3IbmmrIox8t1iJTYEBnTQGs7jj6CSxc2-2iT7FUPj_eroCZTUABwjmNLkj1vKfbR-vtup-Mv2EMi0d5JnJVjzGbEtZg56pxFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeigeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrhihurd
    gthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrg
    hnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegskh
    hkrghrrggtrgihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:5I6yaf5iaoMXrgJcijjCiPQvis2VYru3qe22oXtWaQMZgIc7MOnz5Q>
    <xmx:5I6yaSQygmttlGRhI8ud5Bak-nqPkE-FEifkBMNcSewfkDiqP8yyIQ>
    <xmx:5I6yadworgmwrPpG_b4H1AqKYKL8Dr2urPGPaEBdnTAEx0yCvOLPbQ>
    <xmx:5I6yaap2bZ7tHC8Fq8yloM33zlvdZ4O6VRVTvKg8l8bXKDCLsS_RhA>
    <xmx:5Y6yaVeJT6Np-I9LPD3Et08N4jshzg-415g0xZhluTmwxBaYl5nvdiAy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 06:01:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42447f3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 10:01:05 +0000 (UTC)
Date: Thu, 12 Mar 2026 11:01:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com,
	jltobler@gmail.com, ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com, l.s.r@web.de, peff@peff.net,
	gitster@pobox.com
Subject: Re: [PATCH v2] run-command: wean start_command() off the_repository
Message-ID: <abKO3155A9mw2pbO@pks.im>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <20260312085341.631318-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312085341.631318-1-bkkaracay@gmail.com>

On Thu, Mar 12, 2026 at 11:53:41AM +0300, Burak Kaan Karaçay wrote:
> The start_command() relies on the_repository due to the
> close_object_store flag in 'struct child_process'. When this flag is
> set, start_command() closes the object store associated with
> the_repository before spawning a child process.
> 
> To eliminate this dependency, replace the 'close_object_store' with the
> new 'odb_to_close' field. This allows callers to specify the object
> store that needs to be closed.

I really like this solution.

There's now only a single other function that still uses
`the_repository` in `prepare_auto_maintenance()`. Do we maybe want to
add a second commit that converts this function and its caller
`run_auto_maintenance()` to receive the repository as parameter so that
we can drop the `USE_THE_REPOSITORY_VARIABLE` declaration?

Thanks!

Patrick
