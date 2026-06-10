Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995793812F6
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074618; cv=none; b=s6DoMng32FqL2JuhQf7vbEbcrYyp6s+a8cxCM1wUcDtnJB7lljSx1yHE3KJlgbGALSP0c+MMDoixnVTI4gtihuUaZa11PQOkhh0QLCxWxSkL68q/EmBWyk7O7L6WJSj6QURU7REi0yAegG6oDtgyCzhgYLIF8hrePMAVaQXLzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074618; c=relaxed/simple;
	bh=3+JRVeScqxsFH6ibgRBrQ6huCGcnCgl+DkYTsh62048=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dl4oh3b0REQemCh0RBIiUyTZGWL6Ck3QQVoZ9J90YX/6OeHGagahDaUJP678TMxAnyzq1MO3DKiM+lTsCEdvSlAhxcVW20uHsKttUApuR1tiTz15Wmkc1Wxx+Vz1LrvaMITwYuC2z9iZUgXupKGn23zj+yF1zB/9V0qNytdjrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YwyJvTMp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLHkr5Fi; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YwyJvTMp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLHkr5Fi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F3D4E1D00064
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:56:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 02:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1781074616; x=1781161016; bh=sXRSP49S+B
	JBaxbQ4RLOciafKDNWLZY+mv5cVwxhJj8=; b=YwyJvTMp4wbq0wQbHR7M5lxbS4
	guUuCeOKW9xW8J1ygmO3IpEPCZrSAh0mCzlV4jQIvQGp/U0SH7RbYmEYNuzIQNGd
	z3nmbOcI+k940qsqCw6zcHEFAll57CCE5iyl21NQG/LTuDwcXzHe432rsmwtgp2t
	Ye4hKI58SFNJb/NwkKnp+pdRaDOYgVfsvZaDGzn+hbG0E/aAs7A59k5FLrKBJPfa
	waeygzqrmVgDY13OOBAFelCMNTiPfvstnLYeV2iPy6vfOcVQs8lhDfaBC0luwwNn
	7EVfDtcY0yK1tZDj4pwoxl4QgyN/p8LV8zueNozTGITHcgJ1v/GW7SEKjbPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781074616; x=1781161016; bh=sXRSP49S+BJBaxbQ4RLOciafKDNW
	LZY+mv5cVwxhJj8=; b=WLHkr5FieTONQgSv56XVxqfES7QQP0CMyBhRSKyzEKg9
	uRnThnSIgY2wKY8lW3vFrKj1ktEHfVH7urMUeAYKCFt/qUGC0DJqAQqEyQrjcxQe
	4qpWE8uZ0U5YdmB1ToP7LNaALfDNR3KXdH8HosjX4/zYQ0OaWEdUNl6pZkSrQYzF
	xHkTlEIIyQrDooymaNBawSwKpxPeEL0pr6xQ8U4L+Dk2TQGKkMDB7C76Kljn8DiS
	aCFgCUl1BzS/Ay/6WvD47tWzjnsEYKC9d78PDw+UufnQfrJ0QWqA351QbIbuNaT0
	k7nGhl38kuPHVIzB4cas4z6FkBjRj6TUHi0t7RpJrg==
X-ME-Sender: <xms:uAopasr_jmWltXBYosgMfh6n5mr8dhdHsCSob1TV5NRvymomRQMkCw>
    <xme:uAopapl5iliCnzg52ifANEfEMd4_umkWlU_-z9VXvqP1PRjkgxfLblxHZFG8uTWNy
    0grApOwIYn69vDGynUj18vKkhCvpVPKEie_mzNx_54yYHeuY52XhFk>
