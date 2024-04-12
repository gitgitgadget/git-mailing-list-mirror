Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54796148313
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942106; cv=none; b=sCJ8eGe0UKQamscjThiV7HG0YbYax++6zqBdLlORqmjyb9YulCj6Ub5Dhf4UpR4JQQbRIFOpq8w0q1OeFZbOhQ1PZuzPwYJSqvLDjfW92nEQobIIm4R6N+F4CNzlwSmRf2wIQgVHlN6+zXCzXZLjGDbuwCqdy0DdGlNImUSu1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942106; c=relaxed/simple;
	bh=iz3dzizcAU8VN5t65yyyulNyyzIKQZz6WS5a/a1KPFU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cHwHlM9jGK3WyCj61KweqjtoorexZhzjPVB8dNwBBfRUAy8xFztYlj8ncau7Q8z7Sal4MtljCVC10BBLLHd+JiwvfQMyf81F720Lq3NrLGrRPuEZVBSH+hvONjqTRw4TKBTwhKtgRBfSTEfQeA2/XiyVgwiKZzOh3Q4Ra1CbgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM1kV8sL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM1kV8sL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-345b857d7adso787817f8f.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712942104; x=1713546904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2iyYsPLn2nTK7G05A/xfGMdG8wlafCICRd1HtWVULw=;
        b=TM1kV8sL+5+tfmpttxj1FY9u00xWizwm2RpLe5o/hssil7gFX9nMTgb14Zlj+0xh65
         NKX6OFOE1+njS2vELZzZRI22FSixTuq6IYZGqllk4giDxB53rYULBSdMzRf72UCJCSXk
         QJKVxmpIBNeKjdNzTgdWrYCO+BYNXEB9cwB5dSzlw601JUfrqbPUav4cNYIS6IaT2IZF
         0ebe+E3IYw1JVmsQF10nSkGOxR3lAaQX/u682QYU+iYbIf+CpvaxKg7E5+ZF3bFc0vOX
         G9eAQeVSHYTmErHyko4Zon7Gqz9QjE8Ikt8A/1CjDmK1xZlQmD+hT136y4wysmyV7DeS
         sIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942104; x=1713546904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2iyYsPLn2nTK7G05A/xfGMdG8wlafCICRd1HtWVULw=;
        b=Y+6WYUEXUHh0Svkkv3a7eFsTDBAM/ITAGVH4bxDlVa8wYjfw5wb1JT42pW5yGjmQ4h
         MGL73SR8V2yROlS1w0WNfAHGlB1llsk9yCGxWHsEHfwtr0lJtY+rgS7pMUl0695vKjx7
         XtB8did4kbr6YdIuptNM2C3mLgammbcuOBHalZoNEdTSKUMueOYEQSFYJkJYx8Q/k2hg
         oF82k0+MVY2Lavi6MNRcHQNP8JJvGIqwS6WAkSpu3XMJEmvrDUO1CAhBrOO4cDwOuNRI
         74WFnc7u//71SKELOPZFP7s2tVZU7WvsNyq8g1XyBd2X0/dJKgnxJunPW+Lu4yGyc6yx
         ZTIg==
X-Gm-Message-State: AOJu0YxD4oVHjY6E533gxqpFItr+xTyl+cxLWmzVL+kgpdQ+/WuwZdFU
	d7AdXkhy+/UEzCgVDbW9UjQPdikHbJxyjCZSDhN0B4cbIbqcYgryrL4Ujg==
X-Google-Smtp-Source: AGHT+IFlrGyT/ZXuTI03Ufsk5n6tg/UUbXdW7SkJO7JbsMayntMqGJQuYVr7WjPjS4w64aeftjfRGg==
X-Received: by 2002:adf:a4dc:0:b0:343:e86f:6f2d with SMTP id h28-20020adfa4dc000000b00343e86f6f2dmr2353646wrb.10.1712942103575;
        Fri, 12 Apr 2024 10:15:03 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d5388000000b0034335f13570sm4679026wrv.116.2024.04.12.10.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:15:03 -0700 (PDT)
Message-ID: <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com>
Date: Fri, 12 Apr 2024 19:15:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/2] launch_editor: waiting for editor message
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Content-Language: en-US
In-Reply-To: <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have a hint shown when we are waiting for user's editor since
abfb04d0c7 (launch_editor(): indicate that Git waits for user input,
2017-12-07).

After showing the hint, we call start_command() which can return with an
error.  Then we'll show "unable to start editor...", after having said
"Waiting for your editor...", which may be confusing.

Move the code to show the hint below the start_command().

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 editor.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/editor.c b/editor.c
index b67b802ddf..1da3a26f5d 100644
--- a/editor.c
+++ b/editor.c
@@ -64,9 +64,21 @@ static int launch_specified_editor(const char *editor, const char *path,
 	if (strcmp(editor, ":")) {
 		struct strbuf realpath = STRBUF_INIT;
 		struct child_process p = CHILD_PROCESS_INIT;
-		int ret, sig;
-		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
+		int ret, sig, print_waiting_for_editor;
 
+		strbuf_realpath(&realpath, path, 1);
+
+		strvec_pushl(&p.args, editor, realpath.buf, NULL);
+		if (env)
+			strvec_pushv(&p.env, (const char **)env);
+		p.use_shell = 1;
+		p.trace2_child_class = "editor";
+		if (start_command(&p) < 0) {
+			strbuf_release(&realpath);
+			return error("unable to start editor '%s'", editor);
+		}
+
+		print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
 		if (print_waiting_for_editor) {
 			/*
 			 * A dumb terminal cannot erase the line later on. Add a
@@ -83,18 +95,6 @@ static int launch_specified_editor(const char *editor, const char *path,
 			fflush(stderr);
 		}
 
-		strbuf_realpath(&realpath, path, 1);
-
-		strvec_pushl(&p.args, editor, realpath.buf, NULL);
-		if (env)
-			strvec_pushv(&p.env, (const char **)env);
-		p.use_shell = 1;
-		p.trace2_child_class = "editor";
-		if (start_command(&p) < 0) {
-			strbuf_release(&realpath);
-			return error("unable to start editor '%s'", editor);
-		}
-
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
-- 
2.44.0.771.gbd07cf668b
