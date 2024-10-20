Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F89194143
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431829; cv=none; b=kTF7O3d2uOOmODLvFaCD+Ly2+itPlVlWCs8lcpQoLOO5lkEnDiPzIBOAwJDfvS2badISpOWrG/fF8Rq3OOBhylxnFS8JTPd+cBL/o8vBdZ8818iF3RagRpa3KhKEas9SroroeJutdot3UHK0Lxl+x48aiVhsD6LZ9Mw1gNumajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431829; c=relaxed/simple;
	bh=4C2EoXD0qRgp37ejpHQAhG965/uTFbfCXWNMgiUmul0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SQ8qjAIAnadCMT4rg7duGqIRctAwDj1S9JWX74CJUFsueB4aijSQTSR/+NLiSVEGQMJ0gHOQUJimiDz9IY/xISYnwp7UATNDN+re0XHIIctmOlocI4zrlPWGf0zyT2/KisiJ7t/6iYRnJh9/hgwxyYKtDjXf4WrdF1H1Xb96j4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVBVS3P6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVBVS3P6"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a16b310f5so467586366b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431825; x=1730036625; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZkXyCwyPixrfrkjod8gQkMhmIivNdVBmrqEDTvbsk4=;
        b=EVBVS3P6ylyDT5xnE3tGgUWJzug+PHlpxhx0WAi1cV1h1jLQGpKnHHbspfs8ZcYWfj
         URoTbAVKyuC8MarU76UglcgGTeOYrDDMJH6GGYG77t6Ek6tzBesp0nuADy4ADxhyyqi3
         CO4SKxXE6QwjvKTw+8XPoMsg/ex3EuEmpDXopeRIJXU4KS5Yw77iQHlnBs3932rEmf/h
         iiRt4qzyvWnUBgx7Z8d+St5JqJ2/tl9po+aAcDdpDHfOEKPe8hbZp0kvr8toHmot2obf
         gL+gmgvlblrLdrrZ+mgtselqp+dK/0gCbSFct7LfKtPSr0BpqPUM7vLL7mK1e4aR79qw
         +IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431825; x=1730036625;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZkXyCwyPixrfrkjod8gQkMhmIivNdVBmrqEDTvbsk4=;
        b=I34C8wdNOx5F5LC0tg/7XaEzr1OfX5uamUYYfThMEp2BphKlzNWOsOgw0GyCjCUmL5
         f5LTTH1EnPiknC+01IblDnisTEz8rd2Vj06IOHp44qwVjWHx2YUAiTaYd74WzRx3P+RI
         Lv244gMFFPPJs1hGWDFSuQH6osT82lURJQ5tmr2z6o0ZYo0PVuLb/UKlSolYHOQOzrGV
         u28C5HEsrVV0w3f2hRohzURD0cfeFzVCgaJQPHSDE/1uceO+kUuemOIiddU3zNlP38Wh
         gNxq1UsMCg8fHzpKmGPtzVbKd3cBFX8LdXsMGAJ1slyee/QOtpjoXBDP/Q3DIEBZJp6e
         v4rg==
X-Gm-Message-State: AOJu0YzGHvuSm8S7tZVGdiFDgaIWJWeCrsqg2bFXy8rE7SNEOBnv6vLp
	R+LZumQlL7hkFkh6gKBGBjH/XEx6D6JFLoDl61+evoOzPoJgTKavtGDzsQ==
X-Google-Smtp-Source: AGHT+IHZntYrZBxw9IBEJN3SraYYCge1CVCrYUXL+LVcnW1QQdpjVeDRkejZzos0cnPy7kVQ1C9CpQ==
X-Received: by 2002:a17:907:7e83:b0:a9a:59f:dfb9 with SMTP id a640c23a62f3a-a9a699694a4mr792381266b.5.1729431824643;
        Sun, 20 Oct 2024 06:43:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d639asm92771866b.5.2024.10.20.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:43 -0700 (PDT)
Message-Id: <21dc3723c365f28d7e31db15044744060a977a3d.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:23 +0000
Subject: [PATCH v2 10/17] p5313: add performance tests for --path-walk
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added a --path-walk option to 'git pack-objects'.
Create a performance test that demonstrates the time and space benefits
of the feature.

In order to get an appropriate comparison, we need to avoid reusing
deltas and recompute them from scratch.

Compare the creation of a thin pack representing a small push and the
creation of a relatively large non-thin pack.

Running on my copy of the Git repository results in this data:

Test                                      this tree
---------------------------------------------------------
5313.2: thin pack                         0.01(0.00+0.00)
5313.3: thin pack size                               1.1K
5313.4: thin pack with --path-walk        0.01(0.01+0.00)
5313.5: thin pack size with --path-walk              1.1K
5313.6: big pack                          2.52(6.59+0.38)
5313.7: big pack size                               14.1M
5313.8: big pack with --path-walk         4.90(5.76+0.26)
5313.9: big pack size with --path-walk              13.2M

Note that the timing is slower because there is no threading in the
--path-walk case (yet).

The cases where the --path-walk option really shines is when the default
name-hash is overwhelmed with collisions. An open source example can be
found in the microsoft/fluentui repo [1] at a certain commit [2].

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Running the tests on this repo results in the following output:

Test                                      this tree
----------------------------------------------------------
5313.2: thin pack                         0.28(0.38+0.02)
5313.3: thin pack size                               1.2M
5313.4: thin pack with --path-walk        0.08(0.06+0.01)
5313.5: thin pack size with --path-walk             18.4K
5313.6: big pack                          4.05(29.62+0.43)
5313.7: big pack size                               20.0M
5313.8: big pack with --path-walk         5.99(9.06+0.24)
5313.9: big pack size with --path-walk              16.4M

Notice in particular that in the small thin pack, the time performance
has improved from 0.28s to 0.08s and this is likely due to the improved
size of the resulting pack: 18.4K instead of 1.2M.

Finally, running this on a copy of the Linux kernel repository results
in these data points:

Test                                      this tree
-----------------------------------------------------------
5313.2: thin pack                         0.00(0.00+0.00)
5313.3: thin pack size                               5.8K
5313.4: thin pack with --path-walk        0.00(0.01+0.00)
5313.5: thin pack size with --path-walk              5.8K
5313.6: big pack                          24.39(65.81+1.31)
5313.7: big pack size                              155.7M
5313.8: big pack with --path-walk         41.07(60.69+0.68)
5313.9: big pack size with --path-walk             150.8M

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..840075f5691
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_expect_success 'create rev input' '
+	cat >in-thin <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1)
+	EOF
+
+	cat >in-big <<-EOF
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+'
+
+test_perf 'thin pack' '
+	git pack-objects --thin --stdout --no-reuse-delta \
+		--revs --sparse <in-thin >out
+'
+
+test_size 'thin pack size' '
+	test_file_size out
+'
+
+test_perf 'thin pack with --path-walk' '
+	git pack-objects --thin --stdout --no-reuse-delta \
+		--revs --sparse --path-walk <in-thin >out
+'
+
+test_size 'thin pack size with --path-walk' '
+	test_file_size out
+'
+
+test_perf 'big pack' '
+	git pack-objects --stdout --no-reuse-delta --revs \
+		--sparse <in-big >out
+'
+
+test_size 'big pack size' '
+	test_file_size out
+'
+
+test_perf 'big pack with --path-walk' '
+	git pack-objects --stdout --no-reuse-delta --revs \
+		--sparse --path-walk <in-big >out
+'
+
+test_size 'big pack size with --path-walk' '
+	test_file_size out
+'
+
+test_done
-- 
gitgitgadget

