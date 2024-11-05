Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06753365
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775919; cv=none; b=DZSS3/6j0xEfnu05J0JnTcSJH6rVCtrfEvZpKPh6X1LFp05ozoWXwHBPcB3S1+pLPA0IGYVjylAfl1K9kq0UAv7iqpGg4rRget60eoGpEhkDsp0hq0G/3EwMGDXJYqD/aYVOqjarBfkEmBk3CrhLnoeDzpMsaiGmQblvrv9eN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775919; c=relaxed/simple;
	bh=4mpV2hPPkWldxlF+f/RxPIB+elRRQjfGyg9r+KenQ8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CSN05hnWUMRgoFP734gVBYSDzSJ3D0oGM1RVxZpxsIOHdKtCx0Kj5u9dKbpLhRzOZCWvRD4wWEPujRkw7LtV9vxNlJk/JkNPdkRKZrF5A06+6A1EFcb/pJNWN7BkNefuOFRJdJLRY2ceVMfBM/4U9202sezRPlDtHMA0ipZB4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLtfviLf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLtfviLf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2826273f8f.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775915; x=1731380715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1vnBnUH7sl3fgzbfJIwVV9Czr5vpo7DJG2ZHFWBjb4=;
        b=SLtfviLfMFAprHk9t4gH7n1JkTCbkMMuA7Hqyi19/l8mSol7LpwPAugY+cKaj93Ncv
         GfEmAlWEWw7jCMxqV5g2BcDk7txa8UZDoeJb0li70yKiz34a1F2oy42KtnoWQY/IrVe6
         DLthg3E7HlAVXltv7nLjNEpr9CtxyFr/oy+oyciz8gQTduBnJQXFGpBWLwuiwt4HEHe8
         yx9sCJ1unu0NZH7n2/DhrTGiSauKO7x863LRHB2gguVqZ0LPMLVN7K8GIcTbiU61CeLa
         9zmPyduGIsT0Est0TK6OFN60u99Q5nQy46P7VXB3/LuOzOu6eSdqZcjKEaoOi8q0g6Q5
         +UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775915; x=1731380715;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1vnBnUH7sl3fgzbfJIwVV9Czr5vpo7DJG2ZHFWBjb4=;
        b=OFI53qBeUFmbVsuejxnQ/Y2gWf2zhSJCMnCqXEBmMx6tHEZkb0nYDBdCCqWgB2rPTY
         dvNJGkN4Rlf9/0lxpGiUO9UGm1xQ6/n/7pYWJ5Y8ysZmAIE6ijeAaIj8ZEZ+DLU7cNWF
         Le6125r3RZTzADnhlmEv1l8SqzIC33WbigQBckbbnqG0GcaM1W2Wd5fj/7KDmFdcdLqV
         6PCIQBxulSqyyef/j3Bh/fLpORYCRaJcxUhj8Et0j+YhW4q8rIuaynKyeQAyxKnUslhM
         ipY1PT/9pmZEbVVuGMgZxhiSAcsNIGmtG8wGMNdJFTO0FMm/70Grs3yn54ENJWfSYUnI
         lDOA==
X-Gm-Message-State: AOJu0Yw/Hjr/1kiJk17jn+3JeKJkq+L1R1vcWAaKA1JUrl5D44V1sOsw
	HoTwWc361cuTJJOSuaKr6kln+1Ih5yyaUib83NfDgzDyPAjle5/UXlTskg==
X-Google-Smtp-Source: AGHT+IH0jjVrvbOr7ew3K8KHCnshElp0oYXXp4/6m/VGe7pCE6hYQI/VigV3Q8ZxaNbSHczBsIkEWg==
X-Received: by 2002:a05:6000:4817:b0:37d:4fe9:b6a4 with SMTP id ffacd0b85a97d-381c7ab30a6mr12264576f8f.50.1730775914452;
        Mon, 04 Nov 2024 19:05:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b97sm14873455f8f.2.2024.11.04.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:14 -0800 (PST)
