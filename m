Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431761A38F9
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765267459; cv=none; b=iEy8Wb/t3zRuwmBaoLvwQkUdF8KmOmUXlkwl82fcWeg+kJRaimMqVAshHeD8ZcytBr82OhW5Bjp4acKvBqv1fpax2E+jtSQYJykr0sJ3NUaPWvLW9d0DH9Ov/xFPJUyYXKQ0mt1Eth9icChR01SI4OKos8NH/q4kjWS0TdqCD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765267459; c=relaxed/simple;
	bh=vsarMPcdG07QA0NzdC+WbGu8kUL74nHRmehl+HSH7GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfXI+Bflw6IR0pSDIWG6GbHGFS0oxyXRqOjBxwkca3bqt5j8iUIBtgajGtadmTFyB4p/0OBsuP7w1Nm0BZr1JPmP/V8ZhRYmHmash7uEKts2X7N43zcTwSSN/FYRG9EuCaoV3RgB+pmVe++HL48UsO6/F6MZBq1hJlrRR+5kjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KT+d+fMd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FB91q2zm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KT+d+fMd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FB91q2zm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60D4B14000B0;
	Tue,  9 Dec 2025 03:04:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 03:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765267456; x=1765353856; bh=8g/MVWF0RW
	tRdd5mJTmpdWN74+/oLbX8ZJln0j8lPFk=; b=KT+d+fMd3nyyJ+yUTCn9ijpVoO
	2RTsG8m/hi7HAAL0cpdP1+5xpKIUGSCSNfa7nlggzFCEQyw04BOebAEfb8XsHUhy
	nL84QAoq4JH5qIdP29IkhP5FWvSAIoE6GwzgdwKcLDx8eF21RUS6WdW6U/ewJOmg
	cNuwudxToDZ5r39Ogdo7P8y6X47knVRTcjVDWHwDT13LY/BumRNxR8FWMlPYlHne
	r5YhClcY6RuCrKgm0l5afOqzTpkZA/ueQD/yK8Z5sJ2ioPT7dq2J0n5kDSuMkZ4l
	5GqZtiWidEtjlW8Tg6LmJAZbhJvX0kElroNwdwLyoJrPKyafgeoW/vlk/okg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765267456; x=1765353856; bh=8g/MVWF0RWtRdd5mJTmpdWN74+/oLbX8ZJl
	n0j8lPFk=; b=FB91q2zmkhDhwuAZznWf5pOEW83yDVSlCEVrre4v0D+ONrXZenG
	it0iVU3N1TCQvzpRBrMVk+cvAv7vpekeB7zhoT2N7i0CQtTkZZDR8DQUqAOSmKan
	Rpc962koHvmmzJK1NGT5PdXVMMHsEhBiW5XswzwW5dfNANjbhJ42kYDcGNZR8+aS
	sX2vzpgUsxyclbUuhDvtqXtL1MMl5lYOVkDayOMM4Y+x4cV4PD/PQWul6y9+25L0
	KAnD+mRXnASD7uxUneTzOz3O07YYb5xCZ49wp8KJuLELHD/lLL2LA+qEc8ePo187
	tTHcW6OS42r5e+n6K6pR0aQBTHE9fhe/Tlg==
X-ME-Sender: <xms:ANg3aZuIFJQ6VG8zWepHxs-v9YPTO69HtzvVcPdllq7rYEC-Oqxk8A>
    <xme:ANg3aZcsjDvOebsoMASLHxxCyjwVtTybChrtBOSo1in0NQKQKlhvimQgig65Dqwp3
    bO1XNXRgsOcu32UZL8-Q1leuRhWeaB6KiRMpqRSC0vAh8ZUu-tU>
X-ME-Received: <xmr:ANg3aRy03MUCk5IaB6Fp1p1Rlngg88XtIIkDfK-YyETMCrv0ZawQzi8Oa2E8O9lOf99MaxlQWUqrCWotReVdfhLDfP4fc84aQqq26lIIjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:ANg3afHlubPTHL_rXR98GI8IZ6cMiwRXhvs6D-Lrp9kZSjnE23QCNQ>
    <xmx:ANg3aVyjKjAyaH9NQgZHf8AR7N0d25MnhEOsvTU2vIPT31EhzOX-Ig>
    <xmx:ANg3aQuEUoD61RXeXeC0qIMUQNhw9KiBTS11AjK06iW8IWf-j12Yng>
    <xmx:ANg3aS0u05FWZBmHMvSz5lPOJgfJLIL659O8L9XWzk4zRKciryZ2ug>
    <xmx:ANg3afIsLKA4cpEgJuZS7fziB9D2f7SxMxG4Mk6KQXsEF4feMWYssS8i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 03:04:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3924884c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 08:04:13 +0000 (UTC)
Date: Tue, 9 Dec 2025 09:04:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] Prepare Git's test suite for symbolic link
 support on Windows
Message-ID: <aTfX-gMI1kByV7yA@pks.im>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
 <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>

On Fri, Dec 05, 2025 at 03:02:15PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Changes since v1:
> 
>  * Fixed a grammar issue.
>  * Using cmp rather than skipping the comparison (thanks Junio).
>  * Extended a commit message to explain that it covers all the cases where
>    core.preferSymlinkRefs needs special care.

Thanks, the range-diff looks good to me!

Patrick
