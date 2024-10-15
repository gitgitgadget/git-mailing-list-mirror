Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F01E7C14
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992667; cv=none; b=KWKglDr7xurjvjPpy1GBC70adIQMJHCiS7FnoBIRXYkOo8X4EOzs4k/xyi0qBytHOMwHX0xTT7rOMr3oXGzJf2rEkn/wla4GeR+zzvUlsX8VN6zZmouM36N1x7ARiMy6rAM4C3jTGkPLk6CO7oGnrsLbf9/504znRMIFRpGbMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992667; c=relaxed/simple;
	bh=TNwZ0eJ3VfbYFoH3ldGfd7y4tQ+bkPqhSCL8HrUyQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi9kxTTRzrn29uRLk5XtQ2No5zDNPDO5owkFSvpVEpYx7VI9XrDu+fqNdnxaLtGqMm2aCcQcKIWkhlA55ebYH6NZCVDZqu5Xq5qlcYhopEHZUBiCXHX0mAYQ9iL9NSO+QlWvr9rd8QqhWrvVvq6QqdaaJRi0qbMGoTy8AES9QO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bd2QL/RB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=puwSUkjr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bd2QL/RB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="puwSUkjr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 155E525400C0;
	Tue, 15 Oct 2024 07:44:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Oct 2024 07:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992663; x=1729079063; bh=XfCMeBZBhZ
	p81qa59u2IKR7S2aHmifByOH2Oksw+vbM=; b=bd2QL/RBMozfk/xrctfyfa3y21
	3sbF3gPQh1Iz/xHodT+Ek4Ket4t9AeRSC9y6ZfPo8n4LXJmvlevs/w8508eUK1tq
	b+Wt1I6Yz+G15NEq9yvJJPT4lUnEaCir9ZWCc0GL9Kd9MSQ9wZbY2VjY+4CDQfD6
	Dcp20bH1Cgw2+PCYCPcdaUYMUzD32mbUGswey9ms5BjDDYMZda4YbwAXBMLVhhXS
	Swz+CWkLqfMwAOwiK5eOFFYAJzAyeE9NJh8fi9wKFHmbLWNahZXbvs5Vil+JOCSO
	fE19EvrtQOvVXZduwgusAqIRXvoceivvbmLDfCZE+fUMW3V9Xm2DqSMhegCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992663; x=1729079063; bh=XfCMeBZBhZp81qa59u2IKR7S2aHm
	ifByOH2Oksw+vbM=; b=puwSUkjr5mlqhCerbz76JlupspAvSUjo0ypKBz5gKPtg
	vBrS/gU4vkc5fySVAz9mkaJu/rILIzcsJP4e3E9xFkerAS4+K+PG32SfAcI5gf5S
	tuw10egjSg+QLEhLeCTk8glHnh+ZgaLVG9XKrbxti3meSWZVmd/vmMusnraGL+Eb
	Ua3nW59KYA7P/ZqoeRDK9MDWDUhdnQ6q2AmdPbh/9ghkH77+rPrxw9RnJlyolMIh
	865uyG0cMcUXpFEYQ202jHuV5cWOFKcniG9TwtoChKPy5slJgMZ5+g5qZjl6o1kV
	ubAkJyrlAaW9e7OSeKfpTOZhI5kBsAv9NhswI+1TbA==
X-ME-Sender: <xms:l1UOZwx27Rf6qLbMrpFf8BS_CF855eDf5o8GEGhM_SBdAbY6Aw1zJw>
    <xme:l1UOZ0QnMAuVAZHvG0Yq3GE9qILZ_ZLhoV87gKImzTxB8E9YJgjpNzLB5CT76CWlt
    43SKDihPOMrz7I0Ww>
X-ME-Received: <xmr:l1UOZyUo2ChDxqf5cc3Q1d3Ji55xz3oKBPH1PNLbMVwUot-aiAnb0aXGPg4WzRt5kdtqqMGANO-1BM_tPVx80sLIsm_EDkMvNmkPPs3wNoJ8lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:l1UOZ-jBGfVPpmC0qJpvRaFAyev4pdMFVEDUlDj3QwBjX29kmJGyGw>
    <xmx:l1UOZyDEUa59NBSkO2q4y8rqJiqX9sgXbJQM80uqtSisvBcJ68TQOw>
    <xmx:l1UOZ_Lda70X_7NeDp24Qi1DBsj-psIBMp8ef8SYY2oWrtsniUBAsQ>
    <xmx:l1UOZ5B9CnqIpQ1ZDTvGgu_XzjxX5g4tJMognYMS-OaRYDO99wdDMQ>
    <xmx:l1UOZ1M1xTZKAvxPoBwKsg1AEENUbRwMQOepx51ulNo7DMnSbBTZkxS9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:44:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec94f4a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:43:05 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:44:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] http: fix build error on FreeBSD
Message-ID: <Zw5Vi7P-bQzRX5uW@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <deb30e12a5861410b6c3b7385fe09599ddd0394b.1728906490.git.ps@pks.im>
 <Zw2XrAkyOvYFwEDp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2XrAkyOvYFwEDp@nand.local>

On Mon, Oct 14, 2024 at 06:14:04PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 02:21:39PM +0200, Patrick Steinhardt wrote:
> > The `result` parameter passed to `http_request_reauth()` may either
> > point to a `struct strbuf` or a `FILE *`, where the `target` parameter
> > tells us which of either it actually is. To accommodate for both types
> > the pointer is a `void *`, which we then pass directly to functions
> > without doing a cast.
> >
> > This is fine on most platforms, but it breaks on FreeBSD because
> > `fileno()` is implemented as a macro that tries to directly access the
> > `FILE *` structure.
> 
> Hah. I'm sure this was another fun debugging story ;-). Reading this
> made me chuckle aloud, but the fix you wrote here makes perfect sense to
> me.

I'm sure I've either got less hair or grown more gray hair over the last
couple weeks due to all of these weird compatibility issues. Kind of
puzzling that either nobody else has hit those issues, or alternatively
that nobody seems to care. *shrug*

Patrick
