Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC546351C2E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419681; cv=none; b=rR1u6RttQc+3GFOu67L0yjD1UDUjr2CYWvpUl+V4Dpj6YqbajlqjTZTO+YMXbjVNtLr+ZDj05bBhMldDqMozaqhZh7bGVvGFydO0ghnsBd1ilaUhdUQY+GsQbkFNo9dgmDoSdHUQAwDUbNd037Ac4c9pLzCe3Ev/Uv3XhzSgWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419681; c=relaxed/simple;
	bh=Zr8BG2DYLcUFEYCTGjr9esNCKP5W5u5L6tB81xhHk94=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H083HJUheaQMCupWBsUPkfGbKGppUM3m57ISkvR07p/a5glQLBQdGjJnCMDYXOjXEi3WjEi6yxmwoh4NuymolgX1kTIIfcVHN5vQHBWeCg8hgOxKv4abIrihU5cwT75ovI+aq9KhDEU7uAKvqLl/T1hCRAWHTgqNR1EWhrkHY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGoi8BYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjqIR3+x; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGoi8BYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjqIR3+x"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DEA57A025D;
	Wed, 25 Mar 2026 02:21:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 02:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419680; x=
	1774506080; bh=AZRxjIuTJ4VVTEjVq6YHRmfu7u8nit4fwPsKp/3NX0E=; b=l
	Goi8BYkCs11lLaIQjliPcbHJvSRzfPrvwMWqlL2ds3+sNr2ftcqRO8VMmAILJD4/
	z3CY5MAJeoytKA9DOFq6r6umUms5rx3fGoNIWgtqLD92k10l8fdYFOnfsUXXMmj8
	fK+EYcgZfSULW++mINHw4zXEWGDEvxbQVKpQTAuvA/T7/5QSawHMyVVqOEe1OcLL
	zfb0SdJhUh3wI29RjB4asTHvkafIAAx7ELM0Fe2YI6QMOk6chq6QeKuTeu0xuDef
	eU0SthGrl5p1v0GtQqEsgYW30l1ectklcbbZSTWTnl1cZ4oksqdp1SZI5LjD1ZBN
	Y6Fh3LCR/CV1SbOdd2DIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419680; x=1774506080; bh=AZRxjIuTJ4VVTEjVq6YHRmfu7u8n
	it4fwPsKp/3NX0E=; b=GjqIR3+xIRq4qfUyzDkxzMw9ym1a+/bzJwHO7fnUyaEc
	XWUuuMmQzMOPxNLyK4l+Dmeq+OAKGNGmsxTxl3d8BFsqhH9nkSde5L93SQ+16IsW
	ldLMbSlxch+3Xu8dlNpipYKdNj/admpRmpGtGoNKtiBtYEcSWJ+IdS8zTgWE6x8v
	2MYEDqoATjk8JA6wuu6DSQ6FDBFvFDhQw34JDGutV8Ri+cMHqDHPOmFvitZi0nC1
	toM+0SEckUdPZ8fk490hkMgUZFRaSJaVqw9XRt6AQ6ryrxzKo9veJO4dCXK8SU/n
	DxKxjC9PeGPS0Am23CAm1PPOcyT8dppMswv9Wyl+yw==
X-ME-Sender: <xms:4H7Daf01uL7tA0P5iM6q-t1rxDHXLZ-cKrXzIajLm2_j4N9RL8vDgw>
    <xme:4H7DaUHqv7iY9EkOn0t1sMbBFCjhULTux3WAsNzjw_MUVvcX4lsZtCVKklsOaMXYH
    12ncKfsHvaC5vmsZ7mxHV8t-6lKl7CveVjto5V0iASTDVrJJAOZ>
X-ME-Received: <xmr:4H7DadgZYpzfGnRzv5nz7m86o28XfMwGkrqEeP0nFtxTtDqIXBl68-wqPikw6n9auBXwmVy0TaV47wifH_JBgdXAHdPouebdMg>
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
X-ME-Proxy: <xmx:4H7Daf9Z9wPCWbbYnw4KAK_v28s15lTO9vdE39Oqrliw7BFIwbISZw>
    <xmx:4H7DaUrpBu6t0tgnwp4sUfjYrYIo74wQCbjPeKAL7_3V6fRmRSHkpQ>
    <xmx:4H7Dae-7WWjrruPPvJt0e7S5ZTSkOhoH2SGAMCnxxcb9vFHr1tMmkQ>
    <xmx:4H7DaYVx9mqomDCRAgzH7rdfGLRq4M4_YJ4tJrMqxnFpdZHmtyvBew>
    <xmx:4H7DabMGmcJbFhWSnGtk0AAeWNEzM6ACErETJYcBsA49sKsrYlXIk5lg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 02/11] t0008: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:05 -0700
Message-ID: <20260325062114.2067946-3-gitster@pobox.com>
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

A piece of script used "grep" to filter out its input purely for its
output, but of course, "grep" reports with its exit value when it
did not see any hits, which didn't mesh quite well with "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0008-ignores.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index db8bde280e..8edb08d9c2 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,7 +122,7 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
+	expect_verbose=$( echo "$expect_all" | grep -v '^::	' ) || :
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
-- 
2.53.0-886-g529cbd14ff

