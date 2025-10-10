Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D62F83A7
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113365; cv=none; b=elzkhz8afLAUCZuAoafnDEIe7ukY7DrKmaZVC1ovr99geVyj9ha9McqcKMnd7Ilcrnys1hvvqhmZE0duEAYNs45B4U7MkM38+GJlKQnGqa6vhKg6J30Mrm969iD+OFFqZhvQSnEl6WaENKzqeHX7nc1ETphehvOGmpuv4xl9AV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113365; c=relaxed/simple;
	bh=qQs1+fGjsBunL6y83pOiTD635ZSOMT7w0v8LqaqIK7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbzhyvByo0gUTIZZLGWqudwj9YU0oL/ZPJPP3657wN7oYnluuGMOUmBaj+6UrzJid3tRNjLQdM/Kb/RoFrCeUulDjnzqQTPNXFWkDpJRNMtgWhMqPcvfLOfjzoT1UX9bG70UktZgrvKWajTJ6m0nmZUrHawKyuAdOKrf0ytTrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CDGuGijq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbYf1WHO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDGuGijq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbYf1WHO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 32293EC00D9;
	Fri, 10 Oct 2025 12:22:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 12:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760113363; x=1760199763; bh=xtPPG1l35Q
	dKUOcuwbqPEPHHU1UFD9JM5KpPNLRPpO4=; b=CDGuGijq6SB8RS9v7liPycN5oF
	oEGps0yUgFW38CLOE7v5i+W7WQrMGS4+Fyyhqn+HYN2pr86QhZ32b3vZmP/3IVoG
	eXYhGd34JLjkAfp9C2mdV6yu3ob19ntC70jRXb4qYvNIoBglTNFCq4uNf9gCzwPh
	N1rik1dl8Ei92h/E37hfdh8UQHYAl2Lipn8Sib/6NfEdUTN4s7LcG3cwjz+Kaa4t
	YNiPKdk+KLh3X61GUOToQoPRwS8NnwAAP0Y7DlTHw++5VtXQiMkZPBiqpuBp6Ki2
	Xey7IDOOyipLhn0BfxnfU69Pu3CErPKXOgaaGzYlqLT9KgLcsHdj/8ARkqFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760113363; x=1760199763; bh=xtPPG1l35QdKUOcuwbqPEPHHU1UFD9JM5Kp
	PNLRPpO4=; b=YbYf1WHOSJfYLkfsQP8v/TLyhgdO7lvxvUGwHg+r979xyYVOdzG
	r5K/5iUd3TLDdogvR8tlTNqZLjnX4sS4+DMSb2v+Gw0UQ+QDxhimN+2G9YSUYo6M
	Y6t19X8u9doHzKQrOKtga9+x6umvvwPV3YK4J/m9IPT4kJu74T/u49rRFxOgcKXN
	GTsvzL7VNGRCcDjQhHDIY8Dh22iF9rcRxEt+R4w60VGUj1CkI2dkd/OwHBn4JXve
	pI3WfE0vpZKjubVotfy+3gq9MRseYnZ0HjVMiUJ7/Wb2/u2oXz4/S/Gt1q9Gw4mS
	1GHWCjPnOA7wM/4p0qnc1WMRFoSVcSC9RRA==
X-ME-Sender: <xms:0jLpaNQIojlN-d6Jaihy3LGIRkYKeKhQf_clSeLmE07XBgAmdQKY5Q>
    <xme:0jLpaO9KztvRiPbJctEJgyFAXojOukIsYs_TjTgLXE8eu3TeUKmxalQvnsAsir29r
    KTMx0F_YLHa0nf6_1KDLePnxIPa0Yj7F4o7yDC9aEE35vUI8TKB6Q>
X-ME-Received: <xmr:0jLpaOZj983k9gg8ue7PdAhWSqx-tvhTN8mrq9oSUvotea2yDfKhAQ5RunYNue9bkZF188QqnioETnswghzxJ7vjl00XZnIECaK3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:0jLpaPqyluRczpR-rpO9iTVsuiVZ-BPGjDvZykBLy7m4c40Gv1PyGw>
    <xmx:0jLpaCQUvXoQyoY62Tw0zWvwjfXEGudY79DddtZmvqTSQGnXBn5OIQ>
    <xmx:0jLpaDq-ruL5e8oAMXmRRBysLnSJWr8s5ABogJIDlzDwiLRO0fgwXA>
    <xmx:0jLpaM01kvwvkv-6mOtoUGCvBkGwiKRL8YD1vr935YyqSOxtQAzfoA>
    <xmx:0zLpaAlW1--ZX7Zyloy9GKQFetXMUgiKDrlKPme30XoVGv1igXjKd_J2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:22:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Collin Funk <collin.funk1@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/5] lib-gpg: allow tests with GPGSM or GPGSSH prereq
 first
In-Reply-To: <aOkTs7G2GGLKajUf@teonanacatl.net> (Todd Zullinger's message of
	"Fri, 10 Oct 2025 10:09:55 -0400")
References: <20251007122958.1089680-1-christian.couder@gmail.com>
	<20251009122457.1273701-1-christian.couder@gmail.com>
	<20251009122457.1273701-3-christian.couder@gmail.com>
	<aOisaq-rSdwjwo6b@pks.im> <aOkTs7G2GGLKajUf@teonanacatl.net>
Date: Fri, 10 Oct 2025 09:22:41 -0700
Message-ID: <xmqqbjmeafqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> I agree.  But it is ugly that any tests we have which rely
> on the GPG2 prereq simply never run.  That should be fixed
> and, if it were me, I'd do so by dropping the flaky tests in
> t1016 initially.  Someone who cares about those tests
> running could debug it more and hopefully fix the problem.

Let me queue your two patches as-is to leave the tip of 'seen'
broken for a few days to see if anybody bites ;-).  After that, we
may do "s|test_expect_success|test_expect_failure|" on those tests
that you call "flaky".  Are they flaky in the sense that they
sometimes pass sometimes fail depending on the timing, or just
simply buggy and always fail?

> The t1016-compatObjectFormat tests have been flaky since
> they were added and no one really noticed.  That's at least
> partly a failure of our CI output, which hides these sort of
> skipped tests that we just presume are running.  I don't
> have any good suggestions for fixing that, unfortunately.

Thanks.
