Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D032B652
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547750; cv=none; b=AJsRSaW4OKW7sCIR4wTGkw9rIkWy7AokDrxnoWHnsWWq+IKZxETdtw1w2rJ7Wwzw65ySyIRyOhRsUkN44yi016cCQsvbRArfbdFrUtKA3dEeJOZm7D4LB9iJ8I7Nd2kQ1gq7pq+qYvc6CG6T60jB1xnAO9yA/oPiPNODWbparGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547750; c=relaxed/simple;
	bh=dYj8Hg8vQ6PjHlzxsteOZoJoKiaFcxqV7TZAPbfHsN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxSKzKL1qttaZyu1V93Aq8Z61vjueCE0WwKAeA/eeIYkbEr0eUfZamR4IQN1YFWaAzf+IBEOLIEJqwBMYDJXUnm3Td9Xc14ETCtl6rdgW+K3265eddYnLFjv/pqAYnQsQww87Sndy7ZhKLVSl7GYg3lqQsCCAIRKUItrWeL+BiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dyp3Mkj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7uSF5/n; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dyp3Mkj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7uSF5/n"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 474201D001A0;
	Thu,  3 Jul 2025 09:02:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 09:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751547747; x=1751634147; bh=ahMvKhz0zf
	QrQKvcb0WNiREYh5XrHWogDlRq3CBKDY4=; b=Dyp3Mkj2gYgzuP6DDUZR2F35j4
	KkXk91WsyHCkx28j41mJoSLUG8LcI6dbkrf5C9sqIowQwsL4r/S7s3aeIRFlaZjt
	ysp89fVpdY9L3u92Ermc7ewAsqDNqYPkI36OAgRTOmng5eRMK3Mdx+gyrjLZUDXU
	rXSTVR3WAVm177x+FZkSlx3H1uuzz8rduIlT/s7GAyGs3OxTfzQQhLrZl9pundKc
	1CzeUEwcKxxNZga2iZF1cVYfzxK53lz7vU9+3y76MsQNTB64bKwkbiDG7Us2hYqb
	FXdq5IuwiqphlgJYbgULwTA5YFarKwIGIM2lgUoWfiG0CGfT0X4DgUpRjZbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751547747; x=1751634147; bh=ahMvKhz0zfQrQKvcb0WNiREYh5XrHWogDlR
	q3CBKDY4=; b=j7uSF5/n/dWmCPr4NJx4d4qCHqT0K9iH79IpgLDeTMsQHQGk0kl
	yCZRRklnsxl6Sh1zgrO7il5rOXsvWThhj47wMM7ImClEVZYDufxeQNaH8CXvqm0S
	0qLVI46362LMQwnH6A2rnfQjbLL02l6Sdh9EUPmaR8EwhkamMrnMBJaAFdrnlsI9
	0QZ6rsbGT3phOw3xPGbifrq57u3jbfhXqsEYS71xyH6wnNELO03H/IGGMFtJiACE
	2YQSwJmig1qud55qZD3sKVJJtllw0pRC0Eeuxnm4ctu+lrVk7liC4LQ+sFjNDMv9
	uMGZBPq6HBqf/81A5Nt6kN7axMDYyTwa0wQ==
X-ME-Sender: <xms:Yn9maAGI2ReOXrwoRi6FN3UHVJvC5sCcO7PLnYfCMkNZo9GwqCzWWg>
    <xme:Yn9maJXqsR6rpLA4osYGU_Tu-0LV99EjiiDs69QYnk_1e4my3rE-t6JiwBcxMWyaH
    H4AlHG4RRj-_nFCpQ>
X-ME-Received: <xmr:Yn9maKIXP1kySpZ0TlE3iKevRKlWE8NQiej4AJ3H5vGOcTwH70P7W19X7awk0CP5H8zNP_Zn7kG_yq-u_48zF_KtoE7EP5TaDSe9TKjE7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgrghrghgrsehfrhgvvggsshgurdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:Yn9maCEIVDnVuCVaMEjBH6QDwsYfxzPnXztdXAmwSFVG6QJqF7uiRw>
    <xmx:Yn9maGXgxEAPN4cy-xLX2GlkyeNVHUUnnBeD3RZGlmlteh0QQpi9mg>
    <xmx:Yn9maFPlcGnQq0YEX49rCAPNvMtjCAJFJCMLjeaMuqtlrWP0FYQPSA>
    <xmx:Yn9maN3HOyilxbuAb7LBYk1xlEqzRmMfTz8bNq1kDEBBvhVmE8jxew>
    <xmx:Y39maETNh7nIH7tiRWBweKHUPzfrPx7WRIXAMk3oQdWt-vCRk5HYeG6B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 09:02:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f65b365c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 13:02:24 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:02:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Renato Botelho <garga@FreeBSD.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
Message-ID: <aGZ_XEJrZkv83QyR@pks.im>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
 <c8f4ae13-8578-4db3-bee3-1619f03428d4@ramsayjones.plus.com>
 <aGZB-DYo1nleB0bd@pks.im>
 <90f5ae50-51a5-4188-b76e-90ab2621551c@FreeBSD.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f5ae50-51a5-4188-b76e-90ab2621551c@FreeBSD.org>

On Thu, Jul 03, 2025 at 09:35:47AM -0300, Renato Botelho wrote:
> On 03/07/25 05:40, Patrick Steinhardt wrote:
> > There are no plans to remove our Makefile right now, but there is intent
> > to remove autotools once Meson reaches feature parity with our Makefile.
> > It will probably still be a couple releases before that happens, and we
> > of course still have to make the final decision to actually go through
> > with the removal. But it likely is to happen in the not-too-distant
> > future.
> 
> Thank you for the explanation.  I'll keep an eye on the announcements and as
> soon as meson is considered "feature-complete" I'll start experimenting with
> it on FreeBSD ports to be ready to flip the switch when the time comes.

Thanks, that would be highly appreciated. The more testing we get from
different platforms the more solid it becomes :)

Patrick
