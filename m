Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A1331EB3
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679512; cv=none; b=V+H9PinNVHfK2PLuuCkOfEgT5KAVPt6L/9gDioNldCzqSNCGxYAGpRRBGQDVmKPD/SJlS/R/jwCotyLquTvVKjKzRZ6ff/q2vhiH3yZdIklpKAYnG7nfjiZaYOHK/ErdJPunuAvkawVIXrVOCwmUVxpVnn0eC4rj8oWyIKHGRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679512; c=relaxed/simple;
	bh=ojwU0F8JOnF/4dCGDoSwKPiSiTptyrU6GfgdxzGlPmE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cX3ep3WSWvq/dZashi5GUUQMbEY1xqEOrr+Bux/HeCKM5y1JDZo0XmBm0rRTb7TCyNsqmXBTa64apHEAtn2/8w/+u8QeduFTt8PoLzxj2AoxRinxtZ4rhKuP5Az4sQ9LzsRWUwz72JfK0bXZ3s223v1t2zMkO0KcgmnclujlM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J03VHQC+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J03VHQC+"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso2230444a12.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679510; x=1789284310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0KDVP46pUYEkWNhu+GnpCBIvYxbZhlMa7U2GWj8wkgs=;
        b=J03VHQC+xfYtHa8IEup53x2lzuqiwPyXwqTvVMSzSRb7d9VmZk7zNv+PW4lLyp0vIx
         XCKPbyenbKaF4HSCYvxKLadLEAQ/HlicgiSWIvhjlatUpb0rebhHfI7Prd+B+JTA1q7g
         hbTCIoRDckmFY/5GEgre+vb/HIMrYvOi9ZjhjqKfqtiqCETKk5kQX1su2bIaI7Q5X9cA
         Ma6RQLqSWIm3gkC0ALsqgnO5aGcoFauMsJkyRy3x8fl9eEg0AempY/ydUzKU3M94TVMv
         R2xxD13HNx6olcHxrcYExhlnog3TM2FTCIL3Kg4csRKKTTryBHl1qn/Pu5Kwe04myLDq
         1XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679510; x=1789284310;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KDVP46pUYEkWNhu+GnpCBIvYxbZhlMa7U2GWj8wkgs=;
        b=pQTQxfn3U3jLNEmiW1N1gjPlN2PYIhCQXVcV4iAN7WEOizVjY3OgYrlT2aTffFNWR8
         lqu0cKhUvx44JjNnO+uJ/hlWRiZPX8AuKIm9dWDpxVKSCB27MnaCtSc0tsEML197qatB
         Ni3aTXRAGzN0RWE7QSfCcbXWmVldD2EUdp+jxHHXvEvQfnxFEECcDe1NIRBnY1H0ocD5
         +bWFOFoRv5l8MgtI/Es9mQDZOFHOQ7UBkp775bdrd+rbMdqJTou+uB9CUxcBeBDfDu84
         wjVu8HDoeYWRHkZyOnBdEHdbQOZUCGdgAskWL899KKpOLHBe9Uk7bjYZF/8Hf8t2ToV+
         I1uw==
X-Gm-Message-State: AFuF++kCryy1PkelshCtpH8kLOu/D6QUPkrTHjJO5znBjmgL0tsoA/E4
	4xbQ5s1kgXtBNO7RtqUxL7WglY8TNy9gMcp5EGpAviBEZll5QotGjQT20nVtYbV9
X-Gm-Gg: AYBFou3QwoShtctzy2BUmkBCyEdXSjzSxqFPUEWcBB3eGBz9xSNRYwR1vABLEbxDK4z
	oSz9Io0pygPK/Lhp/9ECwI2zJ/591BdoBrTmhhbDPLMw4K7HRdDleaTSzu8aVBDkFyejBXvqxdo
	56g8NxH8/1xXHlUMWV+IT4iTPY4fKCWncMgSl/UzYW2KKDtKAcEzfF099wb3SrHwqSRY+DvhbF5
	VOKofGSPSgiw1GTBcsptheeRy/QVTPGsmeopAZVZxtE8x2SQErpQ2/b2n2tIlx91t6HEug9g1tn
	7h6qATI9dQmPLqDPEUMBLyIJutaRx34bxI6m+7UhkyP+J8cZ85tY+97h2KTRyCzKUmQpIvcruV7
	b8Xnf5rBJND2sPjXIPrBSwZC0jpdKWBuQImCZsQH5TMr3lPFiN5b7iKFgBo9ALAM9gGOAwUeLCT
	9H9kPQOhDUm2AtXTfOlpAlWO6onB8271MgdMX6lNuiPDZgXbrwF7a+5RjwP1ELC5xWbvAq6Yj4Y
	Q==
X-Received: by 2002:a05:6a21:600e:b0:3d3:aed2:6f26 with SMTP id adf61e73a8af0-3da21665f2bmr24206661637.26.1788679509978;
        Sun, 06 Sep 2026 00:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm18868796eec.27.2026.09.06.00.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:09 -0700 (PDT)
