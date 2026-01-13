Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C9B28466C
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768306321; cv=none; b=QFqOJGJZAOObhnPD0bFsusB+Nz1oSnvMzjlsPki0HeBe0i2OlFFoBE6k185LcmyBFWolatUirIsyejwt+DOW2LsUBmJElv3qVhyL0LOa60v7McHB2Z5Ts80+vP9KIB8PX+1u0vyAchzJU6v4oa8GdwpKARP4yjbQVjtK6o+Xtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768306321; c=relaxed/simple;
	bh=b5naPlLLrrPSBc6IZIKX7JLd5aBSaa+FXo845WIOx+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k2ZTewU7kBjZ9+dNP4y+Cpf3DxWIOzBfvXDuuYVWeI2a+OkaJCt1IU1F+q8B2FH03ZlIecTt4v2HhaZXK+tZhllZ7KEdRiFKpiy0Y+DymkG/t8g0YybNL6Egc8JmQLf4DirbE1Zt50kR0Z+ZNaBpgFApRBBtwLhQ1JlNd8mjlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke+LY5w2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke+LY5w2"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee158187aaso81580271cf.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 04:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768306318; x=1768911118; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZzISbNEEjfMKmK0iyaRGUajZP9fSnOq20tYgRYw4Yg=;
        b=ke+LY5w2rSKWye1zzxGdB8fVB513FrbewvQZVMlXAgxqSLz3vCCEBjvxP4a/uBh94U
         OKEkEaUqK9SPU7k1DVXTxHk1gS/uees2ENp+YE5ZoyMooKAatg9IrhJjYZEjYQOUdA8h
         fcr4F6+HjsD74nIqiKOg+w3o0CHz3ZeVEqsmiwtkx6/J//ZpcdkZiF2OSmlbh16hwoHR
         /BM4uAe483nj+sQa72YQ+pw4LaPevrxt2hAIZ0L+1QNusJ+eMZ5Q/amvaq5gwTRQCO3Y
         FM+4WShXxxtezvlfpjujNq1XgZvn5n1kxmhfCIcimkOly5uERy9fBtPaYdVELYJBx4Ez
         16SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768306318; x=1768911118;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZzISbNEEjfMKmK0iyaRGUajZP9fSnOq20tYgRYw4Yg=;
        b=Os+VaKVmTBD7eV/rxdB56jDO0DBB3fKAtoETGBlCKMpKd0oYa+KvBu3e8NdXsBlqoA
         pAWb7xrwOthumVuP6ODSW4yW8bcCEJzDQUjWM/o9lyDEQuu7/NW5vkvUpf4hzC2AePO1
         jb6/KdqNZWoNSXxw+5/1LtVpiAnrs6uPcW8mqxvxLO6nB9dOYYv7cfM6Pp185z8pVKao
         4jYam8Vzxbi4RVqlQzPe1734kbebZ50Nllj7XS50nUfaVYoT/rR/WTt6pJcipyWhIK6+
         Baj6E+c45Tx8xHlpkwKd9tgOOTF1XFPOiaBioBiMTsOVY8rImEBmjwuL3W950WxUS5W1
         uFPw==
X-Gm-Message-State: AOJu0YzVUKKKfQ2FF/cxzUfXkqy6MaJSqmJusqvdJMIsxSG4MRMOFV5V
	+k+2FsNzc5a3izjElnL9JlqXpQBdrDzVZnusPcApZVamugd3eKENaZRGaXQjFQ==
X-Gm-Gg: AY/fxX6Cu/v1syPlMHxbK0+0SAw64LvFCS8oDtd25YmvBctoJeUHZNrni2y3bvrIp//
	99MeY4loNOIKmTB5ssyXUgBrD2/4NDyWvLZITb169ljfVR7gldtENy/8He1aQ7Mb6/765+PXGvW
	dq3PbTqE9CKZrw4Y3OJeZcEUSv4cfju4jnOQxiFH+75umr5KosHX89eIpG37WbGYkj8XK0UvQ23
	9Jn4jH4rHRZR+BsxxVqDm/Jk1QfMSAdHsDzbIrvQRPP0ocCAnyeqTNPVHpXR6LCMyFNSLHcPmA9
	/7pOKo91OKG4x3c+ccoWKit4Vnr4UBv00PrD5PNly1nEdZvMRwGp4lnVkWnQRHI6GS39zdkBwWf
	HrQFVUQ0v+B6nRL9TO2Obz1sJsrao8XQaIX55dZJmrL5UqBT4i3HavZSfF76dHaA0AsyQ5VD6+c
	zH8jk4610hKDC5cw==
X-Google-Smtp-Source: AGHT+IHGXS8Xx0zXoSXOE76uNseEYbXlvfgij1kdC6TT7SfggepDUyf75A7r7tNaeJgoWkbJPxZcJA==
X-Received: by 2002:a05:622a:5817:b0:4ee:1dd0:5a51 with SMTP id d75a77b69052e-4ffb4913976mr278848941cf.2.1768306318052;
        Tue, 13 Jan 2026 04:11:58 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890771061e7sm154530366d6.25.2026.01.13.04.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:11:57 -0800 (PST)
Message-Id: <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Jan 2026 12:11:54 +0000
Subject: [PATCH v25 0/2] status: show comparison with push remote tracking branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 175 +++++++++++++++++++-----
 t/t6040-tracking-info.sh | 285 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 425 insertions(+), 35 deletions(-)


base-commit: 8745eae506f700657882b9e32b2aa00f234a6fb6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v25
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v25
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v24:

 1:  fd05c7b778 = 1:  fd05c7b778 refactor format_branch_comparison in preparation
 2:  138b79a0b9 ! 2:  fa744efc59 status: show comparison with push remote tracking branch
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success 'status with upstream ahead and push branch up to date' '
     ++	(
     ++		cd test &&
     ++		git checkout -b ahead upstream/main &&
     ++		advance work &&
     ++		git push upstream HEAD &&
     ++		git checkout -b feature8 upstream/main &&
     ++		git push origin &&
     ++		git branch --set-upstream-to upstream/ahead &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature8
     ++	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
     ++	  (use "git pull" to update your local branch)
     ++
     ++	Your branch is up to date with ${SQ}origin/feature8${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'status shows remapped push refspec' '
      +	(
      +		cd test &&
     -+		git checkout -b feature8 origin/main &&
     -+		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
     ++		git checkout -b feature9 origin/main &&
     ++		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
      +		git push &&
      +		advance work &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature8
     ++	On branch feature9
      +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +test_expect_success 'status shows remapped push refspec with upstream remote' '
      +	(
      +		cd test &&
     -+		git checkout -b feature9 upstream/main &&
     -+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
     ++		git checkout -b feature10 upstream/main &&
     ++		git config remote.origin.push refs/heads/feature10:refs/heads/remapped &&
      +		git push origin &&
      +		advance work &&
      +		git status >../actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	On branch feature9
     ++	On branch feature10
      +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
      +
      +	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.

-- 
gitgitgadget
