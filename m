Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC92FE56F
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270421; cv=none; b=T5/Mw4YCzHi5FFkiz7fO7tY5naSIxvqNS8yfpMhziGXa3LYvDD4w425SJq5PKujCml1Nns90Yurk/UL92ChEevtxGikqbqJmgo3gR3Ae8/kpf0q8mE8Jl9go1e1/w2sanzHHtLG9lOkj9rJ9gZzb+W+EEUqM0J7ShJGrtu6pl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270421; c=relaxed/simple;
	bh=eZ4LgpuPGRTcTUhFhM7DeKDSMCXGaZmfgP3HQg2LRxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEsz7Cy80d7k9OEVjEXLWgNtxSsPOY4Ds+hMgXNjwJ44WGRL8IRoOIiBvGjpWf50t6VdcopELphaIygPFegVm0PdVwX2guBHaCHtTPzE26fd5qqYHN9iudufjYjLTL8USaqZ0ZG/qrr3/941bOs7UQnr4mHDWqEs41gs+CZiVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROyzgBWV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROyzgBWV"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330469eb750so2108168a91.2
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270419; x=1758875219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff7nGsuJqU7Ai40kXon7NyLWGPpHvW/rCcKUhcpHjJM=;
        b=ROyzgBWV6JAAdtdRsspljVSar+cEvCIwQE3JEwzD68mzYCJ2lg3evYnamge5YbCJCp
         CxepxAVeMZXBB8nZEE/ADcWUwTCe3lk80N7TmHQBnVOvMibyCSvrYPXL7I7jvP6bpq/n
         XDlgpZjtObapfXRXKyxmcqIHK9NW2JVNN3INt+L/5AG1NeOPFJ6qUEmIQS6TWBp0Nszm
         TubW67DXMg5DsNmtVMxAtdzJ//SN4s3KF2vhd0Cbt0iAGCjqpSJ49a6etBY5L06OTAYI
         RfckwVJuSzGjTwoQOlyd8ap/dRmB442XFjFLBlJ9ENdfbfdAMfCDsI0xr6JYUfNh8atp
         xvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270419; x=1758875219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ff7nGsuJqU7Ai40kXon7NyLWGPpHvW/rCcKUhcpHjJM=;
        b=SKoPRWgxPDhuyOYWnohSrQOW/n/ZpFYiBFfL+rsuXsi5FJ6d6iOFIBX/LknOSGORcl
         C0QkAfc+PNhA1KGzF3tbkOapVKn2PNTMggYcveu2c/1TnKjLbApWvA79jFmEPjyl0Bpm
         InLnL11dq7rPXzK4YaGXVdeF/9Psl3g5AkkWmIMEmpntrixrYLWowtN9+q6l749AEQ9E
         V2abngmIbPvdpBRVPn9TapF8fn6ebo6cPhAYWvQyL6i0fn3tO0MHfoIxEhv8fHRD+EE1
         mMMcomHvOLTXa2wm3Vg2QNN9gnvBT7+MMlm2plFuHGfoGT4coQvzzJIgLDOMHygUn2kt
         fB7Q==
X-Gm-Message-State: AOJu0Yzi1gQUj17eF4tlWNpg+Ylsx4Dk0mXtYh3PMKp7MsIc2XP9bOm1
	bbCQiZQ0bCwVmBXZf6jr37cea/W4TU6B5T1ACsWJcG06qxYSm8Jy39GT0JgDyQ==
X-Gm-Gg: ASbGnctBNS9/pQB39XKez/4c3rWFFth2qDA2/L/oOr+POpQDK2mFLe6aAmaKGafzYVn
	N8FwI3ePo6egoRDx5XNbbaodpmGji6XPgLqM2Xomr0A3c3UFXF8YsL1G5DW4l8uIqIwCfPhjcCi
	+wQh+1dwGQRqqYqlcZKCyfFn8adrxuQ9/V5cSOBs6Mt/Nn63YJO+UviVDao7SW7sGtbF939RxeQ
	3ztXvOzQbYd8BkH/r89GKxV+EiS+8OdvxlreDublDVjMANEy5abWw79mKCooR1keb2XrX1nbmiJ
	4iu2h21EkUZH8H2HqYEwWQn1C0jmyeBKasMiggt9o3FZ1T8aGjQA6eAuGFADShUKAD7ZRFPd99E
	q4qnji18OOi504C3AgvA=
X-Google-Smtp-Source: AGHT+IFxaw5FDx6Wm+1f4li8N16B+WW9SPlzbwZfbNqdiG45s823u79kf7D4BvWyRexpInxHi6EqQQ==
X-Received: by 2002:a17:90b:1d8a:b0:32e:6858:b503 with SMTP id 98e67ed59e1d1-3309836b19amr3143384a91.29.1758270418555;
        Fri, 19 Sep 2025 01:26:58 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm4774254a91.24.2025.09.19.01.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:26:58 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v4 2/9] files-backend: implement 'optimize' action
Date: Fri, 19 Sep 2025 13:56:40 +0530
Message-Id: <20250919082647.535213-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com>
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250919082647.535213-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the generic `refs_optimize()` API now in place, provide the first
implementation for the 'files' reference backend. This makes the new API
functional for existing repositories and serves as the foundation for
migrating user-facing commands to the new architecture.

The implementation simply calls the existing `files_pack_refs()`
function, as 'packing' is the method used to optimize the files-based
reference store.

Wire up the new `files_optimize()` function to the `optimize` slot in
the files backend's virtual table.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refs/files-backend.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dfc8e9bc50..1428d3a6f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1473,6 +1473,15 @@ static int files_pack_refs(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
+{
+	/*
+	 * For the "files" backend, "optimizing" is the same as "packing".
+	 * So, we just call the existing worker function for packing.
+	 */
+	return files_pack_refs(ref_store, opts);
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -3909,6 +3918,7 @@ struct ref_storage_be refs_be_files = {
 	.transaction_abort = files_transaction_abort,
 
 	.pack_refs = files_pack_refs,
+	.optimize = files_optimize,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
-- 
2.34.1

