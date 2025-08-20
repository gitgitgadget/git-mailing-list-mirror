Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D862E62B4
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701035; cv=none; b=qghiYAWHw/qn7vtaLg1W1kDO0Wpczc7wf0xaOqH/utWfkGcTpbAvIpEeE7cJv+wU3GxjFXRmitsJeQMbWzzWeFnDQ0DVsCaXoiYOcIZLT9hDeqAHp71yvtyNeXk/e75AARiR6xrhIhTtVPuh3sWrq/VccD+F2yT3sW0Cp8Ng20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701035; c=relaxed/simple;
	bh=EH+/2jMMPUfESRmibX8MnogbFNccmj9hhxur5cJbK4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otlZEVlIeX9fbhSGzlFGeFSyOPvC/tOeioh4uCHEunoHXJNMOIh5LMfjKqi76U8HWqDB8Uo6UJGwb8wS0NHy3baajIdbvuLmcoHISSKaRSXsiXL4yF6LwfBwbCo6lUs5sZ0bLSf0GWjw8mufsRWtpfw5n2aFsKXxOef9X9/7Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPMs+LuH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPMs+LuH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso18067b3a.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701032; x=1756305832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS34tv66PCNBOXzPNhbGOupK33gHLKhCsSZGb0jfNIE=;
        b=dPMs+LuHUQXDAGt5M1nU0E8PdgCJnjosBcTCaNxOjq8dWBt+SWusmb2m8zgY21TpeJ
         2gT31wuEbLSdWW98BdHQTgd7o6aOFhk1D5ahJmDIZOvARvxDiySzbNRX8T+6KaPeSmQ7
         ek7TFH8ZbQPIiiDA9BtxoKKqx3TbRlDbW8xHkfil0Qow3oOWzXYn9b2mnmMOOk1zyJ2B
         gLoqKimDcAX0h7ePlf3VXwV+0YSIOneN7zXkbWRDuTPuQdMh9ZQpkSiddCdb9bi5w4Kn
         KMhoeaLoD6dzWXuWK12QqsnbEFcXXHiJPmQ/6NLyVWKUstOebWaIDyI5ibTQ9GXSkBvK
         cqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701032; x=1756305832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS34tv66PCNBOXzPNhbGOupK33gHLKhCsSZGb0jfNIE=;
        b=a9hR1bWgE/p4NZQ8ARKKfccBWPG4+IHJJyX5RWe/Ax3Y+r2TdOoLwfYNHDqlbxyPfr
         H30vqxmOhpqzP+k7UwavCE3Vm0V0vxTQr91IWeogV3b78ly7NT4h7ZkgwlWMz+WecaOZ
         m3sNpwm03bfjfxGlz5OZ75n/Xd20SKeEkK1mqYdtsrNyY8ZiQs+HKTd4TYHO5BLy4/PS
         FxkQLjuLSE2ekqj/Igmc7pBugOArj9P9WIVXD2MuKzpFVnIrjoNweB7qGKd1O3O/Wqsg
         lFu0bY8Oj9OMLfBxOjkg3M/PWFhwfuTEWRV/PlSCehhE9jI6dxJrKvjHQTX9t1O+6+17
         n1Tg==
X-Gm-Message-State: AOJu0Yz7ljJHCZuBHBsAY+aR3I1REED6CRjXxYEj3GH6/BZIl2cpQcbW
	GDE8KHilIXJBn7mD/jE3eTJ9Yrt1ib9agshuYj/qjT8YiuHwLsrNsHW61d9B4A==
X-Gm-Gg: ASbGncvGwC/YHmgFnn6lk/TxMgIU+YvFyHIhCnBCLLJ8CUbG5IwT3FoBVpTVGRZ03E5
	LdoIZT1PY0y0xu7nfzQBi91z9izHm6fnMe04pU2Ca9MjFctGTZ5qQQFmQrx6+ypm7XIfCyQOvZ/
	GzB/I6pll8EYjYHXWjYbKop9zUpvxT4Ab8KgGo3FULp7Tsqk1AitLCsmEEa60k3rQX20E9GNZUF
	/XMralPfku8X9BlgIOCl3jBQyZ8XlUODLkTEqK9lTzCNODek3bJGs9hIio+cyWEgRjJrN6gibHA
	94V+FdeBezxJSETFGmyE0yq5bKPfN1ng6ZGpRxjHxqz2Ery30DuX+dKv4FYXRJFFZHVD1r29aJM
	l4JpLdwYjogELSXq2gicQuqKGONIVrUMgvjx3UhKAEW33//Mv8NAS9H8VYetl6l8=
X-Google-Smtp-Source: AGHT+IGHjdmzXegggDLJwSUlO1sLeZ1pr5TnCGBiys1xMxZe3CtAEVadWivXSzUTDPexGGeYkoXtvA==
X-Received: by 2002:a05:6a00:988:b0:76c:2ef8:7536 with SMTP id d2e1a72fcca58-76e8dc4252emr3515164b3a.5.1755701032260;
        Wed, 20 Aug 2025 07:43:52 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e923f8364sm1950291b3a.107.2025.08.20.07.43.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Aug 2025 07:43:52 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 2/2] repo: add the field objects.format
Date: Wed, 20 Aug 2025 11:42:47 -0300
Message-Id: <20250820144247.79197-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
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
index f2dc71193c..b6ec423d12 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -55,6 +55,9 @@ values that they return:
 `layout.shallow`::
 	`true` if this is a shallow repository, otherwise `false`.
 
+`objects.format`::
+	The object format (hash algorithm) used in the repository.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index b2ec66e454..71ddc5e8c6 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -38,6 +38,12 @@ static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_objects_format(struct repository *repo, struct strbuf *buf)
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
+	{ "objects.format", get_objects_format},
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 3df55dcc79..aca2ed23f9 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -63,6 +63,12 @@ test_expect_success 'setup remote' '
 test_repo_info 'shallow repository = true is retrieved correctly' \
 	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
 
+test_repo_info 'objects.format = sha1 is retrieved correctly' \
+	'git init --object-format=sha1' 'sha1' 'objects.format' 'sha1'
+
+test_repo_info 'objects.format = sha256 is retrieved correctly' \
+	'git init --object-format=sha256' 'sha256' 'objects.format' 'sha256'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

