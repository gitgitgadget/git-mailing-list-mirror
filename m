Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284A2C0F84
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772373645; cv=none; b=IsMhqHreO+8/PcHmzdGmQtRyXWsHrhqrOanOrzIALVbRZrc9DXt1hiSbyaLXKxOoc3JWoPu+nT7faNIKqw7n2YDkAsngTh7VeGQvum87fClOcsYFFM9c34JJKSMLLbDWvVQcSRM2BO4n1fPTYTEn6ShzlESsoQVSf8qtEB5wWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772373645; c=relaxed/simple;
	bh=hf46seG66zDBEWdcC4wnIFcEk0EYVdZ4c5nzAdpgUNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6bXROZuxHg3ZAoWEjV3g2GCs7cqMDBbRfoAnzlbIhPudl5QhMFGvHKrvhyws2xGAzvl2MwAzEnFeDHDWT57b46GKmCr2BFuPtG40J7XeKAgTBssYx6JkVDbeLYEpjEw/E4DbYEf6nCH4kERVEY9ZsFPhIOv3nBaNvwKlok0HwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKSoxpMf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKSoxpMf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82747396358so1595623b3a.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772373643; x=1772978443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38uwe/MWUAzC9UolDVOOSMq9k1um54fwPo7JB1KUoTM=;
        b=IKSoxpMfbm6k6SqQRKJs3UJO67rVJLEv6jEcvd1NWiIsvZbaxmI1Nef0g2mkan8gty
         gmXRLemeAMkNzhjAfYp0TPNksvGqvJtlG/hqW4Lw6X20y9wl/s1rmaR18ufvvVRL/96N
         gEqCoibji313DXR/grqa093sTIeGpquXItYEsxPQaxMtfMIZgnDbS3+Jp4EHH+QSR5CZ
         iTJx7diCg+OmgWVKzdctJ84WnENcyZCgs+YkJYN/3ztjGDmm63sm+EMCzzGB+a7k0Gyn
         5RV3Mqh4LJRlUriOZ6ZkSbgt0MLogEWdyjLsLR7sKCkA9FtNfrtM2ER+q0LlDTst9f7z
         rsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772373643; x=1772978443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38uwe/MWUAzC9UolDVOOSMq9k1um54fwPo7JB1KUoTM=;
        b=ucLNJqooR8Yt/9o0viMkwj+zMu7RvT2oHHwaUsT6ARYebBpNsKzRCV/VLkzqBXhFbx
         4bjsFIiAOUm6gY7F9eCbz7VUeWXQW3soRrwBjrxkysEO6kmd763iGkb09bDHBrxcgKcB
         Xal4HGMKZx5/T4QbtuRNeYpZwl979MwlAqeJkA7tQEadAgMX4CSwpmGvy/f1l3T2q2E+
         cv79Vk+ctYBb9AfQBDi93E3lxB/3T+NdjnPQf5ah3d36/lYVgV9CIYGcD8xlJknGMLlJ
         2ZjokqOrXf5NpqnjhCPccGv9vZAQJ+qSIBXgHgC+MYYXpzesBdGBwI+k9KE023LrlrG+
         eu8A==
X-Gm-Message-State: AOJu0YyEy6yJRt0IQzcVE3a+1CAhfT8pJl+Zw6UvOlhwssKY5Bj4ETak
	1D7oqfbVoLlLwyfgzuDHh5Qmx8wIv/DQcPkKCNcWI9/FKXPlZtGpoDzNXDlt2hEB
X-Gm-Gg: ATEYQzy9tO8D53gl8YVgvSp4ff2z+7+UtJ0/mypWVGC7pQ/3E5Y7EOA0nSVyQm3E5k5
	WmQHMheH0kjyfL1jnw7PaS5pn9CLWavDx/u3otBW8MWeHYCylfJoHHKDpua62AvWlAII2TTGnf0
	tRGiOohT/QBpheRqAI0C22cd6Ug4Y6WChlVJmPxNR9J6/fFbcb2yulMQJhUdS+9QeFTMKc4HQs8
	MYqMW2zp+B+EyM2pn6UVPo9t/NL/wv56gLDGf2LDYxHm6l6PrQOuLQ1Ngaa97l2gJKCGp0M9gjX
	vb1xI4jGpEv1xpkaCR29GfbbS1KJrR1vvjJjF7ecdXQ5Zl8agQsJzO+rJFgzHI88uOaISSZwGII
	OGnnusdESrunnKz2/YL0btLLJdmGGzlgZ5rWh8BPBLoZ31zqA0c30ASI4g4Jt3UCPUFAwpKggEH
	LTYY9MVhjomfRkP2ib2cOC8puDKV5qG6Ux7kAPvc2G5ZtT
X-Received: by 2002:a05:6a21:7116:b0:38d:f8e6:fc9c with SMTP id adf61e73a8af0-395c3b575bcmr9437665637.69.1772373642986;
        Sun, 01 Mar 2026 06:00:42 -0800 (PST)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa63d3cesm10095410a12.15.2026.03.01.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:00:42 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthiknayak@gmail.com,
	lucasseikioshiro@gmail.com,
	patrick@pks.im,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH 1/2] repo: add the field path.git-dir
Date: Sun,  1 Mar 2026 13:59:29 +0000
Message-ID: <20260301135927.1072684-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
References: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The flag --git-dir from git-rev-parse is commonly used by
scripts and tooling to retrieve the repository’s Git directory.

Since git repo info aims to provide structured repository
metadata, expose this information via a new field
path.git-dir.

The value respects the --path-format flag introduced earlier.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/repo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 61cd539e05..8b4c7ae4cb 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -73,6 +73,21 @@ static int get_path_toplevel(struct repository *repo, struct strbuf *buf,
 	return 0;
 }
 
+static int get_path_git_dir(struct repository *repo, struct strbuf *buf,
+				 const char *prefix,
+				 enum path_format_type format)
+{
+	const char *gitdir = repo_get_git_dir(repo);
+
+	if (!gitdir)
+		return error(_("unable to retrieve git directory"));
+
+	strbuf_add_path(buf, gitdir, prefix, format,
+					PATH_DEFAULT_UNMODIFIED);
+
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf,
 				 const char *prefix UNUSED,
 				 enum path_format_type format UNUSED)
@@ -87,6 +102,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.git-dir", get_path_git_dir },
 	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
 };
-- 
2.43.0

