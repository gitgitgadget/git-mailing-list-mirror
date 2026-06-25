Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25A37F00D
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379215; cv=none; b=lGX2za0bFggA5GtV3ZzQi0gCVWIFJfG2XpzHN6uc6KtpWxlLyiGKeTSjUkVHe++pF+ddManRBlfDbJFZIcZ354odA4v5j/ut21sujY3fJwnA+X0+RROn2GTZ4mMLNiFxBEUZL+WVNjaon8SZgcTSDLm6moiu+q7npJL7hwW1eUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379215; c=relaxed/simple;
	bh=58YVJWT9UI8kFDdUXcQJJtdE7U+/Aj1ZmzZWBeydFbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFPqa4JOl7Fnx11VYFBJGpsRF4NKGRsZoNIyvzbMMz1uYB3v+HoX6x64Nv3QGvxrMqd1zyCzQJSl/YZ2ScEQBcYUSJmWN9xm/XeztnfMf9dafLX/k21wu31dfrem6pDSn/XThICYBrkBTTSR0PTfPErMi/j6AcUSJ/o3m0vGG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IPhzrlRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgK7eGva; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IPhzrlRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgK7eGva"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12F607A0150;
	Thu, 25 Jun 2026 05:20:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 05:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379213;
	 x=1782465613; bh=CTRf5nrb36Pf8fnz9MxgWTc9+bZ4tr2L/6FfBPB20Y0=; b=
	IPhzrlRw6kz9GinHW+tLPVHa3Ej0BD/slXR60CNU582hhbjIzBfk/hmgK7b5P0dQ
	dzp9pj28SOnhZWc0PGLB+hOciDf3a4TWzRGYV6gyXx7Rf5EBvpj7Hg96Og0OzfoH
	a2RTi4wBnHxtR/CxIVNoaqdnbbAwy1aqQeOupBCyrSaqeQd/AB6RTLOa7mxmEw+S
	Up68uRlZ82eo1LfIb82B2qZSKeBfqEjGmnDWSMKJTjfpfO08txVkhMwXRDD8w/ui
	le22/GHT2DQOilfhGaoTskVr6haGeYocrKU5iwkjwwji0rxI8IZTuYKH+1tYflWt
	WRfD4qZk8sGBluh022QgWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379213; x=
	1782465613; bh=CTRf5nrb36Pf8fnz9MxgWTc9+bZ4tr2L/6FfBPB20Y0=; b=l
	gK7eGvaplcpqXOHnIBK0ktQU7q7XxViGYrhCe+BEFgXTGVgGq9kmPgXVRIBVc7Zn
	1+Ga7JMWl50RIbjVGomBNUHbrV+qFDBQQyGI1lY3ZzutP2Bjzt7nJkXkh6N78qe5
	nB/LNwHV/JE6lE+Tp4FY12eJx1Ak28Y4IhXoNgp6G8QZOfqFnEmhCaMb8XhKturB
	3ONM8Rrd4qT6HAY7Dl/lT0Me4wycL2ocSlPBqJBggKdWLDZjj0Wxgt5CHqXp523l
	4qmxzvS9Ws3NKCVvQ4H5t/mofy0DOQ0hpwPWWjGMuxGIAbZoAiS5Ev2SQlpSZAgE
	8W64aklu+E/n/VLK/Fw3w==
X-ME-Sender: <xms:zfI8al3g5JtCvoNeU2-8w4lAtVtNoGilEkt1Fg5UvW_GH2Uixj7qfQ>
    <xme:zfI8ajHW8eDY1R6s1Of9hv4tIS8GCLWphif3EB1MvDAY7vTm0t4S9h4Zkkl3DWh_H
    vAjcxelfs2kuoCmBpOtn_vhF5kATuO5sRlyc2aZYeWoKKsEnqLbHw>
