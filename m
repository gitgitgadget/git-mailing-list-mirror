Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D50191F94
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698597; cv=none; b=EsWNEXQgFb5mizHjViFdot8iwqQYs6IR2pykrt6gix0G/JdHl74jqlTOdm2nD4SYoouzzhhpXTM898gN12JV/ZKmXcoaeLWxSVaLLQ/v9T5tmSJwnnCUeB/Lfup0nDl8dhQh9aBkXY5bdl7sVCMMWCo2CL6B5v8/d071hU+3BTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698597; c=relaxed/simple;
	bh=pOA7z8J2K/o70vNWInB46yyT7dDJh/a6f5k/lHqpzt4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kYudbG3UhrKbcdcBJN8DZcW/gvWH3qVDyZg44ho+zU+TJtMaXPmARRKVh6Wp3jA2T889BikItPMagfdHc88r1RhHKuAXqT3jP9suw4TebDWNIusELPPyJXCQAf6+Z+Imi7cujEPAKijfhu5rbP11R4HPzMk3zB2LQTBShp027hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+J+dlrX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+J+dlrX"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1890f5cafso1312954a34.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698595; x=1771303395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRtD1QEhYjvWafgNP3JADMmH1VpiNtGKQy8sKPXO/FQ=;
        b=k+J+dlrXwlxZgv4hFaN8eyNv5nqu6rrfXRf9kzvhcTqEfVwjRAKb4960OkO9AXxZsb
         laoCXwsD6F+Rq2F223juTUsklAZvrqK/up2EQjyNxMyteQU/uY1HpUhc9jhgfcINLZvm
         T+hHkM8iQz9j/+IQGVRV6eBLTNr4dF+X89ZwEj56H+ymhAE95q2eASCOKcJUehiep4tv
         fdiDK86lYWv56bAhnvVKzVmJIwHhia0BK9T+EQM6QbSP/xJztD/fU/tbkTAHw/oHn74A
         FQSAXTnMhUkWWiwfYFFgjHuHNlYqh8zrrslbhyO6oLsJXdmYvjYmGqyEkKRfeh8x9rO6
         SQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698595; x=1771303395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRtD1QEhYjvWafgNP3JADMmH1VpiNtGKQy8sKPXO/FQ=;
        b=FkPwWWaWv4RKP3FncQzzdWjnBhEaLF+RpvqWjvUdP/EgOfa0wgPE796+fjomzx8odV
         hveTDKsKWDSoHiVfNncJHs9MNRxoiK6fgMmC//vrIp1cYbUXhaNH8hwi0yj0e59Py810
         kpFQZI8fZo5LD26SE0hg/2gIldPsnaNdR3m1VmiXjl2+X8ucKqMAxJQF07O83HXkJ884
         nHLT786dtJRxbXawF0Bzo83lJvpoLWJBobSll//tl9HAKg+EK1Q3ht1W822G6FAPhBOo
         iSlwACJUXrt02ZcWNLZFV5vp8Loy5/vb+P6TjHOWkbw+7aumFwpsmGYUTMDrvJiVchTB
         Ii/w==
X-Gm-Message-State: AOJu0YzLeG82Hh/dZ2chpdoCDbhuYhY/9LHhpM1er/rtjMBI1fnQrg5c
	UvR9DaoGIvcf76L58pvS8qXwMDDQH9GOEKppJ8/84Wjz6fMHFVFEbIE9icyFRBlU
X-Gm-Gg: AZuq6aLzKqpHaOtMAdXl9UqMG29/3cyNHB5o/aYZqm9vpDudIC7GLaXsWvzuJkDXEi1
	JrL3Ebqcb3J78ie5F2JByaM6ZrnoSXPPyqzoDRG1HiW66pq0KlTFaC8PrC/9v8W+oA1vVUTKTJ7
	S6sV9AdSJRBGH2CFcSeQy7h77Grd9EmHAqqrGUSJENceq+DdmvH3I++lsrhjiWmF37cekfwyWr8
	Krrc6TVAQJObwgxQfxLlz0Wz7/FgGLASsWkQuG/f5QuiMAWvLTCSitcL3xHztzq3vsXoTS3bsd7
	1PFgzbUeD1dE0/yGsVmt3K/dMC1UhufttO8on2nx1jWjvgPM/yu3CcRDTjyxiyz+KuPN0Y9BGly
	rq4xrbhT9gSVj+UiAjtXF+JWXMKd9OVXGVFdIvgJOVxSvbrHYzCup5wfu/UldZ44xRZQY+MOtIn
	RiB/cuUmLZnp53N79UAL09rarHHg==
