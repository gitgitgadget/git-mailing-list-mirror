Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD9365A03
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849624; cv=none; b=hvT10+ml4IhXwLs5/P/0wAz9jjZzHhQIGjQmRu6GfaS+bqKEJEU7AubGTJ3iM5TGx805G8DxvgEP/nigFV7v2LHKBHTVkhcPJPOwTOBITi1YRAUFCxbxXCcIrfprJOhlj5J3vVvMzGyto66wButx7kq1XTx1cl3FKGlNzDbOIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849624; c=relaxed/simple;
	bh=1TRGazi899sOFII7dM5ZtIXUkND8xfoY4IokJfu/zz8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZRUdq9x/0AdmOLKsG3td1P4SqAKTnrtIFpP4RZhA7Qe6CxnS0JhDZRDAHPS8AyvSc555m7rg/FOgajhhGoxs/wg7l7BQjpPI7lJwZjFFStN+diIHKXQj1hyEa7m5emnpOHqiR+SBcB0wNnRUF+2XA/zdzI4QdtEpGv/C6EaQHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKAOch8O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKAOch8O"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-797d6f934e2so39955987b3.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849622; x=1772454422; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/8/dI/miYQFdbZevFeKbT9ZWTIPZ6sliYe7jLed6AE=;
        b=cKAOch8OVIg+VxIsoaf/SUJo6dg/yLQELkB79VqXfiCGm9ivF5WtmcIi8RmwRWwstv
         Tn4P6vs4idkYMDEnXQyh8fj+ZXBEGw23yPYLobNtIOqfJ1899L9RZCUc2eKXisF7sdsX
         sZsrNcoUJzftb9TwAaRe5F1N1ONJoU0WvJVx+/ZaEDZc/lo2JjXoobh4xoKQpWp/JvLO
         TA4THGTmyNX9mupMJAPR3lMWwaPsZbnEToAJq6GAS7ubPz48W6/bI25RVTCvd1I8vNtX
         Di+rw8qxnM2utx4upVyQ3CcsyMbGSEXB8dztLZ21ZeWV8fH7UBioKkO6ThIA4S8OP16E
         KztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849622; x=1772454422;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/8/dI/miYQFdbZevFeKbT9ZWTIPZ6sliYe7jLed6AE=;
        b=l8yFjmyonhWepYHNIWXHUt8gj+VGEiKZ2n9xhjAHFdTNPiPin3lWpAzoC+VnHRftg9
         6eWTBOkRy3SXUBkAgth6MF3FBbvUVlMTfX3RO7q0fQZrKQH/Wetsms61U60OZkIDul21
         thboKY7bbYgbTIl5Om5RQ9a9a7fHZs+8EVgHnkkKLI5AarqL5hsSsxOP6lSJHfk/AYPU
         s1H/cIL3qesgck9f9wp3IbTtONVlE1EmqcSlca/0kaCwBN+kS3l8eB/Li+er/QOqzl5z
         F58Q27XgiMkAfyEFx9/cAOwugY4duUrAbPuH81xeZTYCYhp4G+jMtjHk6xpTn5/w3KKD
         07Fw==
X-Gm-Message-State: AOJu0YycqndzWMLDYJg+jSgrGHBiasmJxuXRDc3OwVzimgAW1cSLh2ut
	lumNDsPvRYyGVtjXaA48lAJ6x+bkTtfONm1n3LjL7XUe5GBdguqKgLzQo/djLA==
X-Gm-Gg: ATEYQzzC5EbSPnqSdfYNcfRMxvH6ru71cHil2i1DpyzrDu5eaEvmNUWLsoiRt2DQOF0
	kJkiVeCDKhJGot474XSIzqzRl5o8cEEBJStDIQbi6px7zWRCC7/kx1s1Hfi1yHaV+H0myMYTMo/
	RcwUWsxRBSw1/IH+5TNi29pszRfrMKiyMHy/GW7YQe2iXgMNwW7nELw18j5c84rKSsL7SteVytM
	yZgEUK/J7EW8jLjtRDmrt/8ODjZDfSQdnIciOqFABWbCl+CYS+BAuBnMpI9QLl1QIK/eaBfmUwj
	volnQxCQ2R1Cyal/e9APgQeouQmsQiDQWGfieApA0E6mpZ0h7hPjYCM3iDVsCU10yO516u0FC5i
	gBvs8vUuYp4BlWfOVtE2GFXPVv/hT3vHcHO0z7h0m30wJXXnF151aHvujuGDxk57HJqgJ1o1GPT
	bt0yMlS8uNARdTvJ9Tf5/WVY999w==
X-Received: by 2002:a05:690c:a6d4:b0:797:e0ec:b8df with SMTP id 00721157ae682-79828f1e7c4mr51603677b3.18.1771849622238;
        Mon, 23 Feb 2026 04:27:02 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd81dd1sm31097857b3.27.2026.02.23.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:01 -0800 (PST)
Message-Id: <4835ee51800871f0388bc0c4ea812bb90bfe4284.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:46 +0000
Subject: [PATCH v3 04/13] config: format int64s gently
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
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting int64 config values into a helper method
and use gentle parsing when needed.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 27 +++++++++++++++++++++++----
 t/t1300-config.sh |  4 +++-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4c4c791883..448b148563 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -237,6 +237,25 @@ struct strbuf_list {
 	int alloc;
 };
 
+static int format_config_int64(struct strbuf *buf,
+			       const char *key_,
+			       const char *value_,
+			       const struct key_value_info *kvi,
+			       int gently)
+{
+	int64_t v = 0;
+	if (gently) {
+		if (!git_parse_int64(value_, &v))
+			return -1;
+	} else {
+		/* may die() */
+		v = git_config_int64(key_, value_ ? value_ : "", kvi);
+	}
+
+	strbuf_addf(buf, "%"PRId64, v);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -249,8 +268,9 @@ struct strbuf_list {
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
 			 const char *value_, const struct key_value_info *kvi,
-			 int gently UNUSED)
+			 int gently)
 {
+	int res = 0;
 	if (opts->show_scope)
 		show_config_scope(opts, kvi, buf);
 	if (opts->show_origin)
@@ -262,8 +282,7 @@ static int format_config(const struct config_display_options *opts,
 			strbuf_addch(buf, opts->key_delim);
 
 		if (opts->type == TYPE_INT)
-			strbuf_addf(buf, "%"PRId64,
-				    git_config_int64(key_, value_ ? value_ : "", kvi));
+			res = format_config_int64(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
@@ -309,7 +328,7 @@ static int format_config(const struct config_display_options *opts,
 		}
 	}
 	strbuf_addch(buf, opts->term);
-	return 0;
+	return res;
 }
 
 static int show_all_config(const char *key_, const char *value_,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index dc744c0bae..05a812fd6d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2515,7 +2515,9 @@ test_expect_success 'list --type=int shows only canonicalizable int values' '
 	section.big=1048576
 	EOF
 
-	test_must_fail git config ${mode_prefix}list --type=int
+	git config ${mode_prefix}list --type=int >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=bool shows only canonicalizable bool values' '
-- 
gitgitgadget

