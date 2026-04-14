Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0742F8BF0
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176335; cv=none; b=XHEEmu7Evjex6VLfeIAOe5RNEIF0YIeOqnsHjkJHYqdEx4DAtFWrPiG60mm9naf/eb0hx9KGnfhCclJNDtTf5nwwX4eQ9NWe2ydY+CUjfG6sagcrB2k0ECQLy2c6H2VmdEqEYJl+ynQxTf2OCDpQkU2w5nM5mlPEGjL7UctktQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176335; c=relaxed/simple;
	bh=7mLsic5FxbcROp0/aCm3pXzdD0E2Eq+/ap0KNW6HxNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZps5GMxCOSshSBBhENINk0zfRgkCjdwjGjgnAL6pQ0GX3+2BGofcp87F6EpDzDFxDuxK5gLYc99ujjOE3wD1OCS6/qJVE6G2/1/zStdETRC6PBVBNdXepFa0RNDHX5cETZucqU62hl7Jtqq+nQHoS+GdHKQsrRUUJKI9dz6GA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLOHGX3S; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLOHGX3S"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f206f2b54so1251146b3a.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176334; x=1776781134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd1SKvyKXs2qawPHom8NRxY1OfayobbW7p1TVZnqfpw=;
        b=BLOHGX3SrJ4J1YFGKifpRnoeL+iW63Dd3SqttIKzzl/ntR0oDQ/PXxE97mQInup+sp
         e93VAqrjv4ixlzVRLRW2mR04+ecrj9cXSIOhdysnmjZO66PZ/m+KLMDJlGQDB9rdS7l6
         LSXaHdn7SzFd+GJEn7kgbbAwPwmCaJshVuqvtiIoeTVBaSGO8lMOWIt8ZSY+X7G5gk/N
         e3Y/RLjFCIvEVanKlZyZGGDDiYdyKc0fmSNnWygx3w4frgmHBNJJstvMUKLljYb7awvM
         2EHve6BhP5Zca8pEX1WSG2+zCnSpov9cO4aAGW/3Ne2/HTp6/e2jpjakZAoJb6n73Z67
         92zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176334; x=1776781134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cd1SKvyKXs2qawPHom8NRxY1OfayobbW7p1TVZnqfpw=;
        b=jT6HlFaOVZT+kaTdVw6RSJVOauVZuJ9ZHx6LMCaqJWHQavPyTMuddWZBZKvJgOJ3O0
         ViOBmnmiU6azllM4hBJ0mqQgQOqwrCIR1IEs9uKidunDvjYCda2x6HBZdjbS9Q9tQ5bD
         BzA5JLIRwuHzR8ngNDNPH+n8fQvBgfZ9JI3iN9kM0TrRsCBwd/SOElR2OdW7Qdu9j22b
         rLJ2dRAVeBY3C23ShCYGWbcvU+Icdpq5HSF9sGPk2saUFZ99GSOqxmev35tALloQohyF
         HBV+jtClNDwfWqdHFfcsCPOYorwNWaHvARI2esUOp+gA3BzXnRmxQIOtBbf42/B6aG5z
         +FFQ==
X-Gm-Message-State: AOJu0YyCSl2XpD2cMr7Jp33rXVJE6pzwKocg81Nxt63y0vtIGvMbLcIo
	S2vEBdMhzJFYfoFE4YDFznEXeNoX0BqJNFvdHcxmvxcqY/nL11Jqc9EVQp3uBg==
X-Gm-Gg: AeBDiesTEk2OK7j4YZTj+Pho37cEeh0v+gb2JtXUF0uNp3QO/pMbGd9VFLYgFfDZ4J/
	0qDG7j8hIaMoVp3+CHw9ERLLICunAYav2dKccXuh1H+HZsv9LkxEFmZpmylqpTpZTOINM1aCNob
	pMEI9Q2LrZVy2uOc/8U99u+wp1XdTkg8dunI0dMowxjHR5cMj4tS5fD0iy7P+3qPe3hPRtbnrPq
	5zyeey/gdCR3UUqKFilh1EwbYsqv2HUPy8zJGEy6OnT6CkByjxAaLSuE24OeAvjXGjsDndSN/TS
	OdQtrsrkLD0NI4182i16zEksV/CbnH4h40w/m68+IF7FjDr8nC3/vNyX00La91w2kvyU8QBo3Ge
	htZ+bvn4H62padxEXIxGBdxSEmaDdiKAui4GCFeXx30RawtxgfMGXMvsr9dOf5eC9lgggs+qgK7
	ECSAZPtDC5fSvq+O1xJHGQFgAsYJ5pKt5JkAMCKUi4Sa16+DAPiQ0i3oac/w92nPa/Uz/iY23js
	OgsQ2xSRlU+s3kowYgdzatYYXF3G8AE7+qOJa1iRAtGFdEbhI2Lyvn2Hl8OmdeFzmiDbwAfS6sV
X-Received: by 2002:a05:6a00:9165:b0:82f:2d48:f8ff with SMTP id d2e1a72fcca58-82f2d4916b4mr9075302b3a.16.1776176333530;
        Tue, 14 Apr 2026 07:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:79f3:3c56:74cd:64f0:3838:afaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm15145048b3a.7.2026.04.14.07.18.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 07:18:53 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	abdobngad@gmail.com,
	ps@pks.im,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 2/3] t7004: dynamically grab expected state in tests
Date: Tue, 14 Apr 2026 19:48:27 +0530
Message-ID: <20260414141828.27576-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests for 'Multiple -l or --list options' and 'trying to delete
tags without params', hardcodes that exactly one or two specific tags
('myhead', 'mytag') exist in the repository.

If other tests are added, modified, or removed earlier in the script,
this expected global state will change, resulting in these tests to fail
for completely unrelated reasons.

Instead of hardcoding the expected tags, dynamically grab the state
of the repository before running the commands under test ('git tag -l'
and 'git tag -d'), and verify that the output matches or remains
unchanged afterward. This keeps the tests independent from the script's
overall state.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6ca5c75b57..4fdd47cd21 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -145,9 +145,7 @@ test_expect_success 'listing all tags if one exists should succeed' '
 '
 
 test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
-	cat >expect <<-\EOF &&
-	mytag
-	EOF
+	git tag -l >expect &&
 	git tag -l -l >actual &&
 	test_cmp expect actual &&
 	git tag --list --list >actual &&
@@ -223,12 +221,7 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 '
 
 test_expect_success 'trying to delete tags without params should succeed and do nothing' '
-	cat >expect <<-\EOF &&
-	myhead
-	mytag
-	EOF
-	git tag -l >actual &&
-	test_cmp expect actual &&
+	git tag -l >expect &&
 	git tag -d &&
 	git tag -l >actual &&
 	test_cmp expect actual
-- 
2.51.2

