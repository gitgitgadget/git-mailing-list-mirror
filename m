Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DE280CD5
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774146987; cv=none; b=TWkXk59l9FTQ462cTn1Zjvyvn10Rp2Pm0tbPrDOYSA1QNC3WjaxavYs5NpVjd/sSPo07SNHe52ZvSsbQJCWR5Oh/X6jGNgysZ2gq9O6KXHDryhgfBJo59txnqCoz2TXyRMCvSnj6imzNV1qmsDf2b59YScz2oPS0W2PGK/1zHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774146987; c=relaxed/simple;
	bh=Cz2m/JfH5tM9USiRz70kCs05ykY0IQDgDNXObU4nfv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWen+rpCqH5NLGotF2k9H8Azk1C1N5B8MejsARQ/67DG3Bk49y9Jd+ObBdt8Eo/4ieiczhWkowI9SuUPmMuT/x9dpC15BwrEy66sIXDNCos96N+TCplYvbw/tcvsQsrUzSYqMPe3IP8UdoR4QDuwr+je6UpydZTq8rcnYouhEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5mCALN5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5mCALN5"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso1212044a12.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 19:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774146985; x=1774751785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=davMrHZzgr+7vByoE1xsFEIxAGdNdRGuuOhJOmaoSjY=;
        b=e5mCALN5R0XVWF2OOCY/8clVk4O0sNO5vfRAwYSiv9lvuCWjFRW4d8lpjHXtcchSRi
         Q/zFORVbcSKa37/D2Ibup8Pdg9eRLjQ/QjdWfrD7j3hsovDNEcB1kVAZVQspKUcQ7IRh
         N9gRSa8KpVwaztNgnC32ttv4z6hLI37y5ZLuQy40mXDtVQljW4Abgar3u1hLXd9bs24P
         isN9Z5gzE+rqUPkLcPuOIwJXs5jWRta7WNExfGPUGNZcDRFhj7FjN+zSxAy4v1GgIkHj
         hAoBdY5ndJmrFWC5hwDSBeePdf9DZ6q25ujRM2LR450dqq0BQDWgR/LUBqdN0hTYTEQE
         f3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774146985; x=1774751785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=davMrHZzgr+7vByoE1xsFEIxAGdNdRGuuOhJOmaoSjY=;
        b=mlOzjhZ1DCHQPJio47CaIO7sAqF/XK5Z4GhFc/iD0tYoqA0YPOq39zKbt5GdHyCrir
         jgA4jN44JMzu0YDy7z8kcBK3B3LQit/CRms0mNc/Z+FozQ1/BVxUO8Oyzv/LW/+z8dJG
         /ui3LqqqlTZP24ysyKB0J6LOm8yAtUPCjL2co8onhWwB8sHRYmJorQ1DFjnxUS3FqZes
         7Al3mEsZ1SeIuuMSzV45TFr84twZ3m8eu1Bzz0UnCBdPbFui9Mwz/zKZAK+z8mxPTMz3
         T+Fu06DPS58ZIN63vkR9xCHu3oMHug0v1ur7HWK7+7G/K4MxMRR8pwFQKqk2f55mqKxS
         FQyw==
X-Gm-Message-State: AOJu0YxoEhrdPv9EZp+nXWXhoWOxMxBbP0/XQFBUUP71qt2Ce/v1jN8s
	hKYjvcIPTiRPExFgAiVW/9dj4zRgDauuq41eAM9NsZXmgL1TlG6G8CNa
