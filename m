Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3D350846
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122729; cv=none; b=FpFGx/YpvGTRxqaV5mU95IUXUApWgCtej4MM8jyWMZwTjO3n88L4QYOM+4zYbkTBKbsIiqjtyxMExpaBgbZ6YeaMrAX84R0IZL23ZDaNpwxrah6WsVik2yCylNuyIF+KxdseG1smCxWCvQn8CGJ3UAQpIErFTRo9aQZG8J10S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122729; c=relaxed/simple;
	bh=fkPwafT6dwiDiEnzTY33FLictIl3PwrGLtt0ztfc2FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxqvkHOKlgvk9IacUdhYwII+u+rDI2IdwLvmPHp+pD27qwpdYr/B+lVYQkxNcAJ9TzAT5GnRiHb7gPKbNdEhN9xhm2lk8hgv/G/5gMMW4xxejhsMBD7SQM3eJg5EJcsuQXzQfPiH5M258Xn2uIQoKLJB6AEri1YkIA8kQ4WcZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH2/iNRt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH2/iNRt"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62f4273a404so2146323a12.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122724; x=1758727524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJBxv3vh+uICdlgFViKgBbvCuWMqjhiaYcM8rK6XUjc=;
        b=YH2/iNRtLYlOwUMiK3J6eaNNZqNjVMcBucl6RMCqKQpnljJJa1DqPM+ufWkqo7ASuy
         OWSsp1+KFa8X9dbD4X2UPjZ69sgEamH+dFbnSD4WcUXo2H5ibhZSOXK8RBSZpgr2ss5y
         RvcpeccgsEZGHeMA98NPyzAb9gyZDG7/8+RsKt5QlCrpuqKyNeSy3YiXfeZaK3JKCMKl
         4qcOP8eEHSsZnOrBh2E2r10t2Q0IjlVc9+uQ7aPSrAP/94LUyqwEJjMMXMgA9suDQyrg
         kwEg63WqBuV1CphwrKnYK14bQFrU3QQenmg+fOMyCgVnJ1+W8RgJliOW5jP///v8dn4t
         Ldnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122724; x=1758727524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJBxv3vh+uICdlgFViKgBbvCuWMqjhiaYcM8rK6XUjc=;
        b=FxPYnikloduEhUR6rK0kX9/YgozxzxeWrJ4tTr/6vajvZrHWYdtZghwSqYXza7TTa2
         86byMHWiVkAt0gHZPsnHShB0QEZV9LTZ6dppv6LjcBFzZzH694C707eiovTeQWmgp8lq
         wcmVFIDeSPK1Nd0QZpmU6CLzLQpuY/MAXaKSF+hHv7W+YBwMX+UIe9qiVXKd6R9b8TcL
         skxf8kuPNk48UXrXps3h4KMOjxH7J1EblRa4t6ll/PkdTOjR/82qE3oXlNQZ8uHp6Uzs
         46je6hmOm6UNzy/h6nfiJ7gneHHwWp34/KL3yPilu4PJ3ZanMoqGc+y3b6uLdlE4BkmW
         wjjQ==
X-Gm-Message-State: AOJu0YzSPiGJ0VHgXDP6qlQaPNcCFKUnuEsqbJHvOGcmQPHwLNj7dPnB
	uBV+Zi99h+X3aJazkssnBbDVBMFlgJx3u0AKoYRU4B7t/q81GuNTquoq
X-Gm-Gg: ASbGnctVh5adwK7Olzvm/k0OGxyrJxz65dtFpIbxV2WYtmJiqG07c0J1SSsxatGUxHB
	3BX1HRtUCVETSKeDmqk44EJ/sqDO+eHWNBWBYFBsFX+BWU3Tg/8Rhmuote5tnFesN62hYgO5tiS
	k3MoKDiZj3UlWqz9UH5A8mKtO4Rirt0BwtnFGUGYRTaq7gWFFHQkK4eIjFgFwf1EuEv3p91fywp
	JOJqI5O1FJN3LXE3Ujbu2K1BuGCgcYve/KGW39v+6UEs8BRrQAouZJuvRboxr+HazfKHuhsCUtz
	CZehIvjhRJ0Y6FSR/CzJzdYrGEWz3A+JxMDtPyCI2HPKTph678QPsmEgXsIH/Zf5WuKInweHiUu
	tm8KspHdo6ARl4rRc7Cfs13qOSjQeXEOYRPvE9VM=
