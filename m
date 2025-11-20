Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404223FFD
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667940; cv=none; b=Xod8pIsNxTj6JHrI1CaVHh0CAo2lL4OymxGs2Ug8eOEdbg/8+9Z6CX0bp5GHd2TN0alrtXHv6Lwt5e0u9vsXaEeUnpgDYF0PsHbNxLz6JG7vJpzyeVHX90quC35wHi6cmP6ukbyVndF7FnUqr5P3Jw8Lozkq9n3viFfPxOjRWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667940; c=relaxed/simple;
	bh=KyHb7EmriFEsUAuZEaCo+MJ1eY9vsG/t2TpvFZrq+/U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAnuh89XUmRbFLLqj1V5ZepBIZNdvbGDiEpiGMEopwGaZ/f3ll2JiUJ5fVtVZvfLCq+qEkRwdchGBV8pSGQuO1rR2OjNcFdyjd4Xq5U73Wrnh+HqhJjoEHKkWZU8bsLi1Gkwj/D6xL3QpFNCk/qrwJYI41jYn4JCul5TNxn15cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P8t+LvKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jN6yfK1w; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P8t+LvKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jN6yfK1w"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 544A8EC03A2;
	Thu, 20 Nov 2025 14:45:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 14:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763667937; x=1763754337; bh=yupyBnAa5f
	D8ZPIs9zTQkr+heuam6XTqZA5buff4iRM=; b=P8t+LvKbpk2L38q0JZZTO6jOEX
	1EtmELW0pSrc4pNAD2KnfnJyfzKQV5bjb++6ZyJtf05MgBxD8EZi028KljriDtEn
	709zv58pieTHjV8F7QtVr3DHicfUsiat+jLGsJjEGgzSu16/COBLL/DS+iV7RN7I
	DnCbOlE/hRT+D5Aa2cqZUILsP4AAkUKtcxgfMQCHHumSyfL9Gh/Q4sn+QWUP0f7V
	2nWgIwh4ESAAsfMpVQCawLd592kMUtQBatsJPxKuYIvNLeOhLNP1gSwTjVKo9MsC
	5CGYkglgtOSZ0dM6zaVDNVhRIf1ch+Ujcol+CX7rPX3ioRwuKlxLf5hF7GpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763667937; x=1763754337; bh=yupyBnAa5fD8ZPIs9zTQkr+heuam6XTqZA5
	buff4iRM=; b=jN6yfK1wenffurKai3maGEjjm+wi47sGQe/Cdb5hypWwtA8ooft
	V7+gQ1vnhz0lMMFtXmQM+KOVo73cYeXRnJvbQ6NIxZmGzpZvg0Cggx68nSac47Rw
	ZBiMs0TcerDAz8bmkAddC+0vxWoO9tgIVaPMK0UgoJPlxTY4JBOk99F9ZPN6M7xH
	Kt8fus1EQYcLDVYnu1JxNabyCFe3zoMKQv85ZcpAUaZeSX1URMRlLcRkH3NPoQA8
	+SLdeyY4kDI1zFk9Y3lqI7VuEBDTtnI1wSoAN92FGsn84hgjqRIBcW7FGNfbkPj/
	4w33YCRtb4zDu0+9dpFXiveKelJMLGjVUxg==
X-ME-Sender: <xms:4W8fadb30uaV8mO3AGfNkO3lBSDvIlFPgT_I9w8IuAqrPN1pcQcq6Q>
    <xme:4W8fabaK9EJMkzu2vaUoakdMQI9UteqVs2NMXOOdZQBE0a81EZHsRznr8KowewMxI
    FHz_NrPxq14n3X2KWWlCBzlLcS9IFmn7UoNyMbJ8CCCNnXKNX1YHw>
X-ME-Received: <xmr:4W8faU-hcFh4BcUvt7Eov43M9jv6v09zYO6eYl9ebJgVM9xVXX2vVItaQq_uBKs-FBX_3zc2vw3ZuzVs2av9oKj3YWhUfijv7eee>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4W8faai21egO2b8M2oC75XE8wVYEZoFsKHzTzAMHFXX2CqIJ6DTw-Q>
    <xmx:4W8faUfrOuXYg5kkTTmMWLl0kgNBKPdPF9h95ogqRcy8d_1JTHPa4A>
    <xmx:4W8faRpFgk892iXGktHYpBGeCSaCRAOwsLYaDE1EascLI8fbn5y8hQ>
    <xmx:4W8faZDbb6y4QSMnQIVanC8ITGTX29kwbaWJ0aguK33C1diKfCzWvA>
    <xmx:4W8faS50p8-msfwwJcQFO7bFEaE2L7izP2hPNr_5yCBJcnK4H7l0ojmf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 14:45:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,  Han Jiang <jhcarl0814@gmail.com>
