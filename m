Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD173A268
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141040; cv=none; b=rr/TF1Jjdt8wUZkxLpJ6iCWVkKeEI3gqTOg1lg45nCkvmeqmUL1QMCxpydLXMSEy0WNQolas7JEPcxqEvTVZELIX0OQQ4mTpa/EK34nW3u3U1wVsfvxWmJV60D6oVcfeLMJkT/4WrkhM1YQ7QWHpid/zU2pFEFwz0VFcPErp840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141040; c=relaxed/simple;
	bh=WBYQ41+0bCZh6Wx4W0uHCiU2yfSC8co2HUQmiSzpmEw=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=hfQUTK3DidGu2uWznnJv7XhrREVI+1KUlXvU6y3mY6kqSftNPC4RnJrWIBkjEEf4MXhi62Y0p7cCr+atSRZAEkJYyNClaiXEGXrIeneex0zS/Z2/NBceoDvqjp6VqSM0bt7DD/AsV6UZTpwYlbRI18yaOyy4sOf32q4ZFWE3fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=UAQgPrfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=baDtnQ0G; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="UAQgPrfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="baDtnQ0G"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B43ED13800F5
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 14:43:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Mon, 28 Oct 2024 14:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1730141036; x=1730227436; bh=WBYQ41+0bC
	Zh6Wx4W0uHCiU2yfSC8co2HUQmiSzpmEw=; b=UAQgPrfIjdp+siL2jucQbHZ/9f
	3eu67mr9jONxrW8KIhUYPEjQ1mktArH+cN8og+8deRfthiZY+1WMYkSscLstxUlc
	UGxyvjas3W8oeaXNQ3UGM6CbEEB3MfcBbOhSszmmlltitMqN6WWOTFiPqKymhjnp
	+D77qJEb6e9bpyauHZ5ilxndh5xL4Rlq6hsL0B9zmh3kumBH3ynNCQHsbqouRHHE
	tLhUgIDHzCapFjxODQYX2nhEk6o596VwZHjzbf4PQAnFvbjpFVKyz05xedNajJhN
	1vk/W9+PVHGLK+ahJCYe2Vl7CdJH8HKxkYhEBrVnhz29brOT+U7H9pGtp1WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730141036; x=1730227436; bh=WBYQ41+0bCZh6Wx4W0uHCiU2yfSC
	8co2HUQmiSzpmEw=; b=baDtnQ0GXJ0JxH/6s0AfWtNdA1qQtWvvOuoOGsqVJARn
	DGR0XYSMcA2TK7XGeXTahPGw7ACAONg/4KfKWbIHFBpQxgudNv+USx5Lxccv2f8D
	OLXt5KVmhMFyl6HmkDJW2E8xQZjNCVG6z2JUYRoIXxUO4QPY5nys7Y8QHXutuhWT
	YktH5MvJaKqk9Su/E898vqo09wtrnApXwrSMRKaxj19G7Nd5IMfT2em64gH2fZyU
	2iGbZnp4f4DHZW9ALdh4S75LTAC1BWXrbX2vmLdF9B9QLio9j1a+eBrgUQeiQc8w
	goyH/OQCTSLLaO3aS+A7AES58QCZ+7ssv8qpz7nDGg==
X-ME-Sender: <xms:bNsfZ_nPwX-ssNo_JU8Kd6cSUPeOlC4MwbwbtP2GBa8-l3v4r0wyEg>
    <xme:bNsfZy1f4XUcy3QAl-zIwHp5fFpTUWCTjatsSqjhO6n8pSe8Q5BI7YZw-LXAkBmaK
    p4ZfWv9FhIKQWFdDK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfpfhitghhohhlrghsucfuihgvlhhi
    tghkihdfuceovhhgvghrodhgihhtsehophgvnhhsohhurhgtvgdrnhhslhhitghkrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeelveevudfgffevjeevteffgeeviedtfeevtddvieet
    udeuvdduhfejhfduteettdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehvghgvrhdoghhithesohhpvghnshhouhhrtggvrdhnshhlihgtkhdr
    tghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bNsfZ1pMVGdtHm0k2xAor5ks5VLdrKU9PW2PaHsaWSDkMyuIvNJP6w>
    <xmx:bNsfZ3nKWG88MA2l-8MgyKz7y-4BGiGnMX0sei8VpG74fv0smp6W0w>
    <xmx:bNsfZ92vhgDDE_0yk1yk_yO4uUiFKJQyTECoBEjZjlZ7ntOWtbDIGg>
    <xmx:bNsfZ2sL_IHoNunaW21j_IVB1GNcYKoLdvOIf9sSR2yDIFlmRASnGg>
    <xmx:bNsfZ6hqb1DJo9sJ-mQy-5OouJcSg6Ujgl-D00I4nhaJY_tosl-OjCIZ>
Feedback-ID: i78f146c6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 429022220071; Mon, 28 Oct 2024 14:43:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 11:43:35 -0700
From: "Nicholas Sielicki" <vger+git@opensource.nslick.com>
To: git@vger.kernel.org
Message-Id: <ab71a27d-728e-425a-8729-8699c9369bca@app.fastmail.com>
Subject: `cherry-pick -x' and git-interpret-trailers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

If one uses `git cherry-pick -x' to apply a commit to a stable branch
from elsewhere, git appends something like:

> Tested-by: Some Teammate <some.teammate@somedomain.com>
> Signed-off-by: Some User <some.user@somedomain.com>
> (cherry picked from commit 2efe13923d0ff714b1b0f3b7175e714f0e295727) <--- this

IMO this is inconsistent in two ways:

1. it's unclear to me why the cherry-pick metadata isn't emitted in
trailer form, ie: `Cherry-Picked-From-Commit: <...>', making it work
with `git-interpret-trailers'.

2. I'm not sure if any tooling (external or otherwise) breaks because
of this, but the existing trailers now have non-trailer content
following them, so it's ambiguous whether they still qualify as
trailers at first glance. (possibly, this is intentional?)

Realistically, the only thing worse than this^ would be to have a
mixture of two formats in the same repository, which is to say,
without a surefire way to to share repository config defaults, I can't
imagine there's a backwards-compatible solution to changing the `-x'
default behavior and git is stuck with it.

It could be possible to extend the existing behavior with git-notes?
Added benefit of that would be that you could mark both commits
involved with `Cherry-Picked-By' and `Cherry-Picked-From'.
