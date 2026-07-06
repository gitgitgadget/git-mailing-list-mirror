Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C42F7ACE
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359246; cv=none; b=doAFov9qA/dm234BtSNPSxJ+YS74ADk5HKz9uNZ+ykf3Q08nGlM4Qtl2MYvuCBDHpqmNP0PcjFf85je5/An1+u8e9b7bM4Fh7s1GM6m9QMYz6MYMkAneS6nes9rKcIOwGszy+Q9bpQUtgScTAnStTOYySJ+XS32pTrQ15xRobSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359246; c=relaxed/simple;
	bh=ZAfbyVwK3aaUKHTBaVCrtDo6AyI+55sqxs/OVRhZ4bs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SA9cXDd5rwS8D2pfjTTbuP2QvrBhgu84E5AtHsA1U8WkK5YEH7jK+JeAVHm4nMUlsm3adWCw5ga5QhKRlPW5etZf+/uAz3wXZHWWs2hfj2LO/0QrQ3ntpo415ZasPYZ5TtY6eLzuc323Ifi3/84UW0+vKeJNbAA1aynUBUmO1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPD4C/Ro; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPD4C/Ro"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c89636920a3so1581535a12.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783359244; x=1783964044; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MhH3JSS1fIfg7JP/0NeWPavcGWO5GjLLd8L6eKz6Y08=;
        b=KPD4C/Ro/YZ/svcZnPtumi9nNpmHijDeTBXlfawWAs3BorUkfPKEKMInCZ1eoKm5x3
         PPDZ9SlwGLaVwG9mVvxJewKDOltmyJ81ks/6mibubklZ8iMdmjk1dM+tA6JNmIXTmwze
         fj+0QH8Am/QVLzSmXqt9al7BI04+sAe2FhspRpqM2FSfEgzq/w3wXyp3ogR5UyUNzypt
         vGuMUmL8sMkTt9azNk5UB2JuPsNSsXIlqdkiBSwdJHomoJT7K/Y9uP/ovOU1ibx4K+qz
         R88OYRr5g4HCkhMoi4d1IpIxxe2iWky3rPQe8xhEv4+okgSYJIp4zOlYA+6BuUZNijLd
         Bi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783359244; x=1783964044;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MhH3JSS1fIfg7JP/0NeWPavcGWO5GjLLd8L6eKz6Y08=;
        b=AC4RyYpzvySGW8nzFkftSIeoIQ87nbL1OYKzeNk6ZH2QIlRAvFjFBrqDdfRVoEwych
         qylc/kKmR8qkykF2PfIclkV0NPLoY/bmW9ggwQzuVp/izJqwa5iAKLqJfQfpgZMCBLmK
         v8uIE15KbqtCpO/Fre0Y+u7Iy8iynRvnEIrGw/XrvoOjsQD79YyGhBtvuvxl4xA8xcN+
         eExjR5jpiJhS2dAjoM1PZVjrZjYlxbAfQyxtMFZaajbuB3vlZHsqATw6SWjtoWvudDup
         9aDoc3MP40Nq3NSZ2elJwXlgTMabNkPcheSErIWSu/+8H954gUs+nrKFLqF0WVcGIsJD
         IzbA==
X-Gm-Message-State: AOJu0Yy/PaGbaupst5ZVc3m3Q4btsgyQRCbjD8xd3Cw9G56KZhkLMyff
	b5OKSXC1xFTLPf7f9KTH4SIwm3RBmUMxv4bk+SjNtA+XzZOFFhUr3oYYvxfsRA==
X-Gm-Gg: AfdE7cnz7Mi26m6I/sCD/5LMHFs69+TkM6veAoTvMGOt+XAhWL4vcYvDn38u75YJWkw
	nKhBgL2jWVtMJWVclmA4VPJ8TpiLSr09f3O1VA4yBvgGYAI9tRe8p1NvVpQwqXJBBvokpaJxAm5
	0IcfS8GspeuRWkb9EOOyRbjT6o0LgBGrdMonKr9wwIQ4FowQq9kqwv5RxNuD1PSB781gfrtvwz/
	WdM1K8l+HPrgTHI7GqcSEHuDbIk+Qz3TrDrg85KSomSnwvQGMyK/wXh9cuiklkAQc0DxRWY77mX
	KpCJ7n2FuQ7VlQZyE/8py236OEZ9O148472YepZJb8iFUtp1aGxDU2mMvjp+BJYodZ//y76TZgb
	RPxX0iFhLUnMES3cTxOxpE0HoEmsglqwSYTzMa94Ef8oY4UzAabiQJJQXFdS8VtIUqoHlY18IWs
	sZpn9IewDB+QFAyA==
X-Received: by 2002:a05:6a21:7116:b0:3bf:6c08:2b2f with SMTP id adf61e73a8af0-3c08efa611amr1891489637.55.1783359244080;
        Mon, 06 Jul 2026 10:34:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.226.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e927a1152sm6506816a12.29.2026.07.06.10.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:34:03 -0700 (PDT)
Message-Id: <pull.2168.git.1783359242130.gitgitgadget@gmail.com>
From: "Jamie Magee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 17:34:01 +0000
Subject: [PATCH] t0213: skip ancestry tests under user-mode emulation
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
Cc: Jamie Magee <jamie.magee@gmail.com>,
    Jamie Magee <jamie.magee@gmail.com>

From: Jamie Magee <jamie.magee@gmail.com>

The tests added in 3c8c638df6 (t0213: add trace2 cmd_ancestry tests,
2026-02-13) expect the cmd_ancestry event to name "test-tool" and
"git". On Linux those names come from the "comm" field of
/proc/<pid>/stat. Under user-mode emulation (e.g. qemu-user) /proc
reports the emulator ("qemu-riscv64") instead, so the event is still
emitted, the TRACE2_ANCESTRY probe enables the tests, and tests 2-5
fail even though they pass on native riscv64.

Require the probe to see "test-tool" in the ancestry of a test-tool
spawned from test-tool, so the tests skip when the names are unreliable.

Cc: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Jamie Magee <jamie.magee@gmail.com>
---
    t0213: skip ancestry tests under user-mode emulation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2168%2FJamieMagee%2Ft0213-skip-under-emulation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2168/JamieMagee/t0213-skip-under-emulation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2168

 t/t0213-trace2-ancestry.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t0213-trace2-ancestry.sh b/t/t0213-trace2-ancestry.sh
index a2b9536da8..2eb86c1952 100755
--- a/t/t0213-trace2-ancestry.sh
+++ b/t/t0213-trace2-ancestry.sh
@@ -31,12 +31,15 @@ PATH="$TTDIR:$PATH" && export PATH
 # no cmd_ancestry event is emitted.  We detect this at runtime and
 # skip the format-specific tests accordingly.
 
-# Determine if cmd_ancestry is supported on this platform.
+# Enable these tests only when cmd_ancestry reports real process names.
+# The procinfo stub emits no event; under user-mode emulation (e.g.
+# qemu-user) /proc reports the emulator, not the guest. Spawn test-tool
+# from test-tool and require "test-tool" in the child's ancestry.
 test_expect_success 'detect cmd_ancestry support' '
 	test_when_finished "rm -f trace.detect" &&
 	GIT_TRACE2_BRIEF=1 GIT_TRACE2="$(pwd)/trace.detect" \
-		test-tool trace2 001return 0 &&
-	if grep -q "^cmd_ancestry" trace.detect
+		test-tool trace2 004child test-tool trace2 001return 0 &&
+	if grep -q "^cmd_ancestry.*test-tool" trace.detect
 	then
 		test_set_prereq TRACE2_ANCESTRY
 	fi

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
