Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614434DB54
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368315; cv=none; b=ZwyvgGozhJNCzfdNUQXAHqwTLZ4vFYnuiELKONF2/M4Ulr9j+UpCMlfaTWe+P7PXQRS/me9SsqD848hYcBAF/m5RGpnLoidXLFPDCfVRbtDYXRbnEzMoRBpMxmQ/2zCKCRoA7OBd4u1XPLDp0t8OprpDErdUjgSz4vV0ofyoqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368315; c=relaxed/simple;
	bh=hRHEPWQVyYHaPysblMQpjC43kSo5vmFo+kQWDcZHIUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzy5eb9p7qrLyt/3kksuTFshxgcm8kJr9R2m3gU4/Q7UcBpCOV/KKGJb2UMGFXWegh33QrtCMubdN1/rcMgYB4mXfz7XYH18yw6g37zNNhUD8K6jUaAq30Yzl8HQATY7ibPkNr9ytm6BQTnaxKP6yfaUEtOgBBji9P5bNPncy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zvW442HQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfFgfH81; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zvW442HQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfFgfH81"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EEA41400057;
	Thu, 16 Apr 2026 15:38:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 15:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776368312; x=1776454712; bh=IC10fhwILJ
	tHl2p9Uxs3rlajpNG8UFgRR+dCmYeYkZ4=; b=zvW442HQi/L403J/q9s0003no/
	zSCXcYK7RBjqa2BXQpHHU+gukD+PYIvTOayOx4F/SzyNEH+RDQ2IqTFKIpvJbGi2
	K9CJl+SY6uZ+1KTsDa0Go2nsGgZ00e6mvhlIDb7rXjAZ69V8cV4ZgKc6usylFUCe
	vtC2zyYWpvJTLnxTUVXQ0vRUFCt40LVxZCFqSpnWze9jtKzUpl1KT1FqLETFXASy
	XTPOOier5MW1v++uZXMWZkjNuBFHTHSSE77IuAAJkaqo+Nbeg0LvjGZMakwob2yp
	KuNkHBLU2nUzQRLkmYtwVhHzEgQ1RoZEhZIWBVDfp0A9YAHQQjYco6HOW2TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776368312; x=1776454712; bh=IC10fhwILJtHl2p9Uxs3rlajpNG8UFgRR+d
	CmYeYkZ4=; b=DfFgfH81QJSjt1KJiSw/l/GVccpKcSU2VhWC1e7WURKKiEqdGiR
	HLOtKBDKh04hxRmkjNx5TP3N39BzKratbJKbIpwzndlPkq2KDij6M5YfdZUqYmGG
	smeAPFkbbneMXEjB/FPwoPOTnDcx0wHPl1VpY6w9ThJPK8knPWaOhvWlHq614qxa
	hRdq19IBwpbp3gsyEqM9WcCDiQsln+UdDBRw0uxspuUw1NEh3AA2OcoH7a0a8FAa
	Vbv/ytvbFrCAXz2hcvOqRLSMFSj1Osd80vJV9iUE3i9lE/e0P1dig36X4DVtGwyv
	5Ff2ulrn18EDnEfRuFHAcBchfkRbiUX+ZUw==
X-ME-Sender: <xms:uDrhafLeBFbH2_TSKEv9VirDZqtLGSboAM7rxp4ylh0wqg_S_KRDwg>
    <xme:uDrhaaA_pX6PaFcXzVeU0kLLdOaaRgHviRbLSOt2YpYUltd1mlFWgzBZkm10yWwjE
    toRDwEVfGhZQJj19PY5HlFEXcjXHc3U47EFfiVuyotS7SCG-dg>
X-ME-Received: <xmr:uDrhaQBqGG73xGJZX1CJPCL_QuTL7pJna1SqL26st9yuQbTscjoA5lGbk0IcykZlDdk8xsTaObs9NZPnM-Hd8EYt8rKpodJwRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uDrhaUBMQg0imTOE0jbyuXGaW-iVu12Iz_yeltVbVT7GfXf1eafF2w>
    <xmx:uDrhaTq00TVpdGLDsnWDfIxdJHuVNJtvOkm9zgbmZEQJ15gT2wk_4g>
    <xmx:uDrhaWkyqscgk4bqHqTR3gWy8kpDSP3NB3WrLO7mdy7SCuwg49MnCw>
    <xmx:uDrhabwUx8my0m3lR3XJAgf5X6y-yftBNqIRojdyh47PNdLvXqdAyw>
    <xmx:uDrhabEB1DFjjMm_5TqQefEBupnBVnBAIQrHnkgx8WVy7TFFCcR-30le>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 15:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
In-Reply-To: <xmqq8qam217m.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Thu, 16 Apr 2026 11:45:49 -0700")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g> <xmqq8qam217m.fsf_-_@gitster.g>
Date: Thu, 16 Apr 2026 12:38:30 -0700
Message-ID: <xmqqv7dqzoeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> From: Jeff King <peff@peff.net>
>
> Dscho reports that fetching into a repository with Git 2.54-rc2 made
> it unusable with Git 2.53, as the recent code by default writes
> version 2 multi-pack-index files.  Version 2 is the base of more
> advanced features to come, but using it where these features are not
> used is a strict regression.
>
> As deployed versions of Git and its reimplementations may not be
> ready for the format bump, let's revert the default version of MIDX
> file we write back to V1, and adjust tests that exercise V2-specific
> features to explicitly request V2.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Let me reword the proposed log message to talk about background a
>    bit more why we want to do this.

Of course, the tip of tb/incremental-midx-part-3.3 needs to be
adjusted with this before merging to 'seen'.  I think my tree is
getting ready to push the "revert the default" down to 'master'.

----- >8 ----
SQUASH??? adjust for MIDX version default reversion

diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
index 562554e69b..7eb1109ec5 100755
--- a/t/t7705-repack-incremental-midx.sh
+++ b/t/t7705-repack-incremental-midx.sh
@@ -63,6 +63,9 @@ create_layers () {
 	done
 }
 
+# These incremental MIDX tests requires the V2 format.
+git config --global midx.version 2
+
 test_expect_success '--write-midx=incremental without --geometric' '
 	git init incremental-without-geometric &&
 	(
