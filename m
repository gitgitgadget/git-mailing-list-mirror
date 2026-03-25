Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373973537C2
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419685; cv=none; b=KzZLEWHUja339BkpWVF2L5tdnjT2bsdt2d37UAWegeZkKNvbE+E+L8KD1Q7mSsVJKQ1mQYRxJwM1W5r5Ce58ErNaPDf++UhTkuINV2nPKoxYvdX1ZSfHRX+6Xu66/LZAGwHs5sXBWdHcwyuF1kCV63UoQkZ2UUgwj3EE09BHQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419685; c=relaxed/simple;
	bh=uoTqupK4uSP7KxVKPyR5trWbpAlosBfUXGNxky7vhjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8HyKzT+8mCEH62QI9zfwTbl/xFlLqf9eQox4qFAgY1axj87IMSDyYCKeMvKfW+TDUpyGLzybeKU5BaIEtdWbIuALRWy5kM8KX3yoWlIlDK/q55i7ZvitvU4dfL/rfqk5WHeQJXzx/u0HjALruvztTS/SVfgvx53qfage7I15pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hj8Rl3xp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BlTKDypE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hj8Rl3xp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BlTKDypE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EED47A0267;
	Wed, 25 Mar 2026 02:21:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 02:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419683; x=
	1774506083; bh=m0FH4acGFb6O9gGhJqwvJ3Q2CCN3xTML3fOCdm3H/n0=; b=H
	j8Rl3xpGS7MaJtE2FpRfFhM3XY5kZFiu9RVarvvxLvmUkZXLXPJaBq255QTStBkx
	n7Emx5y25Dr/BCjwFNPifbUxFqaM2R+jecslqU59QtwxeylWIeqKYdcGzBwUUO6j
	nBBQVizVsOZJVix8iaTmsBuWRbQs8zoPyTl1haXdgK8YtH32QgxqzdUxGs39nJp0
	lleHZmH9t2lTkViCBFkAVmiyvV5y1KZ+vqHgq2OZKJFD94ZZBoays8kXe4e6d53e
	fx7f8o2Sw4Kn3NTv35m7h95oH0GEzX+99ZCQrRYUckC9JwvGgwx/CTesCqZkB8fJ
	06LV6wiUlzEUU2vN7yOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419683; x=1774506083; bh=m0FH4acGFb6O9gGhJqwvJ3Q2CCN3
	xTML3fOCdm3H/n0=; b=BlTKDypE7xdohFYSuS4CMPii+hhyNVGuNP7oIBPANYVD
	bY8SboKmJkKmFOGDowUJVMx0yBlVXA4Rx5taZCsJZeIFIXciYJgkksVrt8M/NKxG
	gS2wDAfJrC2w/rJYpaPb76qq3U59q0VjP0RnbBc7UE4LvAP6nhoXFeKJfCOXd6/a
	uZTJdpHC+bKwJVLuztUjqRF82MeOm2ERZSW5mAahpJsXdXrMG574EPZC47ugBZ8J
	/bvGGWc5hdUxg1ieUvv6n715/ruT0vNh2jfSqmEZ4RpCnSHJqriU278aRCpBfNnI
	kdaWn6Y7CNGS1DeAFNltwil3StlTBkq0+5q7R4QEjg==
X-ME-Sender: <xms:437DaV2-I1ZZzGlAXqVddLgfzwEhnkTCopKOkFNEL47jsBEk82F-pA>
    <xme:437DaSE7j8YJinfgGcM38ZEtrbYqx-GFcUttk3JTYIVMME2kRvflDb1nrWcDVwvyi
    bavTzSwPCWOy6p3UffnKhBnOxTQDXTQ9uIreB9tNUslp6wV17nQz6E>
X-ME-Received: <xmr:437DaTjJ0I5sIvSUKM1pdGQCngSuLo72mCSj8Q8_sii3I5WDZyN1Bkf2ZirbhTB_vnvbk7hRpOlOzIVpWGAgbzZmrPIiHdG9nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:437Dad9FKJvm2VvjhfXHLi0EFPp8QeuT9XAyJ7dGNeTYWEZP8S7UmQ>
    <xmx:437DaaqXRvTwEV5v__QVa6VEC4j_nZI4SVLfWApVFPRjQ0naFMMoTw>
    <xmx:437Dac86oUi9M8bEG53tLH_16PQ8tlMPfhxK1Xz55RxQMAOhB_xlPA>
    <xmx:437DaeW25FvhO54PV5bI49Gvw-5g8a8jR5AcrwM2KJpjzdcxtHCu5w>
    <xmx:437DaRM_UHcyg7uxeUSWyxc1L14LBHXyJ-JaBTNK6_Uw3UEgm7MulZUT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 04/11] t4032: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:07 -0700
Message-ID: <20260325062114.2067946-5-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

A few shell construct used in this test were not ready.  Make them
so.

 * "git config --unset VAR" can fail when VAR is not defined.

 * The author of "test -f X && run test that uses X" written here
   really wanted to say "if file X is there, then run the test", not
   "file X must exist and the test using it must succeed".  The
   proper way to express it is to say "test ! -f X || use X".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4032-diff-inter-hunk-context.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..efcd863126 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -17,7 +17,7 @@ f() {
 
 t() {
 	use_config=
-	git config --unset diff.interHunkContext
+	git config --unset diff.interHunkContext || :
 
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
@@ -40,7 +40,7 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
+	test ! -f $expected ||
 	test_expect_success "$label: check output" "
 		git $cmd $file | grep -v '^index ' >actual &&
 		test_cmp $expected actual
-- 
2.53.0-886-g529cbd14ff

