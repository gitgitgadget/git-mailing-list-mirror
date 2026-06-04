Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665D3CF049
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559219; cv=none; b=CmoeGuEi6LKRHoZLf/Aw7cyrK9RpwidpMrDrWwjxJfpoMQBtUKRBzx/Pb/PMH0tDvsQ+W7Hlj2tKg7MV0+0BOPC9gRQzGb90DZ1IvXz7buo2ALvXzc1/HT7FR0tsOKR3AKClJCNnZl2NUwWyQcbleOCMNgoQ5gRfvo0opIwv4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559219; c=relaxed/simple;
	bh=R6h/NXnLq12MVnS0Iybjboa0d3umxvy4u0/mVB0OtgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNDYmG+ZXYJtMm+Dx65pRRoer7cOevCCUNkOpmdg0C24BnpgCtBOsyu21M7AK4No5t0tWv6CNc3yjzDJMvuolNhqhjJBxK0c6r5p+J8VucXsVQ7aUrrttVpsZ49itj7LNS3wLBc1aPDFgmQAH+oWPQWEUbwRihS3hp28XYa1HYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/Yh7REd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fH/fHbTb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/Yh7REd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fH/fHbTb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 746D91400077;
	Thu,  4 Jun 2026 03:46:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 03:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780559217;
	 x=1780645617; bh=r8D2n9VCzbHvziNAy7SbI8nACq+labSRgwkFZzotwtE=; b=
	T/Yh7REdsn04lFOJEwhbqPBx3h7hW/n7arEkTsu9pn0QaEhXPz5C7UFLdqjgjJi/
	wn/I132H2ZKu2c3gaZGZqRYfMG+QUHaeJGlaqG/Z7hpjexING6m0hChE/EnWqFxh
	Kqz04zV54ojH3LnnpvgVKOkG5D50YlSQSbiGeTiEABU5rTQxV6ohZO8chaJ7Hmm0
	BCXptiGsa1XkChkBrQmevsP65TzqXKCs3d7sFuKxS+/S0sZnZqS0SYEk6o3KUWke
	5m68trH14deLWbqV14EMRgREpgioPOtx7NyhmY6ULomKE8tSlHuSHgpyoOjufCKm
	zD0lwkdsTFonRzb+ff0p+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780559217; x=
	1780645617; bh=r8D2n9VCzbHvziNAy7SbI8nACq+labSRgwkFZzotwtE=; b=f
	H/fHbTbN5hOwGe31U4ikTaxQbCsE1tSl9W7dsL3lcxO8CLXYES9dKAeS2gCVc0Ro
	ZGlh+sTnueRA2lEHtowBg1c0l7hLw5WclgaGHu6ic9it0JpxfrCBCAMnoahHYCc2
	tfbUMEQN5V/hxgr00ZfBOJIa7aPshjkByP0R7+3hNXQqy9auDu070MXKC3/JVNmp
	dIjo/lzrMOdxPJltztjCkaQgdDvFPfQDBSDCmUeppY0WuCKazA+hfmPtDDTsMcbJ
	2tQDImG78w939ZyLzOchQMJF2HHXioPHbk3FsfqP/0Vv5gQP/lmhQFa+G1FTTk7Y
	ktxkiDa8Y/Ffs+HW+cpWw==
X-ME-Sender: <xms:cS0hahLw2DIhbJyC7AEH45iuvJEdphnovI2JnQ1WZf0beyfuR-zivw>
    <xme:cS0hakIk1d0LNiHTR1qJ7DFCSD8I0UFCO1PC0oSApgcXaH-50b1f1J4ADZA_83a5G
    fhpxdwS7NzFpcatvetXD2hkLc_GjYNEATsW8Z_usvuVaXrqo_d2rw>
X-ME-Received: <xmr:cS0hauvJFQkD1Id1fTL3XOGbSLebWDZmGYGxUXZZxp4Gs6dxK_tza7gMQHbwh5zHLbwDIK0Ff4zMQFZWE1dga7ZmDS8kvO4LZc072MW0NFQ>
X-ME-Proxy-Cause: dmFkZTFc6qMdt2DXZLfilMB7NjsO2g6IYSOfHzy47vlcNsTT25Ss7MrjHqqJY3eKOJM0Gw
    xcO8nuUw4Gi6Aq7ALiUoR0P6VEfKArbKDqWPEZxxJ40oxq4j+CyeGEoFCzA2A7IS7zA3Zb
    Lk12HrJCmDFU/NQq0+6uxTIc5ybb+BfH+v8Td/nrY2/ryPtn9LrrpDnBHO5ly7SILMCJuY
    bI3eVEq3TPBhUlQfQKcX7D7j4xS1omxxmFa6Riyp0OqnTGMJ1ucyIxbTPKUexJ33zrcWsQ
    728+U/QsudXZ7zS24ytQIntDlXUXQecxKjxgUEXUiDBYyVNPrrIk0Eg7ejoSOQvhumwaer
    h191B8Obe6Cua0qMSZLcfp+db4MwQtzVEQk2rz4p/K7O/OapqTtFdnItjjoYhL+z4ha5Iv
    FIHzai6hOM9KTO3C0hmtrpSrPVF48Enx3KeyUmtTldBSePGBPPl0PiT5c2r52JeDCQUT5k
    wLTCUjWQuRfN0htoUt4YeGn6i+cZ2+Ohzyrxbj8z/sdWMRoxEL7HI1pqGxSJKzlHE1gChS
    LBgfo/WbHsRfiUZT0HDm9xh6li8IKKs4vynzRp9XIAQVazH02Lgakqnz66zRKzt+U0ANyc
    yhIWdMNBIkuTncb1RNGKCwjRXqZJVdAozK6tVEGssIy/k8BQY+uSIpbZfQCA
X-ME-Proxy: <xmx:cS0hahQpdDnhDsiefS3PbwBnG4C16R4Zl69qM1FgYHbv6em4to-4pg>
    <xmx:cS0hakOrDrd1oRhmG1-M9H7ve8B_gsYSfRLspOVajIw-pvrkXnN66Q>
    <xmx:cS0hamZrd2nXzV1bVLSIxpdRfeinyZhS6aJ-21aNzZqOJZ-x-gYZHg>
    <xmx:cS0hauxxSTAr6SXRBa8WonK6E6B5o3xqaWuJOPAz3s73JnxTQ3mpoQ>
    <xmx:cS0hauNjVXqKWszs2AGZv_n9VAu-ULYm-S7ccNcohZcQSbk8h2q5Hbui>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 03:46:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c5736bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 07:46:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 09:46:31 +0200
Subject: [PATCH v3 7/8] repository: stop reading loose object map twice on
 repo init
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-b4-pks-setup-centralize-odb-creation-v3-7-0691834f318a@pks.im>
References: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
In-Reply-To: <20260604-b4-pks-setup-centralize-odb-creation-v3-0-0691834f318a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1064.gd145956f57.dirty

