Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32120541E5B
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201009; cv=none; b=Wt/h62OdgLdDUTNz2Zug03gW/hck1VHNDpdHrEJ8hBZ4Gb5+RcCpcQw4V7ktDnjincIk8RMB5P6x+7aLP2UILZCDsJOjAdSIZJzYxUugECyIM+V63ceUpnO0NHd5RC9B6fn1/DchOhn8qHm1FxxRon8gxnKLFVsZAr/EENyHqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201009; c=relaxed/simple;
	bh=lR75QgJBMzWSb10G4UG2vnfTlTBXi4DTmeW3HoC+e9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1hEckmQ2Bit9bLjE5DwwKVwugSRNiCtTS0qcz/MQCXimjmlfUgH7WsDJir9BSsQdoOnCkIvEHTzyxXUwsyQz0/a+Qt7JN6QC+nVSCFZaQEwK3jvrSD34mIi3ftX85I3krwQxljnCHwqP1hFnaJpcwcGhPPX4xd5XMxSL4JybR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5z7cxm/; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5z7cxm/"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a368895so903602b6e.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201007; x=1790805807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CKaFStW3Em61PAggt+h/m9AWu9oFR03KgUEEc08UqU=;
        b=d5z7cxm/J4BXVrHkInDZL6xf8+qXc9PIqguCV+/eTUfkfWn4QMBTg/n0WVsh+1hlVV
         UZmrjBKcG63D0GpuooasQn112FKRrAXYGF/4TEi2MjeQ22eYNJ1z0aYfC82Nd8KQTPWt
         FFBUpPOYG7wjiO71dwxaCpTQgidTKqvdkL6U7vis07fPOlnUMtHoaTewFjTba5kzFGVd
         S4DBqAz5GE2SkIZMtYB+Zd9sNLGJfajpP7Qv0lAwWYfWGBFRWW90QlVR5zKj7Pox7wcI
         MrOl7u+DpeNq39yuqFW2THCjJcJGOwQLAIAfuJcRGDt2TfkpSerwiiuBuVblD0uF+p05
         N/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201007; x=1790805807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CKaFStW3Em61PAggt+h/m9AWu9oFR03KgUEEc08UqU=;
        b=sIRdN34og56gVOGxSWN5E64Jas26HoazMZb540zgw7MvDr3vhiTjEZ91CojtVeHtNi
         ncX+mSYot9BTZmgzKDGP38LWq9qTndK7FZcyusodgWd+fZg/K9MVSZTxvHpA9XvmOMOD
         3II4D4v8c+iRvAWwagLRArAzHCO8kUdFq/RXqNxyqcwd+s5kyxQmtX2wuUk5/0YMh5t0
         XRP8mw0hwP4i1okxY2S9gJGOZoPFn1lmulQW/pDYw8iWxw41gl9S08X545XoNOwD2WXR
         8ZJpBNbwr6EVh8VmzhCsLXn1pvK2gBJhe9P2P1EdU5d8ICJC2HYGyILbJDvoXZQcL/ml
         3wjA==
X-Gm-Message-State: AFuF++nkzYtjwgjyTXvs32fMQ6htkD1p5J4i7OrjEd1ztarBhNgS7KfV
	d3xRnTS2ysrbB8P0DTcW8G867OL9YwXVgn4hiuZ0D3mrHJELTkG9trUp/u3uhg==
X-Gm-Gg: AYBFou3nYM8Eik2YYAvIBACFGDWBHoqntFBpoLHAdKJmTy09cmDfpoeYBwABUC1DeFr
	gye0KPp/zCyfvtv1mBM2YPc59GdIh+NCmrR4asgzkkTTXyFuH33Z3moo9xLoSZki53IGHnXrcap
	1ht/I2HG7fhi5ur5Xz9cK0UD6dsYSAOCP3w28AqB1hsIk4XSKvY6Jc80TOLdBQ9/rOLnNtTMPIh
	oDYpX7nr9MpYlmoc4DKUCg1OsY+CUIEm3WvPeXvhTiZPT/B1KKK8xqJ2igKeHeKFrywWhcFri/x
	utqO0PuPFM+hgUDcH3LsCNWvE40Tu1uWXTih3bk0InjjL3Ueh79Lb0gPFh4aH70W3Wal+dE6KFW
	gt8IBMkVLzBUh1RIQ4Iw9A25+rNqKzT8N9/MVn4G41+gOF+wW6SChyF+YqUpL/DeLg4/3o7SrBT
	mFk+OqDQ1XChfe5ZdvOBmK1U85J7CzdtpI50S3srsfItcXkMDayPP+euWx5kgUgdvZhFG9WstTk
	sfh1BhC7M6x9OKphHx4+G/eSbkNz+auwFaYCg==
X-Received: by 2002:a05:6808:6782:b0:4b9:a8ac:489 with SMTP id 5614622812f47-4d72df6ab54mr579826b6e.39.1790201007017;
        Wed, 23 Sep 2026 15:03:27 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c43b74c9sm3364802b6e.9.2026.09.23.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:03:26 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/2] object-file: lift ODB reprepare out of packfile flush
Date: Wed, 23 Sep 2026 17:03:14 -0500
Message-ID: <20260923220315.569424-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260923220315.569424-1-jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com>
 <20260923220315.569424-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flushing a packfile via `flush_packfile_transaction()`,
`odb_reprepare()` is invoked so the written packfile becomes visible in
the current process. In a subsequent commit, flushing the packfile is
performed earlier when committing a "files" ODB transaction, but the ODB
reprepare needs to remain the last step.

Lift ODB reprepare out of `flush_packfile_transaction()` and instead
require callers to explicitly invoke `odb_reprepare()` if required.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index a4cbf8b081..0f123b79fa 100644
--- a/object-file.c
+++ b/object-file.c
@@ -857,8 +857,6 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
 	memset(state, 0, sizeof(*state));
 
 	strbuf_release(&packname);
-	/* Make objects we just wrote available to ourselves */
-	odb_reprepare(repo->objects);
 }
 
 /*
@@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	 * to zlib compression and is sufficient for this check.
 	 */
 	if (state->nr_written && pack_size_limit_cfg &&
-	    pack_size_limit_cfg < state->offset + stream->size)
+	    pack_size_limit_cfg < state->offset + stream->size) {
 		flush_packfile_transaction(transaction);
+		odb_reprepare(transaction->base.source->odb);
+	}
 
 	CALLOC_ARRAY(idx, 1);
 	prepare_packfile_transaction(transaction);
@@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
+	int have_packfile = !!transaction->packfile.f;
 
 	if (transaction->objdir) {
 		struct strbuf temp_path = STRBUF_INIT;
@@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 
 	flush_packfile_transaction(transaction);
 
+	if (have_packfile)
+		odb_reprepare(transaction->base.source->odb);
+
 	return 0;
 }
 
-- 
2.55.0.424.g13c7afec21

