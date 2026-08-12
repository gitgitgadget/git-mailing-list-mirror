Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4F2E738A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516787; cv=none; b=XqHmIG54RKhti0FKBYoRATiVU2Lt6CH48hWqsy6AI0IxRDeXelqniZXS1JH9nXcz7f3hpeho6JOoLZf+k9taF4Ly44Uo6oYz3lNTsK8THUd0HS3VfiS4KkflMejrxZX0iFioqpxnhglUKyy6mnUlw5PBHvbZlr05PST/Xs1ikTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516787; c=relaxed/simple;
	bh=T0nzvorzUbEeNOfVNLGS3ZjTMTMVGFGFghmRoLIOOmc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JcAbavIbSN5skhBW9KPs/bQwIBfTfc0uK+m2Vd17ERJaL3zztns6vaBfo+Xczx4kpEqwnToq9Q59D9GxqF0RV2htLdBWtkA/JNGasOBiL2+ecVCZIlolN9QVIgN1J2DzP7ORmuQBzlkGnuk71jcmdOhuqwrXyZNvbzLbDjC7DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbhwnaR+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbhwnaR+"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8f29ec73064so2786626d6.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786516785; x=1787121585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jH6uEdJiM3y1OA8FYAJKwskeAFwPoZc2W1ed6kdr9+E=;
        b=LbhwnaR+Xc49U5q90w/yeOhp6buCHYL28p26MaTc0UB7+a9B9DjxF+K3bPHlxRLnyI
         vgZ8GibI7M78PKFdVpjVbgF7s1xOtfpcJec3lnNCudkRMh1u8NEBC8QQiMEuZLUQ1MTp
         q5Trf2s3LA01KJ/u6DSNes5OFwJowf1f7/wRsyHU1h/UWFSXRGPazd+ack5dmuwKEqqk
         cCa34Trw0CMjqsx2/33i2kWBtcpCKK6lS/ncXDnV0twRE+eGlEQBb7gJnIqt8vQNBWNA
         W6WnwCVdrRUhBHre3aWg+F2gc0jEtFds8q/p7lytteU1kZWR9Xc5MnjLsEQiT+YIygrC
         OmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516785; x=1787121585;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jH6uEdJiM3y1OA8FYAJKwskeAFwPoZc2W1ed6kdr9+E=;
        b=Xii5FVupvIuCvRL5Kf5YL3ZJMJ9IYpSlslqiDG1qEimIMtclBCKwcQRUqdgYZqa+l+
         us9BkJFYU/XUnVQqjCtJGsqlXFb+WcqsHjYOWb+ehu0zDHc6GcNlODPkujYcX4eFOB8s
         eMMlmWhD46L/c1qZQsKwrYQBagGRDIBkm4wXOZdn32pYIKaPkbhotVIZyC+LlSmQcPPj
         iq0xlDZb6+MWj28JPqnmrOxnOHxamwwshCNstiE8sOh255RJsSp0Et6XLwClPMMR7103
         JiWJIQYVN5Le8h8H1CUuAtAmEoJ1kv3EDu4/hCBg1DXLEUA/jfhW7clLBr7I4LN1B52r
         CFew==
X-Gm-Message-State: AOJu0Yw9Wxr9jAdDnB3HwPSvoXPK/5RQqAcl+T3+Es2pNjizWN7lLkQ5
	gp6QSdWiNasoXncj1ee+2MZriXoa4yhYhkKeUJl/PlM4aGVbs48redHnA/80ow==
X-Gm-Gg: AR+sD102o9dhMl2LQM2jAtvernsStd2vKj9pGOrlsRiqH08MA34nmD2aW+skpZ83X0Q
	KUXnR+S4nD4FiCfYJsyvKNF+HflBHZbvZA/XtxKsK0uJ0/8c7o4ALqo0jRri6cODbwQvYwdAS+D
	9A+DfPawR0KaFO6i19qC6KJaAwn10yPltL0T4hdwfwRUcZeHr2GSwd72TvV3Bs39VIn/eoo1qYR
	K+1m7JBsaPK/iELnXtpyfVcaGA3igYlkqx91FxcDyJPt9zkaw14zBR90ZRdwmhjz9zjhYS+xDo2
	waj55IblcXgWQ2eUKZjYsGz2+RRNApc/P9+TtRFw4jqS/IGcrYpyA6xjVEna03LWvyfSUCqcv42
	UPoJCrFnlpyuA29sDzeJiehYl/rQLsThkDxUXKSqdjzUlgqKHEdL+ggwfLtH2T+LTeOt+dEjDTt
	HhBdCuzWAhKDJjae+IgABb1l4REt/0O3FC86pixALu3DRRYpE/jBk8JaV1k6NcKqA=
X-Received: by 2002:a05:6214:627:b0:8dd:fde8:68c7 with SMTP id 6a1803df08f44-90a701e166cmr22376436d6.30.1786516785163;
        Tue, 11 Aug 2026 23:39:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.68.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3ee3b2sm15055466d6.48.2026.08.11.23.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:39:44 -0700 (PDT)
Message-Id: <pull.2199.git.1786516783909.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 06:39:43 +0000
Subject: [PATCH] serve: reject valueless promisor-remote capability
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

d460267613da (Add 'promisor-remote' capability to protocol v2,
2025-02-18) added a receive callback which passes the capability value
directly to mark_promisor_remotes_as_accepted(). However, a client can
send the capability name without an '=' or value, in which case
get_capability() supplies NULL and strbuf_split_str() dereferences it.

Reject the missing argument before parsing it, and add a test covering
this case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    serve: reject valueless promisor-remote capability

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2199%2Fnewren%2Fpromisor-remote-require-argument-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2199/newren/promisor-remote-require-argument-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2199

 serve.c              |  3 +++
 t/t5701-git-serve.sh | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/serve.c b/serve.c
index 2b07d922b3..5a64344467 100644
--- a/serve.c
+++ b/serve.c
@@ -46,6 +46,9 @@ static int promisor_remote_advertise(struct repository *r,
 static void promisor_remote_receive(struct repository *r,
 				    const char *remotes)
 {
+	if (!remotes)
+		die("promisor-remote capability requires an argument");
+
 	mark_promisor_remotes_as_accepted(r, remotes);
 }
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..d888cc5c3c 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -71,6 +71,17 @@ test_expect_success 'request invalid capability' '
 	test_grep "unknown capability" err
 '
 
+test_expect_success 'promisor-remote capability requires an argument' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	object-format=$(test_oid algo)
+	promisor-remote
+	0000
+	EOF
+	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
+	test_grep "promisor-remote capability requires an argument" err
+'
+
 test_expect_success 'request with no command' '
 	test-tool pkt-line pack >in <<-EOF &&
 	agent=git/test

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
gitgitgadget
