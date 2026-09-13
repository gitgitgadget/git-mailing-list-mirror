Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF1280309
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789269617; cv=none; b=BjKzuVHX5mBLjM2PmGnI47O9CzJOJ6btfu7UbXxjkK1F1SnDjFOS7FtAlDFvM5NzE17MDBeMpn+B84RAdOtmtle50OG+3/h7EwHBaPV3VGW78kzDg65NXyDvn0+1qL0d3wVLgCICFwVu/ceqHj9NsAinE4yXvxI38Xtklpbv90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789269617; c=relaxed/simple;
	bh=xyojRQIvW0TYER7BclR7xv1RKa+JNMs8GB88mekDy9c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=nqxuQmukhwPnkZYoqOOA9CTBLnfr8T2nKdL4pt4mc9KXWI/1tzEs5GKdbAvtCLBbL9J5h6btB5HqWrEdUYB3pwuAlvwmkHhKkO/imLjLqY//RCXKmztyqdL/8rYcftdQ9DmoC+RuTt6+uR3OWfNK7H+gZz+S61aj47MkW5qYIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSGeZeVR; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSGeZeVR"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso758376a91.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789269615; x=1789874415; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LxILM4LdIjR2TtlI9KZqcfCoUmrIjR7SqiiZykZ6dGU=;
        b=TSGeZeVRC0sUjzhmQ6RXVpIH9tk68NjWDHhPzo75WlkF1k8fF9vkpazE8MxnOdTJSN
         GSorCcH4xcLvqjVoV/Bt8APdTPK8LOfOTM0rVQm+iuStw0I74f+Rp0UVPb2rtiEW3S9c
         fYu2dDQ0TQf6Zeyee7wDLTc2+QvC1OtTngS/jJsB4hSQS+5Q9aK/CqtHPEMfsp+A5wkT
         04Uk5XAFOcRbxuZAdnP7rYtZcZ6aFwQY4qgxkWmx5ZNZKAzmjMQHLj/sOlcVrXEknyk8
         gHpVqj7rJDqFgTpQ2LAeyQOMxQoqmzzFvLEZqzA9Otz/6IMXTFa8x4SqDRTK1ieK807o
         vBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789269615; x=1789874415;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LxILM4LdIjR2TtlI9KZqcfCoUmrIjR7SqiiZykZ6dGU=;
        b=F0yqYP+zwffim5TkMrNCq2rsrZpAPH+VgD4rKpR2k4aKPqFGfN5VGVCzA1Fl+LdEmX
         50riJZZeYfeBhFVWkEE/h6g4NHYJqJVF2E9tpJFFf8O3DW7Wl/+CCmnsVSV1vKA0ems+
         Cn8iLUMTqkaLShk0xNy6aW0xF0/f8xMHwzG8mANkyiLXgW6ch8xfGt/mar9Q6fz/hvEz
         BEJjg6U2urpsORLdWKNW/mw0j2sdzR1H7Z4jrdiuymSxJPj3Je0XBFnAdDyLk0AuFBaJ
         af1eIbt/DX9eLOC0rSlvmB200rnt747s5AJH3VvPEylg0WeyWF+WfReVpfbFRrzJd3Hh
         m6iQ==
X-Gm-Message-State: AFuF++kVZr67BiViGMn56sR0+/ilfIUZ44VcUJry3hk0tr4gJm81oXfp
	NmDU6BZYk+KNiqj8tdLgC722kehDPLRYkVc/zkODbZdas7XXXYMzItFO5jZbwg==
X-Gm-Gg: AYBFou0ng2XvaH0lP82RmhGnvApb6VEgabtgQKYbrEZ110N0g3dT5ZYY9UOQHq3TLZu
	vs7u/95+MLLJtf5Mezl2rYyHqGMOHDvuSuA4D1Su5VWT0WBhetiN7H7CMkhPibFGXpyr7YzAFuv
	8u7UOsXTziCkwBrPyXAXE6NvNo9k5/aAybo+Yei5ZRikEneI1jQYcTokq8RmGf0EuokwgE1/NIA
	OcMIIQZBzFk5Bkrz2vVxydRJ8R4t4d8hbSZB2Ta2iJ3gv7LjZWB8lvQrVUwIO3dnaIp97KVkAyJ
	vReEIldjkn29yJZ0opEGDoYLDYEKYRoDYgs2GF9fJC4riFXebbF74t0Zg+s53SiOGJYELzgo4Xo
	ZhpW61APCUYorgWdi4ONvZj0fpo6mbrWAo5pEcbp9A/1is9u4VWYui1ZPoU7DWEHXhckDig34BI
	yQvMaAuTHbGFlea032nvd6GT/LCFX6H4bOhhA83EvfGQhBY68XHk5ShyrypFSvsEabeDpiLLel
X-Received: by 2002:a17:90b:2dcd:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-39dbc6d53e5mr10060463a91.17.1789269615213;
        Sat, 12 Sep 2026 20:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.65.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed64fcsm19101572eec.16.2026.09.12.20.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:20:14 -0700 (PDT)
Message-Id: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 03:20:11 +0000
Subject: [PATCH 0/2] worktree repair: avoid breaking unrelated .git file and gitdir
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

'git worktree repair' does not sufficiently validate the cross-references
between a linked working tree and its administrative data before repairing
them. This can cause the repair to modify the wrong .git file or gitdir in
certain situations.

This series first refactors the code to read the .git file once and extract
the worktree ID, then uses that information to validate the repair target
before modifying the cross-references.

 * [1/2] Refactor the code without changing functionality before making the
   fix
 * [2/2] Validate the worktree ID and inferred gitdir path before repairing

Yoichi NAKAYAMA (2):
  worktree repair: refactor and reduce .git file reads
  worktree repair: avoid breaking unrelated .git file and gitdir

 t/t2406-worktree-repair.sh |  33 +++++++++---
 worktree.c                 | 105 ++++++++++++++++++++-----------------
 2 files changed, 83 insertions(+), 55 deletions(-)


base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2225%2Fyoichi%2Fworktree-repair-keep-unrelated-gitfile-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2225/yoichi/worktree-repair-keep-unrelated-gitfile-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2225
-- 
gitgitgadget
