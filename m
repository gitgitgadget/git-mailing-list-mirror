Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E532B108
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103447; cv=none; b=NM/+lUDNj9F+yp/DBKu6OtHLir91CqkNWXWvp4xZXombGtbnv5PjayKZX5wn75b3Kn0wFCs+HqOjV3EUgfxsEomgoOiIW8f4IywdggcB7U1i9t9LLefLVfVqlT6LU1c9y2AsrWZ2CGK/Q2DITNtnDyq0P1UoHmJNx0wTODuCf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103447; c=relaxed/simple;
	bh=cf7BTnj4nFloLmSfzb2DDOuLkgyJ+ID1M4GDbkSzFTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyHCHZYojiBQd3/brBitPPbK4GGcTrKTRpnuBk8HY4ZS0P3HwObv3lkXJhmRL6oCTFcyvc+lvH3D3958/SwxMajiVKMGVBrpyKXR3w58MJX5zVcSSz0Ni3VDObu4GkBAblGv+F/G4+Wqcu7mczDXCpNWaGAq3MSS0X4QPx00yN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T4JBRxdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jy41F4Rx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T4JBRxdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jy41F4Rx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08EBB1400133;
	Wed, 10 Jun 2026 10:57:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103445;
	 x=1781189845; bh=tFeS9MELuVYsnFVbUvwN280U10oe4dRHxAthjr1i9ZQ=; b=
	T4JBRxdqMbwjsSt3ajX0tE34+qMb3GSiCJognEYW2+4OMthXj01TNF7GG+IYsrxk
	p82CdX1Y2iD8Bo9rui4EBiiP0JSGV7+3ZQBqoWZhC7PgFE/SXpWhsGK2CuojFvsk
	J/TWv4m0UeEwXK9zsUmC2txcUf76OUkbJPmStCKNCUWNr3CTzddFyMj6/p3g3Igm
	W0tXf7XaEqI/20OP2D1CxQMWZxyIPus8bluMLPWmrceTeSE/Sagwv9uCwZRE6NLQ
	0JbNO4HXkuJDuNHE/Yq6m3SBTvhqfXr+V43mcnPKYQCKAh4Sx3Ham6yA1sGnvy8X
	pbwbykBxuwKpWYBB8boaLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103445; x=
	1781189845; bh=tFeS9MELuVYsnFVbUvwN280U10oe4dRHxAthjr1i9ZQ=; b=J
	y41F4Rx5ZmrbgetO/AqZgNuj+cKkNzGCAzRs8BdfAFy9nH2Cwy73TC9PaKcyqIWe
	BpHp3f7SNl7e+71SqGl68YeJMTZyRn5ks/AND8d3JBlYvCsWGE2J3w8fzjkrBfHo
	HSSa4yg43aDjeq61TbB89KFXA5TgwpG8ALGRN+0YlNgxG6lUlgo+1E+IXN9f4/hg
	VlnINj6NkzZssyW7OsjILpTwzzcPCFno+syObN9FTcDY2bo1CYRAB7Du1BQb3Mum
	8FQzFYNO7QIV/NKoQL9+BWZQT/UI4oj81Hw4bt03nG2GyFdOa/4pWv/c/lLOpGrm
	WdANLI++/9dmmVZQdTrzw==
X-ME-Sender: <xms:VHspakUG7waZCdzT__zYehLvUHP1e33ad4xN3D4toEmAw7oCDVL9-Q>
    <xme:VHspaulIlykGXxDZ2gU3o-__YSvVP30BahjKH-T-eBDU28AitXAAc-n2zIxGYpnvL
    7L30TCgrXjCgOGRJfSWnh4UTDWcezg8AJcpa7WUi-RJPqgQc4Blsz8>
