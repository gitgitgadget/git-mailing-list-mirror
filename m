Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A246189F2F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296539; cv=none; b=cQftZk2kZQZQmJrX8e+xvvGNJ6axHSRytblApy8BFUix9B7KrZjzIZGvXxGixY1F/woX6kGQfxSJn2LUpSef0jz7lve33sAJYj1bTfTJ0MW8Tmw61iz5kzMaR7R5ZmHv0KtdPEFArRNIw9uMxfiLxhfD5Z1iX1rZCwrjEKJb85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296539; c=relaxed/simple;
	bh=nG/qKW7xRQ5FWDB+sjeAOxA9xg1K3dibW/GcE/axax4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NCGmXRwrguW2KbvcrshPf37mSHX1eE/xMt0Dbc774sCZpDmAoG4R8AOFwl9dJMvREHqz9P4Zj/rR+tWI34GKcjNO7bB/+3/JthLDTvcE5f0umWh2pCWQ1t7wvXP1MRSo2IBhrpMHqeMQVpYRZ+ghe0Emd/cKSbgHYq6l+6Z+GD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7NnJCth; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7NnJCth"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398b589032so6152828e87.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296535; x=1728901335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiIM08nORir3MW5LV3zC60kd0rWJc6wDXtm+d5TIyp8=;
        b=O7NnJCthTbru4nqn2f3vjtHA9ZdKUkQ1ukJW1OKWz+Yr8EkwyG0+X47cyDjhiwwLer
         hYO+8JHTr2n6YGFo8ys3tFaL7JaUD2oPUoH9gnJd+tKlmYMhE0acQVdAR/21SN/6wkAn
         T75Z3/dqzaqwd9px9q0tOuNzak6qMQOeXOY8wwvjf4aJ7rgrJjc0CroOvtEm25Dlno9e
         ABQziXviG+eawpmCZqRls2KPwbAuDHWnBxCNxlZbLKFTtbg7/ncsdzIYc/2sjr8VWVat
         DAiNdsUdeFYa9Hf0Ntc+dDJALkjahGND8dKiiLR/HMUFvNmSbujEmd8TodAwVRnxGGeC
         gJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296535; x=1728901335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiIM08nORir3MW5LV3zC60kd0rWJc6wDXtm+d5TIyp8=;
        b=k7yUGhPQSmvaawPgaDF24n9F5bi0pXioaza1MTgGw6X92HgSHyUZL7FQa6MP8KrJ6c
         t2kGhzgZlEbyTkxePLbVlEcVQAQkVfF3mM2wNqfcaNtoQYa3o5zcL1mnw/c9pW2kK0F/
         8oonWVU6zDBbfdtqi883qL2TLWgp36ULSeNTc8lOhgXKPwIS41PqnX8e4hPp7JmXxGVG
         FG7gi0ZIaoMZrilU+dPfwM0eHKTImN3QXyDAX2V7oVVlMJPgJ/Itb7KoNzw9FOgV2feT
         UlO5wHimtQADddKR2i/C1TItoj3Hp4WMYHqnKD0sn9fL7080FaOkDGz2G1t4HlC98+tQ
         izNQ==
X-Gm-Message-State: AOJu0YxhTDF8cSKtRbOI9nAEvOhUmFqcsPNvEGiOSMTFLnONIhwWqrMi
	L0DfAEkYXwA4lU27nfukPZ3bma3F6RnsLO96LO3v9CoKUdZVb0ckXkTYxA==
X-Google-Smtp-Source: AGHT+IFWT36VvijVwuU6MF6CcNgW04UChVKQoD0p6R+KWPofKW1kTSTJgzJcbD7PLQMo1WNwD16aNw==
X-Received: by 2002:a05:6512:a96:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-539ab866554mr7339366e87.16.1728296533016;
        Mon, 07 Oct 2024 03:22:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9936bc91f4sm332090166b.56.2024.10.07.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:22:12 -0700 (PDT)
Message-Id: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
References: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 10:22:09 +0000
Subject: [PATCH v4 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v3:

 * Replaced the use of grep | wc -l with a simplified ! grep command to
   directly check for the absence of "NEVER" in the output. I was not able
   to add this in the second patch ( employing test_line_count() to replace
   test). I was able to come to this solution with the help of Eric and
   Patriack.

Usman Akinyemi (2):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-file`
  [Outreachy][Patch v1] t3404: employing test_line_count() to replace
    test

 t/t3404-rebase-interactive.sh | 73 +++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 24 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v4
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v3:

 1:  c9a0cca179b ! 1:  bfff7937cd2 t3404: avoid losing exit status with focus on `git show` and `git cat-files`
     @@ Metadata
      Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## Commit message ##
     -    t3404: avoid losing exit status with focus on `git show` and `git cat-files`
     +    t3404: avoid losing exit status with focus on `git show` and `git cat-file`
      
          The exit code of the preceding command in a pipe is disregarded. So
          if that preceding command is a Git command that fails, the test would
          not fail. Instead, by saving the output of that Git command to a file,
          and removing the pipe, we make sure the test will fail if that Git
     -    command fails. This particular patch focuses on some of the instances
     -    which include `git show` and `git cat-files`.
     +    command fails. This particular patch focuses on all `git show` and
     +    some instances of `git cat-file`.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
 2:  37b1411ee2c ! 2:  864b00997b7 [Outreachy][Patch v1] t3404: employing test_line_count() to replace test
     @@ Commit message
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
     +    removed test
     +
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'stop on conflicting pick' '
       	test_cmp expect2 file1 &&
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'multi-squash only fires up e
       '
       
       test_expect_success 'multi-fixup does not fire up editor' '
     +@@ t/t3404-rebase-interactive.sh: test_expect_success 'multi-fixup does not fire up editor' '
     + 	) &&
     + 	test $base = $(git rev-parse HEAD^) &&
     + 	git show >output &&
     +-	count=$(grep NEVER output | wc -l) &&
     +-	test 0 = $count &&
     ++	! grep NEVER output &&
     + 	git checkout @{-1} &&
     + 	git branch -D multi-fixup
     + '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'commit message used after conflict' '
       	) &&
       	test $base = $(git rev-parse HEAD^) &&

-- 
gitgitgadget
