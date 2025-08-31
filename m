Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F579CD
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756682767; cv=none; b=ZhIoZEsekMwN30qFZQWuDeVLhHJMcIunoUDWowvDBJnUodvT1aTY9d+DFZIPRd8smu/0cesHTpx1aSOZXJfHcdYdlGqHPm7fpmAEGCcOjJJ5TEy0SIlWJW/oi/GfkMy4RGPb+AKKeK4BuUBe2hHTOqrAybzs3zqMXS0JAQIFP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756682767; c=relaxed/simple;
	bh=X/0Rn/Y/Txu9SNqQR7qKZyrQmOceTw61tacXfm5vdwM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=E9erCSpXLivwQI3cyg5/pDEc1JPjH7STgcMcU0eiw+nHon+b5oBoGgwLacWyq+HSFvVSQqKbQhZpbQw+Q7idE07vuOxPiWU7FvqVb2VLV5EfmxHOiOhexa9xY+Mvr90JoWytgJVcbdJ9hSX84jrspgdCgxZaPvGM7b/G0QeamR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=LU7TzSKE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fksq+7cv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="LU7TzSKE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fksq+7cv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A0061140018D
	for <git@vger.kernel.org>; Sun, 31 Aug 2025 19:26:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 31 Aug 2025 19:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1756682763; x=1756769163; bh=SA
	RHKashyEpnH5zrSOgj0RN07im2FZIAlpRVakCeTkI=; b=LU7TzSKEHzzOQ9UaFU
	qYUhKDW7CZJSHpMP1R7wSuZT82jKoqsKR+RoOKq16LmHX8jssoHMqAUJbVDFBfpf
	WzQ6emCYySAREzMTuLNGw13DjmbR61Bo6aO8Fkul/2qrN2WHaxnIRuIC1lUVVZck
	TTmSJwBWygsD5hY2xK1D5xythDSDddap0zCc2mqFQKnNjKxoJB+ZnjQLi3PODUbt
	CM42ISZAB6LrGpnAwL+Tzuow41gRFoLvc1GW6X5C+KmLK6mrnf76r+Ch0yBfrwXp
	yE7gaC7tTY3+WWKmLys1KDv7iLp8Y/M+O+VYc4Xo0nupOmyVTD27C4lIpXWZ5jaY
	o1qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756682763; x=1756769163; bh=SARHKashyEpnH5zrSOgj0RN07im2FZIAlpR
	VakCeTkI=; b=fksq+7cvp/G6tTCZq+0EG8+MF0BputYWgNiXUilH5WeMApVNl1z
	+xE/kaO7x3devee0ifk4C/ybU8+NmQH4N0Te1vrea/KMqc3u2wHbZURzVoy2H/WA
	AM2A36soUjipaJJC9jIAlEwvyXSsD4oxZc4lafFjLogw57V69EXGG+6eVj4dWTxB
	GJAt0ODpFSkI+UR3oD0ERGDbbDf6/viV/LvevZiHLCbEEuzlJEl25gP01X8UMFJi
	Eh/39FwJ6rlAlFyQiWVo710s9GJabJ/5dqv97W/uzWDx4zaFYjbS5EA+8sH80lnt
	C66JuYUKuLpLTczNv9H7wCNxaAyikU6GV2A==
X-ME-Sender: <xms:C9q0aOdY_JICm_6vx-_-6WI5WmAq70mt-jzkZkB-qQxPrZg0kFKzXA>
    <xme:C9q0aKPPZxAVZUcaYphremoWQTEgqXa-XqJmTopOFdoAMAyPrYmxX4aDeDB-lwAHr
    QVtgxOFucX9WYfh>
X-ME-Received: <xmr:C9q0aI5beW1GKBKG5Eka358phQ1bhQKg67daOkMeooz2IMwZwgweVd_QlPfDPMBrxVi5EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtdhhtd
    dvnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegrlhgt
    hhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpeelkeegtdelffetffelueelfe
    fhuedugffgudegvdeuudfhteelheegieehfeelueenucffohhmrghinhepghhithhhuhgs
    rdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:C9q0aOKE-tDMBg9RRjVrqBMiPRqoaK9Ubmn7XTJJ1O7fljbCO4a3Gw>
    <xmx:C9q0aCeNEEx4gOfcP2z4EGBOkzQ1Axxb8oveV4uyXkSYZp_X6P8jgw>
    <xmx:C9q0aBct0ELnAzXvUONEVUE_fRJJtQap8RKoKbqStv74NTTckidm0Q>
    <xmx:C9q0aFN87dY1HWV4-Q_k_9wl9OLltvGagbkFiAqfN6EwYjraLSKOTQ>
    <xmx:C9q0aFGmOM07zLnOtA_6T2BpETL7v-S4dbsO0pvCKhfKBjsTI-_qOftN>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sun, 31 Aug 2025 19:26:03 -0400 (EDT)
From: Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Git Stash Synchronization - Best Workflow?
Message-Id: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
Date: Sun, 31 Aug 2025 17:25:51 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

Hello.

When using Git 2.51.0, what is the correct way to safely export your =
stash and then keep that stash up-to-date? Here's an example workflow:

touch demo.txt

git stash push --include-untracked --message "Demo"
git stash export --to-ref "refs/stashes/$USER"
git push origin "refs/stashes/$USER"

git stash pop stash@{0}
git push origin "refs/stashes/$USER"

git stash push --include-untracked --message "Demo II"
git stash export --to-ref "refs/stashes/$USER"
git push origin "refs/stashes/$USER"

Notice, in the middle, I pop the stash only to rename it. Upon pushing =
these changes back up, I get the following error:

To https://github.com/bkuhlmann/test
 ! [rejected]                  refs/stashes/bkuhlmann -> =
refs/stashes/bkuhlmann (non-fast-forward)
error: failed to push some refs to 'https://github.com/bkuhlmann/test'
hint: Updates were rejected because a pushed branch tip is behind its =
remote
hint: counterpart. If you want to integrate the remote changes, use 'git =
pull'
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for =
details.

The work around is to use `git push --force` when pushing updates. I'd =
like to use `git push --force-with-lease` but that doesn't work.

I realize that force pushing over your remote stash makes a lot more =
sense since you typically never share a stash with folks but was =
thinking it would be nice to ensure you don't accidentally override your =
remote stash when working on different machine when you forgot to import =
first. Basically, wanting to protect myself from myself. :)

Is force push the only way to handle this use case or is there a better =
approach? Thanks!=
