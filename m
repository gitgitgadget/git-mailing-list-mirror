Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2172E370F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576641; cv=none; b=jTWD+LOytM1bn3wXqReOoU8/xuXE8tX7oikY4oblfZjzAnw7Zqn0/hJS8XihAy9K/0nMF5tPyhtmZsFvRg/z5SWAIWS41KVd0iovwvUnwX4E70TfNVcefFtuutqlgFkjeOGTFIxY0TzlMdgBaflRIK9L8F3LdE7c97xsFHaTf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576641; c=relaxed/simple;
	bh=g+z5+LRPqPpHsUtasj1HWzIPfU/ODMZ4OiNdkS4wic0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjQhQYWkJ/B7+LPpNSPPefq4aZv37BTGYDYmk4s3P3YWGzf7zAswUQ8S1LnqyDqxfK4kEsZzHnlzoOPAYQ8n5s3mBp/DtXGoZ1eHegSdhEQwjzDawPGdg3DHvAfuuMWGMK9zOLawA6fh40EPahdeI2r9hmFKPZ50w0fkYV1edyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DP0qXcW0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZRb6A8ml; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DP0qXcW0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZRb6A8ml"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 336F01400030;
	Tue, 15 Jul 2025 06:50:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 06:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752576639; x=1752663039; bh=vJ+ukZKesY
	ufZ36SxOVUWqNDCDPkyEbx1xlsJiWP3SU=; b=DP0qXcW0MxZ2TkUkv0tIgGHJ+a
	4K68K2oy/gt4VIBg681/Qr6tifx8/AhzCFfHC13weAgMgRh3vo9iKUsK+30CLfAE
	nX8DN2s28t7RjFzuAQ2F4woClZAj0dfoochhhilDrJKsAKIVKrAT4tEjDgmt3puc
	YxMsJdr0/XgCUsEnQOYiZnGJdPlS9XktwpObYMR9xeKW8qd3reTP5ywPidsL0qPW
	c27XAGyrVTdCyizxIVHcuqV6BWyRbmOKewoCKcX6FYaPweD41PpqTnMleXqtPc1D
	Nu8miwVxZvC492Xz4z1QPYn1sSt0E1y2X13vGx52eXtrDNeADvMMewrwH7ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752576639; x=1752663039; bh=vJ+ukZKesYufZ36SxOVUWqNDCDPkyEbx1xl
	sJiWP3SU=; b=ZRb6A8mlLbzU5L1X4FzFZwM09QRIwxLs59cZSaFf/mHsAkmrYdq
	i7LdIM8g34c13APCVUDhCYjhNfyogxoFR+wlCX3HZo/tv3BottjW2rsVV2YL19jf
	2k74KhXjvEO4m9m+USGL1DFimBNReZrnJER97VRwzmYo8bNh45YhuKVrbOjo7haR
	XsILXp/Hz/q7i3qTlrOsvlze0imCw3w7TolAG672tjnUcdn8H8v9xJci+CF7ai1U
	QKPj/jbF1qeoisEQ2K5HtHFztuAL+Vp3rHugT3237ggAhGasqBpNY0NSOMUvs/yW
	13WmCGsv14dJqU9n4rvLDaxhonqdqe+uVog==
X-ME-Sender: <xms:fzJ2aDbJuaz1dAoXFtihoVK4dnKQhvZ7KuS3ZNmBasbNQHLR73JUyA>
    <xme:fzJ2aM89kzUC96CaaxP5wH1luLuNSjKwFot2_p-NQ5qk-gvUSolOZyX5DsPDRLQja
    OkObDNuTau2ZPv2UA>
X-ME-Received: <xmr:fzJ2aChZLW_eiI0G5e8amkhsPXu23MkYoYaYlhA6jknLnZtTefMqzGLNe88ihD4vS9rfE4yEdga3WJ8rDt1rhmSbNQHwVKUddL2fMeFaIPAvbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnug
    gvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:fzJ2aMcbiqIio04WyrkcSGRlThzRvTI_JY03QxUKCHpBx6CrVBtgwQ>
    <xmx:fzJ2aJrrzMU5IfiOy3lGV5FRx-ETdpWF9XUrXca9K1J_Ma5ApAtgYg>
    <xmx:fzJ2aBDAz5nHEKOmRfLsE3II6tyThxQVZaz8uQQ4hPfIDjUCPYyzBQ>
    <xmx:fzJ2aGYN8C24eUYZmACIKWgHDQTGSRb_20upR3ODQEQpE06sIXtt-w>
    <xmx:fzJ2aPKIEDzOL_hsHLv4zgesUhhCjuDp7eWJe4BwEh7vHZjV86UTghGT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 06:50:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0204f40 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 10:50:37 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:50:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
Message-ID: <aHYyeilUeXqP2IIB@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com>
 <xmqqbjpq1rs0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjpq1rs0.fsf@gitster.g>

On Fri, Jul 11, 2025 at 11:55:27AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > I do not think adding prepare_repo_settings() calls all over the place
> > is a good way forward as it makes it very easy to introduce
> > regressions like this. Our builtin commands parse the config at
> > startup for good reasons if we're going to move settings out of
> > git_default_core_config() we should ensure that they are still parsed
> > at startup.
> 
> I think that is a good guideline that applies not just to this
> series but to other topics that attempt to move globals to a member
> in struct repository (or repository_settings)

Fair enough. One thing we could do is to call `prepare_repo_settings()`
at the point in time where any repository is opened. I'll have to think
about it and will try to come up with a solution.

Patrick
