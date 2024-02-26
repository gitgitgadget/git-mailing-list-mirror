Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D507C131E3B
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985156; cv=none; b=X1a/nUc5EfaLXSaHLy2pmeDGZ2LiMwcGG36xMmnt45fPAckGdxGHyWLMXxm9fxiKDzKt2n1RtGPrGzeb4draK/6TuBMmA/qs/bob3xvAjdodoF1Fl5wS0tfHmHi6g+WcIuPYu+sSNl3qrpApUQstWZlyIbU0ulXnEgZJsTxQBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985156; c=relaxed/simple;
	bh=ss8wEPQhUrwBOIq4BkUXzplHoevc/0jYFgkJtUVyNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMfSQkpeopYxZOKAPC8SiqXwulwbI51qJDqouBy4VBy3cTNuL0etpAaHsP/kTcRmvT2D6UH5t9ox37KDy7KFH2TO2mZ0VIVtnpuhtq9vdz1Ucu9BSo4hBb/lXlIexIlJtWrOjmD78Mr86DUyyn/F90iaGlaHLHuaT0uenikyu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQjbtKUf; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQjbtKUf"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bba50cd318so2677066b6e.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985154; x=1709589954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcBb9YUvq+p3EOGxZ9MY3/p4E7NvnPbgKnUHKwVO7NE=;
        b=CQjbtKUfrUr92ZQf6EljQZe0Yz7GWJKs7KtqwzcR/SGD0bQ8oCKyWlIN6rQJTeZ94G
         PQ5B6pD5+kUnwhP89nbBdHWRt6rLzYn7xFAWgoxoIEtG2GgllQ+YafngITnGed8WBymt
         WFRvHHi58vshUAtglWUVIlJjDCjl6SVntBcEwKQO9t8RyohCwE6fkK9Ywkni+QYf6AKS
         2aoisCy9a0caG0Bo4nz5b1hvVWX/4v5q+bl+LIjkVp7DSXQKoKCCShTXhKVfM5MVqwMM
         2m3dyrncy9Pgs3oKnC1pThl0zA9ERwAXX6aRdic7VMwc9S/tmjCdwLIZsC4cb/QV+aJB
         4u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985154; x=1709589954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcBb9YUvq+p3EOGxZ9MY3/p4E7NvnPbgKnUHKwVO7NE=;
        b=qEeuFDDE2Xh2690WHPVxvssCwffAN4ZDQgZiAo/DE36FTRxmF84Tn8G7pWyXWhAgdD
         bl5BBHwixULYvY5XrI9aY3Nv5xK9fQTqGbvB0L0Pztj9mZZiC85zwfn7QURS62TqFBwQ
         f4W57ql3x+i5GeW4mrs3d8rG8fYVaVtTx7aZPXjT49SbS9HKJ303RoZvMCKullYCtWO3
         PtwtjOmZSEK3V1nHl7FnmmaO5/JDdoRQWWuV9EJgwU7a78TyZpd1OPend+oOWjBbA1t0
         1+fSN7kM37+6UMGvcDgwktZPV4C6tVkd21/UJUN+BtCFKoAMlmhBuArRbcBeWc0DoZ4E
         D6WA==
X-Gm-Message-State: AOJu0YzQaTCDfahn846NGjS1JRGyf9WfFk3V8by0UJUeInS0+089FgZ0
	KOOuRcqVxSnjgQU4OY0wL4+SgKb30HiIcGrZ5mpyvytYNJzUpjuq157hlz5e
X-Google-Smtp-Source: AGHT+IHGhxJkb9uNfn1ccjsvVNQNwJJbXqZlbiUD3CEKZqp3Lu4monfkUrrjJAAMDVdQxYjzwaCVHQ==
X-Received: by 2002:a05:6808:1893:b0:3bf:d840:6c0b with SMTP id bi19-20020a056808189300b003bfd8406c0bmr501094oib.36.1708985153903;
        Mon, 26 Feb 2024 14:05:53 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b0042dce775a4bsm2911696qtr.3.2024.02.26.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:53 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 3/4] builtin/repack.c: change xwrite to write_in_full to allow large sizes.
Date: Mon, 26 Feb 2024 17:05:37 -0500
Message-ID: <20240226220539.3494-4-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240226220539.3494-1-randall.becker@nexbridge.ca>
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Randall S. Becker" <rsbecker@nexbridge.com>

This change is required because some platforms do not support file writes of
arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
maximum single I/O size possible for the destination device. The result of
write_in_full() is also passed to the caller, which was previously ignored.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 builtin/repack.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ede36328a3..932d24c60b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -307,6 +307,7 @@ static int write_oid(const struct object_id *oid,
 		     struct packed_git *pack UNUSED,
 		     uint32_t pos UNUSED, void *data)
 {
+	int err;
 	struct child_process *cmd = data;
 
 	if (cmd->in == -1) {
@@ -314,8 +315,12 @@ static int write_oid(const struct object_id *oid,
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
-	xwrite(cmd->in, "\n", 1);
+	err = write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
+	if (err <= 0)
+		return err;
+	err = write_in_full(cmd->in, "\n", 1);
+	if (err <= 0)
+		return err;
 	return 0;
 }
 
-- 
2.42.1

