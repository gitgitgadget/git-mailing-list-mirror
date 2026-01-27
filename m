Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B2279DB3
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552450; cv=none; b=uLkA1XnLgtGZV5Mp5zKHwSfKMs4We3svTj4A2nr7olahlYeREXRe2p/BmWy83nNH45fFgyN0vIOivY21GsfI84A2n40m9Ig54Bq9eH6oNL9qfoE/BKlYPSGJaKoTBmP87v5ZUCHP2DnHC8ajv0nijprF2V/Jc7DcpKNHthdsq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552450; c=relaxed/simple;
	bh=X/6nMDmVFKYUp+1tHXfkcl0dzR9bt+V99N5oXZUDVig=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gm0cA9zfkvt5RGSFxaAQsu8+Qt4sOTXA867fbVpv8G89m+sJXj9s0Dfq1zSxAoOCioRh+JSeqZpX6rDvDUw51E1IL5AYxzSxG6QHxJQnRJXEvG6DDg4ZEIHTfGYt/RgFyfU0TdFxTrNtU7d2bAdJMWnNFGAr3qsMvRHgVfHXdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UmGtH43L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRXT/yZf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UmGtH43L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRXT/yZf"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 745AE1400183;
	Tue, 27 Jan 2026 17:20:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 27 Jan 2026 17:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1769552448; x=1769638848; bh=IEtbWTLVDLXE4TPlD2tX3ojncn192iEh
	54v1hJNxjXM=; b=UmGtH43LRxWl5jbYhEkXMHKfC9zKfekt8NAHvgJSLFVv24i3
	lCYRbZnHcrx8uuFTkG8AuA13j0RfVJLwHD47NcIj1ouxSSGi4yjBkXkfszbCsfuC
	mD9IOCzzOVIAwvItJjo9QzII6Yps4YV8C9eQTylGs4Z7aqMh1GZvGGZ5akXiVLpQ
	U5Lx5GsX5aEY3rPvhn6UHVWY80n/CgNdCqSsiymghtAwTp5OGSzTbHIjuTjR+98B
	tMNmg6klLvwMb2jv8f9BIvPlBqPxvbyItXbdNBEcBAhmGuNdXHWwYlPpFFeyoYgp
	wLvEKh+rLTRU0+c/1k0eF8lyEaWzgYopB3/CxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769552448; x=
	1769638848; bh=IEtbWTLVDLXE4TPlD2tX3ojncn192iEh54v1hJNxjXM=; b=K
	RXT/yZfL4nFAWB5Tk70eHZwcu4qsiFc3QNA08fTkgrPWXpknYqsC2a1swwKzLn2J
	+Z2IDyn1AGD24+arGAK6glFZZJXqSTgAdU+aYo/ohgQWHfsdXHfQrb2XToqPMVbX
	i5t/BkW+n2nxt8THuHl7MsPCc3ufmCz4xNl521xTEKjgOSDRZFFlBIxIYDQ4EnKy
	r/Hg71UYagt3He+6KJiB3fedkJd4AztVUksyi4GZujgFsiWMStofMTqdOtk5lo/t
	jabyUpTSO+vbLz5JTLf+4xvUX9snWwyZRb+3IiF6outZaurNk8v0qRtbi1JSUtnB
	2ENmxwB+fUC/Tp4P59B/Q==
X-ME-Sender: <xms:QDp5aWeD6HOTtcmT4QeiKhQFaqM7cJdn4vUViBLlqWv1DQacoxVEOw>
    <xme:QDp5aWMclo0B-ZkK5F7bMPmYFvTOyEmjckJjMVma7DMAbXJYRMBBS-SJxGTR7VIjk
    YKF0X-MpPmRi6kRa3hVH-44QrP58iGz1Sn_YK2-JbnyF6xoorJ72w>
X-ME-Received: <xmr:QDp5aVL-918RS9DQr7OXCZLHKCREOCJAjIsRxrBcGWvYLWno4ym_tvoB9AySC1adkvC2ScB4FLs7R7om9vU7FUsNylbMAfm9p70ovko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:QDp5afE9h2LRh7Gsi0yf2YpY30zL9T6HfJ5CjfvOHXfH3vm9uLDRjQ>
    <xmx:QDp5aVRjLnea_2v-BXM-2Z9fBluscs4uaWG6GdL9T6zjiXONV1sDFA>
    <xmx:QDp5aTGuBXNoZUwTb7wA49FRJ46GQ3UlmyJwokb-w0k0uBxMGQEwvg>
    <xmx:QDp5aZ_jqwJykpO-CK4bQ-amqnNvK2by5FnJ6uaNTqxAvV4XjRUCnw>
    <xmx:QDp5aR1RHiX3O4xVmlp90CI4s8CqfAw_PzXlk_vD_m-TmjlVGLLs6xv5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 17:20:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] RelNotes: a few spelling fixes
Date: Tue, 27 Jan 2026 14:20:47 -0800
Message-ID: <xmqqo6meelz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fix a few embarrassing typoes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.53.0.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.53.0.adoc b/Documentation/RelNotes/2.53.0.adoc
index 8b98519268..a24677115c 100644
--- a/Documentation/RelNotes/2.53.0.adoc
+++ b/Documentation/RelNotes/2.53.0.adoc
@@ -64,13 +64,13 @@ Performance, Internal Implementation, Development Support etc.
 
  * "make strip" has been taught to strip "scalar" as well as "git".
 
- * Dockerised jobs at the GitHub Actions CI have been taught to show
+ * Dockerized jobs at the GitHub Actions CI have been taught to show
    more details of failed tests.
 
  * Code refactoring around object database sources.
 
  * Halve the memory consumed by artificial filepairs created during
-   "git diff --find-copioes-harder", also making the operation run
+   "git diff --find-copies-harder", also making the operation run
    faster.
 
  * The "git_istream" abstraction has been revamped to make it easier
@@ -159,7 +159,7 @@ Fixes since v2.52
  * Test leakfix.
    (merge 14b561e768 jk/test-mktemp-leakfix later to maint).
 
- * Update a version of action used at the GitHub Actrions CI.
+ * Update a version of action used at the GitHub Actions CI.
    (merge cd99203f86 js/ci-github-setup-go-update later to maint).
 
  * The "return errno = EFOO, -1" construct, which is heavily used in
-- 
2.53.0-rc2-139-g67c6667039