Message-Id: <c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:05 +0000
Subject: [PATCH 5/7] p5313: add size comparison test
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

Test                                               HEAD
---------------------------------------------------------------------
5313.2: thin pack                                  0.37(0.43+0.02)
5313.3: thin pack size                                        1.2M
5313.4: thin pack with --full-name-hash            0.06(0.09+0.02)
5313.5: thin pack size with --full-name-hash                 20.4K
5313.6: big pack                                   2.01(7.73+0.23)
5313.7: big pack size                                        20.3M
5313.8: big pack with --full-name-hash             1.32(2.77+0.27)
5313.9: big pack size with --full-name-hash                  19.9M
5313.10: shallow fetch pack                        1.40(3.01+0.08)
5313.11: shallow pack size                                   34.4M
5313.12: shallow pack with --full-name-hash        1.08(1.25+0.14)
5313.13: shallow pack size with --full-name-hash             35.4M
5313.14: repack                                    90.70(672.88+2.46)
5313.15: repack size                                        439.6M
5313.16: repack with --full-name-hash              18.53(123.41+2.53)
5313.17: repack size with --full-name-hash                  169.7M

In this case, we see positive behaviors such as a significant shrink in
the size of the thin pack and full repack. The big pack is slightly
smaller with --full-name-hash than without. The shallow pack is slightly
larger with --full-name-hash.

In the case of the Git repository, these numbers show some of the issues
with this approach:

Test                                               HEAD
--------------------------------------------------------------------
5313.2: thin pack                                  0.00(0.00+0.00)
5313.3: thin pack size                                         589
5313.4: thin pack with --full-name-hash            0.00(0.00+0.00)
5313.5: thin pack size with --full-name-hash                 14.9K
5313.6: big pack                                   2.07(3.57+0.17)
5313.7: big pack size                                        17.6M
5313.8: big pack with --full-name-hash             2.00(3.07+0.19)
5313.9: big pack size with --full-name-hash                  17.9M
5313.10: shallow fetch pack                        1.41(2.23+0.06)
5313.11: shallow pack size                                   12.1M
5313.12: shallow pack with --full-name-hash        1.22(1.66+0.04)
5313.13: shallow pack size with --full-name-hash             12.4M
5313.14: repack                                    15.75(89.29+1.54)
5313.15: repack size                                        126.4M
5313.16: repack with --full-name-hash              15.56(89.78+1.32)
5313.17: repack size with --full-name-hash                  126.0M

The thin pack that simulates a push is much worse with --full-name-hash
in this case. The name hash values are doing a lot to assist with delta
bases, it seems. The big pack and shallow clone cases are slightly worse
with the --full-name-hash option. Only the full repack gains some
benefits in size.

The results are similar with the nodejs/node repo:

Test                                               HEAD
---------------------------------------------------------------------
5313.2: thin pack                                  0.01(0.01+0.00)
5313.3: thin pack size                                        1.6K
5313.4: thin pack with --full-name-hash            0.01(0.00+0.00)
5313.5: thin pack size with --full-name-hash                  3.1K
5313.6: big pack                                   4.26(8.03+0.24)
5313.7: big pack size                                        56.0M
5313.8: big pack with --full-name-hash             4.16(6.55+0.22)
5313.9: big pack size with --full-name-hash                  56.2M
5313.10: shallow fetch pack                        7.67(11.80+0.29)
5313.11: shallow pack size                                  104.6M
5313.12: shallow pack with --full-name-hash        7.52(9.65+0.23)
5313.13: shallow pack size with --full-name-hash            105.9M
5313.14: repack                                    71.22(317.61+3.95)
5313.15: repack size                                        739.9M
5313.16: repack with --full-name-hash              48.85(267.02+3.72)
5313.17: repack size with --full-name-hash                  793.5M

The Linux kernel repository was the initial target of the default name
hash value, and its naming conventions are practically build to take the
most advantage of the default name hash values:

