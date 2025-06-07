Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEB1EDA16
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289544; cv=none; b=iwksTQmcofv2Ox1Ajl3MlaqnY/JGFbgHZVPAB2yOD26MHZ1vHkNZ25lQEHL/yOzmknM6TDg10hQztEgFzvf+UXnt0/HQtADGReChbTYjPQyQQbCdaWMeV2tERLSvDI6Ad3RtQ0DiwSs0cwDpHtKnSbBhm+hSZ5R9PNIPmt3JweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289544; c=relaxed/simple;
	bh=BuOPKOnUiUT4LJIiZ7Ejaisx22FiediRbECQlBqLHrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDk/8HGHohU+4OugnZ6HlQmX+13oyX9CFnm0g7QAAOWCVqoFx4Z571teGEcI66w9Zc9fCuWX1xXmqmRYUjxNHWpMgMswbWlpjbn+b82YauRdeElxuqSJjewIxjBba+sDs5TSSbZB9K4wajwM+AeWNIe8tolSVaqgXHS6ZtJ5BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnuyIEb0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnuyIEb0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so37384625e9.3
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749289541; x=1749894341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ue+Etvo0TpRSm4ijYPgC8H/GuDBy/rYHY3+3X/Klwyc=;
        b=mnuyIEb0E1vLvoW40A0chXIM+i23XF6sd0clCSSZdB5cIcBiKAGkjFKagKxW1qkJOY
         0wwCpEf+KnOtA/YZJ1SPIpO2OOPr4zLoXtW4xErWcTHgMySlV6Il8/ehRvgwWGHnkRyO
         fR9dSEOtPq0fr21JsXo5iF9ZMcOM4wPZeLBuAgD5u7yZ1Raa3QCPOgPLgrOkq+QdkVnl
         NrROXe1n0cKYdMnnCbtEI3zDFU34dTW4wzTxcjCMjq6+9v+PCMxQciBo17Oi/mMSi0ij
         CpNYD6o9tl5+F3GuSAHHCTX/LntCYMIqLnuK3sA3QZJSwaKjPIL21LlUTymj0pw5O2aF
         bC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749289541; x=1749894341;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ue+Etvo0TpRSm4ijYPgC8H/GuDBy/rYHY3+3X/Klwyc=;
        b=Us+Rs4ydvblKy/kFFBOXrwa/Etf4YgqbUzYKE+a7QiqUwgQHjo0TEemo+a/WlLpM2h
         wiCOwo8GoyEQthqy4mXVF1lRs2gl5r4joRWPKnGKlUGNngQ0pYfy43Tpbif2ofIn7LZA
         RepZUOHvYgttahRvnL/8qRMEkRzTcRmdyKxHoccmLc3HVVS8GF5MOduAp5Hhg9C1DbqC
         sHIQZS/XYFGcYVxQx8Jy6nhs3o0c83pXCFt9Gwts4hOo6XetovdP8U69uex04rcFwqP6
         38kXQ3EOSveY1ru2ZKUPWcOpepQs05EILiJvEq4fAX9ddVTZSNEaluppjg0CQtdF3tok
         kOfg==
X-Gm-Message-State: AOJu0Yw+qJDHeXOdjX2OjQZOuVMNqrKL6O6Cac8qCNI8M8Kt9zzr+80r
	0dJg8RYNCpjt7KYfqyUCoK8Y0+P6Q+7ETp8kR3gaW1LIbWLHG3ScbFtBZDQtHA==
X-Gm-Gg: ASbGncs7YuxVmLbXboz8Nx/J47OZAtkOjljn7FRjNwpDTeYMU/D7XDupWVDcGXrzAJh
	8w36KQSOijHFByUQ2AmsT3n65NRQ8AYVVzpOPfQ7As8GqqPYrSzvGSt4aqkZlcGUfOxTJvyX37R
	wFe0PMz45iFKXFf0T4KPqq1s051w++zUHQpiQHaSynXuOXcXRpgSMtpTyi47A96MaNjKII1pBMy
	HY2Ax7oMXCmLt/WMJHrLnA8HlptCEhy0YxQAeGwnW655dSeOKoVrRe/4rWNeyukkhrQZ2XGsAxs
	5N7tTjLxMsGUnW6aJMEstMgwnv7HzNwBIHj9ByD85DDs1DIl6IhCLOyfwD6fNaQuvgI=
X-Google-Smtp-Source: AGHT+IFlav+ThiJ0JkZf0J3vsSNnygrA4wF1mJQ5UOiK6wxSM6YzIean1YGfV2kP+1W2erFfQky5gw==
X-Received: by 2002:a5d:64c5:0:b0:3a5:2ec5:35a9 with SMTP id ffacd0b85a97d-3a531882274mr4829889f8f.3.1749289540928;
        Sat, 07 Jun 2025 02:45:40 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c7761sm48351795e9.32.2025.06.07.02.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 02:45:40 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/2] stash: allow "git stash [<options>] --patch <pathspec>" to assume push
Date: Sat,  7 Jun 2025 10:45:26 +0100
Message-ID: <d3a958430554cd4db7ba6dc7fdc20bcd5a3cdcad.1749289514.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1749289514.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk> <cover.1749289514.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The support for assuming "push" when "-p" is given introduced in
9e140909f61 (stash: allow pathspecs in the no verb form, 2017-02-28) is
very narrow, neither "git stash -m <message> -p <pathspec>" nor "git
stash --patch <pathspec>" imply "push" and die instead. Relax this by
passing PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then
setting "force_assume" if "--patch" was present. This means "git stash
<pathspec> -p" still dies so that it does not assume the user meant
"push" if they mistype a subcommand name but "git stash -m <message> -p
<pathspec>" will now succeed. The test added in the last commit is
adjusted to check that push is still assumed when "--patch" comes after
other options on the command-line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c  | 10 +++++++---
 t/t3903-stash.sh |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index bc2c34fa048..b12fd6c40f1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1789,11 +1789,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	if (argc) {
-		force_assume = argc > 1 && !strcmp(argv[1], "-p");
+		int flags = PARSE_OPT_KEEP_DASHDASH;
+
+		if (push_assumed)
+			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
+
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
-				     git_stash_push_usage,
-				     PARSE_OPT_KEEP_DASHDASH);
+				     git_stash_push_usage, flags);
+		force_assume |= patch_mode;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a99a746221e..2bba3baa10f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1177,13 +1177,13 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
-test_expect_success 'stash -p <pathspec> stash and restores the file' '
+test_expect_success 'stash --patch <pathspec> stash and restores the file' '
 	test_write_lines b c >file &&
 	git commit -m "add a few lines" file &&
 	test_write_lines a b c d >file &&
 	test_write_lines b c d >expect-file &&
 	echo changed-other-file >other-file &&
-	test_write_lines s y n | git stash -p file &&
+	test_write_lines s y n | git stash -m "stash bar" --patch file &&
 	test_cmp expect-file file &&
 	echo changed-other-file >expect &&
 	test_cmp expect other-file &&
-- 
2.49.0.897.gfad3eb7d210

