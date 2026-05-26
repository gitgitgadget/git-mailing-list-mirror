Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23683BFAD5
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775045; cv=none; b=AiQvQkXQFeq1MdHFS92X0Cnsh1SbGgRNuCCiYQkZVpBJ6Fd5kYprfafpTsNiovtqWoC7tO1tblaK54lab1oS+pW1fe24g4o52dUN69fPZXdCsXTpcRy1JCKGs8PV3Gp74mVFcjuTu+rMsnU8Xp6UAqGSQNrQXdomlr8WVNdGpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775045; c=relaxed/simple;
	bh=FT9yDQK+8rLqmTUmW9MxWCayGoUIB4V/SW8q4ffo0/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooqgVQ9EsNC7XYWHyNKH07JvjtF/SjRgKdJlJor++9Xe+HJZGM4TOoPZahXGt9my51iUOrb8skUQe7o3q5LyyBh6U+rY5GJldzUPG6rgqR5fHYrV32kIBM7M7IgwkyB5tFD/Q8uevSlBD4Z9PFv1JOQ6uS1xjcax0c8EGpc9ksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c7oy/Dgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ma5Uyo8U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c7oy/Dgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ma5Uyo8U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C3827A0154;
	Tue, 26 May 2026 01:57:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 26 May 2026 01:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775040;
	 x=1779861440; bh=tU0h4MwSbAADlglVpjgh4pP5B9zXNcquI2cs2opfi+g=; b=
	c7oy/DggbVyPVVccyhjpeIUIgV9ASULmOYa977s9ZUIBNDcIPyHEHrZW/4I+uqxv
	C3W65QsMyxIRoS7K2+nRGMF9UcuKrYYfqaVUq+7OGbCvseJhWhTVb0Q02Vmklgen
	J3WDihOfiMO76BxPBZhVM/qLvSjlLtlqbrpngEGi0IRl98f5vRl0bFxbMGW7pO3n
	JnsG+YxEumGFcFr+30vEYC3nL0cY7kf58SiscZtuYMIA6IY46nwRJSsOHFiJLx3q
	KY5rX64QS5Y8RRH0CCw7AtppKd/V5QKnwvZaZcndf3fU+JsGmOqKfja+C8CPT3Cj
	99MG93v7CvwtlUdrvagHGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775040; x=
	1779861440; bh=tU0h4MwSbAADlglVpjgh4pP5B9zXNcquI2cs2opfi+g=; b=M
	a5Uyo8UwOqSMeXT0J1KdSzcda6d7xMMHgWS2fcqsFaN5S/LZi3hH0TDxyKqk8jSQ
	iL3xTaI62bfpM1mLW41uRjmmMpR3ez1iBisLSHloMSdoNCVlR66KyVvjkqkqwjv0
	Cm31GeFnR7WyXin+AtnmXqzOsrK/WgAccBgWGh+JhISn6vD20oJNNFPkFL3SU56c
	pMom8Re3G8BfNm0h8M1ulTccyA0RsBTVsC2hS+eLJ5dcsgfMOLPwIkENLmBfBxgk
	fbG1FzYRM/3kQOJjVKfetdGTPFAwmO2KhCewXLTMs4LqL4jEPwYUBTCm9sVAoUF2
	Sv2+Mlmdl4qNoDGGVGPAg==
X-ME-Sender: <xms:QDYVakGdOPSk54uxc6zd4UH3D_edBpv_RLNXN9DrN5AS356okgMZ8Q>
    <xme:QDYVakxSIeHxhUEoT5dcggrywcOTplxjmlg8ogDOG_FdjYnh6WLu4Fhjj_3CrGzH1
    9DgQs9qD06gcYRxEj67uG0nu4FAzDEelBOg1VE2t2utI4q1C21Om_Y>
X-ME-Received: <xmr:QDYVarharsWRRwgpEDal_cDpfYEmlQc8f99yAsmFX3lgNi3wobG_qOW2N9QCaq7gkMwRQFjdwUtxpHvv2avbnS7kgamLCOSJVOU1tM8wLw>
X-ME-Proxy-Cause: dmFkZTEQDHL1CESZtN5biKIN346oC66kElTJ9EKaKlCB+kqoehOAe0cs4v8SmVdrCZuMOc
    /p7Fmc6yNGG8zffxKJqFcgM/eihw9ujgrbrPxc8Ui6JC7gaa/Eo5dEsCimcCDX/sQ5ZB/s
    kf9b02m3L6w76A/1r1+0PbuqyAxMI7bA9MHqP5HqFFSXteaS+ApqQqJrOaZZVHYlY4472N
    eT7ukn1zKgMTfoU4/zjFR18uWBxi7sJ2B7wyA6HohVBf8XOLWffdwO+ZzZnuMy46abSu2q
    lAMfbD+LwBrwI8ESMYObKDf0RONpUuEt9511ybjUIVsVDCRGsJ31co5sE8pZ+uo5yeJilL
    TgwFmmkicX7JG+3YiXKBIZJnWK68fJyHStEXdkgDL5ThXpgmX6/zUK5eIKYGHD2SQONP+c
    DXREPGIGAt3NsBNdk3daKx7GA6OFwwPStuKCd18GY1XY19175RlPjdlem3081aRkN23Gpb
    11avH7yDPSqnthGY/e+Yc+57wnh0IEnc9Eg0b4kcL4ABpngSjxBeGSx+2lrxnL1JRRTNvh
    M+gOfy9UvXUcwoFEVlVBW/K+d1+v6MlxkZsrBTP1Seoyy3hoTXz6b/JHkP03/RlXQVZtER
    v/SP6bbEMVAcPU3G4CrABHAZQxqOMgV8QW62BDusBQ9oYAr18GTf3jEtH72Q
X-ME-Proxy: <xmx:QDYVavxzKOsHzZ89_qyKm0QnB_eSRjg86w2ziZg58p33yPqY16R4tw>
    <xmx:QDYVauJFH1dUX8-cNy_4JzEntzwKKxIvf5DyQb3jKIZlI3Fgx-sahA>
    <xmx:QDYVamROA6Tc1iW8cVQLmnVLcg2PyFWrkmukmubr9NxwXP4t6QKr7Q>
    <xmx:QDYVampC2Tf6s0ezCkHWiM4ZDPjp5C1HBL48QvIr9rbK2uekfTc_VQ>
    <xmx:QDYVak7Wz9i0yUtyUtrTAui0JzRGCsjbITRrbPKFb80ncBW3spKPzgMD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b5bde2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:57:02 +0200
Subject: [PATCH v2 7/8] repository: stop reading loose object map twice on
 repo init
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-7-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When initializing a repository via `repo_init()` we end up reading the
loose object map twice:

  - `apply_repository_format()` calls `repo_set_compat_hash_algo()`,
    which in turn calls `repo_read_loose_object_map()` if we have a
    compatibility hash configured.

  - `repo_init()` calls `repo_read_loose_object_map()` directly a second
    time.

Drop the second read of the loose object map in `repo_init()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/repository.c b/repository.c
index 2c2395105f..61dfbb8be6 100644
--- a/repository.c
+++ b/repository.c
@@ -301,9 +301,6 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
-	if (repo->compat_hash_algo)
-		repo_read_loose_object_map(repo);
-
 	clear_repository_format(&format);
 	strbuf_release(&err);
 	return 0;

-- 
2.54.0.926.g75ba10bac6.dirty

