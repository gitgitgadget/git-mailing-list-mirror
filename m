Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914D57300
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUvM88So"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40b5155e154so73776145e9.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004672; x=1705609472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkhT75EqWpD2Igh0G/AWT4BxlDOU55rQT1sgj5C2zLA=;
        b=iUvM88So2Ta/RuJLln8xhkaqSQyGF4DXS2qbydDsoeDvGEWYC+Jr1teXL0WP4zt8k/
         b1E4bqhzDh7jVgngc0/8xDxZ15tzYb2GmqaBuMoCIFEWzBE6cTD974qI4hlVDi/oy8uE
         T9V1yXcZCCPS6d32j4zFDc0M1iK3kQa2ZyCWep87eIe2ctE9GfPqXjh/eI9l3rF/Wyux
         jZM3jLBmYftAxLjfnsKvMIGNn+X3AOiPiZYrgxqnQnx0zsTHj7vgDly0bPMr+anIHJLC
         rPDuMQpD0lesKXEw11Pl9T/6C/YTMl6LAs059uCWo54PA1/38c5uKFnnrYDsoegm2Qus
         UqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004672; x=1705609472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkhT75EqWpD2Igh0G/AWT4BxlDOU55rQT1sgj5C2zLA=;
        b=fK4BkzvEGL92UGafSDp332w0KIqBZ643qWZGeMJR94DPA/KbRjJOMFpnWh1NnjSv9X
         DpFfykI7BDdzGNhuxPcAQLAgFGKJy4IQusFVM92vA6PQECNgnWz+tcHrZziemBcbSGMQ
         uObyHwTx1seR1Y7YNC+1FBqbpRlhWyHsYakPtnVCmDZc28kyoR+r1kMA/wOO2vxT7k8j
         nZyGyf7IetzLbXVvTJ5WEqxuIbBhMmVSn1f1/jloT+wgvUeLCrKSn/o3T+WZpO8ZkmD9
         DkaSf2SksAPTlNG2OK1yS6y/IvOtxlGN3ojKNgGqBwJinNoslL5SlvqSSawuocDZBQup
         aOtw==
X-Gm-Message-State: AOJu0Yy6q/H/ShAuMbik9pQqI2WZWi67P6ze4wqBaES56dfpJF5iDWic
	Fi8pH7jnsD5UWAauNJKlEGZZk3MKcZg=
X-Google-Smtp-Source: AGHT+IGzt2Z80xKfkqoVe0FYTlx1fIuJ5ovJ9kw08kpvqe5VBZcts8dqwCVfdT9ye7m3xlGgVKBmIw==
X-Received: by 2002:a05:600c:5108:b0:40d:51ce:16b4 with SMTP id o8-20020a05600c510800b0040d51ce16b4mr167533wms.178.1705004671654;
        Thu, 11 Jan 2024 12:24:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0040e4914f28dsm6987398wmq.18.2024.01.11.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 12:24:31 -0800 (PST)
Message-ID: <pull.1634.v2.git.1705004670.gitgitgadget@gmail.com>
In-Reply-To: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jan 2024 20:24:28 +0000
Subject: [PATCH v2 0/2] Generalize reference locking in tests
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
Cc: Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Justin Tobler <jltobler@gmail.com>

Hello again,

This is the second version my patch series that refactors two tests to no
longer be dependent on the files reference backend. Changes compared to v1:

 * Removed reliance on fifo magic to trigger error conditions.
 * d/f conflicts now used to create errors instead.

Thanks for taking a look!

Justin

Justin Tobler (2):
  t1401: remove lockfile creation
  t5541: remove lockfile creation

 t/t1401-symbolic-ref.sh    |  5 ++---
 t/t5541-http-push-smart.sh | 18 +++++-------------
 2 files changed, 7 insertions(+), 16 deletions(-)


base-commit: 624eb90fa8f65a79396615f3c2842ac5a3743350
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1634%2Fjltobler%2Fjt%2Fbackend-generic-ref-lock-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1634/jltobler/jt/backend-generic-ref-lock-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1634

