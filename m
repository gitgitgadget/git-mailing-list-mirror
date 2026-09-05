Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD984E80CD
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628418; cv=none; b=m5uNjQJdvUmd009uFapvUHceIHUpyh2fie+E6ZUf3c6cTxxBEFnSMs3BJmBeP/FJmHIMD+SA6lmQeka4wdC3u16/hiwYIqxQOkSJkWM9l1gvdgADTQigSeHuFSjFJByUsjJKV02kZkbzk+E9dFoJIbKQIIqUI6j0Ao9L0498BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628418; c=relaxed/simple;
	bh=KFhBEBBBY9D25i7QTK9Rm1np8Scy7S5p7GIuIMih2fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4YIhAYYBaylLxk22qIsTmOZqGJFR2PgwW0YCx+kryqwloNsc3LEsEy6+gjYIOYT/FFbGrGKGQ66tiYkb2hVfB5zQv7lbIlZd2kLvkywlhS5DzMA6lkIx0uw7HByS/edxIkJJGzhf3rvHU8Hu8GGyv9AU4NC2TS9U3t/awl33cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=lTsQbKs4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="lTsQbKs4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso21734325e9.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628415; x=1789233215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xt03ggldp8V67krdGyZ8WWLJbhRmmE7T9s3AvA9g1sc=;
        b=lTsQbKs40JQG8bPU0oyAJbUJxE95Czmb01G+kZK1kxJSQ0jWjgvdNeT2W8FWSnbBIp
         658gpPDOdYf+A4HAtpm0psBxjSsoPtg+EeGsHAC+X1g1CDaA7LamhADI9+NCWrqSH6Ka
         3r1YihO1XJgMA4qbwORaKCnUr5B1jBx8jO8OGmxy0MQobs2B1xzpohA6sCk5qKc9q0Fc
         NEnPyJFV0NmYCHFRPTDKKFIysEJtLj0GtLmgwrgsJYem7E8Sq7inFGE6Mz+68mmloROY
         0bDKiuTC1A1h9B9QCdjYN0O6ZRfFkAKC+W3bzseE1ILF+ZzKiYHSKdfk4SDungxkFb2R
         GNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628415; x=1789233215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xt03ggldp8V67krdGyZ8WWLJbhRmmE7T9s3AvA9g1sc=;
        b=WHckd2C2mriyKQPIjJxJDcC6VaYcG71WJPuMDJJu2FeecqocZtR3e8TszWQmaedeTi
         enSDVUD4mp/4BRMpckwD7MrzfT7MH0SZY2tjANcPX30qtcKSlhGABzWGNFnl4NevgqkW
         t9Gsp3EH1j/OgARkAeQQvXdHRmVkSdCQip7woYkjfibINIjM4SImvRTcx150m9POl4h9
         454RqUqG3mHOvdUWrOe6KKHdOP1nVaJeMmsIoG+XtvI4Fo1q1XQ49n/07AD5YBZ0wqjG
         q6PuvpbkoqIb3DoWdIOxiCKrzFUWSpSeYmaSSBxlPfZrW7cBRm2eE5hgDnzCB2wrBAvK
         eo/g==
X-Gm-Message-State: AFuF++mH/5jTzudLtJl7pC3GDzxWB2pU8FCQ7eRThWtWm2emIzJVsFoi
	NmmhntuFkXgZ/88KedCt2k/NHnW7hrUhg6wG3YsVqGwppJs5FBN+90PQoeXjIuz3NzhmRo/jU2h
	pAyNAd4g6rabx
X-Gm-Gg: AYBFou3MEtqy/b+bxlO7XiGhd9XrkbCnMrP1KdZqRDA+fUQ1Q4qBVKVhYriWVyTCWFl
	XyPERDI4PTDh1Um9GZjKqV6GAzcnRggIxZu019l8I8dL6x7KBJWjcufYy4/+AGZTHp0D1M6sTA2
	e4XSfwB/BE3jI0Jt5CuwQQjVKBOnHR1v1QzmXSGvlw/FY5jvfALa7PpN43pXt/xSW5YUqyVyLXR
	6nYNfxYS0TkHB1A1vigVVfJFQd63ybojqN1lgIbf00a7bd8RiFDablclwNWXod4+WhELmbWCq/b
	R8TsBkLBmnoVRHFn4n1RdIYiMjMMyj9SEld4ncr8LjxCG5niq6BWJTqF7dfnxTzZfRSjHnPoBv7
	zFtrxtrablJXLQekeBHVrpnzYHjUt6tk3CSj6b3uLaI95WZP0y4hfi21TwyJNb/W9RMf8DSrLNX
	4c+AjrUFK9mo5lK1oQAgpE6kGNihq+MjnKBoFA3CgjXuK8hKNad72lq1YO5N+mllHSnJYd
X-Received: by 2002:a05:600c:4693:b0:49d:577:532f with SMTP id 5b1f17b1804b1-49d05775424mr72389425e9.15.1788628415427;
        Sat, 05 Sep 2026 10:13:35 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm252763335e9.4.2026.09.05.10.13.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:35 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v3 1/2] t3507: check no CHERRY_PICK_HEAD after conflicting --no-commit
Date: Sat,  5 Sep 2026 20:13:31 +0300
Message-ID: <20260905171332.34670-2-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905171332.34670-1-f@lex.la>
References: <20260903125524.67889-1-f@lex.la>
 <20260905171332.34670-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether CHERRY_PICK_HEAD is written depends on the command, on whether
the merge started, and on --no-commit, all in one condition in
do_pick_commit().  The suite checks the clean --no-commit pick; nothing
checks the conflicting one.

The test that already runs a conflicting --no-commit pick compares the
advice the command prints, which is what tells us it stopped on a
conflict.  Assert the ref is missing there too.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 t/t3507-cherry-pick-conflict.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 44596cb1e8..aa004d929b 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -79,7 +79,8 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
 	EOF
 	test_must_fail git cherry-pick --no-commit picked 2>actual &&
 
-	test_cmp expected actual
+	test_cmp expected actual &&
+	test_ref_missing CHERRY_PICK_HEAD
 "
 
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
-- 
2.55.0

