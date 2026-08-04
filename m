Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F61448BA3
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837869; cv=none; b=jNkZws+dypV+KHMk8FxImekZoQVN58bvf6+yoJXarfFo+EnkcIGy5NbVumgvXlVrg28o0aRDXIM7ydPczl7On51meHc1197A9pHnNsLdTdjZoEregSlb76id6IxAdwWZRQ7/r+3xzspbwtjKtzEiJq7q3efPgtV7sFP9en941To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837869; c=relaxed/simple;
	bh=ZVLmHwwDWlxwmCfS9YXcdq9zUWaBzYTGt/ok+my7hIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry3ABl4+fN8ITI0CbkHbbCfucMwMn+gvRURs85P0u9yMBtOmaQPNpNepmh5WRv0AVimzVlUfK8Uq3+slOmzWjMsb8ub2E0iS05XbqS9gOeLtQv1vX1NHjHzZMdsL7znt4K8w0vtagajfpqIm7KkLlZPwOMvaL0umLdi9AnhL0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwHyVE5Y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwHyVE5Y"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so27699725e9.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837866; x=1786442666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlQqc+jfpCKV91UlIdNRA0n7q118NRJk4JksTp85LEI=;
        b=WwHyVE5YwpqAmgptgbny1cV2iX1eVzrG5EH0ydXwGy0C9bGYpQTudtYpZTwgXEJGA9
         rsbL1WC1d8KjJdQVvCwBa6sqTCm6mpSgkYhTsuNS1xlgLuw6nAWSxJg0ilwCN1atGbcn
         DMynpe9jf/VejdB+tJP41lSKtNnFXN9CwcU3yNPuk4IDNaTjPuDTCl1hfL6VUMCu1NH1
         28AaLHQ7nhFYOgIBkqkPd48jbjCbEpvZ6pPR+TFqymYmGygTevn8FYUC98YqT6JmH+Fo
         Wj2VQhIIFbxeasGmDEty3SbEatlYqcEdJCthaFq3CBgzniYv/bexARLC7JaahbzODaSv
         e/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837866; x=1786442666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlQqc+jfpCKV91UlIdNRA0n7q118NRJk4JksTp85LEI=;
        b=tFe60i7HQ74T2ekyaiqeRCXwl53SiSoTg5vriMW+EbtUs28PO3tBqPs/AwApEhoR6Q
         ZHPotKH/3J9q8NYZbkZPMr7wmX1JSIS0ibhFEPXhtr5BF1za8yT6pWaLz3XvQ8X2UE6A
         0qgHa4i2TgPFKEaknUNOMTCQGs5cMCNLkTmGf9vQO0ufGQeJplA4tDyDm5ElCS1ciW58
         K3zxyGDZzUMyQHk6JUpPRp/Cn5AXsw47E0irk6FW0IS54PaVIkHJA/Bdj2Ai1Q7OaI1e
         Wi3u1s27SOZKsC6aIS6lb9Ra4J2OIs87VrCXGAuxRXqYp2VauUMkw78Q77+tVHXP8G11
         gv/g==
X-Gm-Message-State: AOJu0YyY89gVs3LrH5I+073eOlBHYwRh0ke8J1xRGAnJ+Ommz+vJRdC3
	HzLHQ572skOn9KQxbHrdV4XhSp6CnO6FUKK9hPeChPeZMJTRRMSCiSCEhqlLMg==
X-Gm-Gg: AR+sD12OCDs6qWFlUASrD4JGE63WLV/krY46zK0osouCPBdumr0tIpp/KMBHTjWhrqf
	FkXUaAdbRf1BzMmPLtEbh/XEsZaV8dBERluYRYnQZafJKr53KTDZ6XZMnpGJ2Ng21dEhpngdSO5
	QUoCn0Rh0sq2cxz/RLnnmVavoZUzaREY/h6n3f7EgHwB+gA53W0T5F5uyCzUD1eG21awDV07XaN
	U2TZ/fblpDGn5QS+L6LomTg4mz7ON988DZWttSmwNPxFT6mX/x1R60tC9TGapiYP5DqEbIkdtki
	Yq2iGB9ZDYODQKjKQSdF5fPpJO53DL67FPFeTMBju/jxZDlJUmxYQkfD5IoD99B0sRZbTKcGJ9r
	6yWWSbXFdM9mxReTSiuA0pzCa6+e5mNXDRb4Q9mq+OentGGebVx0d8Qo7jc43vBteCSs2I4bQUT
	ndpVFljIYDoJgB8tundN/A7j+wdEDhBQevzCgVFu7PxfQIMOgX2lO/Uu/rY5uhnt1mva5MIWoGl
	blFSjwHM1XH7sWEKE4LG7zA4tNXkGWdJBbAMKr4g0aZDe6aZvhmIBYg4IiomU2KvC0PMkTdw4o4
