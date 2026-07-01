Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4523A2E25
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889492; cv=none; b=AuCu49Z7rhpGltnBN8l59wVJrAc8u2LQ0WjZKnsDI/DRa1pVvrVvsuIw7ziSyD4ksjofLcXWVi4FVKdVLnueCACjWZDcdYIewFpYVbsrbvarZUqcAdtQpNfIILtorJfoev8oufVOnIkrdIJfWDwaB/SBm74ZXbE1GQZkjrmvQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889492; c=relaxed/simple;
	bh=lXNsk+KSyUZhB6CmaLHulJ53tvgeLMRbh1UrKIctjQs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oq1GF9KcTp8Buh04OaMJ2f4Zc2uUT6hEMmKewGbRtGXMF1s89vP0+bpV+rnLDuYuIfRH5T1JZDdkYK0YHHh8IK4qijnESxKWerUsuU5RXVrNDwNE/0P2kQxn0oFbjhgwUO4ZmGEY3MukI1sNNKyrCz6Um+1vgeDdOmqG3NptpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/bpuPCb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/bpuPCb"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915ab38ac14so30480985a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889490; x=1783494290; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdvr7lER9V9H7fdQf5A/5tTn1ept9289MiKOfZ+OtDg=;
        b=s/bpuPCbRgTqq8tHJ4y8oLIDPpRm/6rwXsfcuJSikPqjCn8/GtznepeXHEmLuP+Md2
         wd265L1D8Ag6LAKOLNUikCh+of602VVF3NPhzeXwcVWDXoI0oFt7jX9bhaAwsXJvOpqM
         CmF9pl9r1aleF4K1l8BQlzXUcpgITBBBiDXz9kxA2pQChUUr5E/lJY1rY1WdfmanAqLs
         J5QenTve5UtjJ8w5QLAUYsOOXpmIA5ybAsGVzzFhFAfoepulXhOy+/l0nHvzWR80uXY6
         1qnmH3ANOEw6oJItpkiNqakqw2HiqKwFxyZ+msyZaOYQPvxIBlRRNlOg04XW1DiHBxHB
         cR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889490; x=1783494290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pdvr7lER9V9H7fdQf5A/5tTn1ept9289MiKOfZ+OtDg=;
        b=OaXJRsq+ReF1Mqbo2YeONZRGB4Te8hZvTcbR8g0v2Vh+YyxuinRZfoRcYCUeXSVjeA
         vMH4ngzraqTlk1oNuVu9PjCBBiBq18Vt+wr1IhqsDwRLPAoyL2QtWwwj7sUC2pLpzMcH
         2fn0fb2UPtrexiXp7EB8ccrBC4DKKDUqRHD0j5iiR26liIcNHnJ74I2HzwwDP4LmEt0m
         yD66Tc5a2vFexE6iRJGcTEB9z1Y92aJFEB1DqV1c7RBbUJzY0uzz/kx3C3CmU2LmWLes
         dy+9OaNk398C5m4UHSpNxrNRXFwg+EMIzan4va2xbqKHE0odj3XLQbkbfwx4yclRbYU3
         yGwQ==
X-Gm-Message-State: AOJu0YzQTQFuPKnm/47hoGcfIf5YFuOqdh0y1uQ7DJYIlcEtVyc6tjpE
	2Hvbj8JtMqkGsDkl/t6/+S/bO6TCp6W08w6EUs1A4Zz2wRntBX8doLvPK+absA==
X-Gm-Gg: AfdE7cnlepJMsj6B+8eMpcSr13dx1DoDwUr7iWSyB5kOnh1V3NR2yHCsYMqqNa14LAX
	2b8LxJ7iQKbnmW4CTlubdFBc8Fu/MBoOQyiluVz93vVxGBgSM6dZieiOiy2HeSFhQYxLvC0qSDo
	MzzekIBz3Lqt6r6vAt/7woEa+StLG/GGEXrTLx2I5feX7EqTgdc/65IuwAkvsYd73IjhUsKcwxp
	zZbBmJhkMCcqWCbpIA+8bKnq1oh5OUlvjjO/Q4g/9bk79cr0W81fDtAGm2C0AYEqPLi7kcZWxf2
	npeoAyw6Ra+DJ4qf5mnIZ1y5ZhWijnhqL1sSdECAc/EBjyRz5nSJCQNTb8sjjVCyey2kaZ/aRkP
	ol1e6wEO7ogpvuBM1U4FzrKy9x2WTz6U6ireuAf/6dyYByz3NYdAquCDJ7uv4PLjBAXccekkFdN
	JgNKh0tGf0OZtF1Iqi
X-Received: by 2002:a05:620a:bd6:b0:914:cb07:447e with SMTP id af79cd13be357-92e78209b4amr55695185a.5.1782889489845;
        Wed, 01 Jul 2026 00:04:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm484446985a.4.2026.07.01.00.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:48 -0700 (PDT)
Message-Id: <198062addd9ccd3e7bb32fa81970ac00aa48c46e.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:29 +0000
Subject: [PATCH 11/13] reftable/table: release filter on error path
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

reftable_table_refs_for_unindexed() allocates a filtering_ref_iterator
and then calls reftable_buf_add() to populate its oid buffer. On
success ownership is transferred to the output iterator, but if
reftable_buf_add() fails, the goto-out cleanup only frees the table
iterator and walks away from both the filter allocation and the
oid buffer that reftable_buf_add() may have grown.

Release filter->oid and free filter alongside the existing table
iterator cleanup.

Reported by Coverity as CID 1671512 ("Resource leak").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/reftable/table.c b/reftable/table.c
index 56362df0ed..d604ddebf4 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -709,6 +709,10 @@ out:
 		if (ti)
 			table_iter_close(ti);
 		reftable_free(ti);
+		if (filter) {
+			reftable_buf_release(&filter->oid);
+			reftable_free(filter);
+		}
 	}
 	return err;
 }
-- 
gitgitgadget