X-Gm-Gg: ATEYQzxaOQouEcjtjo6DRty/MNl32TgXXqW0IIBAOeXKeVZ2/cDWA1pamP7Vv2+XJ5k
	BOuvCPkX9gZ+mk5uLlhchnJPBVDSSlcef5zUo/Q7jqYuPB0kK/7yxayrm3piieGvOb/YhTsnwoA
	6Cn7YJHcxIBaP1Hi7XPzxdEdAHBx16nUoRO4EvAnxQ07qqBjl0LUZmGMY450fJtzkc5gib+qzOL
	sxHoU8LAwLpxaKOYRYAwgiDnrnZacPwe+DjMFlN7gC4hChgNQ5SNplFP/BqsvLoD4k+rEqe1RPU
	LuaYoGsz78VjEbT2EEOHg/DO7GWo/3V6Nol0JVneeJBLaAdk1o83mB7YpJm/UlqpChmREKlP3uI
	R05p50aGTXt4afrffDaYFJf/J25RxHZrv9pbEXrc+oAi2OLj32L+O8XnavBGSFS6BhAMCp+caeh
	RdH3LOdY2iuBZX+RQH8iU3eWapDSAvwY1hO/FZH9keEXsjyWQVUHGLd5mQhh0evyWDWLQgA2w6a
	c97TM77BrSYzJjYNTTx1RPyyhBao+pCTQ==
X-Received: by 2002:a17:903:2284:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2b0827a4c3dmr81214255ad.36.1774146985426;
        Sat, 21 Mar 2026 19:36:25 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366b9aesm83351665ad.58.2026.03.21.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 19:36:25 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	joliss42@gmail.com,
	joliss@gmail.com,
	gitster@pobox.com,
	peff@peff.net
Subject: [PATCH v2] refspec: safely parse refspecs outside a repository
Date: Sun, 22 Mar 2026 08:05:57 +0530
Message-ID: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
References: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote helper like git-remote-http is invoked outside of a
repository (for example, by running `git ls-remote -h <url>` in a
non-git directory), `the_hash_algo` is left uninitialized (NULL).

If a user has a global fetch refspec configured, `parse_refspec()`
attempts to check if the LHS of the refspec is an exact OID by
evaluating `llen == the_hash_algo->hexsz`. Because `the_hash_algo`
is NULL, this results in a segmentation fault. This crash occurs for
both standard and negative refspecs.

Fix this by ensuring `the_hash_algo` is non-NULL before checking
`the_hash_algo->hexsz` for both standard and negative refspecs.
When operating outside a repository, fetching is impossible,
so bypassing the exact OID check is the cleanest approach.

Additionally, while looking into the remote-curl execution path,
take the opportunity to remove an unused `#include "git-curl-compat.h"`
from `remote-curl.c`.

Reported-by: Jo Liss <joliss@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
Changes in v2:
Instead of adding a fix by giving a default hash like we did in cmd_apply()
I understood that it is impossible to fetch here.
Therefore I picked up whatever Peff suggested here.
Since I got no feedback on the test, I am assuming it is correct and leaving as is.

 refspec.c                   |  4 ++--
 remote-curl.c               |  1 -
 t/t5551-http-fetch-smart.sh | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/refspec.c b/refspec.c
index 0775358d96..a864a0bac2 100644
--- a/refspec.c
+++ b/refspec.c
@@ -84,7 +84,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		 */
 		if (!*item->src)
 			return 0; /* negative refspecs must not be empty */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			return 0; /* negative refpsecs cannot be exact sha1 */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
@@ -101,7 +101,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 		/* LHS */
 		if (!*item->src)
 			; /* empty is ok; it means "HEAD" */
-		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
+		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
 			item->exact_sha1 = 1; /* ok */
 		else if (!check_refname_format(item->src, flags))
 			; /* valid looking ref is ok */
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..280880e54e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -2,7 +2,6 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "git-curl-compat.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 73cf531580..ed81e6b49b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -782,4 +782,19 @@ test_expect_success 'tag following always works over v0 http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
+	GIT_CEILING_DIRECTORIES=$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir nongit &&
+	(
+		cd nongit &&
+		env GIT_CONFIG_NOSYSTEM=1 \
+			GIT_CONFIG_GLOBAL=/dev/null \
+			GIT_CONFIG_COUNT=1 \
+			GIT_CONFIG_KEY_0=remote.origin.fetch \
+			GIT_CONFIG_VALUE_0="+refs/tags/*:refs/tags/*" \
+			git ls-remote "$HTTPD_URL/smart/repo.git"
+	)
+'
+
 test_done
-- 
2.53.0
