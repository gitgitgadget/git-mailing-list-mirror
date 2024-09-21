Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA812A1C5
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726943885; cv=none; b=hMY63cJqFB68EMc6Gu3g//uO+fDQycqhYjUzalgwBSZduVmrwHpRjhvgntGVotTRO+Gp9BtFziWQkbXxocoqUU26bXYnxmn1WChjYTfPzzOKiEdBLra410G13Za8x4bwFQY2pZMelUD25Yb89obGBI7B+aR32YraCT45KQYT7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726943885; c=relaxed/simple;
	bh=87vrbCWJJXToO2MXaYasnd/LjuOe10o26TbL3e6qqKs=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=VpXoZlaFZ0rdk4j69YoqSd9wbfFH9D6z/moPEqzV+HjGSVYs1TOxmzzxavwDa5SREHqcCcwQwhhb0XDSef2DPocH5J1Ltu0gWSEBNZgTv+7BzqcPRjw3zkZfmQG6r6cbI6rfme4SQjYZ0029cTjYyd2/jffze4kbbjYnmYXtZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgR1E6w7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgR1E6w7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c4226a56a8so3653667a12.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726943881; x=1727548681; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSVnpGtcXu6+IYp8sGq0tvHbt/0CPtpJzqT8927gti0=;
        b=kgR1E6w7SXaFHPUp+FBrOz9+fE8x2AYmF5Gm+U4uYjrw/zv5wMmgOYjMWO8MGqsmtc
         xYWZ+3VGuAaUfbjK8Fv2FRyNZzoFjhbvf2pveDlb1mrChzctcxEROX17JWgvKcqCF232
         28I5U7Ombqk+Vtcaxvxe0Jt53OIIltQlTQIpKEWUe/lzwK9n2ZvGM7sN9Ql7Cfss/EZu
         SXd5AC26hp40YFKjlMTrU5hvS8Ib07CzcYWVzYSP+e8fqBlKRINJB43WSWu+E9hl9wyV
         EXcjeubqskTvw0ky2AMkWiNtp5jDu+iFUl0uk5nQvUuG3KQMsMCX3mNK/6uX9TvfUZ3v
         8AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726943881; x=1727548681;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSVnpGtcXu6+IYp8sGq0tvHbt/0CPtpJzqT8927gti0=;
        b=bvoJrTMERhgNRW4kuyqYMy1vKD/1Aj2A6vUFfLomayQrq6EZaLIiLlENDA5Y0+i/0Y
         +vXKCcBTvQ30/io9JqWEZ3CEcod4hYmu0brfCJVfVpnFJtAD43kZ9SSDKttbDZiG8QH1
         kW8XUWUr6Hs6yFt/i7DuKh+uDZlkPQDJZwO+vnFx5NFIqODP38hMUPWOiiCdEYoKNfmH
         Tjea9+f918d4+HfAsXjJMJjX4VmZLQC9mLsGYZ8EGuTjgIVxLGz3dsf5NitQ7rBOaHzy
         xdY6ZyM0MJfLAqjU810heURZSHODJmdHcLzi5RumZBq5jw2pVGyJaZ2CaRPz0G1WI6Lt
         6Mhw==
X-Gm-Message-State: AOJu0YxFqFaO/BLSc0BUh2OKbGc1mUO666xI23kymJexlEy2jwz7UnCL
	CVK8net3yFPUCFbhzZZBZfP4rdrnq8IvnQ/wb8gYAfnJZZ2l+UeLFH1rfA==
X-Google-Smtp-Source: AGHT+IEKpK5wPAvxFSqgl57aiYzCIFYx9rzWkma1PkANV/gnZLXjeyoaheVIG+NDBtKNTTgV/z9B3g==
X-Received: by 2002:a17:907:d59d:b0:a8d:345e:a0ba with SMTP id a640c23a62f3a-a90d4fe65d5mr620860866b.15.1726943881257;
        Sat, 21 Sep 2024 11:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4399sm1000172266b.65.2024.09.21.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 11:38:00 -0700 (PDT)
Message-Id: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
From: "Nicolas Guichard via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Sep 2024 18:37:58 +0000
Subject: [PATCH 0/2] rebase-merges: try and use branch names for labels
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Nicolas Guichard <nicolas@guichard.eu>

When interactively rebasing merge commits, the commit message is parsed to
extract a probably meaningful label name. For instance if the merge commit
is “Merge branch 'feature0'”, then the rebase script will have thes lines:
label feature0 merge -C $sha feature0 # “Merge branch 'feature0'

This heuristic fails in the case of octopus merges or when the merge commit
message is actually unrelated to the parent commits.

An example that combines both is: *---. 967bfa4 (HEAD -> integration)
Integration |\ \
| | | * 2135be1 (feature2, feat2) Feature 2 | |_|/ |/| | | | * c88b01a
Feature 1 | |/ |/| | * 75f3139 (feat0) Feature 0 |/ * 25c86d0 (main) Initial
commit which yields the labels Integration, Integration-2 and Integration-3.

Fix this by using a branch name for each merge commit's parent that is the
tip of at least one branch, and falling back to a label derived from the
merge commit message otherwise. In the example above, the labels become
feat0, Integration and feature2.

Nicolas Guichard (2):
  sequencer.c: extract load_branch_decorations
  rebase-merges: try and use branch names as labels

 sequencer.c                   | 50 ++++++++++++++++++++++-------------
 t/t3404-rebase-interactive.sh |  4 +--
 t/t3430-rebase-merges.sh      | 12 ++++-----
 3 files changed, 40 insertions(+), 26 deletions(-)


base-commit: 94b60adee30619a05296cf5ed6addb0e6d4e25dc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1784%2Fnicolas-guichard%2Fuse-branch-names-for-rebase-merges-labels-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1784/nicolas-guichard/use-branch-names-for-rebase-merges-labels-v1
Pull-Request: https://github.com/git/git/pull/1784
-- 
gitgitgadget
