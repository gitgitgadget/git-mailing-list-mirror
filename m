Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103613E02A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055772; cv=none; b=CR54LLHnkSVTL8Za8e3M8RGJv8z7Tvnl2ZmhCz24IQkW30sTZAUvUDSumyNzfDt1k5mFytPb5UOs6ESF9Lsgp5GCaXl1LqOr9IQ2Jn1HTYJQsI3r5nkoyFwv59W4XGe7BzAOj/k9CYgC7nOA9AiI4T5i/YtiWdEvJQCq+9PRk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055772; c=relaxed/simple;
	bh=Wf/y3MTIS4fo4joGLqOAf8316vVlOqb9RSOZtkr38O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIzlbLMiOdiAsa9IyY2FFQnzENpyu+H+9Kfbjx47fkMalY5B2fNH9VG1nKyGbUzMQDo3PoRqHdyQHPAWRaSZLIUJCGb1ul6MChEWf6RVmx43VxlwlxoPp5fuaaevroHEINA2le/CXokNybE+Drzr3zG5iEnSusXri57vX39mE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XPN0prOJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqx8wQm5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XPN0prOJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqx8wQm5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 928F61D00346;
	Fri,  1 Aug 2025 09:42:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 09:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1754055769; x=1754142169; bh=du
	ZuYkR6p+WPkNvl/u7nAtXxMZoAewrnuZTbt2HfbiI=; b=XPN0prOJf8kx3IIhPS
	kQ3Wz/xyJqZEueHEvDk70KhpdwnsNvUuC/5Wc1oczd/t9rCla/363wL0bAeCs8lQ
	036+4Y6J9IfJcSHDhB5/hw/G/FkMY9PDvMMO6bT0alt9Xo7l5HGI5WJqISX6kRdX
	RWGnq9YgAXiSlzwaoa0g7MN0vVcCJNm4UMa4ZhZ51o0moyqW/7IbDGwdcHf1FwX+
	jGLpys5t1rVv/Ng7e1x6uFWTHkGHhm8C8gp3RprVGWA/6Ff6fONOnSVIBZzRDQdx
	6dVLppVqMx70RqeJMprRpvNxckEq0qY7jQKMCbEbxsiZmadYQycr6XxV6q1qKm5P
	+HJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754055769; x=1754142169; bh=duZuYkR6p+WPkNvl/u7nAtXxMZoA
	ewrnuZTbt2HfbiI=; b=lqx8wQm5uPzF2rdYrt0ggMbO6MWkUxZWisykmsbRsezA
	FZlIa/awEsTpTV9oL2P1HUBxiSE4guvPrNRnxeo6+npPjVET583T3V8X+r2hc22d
	vBT1x1mBL7MQQxw0LcdqloAmMJpdn0E1Dx8pfAKaLzaBElMC8thYUTum5YdSDNpa
	nPJgel6qpsyb8MA6kV3t3LgmzNG2cByDfmBRZSoRSX35b+F2AlGzdKWmt060o2ar
	y2pAXqxHg23snGUDTK3T/9pjhLfF0ycAvguE1Wpd2UbHZS3FNlLW+icS8wEcWVOq
	rwt3dJsz6D54DZuL5aAN/cEiKWKMRJ6qWrXIAin3/g==
X-ME-Sender: <xms:WcSMaDDoPKmz751YfUavDa9OxpVKabfFhQeP02Fi0OZG1NcHo9JCsfg>
    <xme:WcSMaJvyEqhY_q9lO0E3thoNUvx7zVbdRBWVlFm_sE4JbNGyUPBieHC0YVcm0BsrT
    Le1xSBVBVwaZgSEFw>
X-ME-Received: <xmr:WcSMaAbXxs5OQJ3a5pWt8KuapLuCXPM6O5H1K3b3mNb3Hu4z8DZKEWMtUAsVDgE84FZ-DjTdFOipg-ai6FNlAmqm3FSbu3SIUEt4Z8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegff
    eujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:WcSMaEVvJwewlN1DtKw7J0LEsH-DpQscl7SpMDxEjhHXIrg3H_CW_w>
    <xmx:WcSMaM5J9oAnW1iFbaha8PGyJuirKZCQCg2PTJR8ZO67ZZZS_QpcNQ>
    <xmx:WcSMaHgzqbge18vqo7afocwdBM4kd_e_2YN8fYexGAHs9AUfAw9fcQ>
    <xmx:WcSMaLexutifqjqwM6aG63_KEEMWWv-XoOeCPvZtNKYIMOdiYg6mKg>
    <xmx:WcSMaNm79euC11uwPrm7g1Jp3cdutK_PL9HbpQZ8sVv3pn12Zpt8uxsr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 09:42:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: fast-import: contextualize the hardware cost
Date: Fri,  1 Aug 2025 15:42:25 +0200
Message-ID: <a9bc7547a27aab8bc2404caeb821b7f5c4c10d14.1754055658.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.1.8.gde7cc0782a7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

6e411d20440 (Initial draft of fast-import documentation., 2007-02-05)
pointed out how much time a fast-import took on some hardware with a
specific cost.  Let’s further point out that this experiment was done
in 2007.  So modern hardware should have no issues with such a repo.

Also move the parenthetical to the end now that it contains four words.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-fast-import.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index d2327842003..6f9763c11b3 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -182,7 +182,7 @@ amount of memory usage and processing time.  Assuming the frontend
 is able to keep up with fast-import and feed it a constant stream of data,
 import times for projects holding 10+ years of history and containing
 100,000+ individual commits are generally completed in just 1-2
-hours on quite modest (~$2,000 USD) hardware.
+hours on quite modest hardware (~$2,000 USD in 2007).
 
 Most bottlenecks appear to be in foreign source data access (the
 source just cannot extract revisions fast enough) or disk IO (fast-import

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
2.50.1