X-Received: by 2002:a05:6830:67d2:b0:7cf:dc0c:8cfe with SMTP id 46e09a7af769-7d4646af8d8mr7961169a34.34.1770698595048;
        Mon, 09 Feb 2026 20:43:15 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4646fb56dsm9122690a34.3.2026.02.09.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:14 -0800 (PST)
Message-Id: <e27d52c4a5970f774e324b0a9c0badb0532bf3d4.1770698579.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:59 +0000
Subject: [PATCH 5/5] config: make 'git config list --type=<X>' work
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, the --type=<X> argument to 'git config list' was ignored and
did nothing. Now, we add the use of format_config() to the
show_all_config() function so each key-value pair is attempted to be
parsed.

If there is an error in parsing, then the row is not output.

This is a change in behavior! We are starting to respect an option that
was previously ignored, leading to potential user confusion. This is
probably still a good option, since the --type argument did not change
behavior at all previously, so users can get the behavior they expect by
removing the --type argument or adding the --no-type argument.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config.adoc |  3 +++
 builtin/config.c              | 19 +++++--------------
 t/t1300-config.sh             | 26 +++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index ac3b536a15..5300dd4c51 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -240,6 +240,9 @@ Valid `<type>`'s include:
   that the given value is canonicalize-able as an ANSI color, but it is written
   as-is.
 +
+If the command is in `list` mode, then the `--type <type>` argument will apply
+to each listed config value. If the value does not successfully parse in that
+format, then it will be omitted from the list.
 
 --bool::
 --int::
diff --git a/builtin/config.c b/builtin/config.c
index e69b26af6a..c83514b4ff 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -363,21 +363,12 @@ static int show_all_config(const char *key_, const char *value_,
 {
 	const struct config_display_options *opts = cb;
 	const struct key_value_info *kvi = ctx->kvi;
+	struct strbuf formatted = STRBUF_INIT;
 
-	if (opts->show_origin || opts->show_scope) {
-		struct strbuf buf = STRBUF_INIT;
-		if (opts->show_scope)
-			show_config_scope(opts, kvi, &buf);
-		if (opts->show_origin)
-			show_config_origin(opts, kvi, &buf);
-		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
-		fwrite(buf.buf, 1, buf.len, stdout);
-		strbuf_release(&buf);
-	}
-	if (!opts->omit_values && value_)
-		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
-	else
-		printf("%s%c", key_, opts->term);
+	if (format_config(opts, &formatted, key_, value_, kvi, 0) >= 0)
+		fwrite(formatted.buf, 1, formatted.len, stdout);
+
+	strbuf_release(&formatted);
 	return 0;
 }
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9850fcd5b5..b5ce900126 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2459,9 +2459,10 @@ done
 
 cat >.git/config <<-\EOF &&
 [section]
-foo = true
+foo = True
 number = 10
 big = 1M
+path = ~/dir
 EOF
 
 test_expect_success 'identical modern --type specifiers are allowed' '
@@ -2503,6 +2504,29 @@ test_expect_success 'unset type specifiers may be reset to conflicting ones' '
 	test_cmp_config 1048576 --type=bool --no-type --type=int section.big
 '
 
+test_expect_success 'list --type=bool shows only canonicalizable bool values' '
+	cat >expect <<-EOF &&
+	section.foo=true
+	section.number=true
+	section.big=true
+	EOF
+
+	git config ${mode_prefix}list --type=bool >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'list --type=path shows only canonicalizable path values' '
+	cat >expect <<-EOF &&
+	section.foo=True
+	section.number=10
+	section.big=1M
+	section.path=$HOME/dir
+	EOF
+
+	git config ${mode_prefix}list --type=path >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_grep "unrecognized --type argument" error
-- 
gitgitgadget
