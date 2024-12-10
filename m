Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349F2153D7
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830602; cv=none; b=EhpylAv8Q70EnyOaa4qTeiVOWKfRzuIPJCvXvDx7fgURQzj3Hyzk7/qUCETa28o6HvvBMy/002DsKOq7en1Qh4/4ZYKsqvB1kn8jvwcRpvQWjkMbuJvO8D04nz7GC0JPF3qB3W2Me9x3f8amfBy3e/tv1E5JINYWqp8zgTaFPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830602; c=relaxed/simple;
	bh=12HyVJEPaZU7CJGSRJ+apTWgDxiijhUVgWTbYvHa/aE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnvmyjzANk0ZonG46IIGiZ0rsc/BfSmjMF5Fze8c3dFRXN4pQkzAZrx7aLvgmIeQ0iMb3CN7phwXD6BC4IpBSoGk52nengsGfepMcozNRN49LesRmsbujkRrvj/l12ePrQG/eINY7vZ2oU7PrWaYjiuJ53o94HdpkV48/83LRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gieHqF2w; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gieHqF2w"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725dbdf380aso2136449b3a.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830600; x=1734435400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXa6+0s6oflD6keUk9vHi1w4s5eMXdsBz3MNKHzZCJI=;
        b=gieHqF2wQmBNV/osd20ufPnHGF98y+dH++jTo/ieBtAjl51nmgl3gzuNXyrDYl/qHu
         X+WrCxdHYQI2TauL2xXxgAqE28DIWtLUiikW6KnsFnAXFOuqoVm1qNHlvpxOIWtD89qk
         YmI/Vb3cB0aWgI/EU5bv6B8YdY6diYx9gt9iUPCQrFbb35Tow4Hl3lBO9evIcaw81t3K
         PTUUSBO/qHV4apYQNAcucjTO2mFIjr4NlpYHWG0LB9S+P4UzrRU+FgllvXaLG+Znpy0i
         Kyg7vOUs29ESs0+9XLMoEyxLdCa8+qQESEfea7wTDV12KOrTCYQPLiPIeSBcLKIn4d2E
         Qi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830600; x=1734435400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXa6+0s6oflD6keUk9vHi1w4s5eMXdsBz3MNKHzZCJI=;
        b=Vk47qe9PERraOvXbQGBOe/+g6TBvl+sBtXNnBYZRs4SQ0BsHM4kFWC88+hIoncaIUv
         6vW8DYTPmjec513z7VDATdSkQcE4qWZmqeSieG+96C7booJBUG5rH/Lle8QRUFB5hPjW
         EQw49vCGg4JBuYhQgAUJNEDuq0rTQfJRkaAv2u7ZaWy33oWh/aRov1+ghTej8gLr92b4
         to5tMK37apP/+1XE9/hNAhIoXyOpebaZEmrpEem+ji1sGDsR3CsDtkI462G3wH6kUcyk
         x0XJiJVArxTL25npWJbDq7ZAUW59OeJAc1i/cjAibiBbi+tfqJOJ9LhFw4nbxHETMLj3
         PP6A==
X-Gm-Message-State: AOJu0YxG7psSC0LRB2Ia0MHdEx/4GV0Pqzo/dFcFPsAeldpJIjN+x929
	8SuSy9tPPVdxV9DCPINJZ7nbBuUPUQ5WV0OCIY5QiXRuwncpUDxLVNCkYA==
X-Gm-Gg: ASbGncsprV+0UpLCPImfKzLWCRzSV6ayDZTbNK+IqlLwHUt93kGYDpOW/xpLHklPQzB
	b6nSsGsBPHxc0SyDw9XAOLpXOI9eQ3KqO7Hl9CsddUskqM54f5EYrDYm4fyguwlRTcWzbQmVI0M
	WysXmxH/Tn8paN/8juRwiwvM3u25rBgwYg1GAE+gV1EIwfINPauZhlqXV50KNEAysRQaxny8lmQ
	jv1QtJKbKCyXSgTC3uARQHXkmusKpO36rZ+vAgA/2CamrSzX/sLQ3k2WJU/H0mHYnmT6PJsVod/
	L0JYMzX/7VIVSKh/sgWIevcrMcET9yHzFo1xPUgesrSOLA==
X-Google-Smtp-Source: AGHT+IGzGmGIqyzaewz1sFT1w6BEts2zpLTw1O+ubEgeloPJ+N3FiKg4fbBVcS++3iTcZ5gLPWsmog==
X-Received: by 2002:a05:6a21:6da5:b0:1e0:dc06:4f4d with SMTP id adf61e73a8af0-1e1b1b09c09mr5999301637.19.1733830600393;
        Tue, 10 Dec 2024 03:36:40 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:40 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] t5543: atomic push reports exit code failure
Date: Tue, 10 Dec 2024 19:36:27 +0800
Message-Id: <7c78dbeffb24fc84e5e6d5e01e77c58324bf60c9.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
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
index 04b47ad84a..32181b9afb 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -280,4 +280,34 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
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

