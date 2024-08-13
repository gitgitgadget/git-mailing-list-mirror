Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922621304B0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533464; cv=none; b=dAawEM66oSRi4Xuqm5CdOvOBj8yWWk889OL2I3xc0DV406W3w9ksPE0EIdmhaRNpPcJeSVC6A507izbNXwSNeZB3Sb+kssvDfI1vW3xeHplYFNJvUn/O4ntV3YCl0cW9ESLS7FW0RYHrQeJ6xbeLaBWOdNwcKROlCAxPhG5xHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533464; c=relaxed/simple;
	bh=oOFgSZ2fMbCZe5Z0Z5XV58NaRESSXrNXe/AYv3H0eos=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kZc8vsvbyW3mQUF56bEQvFxQgJJeVL3UlWhjFIpwCejZHm5Y6keQmy9sC5Im0YnFDhyxidUUmJZ3jcKAwqC2WEM+OyK2UqfmkOo0UG/Sdu1kYV4YUWOB+W0JEFY2fatGbx2dqJnOM10PPTmRTtzwIP87G5vE6/waec6YILbj3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BwRxCxgn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgQIaY3K; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BwRxCxgn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgQIaY3K"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A20B81151AF2
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 03:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1723533461; x=1723619861; bh=DvitL8qEjYeZg7jJfVxBD13kjTDzANVW
	FGL1p2cSij8=; b=BwRxCxgnswOIIJ3tdLTVGBdwRzq/OTw/xXuWWagfLKgtYONJ
	3ZIBd2V47o+9t33V41+4NUBSLfGfzY/662BhBiuzmW0B91HfYOKx1PX00/0MwH59
	7aAVHosl9nsbKezQLUZIo0fj32CuAcF7fqt9A5awZqyvi4nH9MAW8XhyBUwhb4AS
	Zjdm9YGo8wkN6IEZrxxPLj7JtSRmf6teTIky225wcRxPKTw8MjWuQ7B7MxALaxOv
	z4roqRR3Wgx7IfDgUThPm3fUFVOPa3v0yiGLFwVT/hB6mXkuisN6JQYT+SMnHJsb
	VsofjQdsnBaVLo2UPR+CpHaOpVfoCaMYBzzAKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723533461; x=1723619861; bh=DvitL8qEjYeZg7jJfVxBD13kjTDzANVWFGL
	1p2cSij8=; b=HgQIaY3KABP4ZgMVH14YyF1ONtgyn6CeTNsYqDm/4jMpQEzbY6T
	RrSOu42BsIhLXCbhs369ylf/pJ8Wd/pMxxj2bJkZhEc+V/+AC/0v39CcxZsI+hyy
	JVEsIMiHcEFuA6HzO3IOqOI1voTlqkKOo9jVDBtwqAXyx++227OZGvXAyYpJTFoo
	PlVM8rVU34TIpBmRgLl22MIP+Ag3U4Rc7h9SY7DivjenxLkQ6kOwqt2QqzMrp044
	oOuYDekZHPSpa5XuJOYJMGJ2Myc8mbPPz72KaFeenBf1uN6mSctOAHN6Y5PYd2+m
	fbGEpuYzA1jaFBawLv4RDQyz5EmpzRaTCEQ==
X-ME-Sender: <xms:lQi7Zhh7P45pax0FtBjJUfs81czOc3ZTAhL5lu-uTL0et042l8m_Og>
    <xme:lQi7ZmAVtSuzUdw_N60Xw9vZ6DDK8P5Q9LOMLttaIp3sNCRDI8T_R8HzSeV_MO1q7
    3-nfnr6nGR7S3iWDw>
X-ME-Received: <xmr:lQi7ZhGyLjkLp9a6MN1kMfbVrsnYkWfWg5Qrj1FW6EyHnKCNtdFK5AZ4ihIwtySTC7mdTkRJchZn5jDrdJDbC27EYiANl-agJgRhd7lMhgUYKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeegveegffduje
    fhveehhfejgeekvddvleetkedtudffieejudeiudffveelfeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lQi7ZmSDbHeFmLCUWR1MrWKaTGRICjU9SoZMICvUeHRQ_7Jg77ktdg>
    <xmx:lQi7ZuyNs2uMVDzHYHr4ogxPQZQJ_tHaTIZ5kTqUgaQaKrwzzXnFBw>
    <xmx:lQi7Zs4RbCue_Nu7cWiLxEjS3Z0eLY6YO3FEyLVRWxcRIiVzZACcEw>
    <xmx:lQi7Zjw6iBXuBkhTa6QrOltN31VOCrSHEfpkrPIoNUH0jlhUfrK1BA>
    <xmx:lQi7ZjoXY__AvzC71IZ8nDLnRd-dogQKg2BVwS_6IdVmtF7qlksbYdlH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f324877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:23 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:17:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] builtin/maintenance: fix auto-detach with non-standard
 tasks
Message-ID: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I recently configured git-maintenance(1) to not use git-gc(1) anymore,
but instead to use git-multi-pack-index(1). I quickly noticed that the
behaviour here is somewhat broken because instead of auto-detaching when
`git maintenance run --auto` executes, we wait for the process to run to
completion.

The root cause is that git-maintenance(1), probably by accident,
continues to rely on the auto-detaching mechanism in git-gc(1). So
instead of having git-maintenance(1) detach, it is git-gc(1) that
detaches and thus causes git-maintenance(1) to exit early. That of
course falls flat once any maintenance task other than git-gc(1)
executes, because these won't detach.

Despite being a usability issue, this may also cause git-gc(1) to run
concurrently with any other enabled maintenance tasks. This shouldn't
lead to data loss, but it can certainly lead to processes stomping on
each others feet.

This patch series fixes this by wiring up new `--detach` flags for both
git-gc(1) and git-maintenance(1). Like this, git-maintenance(1) now
knows to execute `git gc --auto --no-detach`, while our auto-maintenance
will execute `git mainteance run --auto --detach`.

Patrick

Patrick Steinhardt (7):
  config: fix constness of out parameter for `git_config_get_expiry()`
  builtin/gc: refactor to read config into structure
  builtin/gc: fix leaking config values
  builtin/gc: stop processing log file on signal
  builtin/gc: add a `--detach` flag
  builtin/maintenance: add a `--detach` flag
  builtin/maintenance: fix auto-detach with non-standard tasks

 Documentation/git-gc.txt |   5 +-
 builtin/gc.c             | 384 ++++++++++++++++++++++++---------------
 config.c                 |   4 +-
 config.h                 |   2 +-
 read-cache.c             |  12 +-
 run-command.c            |  12 +-
 t/t5304-prune.sh         |   1 +
 t/t5616-partial-clone.sh |   6 +-
 t/t6500-gc.sh            |  39 ++++
 t/t7900-maintenance.sh   |  82 ++++++++-
 10 files changed, 381 insertions(+), 166 deletions(-)

-- 
2.46.0.46.g406f326d27.dirty

