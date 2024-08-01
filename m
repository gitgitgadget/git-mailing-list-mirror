Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6104813B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525279; cv=none; b=QWat7VjrA+NVCsk4iuBchuFBHj4tWng50uPzFxJYIFPipJRjXIdQ25nLnzKdJw+gh8FVISLfcS1IEyCrFVtHZfEPtWkvdaRyUlQWpYs4UasUTOhrAFHV7RMGwqV8MMxMybNrB4HX52jzTTxriBByW6CjIB4sAUrbVTP9UATJT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525279; c=relaxed/simple;
	bh=nGE57sSUhTelT1O81lLGuxqP8EnWXlavHo0hiBrSCq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFcq3yL92tf5OYkSF5Pc0NCl47BBSzVYMTDgHSpGf8+JM3E2skxZoCxiwlfwuoowbe81MlcoK6y+WV0hypp7oO3TeV5vYCYQxZazA2xeKF2EFVbDefTm78Gm7kFTdFxCPsOr8YXRk8Z5+FLhddJUkyZwdVb4iy5kk6+Dx7gCZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5bPCQpR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5bPCQpR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7a263f6439eso4200309a12.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525277; x=1723130077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHF83E3ccLYpbKGMj/UzhWuRAPca4fkz7XAnJMogJ68=;
        b=g5bPCQpRfhR08tyXzyab0WuCiDMkzYVIGmMnyPL6oFHJCUwpjOkt9oeeeb8uFCFTED
         VrfIOreVA/JJiAgcxMAca1ztVdNp3DOLnaWFthRmZ1iuWgw3tRyMNu2JwKk8nZv6q1Mf
         k8S0frxTVNU7SdEk2PoCniiI9kWJ4arlw4208EEfo872krOLVcMfxaZgspm1KAQojV58
         6sUakAzDkgNVAiUu04q9LzsU5Zts0Chn9BV6iWf6YIyvIo3M8c4VgQ4F15SesKa7G8Qs
         59/WwvFeW2t6nrR+zqZ/voXjrxFrabRnnZymNfnJ7yk/mgwd0DHC7uad2LH14sLF9jZq
         udIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525277; x=1723130077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHF83E3ccLYpbKGMj/UzhWuRAPca4fkz7XAnJMogJ68=;
        b=EkoaaYOfoO3kgIUBJkvHzjMqRPWIdNAXO6F1ns62Fqa7xyEk1xpOMq9rHqk9kSqpJb
         s49+LAYC2PqMe3HKsy7Be5CwSWYo+T+04p04Ke4FTJrUpUTFROtJdakBxk9tfHrGb4Dz
         x1A723O817BtbQJ3/MZpUKMbaKOyHC/CddiebU2am5o7LE6mV6lEH3QOP6OlUOZy/IYQ
         kCJ0g63DGP8+vEd3sG51M1lJ7F8OrDnbLA/YinL5h5WMVxNDOUQMSuSLzWev2JOaYkpZ
         p+Lt/AC6I1qPfO7iWKGdJQU+iCnGb16Gil/zVVZPx6lgoWbyVeIiA7qQIrI+Nm3d6YgW
         djkw==
X-Gm-Message-State: AOJu0YzybZsPx2rzpuOO2pYh+XC0PjxeCoJL6sFyc9js6UzQu1jHS8jd
	1egGFP0HqwT28yuEnjKk8mSQ1fshzHX0bLXBloD3zlkMyeZrH5UANDDq1Q==
X-Google-Smtp-Source: AGHT+IHQTtjUJnlq04JOXQ+iJIz6HkHqgPJ2UN4HhtKTvczdU8SdUJI3XzKtlUIT6MdiAnmDKtPjAA==
X-Received: by 2002:a17:90a:a00d:b0:2c9:3370:56e3 with SMTP id 98e67ed59e1d1-2cff95148bemr593647a91.34.1722525276777;
        Thu, 01 Aug 2024 08:14:36 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69a27sm18800a91.5.2024.08.01.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:14:35 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:15:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZqumdJz3-0mqh6Rc@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 766bbd014d..b6ac878270 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -899,6 +899,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
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
@@ -1068,6 +1083,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

