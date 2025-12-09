Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2A307AD8
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309606; cv=none; b=H1ZyO2DLKftmr0lzvY9rl9BPePDfM9XEQvlTUtoVkJ6Wr5AF9xDFogkifPHAkl2VliJY7g04DrhcJlvYdiUAbkdhaYIGfUvsoJtusFxu2LBIa3F2eQ+LB2jSuKnIYIBot+PKs5E4gc0X4Eor9rjJ2Llcgkc0MEnlB2bEaXV9Bjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309606; c=relaxed/simple;
	bh=yYnsjv/kKTUcngawJwxzupZ1aC6LMZrN/+Egyhany04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXDkjsR4Ud6tXbqaLa5crOUkbUxaQVh2iwZYoQqJerYPccPrS3cwvOCmX7EhXaaj1aNSdjrg+W6MY0M0jgLhaU6s9ZSJb4/nrON0uwaKz2wPlMN0BHfWxs+jp/dlCtPCDRL192tQ8KD2CChHSroGLnYs0KX0O093anTkI9I3TKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbC1Qetd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbC1Qetd"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4060640a12.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765309604; x=1765914404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayEWNhQXuzf9zzA9mpdUXgVLKK90sdAcxTfPviCc9JA=;
        b=PbC1QetdAwJ1RS20UTt+djpyi7EEOJECef2uIpq2a/0Ft7hR9ljTjmrMZvnLQz7O3Z
         mg3C7hlbkW3wyMLz3ZoHd60zPVOU9wheBG0fx2+SE7av9AoomPNlorTBxyWjMZrjbsI/
         uL8K8OR3SYYT8XIi7RwO9jXiey1wvnPDO7BeY2glxCCKOjEzKdCxHSfQPONGW9IM1/fx
         eFPL0gEvEoEOPLqBILTJVVhUKFJdfwhnAKBohbifLwq5cXGtAkk1M7fjc1U2whuNjl3n
         jNL0jbXQwnPHvrUe6IH9mCMbmdYcB+qa0VAUyARd3rLpbbsZysx1tCF91Kp6+zYltbRb
         OolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765309604; x=1765914404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayEWNhQXuzf9zzA9mpdUXgVLKK90sdAcxTfPviCc9JA=;
        b=EYWgNvNd05IQ4TcJHOGrQ05U4+Gag617M3saj49h+dGnytsuI0na3J9H77mWz6FeFh
         pn4Dt3Q9OFID5z5bxDia//n7LWQ1FSUY4eNw3tB3Gb5k69KKEOolutruup1M2UaaY6+U
         GKz4TI498UDGTSnc7H80PUI3dkN/F1hC3AIbTv1cyMhDXP2DMCu5v8ScYJtixwSKvbSu
         vm2CgkVOnbbzKOcu3o4CExUBl1dlyeokvCvzdqP+b1qz8cJFlwLjUbzGXZPS/8n4i3/7
         rJ5BdfncpFT1sOsL/q+LAOzJet58F3sq7oBLawVaq0thnbDZnuEBFTJdN4RJOc8QOKkP
         KvYA==
X-Gm-Message-State: AOJu0Yz6Q/6VeVqZFyMwYXmxYYSr7xQLmX+K8LCS3oPL4Y5blM/nIziS
	atqC90MgM0/jioGYNFpiIgK4blMucPgEzNp2BQkO0ZYXgzoBgSraayUGmqYk5DlY
X-Gm-Gg: AY/fxX6Gm8RBfD6AM5dmx/ZptWXWFO+jks1wrlVuZt0DISGE02RZ0Scf0KxRZgbygzL
	brbc3Pu3sMdKRLuD/ij0pt3T4a5kXoD8IAF1+mEnCQIXKRmDvE5oEJQTyTNrUBlRSkYqpz5tC71
	QX54A/C3W6AB3uno35Cn9R7izIclTzjOGsH/3OJPiiSzSMovHK7rqNVj4Yo6HAye15AXITOX4vf
	o5X3ST9tTgzeT+Hvcm0XEacKmOF//TF05MLVUHqCrQvRkD6Wdu7GcOiCUzMaFrnmithvTVte8ew
	nt7109PllJr/alZrNQxqlGeW4HsKOqFo/SW7/lMVcfmKQUdvN0UPra7Q6wwJiI7gj3Gobm0F4+/
	1O224iEgcZSuGYCrnGmHc75B7EoR9ZraKCamJO69mlby9K8Ob0qvhzFTb4/K52c5ZFa/2R34UUB
	4qVSqNQizMw7ljSi39GCo90yR5h/2VTeNnyaObMkxm1j7sIkHvpQ==
X-Google-Smtp-Source: AGHT+IEl8f10yCPyX3D7pl0HdKv5cSevbYEDp3RgJ/M6uwBgHosu0erxy2tHiiJ86TWOQfP3p9n2OQ==
X-Received: by 2002:a05:7301:4306:b0:2ab:91dc:d701 with SMTP id 5a478bee46e88-2ac055c4558mr99806eec.39.1765309604095;
        Tue, 09 Dec 2025 11:46:44 -0800 (PST)
Received: from localhost.localdomain ([177.118.148.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm71077271eec.1.2025.12.09.11.46.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Dec 2025 11:46:43 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 1/2] repo: add a default output format to enum output_format
Date: Tue,  9 Dec 2025 16:36:02 -0300
Message-ID: <20251209194616.61620-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209194616.61620-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20251209194616.61620-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a `FORMAT_DEFAULT` value to `enum output_format`. Change the initial
value of `format` to `FORMAT_DEFAULT` in cmd_repo_info, indicating that
the initial value hasn't been changed. Also map the string "default" to
this new value in `parse_format_cb`, allowing future patches to add
support to --format=default.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0dd41b1778..1cd12e7eea 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -23,6 +23,7 @@ static const char *const repo_usage[] = {
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
+	FORMAT_DEFAULT,
 	FORMAT_TABLE,
 	FORMAT_KEYVALUE,
 	FORMAT_NUL_TERMINATED,
@@ -159,6 +160,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_KEYVALUE;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
+	else if (!strcmp(arg, "default"))
+		*format = FORMAT_DEFAULT;
 	else
 		die(_("invalid format '%s'"), arg);
 
@@ -168,7 +171,7 @@ static int parse_format_cb(const struct option *opt,
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
-	enum output_format format = FORMAT_KEYVALUE;
+	enum output_format format = FORMAT_DEFAULT;
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -183,6 +186,10 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (format == FORMAT_DEFAULT)
+		format = FORMAT_KEYVALUE;
+
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
-- 
2.50.1 (Apple Git-155)

