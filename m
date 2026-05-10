Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF12BE7D1
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778457079; cv=none; b=dmDIU1flIskNSIjzX4zsRXx2PXuBi9qWRElEGZBtR3LlcnPcPaZuvfQ1+rMKll6c73mMBsFc87eW9S2wiFFzqyz0kHnauW7Fsdmb9q/iItNK/FB1LQje05W2Fm1pJjkF6iOMm1Xu+zstk63hvd9kCObSLQgOHafo4Jnk9J97YWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778457079; c=relaxed/simple;
	bh=uS4ieGF+nvG4qa5CEMHzklfe88jgZi/UNEtc26zDFCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIyXNdsI8etOGAV7J1Di8lD1wy2V0Ugw6aDlyLClyu/ZUWZLomCyTdZ2vRLmQeaUC6oihFQ9oEZI+j8j458yuh81lWehDZ0uEOQIM1Yn/yJKOknpjQKovIKO595WEhTUbk1+/fWPyjTZvasRzpo/gAGtOdmHHTmdziYLBn0tPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r5pHpqI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4hkKfPF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r5pHpqI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4hkKfPF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14A0814000DE;
	Sun, 10 May 2026 19:51:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 10 May 2026 19:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778457077; x=1778543477; bh=FPWzT216eM
	tHdNWEyreFS4m1iZe7GfYq47+6pHjLr9M=; b=r5pHpqI+/KtScT82PUEqSTIW4Z
	stG5PEnfUMWGRuaLyqnbqgFsij2SnVDo6tnOe5UR3AGVmfhmcsuzPwS4D1WIpC+X
	u2KDcVhWnMee36qjRI3FmlYSAl92pxKrlQymbasWUPNP2iGPfCA1GYPJ4R3jsw2A
	3+PC/eG7l1iN7V2cwtDqMc8RoO+eiJC+dO6Qwifih9SpHWk+X3kQITCeYD+QiLFO
	3EE/HZv4GlkIoyS3MDhoL7BKI+tyrOCzsiJe8YRWyMnzl2wRRX++fI1CsbByB5Av
	f+wOJkKi0n50DVV/NfpoF6DSHX3KUB2DiUd5vk//TRFpqPA0wOBiQg+p2t+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778457077; x=1778543477; bh=FPWzT216eMtHdNWEyreFS4m1iZe7GfYq47+
	6pHjLr9M=; b=K4hkKfPF2kVEO863WYazL3v+FQg04ZD535XEX1QurQnJ0VO5kSt
	7H4O4Ay+G9gF+CkGUz5JczguQvZtVbxO3yswaawvT203ZHjmhxJDr/iJcIF8MJgA
	iI3pkbNzsMwbFW6XSzgGXDaTY3nxU8mrxp/QiFMTIcr2dsAf3A93bnQls+rZUj1M
	S2bHRUk+OOY3VCVjMbmL4luGAVPfF1OZR+0EZMmI8Un0qxM6gtAHyojQ/Gsryt0C
	vFexky8GMgvUXhidN3Qo9UFVYh52CJcfNbABABtTx4XglP8204IkoWGKYq/hEH+W
	7HPb2gxbE6SvZYCKSs6chhBZKsckxE9DTaA==
X-ME-Sender: <xms:9BkBainyZnPAy-NHfyRjy13Pq9czMaS_dcoYR85-L9Xm73kxzpCY-A>
    <xme:9BkBao7smvoUpcppjGgz6on_BwU7iIxoOie31E9fb9X6lk6yOCO0grzju5rUpKy-n
    q4zcl2cQRsUHpNFN9h9W0Iv4oby4CcZMClF68Zj1DIw12COC4ToUQ>
X-ME-Received: <xmr:9BkBam0K867-yvZDELAHZXlkAG2_F0OJAcS9NgNkU1FBtpfgc7Acs8EYchBIbR-Mvt3up3BMn_RK06Xfqq2oK99pWpDeqjQZUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeejhfelhfeuiedtteegveejgfekfedthffffeffudfhvddvgfetkedtkeel
    leeknecuffhomhgrihhnpehlihgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9BkBajF8PnAZwLa7h-r948ynoxsF3ub9DOg9AtZ7VyA9zHE3w_mE7g>
    <xmx:9BkBalh1mREactoXVLrhwmAZNxTLRI0vItNy4tF-8tVgTRXti06k6A>
    <xmx:9BkBamAEnLuhETBjpQpHIzy_5YRusXT_5NGHOdQ2UPi8LxzYP2zvxA>
    <xmx:9BkBanRtn9jTEuGwDnbyLDAL_U_Iq3gEchT50q8Wr9DjNhEOQVxAGg>
    <xmx:9RkBaoi6xYnrLTbHtljmCAVrwpNWHov2R0DnjgvHmMq4Yr8M7h_gWMkh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 19:51:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Jeff King <peff@peff.net>,
  Patrick
 Steinhardt <ps@pks.im>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] ci: enable EXPENSIVE for contributor builds
In-Reply-To: <2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 08 May 2026
	08:16:49 +0000")
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
	<2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 08:51:15 +0900
Message-ID: <xmqqjyta9630.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Earlier, we enabled EXPENSIVE tests for pushes to integration
branches. As we didn't have any CI jobs that run these tests, this
was a step in the right direction.

It however is an ineffective and inefficient use of the maintainer
time, which does not scale, to allow contributors to send changes
that are less tested at the list, only to force the maintainer
notice breakages caused by their changes but only after these
changes are mixed with changes from other contributors.  The
problematic topic needs to be isolated by bisecting, and it
historically has been done by the maintainer alone.

It is far better to let the problem identified early, preferably
before the problematic code leaves the hands of the original
developer.  In order for it to happen, the test coverage of the
contributor tests must be at least as wide as the coverage of the
integration tests.

Enable expensive tests for CI jobs triggered by pull requests.  This
will make each contributor take care of their own, which scales much
better.

Keep the expensive tests also enabled for the pushes of integration
branches, as that is the only place we can notice problems stemming
from mismerges and inter-topic interactions, even if the topics from
the contributors in isolation all passes these tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is to be applied on top of "ci: run expensive tests on push
   builds to integration branches", currently sitting at the tip of
   the js/objects-larger-than-4gb-on-windows topic.
---
 ci/lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index a671994bdf..4ca3ecef2c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -314,11 +314,13 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
-# Enable expensive tests on push builds to integration branches, but
-# not on PR builds where the extra time is not justified for every
-# iteration.
+# In order to give maximum test coverage to contributor builds,
+# preferrably even before the changes consume public review bandwidth,
+# enable "expensive" tests for PR events.
+# In order to catch bugs introduced at integration time by mismerges,
+# enable the long tests for pushes to the integration branches as well.
 case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
-push,*next*|push,*master*|push,*main*|push,*maint*)
+pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
 	export GIT_TEST_LONG=YesPlease
 	;;
 esac
-- 
2.54.0-162-gf1ca62098f