X-ME-Received: <xmr:uAopam2nY18R3-b0QwN4f5Nor34EtOzrp64nqDQCfJFVfuoE0titdr8aoWoltMKFQ9zJQTf_tuH-iTI6suHULAtG4ADke8Wa99I5SfAziQ>
X-ME-Proxy-Cause: dmFkZTFGrzLyk4HFxWo8XInriWyKMBqGhrl1a1wET8Q57l6fgCWuOVuoO7n0WbLQ27F999
    ulGwm/jEjZfiFZJHoHe9diFdVnmx5TfDzwJJd0QQYHbcSnSWEJyQgEZZGqTOcvYuiI9WJX
    pE6fp4i2scvDsnodHpcSHFPL4Cw1MSRWHvSGPOQzUNXhKuKPbm78YymGMWLfvn1XewVl5Y
    crLiHDjEzcF/Xj1tv8TENdwoWeW+4gCsGZid+dgTXkqzvcevYcAW/3bSiMIeHyS0Vm8rgI
    9BBotZNDdO3NoEFqo+kwzO59wPDYnaB2pYhgzZbGCWrzx5PKuamcGOYhWlQ5CKFjp5arGv
    cy3BaTBJv+LmPvpVnS+lvUajWrBIak++ZHJCQbbsK4UN0ZMveBTzk7UQNkSaIQLqFXyDRI
    NaLxaSh0rxf1Ue/QmqXT+AqNKP9lwtQuXDm++1Fn0l435nXVcqZ18UgQxcZAvoGN8QMH5r
    RBbNfmFVKRU3r9WP0HmFFWCPTTVpsKAFsHMYkHbVd5N8YtZeCRz2tGKFY5L5L6dxMtfyzW
    jfHqaCTHe2tRcy6C+GqV++kX4hb0YnfVZnCxP5ihgj0ErsVUDCxTCoUQq607fhH273RKc9
    Bbx7J/jHFhmmgoKppidBXNYcZ+CI/reaz2yFL1iXznGKBmicvztl1VygGnyw
X-ME-Proxy: <xmx:uAopapC4y2wPXRrOvd5uCGt06H4q17u5-8qzcWYI8F8mrUfWQju_XQ>
    <xmx:uAoparzqcwAgiqllr1xtKVmxqnczs-bNpiS4ifvK2OR1MozlYKkaiw>
    <xmx:uAopavnGOoV7m6DFV4Fqs2ApWKYmEOnoPowi6G334dURgQow3t-HRQ>
    <xmx:uAopaoF3VfPSSqNkCb-BhDmYHkM4Gf4uUbSq_11n2aLFDgpl7Nnv2A>
    <xmx:uAopagJMXzoGeeiKsTM620fTenRUlS-Pkntxehf-DxV144Pt74s6il07>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:56:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ad7119b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:56:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] setup: drop global state
Date: Wed, 10 Jun 2026 08:56:45 +0200
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0KKWoC/yXNQQqDMBBA0avIrDugaVToVUoXGTPVsWJCJkpBv
 HvTdvk2/x+gnIQVbtUBiXdRCWtBc6lgmNw6MoovBlObrrbGIFmML0XlvEX0KUQcl0BuQc0uM3b
 UXHvr2LeeoERi4qe8f4P742/daOYhf6twnh+qBIJRggAAAA==
X-Change-ID: 20260422-b4-pks-setup-drop-global-state-6b1374aed5db
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series continues to refactor "setup.c", where the focus is to
drop remaining global state that we have in "setup.c". The most
important consequence of this is that we don't need to rely on
`the_repository` in `is_bare_repository()` anymore.

This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
object database in `apply_repository_format()`, 2026-06-04) merged into
it.

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/init: stop modifying global `git_work_tree_cfg` variable
      builtin/init: simplify logic to configure worktree
      setup: remove global `git_work_tree_cfg` variable
      builtin/init: stop modifying `is_bare_repository_cfg`
      environment: split up concerns of `is_bare_repository_cfg`
      environment: stop using `the_repository` in `is_bare_repository()`
      treewide: drop USE_THE_REPOSITORY_VARIABLE

 attr.c                  |  4 ++--
 builtin/bisect.c        |  2 +-
 builtin/blame.c         |  2 +-
 builtin/check-attr.c    |  2 +-
 builtin/fetch.c         |  2 +-
 builtin/gc.c            |  2 +-
 builtin/history.c       |  2 +-
 builtin/init-db.c       | 44 +++++++++++++++++++++++++++-----------------
 builtin/repack.c        |  3 +--
 builtin/repo.c          |  2 +-
 builtin/reset.c         |  2 +-
 builtin/rev-parse.c     |  2 +-
 environment.c           | 10 +++-------
 environment.h           |  6 ++----
 git.c                   |  2 +-
 mailmap.c               |  6 ++----
 refs/files-backend.c    |  2 +-
 refs/reftable-backend.c |  4 +---
 repository.c            |  1 +
 repository.h            |  7 +++++++
 setup.c                 | 45 ++++++++++++++++++++++++---------------------
 setup.h                 |  6 ++++++
 transport.c             |  4 ++--
 worktree.c              |  4 ++--
 24 files changed, 91 insertions(+), 75 deletions(-)


---
base-commit: f5a08a09a0fdf0fc2a355eba7979e2cfd65659e5
change-id: 20260422-b4-pks-setup-drop-global-state-6b1374aed5db

