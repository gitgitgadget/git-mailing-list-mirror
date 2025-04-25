Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195722FDEE
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566165; cv=none; b=bLVmxek1aQyz/MjhSZP3Pkezl+ZbfSzYRqYVlQffKU+BPfsUr+BZ5WLJLGj9SkhxKfWrX5kofhFi6OrT6sjp6hJZIQ30pYsW/6YthaJ03sU7qQiqNo4os78bR0ct7IgPQsd6g+aJG5Oz1QUMNvxmoLcM8fAqqet4oG+IBOqaVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566165; c=relaxed/simple;
	bh=Cii6H6+Cpp02BnfFA265Ud55F4eGbSOUmP6xaiU93yI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HPPh4n9nblvm9ao87liI7Kjeb97dNEOMy/h8n4UHFGAbYIZ9WEpqTruGAVKE64h9/V0H1wXKCCfqbUSgfpGCmW+P/ZgOiAqXXVrSY8yUiJ4jDdodK/bFOpNSm3UhmyIHEpZDw0qKPFR+SFlCEeA22fdMSqTG3ACeXepOvHANyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bb81qsHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bH72PKqu; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bb81qsHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bH72PKqu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D49D1140223
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Apr 2025 03:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1745566163; x=1745652563; bh=zKuYaf38Hu
	jyple4PmYoZSblsPPfOxL9/V9H2uFniSY=; b=Bb81qsHcjEcl73taJlJcKiUNuA
	I3vnWA6G+LF88RJ6Qg5zmaRqwpDHOY15EZ+CIFNOdcZE9f9nW8a1zmpEPsNz8nKE
	AXir3BNDlRa0qe3z2WBVWgz/6dDV5kdZ30JXmD4VxKz9WstMb1OguXK5e7ojtNq1
	gW3Kfr2aVEeYxR4lCbbSc3o6CxErmX4MXXW+D38fpTdpxs3bBzstI0kEusiO40jn
	f0a29+Txlt/iQP0k9RJEevQFIgCrGE6JU2kXx+ycEAgc6O2B6JtZVHSoVlqw/8Y8
	IWeWFMDeeLYhl3k0OhWmlc2l0MZf0VuagappI+fen074J/LhSVMFVSdzl0Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1745566163; x=1745652563; bh=zKuYaf38Hujyple4PmYoZSblsPPf
	OxL9/V9H2uFniSY=; b=bH72PKqu8+fiKa27aBcMbkMgQvFtLg8FByD1nvb1nkai
	mPoFlN5IAhxXtK3qfJANli07JZ6KFAMlvr5EO/10YsBCwWu7tPb1nX5HR97Fn/JF
	9PO8LPrrO2mTzMUf9fykAnuiE3tEB6W6nqMqbdLMaK/OMxFrWWCF16Zqu6g9eAaN
	kv3g8rnW7N4dAn3f+6f6wMc36Xy3FuV0+FRPeyRV+a2BU1kEcXsGKq3ORfkfL4Fx
	Y/OoRq0oxS5Yy06/sNCZmwBtXp8qdpye+Z6DHKGWNMcp/7uC3fNxzK5kB1UerQvY
	autKygYZUQfNJlG9FXFa6wmwVyDudcm3PA5NKoZflg==
X-ME-Sender: <xms:0zkLaDF6Qw00CgLpYpRXlds5mJnvvC1_jsFOKnYv9MfSaDGJe0tk7w>
    <xme:0zkLaAUppbCgIr4nw70ferJxY0xjLA0hkTix7VA3qGB9o-g1yRHOcCjponsQTAp8k
    tgiq_20sgeLAteo9g>
X-ME-Received: <xmr:0zkLaFJNKbeMsQeyoupa4LKFXBmDTsJZoqZL09gVYW48-uu__xH4bU7Brg5a0a3_Lkjp7HfQ5O2RqnCW0ii4VbLsdydXd3ZlGD13gRV2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0zkLaBEEicCFLyWBzM4GQ58rIMkoKGdkzkyV_SYBJLoopN8Pqkx_ng>
    <xmx:0zkLaJXF7c2M0pRxxFJsXxppX60o9UXUyJBjLmDMvaJAQPQcq5dyCw>
    <xmx:0zkLaMOaAyq6QAUpYRNc0Bo-9vnIhDcU73-FPKZwx2B7TBqN9dqPRw>
    <xmx:0zkLaI2o9VgtDFTmm_KvEll-PUqm-84EoRySUl6sr3dQXvBdEfBiJQ>
    <xmx:0zkLaBRLm0l07N_geywizKm54PR_EfUZ00g0EoZcvqJ7zuaoD8WCbcy7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e438ee1a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] builtin/maintenance: implement missing tasks compared
 to git-gc(1)
Date: Fri, 25 Apr 2025 09:29:16 +0200
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMw5C2gC/x3MQQqDMBBA0avIrDsQo2m1VxEXaTKxQ3GUjIgg3
 t3Q5ePDP0EpMym8qxMy7ay8SEH9qCB8vUyEHIvBGutMa1tcf4qzZ9lIvATCmVVZJty8ltKlFGJ
 0/fPzaqA81kyJj/9/GK/rBgBYzsVvAAAA
X-Change-ID: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series implements the last couple of remaining tasks
that are missing compared to the functionality git-gc(1) provides.

Right now, git-maintenance(1) still executes git-gc(1). With these last
gaps plugged though we can in theory fully replace git-gc(1) with finer
grained tasks without losing any functionality. The benefit is that it
becomes possible for users to have finer-grained control over what
exactly the maintenance does.

This patch series doesn't do that yet, but only implements whatever is
needed to get there.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/gc: fix indentation of `cmd_gc()` parameters
      builtin/gc: remove global variables where it trivial to do
      builtin/gc: move pruning of worktrees into a separate function
      worktree: expose function to retrieve worktree names
      builtin/maintenance: introduce "worktree-prune" task
      builtin/gc: move rerere garbage collection into separate function
      builtin/maintenance: introduce "rerere-gc" task

 Documentation/git-maintenance.adoc |   8 +++
 builtin/gc.c                       | 128 ++++++++++++++++++++++++++++---------
 builtin/worktree.c                 |  25 ++++----
 t/t7900-maintenance.sh             |  34 ++++++++++
 worktree.c                         |  30 +++++++++
 worktree.h                         |   8 +++
 6 files changed, 189 insertions(+), 44 deletions(-)


---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73

