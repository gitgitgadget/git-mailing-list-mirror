Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD328D8F8
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700080; cv=none; b=LdFy0tVVQoJDGO5ZhJyRR0GXwBIxIoH7yND7YdrY6ObX3sFT9j0Li8Zm28q1cHEe4ZfFQdxMv7nMRntQ4L4eV1QnxJBGY2RHckbw5QqDoHjd0AMhckPPJYtSpjQ8gMxtrYPPaiDEM/7xnPYMfHnRTWA1VlmyBP3U3Lcsqm5EDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700080; c=relaxed/simple;
	bh=bDWIoP1Vm6HeBFA3oM0/isg0fE8fJ61FtayfqGDIloE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kizah4TcrZEvAsPETE3G7BNQJvDw31Ej80GuOE5GfwM3xWcJj3b70LO9bJRcJAeLzT1a0Xf69C0pqK42tB3OAvct9p7+U8C3WH+rsddgq7s0gcSgPAh2CrC6+1uh6za9hQuTUPDi0LhG5iNI4+Sdqmcc89jEFmOgVh1U7U1WjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J6tTmgH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kmarqg8o; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J6tTmgH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kmarqg8o"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D53591D00033;
	Wed, 16 Jul 2025 17:07:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 16 Jul 2025 17:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752700076; x=1752786476; bh=8IKry23lQS
	ZqCzuiW2ud6gMgLMHw8XroubDabdMrAKM=; b=J6tTmgH3w1pEn+jLJC+6kAPgzR
	miitJMNCg3phAmQL3YKBIL+wz/kw9YoBz3ytVlu5DLbem5bjRjzsc6iTtPZJod0z
	i4MmgRhDGZbCoXMSdPZyJcSWdm/2Ulx8fjVhkMjpMUSu7Jf87+Uf9KQ8MibwL6Kf
	xYGJ/KDeYBH9/yZdnMj0ChzZaRyJbShayzhbC8eR/G9R4NqnUCl18AECIjP6UR2D
	lcrai4YYr7ecVbyLYNz+r/l7Br/sOkvN1D/zvOQQIsS4JvKu/Df/p0nFjkec9RqG
	GFm3koeJSpKwOa2vaRAotP7kjVVz0ITmb4GZRN2sV09/y195Vw3WIPkFpBCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752700076; x=1752786476; bh=8IKry23lQSZqCzuiW2ud6gMgLMHw8XroubD
	abdMrAKM=; b=Kmarqg8oUQUy975ugKh1+qvsARWE7PZVk2faodbx8TmVtVaAyEm
	Q3Uw7mQCEtCMixckz1mILUIto7s9+sIZh1V8esCJBwCsKh4mu52PLeqQScq4ErM9
	EbrqzMM3Nx2TJ0JxyD+mO5IwwivRZIzkN5iQUeOct8gSElIUZBIV+PLIESrB2X6A
	5Uh8YncMQkSLiKl69JJ28ycNiIamLsTxDcmLEX0sIieqNvIYb6NlZWapmYJmK51O
	vmZX3np+cG8m0jD1fzPTR8M4iA+TvhCSItNY6kgS/v65M12pL7GNM8ppVzgRYZYZ
	jh13g3BpSeUf2C5GL07UrtVgmL4ZdBHhYMA==
X-ME-Sender: <xms:rBR4aCiyix2R5bJN-zP1Pno0ZK010gJgotT8l6ssjc1Dfjk1u1eiVg>
    <xme:rBR4aGTT6DeQ8mMSBX1Wk-zHTzWmow0nGrOy_VGeW07Y024sneQQN5vnJXMmnMvJ4
    KGe1lV42sVq1PIuUQ>
X-ME-Received: <xmr:rBR4aDhdCH15zYd4Vk54hqF8cYxuOKyP4kxYYXR0DXf7I5VRLs83NsjkJLHNiA99ROnUGjDkq4l2Clm4jHtWdfw42hMcgfpxScQnhLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:rBR4aG58UaphkeGan-Mq4nSa2CGoemh2xGK-jT2q_eIVha9Mzoh7cQ>
    <xmx:rBR4aABQdt5XifcWBdPh5dHFFoKMZt0vyIn8oc_EILDFRlrfyiOhxg>
    <xmx:rBR4aNYZEzKMes1BvV-6dwxWEUlXOsl-nvGjLCqakzG3UWxNCMRWzQ>
    <xmx:rBR4aLYEz0NtcTJXIPP-DnG3qmmv90gWTMQx_-DzSbRlf25a710GnA>
    <xmx:rBR4aF0gT_ePel-tKARGQUItNRFhe13OSHUDqGAcmFpwtbHtPp0ZHDKM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 17:07:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] ci: allow github-actions print test failures again
In-Reply-To: <20241213-pks-meson-ci-v2-8-634affccc694@pks.im> (Patrick
	Steinhardt's message of "Fri, 13 Dec 2024 11:41:23 +0100")
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
	<20241213-pks-meson-ci-v2-8-634affccc694@pks.im>
Date: Wed, 16 Jul 2025 14:07:54 -0700
Message-ID: <xmqqa553alp1.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

eab5dbab (ci: wire up Meson builds, 2024-12-13) added two instances
of a very similar construct

    FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts

one to ci/lib.sh and the other to ci/print-test-failures.sh
Unfortunately, the latter had a typo causing shell to emit "Bad
substitution".  Fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index dc910e5160..5545e77c13 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -41,7 +41,7 @@ do
 		case "$CI_TYPE" in
 		github-actions)
 			mkdir -p failed-test-artifacts
-			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:t}/failed-test-artifacts" >>$GITHUB_ENV
+			echo "FAILED_TEST_ARTIFACTS=${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue
-- 
2.50.1-447-g6271d3ee0b

