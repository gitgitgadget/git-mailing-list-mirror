Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF419325726
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772373723; cv=none; b=BZwUVKeP/P4M9pIOA6nsh2Dy3rLcTbu4NMTAl+s7d0lYNSUhBWfitQ/U+XnbrhfUO8rAm+sr71wOri0+iAfYchNWLpkMKCw15koLkYgNWGeUDt5UOWVkeOG+Id+j9jZiEYJYvhQ5K0An5h1UI6mtzkCncPnN189vz5lPg3bI+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772373723; c=relaxed/simple;
	bh=ixlYJMgxiOM2Y0Eu381xwq/b8EP1IBEOS7DLM3dnSMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzIe1BYDPY03OV2r34GeHC4ecYT5MJRGHh0SsiYnPzPSavuUxtk3gTO6vdd2nUsDoSmbmJj4hLdL/PG0/c5y6IbrMvbl+fxxuXJspFfyDjrVmAMACWYLBx/s2Ab0yO/f++6HbsXt586kNfag1bzsrM/cBgWMvFr6LbkjBASu6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSQKw8gr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSQKw8gr"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7059b9df33so1361405a12.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772373720; x=1772978520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4gXsej8ochLzjTRveCfCTFAPmP9WzGSlbF0ClExSrY=;
        b=QSQKw8grCTlU7lh6VskWa11N4JrsWQRYtKwSBY9cgmLsiQP6YaamFAYqMUPS8iSBPj
         hUJdxtuF2vJ1W2OF8je+bfRqHqw0PHIHpFHXBhg+x1Mw8hPTpeuvOR9K8WbgKrjs+kjc
         MrtGj+l+Shm/Iul7QAi9z/lW+2osJ4TbTDLDjxxVl+QtAGibgbIV5eblhC3NWwVdJ23V
         dXk2K/nRf0xSTRgeX2eUfmc/I+39ySUxAFDBckfOP3C50HHEtRTLvEpaANgCHCpTwc+N
         HErnkRFPqy3pztDlplEBY8s7NuJqD0eoE6ZJYbCfPT34txC6oyHgiT9yLNqoFFYuNfbY
         06xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772373720; x=1772978520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4gXsej8ochLzjTRveCfCTFAPmP9WzGSlbF0ClExSrY=;
        b=Lgxn8lwIktt6UsBWBqCb1qrmRD+pX2iZj82dJVtA358PLIL8css4nCqieDcrBnQ3o9
         gCmg7XzRlL16L6h7YKRX2gfgd/HADPuYkNv1M+g8wWKcgHnF/Rlot9y/uiHbsgySksUJ
         zVbHuvK38v5XiFU1EvPl4r519t+P3xS/W2TFnRdFkC6mqzsDPe75KfpCRpdpP+cHkQtv
         XE5q2/qXb//RGe97o36TMA+Xwni/Z3uWgo1Y1p6xeK8V7gJFSymB6oJyLlXii3uJLhB6
         X04KeLRPGFZ3McSawdD1zME6ZEWeXvNXy4ST0ZaMMC8w6R/KovQBofq+HLoKzE35XIOL
         TR1Q==
X-Gm-Message-State: AOJu0Yx9bMHCJ9Itq7eDVWnZfreOg+wuwsyQ9tBXfQXuEMwy7s8bf48u
	YE8XMtdYMi87/8JTFp8UKuuUYUwaDOh8VMM6lkGpAO7+uM8rkOxeLjRe+F1dscC6
X-Gm-Gg: ATEYQzzJLsQ6FZZxKnfKtI05Rn//FtLfWvecmYB6tvHXFpKKmFvdfoy3FzLvf1h9CcG
	QNQ0/c9O9xtV4oIZ0FXa6Zn+uGBwfQ0Wi7kfqoylHXpvgSFggvPBuwAfT68D8lvtYTPZRn9RnsW
	8Cmlt1OZdJW0pLNEdaj3Ql+KeYQzs9BbhLu4VRwPI5MiNYstPJo/FRpCQmSkZHH3ponDEN7ari9
	LvWwBGSgsXxY99lsW6zJretaakG0yykE1zsaswDOGFPd9ey9H/Ad7tzypWLdC1ayzgZfWp2MzpA
	zqAdh2iQBll+SV9wg7Y5w8l8VfIUJcozi86pEWGxxoinQmX0lC8MqE9PIaAMEBZt3fawQYUMiOs
	65dbsfHG3mLUUOYZYRdR0l7OW/HEv8OS/Uun9q5N+cHtN2MAdLu15Bb74FXfVrdbfie7R8NyNoi
	7XtrLFyg0HiqJCnTGZ7y/FVe3oKFB6OjhchvZTMoIucR7k
X-Received: by 2002:a17:903:1b63:b0:2ae:4af7:d1d4 with SMTP id d9443c01a7336-2ae4af7d4b2mr16379975ad.29.1772373719832;
        Sun, 01 Mar 2026 06:01:59 -0800 (PST)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a041asm115062325ad.57.2026.03.01.06.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 06:01:59 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthiknayak@gmail.com,
	lucasseikioshiro@gmail.com,
	patrick@pks.im,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH 2/2] repo: add the field path.common-dir
Date: Sun,  1 Mar 2026 14:01:38 +0000
Message-ID: <20260301140137.1072709-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
References: <0260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the repository common directory through a new
path.common-dir field in git repo info.

This mirrors the information available via
git rev-parse --common-dir and allows structured
retrieval through the repo subcommand.

The value respects the --path-format flag.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/repo.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 8b4c7ae4cb..d42ac2478b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -88,6 +88,21 @@ static int get_path_git_dir(struct repository *repo, struct strbuf *buf,
 	return 0;
 }
 
+static int get_path_common_dir(struct repository *repo, struct strbuf *buf,
+				 const char *prefix,
+				 enum path_format_type format)
+{
+	const char *commondir = repo_get_common_dir(repo);
+
+	if (!commondir)
+		return error(_("unable to retrieve common directory"));
+
+	strbuf_add_path(buf, commondir, prefix, format,
+					PATH_DEFAULT_RELATIVE_IF_SHARED);
+
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf,
 				 const char *prefix UNUSED,
 				 enum path_format_type format UNUSED)
@@ -102,6 +117,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.common-dir", get_path_common_dir },
 	{ "path.git-dir", get_path_git_dir },
 	{ "path.toplevel", get_path_toplevel },
 	{ "references.format", get_references_format },
-- 
2.43.0

