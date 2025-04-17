Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DA360
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744848676; cv=none; b=bB/rR5Wk7A6VdxqonPkzSzPJ2WN895bYOUMieKoXnxgUuiPOq3rQIMPcm5tQLbJ9F/dd7sa09icdU//uqCnRXlhJmWko43maTsz/3PRiXHe7R8U/xqqcB2dRl1icX3Bzkb9pi3aY2jBmNk7zlY3knwNrmPS6LUhePllYd1tLZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744848676; c=relaxed/simple;
	bh=JOLzoLRwC4YIX+/oRvmCIO64pWeeYPctdsc58Lha6Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYJdeIuKQUZ8uWrpnsq5SZFtldsotcRgF+VHMjgVEEq4vQYpY/wFP8JeCZG79MKRQ5ps7ob8Dx+Wx8h5DBeTTnEZcP6slD+N/VEMI0210XJLJF3SOJ39VW5n8SBBHKbl14kzErjFbwL9f2HNNVtiKj1HAeuSsox+l9W46mvcWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=odQc6bU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sq+50CCS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="odQc6bU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sq+50CCS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01EEC11400AE;
	Wed, 16 Apr 2025 20:11:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 16 Apr 2025 20:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1744848672; x=1744935072; bh=tM
	TpZQpobzhmtqL9rg4GUdiuLOW+RqKGZMNECx4I36o=; b=odQc6bU6d5c+oFUrgq
	7I8gNtEe8bVvUIsZI9J/1fxLEgK22xMsQyARR1GVthuDy23iJv82F8XR63T7bWXA
	B7vZ9arEL/MPfCsuIV/j5+Jv9vZRJ19uwCDWq89zGyrIhrXiyf5DIXu5E4x4rWLa
	sZXiIBvzAl/eGfius+31J+rKO4L7SS1igcHRy+jsKNZ6shdfytl1eviiIbXMfeXG
	JkPBdXMgEp194IjV/fABPEKcJn6z6+AfTTqPF9asS9DEk+xoO1XcAG3cze/yuiux
	+UxFpdPMzLSCADtEKff5SFJqcJXMpSsMvhdRc36cE8L28tE2VrLFEy3NAUEF+n5Y
	RqCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1744848672; x=1744935072; bh=tMTpZQpobzhmtqL9rg4GUdiuLOW+
	RqKGZMNECx4I36o=; b=sq+50CCSLWFfqnV8uIsG1pFGivdqSVAzT9tRSox/2nWn
	zu5XAeGgGn0/ky0M2dcmd+3Qtgn8NFKCWbrHySQym8FdE272ULIqX8e6SE5WVdDf
	oTSF6tpGdR90u5ZSIbrNxvDxoxyUvw6nGaKt6pD89RIWxO2qMB5Y4TeNhcpB+pGa
	9Me4lpiOizgUHznRIzCwAgvvyvwGo2uug8Y1IeDVA3qWLLDsr+HYQKZO58/cq2J6
	XTz4A8k+Rkt1wEWqJE7bjr4VKOdn0vAi6irpdcdlD0Ptce7o424sgqosmZpJEdrz
	7UGAzV9HB4ddtfZNvGdu2dqrPI79MdRN1Qq9vvO1Fw==
X-ME-Sender: <xms:IEcAaG3jZT-EgQw3p0_OEDZFhxvQIXTLtHXi2lRlEXw-NF-XTfennA>
    <xme:IEcAaJHfJ_8ywZ94wlrpsWHNIwzMgbYA7IUjWkM7D2VtsAsWJ9BVrg63_WVSmLpmY
    pDZDxeDQcHUfFgEWg>
X-ME-Received: <xmr:IEcAaO7O4kX0xlCSAq76vaR5g8rLifConnTMpKT2681dg43ukEWNqBlBn0rH_sETqU3Eg8MUAkty6UHahREkZG3gFUCmVnzemb1T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeejleelteejgfdvhfdtheeuffejleejhfet
    ledvueekgeffkeeitddvlefhjeelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegshhgrthgvrghrnhgrvhesghhmrghi
    lhdrtghomhdprhgtphhtthhopegtohhnghgurghnhhhqgiesghhmrghilhdrtghomhdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhope
    dtheiihihtfedtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IEcAaH1bx_McmFxAwzqIkwKLrsE-EY-7Aw5Elg-12SxxCrhMn2Yujw>
    <xmx:IEcAaJEGlOH1c0Z5TB8u7VxB3_zF2LMA3aYch7ZmMY8x4GQxmuqIBQ>
    <xmx:IEcAaA-uf1ZI28UxwNIKv8k3MK3bDKQJPg4k2RtFtLjmgw0u46lRmg>
    <xmx:IEcAaOknMHXl2fJ4et94ueXQidb8S1c3e900G_1P19NXelpaxt_Piw>
    <xmx:IEcAaOcW4LvOQ-I95cNyxutloNWHO4nFa8GkrvMbTKhggSRcW5vBdnBZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 20:11:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Arnav Bhate <bhatearnav@gmail.com>,
    =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Justin Tobler <jltobler@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Seyi Kuforiji <kuforiji98@gmail.com>,
    Zheng Yuting <05zyt30@gmail.com>
Subject: What's cooking interim report
Date: Wed, 16 Apr 2025 17:11:10 -0700
Message-ID: <xmqqr01rfy01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Here are some notable updates relative to the issue #04 of "What's
cooking" report this month.

These three topics have been merged to 'master'.

 * js/ci-fedora-gawk (2025-04-16) 1 commit
 * dd/sparse-glibc-workaround (2025-04-09) 1 commit
 * js/ci-github-update-ubuntu (2025-04-09) 1 commit

As removal of Ubuntu 20.04 runner images from GitHub Actions was
causing some CI jobs to fail, Đoàn Trần Công Danh and Dscho's work
to update the necessary bits to make them work has been merged, with
a bit ahead of schedule.  At the same time, we discovered that we
lost "awk" on fedora image that resulted in test failures, which was
quickly diagnosed and patched by Dscho with great help from Todd
Zullinger, which was also fast-tracked to 'master'.  These three
topics should be merged down to 'maint' before we'd make any update
to it.

We also graduated a bunch of other topics that have been cooking in
'next' and spending the usual 1 calendar week (or more).

 * jt/help-sha-backend-info-in-build-options (2025-04-07) 2 commits
 * ps/cat-file-filter-batch (2025-04-07) 12 commits
 * ps/misc-build-fixes (2025-04-01) 5 commits
 * ps/test-wo-perl-prereq (2025-04-07) 20 commits
 * ab/rm-sign-compare (2025-03-29) 1 commit
 * ab/pathspec-sign-compare-workaround (2025-04-01) 1 commit
 * jt/ref-transaction-abort-fix (2025-03-21) 1 commit
 * zy/send-email-error-handling (2025-04-07) 2 commits
 * jt/rev-list-z (2025-03-21) 5 commits
 * sk/clar-trailer-urlmatch-norm-test (2025-03-04) 2 commits
 * kn/non-transactional-batch-updates (2025-04-08) 9 commits
 * ps/maintenance-reflog-expire (2025-04-08) 6 commits

