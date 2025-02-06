Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F922577C
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828692; cv=none; b=X0pd+V9VwT1IG+pjmBDOwPlODu8R75CykzWbkCf6g2Ud3MvF1+0eyb4MFWE0njmUXGvLv+IrKYEZkSL9vmk4dwL6LJodH4z/Vv3IY/Bkmi1Le8gm8UXXHlPvaq2I+nnktsmfus8bPh7RvvHp4ovpa4P/Ha3WLQQCGLgZViPfagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828692; c=relaxed/simple;
	bh=SYZNrslGPTbnQzQ2s7xWwz3pdJZXubCNlhkaSbbNYcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoZnXh6Xemb3w8Kf5nPJg66lOp1A4vrYTBIaEIxeThwpSQRDpwl9sc/MKAvI2UcI1FYvYKsQUsUsJHmg2PGPJDA/r8shUjjrUP+tCJckH6gd16r/f7yLRHyRdyp6nXuTTgsCYwHxiH549/Y1RQCeuZtgB7FoTley4ub8l7V9ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aaeqZ4qz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNi2LJPf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aaeqZ4qz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNi2LJPf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD4F21140189
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828689;
	 x=1738915089; bh=+VO+Ta4wrVa+SyBu2EFT9hRTeBNJHy7MBFE6y8zrGNw=; b=
	aaeqZ4qz436bEKs4z8isSj6JdR9/BVq8/QTCli6szlr+rV44A7j/b75uMd2/Hr7u
	tNHjWtx98xjtDXLOjuCfjVpJp9OTHc4aJd+UWBiBZ00JE/IwSl/mVsrh6CD8JR8r
	/wGkI7uW3t2h19pv7FMXhBuENGBM3aYNmA4SLqi0MgUYVfL10kiJlOFnKlulGMW6
	HwU4fjanqDG2hUxK0LT1PqX7fL20ZhHhSkPQSvb1NA3F61zkjdSrnbQAxf6rqQLN
	p4HTBj1JhzeHlTNDX4LQutkp4yuyobZKJqLVOKHYo4mm/9ANrHjoq3G0fScVnx0f
	uRTC0E7iTf9Sw+CoCM0vpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828689; x=
	1738915089; bh=+VO+Ta4wrVa+SyBu2EFT9hRTeBNJHy7MBFE6y8zrGNw=; b=d
	Ni2LJPfJ51/xofY7ir3nVWPNyYI8hqFL9xUsLABzeyEVZmaLCP2AcpbvqrpOXaPy
	Mod5LJvGbqeq68woYkzYR5EPay3LyQbNBK/VDbMWTSd6xzExYlzVt0q1skbBE/I7
	5zVUBtE7xOB6AF9A+rHoOH5Hnk3BNeOgbo1RmGb1k22Szinhi/wLevbuUSTJlntu
	IQmf6oHSoSXAMxt7GQ6nD5/yn7kwHJAFSz6BSPG3r0iSdUtDwKR1nUpIxP/WFHTC
	GXgy+sQ7XeAexM7PAyDei5wy/hLW2L+1CnW/s56bNPYAQwxK5CnMYZ8nRqIJT73+
	zpo64tcK3gUX2tIJiSk7Q==
X-ME-Sender: <xms:kWukZ_MccJyRv8EMew00K-w4-C26qjKrcLIGqJeJUBOzd7rWG44CpQ>
    <xme:kWukZ5_BuAfwCV5mdd9oInZaqR_LbBvMesZfJGaeaxQazxQRgRTclgutot8dCdNI0
    gG8TSjkd2ihWAXTJA>
X-ME-Received: <xmr:kWukZ-Sik5_XKw3hFV2chJBG9KTv5JeVE7D85n4pDQ_TSjatid2bTSRHbNrf3ch19Ne9MU2jxyruNKjVTz27fMshO6u3GLQyhVAVzHE7XPjT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kWukZzufSL0lwUDcfol-BCPF9lPjj3oCz-6WNeAhTPDp8bRja53-NQ>
    <xmx:kWukZ3eSogcPYlm_9_Q7LN1kK1K45vL0Y05aL31MgQ5hz0K3TP57zQ>
    <xmx:kWukZ_3iaQjAGDs4DJGGZenk1jncUwylBRab8Sh_gconkHlhTaYamQ>
    <xmx:kWukZz-F3tBZLQwhPk7B8p8v-tjX7FFJgOaGuCu-xWV15IICMnb72Q>
    <xmx:kWukZ_E2IEU__BR3oviGFqC8pICWouUKuKA6IXs4o1JvVaOsXfKyzAc_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5926b31b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:02 +0100
Subject: [PATCH 06/16] path: drop unused `strbuf_git_path()` function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-6-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `strbuf_git_path()` function isn't used anywhere, and neither should
it grow any callers because it depends on `the_repository`. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/path.h b/path.h
index 63a8f91947..cebc93cb0a 100644
--- a/path.h
+++ b/path.h
@@ -272,19 +272,6 @@ static inline char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	return buf->buf;
 }
 
-/*
- * Construct a path into the main repository's (the_repository) git directory
- * and append it to the provided buffer `sb`.
- */
-__attribute__((format (printf, 2, 3)))
-static inline void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-{
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, sb, fmt, args);
-	va_end(args);
-}
-
 /*
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.

-- 
2.48.1.538.gc4cfc42d60.dirty

