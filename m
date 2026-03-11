Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53422C08A2
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242386; cv=none; b=Gxsfaf0eEV4tdcXsgS4QZFw8HMxmAzcWVmoJI+ME/d/F8lf9kavz+RRtS+5+BjEbznsIC43hjBGTeEb9U3e/9JBFx0RwsDhCOCm7YwvyAqGO7gCAt6wyQ1f5I6hVzq62eL/tLBXTBhIbOUpB05zq5ly8VhSxe4FDwDRPhpbB1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242386; c=relaxed/simple;
	bh=plDCAMJ4eYVaHLy9QN4q0l2sMJAm6CIg/hq0RXOoF3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chkVx5dLrHdOyC9ZWwG+VK00OibSmwIK8ECXUGTGErlPXUz6yL410x23wgsTNthjQ0Bpg6R2ynYDaGwxra2hhZt/Ik6u4zm4pdK8WF9D9ym+Jdrv08UWywBnZw00DQEShGv6Z9SYjrF8KHAYeVi9karOIVq/YP4k4k9oiBRoYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvQs0fqG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvQs0fqG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so46635535e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242383; x=1773847183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzQxHIO6LrPPHVzVJBCbCiAGsL+UwT4U0XvnvsrQFDE=;
        b=QvQs0fqGUslj4iJMndAI+cUXnO8zkybi0CmUx5I4KfnYQHaNYehd2XTNcHA08biDax
         klWlZ4Y+B7Rjuio7x8IIFj+NMbuULGDuFNpaUQkIRtBFjo85ZdlhDElgA+/9cnPyR5og
         1607kdgHTtxq4bV8e2d1UIN/tKC5ml1iN6ZVPKXdD4rAKdiqczcumk4sXtPANuDpGeM+
         5Qb4lFM3JojdXTIIPC4QKmJyvzbEUch2gBU0+M6gSYSpOMw7Pz7kK48cME1i30vuZ5TR
         C3qILo02HtWnhP75BoOfZTjMygCzv9PBbgIxZ0W50XTclDYj25N2QrirzP8R1CeU6ifj
         rovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242383; x=1773847183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uzQxHIO6LrPPHVzVJBCbCiAGsL+UwT4U0XvnvsrQFDE=;
        b=L49vhG0RTWs6ZAwOuSvWV/kX4cu2rg7mp9FjUyCVCTdk3OanVARx6LEmbLfpmvs0S0
         XREwBgpDCNHCYbLKUIF7UPPgfJs+WYZNDYrJqjClN4Ip2Ru7ai66mb/+h0Gex95U2qPb
         Hm6EC+0Ms/062yBFe1eNYy2h7oGu8CPF+kE6jbLuBRCqiXsJZoC5Az/PsS6q3yxPz5Ya
         SPFHbWUxeqNfIjvCUIDgMcU6xV3cbclYe3BQSd/5UFK84H/Sd7zaCAoGw0Fg36eguwf7
         /MfOBM0EvghNjmUvFQe38R501pi76RYxltWb2yBTGzTc9Brt+NTfmdCojdhhl7OxU/Jj
         rdUw==
X-Gm-Message-State: AOJu0YxS3bq72FFKlELsuDqhpFKTlvajBAH0ABkTKI6UnD6iaHLE79Sd
	4w3s6SOhCIfuRIiodrWsn4FcKBkzH6AM+bCNli8cSOBY2M0SwtnnY9hGycSK3yq0
X-Gm-Gg: ATEYQzx0185xEikAS84G24L34pCKf/cNbEj/FyUvreBqfXQtJjMCzfk9RScomeBn+T9
	FY/2aMBkiPpXViecccRlaJXTp6dCQ6fHrPxCGUnP635f2YYgSDxHSPNMxKM50AAUnQpw4XRvV4B
	sU/Hb21H5poxHrGYSffQawX02XwuZ8/LKAYswZelz35H6bckkmuJfN07Rrxz3mDXZksgQEB0ZHX
	cmxLcdcuMrltYuulJD2/o1nUvtfIYzIqW1rsWWJ2mtUcKdybEcoVLXke247KWYsKLfAgSf320zb
	7118ThOGefDhNPJa3EtwRufEL9d0oZ+e8g1GiPvjCk2y+VCjJnNJ21VtGRwaBS5kRyrNt551edv
	o62SUtfi90T8rSCYhhlBJDDaTYiiugbCRUZPAiC+rsEgNzFwAa2QldruNXciLd1a459XjNq0d3o
	AJvT41K37KSkCPLhg=
X-Received: by 2002:a05:600c:4fd6:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-4854b0a6b99mr54441875e9.1.1773242383064;
        Wed, 11 Mar 2026 08:19:43 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm62743975e9.10.2026.03.11.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:19:42 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH 1/4] run-command: add repo_start_command()
Date: Wed, 11 Mar 2026 18:19:20 +0300
Message-ID: <20260311151923.4178655-2-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently start_command() relies on implicitly the_repository to close
object store before the spawning a child process. This prevents callers
from safely starting commands in context of a different repository.

Introduce repo_start_command() which takes 'struct repository *' as
argument. To avoid breaking existing callers, redefine start_command()
as a wrapper to pass the_repository to repo_start_command().

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 run-command.c | 7 ++++++-
 run-command.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index b27064ef57..fadc3d5283 100644
--- a/run-command.c
+++ b/run-command.c
@@ -675,6 +675,11 @@ static void trace_run_command(const struct child_process *cp)
 }
 
 int start_command(struct child_process *cmd)
+{
+	return repo_start_command(the_repository, cmd);
+}
+
+int repo_start_command(struct repository *repo, struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
@@ -743,7 +748,7 @@ int start_command(struct child_process *cmd)
 	fflush(NULL);
 
 	if (cmd->close_object_store)
-		odb_close(the_repository->objects);
+		odb_close(repo->objects);
 
 #ifndef GIT_WINDOWS_NATIVE
 {
diff --git a/run-command.h b/run-command.h
index e1ca965b5b..654ca659b3 100644
--- a/run-command.h
+++ b/run-command.h
@@ -2,7 +2,6 @@
 #define RUN_COMMAND_H
 
 #include "thread-utils.h"
-
 #include "strvec.h"
 
 /**
@@ -15,6 +14,7 @@
  * produces in the caller in order to process it.
  */
 
+struct repository;
 
 /**
  * This describes the arguments, redirections, and environment of a
@@ -205,7 +205,9 @@ char *git_shell_path(void);
  * that specifies the details and returns pipe FDs (if requested).
  * See below for details.
  */
+
 int start_command(struct child_process *);
+int repo_start_command(struct repository *, struct child_process *);
 
 /**
  * Wait for the completion of a sub-process that was started with
-- 
2.53.0

