Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D644E646
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837863; cv=none; b=lFf811AiqHb078+v9ADcpfOdfsSOSJC3YA0AibMrRwHg1Mg9xv5CFB2syuHJLqEsl9YKJQEQBJYaDbNLds7q9CjHS9eJUM1jM7m0KLU4U6kxfgjQsmG3U9m5wSVolpAu8gzoTbanO7m78TxwpRqx5p8eOi/ONuvXD5/32FeFIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837863; c=relaxed/simple;
	bh=DYUMZ1kZT/u8z/kCU7r8+wcAzD3RmanrZyaoJ4dxgwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOPAvudH9UXDo/RK4ji/V7G1KxEd03wuYwbv4/oh07aIt0z4GUZXJ5vc9+mTVa3G/VPMGWovyd6VkQi3p8Xum528EJvZZzgZhZQiJZYnne/B2TGBfyuwTkQ1b5zc+W1rHSUg4YxwxoxPU308Gb7DMnRKZ/qhpFkMXfnI+NKpo2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sphtKNnz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sphtKNnz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so32119415e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837860; x=1786442660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e89aOLQPUwk7JVPJ2YZMOuT84NJzdRwlIQEwLfqRU50=;
        b=sphtKNnzIATciKVLCiOT805wCB/NGfFnIM7GZukTKt3vdyHd9ST7bGlQzyuQMG+88V
         LA2mbuIbIeLYTKixnFBQbV9+51BJF1kAILIFMKGlLjXFVukq0fCr+p5/Em2DW/HTYh8J
         evpfThwcAItV5hlt4Ljt1v9BpO0JsSIs/p0iPWonzT/ymcq0AYJ7WsQt8iWhDVapzX8n
         BIeYcEOJIkzqUpyFltQIEZOV0yZwJn4YbPwOAVYjA4c+OTuf4i8HHZrStNcVu8OvYwRx
         AJe9ia1GY6ED62NSxqs8X6M2BiLCgz4Gi6si4LkmSmdVWp5glmlNO/TX0qsvbn8/rHTx
         5O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837860; x=1786442660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e89aOLQPUwk7JVPJ2YZMOuT84NJzdRwlIQEwLfqRU50=;
        b=RXqvTM8f92l1sMiRerMAu0Q5rKU5mJew4ai+spTX3yCRtNnDSzdUMnQU5Y677d2C+/
         Kfu28XfiBSCxrkzGIMcNZfSmDj9upVGXrzV5qw+Rzs4sSes33/skqmHgbzTBNTdi51ZM
         5RVTN2J4fM8E7+NgbM5TQNwIMvdqNvBMj5O+lILVoIN9Hee3QkIJ81CO6jjCCwzBDrN3
         EUEJmYdDbtkQ4ZZBJZpOYP5C3qtoICQ6Co5x+eFOPBQYY9rFJwzwLmVLhBpw+c8LZgze
         RXa3Kgbkw0AUX2YxdHkcQ56eAoj0tf1c1A0vibHNt+LIGY99yXa6v9BznSDbSOLwKDHE
         DJ2g==
X-Gm-Message-State: AOJu0Yx4igMpdmaGIkVL9l246ho8f1hsNn3lgbosGC+xuMdHUOI5M8zR
	3Se23ceuhlxrN3nNrqUm1i3yiwEgR5IK44lh74y0/71OfhRUfc5vEEF6e9b2bA==
X-Gm-Gg: AR+sD127NcQhN3VSXUcUKsG4v1VA1vCsA5rCt3es3YSOW80WYqpLx9J3csk4BsLtImp
	Hcp31N5W0aM/yAFQ9tKswgWISoYRFv8ZheU4B8jdLx3S8r+W4OLcwHlwt0ksd0AZ1OloljXFiT9
	BqAY4MFQ6de1WC+EOEebRuvHzt+vzTQ+hJCVj3H+5szOiDIXmfDvpnVqXZmN5xI492JkFbTtCJX
	CadbYDcZvZPgO0thbElFdvNCPnv3/1StF5dxqNiYAxh+60g2bS+AI+qT6WLMYhBjiSR3I5RUze2
	NRym8ZBoY0AwSAylBKLzzp+D8uXTaj8jNMGT8PdGwkWDzkuQZF97WX79nuAI3puMuSVg3O3wakM
	2cdYxf9zuiUhcwa3HREBuw+rPB9S+DTuvNq0BMym8ile9O6AUXrLgZ9NnhFRGBL1LHfI95mZtEM
	7Fs4zmKX7bQ7Ko2x+Y0A9F25fu/NHyvnKoStd7VvEdKFK2fOdgdq2h+j6tIY0eJ1yfH8N5n8YFJ
	3jsRqEvTTW3VUvd0rqVfm/GZhdnI+Ir+YqNK+hMlTCFtBU7VY5/OIPbN+hFKgnLeLyZQOygBlls
	rqsz8AYa/x4Q
