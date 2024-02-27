Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119231482E3
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046601; cv=none; b=d3I7X0EILMcoo/JIZ/pqQE3jtRz5OcAFOczgWkAzkbdql8r/6YS2Tko7Hz/GA4dWvQhTqbPHTw0xjfJpdKWNv3fMnZZN+LrdZqCYQK1qAvhuwgfR7N8aJWt9ER02nQ8zgO+Gi4f2vIJxNA/wH8wWF4PtMrHY0s2eRxRek6ir6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046601; c=relaxed/simple;
	bh=ss8wEPQhUrwBOIq4BkUXzplHoevc/0jYFgkJtUVyNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIneeRXX+WC/eBeg6HdoFbZsEGkwXJdSWzHIHQQJnvI4fM7djavNwSHxfiFCyqrWlyD65SGx4GWWk8MuW5/mrW4/FZ+1Ei6W8d2BgNthWgqKfWTVyHcSQ3KbLUyGdRnxmHnDfKEel0WEeJzEBkr4ZfGG7nSZ+fTDOleHhBnMRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzK4ePm8; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzK4ePm8"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1a2f7e302so959702b6e.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046599; x=1709651399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcBb9YUvq+p3EOGxZ9MY3/p4E7NvnPbgKnUHKwVO7NE=;
        b=NzK4ePm89hN1XBg+WGwRVMzx2EiuiS9QoCvsGvAZYWb/RWsNdMwha+acGdFsJySSem
         Xm7Qh5tt/kIJk24nfdo4WuB3PoctRqXcvNjUD8dryijjYg96pMQ1hK1EehQmelkSqvqg
         0/HTlNae9aFkFDK8itPJuj0rhUQyuzBWuW3Etmzti+xQP3jrUEMOzyECey3lc6O2bn+b
         Zj1bXzW8Tffg1vCxAFvqZNa6eFgCau65LSo3o1nM1F4FfDGJSlcpNCrC55sVlJ174z+y
         VDzwg/EqSKYOePSQBFI1W0TM0MkG9+OsHaAa+fxH4YCzDYG8V3+j7pCE+hlxOIqpx3SE
         s0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046599; x=1709651399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcBb9YUvq+p3EOGxZ9MY3/p4E7NvnPbgKnUHKwVO7NE=;
        b=TIdx9XPwH5+/Uz3SxeyRfzCzAcySeZn+J0SgNFmAXeeBnCZECyrXRFXSWMaDlbYkLI
         1c39Cy3zOt+oW/KAOEVpLgROFJjWIBlPo4MYyotXCEmj6brtS7vW0+cT9p+3n+DPI5vs
         1h+ksA8l3T0sAYMoXWN+bxPUgfWPcXTZTM6++aePFsP0k0S24HfXPQYNnBs2CRGeQ992
         ZuJsNgo2X9HyUxT+ci0WAgtz57YQyFWJuYgyDAv6JuEIFp3l8EDQ73Q3YdMZQWUDA6+L
         +Ym0fcsT9EIFn0cEJTMJUXCxgD7jljCF7CmAUvXswJmisIRTnrsN1asVOA1fTSnt/ge5
         kg9A==
X-Gm-Message-State: AOJu0YyLDO5BwCs6pPlej1DlesQtPtQortdfz+y1QcK3ISGfEBI24m0f
	53Qf5vPke8QrmftMIAOVH1DuJgwmikxarFmLwp7Bsm3PZlyUYb9jmM+Coico
X-Google-Smtp-Source: AGHT+IH7llTEU0YPXxFZpLaBdDWguglIBqrlpHZZZ/5PR9gP6krTsPV0Z/w5JrtI1J70dDOKwMvyHg==
X-Received: by 2002:a05:6808:2013:b0:3c1:acc3:99ce with SMTP id q19-20020a056808201300b003c1acc399cemr2620210oiw.37.1709046598841;
        Tue, 27 Feb 2024 07:09:58 -0800 (PST)
Received: from localhost.localdomain ([2607:fea8:3fa9:4200:ad2d:24a1:4eaf:e903])
        by smtp.gmail.com with ESMTPSA id t19-20020a05622a181300b0042e56fb8e0bsm3618149qtc.93.2024.02.27.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:09:58 -0800 (PST)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 1/3] builtin/repack.c: change xwrite to write_in_full and report errors.
Date: Tue, 27 Feb 2024 10:09:32 -0500
Message-ID: <20240227150934.7950-2-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227150934.7950-1-randall.becker@nexbridge.ca>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
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

