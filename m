Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E31607A1
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267382; cv=none; b=CHaNhZsKuXzlB9v4J5SxgnshGdWugCc4YcSO0R+Czjk5UYTe1jZ5eVlfp9XrsDya5DLCMGNLKBrOVJtzgjvW5ZnLCypRNz8wRP3n48gSJK+PzVfMDgTCchJQKCwbd6Pjh+kOIWKFAqY0EsBPsNsG7laKA7JATX/oPUU44gjI9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267382; c=relaxed/simple;
	bh=h0/3IMI0bbEkpyqFWSvHc4Cfv9Wvdcji97rbqrIrD0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CP70a1mbCNgXQxuZgRtVBPBnkYVfMp3/GDPFiyFJJYGA7sZmR/nNedz+pEGRkRmtDQ94f6PNkTUTKYX1hvaAopcgEDD4nIqQXhN3v8sceDBYEamrxkCBaQHL26LhDwn+xSIXHBoGozUtZIVjNgmbFchPz3Ulu4bk9/NWjqlQXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZShV/bVa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZShV/bVa"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso52015a12.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724267378; x=1724872178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/V/WhbkEWsuFTEHK9w+b1kgD1nryQtleqgKyXetyNIA=;
        b=ZShV/bVaNzjOCakeQtoPR1goVcD4ws4gzjPUNv31TlVV6dOm8hUtb9tJnLOhTOtvqd
         hDORmRupO2H8EqFBTOjr3UReZQSjSB4f0BZoNBti3OaPBtma8TUzt1bNcoVifwCUGBqo
         GttcinRNzDMQATFLidys9JbEFeyX0idMUBPpoMbh31ZGgjYf5VJwtFGFHTae/2sw4XCP
         Cn9DmURsuNnPFfFtQE6j8O4fr197Q0oEoBBos4ptqwgHg8igCzBBbA7ikDITkJJYIZ2f
         z+d5oE6TFkpmG1ycYuNT3V07Cttk4kuPTXT09VzqdW609MxLvcp7iWyvM0pp+OvqCnZ4
         wqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267378; x=1724872178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V/WhbkEWsuFTEHK9w+b1kgD1nryQtleqgKyXetyNIA=;
        b=FDWQVPRRvCvRPFnoclv5tkyN6sZnvxygt2ri+bLEmlfye3U9tutpHiMnACMFNx+9Vx
         0M9q4K8pf91Zj5B9iiciHssL8BfJr7YG2fB8PKLsnw+7Vyw+6gXgzsXq3slZshzB7gDj
         CXqwGLCSGrd1A61At9jojJmnXRCI3CcGEgJtyn8g5qvOQ4cwxpqlTI+cBH+/yPnSSvTN
         +2BjCmJ8y91106oVD23S6pbnBGCShIyUvJv6/9jDbLaRJlmQivr5jqe8eOjytm++HIDt
         PUbv7IXbOIEl7fudm2uGkDBi39u3/XhgZytBeFwJhQpbRX3RzdERYZ72n5zrHtk4nvo1
         OM/g==
X-Gm-Message-State: AOJu0YyKpz6UM6OkH8uIuVU0yEHyIQPE1KPfu3HrEhopgSYrVmPoSZTR
	d127NjTRL7502qSJMhWkfwLqtv1d9wg6qnfD74rIbesM5yQTQ9FD57rYhZ1H
X-Google-Smtp-Source: AGHT+IHz7ZepGPfJS3rs/ORlWYr2bYTja8giuPoi6MrD8BOYGsi4236FI12oBz6yX7UzCuvgR7/b0g==
X-Received: by 2002:a05:6402:2186:b0:5a0:e61c:edfd with SMTP id 4fb4d7f45d1cf-5bf1f0dd1a5mr2034393a12.14.1724267377985;
        Wed, 21 Aug 2024 12:09:37 -0700 (PDT)
Received: from localhost.localdomain (d171-197.icpnet.pl. [109.173.171.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bf1aba180bsm1703649a12.7.2024.08.21.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:09:37 -0700 (PDT)
From: Piotr Siupa <piotrsiupa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Piotr Siupa <piotrsiupa@gmail.com>
Subject: [PATCH] builtin/stash: test push with new file added and removed
Date: Wed, 21 Aug 2024 21:09:21 +0200
Message-Id: <20240821190921.18772-1-piotrsiupa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the scenario when a new file is added to index, then it is deleted
from the workspace, and then a stash is created, the information about
the deletion is lost.
The resulting stash contains the file but not the information that it
was deleted. The file is also back in the workspace after the push.

This commit adds a test for such scenario (as a known breakage).

Signed-off-by: Piotr Siupa <piotrsiupa@gmail.com>
---
 t/t3903-stash.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a7f71f8126..84f0309b3d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -469,6 +469,37 @@ test_expect_success 'stash rm and ignore (stage .gitignore)' '
 	test file = "$(cat .gitignore)"
 '
 
+test_expect_failure 'stash add and rm' '
+	test_when_finished "rm -rf add_and_rm" &&
+	git init add_and_rm &&
+	(
+		cd add_and_rm &&
+		git commit --allow-empty --message init &&
+
+		# create a stash with "file" ONLY in the index
+		echo content >file &&
+		git add file &&
+		rm file &&
+		git stash &&
+		# no reason for the file to reappear but is will not hurt to check
+		test_path_is_missing file &&
+
+		# apply the stash without "--index"
+		# it should behave as if "file" was not in the stash
+		git stash apply &&
+		test_path_is_missing file &&
+		test_must_fail git restore file &&
+
+		# apply the stash with "--index"
+		# it should restore "file" in index but not in workspace
+		git stash apply --index &&
+		test_path_is_missing file &&
+		git restore file &&
+		echo content >expect &&
+		test_cmp expect file
+	)
+'
+
 test_expect_success SYMLINKS 'stash file to symlink' '
 	git reset --hard &&
 	rm file &&
-- 
2.34.1

