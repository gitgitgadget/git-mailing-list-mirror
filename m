Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245933D506
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026941; cv=none; b=O8Qu8mF2MmFbgQFawrximXotLmcLzG/JoZtiZEy5cPqeFM2Knu+0BbfbsJvsCSUQP3UB8y+0VLObgg9rY3cU159tWMkrXMqy+Zy5hngsiycBqxwsAmwQItXnCD8xOVt3GvQLrn4Mdvg/GaXz431/AuLMPDgGJRmUax/nhA8aKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026941; c=relaxed/simple;
	bh=IDTAVD/HVf7NWPra3QPH+53ont6FK1ZvLsOgPI9wVJQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R/U2pFcSODi6nixcX7kB2/973F8eDeB2FtEmls7RGjqUT/80/yHXbevtizZLDkw6jGrTlGd0K5p7Rqe1uO3uZXMJzz9mzVqFWxtXmaoLszJFrSSQkHpuViW2YjRLC3SyroAOWgaFUWzanD/HsXjfULzGXpaBeRzxFSnZhrXFOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npVomR/Q; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npVomR/Q"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3b3e643dso97122085a.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026939; x=1771631739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUkzkMl3QZQQAWCQ0Sb6NuI15sbQ6d5Kv6p4SuwHUvI=;
        b=npVomR/QL8eEuuXDcLjPB88/QGkpHry+vzTFQ8RywOfp2K2R6YNBvunMLeryiTr4ue
         h6swNeWBdsZQj521gowbqs9FZbgmA0sN9gh9SGtlw8rOFvLNxf8Q7fBHFUa55+SAymsj
         EClWYCfvIndooWz7rH01dQcibspA+wPdbA+x8Vi9fehC6Y7mh59wNmbTSbS9LEY4yhhC
         fcR0c8cgaZqEvmd/8EnJwmyF6q8okTTY1KRjtKKKs/gdG2FnHR0yFcnQKyOHQiGtLN8O
         y9sNyjUJuBay8dzLkHknJKmhZGUadRVyzJoFoSYbe5nEmDVvKf1unWx8KwAh072Vg1J9
         pGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026939; x=1771631739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUkzkMl3QZQQAWCQ0Sb6NuI15sbQ6d5Kv6p4SuwHUvI=;
        b=GSegPdXV9bJP/y3y2M+2LE3ETyNTjOCn7cu3wSo4rtdLL7gnIgxrVPjeBQXpIsWbwi
         NP/GVLofhIQbIsF0e/0ZPbJk5R42lg2/XdfJ7Oa5gmurBKm7yLcaqGOL4bnlM8L8pZwi
         i1CXxBzZBOnYQeZ56YaZSSgfg1Wf92X1KTkEIAVFY+buXERJgYt9GKn2NI2a7BCQzNEz
         dwZGeEEUjbMM6mew04OB5h1p8uyL+kMuQvbRKf5g/SFfuzby4R+YQlr55ytni+DO5BXf
         G//pd4IQ+3JZofIDAhONFXuR218mISD6ZM4YOQm9SRxGnQBA92XRhgKKN755ChWik4w+
         c2gA==
X-Gm-Message-State: AOJu0Ywg6aK57Tnqq77YnKTk8LX3rPnL78AxKnlnrkC5JcbRgVS2f4gr
	rdxlb0qk4ZYqFnlDQDNznwCHRiULxzFeTDvXkdYzdKvOR6Fsf5CMY2N+05Rt9fMb
X-Gm-Gg: AZuq6aLs/+pRwKyu+EMc356k0AJMqPV5qs9WkeyFinYtPknZpNSGvBtptx/3H+vEz3C
	At4CaVMxV6/hwtVGQXdqAQXRKc+HzDvBLtdLP9WfWfL6AzZxDnq2TiOw/iJP7R3HVEJy7UhzXfl
	jnh94a+/WG0flyZzMbUbPVcz0HgBD6rELgZZLpjrMPBy0KUcPYIqV6sl0yAI0FS6OSDh7zAy4c3
	6YbgR94inoge7Ys+dAlrb58TkjaEaTMDFszQUkCUl2WSbwVofFSUfqjAejtcEjEPQO+Mj3FYf5g
	t/d0JJ9l/ynGXaVL3XZNJ9LEOnMTa+Eh34yMF26uywToZeFLoJgzO2oQTkZ9CvM9IRQWkF/O8Ea
	Mzp97P/JeBGIXX8ZoIMXWRDuUamEulzwl+Ou3l5Mavr500NvJ2g/b4aQMylCj4DEhjShrv9jYWE
	Ar3QP811caVyMNy9z23tVGyhu5
X-Received: by 2002:a05:620a:4045:b0:8b2:2607:83d5 with SMTP id af79cd13be357-8cb424b3e8dmr439909585a.75.1771026939402;
        Fri, 13 Feb 2026 15:55:39 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b6b576sm78823761cf.21.2026.02.13.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:38 -0800 (PST)
Message-Id: <d1cfa0c5e1295d7b6655a0962bd47f8e89bc4a04.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:14 +0000
Subject: [PATCH v2 09/13] config: format paths gently
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting path config values into a helper method
and use gentle parsing when needed.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0c539ff98e..4664651dd2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -314,6 +314,28 @@ static int format_config_bool_or_str(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_path(struct strbuf *buf,
+			      const char *key_,
+			      const char *value_,
+			      int gently)
+{
+	char *v;
+	if (gently) {
+		if (git_parse_maybe_pathname(value_, &v) < 0)
+			return -1;
+	} else if (git_config_pathname(&v, key_, value_) < 0) {
+		return -1;
+	}
+
+	if (v)
+		strbuf_addstr(buf, v);
+	else
+		return 1; /* :(optional)no-such-file */
+
+	free(v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -347,16 +369,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL_OR_STR)
 			res = format_config_bool_or_str(buf, value_);
-		else if (opts->type == TYPE_PATH) {
-			char *v;
-			if (git_config_pathname(&v, key_, value_) < 0)
-				return -1;
-			if (v)
-				strbuf_addstr(buf, v);
-			else
-				return 1; /* :(optional)no-such-file */
-			free((char *)v);
-		} else if (opts->type == TYPE_EXPIRY_DATE) {
+		else if (opts->type == TYPE_PATH)
+			res = format_config_path(buf, key_, value_, gently);
+		else if (opts->type == TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
-- 
gitgitgadget

