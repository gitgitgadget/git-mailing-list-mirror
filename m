Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A62F509
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFQzz5ya"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74049D
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:55:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da05b786f1dso831690276.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698335703; x=1698940503; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpj38fvTuTGG75+kzt0ajURP0x6ExOj9Y9aurel7TAA=;
        b=gFQzz5yawHVqi6fo38gMLE2m5jPoIu1BBIOrYVJidodiSRGAC/uLTbg14SdXxS/ARb
         x4ZoI9ow0O56JtIbqV7+JbEcNEJxPxm9ZbSuzR0a8utLLYAiLz+XU+ME29MyeIR51n5X
         fsa4b+uexNR9lA43a6CkPr4QiubakjCKwQb7hELZ4SvtWyLtnix68NB6cNMI8UGHDkth
         g6CBub8dW/hjvvnT3ZNjLJsmnVcSIwWMJRYT6TiDEHzLh9KtGPJ0gM2AbOJyP5upaY6q
         tMi4srrme3hvUkaWMhvKQnym7cMmdPYeHv1fo8KEYVRiATjU06Gy0U190EfQV/eUGP+q
         rQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335703; x=1698940503;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpj38fvTuTGG75+kzt0ajURP0x6ExOj9Y9aurel7TAA=;
        b=gToLXyWSUb9Cr8RzocFku6xNPK9Qiptwgy6xDCyf+cYiSqcVomH7jReUjGg2x3HGZN
         2ziOgHzUGww5RQGUOg7egh5+lbxaPJF0/0M0AZjH7b6sX741TSMdZ/+RcbuCWIOdr7qB
         fQdCoYl3xDALt6ZSzZ95GUohbQA4oI2dawbLuzjGca0SBjhCeoyXAugXXRDRWscRY4c9
         EyJuebuWvsxXGu3Xu0NAR/m6u7Lc/obYu4nglZGgFG5yOlF4pBHisn3ymQHDa2szaVkA
         qHgC/e3TYTvlsvlDoNPWkzcpmAN6xef7mXYN1qajwZQE5oEsY71+CW3m2b14ralK02QV
         L8qg==
X-Gm-Message-State: AOJu0YxX69YP3F9Ws9bsZ0tKpNyLOAfHs410zJQgP7/O8Icbhwur2L6Z
	g/67g9EJrhxcNipxyJh7htVsArTwsx3y/Jv2fJBtWYRPzPLWc/AtqCB0O+nFJMF69aZiGLKG9GR
	6QH+EKlFvM53ZBh2qlw/OuHLvRArzs0yXTI8X7K91ZFphyvxMbqQht+gEK7DrMPgvLLAJ4aGthA
	==
X-Google-Smtp-Source: AGHT+IFQEJ33JpzI4AG2mD3vrtt7Wa5LIxBpJzBh6sCmHcnK6owTYUNJBIuBZAkhuDQp0UkAdqIsSLuMN9tw1D8QZPo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d387:0:b0:d9a:f3dc:7d18 with SMTP
 id e129-20020a25d387000000b00d9af3dc7d18mr348760ybf.13.1698335702877; Thu, 26
 Oct 2023 08:55:02 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:54:59 -0700
In-Reply-To: <20231026005542.872301-1-nasamuffin@google.com>
Message-Id: <20231026155459.2234929-1-nasamuffin@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026005542.872301-1-nasamuffin@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3] bugreport: reject positional arguments
From: emilyshaffer@google.com
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Sheik <sahibzone@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Emily Shaffer <nasamuffin@google.com>

git-bugreport already rejected unrecognized flag arguments, like
`--diaggnose`, but this doesn't help if the user's mistake was to forget
the `--` in front of the argument. This can result in a user's intended
argument not being parsed with no indication to the user that something
went wrong. Since git-bugreport presently doesn't take any positionals
at all, let's reject all positionals and give the user a usage hint.

Signed-off-by: Emily Shaffer <nasamuffin@google.com>
---
Per Eric's and Dragan's comments, dropped the null checking for argv[0].
No point in being too paranoid, I suppose :)

Note that after this morning it's not likely that I'll be able to find
time to update this again so quickly, so if there are other nits,
reviewers can feel free to send their own rerolls rather than waiting
for me to see it and turn the patch around.

 - Emily

 builtin/bugreport.c  | 5 +++++
 t/t0091-bugreport.sh | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..3106e56a13 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -126,6 +126,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (argc) {
+		error(_("unknown argument `%s'"), argv[0]);
+		usage(bugreport_usage[0]);
+	}
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f6998269be..5b1b3e8d07 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -69,6 +69,13 @@ test_expect_success 'incorrect arguments abort with usage' '
 	test_path_is_missing git-bugreport-*
 '
 
+test_expect_success 'incorrect positional arguments abort with usage and hint' '
+	test_must_fail git bugreport false 2>output &&
+	test_i18ngrep usage output &&
+	test_i18ngrep false output &&
+	test_path_is_missing git-bugreport-*
+'
+
 test_expect_success 'runs outside of a git dir' '
 	test_when_finished rm non-repo/git-bugreport-* &&
 	nongit git bugreport
-- 
2.42.0.758.gaed0368e0e-goog