X-Google-Smtp-Source: AGHT+IEXJI5fhaie02Sizhsm3PkaIrelfuHpEEDiNh6zVkemFeRHQtConp61BLkIO0zaTZTs5CQ/lw==
X-Received: by 2002:a17:907:ea8:b0:b0d:400:9182 with SMTP id a640c23a62f3a-b1bec29eb0bmr292233466b.22.1758122724088;
        Wed, 17 Sep 2025 08:25:24 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:bc15:cb75:326d:fed1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1410380566b.83.2025.09.17.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:25:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 17 Sep 2025 17:25:12 +0200
Subject: [PATCH v4 2/4] refs/files: use correct error type when lock exists
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-2-da3c74a08ed0@gmail.com>
References: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com, toon@iotcl.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fkPwafT6dwiDiEnzTY33FLictIl3PwrGLtt0ztfc2FQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjK0t/tO6e33/+iKA6WmxFJjf/bXvmZQbyvw
 jgpAGUHCQ7kPIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoytLfAAoJED7VnySO
 Rox/a74L/2NwzuG6psnllUgKCnch+mbjUZRucdhfRewA1CiVri8ECjhbLYfTZCOhorMUxBekSeG
 VtvB4aHcGcHNfD7F/HacLc78ooQISnjLnupJi92JK7MnqjFQrl5n6QBWAZeoorY8aZ/plavISdL
 4AA8TF/IeXYn0swxQoMRfEY2IxWtB15JxzVk0bRfaere8m8mzZRV2f4+jh2lUyMQalL+at5FxqT
 1DzKmBTc5TAcNzXTbOflzMT8Mf1Gw9jOF+zwmTL5QDDJxrfjLxA4xFSa2RKxS0E7KGu53QdRxN4
 rusngCo39owYwPYEToVXqkLZG9ku4k9W1ZC/zanSdTXTem6DU5NOPfiKyH1gWcLWC42ub4cUw/z
 /chOhjyQREyHPZEcW676wrHyTNyFQb/gzO9LwskiqjvZqgoAdj9aDVOTazATECrzMDZ7gFGJQSn
 eaL49Y0luYJAuNBI5LXmrEAdJfNS4iURUPmqzGEtQ1mfLJXHWkH5RjONi38PjwMkPBi+8GTy/Z5
 5Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When fetching references into a repository, if a lock for a particular
reference exists, then `lock_raw_ref()` throws:

    - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
    because the transaction contains conflicting references while being
    on a case-insensitive filesystem.

    - REF_TRANSACTION_ERROR_GENERIC: for all other errors.

The latter causes the entire set of batched updates to fail, even in
case sensitive filessystems.

Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
allows batched updates to reject the individual update which conflicts
with the existing file, while updating the rest of the references.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 21 ++++++++++++++++++---
 t/t5510-fetch.sh     | 26 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 01df32904b..d1af5d6bc7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -797,9 +797,24 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
-			if (myerr == EEXIST && ignore_case &&
-			    transaction_has_case_conflicting_update(transaction, update))
-				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+			if (myerr == EEXIST) {
+				if (ignore_case &&
+				    transaction_has_case_conflicting_update(transaction, update)) {
+					/*
+					 * In case-insensitive filesystems, ensure that conflicts within a
+					 * given transaction are handled. Pre-existing refs on a
+					 * case-insensitive system will be overridden without any issue.
+					 */
+					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+				} else {
+					/*
+					 * Pre-existing case-conflicting reference locks should also be
+					 * specially categorized to avoid failing all batched updates.
+					 */
+					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
+				}
+			}
+
 			goto error_return;
 		}
 	}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 57f60da81b..6f8db0ace4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1546,6 +1546,32 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 	)
 '
 
+test_expect_success REFFILES 'existing reference lock in repo' '
+	test_when_finished rm -rf base repo &&
+	(
+		git init --ref-format=reftable base &&
+		cd base &&
+		echo >file update &&
+		git add . &&
+		git commit -m "updated" &&
+		git branch -M main &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @ &&
+		cd .. &&
+
+		git init --ref-format=files --bare repo &&
+		cd repo &&
+		git remote add origin ../base &&
+		touch refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

