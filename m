Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C2314D1A
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002546; cv=none; b=SsOth5gB0q1TiPPgnPuZDYwDzypMwgVbR5mn9XOcq5PN7DH9z9bB5kGlHaPE8Fv6jaSr/mzWtUy3jUmnr1BSoZjvKJqqbdtMxU7GCmLr6sIHKJa1Hy9DZTGbydhbtkS8GgFxfxWzpEG37ZWmvhZSsNegkz7/YBEF7CdkAjXEE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002546; c=relaxed/simple;
	bh=eeRmCZLXrot/+vH+B2CRZbwcxN2rf0LsOot0gauaq2Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYkXipSnFtvmzghTh5+uQ+hRdCMwwijJkCpUTdsnoBPGRCLZeClKpsheTK7pqEkKysdE0fDBclHX6a5ekxpH7SLbQUEGh2RIj8Lr7CYt+kMYvvcawhB8qCdnMU+u8I0UDKwt0Jyq8gguGMYurPa7TzkLfpRALtpdzfeqiNOGYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ki8J/7gK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ki8J/7gK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so13863895e9.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774002542; x=1774607342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfqF3SLxlgQYmB0uz3anayddGYtzYvn97URgd911Yik=;
        b=ki8J/7gKkn6KIclXVX8Yp7aHP7i07NGuAaUZ7uVjH7+f9WwpH4UjXIBnoB83wC309e
         i0toEjxTs0StMWoDJkpT+yRM0M3wr/WMbdzbsNlqSuqic0HT5E2urF/o6ecrQ6qmk5ZH
         eD2xOnyNLsMlSCgRrr5v0tM8VRsqlLW9Aly7k4QeDtZ7nLIA31PbkLcQc1ZFuNjchkli
         ZIL/C1pZMYYuPB/ivCpDUOH4jf7z0LaNGahda7+wdC+gV0ivz6fZgsW+5PXqUa+YedI3
         X/URSCTmmVBvGvjbiLnBOKUUS6bmGuofItei45+w/b+JsndATamo3AzASib1aT4wXeEW
         SVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774002542; x=1774607342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfqF3SLxlgQYmB0uz3anayddGYtzYvn97URgd911Yik=;
        b=rxyGZmuRfyCYJOPkWfeNXFHuS6f9tz74Sdl+PklcgNOmpXykX7GIUGT3V/+UEiEtCN
         Q+JByasM6ySiFGXYbkDj7aR7VLD20u3vVXJjGVllXYpkddqkMPlxV3pPzszn1SeTwump
         cyErvhGybSoGZ5VEk+zvnan0SH2qhR7lLn24MwZCDYBLUIYiuouOS0mxZkK3gxzByZU1
         gII/UEZtdDiDcuKBIdYBjdovD4qWz8ZyzV/Ut28yrGC3ZCDvwdRPk1x2iEqooMm/QCDY
         vPUiUT2aDfAOPYarq6a6H3Jg8+T9KiU6qLd98M7yIT8PQZmwggCMY0wjUb500XfPrLvv
         FC9w==
X-Gm-Message-State: AOJu0YzJu3+aNnyB5u3Qruzc6NjIrJg64ZGx/ea2APH09bhZXfNHOv2+
	hd/gIlf3C2HoG2+ZJuApt/GpTZilgsXQx9jWXzyrFwnWYzGK6ntM29RtZw38AaIkcZMsVpH1RDo
	hShEdksU=
X-Gm-Gg: ATEYQzzc0s4syypbMy/ku2yo0yYWGokcoY4WVAxqe+H40rzdZV1EbL+1DbrHBrisCu2
	ikShHLuSq/sCGxtvLUYIR0o8ekrQBLujIrlQi+il4lLZU2H03wWtmOOw1MajTKjWRaU6iMpPemY
	/MYw9As4Irbm5fqjCb4NDx1LfodiDWSHbARpceqwLqDGIykEarqdyqyI18ZEnvfz4hrjbJFlwQr
	I+co6LXPg6YxpXKiaBqvuQxdi6/gLpmyU+dBBY38lLh68E0MuAhB5xrah7blJ3QspnQgwydmq7J
	X6xH8qB1rkFVcn+b9tJfEOpzJN25F3ul0VLQpoj0/2ykqJLeSzX1YshIfTCwOhMB8lw8oJdIIuC
	JBt70irdAtMtpM8bi3z7LgfmfUOWyqyg8R3p6qXx2I/ErFdldUL5v8BFY42jyyblK9gIk34eJf/
	ywQEgMCko7vkTavCv3FeSpLJj1pc4xw8rrDwxWLFgjVvi2GA/QhR+oVw6C0TDo1qjhWJDhZbj1w
	3AbjnU6gsA+wg==
X-Received: by 2002:a05:600c:5250:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-486fedab2damr38261095e9.2.1774002542502;
        Fri, 20 Mar 2026 03:29:02 -0700 (PDT)
