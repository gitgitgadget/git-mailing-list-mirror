Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8AB23CEE5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997244; cv=none; b=bd6VeFnJ4G+sLg8sf2v5TEwyFW2iyW8Ob7kPJMmOZkrY+4BptrjvS8a4f0luuoK3em0scdFcBlImnNXBfeXUCZ6YbIs0SmBYq6L75p+W3MNCSU8sp7htU/kPHP02340xWWQKitFrcXkGiGOGnxYk0Jkvl4w1S0VyhpwkF78upOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997244; c=relaxed/simple;
	bh=YdbQX8o/qRt4ey8bCprVUmna7+xu1Ip4LcuAbzL+U8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHxQ7FshcV+X6SiyOAOa2OttoimuqeUN5eDU1jXhtR+kcYlpKsbUeeEpmc6gW3AzwnpOcxx8wEvWxBQWjGpwFOWDyTqeaq7dV2hgJO9EeuELuhy3I5zNDUXUY7bU0hsYIK3I4pjYKLgdrIQaEcN3VK8J2b70XkSP2bSXo5cWLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvl+JKDU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvl+JKDU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d28c215eso2533685ad.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997242; x=1740602042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqWghxS4GpQV0mu+vqf4BwXRzpu4pPkVyP0bFcj+00s=;
        b=fvl+JKDUG/MrW3sIjyv/2HdSy+jBCL4TOPv9Jm+qqeAs/ze4PhFbMeV7GNUOWa51v8
         wLoZ+QZdbKK7ype1fFcl5z/FxeWDETBIYLeIxUJgRFcpKfNS66GZXOVkvcYeDSE0oBpr
         yzq24g52dpcdkWBjnuihhZsRcA7ta/b8Yw/OCI5QguRFzLW6A7bLS8Dd/MhPcbZEgqjg
         yRlD8m11mxuArSdwhXu9hD6NzlzWjZJooDt6YH2SO6neiXz2gwXlFvtdQvJsxAvyEGQw
         gm/mew16LbEKu8yx07oUzXjZW4MiCTrQJ7sfr+8EvajIIh05g/Ybz5z2/hX0pWLv3CPb
         XxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997242; x=1740602042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqWghxS4GpQV0mu+vqf4BwXRzpu4pPkVyP0bFcj+00s=;
        b=AkmFs/QONb9l6V1S2NTsWfWsVGehhcR7DiN89BgR91PDos4LjV76Ugx/omnCCToSLA
         99DP0H2WtNl+olMkV4db+6cO5wgr0BzsfD9Q9wmD8SviEhrHxLemZjT9ZMnxy+ZpV1Qb
         WK3fh/r2BvdEwDSi5wZcbqKnqqhXh1dvlfq7kvQ5sFMy7HSKYWzWbZzVxF41v354j23o
         q4Gt+LD+qsTiU8q+NaKd+c6maVDfKG4UksDrHbcOm29cMA8KJWE84wj7bb4qipFcTqLp
         EA49JcCW8yBKI///pI+ti4qxTefcMKQb3Qh6oG1cFUW59xvXNbrlEOLDnKxYTG3ji7pf
         /05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+w5cuUUT/Rj3bPsY6xrs+m+D/CwYhr3Oi2xJFxJqWghEbpLzAzvSFOxf6MurP3EmcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZRe9nAXmBQO79IUKJTlO6yfXM1KubZTQu04sFp1MPOpzDTi/
	qxvVdttvqhIrk8PAWcB0f6lpDrnjrybfeT4EqkzfpTI8zcosrZaw
X-Gm-Gg: ASbGncuoDAJA/Q6tfS+vSa/dQd74kqwEZaKeF3BlcPz1cRoErLyh2RRqa6fn8QerOOB
	Y96lFV9ZstQGyd9VrmQGUfTy60dnosJygbOyk+msjvwNCTlrTiK3zzPXh52QT793ddAldELUSZ0
	PkHqilgfuFbRroAf41/SUXGj01MpHYmighKUYZ6/CWaMHedf2aKmXTj6OIBmlRgSof8GcQubJVz
	fpnCF/x2GQlTZtnQgWbPLmKfLfcLJdqg2vn+BSKq3KuYZ0jw+Uwx4ZawXwDu40DV2QLkvzv2694
	4wwmoG8M5xzEZlCXWQRQU5UXkJ2gCFXIqKVANZGG
X-Google-Smtp-Source: AGHT+IF0s/uMZ2hvZNL7EYFAlNI/hcGMXTJYzmg5cOShqVK22VLePfThNSe+QBpN1X9K620tRpDAmA==
X-Received: by 2002:a17:903:22c7:b0:215:5a53:edee with SMTP id d9443c01a7336-221040136afmr290063945ad.9.1739997242343;
        Wed, 19 Feb 2025 12:34:02 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:02 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 02/12] builtin/verify-tag: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:50 +0530
Message-ID: <20250219203349.787173-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit, without having to consult much of the
configuration file.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f0e7c2a2b5..0acdb364dd 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -50,13 +49,13 @@ int cmd_verify_tag(int argc,
 		flags |= GPG_VERIFY_OMIT_STATUS;
 	}
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	while (i < argc) {
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(the_repository, name, &oid)) {
+		if (repo_get_oid(repo, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
-- 
2.48.1