X-Received: by 2002:a05:600c:608e:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4980c64a978mr393847675e9.7.1785837860346;
        Tue, 04 Aug 2026 03:04:20 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:19 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 01/12] parse-options: introduce OPT_HIDDEN_GROUP
Date: Tue,  4 Aug 2026 12:03:44 +0200
Message-ID: <20260804100355.1299498-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hidden options are not shown by `git <cmd> -h`, but are still shown by
`git <cmd> --help-all`. If there are a lot of hidden options or if they
don't belong to the same categories as other options, there is
currently no way to properly group them.

Using `OPT_GROUP("Foo")` means that "Foo" will always be shown which we
don't want if that group contains only hidden options.

To provide a way to have groups shown only when hidden options are
shown, let's implement an OPT_HIDDEN_GROUP macro.

To test this new macro, let's also improve `test-tool parse-options`
and test its output with `--help-all`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c               |  4 ++--
 parse-options.h               |  5 +++++
 t/helper/test-parse-options.c |  4 ++++
 t/t0040-parse-options.sh      | 25 ++++++++++++++++++++++++-
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 08c21d9fc0..4519ead9dc 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1414,6 +1414,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 
 		if (opts->type == OPTION_SUBCOMMAND)
 			continue;
+		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
+			continue;
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			need_newline = 0;
@@ -1421,8 +1423,6 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 				fprintf(outfile, "%s\n", _(opts->help));
 			continue;
 		}
-		if (!full && (opts->flags & PARSE_OPT_HIDDEN))
-			continue;
 
 		if (need_newline) {
 			fputc('\n', outfile);
diff --git a/parse-options.h b/parse-options.h
index 3ec8ba5cc8..d7f896a933 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,6 +237,11 @@ struct option {
 	.type = OPTION_GROUP, \
 	.help = (h), \
 }
+#define OPT_HIDDEN_GROUP(h) { \
+	.type = OPTION_GROUP, \
+	.help = (h), \
+	.flags = PARSE_OPT_HIDDEN, \
+}
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { \
 	.type = OPTION_BITOP, \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 68579d83f3..f181f0c02d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -209,6 +209,10 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP("Alias"),
 		OPT_STRING('A', "alias-source", &string, "string", "get a string"),
 		OPT_ALIAS('Z', "alias-target", "alias-source"),
+		OPT_HIDDEN_GROUP("Hidden options"),
+		OPT_HIDDEN_BOOL(0, "hidden-bool", &boolean, "get a boolean"),
+		OPT_INTEGER_F('k', "hidden-integer", &integer, "get a integer",
+			      PARSE_OPT_HIDDEN),
 		OPT_END(),
 	};
 	int ret = 0;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a22533f9ed..449fff4d34 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat >expect <<\EOF
+cat >expect-part1 <<\EOF
 usage: test-tool parse-options <options>
 
     A helper function for the parse-options API.
@@ -41,6 +41,9 @@ String options
     --[no-]string2 <str>  get another string
     --[no-]st <st>        get another string (pervert ordering)
     -o <str>              get another string
+EOF
+
+cat >expect-part2 <<\EOF
     --longhelp            help text of this entry
                           spans multiple lines
     --[no-]list <str>     add str to list
@@ -67,12 +70,32 @@ Alias
 
 EOF
 
+cat >expect-noop <<\EOF
+    --[no-]obsolete       no-op (backward compatibility)
+EOF
+
+cat >expect-hidden <<\EOF
+Hidden options
+    --[no-]hidden-bool    get a boolean
+    -k, --[no-]hidden-integer <n>
+                          get a integer
+
+EOF
+
 test_expect_success 'test help' '
+	cat expect-part1 expect-part2 >expect &&
 	test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
+test_expect_success 'test --help-all shows hidden group and options' '
+	cat expect-part1 expect-noop expect-part2 expect-hidden >expect-help-all &&
+	test-tool parse-options --help-all >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect-help-all output
+'
+
 mv expect expect.err
 
 check () {
-- 
2.55.0.492.g44bba30fd7.dirty