Message-Id: <afa44c6d2262dda7d04ba243fdd47563d997561d.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:59 +0000
Subject: [PATCH v3 5/6] send-pack: default to excluding shallow boundaries
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Sending a shallow boundary is almost always wasted work. We got the
shallow boundary from somewhere, and most likely that is the server we
are pushing to.  If the receiver has the boundary, omitting it avoids
transferring and recompressing its entire tree.  If the receiver lacks
both it and its history, the push is rejected either way, but omission
reaches that answer without first sending the tree.

Make push.shallowExcludeBoundary default to true. This also covers cases
where push negotiation is disabled, unavailable, or fails to find the
boundary, so users do not need special configuration to avoid
unexpectedly huge pushes.

The practical compatibility cost is the rare use of push to seed a new
shallow root. That already requires receive.shallowUpdate on the server;
it now also requires push.shallowExcludeBoundary=false on the client so
the receiver gets the boundary snapshot.

Two other edge cases instead fail faster with the new default:

  (A) A receiver has the boundary's parents but not the boundary itself.
      This likely means the user is pushing to the wrong receiver, where
      a quick rejection is preferable to a slow accidental success.

  (B) In a multi-ref push, one ref's shallow boundary can exclude objects
      needed by another ref. This may reject more refs than necessary,
      but retrying the refs separately avoids the problem; the next
      patch advises users to do so.

Neither case justifies making every ordinary shallow push send the
boundary's potentially enormous tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/push.adoc | 10 +++++-----
 send-pack.c                    |  2 +-
 t/t5538-push-shallow.sh        | 10 ++++++----
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index 0ad55965e8..a08ec04c21 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -147,12 +147,12 @@ This will result in only b (a and c are cleared).
 	If the push reaches such a boundary, refuse it rather than
 	choosing whether to send or omit it.
 `true`;;
-	Omit the boundary objects (fast). If the receiver does not have
-	them, the push is rejected.
+	(the default) Omit the boundary objects (fast). If the receiver
+	does not have them, the push is rejected.
 `false`;;
-	(the default) Send the boundary objects, retaining the historical
-	behavior.  This can send the boundary's entire tree, which may be
-	very large.  This is only needed when pushing to a receiver that
+	Send the boundary objects, retaining the historical behavior.
+	This can send the boundary's entire tree, which may be very
+	large.  This is only needed when pushing to a receiver that
 	accepts new shallow roots (i.e. one with `receive.shallowUpdate`
 	enabled), which is very rare.
 --
diff --git a/send-pack.c b/send-pack.c
index 386ea8b9a2..8a7cedf65a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -70,7 +70,7 @@ static enum exclude_boundary_mode get_exclude_boundary_mode(struct repository *r
 	const char *value;
 
 	if (repo_config_get_string_tmp(r, "push.shallowexcludeboundary", &value))
-		return EXCLUDE_BOUNDARY_NONE;
+		return EXCLUDE_BOUNDARY_YES;
 
 	switch (git_parse_maybe_bool(value)) {
 	case 1:
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 67db51e60e..e52f3e50e2 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -64,7 +64,8 @@ EOF
 test_expect_success 'push from shallow clone, with grafted roots' '
 	(
 	cd shallow2 &&
-	test_must_fail git push ../.git +main:refs/remotes/shallow2/main 2>err &&
+	test_must_fail git -c push.shallowExcludeBoundary=false \
+		push ../.git +main:refs/remotes/shallow2/main 2>err &&
 	test_grep "shallow2/main.*shallow update not allowed" err
 	) &&
 	test_must_fail git rev-parse shallow2/main &&
@@ -75,7 +76,8 @@ test_expect_success 'add new shallow root with receive.updateshallow on' '
 	test_config receive.shallowupdate true &&
 	(
 	cd shallow2 &&
-	git push ../.git +main:refs/remotes/shallow2/main
+	git -c push.shallowExcludeBoundary=false \
+		push ../.git +main:refs/remotes/shallow2/main
 	) &&
 	git log --format=%s shallow2/main >actual &&
 	git fsck &&
@@ -90,7 +92,8 @@ test_expect_success 'push from shallow to shallow' '
 	(
 	cd shallow &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate true &&
-	git push ../shallow2/.git +main:refs/remotes/shallow/main &&
+	git -c push.shallowExcludeBoundary=false \
+		push ../shallow2/.git +main:refs/remotes/shallow/main &&
 	git --git-dir=../shallow2/.git config receive.shallowupdate false
 	) &&
 	(
@@ -227,7 +230,6 @@ test_expect_success 'shallow boundary exclusion avoids sending the full tree' '
 	git -C adv-client checkout -b topic &&
 	test_commit --no-tag -C adv-client new &&
 	GIT_PROGRESS_DELAY=0 git -C adv-client \
-		-c push.shallowExcludeBoundary=true \
 		push --progress origin topic 2>err &&
 
 	# Only the new commit, its tree, and the new blob are sent; sending
-- 
gitgitgadget

