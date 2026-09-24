Received: from mail-lr2-f4.google.com (mail-lr2-f4.google.com [74.125.230.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADF311946
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235662; cv=none; b=AtBzTMnKKAnZ4g1IdWxQAFtJSEDyGZQcyil594WHty/m24K6UwqtBwJwTikjmVGZBfAptFPUHjzREJMo4NQBhO9XN1upz/KpRDAffWckzkt6Wy/Xp1NnSYzqEqqheNW7HLfpp0b4/lRVV/Tn76+2V+SMvSwL6LdVX+Glod3gcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235662; c=relaxed/simple;
	bh=8uxenRMUTCK/h7Qi9XflyZDXoM+Ag8dRs59/zwEiynE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjuYtVd7j7CqasshpptXe9u/dAciHUAL7MID+sLo9JQH6x85ie67eYlLee4ZhJb988tufvFQqmwvR40t3JYamWrkyzPurVHx4tFUOUySkim7C7FtUhAAhgjzTU7Ke/wKfMmjrjBNlFy/8aacumWi4xnNOdhkhnIj/YwxMnbqzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwfJy/xE; arc=none smtp.client-ip=74.125.230.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwfJy/xE"
Received: by mail-lr2-f4.google.com with SMTP id 38308e7fff4ca-3a49bfe419aso11750821fa.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235659; x=1790840459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AX87NPLiVrK1YuNPiH8WXqvA8kPS38Xm0LE2iWbuk4o=;
        b=kwfJy/xEPvTHJRdqfP2/G6ld9cSlKBvZIO5ohAoVIyVRuuG0nHy+CKlhTqxvgfqmRq
         qsbpBX3nuPfllROe2bwR5AzGTQ14iB2O60ItPZJGGxAPO17iwNCc9fWqfwty6UGhSDOT
         GX9pSzgz+5IxwEfEt5Q2l4ZriV20eMhJxWXTdoYEp8C97MFeHW4Wb1sq+FI16ljegoSF
         eBTuQUC8/YUQXxI+J4pOPWp5w4WjHmz2sjhbEAeFY1L0OZK91VAJsfkSzgJzfKXdFURB
         kgact6POiUQi1TDylE2ypT+/qlV7JDLz48QNYILVEJOwx2xqIaqcJUnRwjK+0fGKLXX1
         mJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235659; x=1790840459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AX87NPLiVrK1YuNPiH8WXqvA8kPS38Xm0LE2iWbuk4o=;
        b=R7V4i8qVbvbX8zQuu9J1QK+CoFWKn5rxMyEoLUzuDOyzcGKpokJQMalvRN9l7Q/5Sp
         voXokWDVyuakwcRdXHy8jnvXFK3+/aHfsJIiFTBBNshB0IvfRpKdCPTO0IVHM4VIgx4s
         BxWqoyLbn5qGwMjTt+NwFIWU/N+XIdloEheiqaPfIFge1GaobEDiKH7rn8ztjfGtD1fn
         42hrc7SjxvR491ZbrghbejIRN9evasWnmyMyZzMFjj23PMU6fjw+wXy7AdZF3nr2Cidw
         yg8vu9EtHnM2zE7YGEYS75+19E+k8UaDuidr6SvoNOkcSC+z2fVyJ76i2LWEhm30y6XQ
         T+iw==
X-Gm-Message-State: AFuF++k9u9r+tl4Mh0CXJlQ8u6OveCPEqi24TRrPse+xxOC3AuDBOC8Z
	LQ7SnhZi3zfcndsA1evg0jRVt9JhN9u7z2mSGSgo3vR77aEPmtnTgRR96bNRCKGe/XOyZg==
X-Gm-Gg: AYBFou278IzCdihPoW9Mb7Sy/GggDkZA00H5zK60zwK49wexKaSEAiFwhm4hYCnv9Eh
	tfP5zORJKhBxPbgxu2iAtr5ie4O5cgLojikWeI7D8Fn9+oYJCnB99eizQwSG1zOC6MQB2OJB0Ww
	TKUKLbwVkjI0I+X9iOY5wdgH0SOYQOCdl6ZgkvoH3wlS187KOiRCpFiBpbRTqi3C+4um6dBdUG3
	U17N5lLmMew+g12cDtWxj1OIJEqmArsoXhGoTpgZqCt3UGNqlDIXclljY1OeXI6EWVSA1WsazJa
	xIlbfvCiLSYoiIP+Rp/2WKh0tJjy8qcHXzmMjDSMkOGhAm217RqQJhO+2tTbtqPDhWJJO4vavoG
	mdc3+ldP9A1ejXAIQsWKyQm99YQmGmKFAti9tlxGOaU+zNLhROjiVVuqb2rHxdss5YyNh5MTiBO
	C6udquSsxgIecjGVDzSXbb/Pk2nO9MsdoZdKHE7SisF5sdHpc=
X-Received: by 2002:a05:6512:acc:b0:5b8:cf3f:6e40 with SMTP id 2adb3069b0e04-5b8df073512mr561798e87.18.1790235658641;
        Thu, 24 Sep 2026 00:40:58 -0700 (PDT)
Received: from DESKTOP-OI0N70R ([146.158.109.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a63bf41bc1sm5251661fa.16.2026.09.24.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:40:58 -0700 (PDT)
From: parovozik <kaliugov@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	parovozik <kaliugov@gmail.com>
Subject: [PATCH v2] doc: remove unnecessary commas in git-add and git-rm documentation
Date: Thu, 24 Sep 2026 11:40:41 +0400
Message-ID: <20260924074041.1428-1-kaliugov@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <xmqqo6dn6329.fsf@gitster.g>
References: <xmqqo6dn6329.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: parovozik <kaliugov@gmail.com>
---
 Documentation/git-add.adoc | 2 +-
 Documentation/git-rm.adoc  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 16b06e38e1..3fc2513a2d 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -223,7 +223,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 
 `--`::
 	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
+	the list of files (useful when filenames might be mistaken
 	for command-line options).
 
 
diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index b5ead86796..67061e961f 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
 
 `--`::
 	This option can be used to separate command-line options from
-	the list of files, (useful when filenames might be mistaken
+	the list of files (useful when filenames might be mistaken
 	for command-line options).
 
 `--cached`::
-- 
2.52.0.windows.1

