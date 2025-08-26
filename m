Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AF283FDE
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233139; cv=none; b=NKlEa3B5N6uIWduXky8TW9haRLz5dgJjpXDhQOnkO+OJzcKPjk6mX5lmL2utHFtMyrWvsXKLUGA+PO9AVu4Wpqo9tUbe4KVNw2UUHNXnFUA/RlNtTS67qHW3JUuHgavsgc62YJR/2ubHEg1VmosNJjAAez5vauHLlOWcGvf/bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233139; c=relaxed/simple;
	bh=m+aukjZeraU3q5ZALPOuqJ8s50Fttw+F/O+JWjtSDeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhVySA9JMH9Z+fIId8YtKnXiqTS1kO254xMHb80tuMWgAU8NEQaEiCHW1hZix2nWY4vqxH66YNvR9c0Go8jFyVZj6oOCKj5DSAgPEPblPlLhC7zBSS9agcpme9I/86Pbm9tqZ+kkmtfJGPbY/Fh1o1n3eG8ekEhAF3BMXtVLbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQclFxGK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQclFxGK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so4672047a91.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756233136; x=1756837936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUeEuNuOYPsLrvEzUdkECAbz89Jn0rl9kfCVJPsuvUM=;
        b=mQclFxGKmFNw8gTjfO8oAIGLPTGZ+ABaKwHoF1n8ReyL4SVoI9t/bIr6CvmU8XFpan
         wSxnEvf34McMs1erHQHEDzwYRhH4zdiquSoLYCd5ontFeXTTOKWvzW0GqWxT/9x0jWsK
         KuVZ+pwA+H8aam1m2a6FHWJzdEjmg+qvFiVBntWNKiVn8Sgps2rNhZlbIGxHiwuurtwa
         3Sw5MQtzJOULPKX5444rbYCy9aAIPG4i4hNVKkwG4nTIwh2acLyoNkKMZPdCDCika3HU
         NyWOTRy9aeQblj4nwYS6uiCuu1vyjptSzFiw67WLCV8WO/E2KhgWGHLdX0h3/2OfGBm2
         YDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233136; x=1756837936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUeEuNuOYPsLrvEzUdkECAbz89Jn0rl9kfCVJPsuvUM=;
        b=v+6qgCV+w0NIDpZplcka+HwwJjlW87NwejQo4BsAeULOBUJioI+uD9k0uS66pCt22h
         NTAQZOAx1qKhRBpDCX52ncbz0mzZM5u8woN81VMmbUxz3+jTWeMhO8vALzMu4Rm7vRUS
         cAAaFBjFfMyvnb8AG2ujV+JP/11F/Ut5wsZ2UIq3aoP7jA3EACjKXx1G94cMvBx0d8MY
         tpP7FFTZNAHvaATkzyBYUGzJx9x1Oi/WkfIIuU+02ZgfmYj+5Xhqc6p1BRX5ywPg/pBz
         Z/DXdQiCZDA5YC0V79xzw17vXEoAOQK2PUgmnaUqPjv78+ajmc7SN5hLRysAJ4I4MnwJ
         MXHQ==
X-Gm-Message-State: AOJu0Yz5l3wQLG6/dM5yzh7Vw+S5EzjowDdbJ/RcpgoP3RJBstATxyIO
	/aE5XJE2vwUG/9/FC4GXN/aNQ6/b5UkPjiCoFThe4hjRrCa9iJoHSEdspKhJew==
X-Gm-Gg: ASbGncsNM4ujJCZcN2+HwVDNSb86auMIlFVObye7bWN+Cu+Q3jta5t00kYufetn0VYb
	xr59bVeBrWgO2Omve/pNeHtio/ANQK9e21SHi5XKlZASONIeYhr1iGq31nAZ+6WcKgTLm60ltTw
	g4UWNYGgD1HJTbim52WXGP5LgmR4NV5O3P2+N5kvT/wAvOOlMrTOl4yCE6lDwILpZlu2Lr9fXgt
	8Vl9Tcc5W74wIGM5dxt79b9FDq9SO9hLoBR0mKbhfcrv3w8XHLepmMJyYm4KBLSYrmfs7D8jlEN
	n4/U3AK7fcFgB+gM5blULfo3KhsKSyJPN3KN+isTXg+MQQSTMo/ed+vFHTpmlwAu/ew5RUVsn5m
	DOuDrm5X3MYc/VmBevAD9b3DjRR0wnv/z9Twozw3Lphrnv+acQ8U3a4DJMDqwIts=
X-Google-Smtp-Source: AGHT+IFd8HXMTyYV1iAXNEbOqfov3HAzCl/sX/FRSqn89TvcsPUUdKFTXYAkcjoKhEjr19FgiXjNXw==
X-Received: by 2002:a17:90b:2e48:b0:321:160f:3349 with SMTP id 98e67ed59e1d1-3251744c8d4mr22176575a91.21.1756233135754;
        Tue, 26 Aug 2025 11:32:15 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276af0786dsm193214a91.27.2025.08.26.11.32.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 11:32:15 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 2/2] repo: add the field objects.format
Date: Tue, 26 Aug 2025 15:32:05 -0300
Message-Id: <20250826183205.19566-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826183205.19566-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250826183205.19566-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag `--show-object-format` from git-rev-parse is used for
retrieving the object storage format. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Add a new field `objects.format` to the git-repo-info subcommand
containing that information.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 3 +++
 builtin/repo.c              | 7 +++++++
 t/t1900-repo.sh             | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 8224a88bc8..2f9d696572 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -55,6 +55,9 @@ values that they return:
 `layout.shallow`::
 	`true` if this is a shallow repository, otherwise `false`.
 
+`object.format`::
+	The object format (hash algorithm) used in the repository.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 5df33de42e..5c900d683e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -38,6 +38,12 @@ static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo->hash_algo->name);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -49,6 +55,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
+	{ "object.format", get_object_format },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 3df55dcc79..a83139f7ff 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -63,6 +63,12 @@ test_expect_success 'setup remote' '
 test_repo_info 'shallow repository = true is retrieved correctly' \
 	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
 
+test_repo_info 'object.format = sha1 is retrieved correctly' \
+	'git init --object-format=sha1' 'sha1' 'object.format' 'sha1'
+
+test_repo_info 'object.format = sha256 is retrieved correctly' \
+	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

