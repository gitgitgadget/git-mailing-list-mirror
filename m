Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46951211707
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369130; cv=none; b=eer7ntjbNzEZlXzbUD+lLqUrsmYVIdiGgJbYi4RQVNtr/IczVDlBIxJ2+ywdUSX9s4Vl7ldY7ptYtR5PdkfRYbQ4Zq1K+ZtyGj4K0Fw524b+GvrD9bXlR8AfCJtHYmuF8jRIXse8OoN13yVYlma9gXvrOjSM02zhJIMEA7n8quY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369130; c=relaxed/simple;
	bh=SNgM7ev5oZspnkXilnvWJHzdTH0jQUnMKeqq/Ju1mJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNpSb4dbeP0INP87yqqY1vaBeJ47VSFmmHkMeS9z3rTCmHPOeNOZ1avgxnXY8+S5ckBc3QYzE2mRbTCVW3Ox6E2KhciNJQn9FHD24Tmc+jwhQvPkjyGf2mYXZQEPA1icN9KrfP/noQVhfhA0hAYmCnLsOLEb+2TPaL/E2imAIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGFCtujF; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGFCtujF"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bd21f887aso59480461fa.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742369126; x=1742973926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDLZMLZ/XVx0yVCqbwA8+osvBsxeqEQ9KVgNVlqfG04=;
        b=JGFCtujFlEemQ4zq240PEsqEBVjrYMeRd+q+934hYfO8s/gFm1JKh0ma4XCKO+l3O3
         9K/h7w4ot3vUuXpPoWm4uD1n9FXRnrD7LH1eKgrfKNv7jOjbyjZK5R6zfpalpusOz8r8
         9DfGtqbYDdd2m3fKpvleBBf0ZPjH3pS6i80VJnW15bx74PYUGmsyEAFc2Y8+gKVlW27i
         ciQlTZc2rP3KnZgjTjV98k0TlPbBzeNvK209/NtjPBp6fWhjgd6njH1NWUXo/+X+M1TU
         M9BxbnVzmfYkJ6kJ/0McG5RMTfDjnz6O3ENQsjbWrxQKBNFVFkhrf5HWhxR++9oZkD1r
         i5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369126; x=1742973926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDLZMLZ/XVx0yVCqbwA8+osvBsxeqEQ9KVgNVlqfG04=;
        b=I7wi1rsm3I4SirrQyaJhf1EzxEe2pFsVzl3GkPuN/VbSTALZ9biJKcmjtV748gdVi1
         sHLyqEa+sU9TqvtYsR6WK3e2kZnVbxpZgMGulkR3je04rSmMG2l+c0SdNMyIlodXn+s1
         R3BMuhcZkBQkBAYydJtkK2nZQfchjnCzZeGFrbpfX5f5Yjm8Y3G0XJb6T5GyEN35vTFW
         7V/uVKh725FDKU5QVTA24WF0dpEhytUuZyznLKyllg3uUjdyGXgqVkmx+o2zclKT8SeM
         FeaT0BSOa2FH21zlUMnSzeoyRIXGUCGCAwUDE9j8KBaW7arKMYZVl7MBQSj97LV6ZyV/
         k+aw==
X-Gm-Message-State: AOJu0YypGZQ4s6WLIfUOMKRr/sS6llPnB/Q2PY6tNcpPb9QQJ8DDi9Xk
	qvp6AtLPcUqR1dwgkZML1QIeXQghoiEhIDm/Lfh++TWLAKy1olquUoO+Qw==
X-Gm-Gg: ASbGncv0zyPx7qYxbu+pq2MGBo73jKYY3uMQ9D/N6itynDothz8DKGAdUqc1oFatTjj
	RiaxOPxfT/Wpy/zD8kiMDPhXrorJlrj2GzUdmgHhT3kyjTx49TI1WsKDy1oKeuSXpTeh4HIM1k6
	EMw1WQl4mpYBqlW5SO7pzSo4skvRwgrF0hX9YYDr7CryOA1RWy1/eQ0FkBD+90RQGbMfNEIn563
	xVU8BhruRr0lHl14FZautkBPlhq7puH8RQjieGOz0uOaf/AsvPmGxbpiXrztDbIEbKj5pZhGRFx
	dWh0pz1Ss3uoqP1fvg/UJMGneZo2hQa+sJg/4qhGXcMfVI0vFfQLk5a9ls5GuDCfMKlS+Biu
