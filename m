Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59D21D5A1
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463336; cv=none; b=N/IhIfs5ArluMQsGXsRNWiXTxEqJShbPvABqPl7uEMCeoqcPJZBYjyShkPM3LVZyzx1WTpZ/mCf0itAHW6al5NfBzS3Mo5q+8yt+YaQXo4F4jP2wUYKDjJfIyOCUIMM3IRjyZ5pjBd20wn3+O1qSi6TTDRT70DiQ8A643XYOnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463336; c=relaxed/simple;
	bh=oclCana58mt7kb8rhmKQGZp7sXAAzXzaYuRtkACLgcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTWLs893TgajZuBalYrRbMlmmnEg16sqRIg1OmAQ3DG85edtLt6mEOM0I8XrNthKWTcyOzLQRwKxcHn50MDW4uGN5c+x4ISujck+ItTbUTcAfpopGTJuiQIIHcLiI1N8PZSEV4To9aPZIEm0bNoSmeyQaC5q/NDB+LhrCqNKIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MWSbPpQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O4VZC8i3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MWSbPpQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4VZC8i3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4231F25400D9;
	Thu, 20 Mar 2025 05:35:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 05:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463334;
	 x=1742549734; bh=cM544SwlL6SAUgU1rgEpOnvzsNLKxM9+2Rd0BQjSl7E=; b=
	MWSbPpQ/Tl09IG9sLCJeUAY1cEroKe4N8/JquJmp074oR0Qlj5e0OstJ4deGPjiY
	zPvxCMb6q/dJchY9/5CT4Pdu6hh6FW8cBD11YEnjdrjU7X+ZA5Jh27hHPUglWDLd
	dEHRy+ZQFaRDIkbpODeD7wjDRBgAcO9a/hk1MPKm/6IYYJZA5Dsb+7JlYHSm+XuX
	o2avdz29wBbcJZJlf8flIIXKekfJFcy39ehpxyixqVHMka5XfFlIF3BW+fH/8cmf
	XweLsLqTa/H1e6ir93CMGsbgya67WQMGE+jIK+XjYWi3jX9ycEQEcZJGw7Pd9bTD
	eMt7r1xfwSrCemXOxZ0z3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463334; x=
	1742549734; bh=cM544SwlL6SAUgU1rgEpOnvzsNLKxM9+2Rd0BQjSl7E=; b=O
	4VZC8i3ZVnwZ/3GrI/Yk6XfZB8/Jp167MI2UwSCvV8hbmyOAfLHl+RTJI4LInd8x
	KXQK/jW1pGR6i983ijT0UTkxkbrrOkF8hIyIhOX52CIz3E3xR2wwW8rfrsEvZfOh
	nSF+kQBu7fMGcVuTEtKUtSa2x7b/OHn683spMxeGb0xNJR0AqphzKdYYNBIZfQQ3
	eD1M+JpHqblS1u83G41+Gdth9V86f7d/mquA7vdu0Sparg2hZg7cWc8+flKyJjzs
	nujtTQ3Kms6mP6zzfEynRKN/HHDSd99O5fog+iOjnDIrM+R7PXp3Y9DZ2qt1Jwxn
	nC6JhJ7ydv5AzJ7vfkJBg==
X-ME-Sender: <xms:ZeHbZzmLgO8QjFIUg2cg9jYkOFVoxmoLyDyAsslpSiC44iZ3cXIEYg>
    <xme:ZeHbZ22ZUoXihoRWRpuubgQ740XFSjGLjQmHwn-zukAsA__GFcLc4k5acm6TBbDOs
    Qo7NzQvEiE4pP8GfQ>
X-ME-Received: <xmr:ZeHbZ5qZ3-dGsvVsa8c6KZBpHiWw5U36Y-z_Rt8WllFvcr-fJUBHOnLqJzPz1Cv630NVF6lPtMpfDsQtXE4dIU4cZ_9_dWEwKLCOH8MQVF2UBEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZuHbZ7kuEAnUmo3A2u67zx5uZVsqb1KmiDHZI8xpwAnrfN4PSgXskw>
    <xmx:ZuHbZx3frSKhzwb8_tOH0uQWcGeiq00ZFPeudShPl5ScztjEVkgR2w>
    <xmx:ZuHbZ6upHlAbKILrgDDX8yL9mina31tH6VGjxOQXA1YlR4qMFNLQAQ>
    <xmx:ZuHbZ1Vxv89h_EWvEeHBUXywDoCdl-hTe3ED0hD5cXSCgvWEDu5DkA>
    <xmx:ZuHbZ_DS-HQ2PPyYILFDaj-ziP_U6cUpwa77fir-reONqlNvXmDZy2VL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a64f2a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:28 +0100
Subject: [PATCH 01/20] t: skip chain lint when PERL_PATH is unset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-1-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Our chainlint scripts verify that test files have proper '&&' chains.
These scripts are written in Perl and are executed for every test file
before executing the test logic itself.

In subsequent commits we're about to refactor our test suite so that
Perl becomes an optional dependency, only. And while it is already
possible to disable this linter, developers that don't have Perl
available at all would always have to disable the linter manually, which
is rather cumbersome.

Disable the chain linter automatically in case PERL_PATH isn't set to
make this a bit less annoying. Bail out with an error in case the
developer has asked explicitly for the chain linter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9001ed3a647..1ce3b32fcac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1523,6 +1523,22 @@ then
 	export LSAN_OPTIONS
 fi
 
+if test -z "$PERL_PATH"
+then
+	case "${GIT_TEST_CHAIN_LINT:-unset}" in
+	unset)
+		GIT_TEST_CHAIN_LINT=0
+		;;
+	0)
+		# The user has explicitly disabled the chain linter, so we
+		# don't have anything to worry about.
+		;;
+	*)
+		BAIL_OUT 'You need Perl for the chain linter'
+		;;
+	esac
+fi
+
 if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then

-- 
2.49.0.472.ge94155a9ec.dirty

