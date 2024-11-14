Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FE18BBAA
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604549; cv=none; b=YHZgMdGDc2K0ogAmRbIqQpwQKkJVFNsI+NUXDK1RW9apuQgfXicT7JidDH8/OeZjGw46S8DpGklddmKuN9tmD3SbAzpYb2zGYdG+y4eH+cuPj8pPVm5qk1ZRADksynA3UEJXGJLNjE+BwBWzXU1c+s0S6SVJbA3BxMUf2u4G/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604549; c=relaxed/simple;
	bh=FZjwDu08zm+9CKRB9Dc8mPew6bZVs7ulVMC9QOIwS5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkQzcZy7s3CWUr4nly143MR2BJgs6j+TArTEEzFFAfUtK++Ziubxy3xZGeNZQO2mdZn7abd+H+G+wwdwHrGtGMef8eNsskNXr7zuYImbTQKB5emtTmAP4t3wPZxmIflBxXf5gj/Hs2Ld2qhDCzilk+tfxqjjqnAyMmhRbRaTbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0e1OsOn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0e1OsOn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7240fa50694so730020b3a.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604547; x=1732209347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aNzWd1AvmTLQYY5qCoq+lfm76BLl9JNWmsfPgACtCM=;
        b=A0e1OsOnmEkpbCC5/eq4ie5zxcbzDbXCYoJrYsfoqPBUF1/FZUN2f0zzLvTX3B3JVX
         dY/4iv47+fuaTnKMZMtsRo0jspiuDp0aQ1+wJaTiRSBPoD3SR3/ok72tpeFBzN/OIyOd
         H3gyHlxQhAgHRzt1PiiYncl3m8ymLra7MK6sH8SOz66PqVOKMi4Lf5YJYjTGV8VcvcqO
         lfukM9E6VTPVVelgeo5aty65iVQ1diGCJcVRe2qW40SPCBzGLelbPpZtuiW28FfmjvhC
         yAHH0jRkbnN9hDIx6OvFC4k/A5LLCGXqOg8JQfjQPcj0eZOthSyZwOU/snFUYmpaW9h0
         Vm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604547; x=1732209347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aNzWd1AvmTLQYY5qCoq+lfm76BLl9JNWmsfPgACtCM=;
        b=csdrKQj4090UmwgAIMgGex2h4hyiPGnglG8rFmPYMSjRKGm81NPRLm6Bc20QmG5g7e
         Zer9q2ghyO6UE7h/yYYzEs+ZrOo0XSUb1/rW1VmlV6eNEW4gmzlONsID6e5BTnKBbVIF
         WuU2j7bbLm4g/GDcRRo3wQ5SmC2BI0usc8AfYPm7Oc3GOvENVxiY8QzAEf3SyPr1c2ll
         D/N9ZbGPQXlzM1lnACc7YbqurPGi2UQbSNFAxLOXnWYVejFwjYsLfWh7XsQ2vWE7PAD+
         NVZoNqOH2QaewsoQYZNQ6MZlfAre734/k4ytViNVyzeldXk4f9zOpdC5d1qWl83s6G21
         TGJQ==
X-Gm-Message-State: AOJu0YyafMsVVIeu/y35GHeOaLJyp+AWsCWYVpaYX3pUx6OjBrG0BxPc
	cQirjArUbJKfYocJMpEcXFlVU31K1PXYUBM47wEyKDI97F7gt2vHUa5AUA==
X-Google-Smtp-Source: AGHT+IEVWPc14pEPPF6kHgZO7ZtXgWdSKHJi/2/jy67c+Du3kj5IUutWQAKjTcKXUC7DS7qRikR5LQ==
X-Received: by 2002:a05:6a00:ac1:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-72457972cefmr10102966b3a.3.1731604547223;
        Thu, 14 Nov 2024 09:15:47 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:46 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 4/6] t5543: atomic push reports exit code failure
Date: Fri, 15 Nov 2024 01:15:35 +0800
Message-Id: <8094a3a2cdca3d3b01c8c82d83054207d9101fe0.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Steinhardt <ps@pks.im>

Add new test cases in t5543 to avoid ignoring the exit code of
git-receive-pack(1) during atomic push with "--porcelain" flag.

We'd typically notice this case because the refs would have their error
message set. But there is an edge case when pushing refs succeeds, but
git-receive-pack(1) exits with a non-zero exit code at a later point in
time due to another error. An atomic git-push(1) would ignore that error
code, and consequently it would return successfully and not print any
error message at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5543-atomic-push.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 479d103469..a40afb949b 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -281,4 +281,34 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'atomic push reports exit code failure' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict 2>err &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 * [new branch]      HEAD -> no-conflict
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
+test_expect_failure 'atomic push reports exit code failure with porcelain' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic --porcelain \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict-porcelain 2>err &&
+	cat >expect <<-EOF &&
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.47.0.rc1.21.g81e7bd6151