X-Received: by 2002:a05:600c:c113:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4980c674e1dmr262989315e9.10.1785837866059;
        Tue, 04 Aug 2026 03:04:26 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:25 -0700 (PDT)
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
Subject: [PATCH v2 06/12] fast-import: factor out option_*() functions
Date: Tue,  4 Aug 2026 12:03:49 +0200
Message-ID: <20260804100355.1299498-7-christian.couder@gmail.com>
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

In a following commit we are going to use the parse-options API to
start parsing options. Some options will have to be parsed using
OPT_CALLBACK as they process their arguments in special ways.

When the processing code is already factored out in an option_*()
function, like for `--date-format`, we can reuse that function.
Unfortunately for other options the processing code has not been
factored out yet.

Let's do it now and factor out the code that handles the following
options:

  - `--max-pack-size=<n>`
  - `--big-file-threshold=<n>`
  - `--signed-commits=<mode>`
  - `--signed-tags=<mode>`
  - `--quiet`

into new option_*() functions:

  - option_max_pack_size()
  - option_big_file_threshold()
  - option_signed_commits()
  - option_signed_tags()
  - option_quiet()

so that we can reuse these functions in following commits when the
parse-option API will be used.

Note that there are some behavior changes as we now die() with a
proper error message when git_parse_ulong() cannot parse the argument
from --max-pack-size or from --big-file-threshold. Previously we would
end up calling die("unknown option") instead.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 69 ++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9c8edd7c89..a6e3cc0033 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3751,25 +3751,55 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	free(s);
 }
 
+static void option_max_pack_size(const char *arg)
+{
+	unsigned long v;
+
+	if (!git_parse_ulong(arg, &v))
+		die(_("--max-pack-size: argument must be a non-negative integer"));
+	if (v < 8192) {
+		warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
+		v *= 1024 * 1024;
+	} else if (v < 1024 * 1024) {
+		warning(_("minimum max-pack-size is 1 MiB"));
+		v = 1024 * 1024;
+	}
+	max_packsize = v;
+}
+
+static void option_big_file_threshold(const char *arg)
+{
+	unsigned long v;
+
+	if (!git_parse_ulong(arg, &v))
+		die(_("--big-file-threshold: argument must be a non-negative integer"));
+	repo_settings_set_big_file_threshold(the_repository, v);
+}
+
+static void option_signed_commits(const char *arg)
+{
+	if (parse_sign_mode(arg, &signed_commit_mode, &signed_commit_keyid))
+		usagef(_("unknown --signed-commits mode '%s'"), arg);
+}
+
+static void option_signed_tags(const char *arg)
+{
+	if (parse_sign_mode(arg, &signed_tag_mode, &signed_tag_keyid))
+		usagef(_("unknown --signed-tags mode '%s'"), arg);
+}
+
+static void option_quiet(void)
+{
+	show_stats = 0;
+	quiet = 1;
+}
+
 static int parse_one_option(const char *option)
 {
 	if (skip_prefix(option, "max-pack-size=", &option)) {
-		unsigned long v;
-		if (!git_parse_ulong(option, &v))
-			return 0;
-		if (v < 8192) {
-			warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
-			v *= 1024 * 1024;
-		} else if (v < 1024 * 1024) {
-			warning(_("minimum max-pack-size is 1 MiB"));
-			v = 1024 * 1024;
-		}
-		max_packsize = v;
+		option_max_pack_size(option);
 	} else if (skip_prefix(option, "big-file-threshold=", &option)) {
-		unsigned long v;
-		if (!git_parse_ulong(option, &v))
-			return 0;
-		repo_settings_set_big_file_threshold(the_repository, v);
+		option_big_file_threshold(option);
 	} else if (skip_prefix(option, "depth=", &option)) {
 		option_depth(option);
 	} else if (skip_prefix(option, "active-branches=", &option)) {
@@ -3777,14 +3807,11 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
-		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
-			usagef(_("unknown --signed-commits mode '%s'"), option);
+		option_signed_commits(option);
 	} else if (skip_prefix(option, "signed-tags=", &option)) {
-		if (parse_sign_mode(option, &signed_tag_mode, &signed_tag_keyid))
-			usagef(_("unknown --signed-tags mode '%s'"), option);
+		option_signed_tags(option);
 	} else if (!strcmp(option, "quiet")) {
-		show_stats = 0;
-		quiet = 1;
+		option_quiet();
 	} else if (!strcmp(option, "stats")) {
 		show_stats = 1;
 	} else if (!strcmp(option, "allow-unsafe-features")) {
-- 
2.55.0.492.g44bba30fd7.dirty

