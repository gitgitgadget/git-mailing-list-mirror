Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B01E869
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015102; cv=none; b=QAa/LQdp/1qgOcO7x6X8zYqtuKPnUxzamiHXyAdnzFM9Nt1iEdtnk5DvrlaB1wSRrHiRK9JOa6GElPW/Xea9OKJDt3AQS+B/JGeRBhqbNhrmRWLJBvV7fPsRzpvJ+RwX7gO6M8W/2FtWOMo1knkyjHNoozHsFmsTY/FZcJuiKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015102; c=relaxed/simple;
	bh=GPo+wJphr/bQOMx/lM4LzA7A2cyA6HvGGdXEE2sIFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uxr6K/s2RQyZW2VOljWcNYGdiw2AAaf3G7E3Sk9Bk/1ih/D2yAHm7ftFO3EwMlDvO/DZH2047vArv2KltxPjjYjkJnK/KHY7DLpv5N0ATzZKqhBcS8ZFprznX6umt8B2DNtnqfVxScYM26Qvlef+RKtrunphVDjiXyVzBPSv4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0OUbqR6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0OUbqR6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9de13d6baso35316585ad.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015100; x=1720619900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=C0OUbqR6d4H4tA44iWdWF50CKfYNoDUcK6jGQyfhvbqsw8HhkroTYwd2hqxmP82pkd
         2B/30D+lqwDPajwaK4tVSqlSgDwFgiO1HuMMm6Q/mxv7+4rNnYSl72LVNxSImQCsRGbg
         M4ss9cK8czv5BV/4lm824VvS7hfTJI6qK03ObORpG+WJ5l/n8yjEocuZXtqMrd4oyrdh
         B9AC2DOXAkdWvBMqDyoB9LCMYg1KBHN2f7brt5H3XaxhWFc64OoVfwShZZjGeH013vgc
         GH3QWxFl7tgAY7+vU7yuv6oHq7GQ08lL4kaF86vE84UE4I29cNaFxXyHC/2qOc9XcFUb
         D0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015100; x=1720619900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=ftjAvL95x4HtmOFR0kLwRnxOI5yonhPPVC/SzvsIqsFWTdH78f61PdlWNJC1AzmqlA
         +dwLtnH/2+CwEkVtKT0ASmUS2AZu6bBZqVQv+OycZ9nskU3qN1HhjGlJEtCioYLLqc7f
         gpj+a46cFh60Bfx9V67RlDYGrIxCd9/9SL44T71GX3qweFdinEltfSxJwureB6bVPUZX
         OR6RgQ7rXnjKa4+mE4U64bHWM5osCY0n5WLOR0UTtzylti8QKMBGmQYrcrXQwIgzhsDQ
         C83Y2kGTGq97j+UWpR28tPNLFL4opBDYUaJnjeD8+NK+49vbVg4uYD951SJJQQyJLclz
         2MkA==
X-Gm-Message-State: AOJu0YwnagvXExx083A2pK7uik4YcYQ+KHx/LZCv/lj5cQUtq7T7fPuf
	csOwzCth77aZID00EvFAuXxZkXPoiOZJEZSqzfRlCGS1eBdX8Z0qmJCyAkh9
X-Google-Smtp-Source: AGHT+IGqyij6FvxnYBjKxrDiCcH/EAa9bJaJsB80YBvdo4gCwyoRyndvUn9lXdnxZjaHaURrR+AoGA==
X-Received: by 2002:a17:90b:33c4:b0:2c9:649c:5e07 with SMTP id 98e67ed59e1d1-2c9649c6a5dmr3138227a91.8.1720015099779;
        Wed, 03 Jul 2024 06:58:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc540sm10748751a91.44.2024.07.03.06.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:58:19 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:58:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 6/9] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZoVY-0NDEoD6A1HU@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index de34538c4f..ec3357722c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -897,6 +897,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1066,6 +1081,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

