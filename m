Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312581B580A
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756866; cv=none; b=kGSpQ7FPUYHAQvts9STgpc/CEww+0agU5y6C2febhpUVU4bO+uTeZiXLa8QIPq46OI7ju6YJ5sabFqkMyjkPyKxi/BJDPlbqPWoEK6bmKBVBtxsmzYKKZGcYbsG5SpTsB3ae6zm/n+CPpZlvgdssmRoJKiDLloTxDvAyAmVUMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756866; c=relaxed/simple;
	bh=PZa3pQriKxTq0v9PiKVPhvQuMwR4bivglRoxodfxRF4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgNrqkKrD7kkf0yU5Sc4vvP8L5fl6xREgQp0a4Gl1Z44hsS12uxBuVFpqHs61QgGhPg9G19nRYWWi++gCalpt7yOUGCCqIr8spi5iYTuLu/lHQaRNo7ppX+XgqnOcCxNDD/6Kq/3ACQR/hILWxI/IUQq2tjzm9Lre2KgZCRCqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jG3WuYcU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7bwN6C4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jG3WuYcU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7bwN6C4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 12EF31381EA8;
	Tue,  1 Oct 2024 00:27:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 00:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727756862; x=1727843262; bh=+8b5/kQzK6
	BAYy7xrHQ6T1UESohBH79pjvwQNoFCltM=; b=jG3WuYcU+qDd42nYQy1Yq83wq0
	ZQIOH8p2U69MIlyYbch1Szs68JdLwnWBYjD55CHEAsslNMtceznJccb+mTQTz6vF
	Tj0+9u0ca/SH+eBFR+tH78P+SO3o7FLkHsCSi9AsAC7UuDBV4uRHWb5O3PNgq+1H
	vijZQ8Mq811DzceuPvlBqhUNMZtE+/toJ9TuOPd1kGFr3kra2fziEqnRIgSlYzfk
	59paDgqg8uCJ/fMagjuV/EDKn7xZN0VuW064iaGh6cvpBX7pfvLSdle/9oKwRebQ
	QuWpDP43ej9SH3/nqWOesfiEXyjJq2i0mbX17vEDK4YnyItkn79zxhgZchuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727756862; x=1727843262; bh=+8b5/kQzK6BAYy7xrHQ6T1UESohB
	H79pjvwQNoFCltM=; b=O7bwN6C4docZwPLIsAc2YaMvkWscimQ6KQE55fsDsYNj
	VG8NCledwEOrLyPiIzodRKHifi8r5nmYtNTPknaXCY2pK/YPIqhwBVR9+3B9qDde
	AxaK5FPR+0CqqKTbTLnF8TSJcrE4WSL0ZBK4SfbANV37jBwDApIwsRKzs19DjGv4
	9//g/JIXX+cgX4eb3NCjuVtGiUQvCGRlUAqaTd6waTiEovwqntKNacamnVuZvkTt
	nhCiu30K6+mIfRrqUgpTwfdURp0diGl1X/pXn+x9ecnw6QJS9lhQzm9lvfXyOold
	cPprIMeLKyZWFze4Ei5lzjyblMPioQ1tFfOBKIpCmQ==
X-ME-Sender: <xms:PXr7ZoR-W1srEqo2-7wKTWfcInlWndCutV-chKydLrjhJgW-Rp_X_w>
    <xme:PXr7ZlySRXtnnC153ntENIB1ZnRdLi_u8CeV2HHY_zxsMjyyQ7JjIEh16KCrww50W
    zOYyKh8rYic-LCXMQ>
X-ME-Received: <xmr:PXr7Zl1RTqpgQX93hvVSU6tbtSFEtJRfBx693njnLAQdpUZD3JvTQCX5i_hJVS_ya1MWkSwFHPxVkatwTPbBye-EQ6dASqasVkKwWLUxWyRKWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefggfeh
    feelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrg
    hmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:PXr7ZsCeEc3XkSk9FTAQN-cdHTE1pmxbvFMJfQlzeY-YLbK1nw2sog>
    <xmx:PXr7ZhjcZDoqlFXUeQ8yLWgQFgyz6llVS3JytxI5dB618277DTBnng>
    <xmx:PXr7ZoritbEbekrXkrXgCPePsTWWilPBD-d8aIAXNJwX8gaTjAWfCw>
    <xmx:PXr7ZkgCzwnn_ZZtyDj0j-4BkMA3HtMxMfpgRsgy-YBof8dLE9O1mA>
    <xmx:Pnr7Zphr6Jv8Itlmj53E-L4IjMhH3LOwAfFWp9fPoP8ssBiv7QiNx4Zr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 00:27:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18d79b8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 04:26:50 +0000 (UTC)
Date: Tue, 1 Oct 2024 06:27:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <Zvt6LxWm8gtJGw9S@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
 <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>

On Mon, Sep 30, 2024 at 03:19:04PM -0700, Josh Steadmon wrote:
> On 2024.09.27 00:07, Jeff King wrote:
> > On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:
> > 
> > > +test_expect_success 'ref transaction: many concurrent writers' '
> > > +	test_when_finished "rm -rf repo" &&
> > > +	git init repo &&
> > > +	(
> > > +		cd repo &&
> > > +		# Set a high timeout such that a busy CI machine will not abort
> > > +		# early. 10 seconds should hopefully be ample of time to make
> > > +		# this non-flaky.
> > > +		git config set reftable.lockTimeout 10000 &&
> > 
> > I saw this test racily fail in the Windows CI build. The failure is as
> > you might imagine, a few of the background update-ref invocations
> > failed:
> > 
> >   fatal: update_ref failed for ref 'refs/heads/branch-21': reftable: transaction failure: I/O error
> > 
> > but of course we don't notice because they're backgrounded. And then the
> > expected output is missing the branch-21 entry (and in my case,
> > branch-64 suffered a similar fate).
> > 
> > At first I thought we probably needed to bump the timeout (and EIO was
> > just our way of passing that up the stack). But looking at the
> > timestamps in the Actions log, the whole loop took less than 10ms to
> > run.
> > 
> > So could this be indicative of a real contention issue specific to
> > Windows? I'm wondering if something like the old "you can't delete a
> > file somebody else has open" restriction is biting us somehow.
> > 
> > -Peff
> 
> We're seeing repeated failures from this test case with ASan enabled.
> Unfortunately, we've only been able to reproduce this on our
> $DAYJOB-specific build system. I haven't been able to get it to fail
> using just the upstream Makefile so far. I'll keep trying to find a way
> to reproduce this.
> 
> FWIW, we're not getting I/O errors, we see the following:
> fatal: update_ref failed for ref 'refs/heads/branch-20': cannot lock references
> 
> We tried increasing the timeout in the test to 2 minutes (up from 10s),
> but it didn't fix the failures.

If this is causing problems for folks I'd say we can do the below change
for now. It's of course only a stop-gap solution until I find the time
to debug this, which should be later this week or early next week.

Patrick

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 2d951c8ceb..ad7bb39b79 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -450,7 +450,7 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 	)
 '
 
-test_expect_success 'ref transaction: many concurrent writers' '
+test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
