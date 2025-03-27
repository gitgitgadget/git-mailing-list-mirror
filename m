Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBB1B4251
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071833; cv=none; b=FRKYf/+N8tNZWk1yzSmvUnYTavuDReK3r0qfCuvdqWf0gtSF/RA2GZdqNVIxa8ZJ+vu21L3bZqdilms1cIYkTLUk73rOoZZLbNvFjhGjXG+toa91gmngYZUWUMGiVkWglX7r6bbu+NdkFE9C6HTk8J6JH7XFuse/yO1UviBYIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071833; c=relaxed/simple;
	bh=r+44rd782YT6x6dz2cANM6QpWXIcYEb9ttd/QWrrMRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iM36xaGiBQXVH9dRlovuNLFgFVUHKfO/WsdYLjX32XkP5sQ2gxtIlSIpnCPBNb2GLgfgaZToo4K1SuRUDY8vvf1COfUdopG2Uuz8ZGHtTeRBaTvm/d+vnAhz2tZSGjcqB8Q2q4Mue2qmyhH4oNQbqWl5efwlbi8R+5WFMOAOQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fYEsBslZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qjq4nfyA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fYEsBslZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qjq4nfyA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A2DC114013D;
	Thu, 27 Mar 2025 06:37:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 27 Mar 2025 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071830;
	 x=1743158230; bh=bBnzsBxGrvlhpKUDGvjbdM63lE9bkJM7rbSwjIEVqBc=; b=
	fYEsBslZ25MBptDp9Ul7kyTOUy6FynnJNu7vFHcZn5Jq70PAf//cQwMqsKPWBgnD
	lIs3IflJOwE45yAHb0dfEpwHYJWySioFgkIT2bB7VulEsLc7VuB6b4FyBNIWAN78
	DuB8Rdd6Rf2bH/q269GHn0nyNnCc3QknT2b3JEHRijB1Cl+5+pmiidnIU/pgLKXm
	mB4bDBq473JAhajFP1m4bqkQCgxQi6NjzlMv+Pc5JGnPG7B1UWZc1NTVtNnsOiMF
	0EmLD6Kv65jos3hN6XuC751mVxole03Ivm9g+mYzOrZ9uo3z/01rSbwB3auGEYP5
	A8gUsDLqhXJ7tCKyaXUvAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071830; x=
	1743158230; bh=bBnzsBxGrvlhpKUDGvjbdM63lE9bkJM7rbSwjIEVqBc=; b=Q
	jq4nfyABorTrQ8TP1N/wGi6C8iLIcu+7mLiXSblEVpuWo99jntu0789mg6plg7YA
	aiR8ikt1/PtxZdNSBMA2T3Hb0sAMTaubCrz1z/L4LT5D3vGA4Goq69CIH0l5JE9a
	V+v+MN86ADZhir5iJtv8+M18HK0WhgwFYxa3KIS5ePWBq/m47id4aHLX0ibP7RYy
	IMFQKY0PXBCPxxcmGt6JSsH/X5NurCB0BR6NGceo6fvgnUnrYKAzcVB373DGCOE+
	nMsux59gUtq3tSIqAkEM2UAKjfqH7pTGg9UMXZgo3wvOLS/eD00Cc9p9OwzXfbwK
	vrZwPcqWn7VV3tU56ceFQ==
X-ME-Sender: <xms:VirlZ2djxDkgKnAiIZeMU3DJ0HiCMUrmMj50jBdwfVife1xB2Yud8w>
    <xme:VirlZwP51kaEFQAHj_hqoF2tknJkwGyKBbyesbIWzkEEeAifhTgKOms3ReS72fda7
    _NX2AQAmplA2RyiIg>
X-ME-Received: <xmr:VirlZ3gQZW0osmc-TxenFB9B2K-ORaspAuzzgsfEbXckQ0XWJF1MUlvby1BcV2dxOZ6Ev7FosvBCyhnMjnyZz3pxf0LQmrXqS3t--febdWEZ-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:VirlZz8_V-SXyEvVh38ktakwnCnaC86qCUwzIH7m4DL-5lx8umJYKg>
    <xmx:VirlZytMUMiyPoXoMV91Q2iSIf96RdmQS0jbdu-sTf6A_yt9cVHFDA>
    <xmx:VirlZ6GsKXHiTjcKcfbrnHcAZsVQPJDnJF3vZKRulhp3FJFYs9zK7g>
    <xmx:VirlZxO44NSSmccS0WmSuXeOoWS4ewjPpv8ItzBzpiC9ROwng-9SmQ>
    <xmx:VirlZ0W8dS8hav5B_IDzifgQz84CNI001RcLnatxcKFMtLnDEOlDiOuY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d46147b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:36:59 +0100
Subject: [PATCH v3 01/20] t: skip chain lint when PERL_PATH is unset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-1-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Our chainlint script verifies that test files have proper '&&' chains.
This script is written in Perl and executed for every test file before
executing the test logic itself.

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

