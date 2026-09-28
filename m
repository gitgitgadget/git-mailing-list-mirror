Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DED495AF1
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589117; cv=none; b=iE49h0WSXb+Z85aM+M6vo7kXR7ape6X1Ot3SKFTsw2BylCRz00ReeAQH1JgNyJ/OwjzPCqXiGciTLAM8+eJhYcj6ew5fpU1K6CR4FFOTnlzo5ep+/YYUGuW4txkN+AIMG2P6UrSg1KqM3nO55tTecOeJzWifpge+UxXNxvRxIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589117; c=relaxed/simple;
	bh=jd0Mrct8o375cWw6SCIJI9k3Wf3zSYqq8bETMpEw5c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGiKBSMYAezHtuBdhY4AJCuWPyaIBQcyBeEu2Xz5df6BkkrQxQNgI9Zpe74KtawI8OZNgCQ+HhEdIjwrFC2n5YJQNQEQwwOtXQHuvRdibrgdPQo0FjsmWqdYrlzlrcvRRGvsFHzDgXTBiLUBslR2eA9vO0eaQUP1yWbjxp/s+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jMKrnD0c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yMFxjsxT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jMKrnD0c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yMFxjsxT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26EFA1400031;
	Mon, 28 Sep 2026 05:51:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 05:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589115;
	 x=1790675515; bh=McZ7kRVt8TEH3TZweFbM5KOot393HAUfnMmrT2hvgcg=; b=
	jMKrnD0cLpG40LE41vo4tdW7AQn23R3SCY8IuUvCdd6rfBm//2svg6B1t7Um/dfS
	audgHpyLxoqZW52poN41409ZWivxA3mHSRsmsJoeBX+cA+f349krAAshhxxGRFJd
	MLCOu4X7mhMMyukYgi+WX3IIzA5wyBh5jdLOu/5i6KhqkwTPJt6n0WyzDXCfPAn1
	CAT9pvw0K85tU8JRUza/7G7Wz3Zd0BL03pcauv8VlVPj55ML1r11s2lavP5dc7dZ
	ordVLxJ2v+j9IWKCqRQeJS5WxElKVEhCsPcZRcldyNReq/wrIB1xlyT8Nuq3hOkw
	2v478blVyOJqFAT5BqBMSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589115; x=
	1790675515; bh=McZ7kRVt8TEH3TZweFbM5KOot393HAUfnMmrT2hvgcg=; b=y
	MFxjsxTINkNPCbcrf1MSfrzi/dbpuin/wLJbVUJk17XuJZBxUjNDB4yQqov4Lzvh
	JHCKbDIw7kB9DSLrJ438IT3GlYuajQB/Kk3y+y3+5gDTmdZAz1D4YTTM6xE032mT
	LDZxp9d6G0rrQRgPoF5F6pzY0ZiZevtkqoTdQ/DhNdaQkUqMHMPgk000bRY3DsCI
	qD7ocoRQVy+A7HmzLzYEOfB16cfd3w14b1J5JfbJ/SLLN25M5bt9PefuIhCwyUkj
	3jObrd7ECu56ZYWDktL+WdecqDtkVggvTQKlUsJwtB/IdOlo8jSXg1H2Wrjqs+Bj
	A+JDpuzci0xLBK3VmmUNA==
X-ME-Sender: <xms:uzi6aq8kOO4RxWD_NONkVnKHNtTMvG_aI9AdAZaJ-4UmgDUAt__YLQ>
    <xme:uzi6aiLQAiQ-ivgyJn5z3OwGiC0dRNGY0SErGR4INRaob1LP6SQaE8tlPdDO0MnC4
    oBG41w1HdM23WQ6EAYQ_LDcsWT9yE3f_xpxwfjvl97E87NYWJE7ftQ>
