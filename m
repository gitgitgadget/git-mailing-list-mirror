Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06A15A84A
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847276; cv=none; b=tf5Yj5BLTYr7MAg1U7sNAgo7M73AwqjARo3ddCOeQPgcntpIhmFrt7hM7LNwTJJgoTJWJYeKtKhyaPqzYw/56POrVTVyhSpXf7BXLt41hcruwO15/oCESOHygM45tCDVM1WiprKwzn3ZxrCyMN/kf9pD3vuPZoBCF2OR6KJFocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847276; c=relaxed/simple;
	bh=0479d8Robjnw9VfgGsAQjtWbMj7HQSHTxjLgP1mruuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inCwLguGR0GSzH+FM/Q0kweeLYxyGwwSWaaeLY8WYC4oAW14AXeMItq81sDxCehRSDxHUDXN7SHnRQqm92pTFinWqbfwFxD2NSiUiDAd1+GQh7Rv1lLhXFRViGKV92vZzq/dm6d7FN9sfZiflJIl7khtMNiPMNStZFPfR6S28MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THUwV3Vb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THUwV3Vb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so23881955ad.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847274; x=1720452074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F34P474Se0eWjNRjL0aCCuMLLmdx/sNHOXqR74pYVWw=;
        b=THUwV3Vb5DlFV7LQoyeoUsPtVny7+iouuNafzfsNJY4WKxgtl8RmGs0DInVy/ezGET
         ioBQhC1naZuTdlIgj3Cx2s2Q/4L4g9Dkrra+7gEZmg5KM+N199DoqfqJhLZIALLNVYVL
         NqjufZIhjUwBkHq22ZKmT3hmTC8xUgFNRUIh6UXCKSxcdYRh1M0/aB7ciVhQEMP8aORI
         vN7J4PoFhP1wHSUetEjpb9+35lyoGdOOs7iT7N9rTqgf+fMelbCBMx3iE0UuQ5Nmp0Xt
         e+IGxuuzDPjOUKRgnkGY1RaAs+tqfsWfwvPHHU+KBo4dN1TqALfUKifVSZOHIX7MeO8O
         3CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847274; x=1720452074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F34P474Se0eWjNRjL0aCCuMLLmdx/sNHOXqR74pYVWw=;
        b=dC6V2otM09MqBpQeh+Fr3LirbNBuUli4RPo5QJdfcmdVgvGp7TgeVIu6DgYHKEUCKr
         dvHf0ZuGfepGRUuwma5zOPxTXjA4QAlZZ+n8vWXyYvCnR10Iw4kQvGQBekUrJoCXQcBt
         T4H7OiogU7M2u9uskaUN4C81BcvnqHg/WkdGQ2jKkZe01ip7NqHhv+k1mdCdlCR1LBQS
         d8y0lx69QwxY2B4/QuAb/yz+jPy/99LiFDjJRMc1g+5gh0RTRKv30phXOWSA5Stk8fZP
         zSzHer317DbS1rp8/tyCsuAWh84U/iBbkpdBoMAZHeNYweFbCna8NInJbFslmM4s+aTz
         r+Xw==
X-Gm-Message-State: AOJu0Yyve9TlXujmfcSCn9Q5+7YVrrifUcF8Et66ejyq4+SOHbwAE0s3
	luzP7XmoMM6gKoM/qaH8Id47F3UF0Ynw5eOHpR+NtQZRUMegLCoz9ZgDMw==
X-Google-Smtp-Source: AGHT+IFD3fBZwEz5tbeB4T9i92loWzlUg1IAU/mXJ2ju7T0QNbWYk6eoVJwNtzIZY5PvLRQLgH6oAA==
X-Received: by 2002:a17:902:6546:b0:1fa:1599:385b with SMTP id d9443c01a7336-1fadbc74913mr45877385ad.22.1719847274260;
        Mon, 01 Jul 2024 08:21:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1c78sm67594695ad.23.2024.07.01.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:21:13 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:21:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 08/11] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZoLJZ0HGOofz3-cl@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index cdf2218dfd..aea635ea00 100644
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

