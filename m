Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D233C183
	for <git@vger.kernel.org>; Sun, 24 May 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779657850; cv=none; b=gjE9AqKllWC310B36dAcl0jw1mSyK8/nw72OceSdTzB9yjyTvrnvB/x5EhX1B+TwycdAbz/pLivU+ic5HfJyoAGrPfgBscxUZaNZSDKwbuiLESJTL3jhc4yUUWOReC+k6yvs2Qmvr/tPz6eqnOr8R3b1VNd20nyKfBa3kpaseb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779657850; c=relaxed/simple;
	bh=KwEpRIWvmfPQxrVsuu7wVpzkbE8tOgIPMrIUyznTY0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD6Ei40EshOidg3zdDmURAx2lb8hiT5o87iTC1JJvhGq36iSvrdEUtOBb2Kar9aLrWpoPZvLraP52CApRaNPfv3fE0DlEqB01gcRKWRUEZcLtzUvOuTDIUn8w8hz00TSGHmM+E6ONWibXhITeNsAKYHH4hSPCmkHX3L5xDEoyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiICCp3G; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiICCp3G"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ca12973e15so125304026d6.1
        for <git@vger.kernel.org>; Sun, 24 May 2026 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779657848; x=1780262648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL0fs32ib37nErBgD+WxGI20rg2GJdDhbbkj9+9x34o=;
        b=MiICCp3Gl4TiIEsR4APA8XogZTNhMz8pbeo3zeQBJmkfooHAo6CcMya2RmP4OjfTFk
         7BfNCMFnKEHIC7e+mNkWFmFhwDO1gqDOdAAYExP/QCnVnzx/PlqdZPdqZr4IMIrEHSj1
         0BUxxJHRBdU1JZYAAyW06+hbBSzmNAWMAS2AlKrsvgh7BXrvz6dlvdWV4CwXRd+73GGj
         QzTCtaz3IHaL4W0bW61wH6VsXT7pKlY5So5b+YxgM4jJ42CobFMNLahacFRpc314Ke66
         UREkpHcivStApbwF9WlE0mgqVIUMMezGbzzb1XoYjzixNrVGPWdMbIDiJx882oOJ8yky
         7e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779657848; x=1780262648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FL0fs32ib37nErBgD+WxGI20rg2GJdDhbbkj9+9x34o=;
        b=gOJLy1tanaJBpSS6nLc9y+qXmcNIcTK+DODNRRw7BN5fMSNaBDDMbO3A3idcXoPsVp
         USyEflQeZzggQr+9HprlTXqtj75beRdYpm7h8zAttlA8AfmgSb1nc70k2j7qVePOGDyf
         g7G9EXQtQjtTpvK3r3//cSWTpr7t8khnkex1khuhewvG2NlC2Q6L9pDufhNY3CdkMBjU
         ZoSgb+w/5eIUJsAIU68KsxEcNCZKAwKy6+yan4SNU2Ixwh8U/5dfFzHQNpAEhrCCqK80
         4+H/1FsVOt0gIId/aKzpvtOOwc0RL4Mg+sfgOuU+CqBPNDslnEMiwTHQzyz/CfS/lg6u
         XQpg==
X-Gm-Message-State: AOJu0Ywg8VrWuKzbY18oP+8wEiaGfcN2fbPq0TcwUpq2rUcQeshTg8SB
	+iB3IT5fuRPKkk0FIabhVRj3l+YMhpfJmtS+tlj/HlTEK5GU3QF7ZxFrdulWYw==
X-Gm-Gg: Acq92OFoSbdXWj3X0JQ1ZCfwUaco4nUmOrU3SGNrC18/w1O2A9rLINpznazCJZUARb4
	Sz4BXjra75U2gnVQjpcoP0svKzAAXuZEvyJcnpM3em6jBFiE4TcmtrChN+I9PWDVI8aKX1l1lzk
	hoI1BjXVAj8Ik1vS4q2tRBmT8BY2QspbIGW6bkZufNXDKkaedb13V5YnlRGa8YYyNa05SfwDhHN
	Yhzj332esBwxaIXDKBf+nX+8ZKGEXgSSH1mGtftTLnwlerigpTcDRxl6vAykfvC+Qcy/BgLj3Da
	qZ6V1/SIXuKqTjC+xu8VCyXwR6ZkyoVCHdauKO/kc/bPJzVGEuAPFxx8rEdN3ylbU2RPdC/I4eB
	ClfztwldZLW0/H/bQi0759X1hBHsX6E3hEkS2NhV5z49/JDSOaoCL05sImUyT6CnEEf+kaSmne1
	s8ClKcHNm8YgKkqX6JJGswFq3YdzqH9eKOeT62Ngfewk/Vo0tmxN+0Z+8I/ZnzETdB73zUryIU1
	Pr3AesUVuw2mF4QUQ==
X-Received: by 2002:a05:6214:2dc5:b0:8b6:7f3f:5286 with SMTP id 6a1803df08f44-8cc7b62d286mr207458836d6.20.1779657847954;
        Sun, 24 May 2026 14:24:07 -0700 (PDT)
Received: from roly-chicago-24.localdomain (pool-72-68-140-49.nycmny.fios.verizon.net. [72.68.140.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd813sm93270946d6.10.2026.05.24.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:24:07 -0700 (PDT)
From: Roland Conybeare <rconybeare@gmail.com>
To: git@vger.kernel.org
Cc: Roland Conybeare <rconybeare@gmail.com>
Subject: [PATCH 1/1] subtree: fix cache_set failure on commit reachable by multiple paths
Date: Sun, 24 May 2026 17:23:39 -0400
Message-ID: <20260524212339.1493145-2-rconybeare@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260524212339.1493145-1-rconybeare@gmail.com>
References: <20260524212339.1493145-1-rconybeare@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When splitting a subtree, committs that do not intersect prefix
receive identity mapping (oldrev -> oldrev). If such commit
is reachable by multiple paths in the revision DAG, the cache_set()
function may be called twice for the same (oldrev -> newrev) pair.

This triggers fatal error "cache for <hash> already exists"

Bugfix is to make cache_set() idempotent when the same
(oldrev -> newrev) pair appears multiple times.

Signed-off-by: Roland Conybeare <rconybeare@gmail.com>
---
 contrib/subtree/git-subtree.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 791fd8260c..64590e05e0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -343,7 +343,13 @@ cache_set () {
 		test "$oldrev" != "latest_new" &&
 		test -e "$cachedir/$oldrev"
 	then
-		die "fatal: cache for $oldrev already exists!"
+		existing=$(cat "$cachedir/$oldrev")
+		if test "$existing" = "$newrev"
+		then
+			return
+		else
+			die "fatal: cache for $oldrev already exists!"
+		fi
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
 }
-- 
2.50.1

