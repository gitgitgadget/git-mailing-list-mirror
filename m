Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C101AACC
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445780; cv=none; b=Mgh5fyAxKsb6UZ0/tiXvNAA2a0dLf5PMZNlyeMp/Za6GjW50cDek/cK2q+0miNRFs/fLHPPUkvCwBMxgHrxpO5BRfhCrxn3znWozYtNQBYdy2IWaXIlMuI8i+nlMerzBTd54iDIi8ZnuzU+zjbbw5QYC1icO5iFjDp0uXmkMkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445780; c=relaxed/simple;
	bh=GPo+wJphr/bQOMx/lM4LzA7A2cyA6HvGGdXEE2sIFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilBkfw00cRpCOmb33m92cDCSikJeG6ZoHqz2rBJT1e8oO/oujon1rgUifdfuSJjaDl7csizacTR3WcTSoUqcMa49oDCICy3+e6QRFBmP4xsTVlq2k6RmoDSQVHggQ+efj9BWNs5fzGWIhdowV3VNFigAB5GtAJDXEWwr44cOIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHVMSwNT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHVMSwNT"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso2988559b3a.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720445777; x=1721050577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=iHVMSwNTY2EvQs7iLSOEXw1QqkCnRimknwg9TP374gcTHUH1rpxL+zDeiEdBpE8j26
         yu8WJHFHlI2Udc8XO3uyvf8GrNvs2WW0baYoKDD3hTaKXwpi91GqPUQRMLfEaRnEbFmJ
         f0TT6N893wTlgD39tHp2MLWQDOoIuK14VR66f6So8fXKPu2EOYE0SPEsC6kM/igfh+A+
         Drad2QkRFxpjjaTOcwtqP9HcgmLHdt4Yrmyra3/SILUvYHXc63GLZO1tgkSitg1EoNTL
         o6uBlp3X30TWT5PXsKmje4mFkNYd68PX2BjeTHej72j1cOivX+3eSs9la+CrHF4FQViP
         2q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445777; x=1721050577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RAjRwOw8tT55AuT39YuPxyEG/zw/RdiUBjfj6NkTC4=;
        b=oQk9MSsqIlQCdVm9AbV7SSxaRCQSuL4sfb3i0zr4WMmcsVD2tK5gS8lKlSEYz82LMF
         MSIgET0Wivy052Yn5t/1cP496jUZ4UipJvgQgNyS0jqP4Xyz0jCoOAezPNTX4TQfIKWw
         DznxBcgUlyZGYv9qfOoPigz3Hr4RxCJI1y4TIjuowvYSCc3B3aRayrrTKt4p9hrpylYQ
         ZEJ79zXARUvGagR3ASvSO0nilVWGWaACpMhmV/HebkCn2+VkKchkEl3bmTX/ZudbPZA1
         Fjuft2aqOSgjNrR3jYODyPN4jMLE9F7joUZotTtnV8gSYv1Jh3ayf1sgHyjeqaXmils+
         i9ZA==
X-Gm-Message-State: AOJu0YzqGzhDMADSKhe53+T/evQk9aTYQ9IJBDMYH62FpIJwTHfuXxcH
	8KRZy0GPZlPcrbe02TIYFd3ny76Y2doa+Q1ELjQMX3t9Ym4RRWuLxpveC9nB
X-Google-Smtp-Source: AGHT+IH4AcbUa8LQSL1oNtfsSCd/e6P4DO5vP4YPfV3WfjVTFf9QICdTIzZrnrBBGJDql3hR1keozw==
X-Received: by 2002:a05:6a20:d48c:b0:1bd:251a:b657 with SMTP id adf61e73a8af0-1c0cc90dc42mr17738291637.52.1720445777501;
        Mon, 08 Jul 2024 06:36:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb4d84f7c7sm58541015ad.273.2024.07.08.06.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:36:17 -0700 (PDT)
Date: Mon, 8 Jul 2024 21:36:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v8 6/9] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZovrUO0mU0WTUCQO@ArchLinux>
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