X-Google-Smtp-Source: AGHT+IEukpp04nOZD5cg2LCxdZDGdDa4BcPg/2c5C6esupfWq/ubQAXfW6TRF5CfnoEEmAwKigbozw==
X-Received: by 2002:a2e:a582:0:b0:30b:d05a:c103 with SMTP id 38308e7fff4ca-30d6a43c383mr4774181fa.29.1742369125749;
        Wed, 19 Mar 2025 00:25:25 -0700 (PDT)
Received: from localhost.localdomain ([217.116.228.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f209d6esm22089541fa.112.2025.03.19.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:25:24 -0700 (PDT)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 8/8] pretty: refactor parsing of decoration options
Date: Wed, 19 Mar 2025 08:23:41 +0100
Message-ID: <f4d0d5c00ab7d314d19d82335d7381959ee6fb41.1742367347.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec
In-Reply-To: <cover.1742367347.git.martin.agren@gmail.com>
References: <cover.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After having spotted "%(decorate", we see if there's a ':' and, if so,
reach out to `parse_decoration_options()`. We then verify there's a
closing ')' before actually considering the placeholder valid. Pull the
handling of ':' and ')' into `parse_decoration_options()` so that it's
more of a one-stop shop for handling everything after "%(decorate". Let
this include freeing up resources in the error path to make it really
easy to use this function.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 pretty.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/pretty.c b/pretty.c
index ddc7fd6aab..d5a8ceb7ef 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1430,17 +1430,6 @@ static int parse_decoration_option(const char **arg,
 	return 0;
 }
 
-static void parse_decoration_options(const char **arg,
-				     struct decoration_options *opts)
-{
-	while (parse_decoration_option(arg, "prefix", &opts->prefix) ||
-	       parse_decoration_option(arg, "suffix", &opts->suffix) ||
-	       parse_decoration_option(arg, "separator", &opts->separator) ||
-	       parse_decoration_option(arg, "pointer", &opts->pointer) ||
-	       parse_decoration_option(arg, "tag", &opts->tag))
-		;
-}
-
 static void free_decoration_options(const struct decoration_options *opts)
 {
 	free(opts->prefix);
@@ -1450,6 +1439,30 @@ static void free_decoration_options(const struct decoration_options *opts)
 	free(opts->tag);
 }
 
+static int parse_decoration_options(const char **arg,
+				    struct decoration_options *opts)
+{
+	memset(opts, 0, sizeof(*opts));
+
+	if (**arg == ':') {
+		(*arg)++;
+		while (parse_decoration_option(arg, "prefix", &opts->prefix) ||
+		       parse_decoration_option(arg, "suffix", &opts->suffix) ||
+		       parse_decoration_option(arg, "separator", &opts->separator) ||
+		       parse_decoration_option(arg, "pointer", &opts->pointer) ||
+		       parse_decoration_option(arg, "tag", &opts->tag))
+			;
+	}
+
+	if (**arg != ')') {
+		free_decoration_options(opts);
+		return -1;
+	}
+	(*arg)++;
+
+	return 0;
+}
+
 static size_t parse_rewrap(const char *placeholder, struct rewrap_args *rewrap)
 {
 	unsigned long width = 0, indent1 = 0, indent2 = 0;
@@ -1735,20 +1748,15 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	}
 
 	if (skip_prefix(placeholder, "(decorate", &arg)) {
-		struct decoration_options opts = { NULL };
-		size_t ret = 0;
+		struct decoration_options opts;
 
-		if (*arg == ':') {
-			arg++;
-			parse_decoration_options(&arg, &opts);
-		}
-		if (*arg == ')') {
-			format_decorations(sb, commit, c->auto_color, &opts);
-			ret = arg - placeholder + 1;
-		}
+		if (parse_decoration_options(&arg, &opts) < 0)
+			return 0;
+
+		format_decorations(sb, commit, c->auto_color, &opts);
 
 		free_decoration_options(&opts);
-		return ret;
+		return arg - placeholder;
 	}
 
 	/* For the rest we have to parse the commit header. */
-- 
2.49.0.472.ge94155a9ec