Received: from localhost (p200300f65f20eb04bea5a3fc01bcee54.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:bea5:a3fc:1bc:ee54])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-486fa35b147sm110740465e9.15.2026.03.20.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:29:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: git@vger.kernel.org
Subject: [PATCH] Add a config option to add a comment to S-o-b lines
Date: Fri, 20 Mar 2026 11:28:39 +0100
Message-ID: <20260320102844.2714876-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=eeRmCZLXrot/+vH+B2CRZbwcxN2rf0LsOot0gauaq2Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpvSFchkfuuOikgJmOzcglflu9PmfFbtAjxjRsE 1vU7D/wdRWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCab0hXAAKCRCPgPtYfRL+ TmZ1CACTkw8W/qAgnLE+82bIkw+thx6yj/8n+UtZ77yF8P+w/rA39vcD7UDrFhIEpeJ2FOMsbIy NVJkwP8dyHdj1vjpMFYRpVA2TcrJ67w0kVJQ3nZCMp9FUk+jQFHMYe5YiNwv+2u3FC18ylGXuzb 8NurU6F5E2OxvMz1kxTVnwnu5yX6Lps12SSVjaHxflIrREcDlgJu2QpIH/IQ4odsyAlljuMe6d6 7dkhoevXfRx22nO5deYvJfqZJ3qLSVs/+49GvFRCnvlOr09DBHOw9lOHC+FGc8uBX1kDitI9gb3 W66oQFtvBSveix02zmxuVrK13CkgSNNgOvQCdCr1dGyEXRo8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

As an employee of a consultant company I'm often requested to mention
the customer name in the Signed-off-by line. Add a config knob
"user.signoffcomment" to configure this and use it in automatically
generated S-o-b lines.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 ident.c     | 26 ++++++++++++++++++++++----
 ident.h     |  3 ++-
 sequencer.c |  2 +-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/ident.c b/ident.c
index 0b7aacecd7d9..09c7823e8f29 100644
--- a/ident.c
+++ b/ident.c
@@ -20,6 +20,7 @@ static struct strbuf git_author_name = STRBUF_INIT;
 static struct strbuf git_author_email = STRBUF_INIT;
 static struct strbuf git_committer_name = STRBUF_INIT;
 static struct strbuf git_committer_email = STRBUF_INIT;
+static struct strbuf git_sob_comment = STRBUF_INIT;
 static int default_email_is_bogus;
 static int default_name_is_bogus;
 
@@ -468,7 +469,8 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!email) {
 		if (whose_ident == WANT_AUTHOR_IDENT && git_author_email.len)
 			email = git_author_email.buf;
-		else if (whose_ident == WANT_COMMITTER_IDENT && git_committer_email.len)
+		else if ((whose_ident == WANT_COMMITTER_IDENT || whose_ident == WANT_SOB_IDENT) &&
+			 git_committer_email.len)
 			email = git_committer_email.buf;
 	}
 	if (!email) {
@@ -489,8 +491,9 @@ const char *fmt_ident(const char *name, const char *email,
 		if (!name) {
 			if (whose_ident == WANT_AUTHOR_IDENT && git_author_name.len)
 				name = git_author_name.buf;
-			else if (whose_ident == WANT_COMMITTER_IDENT &&
-					git_committer_name.len)
+			else if ((whose_ident == WANT_COMMITTER_IDENT ||
+				  whose_ident == WANT_SOB_IDENT) &&
+				 git_committer_name.len)
 				name = git_committer_name.buf;
 		}
 		if (!name) {
@@ -523,7 +526,13 @@ const char *fmt_ident(const char *name, const char *email,
 	strbuf_reset(ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(ident, name);
-		strbuf_addstr(ident, " <");
+		strbuf_addstr(ident, " ");
+		if (whose_ident == WANT_SOB_IDENT) {
+			strbuf_addstr(ident, "(");
+			strbuf_addstr_without_crud(ident, git_sob_comment.buf);
+			strbuf_addstr(ident, ") ");
+		}
+		strbuf_addstr(ident, "<");
 	}
 	strbuf_addstr_without_crud(ident, email);
 	if (want_name)
@@ -554,6 +563,7 @@ const char *fmt_name(enum want_ident whose_ident)
 		email = getenv("GIT_AUTHOR_EMAIL");
 		break;
 	case WANT_COMMITTER_IDENT:
+	case WANT_SOB_IDENT:
 		name = getenv("GIT_COMMITTER_NAME");
 		email = getenv("GIT_COMMITTER_EMAIL");
 		break;
@@ -671,6 +681,14 @@ static int set_ident(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "user.signoffcomment")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strbuf_reset(&git_sob_comment);
+		strbuf_addstr(&git_sob_comment, value);
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/ident.h b/ident.h
index 3c034038791b..bd3cd3e2655f 100644
--- a/ident.h
+++ b/ident.h
@@ -21,7 +21,8 @@ struct ident_split {
 enum want_ident {
 	WANT_BLANK_IDENT,
 	WANT_AUTHOR_IDENT,
-	WANT_COMMITTER_IDENT
+	WANT_COMMITTER_IDENT,
+	WANT_SOB_IDENT,
 };
 
 const char *ident_default_name(void);
diff --git a/sequencer.c b/sequencer.c
index e5af49cecd08..37494b35c6ae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5635,7 +5635,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 	int has_footer;
 
 	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
+	strbuf_addstr(&sob, fmt_name(WANT_SOB_IDENT));
 	strbuf_addch(&sob, '\n');
 
 	if (!ignore_footer)
-- 
2.47.3

