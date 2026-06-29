Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44541B362
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749382; cv=none; b=mbMLi1Kv/pLpjl+KcU6O3vVeaqdROIt9fwO5smc6FwLwjuM91gtnJQJY6aVDPywlvBZB/SkTOvVoVKM15cyyNHhHNn5CRe6iDlLrclb5kKbNeQzQNc/+3VxwlkHbNDjlYbpNnD1+jrWUYsH7Ys+wzdlg/uxvEB6v5deCVfCrTtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749382; c=relaxed/simple;
	bh=c9VEJPNV+BuGQIniNmpucsqkYQJ0EpbcKWghBgVDQjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uftEMGBvuwScCsGvN5QOsVyN173B/6SiCs1R94l74xO6DposqrFA4ueQkHVTyJQXStzxQY0IBcz1WSEhIBu4WwddX4WWv8A+tdGiUs86FRrRs//4aHDapqYJj78Z9PPGnsR0hoNsuhWJetJtLTlfNw5tjVbM/C3C5EgLiNDOSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uW/wa/va; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uuw7hOS9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uW/wa/va";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uuw7hOS9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C9BAEC010B;
	Mon, 29 Jun 2026 12:09:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 12:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782749381; x=1782835781; bh=gINj6qYni+
	BbMH40T5C4x9ocVmv4uQhmQC3yUDTRm04=; b=uW/wa/vaRiu1ZD6HwW2O6neP0p
	p/ao1AULUcfrjfVDPam0NHp3BGWkpBuHe0IUYfH/aNf4kSJYPBV129fCYQhPXtG7
	klN75o03I+s5kiNMkiVTv/tlyPyIjZVpAj8/B2rBTVmnhsB9cooR5l1iZvudRpg5
	uf4gfEV2fiXKWRQlYDM7fv6ZbQsRRtceL0rZtwQ2gyadmAek8HyoC6KMmlvLvc5t
	TSfH3dt+6t59k3uVlyU6mK5S9YwCARIkNN3/Zu22aoLn+csAwzRNvVTvFZ0k9ozw
	+9HyOMGfIxXRf17RjubJTGSMQUol3jaVKlDiyk1HGqpUkhIDqJ8LiCp88cMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782749381; x=1782835781; bh=gINj6qYni+BbMH40T5C4x9ocVmv4uQhmQC3
	yUDTRm04=; b=Uuw7hOS9Gvd3ypqwj2w/oZxJbbxdw3kPIO/lIKWFYINeKIDtdjb
	tXK+RdfOOB/+yYdVmKEhfPBub10fdf6DtjG4YKYY+Gd2USprtNE6ke5G0hLf4rjY
	7nb3NVtb9FriviQLUC6SX6jgqvQMU79JiO0/exTHYG6WqoivrOswUVek8GYQCoBj
	B/kvbSfpM5qZGTJPAtas8lnuwMqO+ya2DkYNp4e841QDl/jv8H3y7aQmjEaOAcV6
	WEfQeNbAQCMxHslo/uVI0w/Lz0UUSJL9HT5zyOWHWi4MoqKUqEBVCLS+uLzp+fJG
	yGapE3bMWXmOQ6hndwqZpo2q/bKdfS1suIg==
X-ME-Sender: <xms:xJhCaiyPYs_GQpJ4evoZQhyrdnJjumHeQrYuaSKg6VTb-f3pKONmHQ>
    <xme:xJhCalQ-V2H4MEXaGA46OOVeJ7U0ItSeJQtzBWfNuhS_3ntGtIj9z8nJLBhk8GAoI
    K9rsVbsvvMPvhsjTFXTNYflY12YYUfRsmSWRUh_sv27oznnSVms3g>