Test                                               HEAD
-------------------------------------------------------------------------
5313.2: thin pack                                  0.15(0.01+0.03)
5313.3: thin pack size                                        4.6K
5313.4: thin pack with --full-name-hash            0.03(0.02+0.01)
5313.5: thin pack size with --full-name-hash                  6.8K
5313.6: big pack                                   18.51(33.74+0.95)
5313.7: big pack size                                       201.1M
5313.8: big pack with --full-name-hash             16.01(29.81+0.88)
5313.9: big pack size with --full-name-hash                 202.1M
5313.10: shallow fetch pack                        11.49(17.61+0.54)
5313.11: shallow pack size                                  269.2M
5313.12: shallow pack with --full-name-hash        11.24(15.25+0.56)
5313.13: shallow pack size with --full-name-hash            269.8M
5313.14: repack                                    1001.25(2271.06+38.86)
5313.15: repack size                                          2.5G
5313.16: repack with --full-name-hash              625.75(1941.96+36.09)
5313.17: repack size with --full-name-hash                    2.6G

Finally, an internal Javascript repo of moderate size shows significant
gains when repacking with --full-name-hash due to it having many name
hash collisions. However, it's worth noting that only the full repack
case has enough improvement to be worth it. But the improvements are
significant: 6.4 GB to 862 MB.

Test                                               HEAD
--------------------------------------------------------------------------
5313.2: thin pack                                  0.03(0.02+0.00)
5313.3: thin pack size                                        1.2K
5313.4: thin pack with --full-name-hash            0.03(0.03+0.00)
5313.5: thin pack size with --full-name-hash                  2.6K
5313.6: big pack                                   2.20(3.23+0.30)
5313.7: big pack size                                       130.7M
5313.8: big pack with --full-name-hash             2.33(3.17+0.34)
5313.9: big pack size with --full-name-hash                 131.0M
5313.10: shallow fetch pack                        3.56(6.02+0.32)
5313.11: shallow pack size                                   44.5M
5313.12: shallow pack with --full-name-hash        2.94(3.94+0.32)
5313.13: shallow pack size with --full-name-hash             45.3M
5313.14: repack                                    2435.22(12523.11+23.53)
5313.15: repack size                                          6.4G
5313.16: repack with --full-name-hash              473.25(1805.11+17.22)
5313.17: repack size with --full-name-hash                  861.9M

These tests demonstrate that it is important to be careful about which
cases are best for using the --full-name-hash option.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 94 ++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..dfa29695315
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,94 @@
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
+	cat >in-big <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+
+	cat >in-shallow <<-EOF
+	$(git rev-parse HEAD)
+	--shallow $(git rev-parse HEAD)
+	EOF
+'
+
+test_perf 'thin pack' '
+	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
+'
+
+test_size 'thin pack size' '
+	test_file_size out
+'
+
+test_perf 'thin pack with --full-name-hash' '
+	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
+'
+
+test_size 'thin pack size with --full-name-hash' '
+	test_file_size out
+'
+
+test_perf 'big pack' '
+	git pack-objects --stdout --revs --sparse  <in-big >out
+'
+
+test_size 'big pack size' '
+	test_file_size out
+'
+
+test_perf 'big pack with --full-name-hash' '
+	git pack-objects --stdout --revs --sparse --full-name-hash <in-big >out
+'
+
+test_size 'big pack size with --full-name-hash' '
+	test_file_size out
+'
+
+test_perf 'shallow fetch pack' '
+	git pack-objects --stdout --revs --sparse --shallow <in-shallow >out
+'
+
+test_size 'shallow pack size' '
+	test_file_size out
+'
+
+test_perf 'shallow pack with --full-name-hash' '
+	git pack-objects --stdout --revs --sparse --shallow --full-name-hash <in-shallow >out
+'
+
+test_size 'shallow pack size with --full-name-hash' '
+	test_file_size out
+'
+
+test_perf 'repack' '
+	git repack -adf
+'
+
+test_size 'repack size' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
+test_perf 'repack with --full-name-hash' '
+	git repack -adf --full-name-hash
+'
+
+test_size 'repack size with --full-name-hash' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
+test_done
-- 
gitgitgadget

