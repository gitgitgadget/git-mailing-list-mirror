Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15E3890F3
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679507; cv=none; b=tFaL4GPH5vbYb3oc9591SSoReAr3A2nV6oKMn5ysvrLkuLxfsdb+Ts1dQCu19WPqPB9inH2Ds7XqKP+sU/jWZHJxkN1K8Avn/n2kh4TJWy/arvVWR42EDdYgufgELi2lCDAFT8z3u6s5N2lbSXDpV5zUZ8ticjmSJH3GkCWNs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679507; c=relaxed/simple;
	bh=+iFDByLGLLsJbfmr1zmHpTsSDfIQfSSoCCEcLw+E+08=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FtUmWCMK0gHf+U3MQTaGZvuETBlP7M3QVoABb0rZUEkFyvmaSYTmxKGqjC52AfY8VWoVjiG2fMS/jrIbNZRNKtIkwpKgLA5xL220P1NB+JYuH31ch8tFDP5PRWGvWVh6FywDMRkIZrQwrE0u0ILSa4FNumAyi/HIt6ltvbZFgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osGRjk7/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osGRjk7/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbee846deecso3100613a12.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679504; x=1789284304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UxBYhWPE7XUMa2aATbQBIw7sy7f6dIohFp5/i5rv+Qc=;
        b=osGRjk7/RzCaELQPUFzhd6ZSevAg0SCjRrYEErZ2nBtb7VcUNm7Xr0QiEt2mjyzcC3
         iuWOPtCJ0JkEVZM4mXKkyjUyMTaBsJzubbINZjFizd2EKtg0cIZOJXpKRTxPU3SOrgGA
         c54zAcJZav3H6AVjpqdBjbrwmvZYcsJba0zmbVlb0Bkk2UwMq1Z1v/Il4jGZnx0s2odv
         uyAu0GdceBZE5LlUeGmdBk5qJ/EbHN5nVB8YYjLaAOuMaMQ0a+Gkz6qT8A+C8KNPk3lN
         9nGr8lqWzpTMpLLfO/2Q/wV/swnfYtor9aQgWNBmPwiC8ZdR9XH8tX8reBghk+uVUvLs
         e55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679504; x=1789284304;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxBYhWPE7XUMa2aATbQBIw7sy7f6dIohFp5/i5rv+Qc=;
        b=WFtQZZ3LTWA1oMiDa0HNAXKAlnKC/a4JNeoZbIQe1w+2VJHTkQYUMKW/CCz314odGj
         IRy4Kdcz5fm+ViaUQz/wKAVWXqAtuxuDTK3LCkBVUqFJ/8cfo1fTxznc76/VcN/3D21c
         CgaOuLN27RanrIqa9CGSqFFv+ySYIyd4uU4gFUX6yDT8FfpSj9sLCd6WqDTYDznic4nr
         tG6JfmFCNXpbGySRMgGcj2rObWcdU0/PxEW6EMHgaRVnaU1tVaeQR+m3BJHH9ryJD5MA
         HRlHDnftU1AssevlimjtD4gPhD9Mss5dfKbLujzNx7lXZfF4Ok8nJHMVioHnJfQ26B9m
         0C3g==
X-Gm-Message-State: AFuF++nOqkTdCXqxzpm2oPymfaflhCMak/cDrWA465mU8Fv6WA2PfWb1
	2YgAt6tZ6XVneHjS/oog2oNF2rCWoPMLAOrrEFcFl7FTpY5bcoglxpMwPbGa6g==
X-Gm-Gg: AYBFou1gWE7OB5ijit9vWXCXHLOE4hgjRngvizLOvI8gvoff/NSFtxH1DqUEZ8p24Lt
	EMAImPwnSkdBUe8nvfMzRxWa64CJlGAYLwo0jjIw6pn+pngrm6SJX4iwIkhUBrVEbDNaFEw2vpa
	g0OSdjdxnCoSzzf2DDkUE6Tagxkr6YY9OvqJNJzZLFnDyAuIei+pgu99i/4Jwd57GSaeMmrTUJV
	Mh4y4q0rwg1DC8rP9TSpbJUtsFjmlBkgi605wglLVWNkJteOMwC0UiqAp4POQdrUZnkpcaeZBhe
	yEayYMkpgsTiLbtQ+xq8EmkFI7IONMDNMiZo0okRODLwfN44FNKi0tByxwVFpaQb8KUe98s0cYG
	ANVQX495Vat/iJClmke1GeG8iM/cK23gUGwb1vAJpUDO2vS22EDDVeZbU3g/GKGdomWQrW3MsRr
	UEkXHSYXP39JRS7DwcVo+25pP19nBfvgu/bshSz1CAwDZ1fsZV9/w53l3Kz6y678o=
X-Received: by 2002:a05:6a20:244a:b0:3da:1fc0:fb07 with SMTP id adf61e73a8af0-3da39d18791mr23961997637.6.1788679503641;
        Sun, 06 Sep 2026 00:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432423f99fsm17055464c88.1.2026.09.06.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:03 -0700 (PDT)
Message-Id: <6056689be039696d03dc67b8365300449b08676d.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:55 +0000
Subject: [PATCH v3 1/6] unpack-objects: distinguish missing objects from type
 mismatches
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

With receive.fsckObjects enabled, an incomplete pushed pack reports
"object of unexpected type" when the expected object is simply absent.
That suggests corruption rather than identifying the missing object.

Use the same diagnostics as index-pack: report "did not receive expected
object" when lookup fails, and reserve the type-mismatch message for an
object that exists with the wrong type.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/unpack-objects.c        | 9 +++++++--
 t/t5504-fetch-receive-strict.sh | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 351948724a..ceefeb5a49 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -233,8 +233,13 @@ static int check_object(struct object *obj, enum object_type type,
 	if (!(obj->flags & FLAG_OPEN)) {
 		size_t size;
 		int type = odb_read_object_info(the_repository->objects, &obj->oid, &size);
-		if (type != obj->type || type <= 0)
-			die("object of unexpected type");
+		if (type <= 0)
+			die(_("did not receive expected object %s"),
+			    oid_to_hex(&obj->oid));
+		if (type != obj->type)
+			die(_("object %s: expected type %s, found %s"),
+			    oid_to_hex(&obj->oid),
+			    type_name(obj->type), type_name(type));
 		obj->flags |= FLAG_WRITTEN;
 		return 0;
 	}
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 75b2b87999..0848e2da4a 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -105,8 +105,11 @@ test_expect_success 'push with receive.fsckobjects' '
 	To dst
 	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
 	EOF
-	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
-	test_cmp exp act
+	test_must_fail git push --porcelain dst main:refs/heads/test >act 2>err &&
+	test_cmp exp act &&
+	missing_oid=$(sed -e s%/%% S) &&
+	test_grep "did not receive expected object $missing_oid" err &&
+	test_grep ! "object of unexpected type" err
 '
 
 test_expect_success 'push with transfer.fsckobjects' '
-- 
gitgitgadget

