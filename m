Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684D3E63AD
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096681; cv=none; b=osDtHuAZg19PK9CEus7EU5YmEHqMGhbmhrgigmtjZXP40gziOiZ5ZX7xvZnAtljagCnC8mMRdNMwnO/fler5H0pUWvt7IXvH7GroQemymT7RF9H0u2gGjI4KklEeKJVC9IrYxb0QygXv8mkbPqTtg0X36OFb6qX27KnL8Pm4OZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096681; c=relaxed/simple;
	bh=dddV6MnPc86un1+xHi24S80L9IYZXImNUXRxn3ijHaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9NxOlW+ZgWpXYIxk51sgl/NDoPtM1vZV4RttpeyXKAh/c2LBNTjPmPZC0My+PZ0Mrplhqp4t7MUCigBUPAN6IFl8Kz66NYL6gzHMivfSRn7dUS3PsxoY8+7kpug9wb48YIk+GMifnE9uo+Kd07hHrSgJnIhd/A2w6oYEnC5Zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vn4YjElQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PsDHwEak; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vn4YjElQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PsDHwEak"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 660571D00107;
	Mon, 18 May 2026 05:31:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096679;
	 x=1779183079; bh=s6jmm3fUNArNhXujKPVRQEMgoRoBTXSIxJ9fRBvi0YM=; b=
	Vn4YjElQVzEgBB0kzzbASx48yYsHeROldL+YEq51NkYrZ4zCsf3jHVfbH6WzUuRR
	SimNMXqa7gVIoN/S2uoOwWQbyqtVPuGkwEfE7p/kVuO2xbOqqd1YcX6qhCmOhEUK
	m3VFGnHXF0lzb++f2do6lJm1KI50wDPv07ghKtInSip+Ai/zyGJYFyG1i1UZKO+F
	IYtbdDOTFK4Z3a8rDm6UzmscyIxERJy/nnrgdg1EsHgg51Uq1rFdvtTWucm6rLps
	5HuEjjrm1FvuxSmKos+n2VSMCH+Sa9yQ69aNxqhmPtD9N3GnED5dqpggDB05RPFB
	9/UzQXXs46Mp2gqXPEls9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096679; x=
	1779183079; bh=s6jmm3fUNArNhXujKPVRQEMgoRoBTXSIxJ9fRBvi0YM=; b=P
	sDHwEakjR80Tvn4PF7nrR96Epa/iHyaFYIAPKz0aKaFjesGUAJHWUcHwo+0zDzO5
	RbpZY+apiJ0zsDsht6uKqdfo2kJ/YRLlm1ahkdGxiyqP1C1BvNaoYoDVMk+3bDEt
	yxs0alZXIELryJOA6WG6s9o07xtp2ewfAb80i9EGK74K7PMb+75HQMs9TBCfs5mp
	i1vwCBZoFe1FWBdare1SBef9Z9JU3HC5ZaRqcpdEOXS8o7zMU/IR3va3Hic2pTIA
	PMnZX6OB7MMY7Rx/0nw4Z73RS7Uk8/0fhuSojVUNjVQ7+xqnipo2tXF5mUuBg2I2
	n8PIdiVY8djdRaDNDpttA==
X-ME-Sender: <xms:Z9wKarcQ461ff8bhA2QAQvkft7UsOigPjIh6eCaICqtXQ8YKetmm-w>
    <xme:Z9wKassaeciKocu69Ehg5OVw2O8CGK-P1XO_IQU20XAI6Y-e6K7GSc7mlQjEMg0HH
    TsRIAiSyPMYSNC6jDNL9rMbnopiJWzYmJMFGUmP2hLgZWaSmMw5PQ>
X-ME-Received: <xmr:Z9wKaq_0Z2yvGBb04lMrDAmodcmQ1i224o8hMVsgnqbZR-_g0wkcC3edb333nJocrpdLx6SzJvbdtc_2fzyswoNIf_CtSnxfSAUj06CPtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:Z9wKan0lghZit2xCncredPEFCWecigHIQdTJ8PeLHW4XTCznsNIcYg>
    <xmx:Z9wKavCdUHwPsRjYaXQq45m8oQm_Afu88sQo7SOjAJxS0KRyMYJqgw>
    <xmx:Z9wKajcnsmvxhb05aHEZ_Zl9XBpg9OONIId79I0FVSl7zIvqgQJMUg>
    <xmx:Z9wKas5dO7qsFhW0mhdzdfcz0vQM8SfFGv5zjHQ07ERze8OZNKt4dQ>
    <xmx:Z9wKasALiQ_iYZiGC6JAFFEmEf28-kUNVSjHwcbEumMi7-aKMElnEg6b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db9416c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:56 +0200
Subject: [PATCH v2 05/18] setup: stop using `the_repository` in
 `path_inside_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-5-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `path_inside_repo()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 4 ++--
 setup.c        | 4 ++--
 setup.h        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0b23c41456..7ddebce2ac 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -471,8 +471,8 @@ int cmd_diff(int argc,
 		 * as a colourful "diff" replacement.
 		 */
 		if (nongit || ((argc == i + 2) &&
-			       (!path_inside_repo(prefix, argv[i]) ||
-				!path_inside_repo(prefix, argv[i + 1]))))
+			       (!path_inside_repo(the_repository, prefix, argv[i]) ||
+				!path_inside_repo(the_repository, prefix, argv[i + 1]))))
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
diff --git a/setup.c b/setup.c
index adad6ceec0..4ef6216e82 100644
--- a/setup.c
+++ b/setup.c
@@ -160,10 +160,10 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 	return r;
 }
 
-int path_inside_repo(const char *prefix, const char *path)
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(the_repository, prefix, len, NULL, path);
+	char *r = prefix_path_gently(repo, prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
diff --git a/setup.h b/setup.h
index 24034572b1..c3247d7fc8 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
-int path_inside_repo(const char *prefix, const char *path);
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);

-- 
2.54.0.771.g3ed373ac14.dirty

