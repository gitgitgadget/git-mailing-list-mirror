Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB70337114
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392954; cv=none; b=cmApOt2oSJcu5vFH6rJnn+Nvtf2YZQUo4pSSwbfOTqhfOs590qfs5r2yXOF4WoKz5nfNk4gdgSV+hgeP5Ar1YWdejYBJU2NEU4tt+Uj87YEqASmVNngv7bVzakYJR5JheoPwBPUwM2FVPoEXvkUkvg4/iO+WmpzOPbi6Ypj9J+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392954; c=relaxed/simple;
	bh=GmRPbnAYrBu8wnv4QTpNshhmudoEn3YwaqNGYYI5MuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5AMaJYRutjMWscCqmWJeH7jQSHewnvTtZJ1LMoHo8lVwfWE72RMOTHbbpKTeqlk+XEWzL9Q+7LGvFeaShtpSemDMmeDM2xP61a65pofF7RJ4UMOQfYbcjGV/y2MrJIMlblLNTkrcfVgeTSfvVXeI9GsW7irwyw6Wz8+h2b1mNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn8/vWsb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn8/vWsb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so2872526b3a.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392952; x=1763997752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwB+0MKrVwLXOQD1L4BAEhIJlVB57fH/gZU02b4ieCk=;
        b=hn8/vWsbZowPBIgvmtijdYW++FzvUc5M6JUwWOC8YFDlMfaAmrNDpNWkaTOEcRhSDi
         OQoIcMpRDM4QJuI5ZHnviknyjUKq/+XQ+zgxmySEeRBYqoe7ula2Yks36FJzNHgA7XWe
         xJwZmickRLp39glPpu45cV4/1TUghhfB58UUigTkL1QGlAf+qbnihznYcN99TZtygRkP
         zGCdZ918sm5MIFcTsbQoDimMa8GO3pR6cai7ewSpl+SLGbH6axrLQQ9muD5aCo/YCLcZ
         VVyB5TlaOvxcm/HtV26dI0ho5kYoy1kU47wLMyn9/9n1Vs/clP4uEkoOYnQgyjxu5FK3
         bedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392952; x=1763997752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwB+0MKrVwLXOQD1L4BAEhIJlVB57fH/gZU02b4ieCk=;
        b=TVgKydCkQKPgLNsuYeC8RnXfZmjvGp5aevjvgk44k7Il3xA5wqb/jB7jOqB1GRo15t
         14+kFZIVXeFJISJ8x/UsecyXckR/ALkzhZ9Sg2j7xE7apjlBKeBBfJ6dAI5uXBVk/CZZ
         +O2dnOPytJUhf0RDy0MD9PhAMZJaQTx8ktNOCLfCJVBjt6bA5ikXswXo207t0hLSQ44V
         WCi0wWmM6zspA/iGbiTHuWInnmIDl4ArfVvq44v7O3sqKhwPZ2js17JIMjU7yhH6wrxv
         e7l/WaGl9pcWljv6v+GhHBdkBJQTca58BcQ0EM4Bxt8NsLRoc4ZoGE+6plmGk1TvfIzw
         E9zQ==
X-Gm-Message-State: AOJu0Yz2kIKAGpgLfgMz7/yhwgI/J3xx9F64RQzyqJoGJTe1ftQOJKY4
	A0K/gEhqdmKc7sDeelvT20HYGZ88GHtCgxngZI6kTzevoNovf6VSf+ON42S89Zkw
X-Gm-Gg: ASbGncvwWH0pvAYeVmvkYVpiUHrsynalgFJ31wDnAZ6Klfq5InLG7nkHc3DW5RxHb+S
	m/33SsONkOGJZnmtsEV0glI2DTNPUwhmsd1Y+L6UmHi8jB6vS4mgC66SL4W4cljfanoWB+7Y3Tc
	JUzI83/YQiVwMXfXQL0XIyLzkxVkeJxdgSu9ZJsZjVO+EuWqrjtZ+IqciPD9XuEtfs2o3vo3K6v
	j45/ojQJV6/1byEApkP3YGvSgmGY86v3ffPq++HmyOLUlz63fF+WIpIFdg9OvaDzKCVjea3WSV/
	6sp//9Tf8EiQl+vSGoJ1mDT5brhuYxveGoHsDx6nwDaeTek9VzerMAYywe4at2kAI0p5iPBEtgR
	MVOpY/HmND8NwBorMsiZi44MQ3VJBhXYOJly9bpDab1o4Aur0creT39seNE7tv9h5HmIV5Msbuo
	Hbha3gcVvlY0zEeLy+zmttS3UFSHXsx+V1gEW++LAjIoE1RDq2oh2wAtOkWqLVl5devLEI
X-Google-Smtp-Source: AGHT+IHzXPeOpJ3H2CbbuwDdPc+VyiX1Gq57WsQTQPQzcDFiRQPgTcxW5PTy5TSAggq1LL8Ww+CV5g==
X-Received: by 2002:a05:7022:4413:b0:119:e569:fbb2 with SMTP id a92af1059eb24-11b41201712mr6754268c88.33.1763392952014;
        Mon, 17 Nov 2025 07:22:32 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm50245998c88.8.2025.11.17.07.22.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 07:22:31 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 1/2] repo: factor out field printing to dedicated function
Date: Mon, 17 Nov 2025 12:02:51 -0300
Message-ID: <20251117151844.14802-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117151844.14802-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the field printing in git-repo-info to a new function called
`print_field`, allowing it to be called by functions other than
`print_fields`.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79b..f9fb418494 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -85,13 +85,29 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			const char *value)
+{
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		printf("%s=", key);
+		quote_c_style(value, NULL, stdout, 0);
+		putchar('\n');
+		break;
+	case FORMAT_NUL_TERMINATED:
+		printf("%s\n%s%c", key, value, '\0');
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
+}
+
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
 			enum output_format format)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
-	struct strbuf quotbuf = STRBUF_INIT;
 
 	for (int i = 0; i < argc; i++) {
 		get_value_fn *get_value;
@@ -105,25 +121,11 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		strbuf_reset(&quotbuf);
-
 		get_value(repo, &valbuf);
-
-		switch (format) {
-		case FORMAT_KEYVALUE:
-			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-			printf("%s=%s\n", key, quotbuf.buf);
-			break;
-		case FORMAT_NUL_TERMINATED:
-			printf("%s\n%s%c", key, valbuf.buf, '\0');
-			break;
-		default:
-			BUG("not a valid output format: %d", format);
-		}
+		print_field(format, key, valbuf.buf);
 	}
 
 	strbuf_release(&valbuf);
-	strbuf_release(&quotbuf);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)

