Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F024188A1F
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692393; cv=none; b=K97lSBMu+mN6VeultxKxkLRk/m/4pY/aMuuuxLiqfqoCIWm3rXJFGw0iKh2zeNikNH4mg+K/CHUhU0pDY51RFBD8X7crvTLAIrrc9E2ly7oDUuAG2Zg3AX1mrMCGOcTIQaujUimlzT8506Ql4d5VsbfiEdXuUfRSARVa49hn1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692393; c=relaxed/simple;
	bh=gCzavPZaJ9l4yIGD9mTKRG+Ryx8bw/YKI/q+upxRvys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kcto9F6NqCklcoKf/VdncH/FiiZTRJj4VhNmozUS6fdQ7WGD/OMqrGfad0JRO4gxLnflt8AVWIrpwfaiOuLJLtWxClxctr4i17OniyTBFu3YXX3cON9K8TJXofS7r8VUm7jXl6WH+pb2G/JCxluoWRnVXUCTuCrTmjlyWmjvPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBElTQXO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBElTQXO"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so163484a12.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726692389; x=1727297189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xW46GYV3g89nlQDRZF7D0uD77QkxPK9bmYMQk6lSY0=;
        b=cBElTQXOoUznFHF31Mf4Q3aLVeoacWxFRcngr/7btq3cmKaEOimocykZZsaCxEz6q4
         r8AdM1NF1lZl/VSuvOiaCP5Vbjg7WnJ8hjVdiYaJWumTAbF8mRj2t+HHjisLbtUhWOw4
         u6/JSlBBR0hMe9iZnXaD7RTQVMItRfqB5mt+8kecqPiJ+jPvxQZy3+6EogG7H5Ntlon2
         R1YHpNKhR6It2nNcTwI69c/1gPudAPoocjPx1dgoJh0a2/yRiW78ht0FgKTHtwpwhRhv
         vmh5q1lvUGOLBm6aXdeWfiSxDHTVYTlDqp21gtK0fvTSwz9LCwGL0hEWblF/VUgGe/BF
         I2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692389; x=1727297189;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xW46GYV3g89nlQDRZF7D0uD77QkxPK9bmYMQk6lSY0=;
        b=p4HtaPYrJsu3nnX75XiLNZPFPSHtzgRUXQbkZv6S2cXAPkh1sgp2MYxKIGPiD1LzEz
         sVAPaap9pZQEq1FFHqbXOTpZ6oAWbaIZRmg7hiYjoj0pETZK8bLr9Y/WBUPApBTcSVgg
         /QZeganFBWB5akpfv9CBYhVhUjjkasuVpiCyxVSFlT+r/p+KWsycbAQyGgLI2Dn3Wcau
         SPhn51gOtIHCecbVGU//Jtey27rjNAHQ2XB70oBIZmpzfcBH04IxFHC74CJnWlRdBI8h
         CmoVtVmZgX2a3nQiPqFlY5Z2IfoqeSUr9N4QBrAezqzcVuIHSoLTh92iNf6qZ2pyQ22X
         8U0A==
X-Gm-Message-State: AOJu0YwbTCNzil4AbIP/3JiTVUMX82HNlaIbjRR+ouwIL+jLotnFLtVs
	IkEuX7CKpUFYiV0S4ZTKEirLJX3nDykZcCml8L3gXAXu9qOdJzxvOsx4Jg==
X-Google-Smtp-Source: AGHT+IGzMdOri4/OgrQ450nChf4lMU2+drz5HmMd9zuD1JtfezGMumxp1FGhpZtTjXht++gNRT0+8w==
X-Received: by 2002:aa7:c3c9:0:b0:5be:cdaf:1c09 with SMTP id 4fb4d7f45d1cf-5c413e50f05mr17797141a12.28.1726692388944;
        Wed, 18 Sep 2024 13:46:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb4964csm5379705a12.2.2024.09.18.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:46:28 -0700 (PDT)
Message-Id: <999b1d094241b0ba8d6924ac6976eafc64c7d4a6.1726692382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
	<pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 20:46:20 +0000
Subject: [PATCH v2 5/6] p5313: add size comparison test
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As custom options are added to 'git pack-objects' and 'git repack' to
adjust how compression is done, use this new performance test script to
demonstrate their effectiveness in performance and size.

The recently-added --full-name-hash option swaps the default name-hash
algorithm with one that attempts to uniformly distribute the hashes
based on the full path name instead of the last 16 characters.

This has a dramatic effect on full repacks for repositories with many
versions of most paths. It can have a negative impact on cases such as
pushing a single change.

This can be seen by running pt5313 on the open source fluentui
repository [1]. Most commits will have this kind of output for the thin
and big pack cases, though certain commits (such as [2]) will have
problematic thin pack size for other reasons.

[1] https://github.com/microsoft/fluentui
[2] a637a06df05360ce5ff21420803f64608226a875

Checked out at the parent of [2], I see the following statistics:

Test                                           this tree
------------------------------------------------------------------
5313.2: thin pack                              0.02(0.01+0.01)
5313.3: thin pack size                                    1.1K
5313.4: thin pack with --full-name-hash        0.02(0.01+0.00)
5313.5: thin pack size with --full-name-hash              3.0K
5313.6: big pack                               1.65(3.35+0.24)
5313.7: big pack size                                    58.0M
5313.8: big pack with --full-name-hash         1.53(2.52+0.18)
5313.9: big pack size with --full-name-hash              57.6M
5313.10: repack                                176.52(706.60+3.53)
5313.11: repack size                                    446.7K
5313.12: repack with --full-name-hash          37.47(134.18+3.06)
5313.13: repack size with --full-name-hash              183.1K

Note that this demonstrates a 3x size _increase_ in the case that
simulates a small "git push". The size change is neutral on the case of
pushing the difference between HEAD and HEAD~1000.

However, the full repack case is both faster and more efficient.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..5dcf52acb0d
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,71 @@
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
+	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
+'
+
+test_size 'thin pack size' '
+	wc -c <out
+'
+
+test_perf 'thin pack with --full-name-hash' '
+	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
+'
+
+test_size 'thin pack size with --full-name-hash' '
+	wc -c <out
+'
+
+test_perf 'big pack' '
+	git pack-objects --stdout --revs --sparse  <in-big >out
+'
+
+test_size 'big pack size' '
+	wc -c <out
+'
+
+test_perf 'big pack with --full-name-hash' '
+	git pack-objects --stdout --revs --sparse --full-name-hash <in-big >out
+'
+
+test_size 'big pack size with --full-name-hash' '
+	wc -c <out
+'
+
+test_perf 'repack' '
+	git repack -adf
+'
+
+test_size 'repack size' '
+	wc -c <.git/objects/pack/pack-*.pack
+'
+
+test_perf 'repack with --full-name-hash' '
+	git repack -adf --full-name-hash
+'
+
+test_size 'repack size with --full-name-hash' '
+	wc -c <.git/objects/pack/pack-*.pack
+'
+
+test_done
-- 
gitgitgadget