X-ME-Received: <xmr:xJhCapUPf4-BZFUuVtwOPhXMik9lueUUT0f5dLoeuWUtd3UVo4sGnzTqibA1OTVMIbg2BTBgH9wE021K-BzPVYBoA4m-4_RkcHxsYZHT8nI1>
X-ME-Proxy-Cause: dmFkZTFZDZIJgX/wp8dX0ZEzM0wz+L6St1jw7p9RWQMKk3tfj2QX6u9zz/U0XQZdiGMeaT
    f03I2RR2BRv6uiOZtIv+ru6hWlayyQDc73R3dpIbC4QE/0AMV2XBzSbH9BzOH9lyWA/RDM
    ge/3AwQLp/kpjRo1dIRKSmxzMLecJyL70vGiquLZB47LXqCS4J7jMrYk4DIPbHWZ/P7NgX
    9PeQIoLVgjqAxxlQqrwKXGtxPCCnToxVzpYtS8jNIjN8AQaCi7tcQnKvCsL01LSnp3zyba
    62fP2F195cNVNXjlIEQIs7D/EfQN4xl37+wPsxT8aDrxAJltIHcqAfu09SID8/+HcpO4pk
    rjydW28u1lH6R/fL67vsuwPBkramK6jDbWdjm3cmhTUk1jEfR37QH5l+S9gSy5wgdYOVvp
    NwUyOk9SzZ97R2aJV9B+ccCLBNUhWUG1iditS22kD324kNk+vE5wefQxBecZDbmE0lDnQt
    toLcNaE92m7JiIymJY9tAoA+bIH7RGKzoeKQoAgrIKkKR9/1ZDrYj2TCF/1IICad2Yy7zk
    wwO1J1a/6W0aTAktfu3OZeytQ3xF8peu9GTMQZCgCnHca+AsT9izlHPW33ABT2rmH3v5aM
    za5/D+82D5IAMfGBYMTJFP/gwMkr+9TwjmApELjjt5mkp35VGTzZPKeXzSFA
X-ME-Proxy: <xmx:xJhCanaOla0qr1NVVDRNFYrPoULnRNqxOPMB5w5ZLJEjLztMLyNiNw>
    <xmx:xJhCav3htJyUeCJyQM4--pjRTMHUSe6HUdb0VuVpconr27p7pCL-jw>
    <xmx:xJhCapjU30Vq-82TzV5cywWmazz-hZXeCL3_WToT0h-mreCldG6bWg>
    <xmx:xJhCajYoWS07eBM-mLVpQCyLgilBsTIvDri-UhHk8if4QeAonx4jFg>
    <xmx:xZhCarRofkhYEZg5ck4nZcEAy3t8dZ6SFL8LiodidgZf8jHRcLzPOgR8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:09:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e1dec3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 16:09:38 +0000 (UTC)
Date: Mon, 29 Jun 2026 18:09:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Michael Montalbo <mmontalbo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
Message-ID: <akKYv3nqX0BXcavu@pks.im>
References: <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
 <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net>
 <aj5ZaZK7xylfs4Xw@pks.im>
 <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
 <20260628075716.GA3525066@coredump.intra.peff.net>
 <akIfsaVMB_S6kfJQ@pks.im>
 <xmqqldbxz9z4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldbxz9z4.fsf@gitster.g>

On Mon, Jun 29, 2026 at 07:39:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > By the way, the only reason why we at GitLab haven't been feeling the
> > pain is that we only enable GIT_TEST_LONG for GitHub. So I was wondering
> > whether we want to have something like the below patch on top.
> 
> If we can afford the cycles, it would be good to have similarly
> larger coverage on two different platforms (compared to leaving one
> of them not doing as much as the other when we know it).  On the
> other hand, if we cannot cover _everything_ in one platform, it may
> be a better use of the resources to have the other platform things
> that are not covered already.  I see that among different pipeline
> sources, we are doing TEST_LONG for pull requests to any branch, and
> pushes only to "cast in stone" branches.  If there are other
> branches that deserve to be tested with TEST_LONG upon other events
> that the existing GitHub Actions CI does not trigger, it may be good
> to have GitLab CI cover them, perhaps?

I'm a bit hesitant to do such a split, mostly because the canonical
source of truth that the project typically uses is GitHub's CI. So I
want us at GitLab to be able to catch the same issues that GitHub would
flag. And if GitLab's CI stopped detecting everything that GitHub does,
then the result would likely be that we often create merge requests on
both platforms, which would only result in more wasted resources.

Patrick
