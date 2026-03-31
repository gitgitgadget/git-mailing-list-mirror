Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21BA3DB624
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956423; cv=none; b=YJ0nocXubXWQnvBjkPXeT0Unw2E32gmXfGn+Sz/Y4/ovJW6qC+/97Cif0CXgifoPMwWEqkLdKmqd8CrgTUNIebcnOvOSSIlGn4x1+RrZs5/IiM2TphzpD27CNIOTUcqaXXnChBqNCnX3KjnHsKpyKoCI5QLaeSTKmyv/yGKXhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956423; c=relaxed/simple;
	bh=3ScUvSnRPkT50Rs+UkfkVqLiLLGoLnEoCFSwR2b6WCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNpJt4XbnEmu+Go98aVMFD15NLWA44JMbD43YYEEF3jrakp8j04mlcixdci39nYzv8JAubJB2JhJ/Rj5oNiss2EYO97QBAhEef1by1bVg+9Im6Dj6VP0W5b4q2jR1DYNkdwuyAw1BTKt2vvui296q2IozTAnNUH1Y/VtDaWWXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bv8J1E+f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyA2hXZ8; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bv8J1E+f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyA2hXZ8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EF894EC008B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 07:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956421;
	 x=1775042821; bh=oGrmjHcVDkRAZv67RV0DcPGUyUZZT7Grjbk0OkN5Q68=; b=
	Bv8J1E+f2WZmep2xiQ6D7AK5D8THkuheXp5i6RndRA+WJwXk4MKlbatARpCMS1tm
	k9cOSEypAj21ky1ixu4yl2s5eiVjsxL0VdJ4znNTi40aN7NisJGYJOq6Zafe+r4h
	Fs0QJiAxsVANSVM8yb5WfufLfgCDT9b5uscrjMEuSmRXLbLV70JM49CTZ7TvRXZ0
	JTAJDl5ubHxQJQxW9TSxWZKNVRGHThyUXXJxAULHb5vgqhyQ4Gb/z31F4XjmaMmx
	abybR6BPWtW2xuhFIcJOuZOkf5Hw7xA+urYFsFUdJtqivu3AclD++D8aAOICVJr9
	goccfJ3OKD9mMISiV7aDkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956421; x=
	1775042821; bh=oGrmjHcVDkRAZv67RV0DcPGUyUZZT7Grjbk0OkN5Q68=; b=l
	yA2hXZ8nj8BB8jMhkacHL0W7KhJR9ysB63+qc/H6r+rXE38WKtHpyafG+jesDpF9
	P5oG8cf9U1qm21Qm4CYbcalLyimHn0kyMPUT1uBBR4HPsCdv7LCphUloTYYJcV4h
	qm9s1KHAvdGJpeeMEEDdVBQColDUwLIjGD3iAZIV+Tu3uiTGShr3zMHhiNcekUpE
	/dMhiqOSjEMrIoFz/f/xzhYFPQOg1fqtxMD9olRZ7xF11QsYSsxR/5VnSydsrQL+
	VteWIVKgIU/DIIEGcd2k8FZkSKhpr4pPvhO+rXdcMGC08IXjXkgGp1i157Yf+bfq
	CsvStGVwfvTT7oKcGOUKA==
X-ME-Sender: <xms:ha_LabgOmY6G53VoGky_9iKtjkIFh_yGd5nZkVmd3UhUtr0wPyXOYA>
    <xme:ha_Lae-opAIsQ_X9CEMWWuYH1ftfNdeKYLPeqrc0fXkYOh2oCjTfcbed00-2nbk3T
    nrYwORIjP-vtEFyBUeOR1etauggfv01dsA3YUxpfBl_Zr-Sn3z7>
X-ME-Received: <xmr:ha_LaQsTWYrqDPdXDa2fyO8VdFDSfrKurGFCiksSPsefC93UX5kgd0LAN-J3x4jF-aw9-MKtinW05MQehMvk95XwLfxQ7V4DsBm7WItMTCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ha_LadZ-om_3GHw95mswo46GKQa7ALHB5FFvbfYEOsWVESmp-5wWWA>
    <xmx:ha_LaYo6kah9rg4C2DQnNjJE6vjicRXYkN-CmdbkC-aud0Ko4k7UMg>
    <xmx:ha_Laa_VUKWJnPzqmOI3HOea9ALdwEYZphfkyxavbFByZ17lRuUBxw>
    <xmx:ha_Laf8-udEXESwLmKNvCOn8A56lykR09ONU3SKlPdv4StDg9REuIw>
    <xmx:ha_LacgvLLir8Y-vfT40AQ0EZOpXHMJ7QabbW1CB2Sd9-TpND12_hDxV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a1a6025 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:27:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:49 +0200
Subject: [PATCH 3/6] reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-3-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

While we have the reftable-specific `REFTABLE_UNUSED` header, we
accidentally introduced a new usage of the Git-specific `UNUSED` header
into the reftable library in 9051638519 (reftable: add code to
facilitate consistency checks, 2025-10-07).

Convert the site to use `REFTABLE_UNUSED`.

Ideally, we'd move the definition of `UNUSED` into "git-compat-util.h"
so that it becomes in accessible to the reftable library. But this is
unfortunately not easily possible as "compat/mingw-posix.h" requires
this macro, and this header is included by "compat/posix.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/fsck.c b/reftable/fsck.c
index 26b9115b14..8e73fc83f2 100644
--- a/reftable/fsck.c
+++ b/reftable/fsck.c
@@ -63,7 +63,7 @@ static int table_check_name(struct reftable_table *table,
 
 static int table_checks(struct reftable_table *table,
 			reftable_fsck_report_fn report_fn,
-			reftable_fsck_verbose_fn verbose_fn UNUSED,
+			reftable_fsck_verbose_fn verbose_fn REFTABLE_UNUSED,
 			void *cb_data)
 {
 	table_check_fn table_check_fns[] = {

-- 
2.53.0.1185.g05d4b7b318.dirty

