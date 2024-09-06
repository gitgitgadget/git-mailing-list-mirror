Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991071CB15C
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623101; cv=none; b=dFt4dNpWUHFs99Gquv+B1DewmCknZ7xAyf4n5ZqTNYvNNjhdxpJaoK01mA0hk6om9idijEG14KPKH5IROyX4hBEcJntsH/3acu+w5ZVz18VnyRPwLrPCBi3T/cJbBH/o1CctHi8AE//+EXQGtLvGTPk6kXVG7SRPaQMsylM/FnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623101; c=relaxed/simple;
	bh=usJI2MXo1QrnG3fwvm+ErUGf6zUKlIIKTcb/z+mbEFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQ9jWx2y8whKYeNBO4Sol/4HuYLy9ChV3P0LU+RpiywjLuKYma5gDSCcBEpShgpWrTlHPIzsEQkESg2ogHBd35gYX/wI4m22QKP04rNC1O2UPjxhsdT31Sd4+Of6/xlimvqLbCISHVtyid0Ao88metcCm6do94ybB0iV+X5hr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+y3v0QM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+y3v0QM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717934728adso1314379b3a.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623098; x=1726227898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIaOjZVCUUXbIdSstHURhnwFZfKy5i1FSddm+d4QeI0=;
        b=X+y3v0QMDhsmBcwSstu5SPWGVY9NEsg3oTmwOcfxtKIKO1CfLo7MNv7/LWUeJq1U6/
         kTYOuXq5NgYmTbVRmBvIgouM6ikEXYYnGjCjufPSYRtWq1N2Z4ec87dmkYrKZiHdivBu
         tUBgObs03v4MvDz4I49L9oCyvgDiXy4qgKYcmYufaLg2bLi+Vr7gxQRK3LrXO4Qfy5WB
         A8osiqBl7kytuZdvaDA4gqqPW5AsDtigw7T+qiBupo6YQ1fTYZrwOd9eKIClRTpf1n2q
         DaM9oZ82ZI78RCaNNQoaY1Sv7MgrclZ+4GyNmRL5hvmb5HQ1KWN3ZuVg0s5jiM71FeUo
         OPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623098; x=1726227898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIaOjZVCUUXbIdSstHURhnwFZfKy5i1FSddm+d4QeI0=;
        b=YjQm2jCWIyYxq6MufSKWBSI9eI4aH1mIGdTApUnv95Tjh+QVMB8h4WAhDr3ZtBTJUZ
         D7psSrrd4YOzqpwSp7xH3Vk257T7xxdZL2Fo/t5dHivL73SFPwv++LQHiIlhwwbz40X4
         wDR1yJt/SSDqQuMSMDw2kM1JRRF+yxkDBPlpKd7yPLoeRO1asg1poDVpeNzCeiALXjyw
         ZouhmTNot9pBoaYcZQ6kSMzT3lPLxJCWQt0+T2RgGQw/lPEv0hIon1FN2ozQEpi6xQlU
         anj2+RipFj6OEA3Z9qzMNZMHV9CWdKdq0sslz2w6n7KX3asfSy9iMBHqrbcc2OLQ67/c
         e7+Q==
X-Gm-Message-State: AOJu0YyCv/O3S3O1h3qShf3YQmjX/t9ZSDu7xgywljbyN/W/ym7vKu4s
	q9Sly5c4VM2MequAyav4ff6wcroFVrpECrtnGVSgdeoXfmc1DcscfXfB5HN9
X-Google-Smtp-Source: AGHT+IHDaLcj2i10dKeRzbdKQOuCdkJ6W7l+pfpq3jSQni44pg9b4lRSf0RFriRtYNBBt2VL1EnHyw==
X-Received: by 2002:a05:6a21:e85:b0:1c6:fb07:381e with SMTP id adf61e73a8af0-1cce10ed59fmr28755787637.44.1725623098177;
        Fri, 06 Sep 2024 04:44:58 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:44:57 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v5 0/7] t: port reftable/stack_test.c to the unit testing framework
Date: Fri,  6 Sep 2024 16:59:09 +0530
Message-ID: <20240906113746.8903-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/stack_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v5:
- Edit the commit messages in patches 3 and 4 to reflect the changes
  and the motivation behind those changes better.
- Add newlines after variable declarations in patch 6.
- Introduce patch 7 which removes leftover cruft from the previous
  reftable testing scheme.

CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(7):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators
t: clean up leftover reftable test cruft

Makefile                                           |   4 +-
reftable/reftable-tests.h                          |  14 -
reftable/test_framework.c                          |  27 -
reftable/test_framework.h                          |  61 --
t/helper/test-reftable.c                           |   8 -
t/helper/test-tool.c                               |   3 +-
t/helper/test-tool.h                               |   1 -
t/t0032-reftable-unittest.sh                       |  16 -
.../unit-tests/t-reftable-stack.c                  | 665 ++++++++++++---------
9 files changed, 390 insertions(+), 409 deletions(-)

Range-diff against v4:
1:  eae681f53d ! 1:  ca4b00feef t-reftable-stack: use Git's tempfile API instead of mkstemp()
    @@ Commit message
         like mkstemp(), make the ported stack test strictly use Git's
         tempfile API as well.

    +    A bigger benefit is the fact that we know to clean up the tempfile
    +    in case the test fails because it gets registered and pruned via a
    +    signal handler.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
2:  19b2f41003 ! 2:  3e723667dd t-reftable-stack: use reftable_ref_record_equal() to compare ref records
    @@ Commit message
         reftable_ref_record_equal(), and sometimes by explicity comparing
         contents of the ref records.

    -    Replace the latter instances of ref-record comparison with the
    -    former to maintain uniformity throughout the test file.
    +    The latter method is undesired because there can exist unequal ref
    +    records with the some of the contents being equal. Replace the latter
    +    instances of ref-record comparison with the former. This has the
    +    added benefit of preserving uniformity throughout the test file.

         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
3:  ffdfba6b98 = 3:  7526550c92 t-reftable-stack: add test for non-default compaction factor
4:  ca447664e7 ! 4:  05e4b7e715 t-reftable-stack: add test for stack iterators
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +			.log = &logs[i],
     +			.update_index = reftable_stack_next_update_index(st),
     +		};
    ++
     +		err = reftable_stack_add(st, write_test_log, &arg);
     +		check(!err);
     +	}
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +	reftable_iterator_seek_ref(&it, refs[0].refname);
     +	for (i = 0; ; i++) {
     +		struct reftable_ref_record ref = { 0 };
    ++
     +		err = reftable_iterator_next_ref(&it, &ref);
     +		if (err > 0)
     +			break;
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +	reftable_iterator_seek_log(&it, logs[0].refname);
     +	for (i = 0; ; i++) {
     +		struct reftable_log_record log = { 0 };
    ++
     +		err = reftable_iterator_next_log(&it, &log);
     +		if (err > 0)
     +			break;
-:  ---------- > 5:  43c1a522fb t: clean up leftover reftable test cruft

