Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC81FCD06
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483438; cv=none; b=QfWI2Hm6H3cQE4BN6CZlApEFcLLZhImAJpayMzVrrRaz/8KxeKo4zbojwiySnpwqfDGL8ug9Jo1YSEn2i63BpH7IsRmuSjTEIySoeSmHLdsatu/fm5/9HjeOHPxeHG6yaepLgwYNRjaJJeq5TeqGHvwp5gV6PzlaonJofyWh+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483438; c=relaxed/simple;
	bh=u07hx1u4y0wBiYcirZGe0GTg0qM9RBGgeuculhUJbl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJ6A2r49GWiqa9/iWwfcNJ25A25uKYJmLYQsyh2KC9VbBRZrg9CF4gbXFMteeUqhwn3tFR2Kpz5SqXcoAWR+L0lmh3rgnqPz/9SvWrNZVkYorzyLHKFuYy7v8RygQ034nJeiSugPjnYKFFJr0u8Vtmm30hZnfDbz1KEIjyKzAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H5gpWjjL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x4ddvfsz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H5gpWjjL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4ddvfsz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D59A254014E
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 06:10:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733483434;
	 x=1733569834; bh=IeUW2dP1J6lb44abFNKJ+S4Z0co4hVVydlQyZL/NfTs=; b=
	H5gpWjjLb4R0dV00EeAN5Vpn2fNMBbwzFn1zPvO9gCLC0IIhRP6UJFk6xzciTt6M
	NOUxAxygPK6nu0LhOo5h1T9CISyyTkAkZCCLW0gMqDYXoAio5juy8Crein3qGsR/
	kR/peZJU/209dwF2moXInfcL9hINt5ed9gKnccXaZgXFB5ZbeF1tUWhqHSNl6SbV
	bHrNlqJ9s4kuu4FTaIKZDmMrFc72kby41J8n7vs5KP0LaBNh5K9atXRtfu0O3XXU
	7Pi8jJXRTS+LdSJeq7Pt0+DAFQmcImbvpOQTHLqAPyktliZV4T8M7VUf7qEn3fPt
	L3W4XnfaeCnNCqNqwKX09A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733483434; x=
	1733569834; bh=IeUW2dP1J6lb44abFNKJ+S4Z0co4hVVydlQyZL/NfTs=; b=x
	4ddvfszNFS9Riy32XB2zE5pflUyf3m7ebv1D8oNCB5Km53rbT4xH9/cXIGf5fvxF
	4k1g8rptgBcSRvGL5jm3e+ezGoBfRx3mrW1ULteanzkZs50+GKccRH9aCMTKj/dN
	gZ+nHY5PT+oj5HjTQfE7+JNpfgNwoFCnROSVye+nwhc611HjdShdWyBpuazznels
	CKbUK1F/VUBelvaqHPjYUXRShNfJ5iN9uMZrcGgO9N7tTopW9bew8KSwMBcJliBB
	1ChrxG7f3Bhm7ZhWD4bjsQzno2kXJxzAoeczHgM6mN3p5dsN8VpfFXwg5irhEyxT
	7Mxjh14nOlpD9s+SqRqtA==
X-ME-Sender: <xms:qttSZ1WSiWSlLiBjx5h4_RzaVmGmLTJKC6rj5Xd3-p-Gi0C86gDVng>
    <xme:qttSZ1nIXUxSOLom4bOFciAujxXoxgc6JH3teQoO_wPp5i-uM1hSk_JOPp0Tt6Lzp
    VWegrvjg0Gn3MT7gg>
X-ME-Received: <xmr:qttSZxacWp0j7EZsgn2BOLySyhMLcEyiIrCbdy95NzTdw5SvHUQTeXa7a_GwHGwRcu5l65ND_Y6_ThHAI2lax0EKVef57wlIYRmB02yArS7foA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qttSZ4Wl-6Q6nzrNe2gyPDBOHeulVkwkUGuQgb4xyQQttoCdcBGAOA>
    <xmx:qttSZ_m7un6aQCYTW6JfUx5hnxaO3lU2Ml1eqZrhLAZmc9nVguCbLw>
    <xmx:qttSZ1db1nKccBSDKQAm1LL3Hzu_DqjsuUkKQNWgz5RzcqyEhe_kSg>
    <xmx:qttSZ5GfJpSTh_gTvpcgTPwV7a2W-wxMEHGc2XIggO0Ly4b-m9oGXw>
    <xmx:qttSZ3v8zTLfIR_5vpd7ISRE7OEXjgaoQsJBW_dEp0VsVR25KhHVhwU4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Dec 2024 06:10:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 986f1cb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 6 Dec 2024 11:09:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 12:10:16 +0100
Subject: [PATCH 4/4] ci/lib: fix "CI setup" sections with GitLab CI
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-ci-section-fixes-v1-4-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Whenever we source "ci/lib.sh" we wrap the directives in a separate
group so that they can easily be collapsed in the web UI. And as we
source the script multiple times during a single CI run we thus end up
with the same section name reused multiple times, as well.

This is broken on GitLab CI though, where reusing the same group name is
not supported. The consequence is that only the last of these sections
can be collapsed.

Fix this issue by including the name of the sourcing script in the
group's name.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ba8f4da39caf29db5edaffde160bc81a7c58c329..2cdc99e7fd05650ef80715b621b42d15d6b13a12 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -55,7 +55,7 @@ group () {
 	return $res
 }
 
-begin_group "CI setup"
+begin_group "CI setup via $(basename $0)"
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
@@ -393,5 +393,5 @@ esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
 
-end_group "CI setup"
+end_group "CI setup via $(basename $0)"
 set -x

-- 
2.47.0.366.g5daf58cba8.dirty

