Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FC4AB1B7
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720935; cv=none; b=sYyKUawQX2R1zID+j5NSheWNh3RoRdjDZGTF/2w+DGcsb8Vj64xbh0Ald8To0Y5Blj7F9I7gyWmFH2WVVsJBKoU91Z9EnRj1hXk32jBSZ6vIMgMPgDrrL+nEXp5Xzfzd2sDyVaTv8ptw5vcOK/I17u69FkqIYOwrtN9ntYfa3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720935; c=relaxed/simple;
	bh=8lKYq7NwC/s6wKgo0YDg8PG31jrQvP7XqTPx9O123LM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGyQRJnvgxQSrJMqX8hs7srCSeafYzoXIZQ3D3x7An2UlAkWt3LmsF5MAPNvLcRUvpKB0DC8CNEkxLnkwTDpmI52/zCnwn3cELuREfCUELthRP/dyWvoQl6CrfZVR3EsdbpVx6TRfo2Sm2GxzNvwvkfXTBbviHQlCHt5z5fb7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cWY3bL7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbC+hY8n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cWY3bL7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbC+hY8n"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B5477A00AF;
	Fri, 18 Sep 2026 04:42:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 18 Sep 2026 04:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789720931; x=1789807331; bh=dllXfP6BBc
	07dYJNeMTL7PLhZwDIjW5SIEw3OClOl7s=; b=cWY3bL7J+HQIsBqzmjVLcQTX8M
	X+G+D8Ewkd3yttvy1OjYic+YPPJoZurE0Ktn6zp3nMjQYCf7bKt1NMjJKzLlkyg5
	EgtxJpG9+U77wPP1QLBa6eJSUTxnXlDWM2jHesniQFjIFRLAXNOhSolLkCFrs3dN
	KP26AKmej1GAMoJJ3HMfnPbF7kNLPsqgOEzLPFqvyLFMpXc+BCsMgiGmYiRJ/rK6
	f/2st7yy/6J7bHfC/ZtUEv1agpQ5/M0nZBc1YHMR2x1h9bKdUhSutG8rAysO2dGh
	oEtfh7Q1QmkBWLB9snlee+cm4LYxpFP/7OJlSWznUuNJcdG4Oo3+4d0hgSKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789720931; x=1789807331; bh=dllXfP6BBc07dYJNeMTL7PLhZwDIjW5SIEw
	3OClOl7s=; b=lbC+hY8nWxvlx/WNQeQEp2lZhUkqxh2ytDYha33txdIQOx+P9rB
	vIB/NV7BkorQJIacpbuWOp0ZaboGl+789Gu3wjG4QcM7+QO6hxocFb5XWpDC4V6j
	T3xII+zxazUjTr8AIBp/jZydxp3PAR51xu10tqCwvLx/MS+6uOrw2IpE1/sa0d/L
	AFdmUbgfUPvCM7LTlS23mXQmB1mYifU9r5DWeWCVaBk3qBpi/ug821U1yDpYD/8p
	SxWMucTg/gXngMplOudovhN/kFgt1JzXOStCQtSORcZVl1XUbbDjuGHoorjtTOlF
	YpYa+5DdmfYF5K9gjVMYj/nXSeYuyThYUQA==
X-ME-Sender: <xms:YvmsavN9ucbDEs3QIY0icLkcF-Te7u5F0xIpkgri2esm-MU3SX1tvA>
    <xme:YvmsatozmBHU-DYPoslc8zqQfAE_sg2VYpRvjlEH4EhNW15Ho1PXY6mXjKAvLdLE_
    tJKoPwB9WNI-WFaVNfPPyeKB8lpUJw9-K5f1N4aH439rVRvi9a5zw>
X-ME-Received: <xmr:YvmsaoFKH14vAVpK0CqVZhQDox3b7jKvcvRvn0f-CB2W4PDxJNTPM4tAgULgG8DBcef58S6qPDttYq8U-w_7Savabds2riTLZ2Lm>
X-ME-Proxy-Cause: dmFkZTFinWDmmhyQm1QJwB+1n4DO4uwZYYEXrY9a7zz9a6ut86gFdIjMLTW8jDeISAUS4Y
    /Iy7QroEQmAg8CIDxfiM7oL/F8kMVHrHeFtox7fH4HsZqH/AYt9HtFzlCKZZcwE2jfaoH9
    6Fj75mmv4PfkYtjnMqqnMEQWxeQ3AToBNFGinpVX3jT6+mWz4LLAXCXjSVIN1Ha0dFeCE7
    uccxXITFqLN2CEuQNlyfgC4TJ5PL6Pn5R5ARsdRoiurwYjefIw9CVMSpP8DxXxzE91pVFN
    pmVXTN8Z8gXW9q9jB+3hMmY1rkqfr8xGXSetQ5n+yt3xWaz//0t403Awds959f9DcEupL0
    0GphK/IQs4Jfj/6UZzaF6w5y9QRx/daHxLFWlLX1qQUE7FlCQJ3L8etQ5O41gfV+gXpmUo
    RoKihiQ9bM8jg7W5naOGomRCttuuP+ZrJiaF/iJA2FiYfbfHUZvBrvf/AzFZzI206Niom/
    tuF/5Wlb89FSmO/cptV+duPE1DZaVeD6KVGmyeBUX9ThjflF78W8pYAa1bw+ebj2s5S4+M
    rH1on0wgCXOH8Cvm8bM3J11aURfpUgakHdpZfsc5+F05he/nIYRYBSHnol/Dhkf6BKxcz7
    Ymqb6q9BxjCnXRZNqCG+4pYGWLX8t/1NjhBFIWIT0Uw/NqjYg1rH3lJT5ZOw
X-ME-Proxy: <xmx:YvmsaqoOHKGz-T660dWmLPgOkFxOY70BK8YM7yGTn7ezZYt5zAO7Qw>
    <xmx:YvmsapbJTCUdM8gNAu24ljP8w37wZ1JKkMgQPvYzWB8xhj6u6Bsg0w>
    <xmx:YvmsarW3Rli6THw_s6r9BKxqe5FrNhYdbAbOrzET-M6KUXm57JjM3Q>
    <xmx:Yvmsaq9MDX4M67Uzm-YdJfCyMKw00hZLF2LA5Eo2KiFMWNHHe-5zfQ>
    <xmx:Y_msalNNwfmWi2mZM_D4EKiiMeW_SXciNW91c_ASILd9F_eosAqipxp->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 04:42:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  James Le Cuirot
 <chewi@gentoo.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/2] Use Rust in the Windows CI jobs
In-Reply-To: <pull.2213.v4.git.1789315032.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sun, 13 Sep 2026 15:57:10
	+0000")
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v4.git.1789315032.gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 01:42:09 -0700
Message-ID: <xmqq8q4zosri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> GitLab peeps, I still would love to ask for your help: I haven't been able
> to confirm that GitLab's Windows runners come with Rust preinstalled,
> https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
> did not clarify that for me. Patrick (or anyone else with access to GitLab
> CI), could you see whether this patch series builds on
> saas-windows-medium-amd64 without need for further changes?

I rarely look at failures in individual tasks there, but noticed
that a recent run:

  https://gitlab.com/git-scm/git/-/jobs/16576450182#L784

failed with "cargo: command not found".