Range-diff vs v1:

 1:  cb78b549e5e ! 1:  714f713ccec t1401: generalize reference locking
     @@ Metadata
      Author: Justin Tobler <jltobler@gmail.com>
      
       ## Commit message ##
     -    t1401: generalize reference locking
     +    t1401: remove lockfile creation
      
     -    Some tests set up reference locks by directly creating the lockfile.
     -    While this works for the files reference backend, reftable reference
     -    locks operate differently and are incompatible with this approach.
     -    Refactor the test to use git-update-ref(1) to lock refs instead so that
     -    the test does not need to be aware of how the ref backend locks refs.
     +    To create error conditions, some tests set up reference locks by
     +    directly creating its lockfile. While this works for the files reference
     +    backend, this approach is incompatible with the reftable backend.
     +    Refactor the test to create a d/f conflict via git-symbolic-ref(1)
     +    instead so that the test is reference backend agnostic.
      
          Signed-off-by: Justin Tobler <jltobler@gmail.com>
      
       ## t/t1401-symbolic-ref.sh ##
      @@ t/t1401-symbolic-ref.sh: test_expect_success LONG_REF 'we can parse long symbolic ref' '
     - 	test_cmp expect actual
       '
       
     --test_expect_success 'symbolic-ref reports failure in exit code' '
     + test_expect_success 'symbolic-ref reports failure in exit code' '
      -	test_when_finished "rm -f .git/HEAD.lock" &&
      -	>.git/HEAD.lock &&
      -	test_must_fail git symbolic-ref HEAD refs/heads/whatever
     -+test_expect_success PIPE 'symbolic-ref reports failure in exit code' '
     -+	mkfifo in out &&
     -+	(git update-ref --stdin <in >out &) &&
     -+
     -+	exec 9>in &&
     -+	exec 8<out &&
     -+	test_when_finished "exec 9>&-" &&
     -+	test_when_finished "exec 8<&-" &&
     -+
     -+	echo "start" >&9 &&
     -+	echo "start: ok" >expected &&
     -+	read line <&8 &&
     -+	echo "$line" >actual &&
     -+	test_cmp expected actual &&
     -+
     -+	echo "update HEAD refs/heads/foo" >&9 &&
     -+
     -+	echo "prepare" >&9 &&
     -+	echo "prepare: ok" >expected &&
     -+	read line <&8 &&
     -+	echo "$line" >actual &&
     -+	test_cmp expected actual &&
     -+
     -+	test_must_fail git symbolic-ref HEAD refs/heads/bar
     ++	# Create d/f conflict to simulate failure.
     ++	test_must_fail git symbolic-ref refs/heads refs/heads/foo
       '
       
       test_expect_success 'symbolic-ref writes reflog entry' '
 2:  11fd5091d61 ! 2:  f953a668c6a t5541: generalize reference locking
     @@ Metadata
      Author: Justin Tobler <jltobler@gmail.com>
      
       ## Commit message ##
     -    t5541: generalize reference locking
     +    t5541: remove lockfile creation
      
     -    Some tests set up reference locks by directly creating the lockfile.
     -    While this works for the files reference backend, reftable reference
     -    locks operate differently and are incompatible with this approach.
     -    Generalize reference locking by preparing a reference transaction.
     +    To create error conditions, some tests set up reference locks by
     +    directly creating its lockfile. While this works for the files reference
     +    backend, this approach is incompatible with the reftable backend.
     +    Refactor the test to create a d/f conflict via git-update-ref(1) instead
     +    so that the test is reference backend agnostic.
      
          Signed-off-by: Justin Tobler <jltobler@gmail.com>
      
     @@ t/t5541-http-push-smart.sh: test_expect_success 'push --atomic fails on server-s
       
      -	# break ref updates for other on the remote site
      -	mkdir "$d/refs/heads/other.lock" &&
     -+	mkfifo in out &&
     -+	(git -C "$d" update-ref --stdin <in >out &) &&
     -+
     -+	exec 9>in &&
     -+	exec 8<out &&
     -+	test_when_finished "exec 9>&-" &&
     -+	test_when_finished "exec 8<&-" &&
     -+
     -+	echo "start" >&9 &&
     -+	echo "start: ok" >expected &&
     -+	read line <&8 &&
     -+	echo "$line" >actual &&
     -+	test_cmp expected actual &&
     -+
     -+	echo "update refs/heads/other refs/heads/other" >&9 &&
     -+
     -+	# Prepare reference transaction on `other` reference to lock it and thus
     -+	# break updates on the remote.
     -+	echo "prepare" >&9 &&
     -+	echo "prepare: ok" >expected &&
     -+	read line <&8 &&
     -+	echo "$line" >actual &&
     -+	test_cmp expected actual &&
     ++	# Create d/f conflict to break ref updates for other on the remote site.
     ++	git -C "$d" update-ref -d refs/heads/other &&
     ++	git -C "$d" update-ref refs/heads/other/conflict HEAD &&
       
       	# add the new commit to other
       	git branch -f other collateral &&
     +@@ t/t5541-http-push-smart.sh: test_expect_success 'push --atomic fails on server-side errors' '
     + 	# --atomic should cause entire push to be rejected
     + 	test_must_fail git push --atomic "$up" atomic other 2>output  &&
     + 
     +-	# the new branch should not have been created upstream
     +-	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
     +-
     +-	# upstream should still reflect atomic2, the last thing we pushed
     +-	# successfully
     +-	git rev-parse atomic2 >expected &&
     +-	# ...to other.
     +-	git -C "$d" rev-parse refs/heads/other >actual &&
     +-	test_cmp expected actual &&
     +-
     +-	# the new branch should not have been created upstream
     ++	# The atomic and other branches should be created upstream.
     + 	test_must_fail git -C "$d" show-ref --verify refs/heads/atomic &&
     ++	test_must_fail git -C "$d" show-ref --verify refs/heads/other &&
     + 
     + 	# the failed refs should be indicated to the user
     + 	grep "^ ! .*rejected.* other -> other .*atomic transaction failed" output &&

-- 
gitgitgadget