Subject: [PATCH] config: really treat missing optional path as not configured
In-Reply-To: <xmqqms4g7b1h.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	20 Nov 2025 11:34:50 -0800")
References: <xmqqms4g7b1h.fsf@gitster.g>
Date: Thu, 20 Nov 2025 11:45:35 -0800
Message-ID: <xmqqikf47ajk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

These callers expect that git_config_pathname() that returns 0 is a
signal that the variable they passed has a string they need to act
on.  But with the introduction of ":(optional)path" earlier, that is
no longer the case.  If the path specified by the configuration
variable is missing, their variable will get a NULL in it, and they
need to act on it (often, just refraining from copying it elsewhere).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c        |  3 ++-
 builtin/receive-pack.c |  5 +++--
 fetch-pack.c           |  5 +++--
 fsck.c                 | 12 +++++++-----
 gpg-interface.c        | 10 +++++++++-
 setup.c                |  2 +-
 6 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 2703820258..c39c1d3149 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -739,7 +739,8 @@ static int git_blame_config(const char *var, const char *value,
 		ret = git_config_pathname(&str, var, value);
 		if (ret)
 			return ret;
-		string_list_insert(&ignore_revs_file_list, str);
+		if (str)
+			string_list_insert(&ignore_revs_file_list, str);
 		free(str);
 		return 0;
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9288a9c7e..c6e8e8346e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -177,8 +177,9 @@ static int receive_pack_config(const char *var, const char *value,
 
 		if (git_config_pathname(&path, var, value))
 			return -1;
-		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
-			fsck_msg_types.len ? ',' : '=', path);
+		if (path)
+			strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+				    fsck_msg_types.len ? ',' : '=', path);
 		free(path);
 		return 0;
 	}
diff --git a/fetch-pack.c b/fetch-pack.c
index fe7a84bf2f..7162fd3ba2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1873,8 +1873,9 @@ int fetch_pack_fsck_config(const char *var, const char *value,
 
 		if (git_config_pathname(&path, var, value))
 			return -1;
-		strbuf_addf(msg_types, "%cskiplist=%s",
-			msg_types->len ? ',' : '=', path);
+		if (path)
+			strbuf_addf(msg_types, "%cskiplist=%s",
+				    msg_types->len ? ',' : '=', path);
 		free(path);
 		return 0;
 	}
diff --git a/fsck.c b/fsck.c
index 341e100d24..cf6f7f3a61 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1369,14 +1369,16 @@ int git_fsck_config(const char *var, const char *value,
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
 		char *path;
-		struct strbuf sb = STRBUF_INIT;
 
 		if (git_config_pathname(&path, var, value))
 			return -1;
-		strbuf_addf(&sb, "skiplist=%s", path);
-		free(path);
-		fsck_set_msg_types(options, sb.buf);
-		strbuf_release(&sb);
+		if (path) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "skiplist=%s", path);
+			free(path);
+			fsck_set_msg_types(options, sb.buf);
+			strbuf_release(&sb);
+		}
 		return 0;
 	}
 
diff --git a/gpg-interface.c b/gpg-interface.c
index f680ed38c0..3e73513694 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -794,8 +794,16 @@ static int git_gpg_config(const char *var, const char *value,
 		fmtname = "ssh";
 
 	if (fmtname) {
+		char *program;
+		int status;
+
 		fmt = get_format_by_name(fmtname);
-		return git_config_pathname((char **) &fmt->program, var, value);
+		status = git_config_pathname(&program, var, value);
+		if (status)
+			return status;
+		if (program)
+			fmt->program = program;
+		return status;
 	}
 
 	return 0;
diff --git a/setup.c b/setup.c
index 7086741e6c..cf47441b7b 100644
--- a/setup.c
+++ b/setup.c
@@ -1248,7 +1248,7 @@ static int safe_directory_cb(const char *key, const char *value,
 	} else {
 		char *allowed = NULL;
 
-		if (!git_config_pathname(&allowed, key, value)) {
+		if (!git_config_pathname(&allowed, key, value) && allowed) {
 			char *normalized = NULL;
 
 			/*
-- 
2.52.0-101-g4c43c53c49

