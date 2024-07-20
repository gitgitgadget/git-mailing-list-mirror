Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F11B86FD
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467715; cv=none; b=EEoyj6xjNCIyf0yam1jYxgEwdxy34/6o4mN9FbvjXjMROX5chScsIOwbDStjreJGV49/ZZ1hDreI077YHbatEmg9EmPhM275tFN95Qe9us0BhZ467Srf9FpBJzYFlLaJJstrcMIbbXisGcj5gF8cgWYTMtP2fmTyhcSss6XKuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467715; c=relaxed/simple;
	bh=uXLiWDdQ4TXYINN7nYIcVgAYU9gKtYEEvtiLFFLTrEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0u8DYGF7uS7c6HIAvv4ZZiYIiUMNp6zuXU4TTFQyKB9nMSqhaaeWEhWDTFg3JD/ucGmXezs6EV7cYGM5xe8kq0sC4qTpcrYUaR7LrMUwtGgz46mRP6jtwQIL8fuOs+k6lhwzNomZiXBFlH/WWVL44/Ze9+tVX5C2bAKuDe+1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pd70yTNK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd70yTNK"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-381f24d6bc4so10921255ab.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467712; x=1722072512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR8gSKe1hyeDj1f5ziXrf6+stAoMjezZja4QTgJnPs0=;
        b=Pd70yTNKTx82ZNUyffxYdBWLoA5KVa3ooSfPJhdyU5ni8FVMBeG+L0iyeKh8jVSYV9
         xAZxQoH4I/E4iNjcbu2l1q3+WekBA4xpnYWUtixvA6j3EfGd6Ke9r+KY2jeyfcqa/sZ/
         /gN7K6XC29Xr2GwfK7XML4WHcSOb5TSmBYkJ6xfMX7AzNslEEDcoi+RvJKSflWfLnvn3
         dwUGErUMq9YbSxisA/ttZ1Bds01jW70dR7Br+SxHECl8+IoDkFd0rKEhSSQgLQnQFHy8
         Wf4mnRJlNwgzHeYOv7r2e+NFHeI7UEUpwPNkZEuRBrk5eq6LMXyLTNFQksfjVyWoavoQ
         EVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467712; x=1722072512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR8gSKe1hyeDj1f5ziXrf6+stAoMjezZja4QTgJnPs0=;
        b=CtSb5OyPK8W0T5tkEYcL5RTyH6rocImZr+WkZ4+5ZiUMCPoVSxlR+XqYqunKnAyxTs
         JhQLeZV/eCnWjm4VphvH26ktZhdMp3UrIC5R8AvG6d8yUJ1H1otfdwxy6YngAXqRl7X8
         N/iIw82wJUyRXABszaHDGKH2JWmXN0AgHOuywjPRa9AN3+5Wma7nmdQ1wN32tI/PQUOe
         dPruFA+aHNdHdcd+O2gOF8htE4BtKTdE+1Z5wUqU1XgVSLMMarobTL9qJoDfDpVmv7MP
         Fp2NzXLD/Zk3B9zlx9qDWM4HgCJrNISOkanVCIULqTyvqjU7f6lv+Y0uLmmqw7kE16s+
         pPmQ==
X-Gm-Message-State: AOJu0Yxz1Aftc/xUUaWVpHcgZP1nVETkgMODdHbPCl+thBvzwgFwaCJz
	9LWBWfZvcyJa3JXdkoX+YTP15MDMAmLPzBMXpS4ntPNrDxSSpAuSJXtlIg==
X-Google-Smtp-Source: AGHT+IELAngAxz7Mmb5CdkadJG7TJDhE/3RISSbdLhJfQuGgG5r13Jylnca1/0Cj1Hh3ufvefrgB6g==
X-Received: by 2002:a92:cd88:0:b0:374:aa60:a5c3 with SMTP id e9e14a558f8ab-399404d20e6mr9538895ab.28.1721467712566;
        Sat, 20 Jul 2024 02:28:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b5ccbsm2349305b3a.68.2024.07.20.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:28:32 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:28:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 07/10] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <ZpuDS6AjYj2gelWm@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6d86bbe1e9..6cdff55fd6 100644
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

