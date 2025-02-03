Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DA158DD8
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738562912; cv=none; b=Ad8fHq7uPkYpKrQWZtw3EhDLCVGk+etJ7XVns1zddInMb8ABC+iCEVcluX35RK6aL6BBqKqr+hN7SkmoKx+bUo0YKD0fdfu1RfeRCB2rlbyqXsWxq+tDex5KhqXFVMBrR3K6Q4OuY4vbhghnqdGwWiILA+mW1toFSuzWdgR+uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738562912; c=relaxed/simple;
	bh=0vgw+KzJkiAP0oB35jKc0gubJiVeSMC30/37AFEfR6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3sWvnsug5gGYi+eyEjhNs//mBPd8eeB4EHbLkyBzWMnMYxgxpPIBoIHZvmIx882GnOu7k7sgw5m1csmRVCE1jlGG2b3STC+B924CK+aXRKRnlxEo1bg8sMgy+NQi0hjuSHQOXdobeJD/eL7z/LNiN7yRYjfJgZpBmIit3IpL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eXWlqD70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vG+k6hQS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eXWlqD70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vG+k6hQS"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B6B2F13804B0;
	Mon,  3 Feb 2025 01:08:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 01:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738562909; x=1738649309; bh=s9XYj/wajk
	WZuOD1TjiXKJBG++XEBnbTft+AvOlzqVE=; b=eXWlqD70dWYMa/z42+QuylVv7P
	Bzq5vFCeFkVqahb9PI+aiT8AX8/jeawW5gVkL8XBfKazAAV+lZbPAn2gzIiMxX/h
	MoyEQH4RulbR7ORXD9YKWj26u+q4CYggjTremmw0JF4QAacFMkTGTAob6RBiWHvY
	+BAW8fbvZFvpv11UEjxa2PnQ4cz2xtEHad8ehJL2RlqFtsBYFz0KYgvIzuq2LvUB
	tXEmXSAnYBvipGrnZmu6NNX1mdttGp7D+HP4JhF9PiQcyMkSXDBKOIXPR3wEtD6W
	af4iCFLzr3vl+42xF4g4KqGcXKwHV7ObKHfIdc1rw25xvxI1uNBwGt3AT+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738562909; x=1738649309; bh=s9XYj/wajkWZuOD1TjiXKJBG++XEBnbTft+
	AvOlzqVE=; b=vG+k6hQSzekKSFwvAh8XJ7eflNhzafwhx6OxXPqkpRd1mOIYqbZ
	uHgvfL2I5yZ/7PGXtVb4oeyTo6laDv8us3aXTieZ+QKfJc49LxE/EjFeZrH8Mk4c
	pe7J6sc1VPvsbbiYuxB7vlkioEEQTxS/nxM3IsNQCL6HNZP3NUWfvf3fdjuGplYy
	D15hltiCpuMgLXZWsJU85tS//p/7oSOgT+xrVIz8RAnQd0g1wYx2oL8cmJ19uWga
	znV2yXUIUs0mRRjO0AiWi4EF/f93dZtExUl0+grdUKkWq6lN2fWST4CwhJ53n7dk
	eq3w2NmNoHxHBZMKZf9hJKHIbRQJXkE/FgQ==
X-ME-Sender: <xms:XV2gZ2PGGB-RmfXkEXEnVowu4lt6bNT3NgBwXiaIHzsznIeOjDnceg>
    <xme:XV2gZ0-GA4WvAGzl_fBNObUG_bwGWom1vBUfRUZurTMUg6r_m-bH90LVXq0vzIpLL
    BmzjMRv3EqSTvXpXw>
X-ME-Received: <xmr:XV2gZ9SBXxfj5E79lBS5whCZkQsUIzNfqojEdHOAsP-QWFRmQrnWwfOQ_PdYyUazNb_3nlf3kQQXK6xycuMLgqHbwigJsmA9d35qXolE7hq4uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XV2gZ2sroo7eUL-2HDTVE888aSPFPi8MSHkFLW6pyjRPRsJoHNdLSg>
    <xmx:XV2gZ-di9nqX0ymQkYYGbcXAcEVrk7q_X3jy-7_k7sa9XhXsSKO5QQ>
    <xmx:XV2gZ61Cnre17h5XOjZBi2lyLPHTtSMPOVFDC4ctp_MZlHgWD27NLg>
    <xmx:XV2gZy9jY05ouHhazx2ZWpSXjzemBojlxA_lY0sAh_N1UHNWE31xXg>
    <xmx:XV2gZ-5wefLK9Z2tHH92UvdNoDtt7jmCqcW2HZcFD2dja0TeOeSdJ_lG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:08:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f848b1c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:08:27 +0000 (UTC)
Date: Mon, 3 Feb 2025 07:08:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
Message-ID: <Z6BdWjgd8kk2c9u7@pks.im>
References: <xmqqlduulbgn.fsf@gitster.g>
 <Z5nfcAUZPNdDSI0l@pks.im>
 <20250131233015.GA3544301@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131233015.GA3544301@coredump.intra.peff.net>

On Fri, Jan 31, 2025 at 06:30:15PM -0500, Jeff King wrote:
> On Wed, Jan 29, 2025 at 08:57:36AM +0100, Patrick Steinhardt wrote:
> -- >8 --
> Subject: [PATCH] ci: set CI_JOB_IMAGE for coverity job
> 
> The main GitHub Actions workflow switched away from the "$distro"
> variable in b133d3071a (github: simplify computation of the job's
> distro, 2025-01-10). Since the Coverity job also depends on our
> ci/install-dependencies.sh script, it needs to likewise set CI_JOB_IMAGE
> to find the correct dependencies (without this patch, we don't install
> curl and the build fails).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Grepping for "distro:" doesn't find any other instances.

Doh, indeed. Thanks for fixing!

Patrick
