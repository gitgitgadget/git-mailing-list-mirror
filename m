Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE67770E8
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782960; cv=none; b=gKL5xXo8WV4Vg8cnv2YHiy5y8ORMin+lec8bX8/tTypc6t7SUPILrhJQ175avDDNDdISW8FLYP4axxpy8s/+EpjLLGJxcAWnMBtiams344kMULNmErQcBmbTUeksmAtsOPTL7Mia0TgQY0EM/4nUpIVNEUcRTCBO36xPqaVA8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782960; c=relaxed/simple;
	bh=t7B+KROCFH4j6b5oWVBjS8FdcdYfBYsgyJx97g70jUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Fwo8Q9AEvtVMbogpjzz3hGi/QWaWgB6um4BuUTPVelz8qS1Qwym2YvnG+RRd3opeF3TWoDWOSMLtJvW3SkdETNlHGpLsA5ZUM6xFW+lSHYWKRTVHmCtM+c/5g5qfINy3OmuCZFBm0RG//iArh6wlnBN9i4/4gHxJIR+2R2RQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzLRrlwE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzLRrlwE"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-704313fa830so4926745b3a.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782958; x=1719387758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGUQWad6A3sg1h/q4M7oBoBoUiwy19gq84I5o14dazM=;
        b=CzLRrlwEHcekTE7k/tYSoJKWfA62qyohihZzQGNCk+f6W62ZRxwFFDZWLXQsn5xD7h
         73qBzfjKSzn7rPOWIefsAaEuf3voLbFaeOcRtqXCmx2TN5yWaUSB5hh5fKRJcaajWb6H
         TU7TTRcCg/nY0kvwg04d4CdmvcL2/ZFeztRkJPM95NPAE+Ij6mPpr4w+815F9CGCVTgr
         i+1PZJLAg8Jti2nnpRHtkjnaSnwWX/UCEAkkNErJPlzTdb39SncLE4Ydkg3IPePn+Sif
         TwHgAWXXkm9+7T93BDYAC3CztQN+V26Ae9UpFT2tEob4EA2WfFK4nt0nJzK0giFscvDx
         wDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782958; x=1719387758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGUQWad6A3sg1h/q4M7oBoBoUiwy19gq84I5o14dazM=;
        b=HKA6Hh/KOLBJdZFyt2l5T56IkQSQAGa2gZiN2FBMkpEMvlHYnDhJDnhP3NXFY5DWOg
         OBzXE968yBszJC6rJe3mHi6UPEmVdcDC1fZv0bQAPDRlYoeQgeRJrgfKV0ZweqEoei6t
         jd8b/v165Fx8j7UFkbEeX1kCPwEytH0Nm2n/2UJKdLHiX4UnZt9z0abXV9VgV1eYZBuE
         6F+XGN/ztIDLSMjPhL1A4SNSMyeOaBsB/c7YvmXFX2cJsw2j9ggPz9jLZ4Qob8YNQ61+
         Ehyd6X3qfxabvegGWgIjAgx0W0P96WxNVXlUU/o4QY/4bW/Wb0V0gPpwlBq1xcxS9MOh
         aDWw==
X-Gm-Message-State: AOJu0YxG2H47mFMuJpC9SA9UonXNqgz1F+jEwpaDh6amEEERN/IYXH8a
	eQpEQ90uEs3eTWaHaD6w5sAvz4vX0n1P6Z/4M7OuWErUpxbBDjyArEH/4Q==
X-Google-Smtp-Source: AGHT+IGn+eiP5xtZ6/kBB5gx0zTJR2+Q3FUnLyhLK7OEnGo5pmnCRQ4Q9FNlj+WNw25Ol0/SgxbU0Q==
X-Received: by 2002:a05:6a00:1144:b0:705:c860:13c with SMTP id d2e1a72fcca58-70629d06645mr2055489b3a.34.1718782957868;
        Wed, 19 Jun 2024 00:42:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4158fsm10071183b3a.108.2024.06.19.00.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:42:37 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:42:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 4/7] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZnKL7Evg-lLIzW4e@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKKy52QFO2UhqM6@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a5b82e228c..cd988ff167 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -896,6 +896,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
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
@@ -1065,6 +1080,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