X-ME-Received: <xmr:uzi6atYyB2xqUEdSwjOYv9NSwRzJKd4p8SItldGTAcsCoftxk67h-g>
X-ME-Proxy-Cause: dmFkZTEzwua939MPjfHBE1wDzO8xjZg2/yc11b7eH9knRSMSy3otZxfqPq1o9kPptgO/IJ
    M+KDKNCUAPNJijVCtyekkXAryATCvKHFxG8UKuA21Trqnx6osXO+pD0sDdYaTW1YZpm30V
    hNdVvSIdLDNsCdMloqy+Y+ITrcL+9rYu+D03m07d8y/DKxLBlyRRSKVVyr7EqQN1LMEXct
    asqMRCcvpr4//PIrpsKAbvTUbtsN6SF36j4ebafOURZn1cDyCVE4zpnc007fGUEwaa4HRg
    8bFxl8yF8pHwjevaXcsiG3TZKAkkEKw9L1DFRLvaC/2aaF8nf9kO3ggKA5qUEZLCJjQrSw
    d6lNhR2aGsAUQgTS64AVlHhMiuDdijqvfn/FIbHQ6yUhhWO/2BAELCvz/S8tbjRT775Za2
    yFjie7J5G4yTzfs6bfJ9kmBIhNVnQtkVysmkILWoS8NhQQt4dWlEl16/u8pga/3Te/7iN2
    THHVKSe1Pcd2BbqUSkcOjB43dnTI7VVqYdt8nVCCz3W/O2mmWJIsoqSwCn00P1lulM7Y9s
    mDk/XBz4ycYqkE9YUjZTGB4OkBb3CgLV20Om5CNzWNFVM7I/jFMl5gwcCfY+fGZTn/u0JJ
    gJBCqPv+EOENcfDnjZ1tDSPxrgi3dlpOyOBwDeXV/5CAxlqbJ7ogiqvCDZ8w
X-ME-Proxy: <xmx:uzi6asJsz9D43Vxi8VBCti7Ml5L1C8KdqPu77SkxOBv-bER9QQMMPg>
    <xmx:uzi6ajAWQS2Hx7o6iP4bWEotdf8mfk4t3bhrUxr8B36KbT7OcqAUMA>
    <xmx:uzi6apoTd92gdXizlH7podOiRuW4ToRuzLu1OJzqX2q0kQXecmqttA>
    <xmx:uzi6ami-GlOLxx-g3XxLtB3IaH_XX4uBG1mf6pV9tqAJfZjFFoy4CQ>
    <xmx:uzi6aola29SXee2aGgH6Zj4-CUJmQkUVHvB3916iXPnoXv2H9AN7eMTZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c31e542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:04 +0200
Subject: [PATCH v2 3/7] builtin/init: refactor messy creation of leading
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-3-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When creating a new repository via git-init(1) we potentially have to
create any leading directories via `safe_create_leading_directories()`.
This function optionally knows to handle "core.sharedRepository" to
adjust the permissions of the created directories.

The value of that setting is taken from the passed-in repository. When
creating a new repository we don't want to honor it though, so we
painstakingly:

  1. Save the current value of that setting.

  2. Set it to 0.

  3. Create the directory with `safe_create_leading_directories()`. This
     has the effect that `adjust_shared_perm()` will exit early and not
     adjust permissions.

  4. Restore the old value.

This is extremely awkward, but it achieves the desired effect that we
ignore the configuration. There's a significantly easier way to achieve
this though: we can just call the `_no_share()` variant, whose entire
purpose it is to ignore "core.sharedRepository".

Refactor the code to use that variant accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/init-db.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 5c22eae2f3..e45268f1ff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -131,15 +131,7 @@ int cmd_init_db(int argc,
 	retry:
 		if (chdir(argv[0]) < 0) {
 			if (!mkdir_tried) {
-				int saved;
-				/*
-				 * At this point we haven't read any configuration,
-				 * and we know shared_repository should always be 0;
-				 * but just in case we play safe.
-				 */
-				saved = repo_settings_get_shared_repository(the_repository);
-				repo_settings_set_shared_repository(the_repository, 0);
-				switch (safe_create_leading_directories_const(the_repository, argv[0])) {
+				switch (safe_create_leading_directories_no_share_const(argv[0])) {
 				case SCLD_OK:
 				case SCLD_PERMS:
 					break;
@@ -150,7 +142,7 @@ int cmd_init_db(int argc,
 					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
-				repo_settings_set_shared_repository(the_repository, saved);
+
 				if (mkdir(argv[0], 0777) < 0)
 					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried = 1;

-- 
2.56.0.rc2.329.gd58861e689.dirty

