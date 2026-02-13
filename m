Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A333BBD9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026946; cv=none; b=uD1lSbWQpoDeJgVjmyxvrrUK4Qn3bsVVLasjzWdnXYK48kQvT2tDkTDwbJOdLg9eGSm3m9rvh6ljO60XOwG6RI/bfv/KzXsQ6ltP8l5nTEtgyU/nmXSVsdNaM/pN5PbwSkeNaKMWxkfXPxIH5b1sZt02KtLs56M4bcDI0lWSTi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026946; c=relaxed/simple;
	bh=T1nqel8NkWF99/pTNJOpZ+fsaS9aU9DBgTdIYh1rNqs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FRf4yYDZ/DG2cwuiu9PMwnCLhxGDFw+nLv4arPgtvqpR0rCAqxDLf6AISyVcXK8rrUklARe5hVRaqg/Zmn4ddlVH/RTPPk6WHkZtdERdjkgv2zCmCwzZTnSVPdY2p041an3ePdSgBdm6e7ZDISekkCyxFohX2GRB2stn8HjsfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX1mPxIt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX1mPxIt"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb49f63238so44376885a.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026944; x=1771631744; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y72pMqs9yEyscWB91fyClow6wxiBSt1McfKC3DosdIM=;
        b=FX1mPxItrpbPj7qOY0buPOJywzItU+PlFrlFtoPOKjGs6NV1dai1VtxsZrSrwQoA18
         OGjNh3K5pbC9u9DtN5DrNXff6XrF2Bfx63ka45SkZ7fh7eplQO46b7agfCsgPHQJIMvm
         x8hrcgUQifJMjxppEkT3xg7g91+ZWm2UgP4EHVUzAi1qpCM0jbiB2WlXFFgLrNPoIb1K
         MAhmz6QMPZWXnGk7N5d8hWIk9gouCZDuP15ScxplUh54xwHNA+dGr7oUSuVV3Dnz9bDu
         nF1jOFma4B9VEX5VtpHgh9SL+gzo9G/zS/H/6L4hZPo39oYrfQmItER3ogIwRnjKtWx5
         L3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026944; x=1771631744;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y72pMqs9yEyscWB91fyClow6wxiBSt1McfKC3DosdIM=;
        b=gga3JzZKzNr+kOk8NOhUCZKa1VE6G/bZFo34+T2gJjeUPScGLcysgy6eXlYy3GQsbY
         G3f+m+9wWlAXzix+Se3biJqKmyarx27MW9jmensDIHpejF/XrSfDT3KvAq0X5kmlPrl5
         RksLEyF5KbOPs3nFKbysOcou5RS6KMvW1RJSoHPLg5Jl7lJ5JgBai9NmttjnjZpPUJNr
         /8LOffpa8EsgqhjvxMqoG1COXjS7mojOblhUHOj0G5Q3YyTOY8l0Avtk7dSZzlGVDF5O
         0QlsXRcKgqBuHYXkaj0JtMMcJgoN0A8ykM23O/S5IPu3RJD7NJNcRZgXkzB1smD/uf99
         d10w==
X-Gm-Message-State: AOJu0YyJQ/+rYIuqe/7e88/wg6aBbhEplTfvMO0ZMUPjnGI3hnJJNW42
	0hn5FR1ZnOP2Va3fajSJZCDSl+Cev+gGh2TKmmqOLtLDD7sJpEfibrgkCdtK5g==
X-Gm-Gg: AZuq6aKVyCMRaIQXgrZhCDdHl/kD5RYiFMAU3PdV6UrR/9eN6X4OeH0LSRVp1oh1262
	5dDohI2cEtvsCLAhOu7oraoYmXe5s2+CgKztmlZalaofuUcsVigp2O00LHzzXvRyzA49Y66ewiX
	S7PGfGtURd/74txuz3H1sQMSJbxACNZFL832butc8XtcrSKM1pvpTWVQF78R2pvVEHYZ0slCB5A
	CGONsRWJlb7zNyqwSC+jiR0cqi13i7l9sAVRu+MMG90Pc3MXpIWOcftJK25XH+RAqyv6I5D005/
	Sa5w9crY7BaU1A/ypuGRt5Hfke5IDTZSVjyuYdPbBCxxW3LuNDg3G0xZikazam99uj8znqWEfsC
	wJuK3OJApkUW07IRSyc54rSe3YrxrI7pLOyrEjPjH3NWrse4fRchlOlx7vg6MgdUEbojgfXSL6I
	wK6zI+N09rmcHNGh3BMur6ndSh
X-Received: by 2002:a05:620a:460c:b0:8b9:cf85:40a0 with SMTP id af79cd13be357-8cb4245fea1mr421057685a.57.1771026943835;
        Fri, 13 Feb 2026 15:55:43 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847ed9c4sm73823291cf.8.2026.02.13.15.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:43 -0800 (PST)
Message-Id: <d14937e6d1e4e33bb7892107061807f2b3bba3d7.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:17 +0000
Subject: [PATCH v2 12/13] config: format colors gently
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

Move the logic for formatting color config value into a helper method
and use gentle parsing when needed.

This removes error messages when parsing a list of config values that do
not match color formats.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 27 +++++++++++++++++++++------
 t/t1300-config.sh |  9 +--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 71b685d943..e8c02e5f21 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -354,6 +354,24 @@ static int format_config_expiry_date(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_color(struct strbuf *buf,
+			       const char *key_,
+			       const char *value_,
+			       int gently)
+{
+	char v[COLOR_MAXLEN];
+
+	if (gently) {
+		if (color_parse_gently(value_, v) < 0)
+			return -1;
+	} else if (git_config_color(v, key_, value_) < 0) {
+		return -1;
+	}
+
+	strbuf_addstr(buf, v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -391,12 +409,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_path(buf, key_, value_, gently);
 		else if (opts->type == TYPE_EXPIRY_DATE)
 			res = format_config_expiry_date(buf, key_, value_, gently);
-		else if (opts->type == TYPE_COLOR) {
-			char v[COLOR_MAXLEN];
-			if (git_config_color(v, key_, value_) < 0)
-				return -1;
-			strbuf_addstr(buf, v);
-		} else if (value_) {
+		else if (opts->type == TYPE_COLOR)
+			res = format_config_color(buf, key_, value_, gently);
+		else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
 			/* Just show the key name; back out delimiter */
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index c134d85d8a..79b2ee203c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2553,17 +2553,10 @@ test_expect_success 'list --type=color shows only canonicalizable color values'
 	section.blue=<BLUE>
 	EOF
 
-	cat >expecterr <<-EOF &&
-	error: invalid color value: True
-	error: invalid color value: 1M
-	error: invalid color value: ~/dir
-	error: invalid color value: Fri Jun 4 15:46:55 2010
-	EOF
-
 	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect actual &&
-	test_cmp expecterr err
+	test_must_be_empty err
 '
 
 test_expect_success '--type rejects unknown specifiers' '
-- 
gitgitgadget

