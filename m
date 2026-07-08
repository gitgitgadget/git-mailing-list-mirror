Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507473B9D97
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484072; cv=none; b=PaK2QTpNf2MENCHBCwx3G1MsiIVpFqyWlmfSFiP+KpwWzdbG5/9Imzhg7CO5OV23VOdEcJgX7gbmSy4MBKHKusogrKPkdrgfU57nxXNj4UnVHjye0Ad94uIqlaihJRbni4Fxoj/btLR6RKlKkeDgNf2NUDdwiP0Csv/BvZv3tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484072; c=relaxed/simple;
	bh=vMUHgGr2pTME2XTSEGDSDrpgc6g5k9PzEwT/eWh8gxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUw0QhCiFtxURi8/MYIirtchIZhT8o5ypjuzmKtz6wf2ow9/eo5yhFuT0enxh02uOmdn1p98daBhAB2LGfdqpT+exhNDPzNhjm2Yp8AKiKLswPluEtxKuETnu9pzYwBNyRKg/ZaTtFrg9RzOYbOXIj/JQYYi9sYpl1S9omJM0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjV5uLnn; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjV5uLnn"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb9b427da2so618788a34.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484070; x=1784088870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=ZjV5uLnnCq3Wuong4c6VhuaUdfp9ZPRSA1U9G64fdToMwHnBV+wjsq9JKx4HW9Adin
         QZE6VSW7IRMCtW/vNe70HkfrrU7Pvu4dH1ByX9AF2YRmSJCQ8iIhb/L8TQsJrbHL4jpf
         Ye5EQ1b5wf25zbsUwZ2LoHhK1NSElQfh5ltUSbBD9d2xp2dDlO3Y5cToQqp+1bV3d0K8
         qMI4aSvo9eNP0zGykVYxv5Izvt/xn8E67DyIohvsCN9saJ8iBwc6JgqXYRr0TMXEiAjB
         HmOMsVMbfWOxsqG7eGXaoR9rZXrXPcVIfQdMV80eirgsNSJ2+uHRlVRfbnrR4lFSqG/A
         eTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484070; x=1784088870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=LWUglEhfUNkMMv8b7YRnFZwgbSQxAVD6HWFSLvld9wbk476r/9oYNE/KoTHVtol3aA
         kdyMMxLgTc2dVWxgSnd3Vdk8QfKRLvASKiVcAHbOjdJUkNH8n18JTXvj14uepsQ39G3w
         NAAZw8fu07l4p1gwCSnZFQ9zKnbMcFKKm1T3KNtix6tdacxJllClJJOiQM/1sseFEEro
         RCJGBlDe/YsHrOlMaGcI1oRrcKqcVO2nnT7mWacLeWNynHLNziuoULXkMt2z+PcQ2nz8
         HvZhR1FvTscX02Ec8aWuogbJQ2GVElewwML60wJWO3AAlMp3xhZHkfq4nm6erRDFz7jq
         JdMQ==
X-Gm-Message-State: AOJu0YyBNaf6/uRIx2F+7XM5/sQm2gd+hT2VOne5uEW8PUD3GDCjFhbS
	nyWX14+4S6gwrqr9D4RpO+j6SIKla2A4lwi0b7jDgh8oLvJTyolxxVpDr6SzOw==
X-Gm-Gg: AfdE7cnTxmz6voqheMcb0tUuqkk58LNx9co1bhakysz8MX2bKluH9H84eSPXHkujYh8
	jV6JuEC88Qhppn8fzGLQZn0jWgbIbzYME1DZ5OuJX+ufSY24o9c9KyvrRyQ/cz8OznZFuriZL3a
	Ijdum5+ZTrJa4ejpoN5TcO4rqf8y7BvVTQPOEzWbMrJGFR8F8qOOGYV/BcD5sJoBXDxfcROo5f2
	ibkb47634z395kqyyMQXHMiJanViqhN9gNQXlvLT9GEUNX1v76O7LYzXEw3Cr+Ul8VEeU85TpEc
	EYL1xEELG9IGprOU6M6stz4O+NYQxJo9M4QZ38QgSuPVqmLrnEqbr7aQWh1ALzZY11gY2KUfTCr
	QNKhhKOziC5cgRKitMATHpfyid+EpeE62Ra1IXQ6WUzwCbGBeJrdKDD/BR9l5QusEtil5zUWY5I
	AhVEYDzamKv+nee3oxsM+u
X-Received: by 2002:a05:6808:3209:b0:49a:8f0d:cd9d with SMTP id 5614622812f47-4a1ee780d18mr753809b6e.3.1783484070378;
        Tue, 07 Jul 2026 21:14:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/11] builtin/receive-pack: drop redundant tmpdir env
Date: Tue,  7 Jul 2026 23:14:11 -0500
Message-ID: <20260708041412.1157499-11-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing the connectivity checks for a shallow ref in
`update_shallow_ref()`, the child process environment variables are
populated via `tmp_objdir_env()`. This is unnecessary though as
`update_shallow_ref()` is only reached after `tmp_objdir_migrate()` has
been performed which means there is no longer a temporary directory that
needs to be shared with child processes.

Drop the call to `tmp_objdir_env()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..50bc05c70c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1363,7 +1363,6 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			oid_array_append(&extra, &si->shallow->oid[i]);
 
-	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_shallow_file(the_repository, &shallow_lock);
-- 
2.55.0.122.gf85a7e6620

