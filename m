Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16C348469
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701956; cv=none; b=Bc4m6RnwwhpBkFw29+l3HG8OjtKgwYcfVAx4mm1KEVJyx6kCWwlCEUyiz4n9GWiukL5dxC6Nq/GscAtu81TalMu66/uTygCsaalOEPeAyRj1HHN0sYcwQ44MAw2RP/lmP+DokivYBPNIYVTVMUHo1dMeiUduQDUqf06n7VEqGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701956; c=relaxed/simple;
	bh=Bgvk5GWgZHHfEJqM8fnGSihxRYDI1k9bw+LcRL3m17g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5ET5JHfg1eikPWEOLqzeU/hnU6rg8JVcX19O2OhbiONP0PFaVC9/UbHium/WC9YcT0wrMFgEhP0oy9ymi1aD9WZvxiLdMsRKjrKAU0vw3aFTp+g7D6ircFy2jDhldEL8Pjvo998C9EDRZs9nBKbgg5D87/IE5zV5avwfTGtBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vNs86i3h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=thcx8wMx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vNs86i3h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="thcx8wMx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 435FF140006C;
	Mon, 20 Apr 2026 12:19:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776701954; x=1776788354; bh=L+Ed6vIgvq
	UDaX51XmkI9hEf82u+EBxyHEf9t7nMSs0=; b=vNs86i3hL+UNyT6LQZ0sYptTes
	dnzul1dvBDL9dh+d3THHTUFn+onSIwSeViH3rNCCLoXwxvpskWc179POOYKkLe94
	Of3GgegpGRg3JmmyIR92RaIytAdUV4COxGaQJuM1JKVKM1bogOnFCEFn2CmNWc69
	2hVXwNtGsGaGUyWBFaZMMXjtANMYGsawSLKs9kSwFqrQ0q9uIuoCwTfFjkWHkuBW
	u1ghp+D/XW+yZz1R/p0QoDCFIK4CRAfalknnB8XbhMAj0QllhW87w2Qvylt5QnHA
	cyJNneqxTNigrNAk4byx5BGxygdLdMsHQ8wvqIR8xbpDIMOV24BbA7PzeX3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776701954; x=1776788354; bh=L+Ed6vIgvqUDaX51XmkI9hEf82u+EBxyHEf
	9t7nMSs0=; b=thcx8wMxsjMvg0Hf5m139wrA8aqBleOaQz49lS/71Pp/iHgn6/0
	o8Enp50Sw9JfTgTd70SLIGpSHWasMtDyVuQBc6PaGa4kxOEn4vIZwsYgywBEHXCb
	5yQL8xG5EcN2AmuTdJWdJ24MVWoCD6bdAJyc5O90LZfuHhgeDlMtTUyIYlifkb+I
	xP2CP1UuYWYecFQkxNUkS9TF9nUsehZHQ1A2D/gw36QSHordAjTDXNxiC36f9lsd
	ROQIQjAxXWSTshfL7dCkNuNfggBBLyWaRlFmaCDqBwtCg8rPHqg5ADvEDp/INZYs
	OUxyy5/kZpNtXbkLp0qXhpm5QPKsMownRTg==
X-ME-Sender: <xms:AlLmadYjA7z3ECS5E34PdxJ07U6QkKGuQFoy8ihFIUtD_669DlJI_w>
    <xme:AlLmabRs_ZcnTNGbdqKBuN9zoV2svCQUwUvDXz0jTsRPTEqS68rY7G1MA3JMwjCmQ
    sH803cMrxAdnrrVWStM1fhm8-IVMyFE_DXQ3zxjtmdeiIAeNAw>
X-ME-Received: <xmr:AlLmaYSTk1c2s48jeBfdVEN2KS3isj9oqupu-Vkljy47FIszXymo3gtxQMFZpG8A-CbuSqibJfbiSF4-9pkDhew7ny4HieUpBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtveeljedtudeuleejuefgieethfetledtfeegleehleelleehgfefteekueeu
    jeenucffohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvuggvrhdrug
    gvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:AlLmaXSRr9vpnA9Scu1mi6Y4jF4iPFjXdZaDkNXAd4y9wgQ8Md8wgw>
    <xmx:AlLmaV7jdCpZar_XvzBgVyrCYnZGvJ_xqqdRT26FjzasgQSrBFq_QA>
    <xmx:AlLmab2crzou0nZh3ADofPZsrCIZkk7e5TROfoLgN0FFmfndyFlE3Q>
    <xmx:AlLmaYDSDH6JC8N33wfY_cOGUnPRNQFICWvbqSH4ib3e6aU5NAqFJw>
    <xmx:AlLmafz-C98mSI4Do2F2gfPqvhJGYCQfe3KkBWa403Q63pwlq66bJKvV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 12:19:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 00/12] t: detect errors outside of test cases
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
	(Patrick Steinhardt's message of "Mon, 20 Apr 2026 09:27:19 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
Date: Mon, 20 Apr 2026 09:19:12 -0700
Message-ID: <xmqqfr4pr4e7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
> that these changes work on both platforms.
>
> Changes in v5:
>   - Allow opting in via `GIT_TEST_USE_SET_E=yes` and enable this option
>     for Linux CI jobs.
>   - Another fix for a potentially-failing command.
>   - Link to v4: https://patch.msgid.link/20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im

I agree that the explicit GIT_TEST_USE_SET_E option is a good way to
go, as it would be clear which ones are (and which ones are not)
using it.  I am not sure why we have check_fsck() thing?  Wasn't it
determined that this would fail only with a broken shells, or is it
futureproofing just in case the function is used without being
tested?

Also you updated in your earlier round to make everybody to use "|| :"
not "|| true".  Either would work, but this sticks out.

>     + ## t/t1410-reflog.sh ##
>     +@@ t/t1410-reflog.sh: check_have () {
>     + }
>     + 
>     + check_fsck () {
>     +-	git fsck --full >fsck.output
>     ++	git fsck --full >fsck.output || true
>     + 	case "$1" in
>     + 	'')
>     + 		test_must_be_empty fsck.output ;;
>     +