X-ME-Received: <xmr:VHspamBXABqHs9rHu5zvaMkezGDOgC0IZ83V4lDjb_-bZ-tN0qFNUIKyE62DnmVNBYNw2_SBTYrvoO_lsTqjTYUhDCjncYgXvDcCOZuoKQ>
X-ME-Proxy-Cause: dmFkZTEJn+HOU7rfleF8wtEqd8n463JF/vFO1XgyixYBoTlaS7cpi00RU70QgROPWwUdI8
    Y2g43EXoqSDarANLeg/qY2LquMRGd0tg55WNrjpoPOxekNmdm0CiNmfLlAe8VSeyDVX037
    1j6uyoB+HxekonkoUDl50g7yk3LRnYScK6sStb5pBzwl/bteJm6VFNzksB07RoD4dmcJZY
    VdiIKVbEs3XzVwXK7AqTzvu/5bPY1eoMkecDU5MTuqJ0bbzDKf6zfqc/3gVc1Tt/VrPF+4
    ykKleLBBcmf2l0TF3giI6aolK2tMnS7lvcFPqLcY2GjwARLogkLqndIPr0EeRum5dexwGS
    8DCqWaXzE8hH/rBr0o8f4kCF0s4ilmzw9zKr/E9hvJLTdvmbAcouTEctnTx3/AGfU3kX51
    ejKs8ehi66+zqdnCFp6fif1IO3TILYATb1KPcDJ5W7wRhpDM8cdUS40eoHEJwdMnwSl3ui
    5ZRajI1Tp7oZYZIO9SjljizjVIj2X2HyT4JW7vHeBEud1dFgLjmeFwP2rSKubwJRxcnYZq
    m7y16EUA6TjOOGGrgHjO7WRQHenjQemFwtkO6YaYYZN868SvRcwuvxqW1SLza1mqxZ5vdn
    Cv7IJrRrOSK0KoxgZ6Att4qVL/JLjl7l6EboB/GAz0AyKc0sphi12obGi3WA
X-ME-Proxy: <xmx:VHspaue8_1RWvswBSRXhv4ez28AhokL8puniUp2cIGBNu-Gmz4QTwQ>
    <xmx:VHspahJ2VVX8PQFFAB32m53DtUONWy62pZqn8NIUnuRCihw3gtAlEw>
    <xmx:VHspahddpy_RggF07p3S1DuhKh9Foh-sNtX3N5RAeJZF5gwIKrKC9w>
    <xmx:VHspao3_rUYCBerxBiahcSAv4xMU_u0DB-ee1w3rin63xm04ypw7tw>
    <xmx:VXspapEdxr9apeC841Bg1Nuq7joqecIf2FQIVEDI3hMzuSZxvBjPou8F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ae54d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:07 +0200
Subject: [PATCH 1/9] setup: inline `check_and_apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-1-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

We have two callsites of `check_and_apply_repository_format()`. In a
subsequent commit we'll want to adapt one of those callsites to change
the order in which we read and apply the repository format, at which
point the helper function will not really be a good fit for us anymore.

Inline the function to both of the callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/setup.c b/setup.c
index b4652651df..a9db1f2c23 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,32 +1788,6 @@ int apply_repository_format(struct repository *repo,
 	return 0;
 }
 
-/*
- * Check the repository format version in the path found in repo_get_git_dir(repo),
- * and die if it is a version we don't understand. Generally one would
- * set_git_dir() before calling this, and use it only for "are we in a valid
- * repo?".
- *
- * If successful and fmt is not NULL, fill fmt with data.
- */
-static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt,
-					      enum apply_repository_format_flags flags)
-{
-	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strbuf err = STRBUF_INIT;
-
-	if (!fmt)
-		fmt = &repo_fmt;
-
-	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, flags, &err) < 0)
-		die("%s", err.buf);
-	startup_info->have_repository = 1;
-
-	clear_repository_format(&repo_fmt);
-}
-
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
@@ -1887,9 +1861,17 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
+		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
+		struct strbuf err = STRBUF_INIT;
+
 		set_git_dir(repo, ".", 0);
-		check_and_apply_repository_format(repo, NULL,
-						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
+		check_repository_format_gently(".", &fmt, NULL);
+		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+			die("%s", err.buf);
+		startup_info->have_repository = 1;
+
+		clear_repository_format(&fmt);
+		strbuf_release(&err);
 		return path;
 	}
 
@@ -2820,6 +2802,7 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+	struct strbuf err = STRBUF_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2846,9 +2829,10 @@ int init_db(struct repository *repo,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt,
-					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
-
+	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+		die("%s", err.buf);
+	startup_info->have_repository = 1;
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
@@ -2904,6 +2888,7 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
+	strbuf_release(&err);
 	free(original_git_dir);
 	return 0;
 }

-- 
2.54.0.1189.g8c84645362.dirty

