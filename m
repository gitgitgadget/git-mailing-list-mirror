Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3713CA97
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230774; cv=none; b=P1x5xD40AxTZvuqQ4k8F+HXcYVnID86gj/ymxQNNtagdeRstXrOn9RrFauy1uhVkDdWRM/Qiij46KdwoA10usD79xpcpIHehdI78JO2ywym2SRVajvCPncpT7pTnoU2cFfL13jf/HDz7CG9QUJQ/Tjky84ch3IxOYc0BKPGnSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230774; c=relaxed/simple;
	bh=vVh8atIrfkGqTOwWwu6L0oJ/MCi7Wqor6FrRUVTEDkg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V03SLc42Ihkp1dtAG+p3SBBb2zRAPXNd3qUr89OaJ+sQkbLZL+gfJM/1vgSE+anH4aq9D6c7iSjF7Nre0pUalOjDWd3o9hMCDeb5b8ElL1j9gB9+r7lCqqu5q0TX+l/Y5tTPaA+uFPLZ1iT3EhXcJVRqsucB1ld5Kv6fIDBND3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xm9fCViI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xm9fCViI"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9957588566so9762066b.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728230770; x=1728835570; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDHJkF5EKa31Ine7/EUdwu5VO/6sQnz/X8Ujk3pe1Rk=;
        b=Xm9fCViIxjvfd/mY/vyyrgb5E1KqbwmLJ875n4i14NQxGBJQpwSm365/hXtgXsAH3d
         JrqpJlxWn2mKGhCAPVsdTs8lQwdtj6aJAijrhkbrYNv2/j5XppINrvjnq6THSEL109YP
         G/uAE7VB4HeYEljDENX+aj8rBJFBsQlR1KOPG4L7gLlBzTMJs464zbWr42rflFPQ9MYJ
         prwwCa+N7zH+xlNh99HC0S8PUfqtsbV7agmI+OCQ3Wh2QCm25yXzzJfWXcsMN2kcVZ4f
         iqBw48FozZiMvagWf2P/xzdIQv+ts68M1ja8/7w3M4TEUxJNvuoz2YQ/3WBoXZVm1Xzq
         3KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728230770; x=1728835570;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDHJkF5EKa31Ine7/EUdwu5VO/6sQnz/X8Ujk3pe1Rk=;
        b=FNMArIpSrE7SCjDBuZkslNvPPN+oNXOUL/LrDWvfPBaVfxwY4rcgE+6oc8rnLYQmwc
         0RMSQo2tz6+xhCerNHDhFaUhbni1rAzypzmvL/jYFVYiwLeYNwUrZWm4w8Rzin4PT7n9
         8tfr49YruYXfdloOEyFsE1xmcDB5PPVjHgrTY5p7aQ5Yz8MoS18xvbU6OsijgYq43+6/
         AZWLA/+ITBKsg6Tq/oX7dlmuynyYrmHtv8/IVIvPQxLhQ6OkLTSKmt/xTZUKr4enEban
         y39c/wi41gHC2NqORiIdcUfdG20123PIefi4xHzjQb4s0XylejLANPeJuIawvV9vYapp
         2MgA==
X-Gm-Message-State: AOJu0Yx9hWlJL9rwBdG9xaN/I/vVKvY+0ypKKeYNvlK0Quh2Mfb787Fw
	D8b9ge2CxNeJ9/n41xgnZtjKTQDw7v7NIAHMbkmjvwMowGA3BItoViA0Ug==
X-Google-Smtp-Source: AGHT+IEwUqvBtiBcec3lPBG2eTLq9s5o83tUVQnSEpUT8Yw7gagYSwPg0azc2y9mdmIZgL0mN/Bjrg==
X-Received: by 2002:a17:907:1c84:b0:a99:420c:80b2 with SMTP id a640c23a62f3a-a99420c8123mr419836966b.27.1728230770111;
        Sun, 06 Oct 2024 09:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5ba412sm272203266b.18.2024.10.06.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:06:09 -0700 (PDT)
Message-Id: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 16:06:07 +0000
Subject: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    shejialuo <shejialuo@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

At the beginning of my task, I made the mistake of submitting two patches
for two separate commits instead of one. The first patch addressed the issue
of losing the Git exit status due to pipes.

After submitting the first patch, I noticed that the output of wc -l was
failing due to trailing whitespace. I attempted to fix this by using tr -d
to remove the whitespace. However, instead of squashing the two patches into
one, I inadvertently created another commit.

Eric Sunshine sunshine@sunshineco.com provided valuable feedback during the
review process. He explained the details of the patches to me and pointed
out that using tr -d was unnecessary to resolve the whitespace issue.

The root cause of the whitespace issue was quoting $count in the test
command, which led to the inclusion of whitespace in the comparison. By
removing the quotes around $count, the comparison works as expected without
the need for tr -d.

Signed-off-by: Usman Akinyemi

Usman Akinyemi (2):
  t3404: avoid losing exit status with focus on `git show` and `git
    cat-files`
  [Outreachy][Patch v1] t3404: employing test_line_count() to replace
    test

 t/t3404-rebase-interactive.sh | 74 +++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 24 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v3
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v2:

 1:  be5a691e96f ! 1:  c9a0cca179b [Outreachy][Patch v1] t3404: avoid losing exit status to pipes
     @@ Metadata
      Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
       ## Commit message ##
     -    [Outreachy][Patch v1] t3404: avoid losing exit status to pipes
     +    t3404: avoid losing exit status with focus on `git show` and `git cat-files`
      
          The exit code of the preceding command in a pipe is disregarded. So
          if that preceding command is a Git command that fails, the test would
          not fail. Instead, by saving the output of that Git command to a file,
          and removing the pipe, we make sure the test will fail if that Git
     -    command fails.
     +    command fails. This particular patch focuses on some of the instances
     +    which include `git show` and `git cat-files`.
      
          Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
      
 -:  ----------- > 2:  37b1411ee2c [Outreachy][Patch v1] t3404: employing test_line_count() to replace test

-- 
gitgitgadget
