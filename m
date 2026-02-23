Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642C3644DA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849634; cv=none; b=rO1lWDw5Wa7XHUGhF/XlZckG0At7gmOthd4sj/tKO4KalLuHCBDvBhrAAkV0c+VR/wklazmMkhtTqrzslWpyymtQsQ+marGjUpVovQFfeIVWqBM66Rv0Iab4t+Kq2cQVR2LX1mGp3+2qHXnhKV8FDgURVh5otc1OkU1QwZd7ZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849634; c=relaxed/simple;
	bh=WxxGOS/jyyU+GNFb7Gq6HsQghpQ2HStzIe704a5gNbk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Mttevh3tCThSwW8FUytq+qPQqN1oD1njKsTLAQBHytS7RjsBqXXcui7B/sBcOa4QJJuu7nOEh/e8nhRpovWZ0dfHwgsbGPIsaeTL6jOUAk53rMCZaKE9OTA3uKHLys7fO13A7cUUC3rFwY3VdOYIWign+4P4b81z1NueDl4Na7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyPxhU0+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyPxhU0+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79818c7600eso26218917b3.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849632; x=1772454432; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUPkiJ1N1OJFOrAyyEhczprQP5VZTb5e7ATxzCiLEJI=;
        b=NyPxhU0+9hxraqI33Ae8ymrtqB5/iiAVqVwJMGZR0/fdT42755C49rDTE/rEFi8vQA
         ahUOA/9v1hjR4FzykmISYq078jzJHLuiI44us7aTA/aY026Oiv+Ms8DfB6sydpZXl0oI
         U5vNKAtUOZEgfc/8qrfTKzrlpSmuIWLn4MBWTAAx8qnbTgzSwrJU2HSstzsJgEiEffPo
         flGu9hyEA0CQiD3pr7iWGbzOTAI2p7TTi5Cy8JzP4Y83YIuuLvelXZ1bwxmkLMyubZMA
         Em1+WjiOIfnwwIeH0wLcV4g1Bxws/7vmSElGHM1/aPAuv9858jyC9dIby2FNWcl8oIcs
         FRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849632; x=1772454432;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUPkiJ1N1OJFOrAyyEhczprQP5VZTb5e7ATxzCiLEJI=;
        b=FWolztoW/pO6xBXCek2sz30bB4u+kgzcuj2OusztHQabOtSJSkf5WYWLj60g80hxtN
         1ld4dNnvzxI0ZzLQjhj8HStBB9v4VSdP5+KY+s7wSWBnbzrONhugbwLACnrf2AYMFlRW
         6Wq/6FOhzFINteRZ3gLxEUxYhwvxFx2kbdQbV2N6kJC7Be4lSVL4Ec+JklbulhRkDVlW
         yBpKic3hF+3T8zTtoahwPQ/3GgbEBgSbjsE0mTReRGhNZfUjm18uD7hKTlqRFfEkCIMf
         O9ATnaEC6F8qGzVPrgJFccKlI6iNglPYFAzCErkTbnASWmCHeSmN64CezwKX3wUGhf1/
         dlFA==
X-Gm-Message-State: AOJu0YwfGDooE2tBw8y6tmwB5k9J1cudl9j/L7zKyxwnfDOcKNXkbZSF
	jG0VqowVBG9TFbpJZbjwrDXIOX7oy/TjnBgSB5ONa4zK9ZxZe3GqWYhfjNnPMA==
X-Gm-Gg: ATEYQzwBao6gC5lJ+ZBzzFtxBMtvj//dPgPWJ1TQW2f0rc7rV2BeWvIGDU5XlLbP57y
	v9/Vq9sM81qcfadlqoAclxRvntn6Es5JT2AtA7t4TlTLQuLM6idCXFYAHZAu1LWyKhvBjYke6/T
	HfIs6bv9lIOEFd3dWpZhP5U4tj+9LjxmocM1kmZl5aUZhyoQJLv4mji2pK/YwXUj76d26FOFHKV
	t0NVNifIa92sWJJ1M3i5bJdT88F6YcQ/lj9dQUwJJFiAnn5FfFMYdRzzJET/YYhG7xDAC/tNnr0
	RtGF4FySEVWQ3CP4FX5NAzBiBUjj6XzrUSMUZbm1F3kRtyspTTvdfLfg7rMyxvzBGIq1PO0TLTt
	tp5CSLnO1Fz81HGCN0ymuBCyJYtckHNqIj52X2HhqaFych4zeRA67SicnlCNJFGJXUau5qTj8Qp
	m0XTfJl6afDrtBrG7Zchhu1sO0/A==
X-Received: by 2002:a05:690c:f14:b0:797:aa2c:7691 with SMTP id 00721157ae682-79828cf4164mr68200597b3.9.1771849631843;
        Mon, 23 Feb 2026 04:27:11 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982de13ce5sm31077957b3.49.2026.02.23.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:11 -0800 (PST)
Message-Id: <d98966f53a4f201be041c4e8a83ed549f64aa404.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:52 +0000
Subject: [PATCH v3 10/13] color: add color_parse_quietly()
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
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When parsing colors, a failed parse leads to an error message due to the
result returning error(). To allow for quiet parsing, create
color_parse_quietly(). This is in contrast to an ..._gently() version
because the original does not die(), so both options are technically
'gentle'.

To accomplish this, convert the implementation of color_parse_mem() into
a static color_parse_mem_1() helper that adds a 'quiet' parameter. The
color_parse_quietly() method can then use this. Since it is a near
equivalent to color_parse(), move that method down in the file so they
can be nearby while also appearing after color_parse_mem_1().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 color.c | 25 ++++++++++++++++++-------
 color.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/color.c b/color.c
index 07ac8c9d40..00b53f97ac 100644
--- a/color.c
+++ b/color.c
@@ -223,11 +223,6 @@ static int parse_attr(const char *name, size_t len)
 	return -1;
 }
 
-int color_parse(const char *value, char *dst)
-{
-	return color_parse_mem(value, strlen(value), dst);
-}
-
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
@@ -264,7 +259,8 @@ static int color_empty(const struct color *c)
 	return c->type <= COLOR_NORMAL;
 }
 
-int color_parse_mem(const char *value, int value_len, char *dst)
+static int color_parse_mem_1(const char *value, int value_len,
+			     char *dst, int quiet)
 {
 	const char *ptr = value;
 	int len = value_len;
@@ -365,10 +361,25 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	OUT(0);
 	return 0;
 bad:
-	return error(_("invalid color value: %.*s"), value_len, value);
+	return quiet ? -1 : error(_("invalid color value: %.*s"), value_len, value);
 #undef OUT
 }
 
+int color_parse_mem(const char *value, int value_len, char *dst)
+{
+	return color_parse_mem_1(value, value_len, dst, 0);
+}
+
+int color_parse(const char *value, char *dst)
+{
+	return color_parse_mem(value, strlen(value), dst);
+}
+
+int color_parse_quietly(const char *value, char *dst)
+{
+	return color_parse_mem_1(value, strlen(value), dst, 1);
+}
+
 enum git_colorbool git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
diff --git a/color.h b/color.h
index 43e6c9ad09..0d72540300 100644
--- a/color.h
+++ b/color.h
@@ -118,6 +118,7 @@ bool want_color_fd(int fd, enum git_colorbool var);
  * terminal.
  */
 int color_parse(const char *value, char *dst);
+int color_parse_quietly(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
 
 /*
-- 
gitgitgadget