X-ME-Received: <xmr:zfI8aq5Gfm73zx-wEgvhbZSLtCPm-FYjtizhweS6LkAs9QgRKCDxsK04XoqSXFQ213EPXZ436cOBIySjlMIV-NYhPK71PPFEfkw7tlldug>
X-ME-Proxy-Cause: dmFkZTGMHA1OEOFl0e4hEURh9ZN4vsd5q1bhsCQ9u+P05s4JDAeY/wb4NOegEhe1Ptkerz
    l6XDzTpo9rCChOz+94AHfHMeTR/Fq2vGULThLBxvLZoVsRCa/vDoE8G/d7A4FIhZi+GeRd
    vw+2RZrD4Jlt5zROZY9cmhpPItfcI8yNiNl3SkR+RiapoupgTT7yFODOYfJD10FkKTnxuX
    SwFeaZB6F2gBY0sRtYYGbWJbaopXLX88L4XljBFLOFSrZvwrvInbc64oU2JzH1Fjx5hBKx
    34pRgjNn/TpL5lg6DnRLGIuhV/r8sq1NIoGqfFwPosUNm+J/ixcsbK511ozn+gm5MdenhI
    KxoT/zJ0WdI9oFgDsUmu8ECB+sEVmesmzGLm9UngCgWk/7RxSk6vgJv8Wrz0n+LtP4xS6s
    bPUCHIU97gt7A8kW5xAUkRP1sR9XbkF6qjLaQznFqfUmHdS5LCubLnLcOcb0sCvvz+KxEK
    rG3AebCGznwPtSF4dML2B3D9wIsjPb906rF8sybXNMftwWhBdRKWIrsZ64zmcPnrUkht/X
    X43m+BTv9xqrwMyU1G9tnrm157TSQ9S4BkQ+NcQqZjWyqAA4D85lUd5MHfzF9AxpvVA1/W
    c9OYltRqzsimkCWUoOSRuxJbK9/c6QRdCHaspC8jNVoLQ2nUDzi5Znui9a2Q
X-ME-Proxy: <xmx:zfI8aht6zGQzXXlyFOgXAfy3xFD3eU9R2k4dZFIo3Mey6dZRNrmVaA>
    <xmx:zfI8aj516Uid77sS9b43MXjcy-aaUlsojZMyTCsWnGh4R663H9WXrA>
    <xmx:zfI8akXtevKYv1_s-NXmqookP8un4zOYrE82wYqW1hWEL6zP5De-Nw>
    <xmx:zfI8at8XCslKe_d_1egMdvONAHrLkkRw2fEazO07W3tyRlru44gdrA>
    <xmx:zfI8ap9dtyjUrlWgLVnOgepJ8U2X4vj58_-Bwx1LTgEK86bLPeO7VadO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5ab48b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:00 +0200
Subject: [PATCH v6 02/11] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-2-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When discovering the repository in "setup.c" we apply the final
repository format multiple times:

  - Once via `repository_format_configure()`, where we apply the hash
    algorithm and ref storage format to both `struct repository_format`
    and `struct repository`.

  - And once via `apply_repository_format()`, where we apply these two
    settings from `struct repository_format` to `struct repository`.

With the current flow both of these are in fact necessary. But this is
only because we call `repository_format_configure()` after we have
called `apply_repository_format()`. Consequently, if we only changed the
repository format in `repository_format_configure()` it would never
propagate to the repository.

Refactor the code so that we first configure the repository format
before applying it to the repository so that we can stop setting the
hash and reference storage format multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index a9db1f2c23..2748155964 100644
--- a/setup.c
+++ b/setup.c
@@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 	return ret;
 }
 
-static void repository_format_configure(struct repository *repo,
-					struct repository_format *repo_fmt,
+static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
 	struct default_format_config cfg = {
@@ -2748,7 +2747,6 @@ static void repository_format_configure(struct repository *repo,
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
-	repo_set_hash_algo(repo, repo_fmt->hash_algo);
 
 	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
@@ -2786,9 +2784,6 @@ static void repository_format_configure(struct repository *repo,
 
 		free(backend);
 	}
-
-	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
-				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(struct repository *repo,
@@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we

-- 
2.55.0.rc1.745.g43192e7977.dirty

