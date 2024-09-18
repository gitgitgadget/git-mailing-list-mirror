Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0163C3C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642183; cv=none; b=LeotnqVVxCcRfNueufKAkE8mf2xmhL1vuppDBNu12mmvyq3m49UTKeWGnElA5IJAeW4uN4466pUHrspXiroE0e628FNpYws9JCT78oHbKR0XOMt7jiT4uwh1mJdBZqfp6IQYzNsbga8QgNM6ZC9NX4krQOwHuWB79O06EclbQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642183; c=relaxed/simple;
	bh=u0/EdkaJRLHrKIYhSOnM6sMX+2EcU4GwzTO+0PfqIt4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Iu1OeQH2KhTLeMU9DkCX1iwKK8i1ZJclB69ivZp+W5tzWwaaHg2LHXCb+yXcxEMRjz0Y/62zgLHGoPwVupQoEe7oZfZg2mua1hj6efjZNnfUrUgXAG9p40kkji4LNNktJ4hmFUkMvNZSTAIXNCrI5UxwShimwA2Ai6yVkJHqUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lzm56MzI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6NT7fIJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lzm56MzI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6NT7fIJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA28711402D4
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 02:49:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 18 Sep 2024 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726642180; x=1726728580; bh=Q/05N00Oj0OKmzVGj4/W5cEYilHQQ49a
	4DWgs6BXaxY=; b=lzm56MzIKFDkgfg751KJ8C5Gq+Oqo+uvgd/W8t7ul1HrKjp2
	J0X5e/k+j2JpkD2SEbSpms6z481CtwnKoP6Gjwkx33nowskT3ZucszCHVNpRkrpp
	TDJ2+eKUQJVtEjh4XFPyUaVbNKFROb85/UF/CtoAkeK78nH+OeRC6WDiFI7sBuFE
	sqVbM699CNIe0P7MMeMiykZfjQB2XVH+2Ti7pmmGEeW2PTKcv7fTp8szYaRPphMd
	JnczT5p3Z8KX532rEdqbnjIeALuyZg9AkZlmX7INsxGOp5s5n7jHGj8OwTgRM5TN
	yfJel2dox8EBEz4ebw6tOskmBhMMv/3txsiJ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726642180; x=1726728580; bh=Q/05N00Oj0OKmzVGj4/W5cEYilHQQ49a4DW
	gs6BXaxY=; b=H6NT7fIJY6LJ5r36iDjTqGDNSzDiWbPx46USQhMwkqr0rnAWtT5
	vfUBUgc2nomVb7ptsX6Mmg9zqkIyp9hginHSg32aQdVS4UZSMl2zTXGnTHn2FSqo
	2g359agAJBrOCnyC04i7VfXspQknIPSOiSxzEJ9RN7036FSxy9MmONYBNbU983tJ
	DhgpxtwOG6ewqhGg9t8qIZrjlJH1hzt1IMTjWE/NxICMIdLxAFQfABWqMaE44VWm
	eAJoIlOnRGDtEBQKXqBt0ha0dHixiBHFltsAbMSoubGlyJN/jAoqx55Ou12J1TM0
	QNYY3lu+sGVvv5Ie8735ESi8eMukbTewbwQ==
X-ME-Sender: <xms:BHjqZufvyj6RxQaZcw6LSAzCbZvJCpZuBLZA-6JVsaaML7hHFLryeg>
    <xme:BHjqZoPL29I8gAfa57ED9fuGQZyx-dNUuf44v2MrqndJp0-7HQowmw0tAa5yA-NQ_
    vdsq9rscmOsGjQOsg>
X-ME-Received: <xmr:BHjqZviwkW7FdwSeeeSQYVSqc0xPtc0UmCFbDgtly7_zzKfUGCKOiyXGMKfKkbQ6AkS5m7eccUKBS8y8fg3EeBg8Pi1-9TE62Ocz0d5u7oaejjEb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevhfegtdelfeefve
    eludefvdeiffeuheffhfdvleefffekvdetudffueehfefhheenucffohhmrghinhepghhi
    thhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BHjqZr-VinJ_CXfFpTtf1VLd8QpfUkAk_cdSxaQQFuTTkR5d7vFrUg>
    <xmx:BHjqZqsg4zHCiZSd5JQCKaM5slc8pW5B4-ouHqFQH66YHbBUdGw0zg>
    <xmx:BHjqZiEnmTWfPyi4Z7dONwca9U5JJ4_liWzGumHKzd81CBRIuO2CxQ>
    <xmx:BHjqZpPgZo5QNdmt_t3c4c7fQU1j1NQAZSWWu3o_IQTIz4ychebrhQ>
    <xmx:BHjqZvX50Dfx5b7l35VY4vta3V904k-TVJPdtdKiLYOnLkm4ZQdhnMns>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 18 Sep 2024 02:49:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df849f2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 18 Sep 2024 06:49:17 +0000 (UTC)
Date: Wed, 18 Sep 2024 08:49:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] gitlab-ci: upgrade machine type of Linux runners
Message-ID: <0dfcb4a7b38ca66ec50775928ecfb31c4bc2008b.1726642142.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With the recent effort to make the test suite free of memory leaks we
now run a lot more of test suites with the leak-sanitizer enabled. While
we were originally only executing around 23000 tests, we're now at 30000
tests. Naturally, this has a significant impact on the runtime of such a
test run.

Naturally, this impact can also be felt for our leak-checking CI jobs.
While macOS used to be the slowest-executing job on GitLab CI with ~15
minutes of runtime, nowadays it is our leak checks which take around 45
to 55 minutes.

Our Linux runners for GitLab CI are untagged, which means that they
default to the "small" machine type with two CPU cores [1]. Upgrade
these to the "medium" runner, which provide four CPU cores and which
should thus provide a noticeable speedup.

In theory, we could upgrade to an ever larger machine than that. The
official mirror [2] has an Ultimate license, so we could get up to 128
cores. But anybody running a fork of the Git project without such a
license wouldn't be able to use those beefier machines and thus their
pipelines would fail.

[1]: https://docs.gitlab.com/ee/ci/runners/hosted_runners/linux.html
[2]: https://gitlab.com/git-scm/git/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

A test run can be found at [1]. This change decreases the runtime by
about 20 minutes to 25 - 28 minutes in total. I'd be open to adjust this
to use "large" runners, but as mentioned in the commit message that
would cause problems when somebody hosts their own Git repository at
GitLab. Is this something we care about?

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/215

 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 80b1668ebe..4abfbc3e20 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,8 @@ workflow:
 
 test:linux:
   image: $image
+  tags:
+    - saas-linux-medium-amd64
   variables:
     CUSTOM_PATH: "/custom"
   before_script:

base-commit: 3fb745257b30a643ee78c9a7c52ab107c82e4745
-- 
2.46.0.551.gc5ee8f2d1c.dirty

