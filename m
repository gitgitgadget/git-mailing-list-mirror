Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8833120B
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326805; cv=none; b=pCd+l41qy+QccwU0PJMbF95ot4ynqQ8rWktq7KSlhCXgBfF1+djLTJxJdIP0N5hE0eUIIDhkeUj9Ee/of9JwBHSH1A1PL8o0vquQ4zM/A4qaqOGpP24TYWK9tdEUUr+FoIuYESK5ru2lD1iUm5hgSWzrlk9I4U/WwFZyese2Cwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326805; c=relaxed/simple;
	bh=tRp0+P3c/YXdku6w5j/jt6Jyyo5VlczjTvSw34YI4W8=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=jIVuNiNzAoBM10u1o1ZXNvraX/U8iAwZlJDaP6T8r4RxkScv5EyYb8HCImcYnDXuZVuBB29ldUZz7Toz3Q/tRHVHGcHmXXiZndKWxVmpm2hTpniEUUirA69NyAQE4IJQ4sFgTxOLnvYzmXWDCuykLk1lPJJQWEx6zgyhS17OMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w8UDob0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhFWYikj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w8UDob0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhFWYikj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B8BC140000F;
	Thu,  5 Feb 2026 16:26:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 16:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1770326804; x=1770413204; bh=XoPnL+FSoHPvBSVRiV90vpmPlTDgt1+U
	LcaohB0tPBo=; b=w8UDob0Ny49uDGvkNhi14cmzYK1fjx5Q1x7VPE6hMPj3pP9s
	okl49tmWzUKrWrv97aTV9i77GSkZ9CNefhKiNIF20ZNgwnxfvXlqRwYO4NaYe2w9
	WohbLA+kROSmGroWZnyj9GssQt0iCqns7yvuXNCAcgTq1rAyKMhfjEeFMBdRmIaQ
	/ZDvHXB/NlpHpLSVqtKW2Wjg5YY3CZdSh+HWV5BOJMmCl9frp8s8i121I0i9iB1B
	RkDW1HGh1T8EP8Ctc1BqkyVyWt8/LpXq7lcXrYvWytZJsFs2Y5tc8mmmqF3T8tTr
	scz28oj47lEPHlO4oW5TH43Qfc3lBroSXMXxZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770326804; x=
	1770413204; bh=XoPnL+FSoHPvBSVRiV90vpmPlTDgt1+ULcaohB0tPBo=; b=A
	hFWYikj0PrIhTbwSjgA+v+gPDrxVohnYKUx/7DlKSom2IQ2ZH7/i3qhonY+AvZMO
	gShNSvxz33Ng8UXqHTqIVfd9gQBhtxMstfGE0QNOs04FJro4LTRGgEyhKL9vAFjB
	C0zDLkNLaRSbrJ+TU8iYF+Q/kZSR7UsFUvqpdmkmK1LfFscHqbFDXywbfoTgLvqw
	qMaU7z3UPzlCfGndhkN9mjrBDFo0PuQDWqa1m2Dech3c/ZcbmsUSnZKevB+qqI4s
	vQ43nyBDoaE/EE2Aq5c7J1TLDy4xDCDxJzcR0XOUWa26kC3KBdgp3Vc0psdzB0cR
	KBVgar/AeixQNZ769ivYw==
X-ME-Sender: <xms:FAuFafqSAOu9RKl6s-5loDtW0IqJDwZVdWI1rzd6k9DoGdEaaPESYA>
    <xme:FAuFaREolY8rk_ZgZ3E6MWVzoB8lOhkU_5h_VxUSrlQBaTGLzLJywOwvPYT9W70P4
    MzQZwmvnkJDo2-Bx0DS1Cuqi6BxUfMNlVPvhNc4yJkQc-xEF_zvHA>
X-ME-Received: <xmr:FAuFaZldqwZXRAjPMCkEWzBcAhGUeT8TemFmAsmyrUWchrR-Gktpo-fjuKHx6FHLb0qFa5RVSZH3i-yupW2vKwWSVwcQSWZv6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffuveffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefjeelueeihfffieekgeehveduhefghf
    elueejiefhiedtteehueetueeuleeiteenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghskhdoghhi
    theshhhofiguohhirdhlrghnug
X-ME-Proxy: <xmx:FAuFacnT5KxsMiWvX-9rcZWuxM_0VHUHduVqXhkPnJTTAkaYgT50NQ>
    <xmx:FAuFaSs-YimUPyoeK8wXxxIDop9IjsVcNJEfJhleqwG2vu0DsyYkCg>
    <xmx:FAuFaXmb5IaQ8hHedQUAnN1TctECnDY0Y2qVzsWv3F8bZtZIdJ1Zaw>
    <xmx:FAuFaVvyY4LBkw4h8B21xKCyKQx2xA7sk7DKLeKJFiL6H0h0Es4jNg>
    <xmx:FAuFacTX182bLoeqlmRomp1sWvDkmsxnnyo1FZ3d-LTzWbeFVC_m5TyP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:26:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] ci: avoid ubuntu:rolling in most jobs for now
cc: Colin Stagner <ask+git@howdoi.land>
Date: Thu, 05 Feb 2026 13:26:42 -0800
Message-ID: <xmqqy0l6khkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We just was hit by buggy uutils dirname in ubuntu:rolling.
Avoid breakage caused by being on the bleeding edge.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is what I have near the merge of "let's test contrib/
   stuff as well" in 'seen' for today's integration to avoid getting
   hit by broken dirname in ubuntu:rolling reported earlier in

    https://lore.kernel.org/git/ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land/

   Until uutils used by ubuntu:rolling stabilizes a bit more, we may
   want to keep a patch like this in our CI jobs.  Or we may offer
   ourselves as a guinea-pig?  I do not have strong preference
   either way.

 .github/workflows/main.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f2e93f5461..0b4567c99f 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -377,10 +377,10 @@ jobs:
       matrix:
         vector:
         - jobname: linux-sha256
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: clang
         - jobname: linux-reftable
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: clang
         - jobname: linux-TEST-vars
           image: ubuntu:20.04
@@ -388,20 +388,20 @@ jobs:
           cc_package: gcc-8
         - jobname: linux-breaking-changes
           cc: gcc
-          image: ubuntu:rolling
+          image: ubuntu:latest
         - jobname: fedora-breaking-changes-meson
           image: fedora:latest
         - jobname: linux-leaks
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: gcc
         - jobname: linux-reftable-leaks
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: gcc
         - jobname: linux-asan-ubsan
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: clang
         - jobname: linux-meson
-          image: ubuntu:rolling
+          image: ubuntu:latest
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
-- 
2.53.0-181-gfd50f4332d

