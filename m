Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922479FE
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381685; cv=none; b=O8i61kPiLJtgSxe33EA7l+ASbWG+8RQWWPiERIYxDxiDHibsraRZXXW84pZi9LIqhDVv9d3ydnsGu4tZUgk74/0Hh8k1KHvOBYt+IWKtJaM/RsPbxRJNuN9Q8Ey3GILRbwS2Se5B+I8iHqEg8WbjWJT/wyGkJCfZ+bGiFGnR7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381685; c=relaxed/simple;
	bh=i7KbYjyG843U5ekgmcjEXld3p4SY28pLa2df6/ZtbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQe3s/JRv7cuFIR8D0WnyXomaf65TUROZPSUmd1k9qNeUr1dFqOmz3qc5M1wCiv4rdq5gD1Shgh9eZN+ENrUsH2T3Cn6FTAyrSyWqucP2OiElLd2q42MlgQAJHCvhm328nShcu/6D77SCwMotHWKdpiFaMTbHCIlsLc6aNRuAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XMb94ZLI; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XMb94ZLI"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-80a2939265cso54919439f.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721381682; x=1721986482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lGSgmQ00eqHzxB6DJqWhlXoU/pI5D8hZZabTgvcc8Q=;
        b=XMb94ZLIj+VkAbEnWvIJ75Uwkv+EiNcgMgMRmkcPN5TENcAg3mgTa5stPFcEgSyyij
         OYWqcgfTRL0YiAilur3vMOmez2aBOv4I2HL0y3lh1jQgzDIX7XNm1mhK+kSnvsrd/aLN
         Ub0s4olEfsZz4CRxEIXNlTAAfq1yCBdz5tPeSClfdqqRPDZ03Apf2uLG7jNXweuiBQGU
         5yefDvrbEyrHrquCgCO/wof21AioZIbtmrwulKS/ziy4UujobR6A87uaV3DodNot2XRV
         W+LViMiZJQLT6eNHSs5293Pg5vQFbhl22vm+fnaIiphvi4hBGi8OubGiKxGYDldT21GJ
         IICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381682; x=1721986482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lGSgmQ00eqHzxB6DJqWhlXoU/pI5D8hZZabTgvcc8Q=;
        b=pr7ge1Zu+d2qiPWpo2v8BrgiPnhlplEBNES7QlIF8jGI6qAom3iESRWfZ1qoyPqIvq
         f252OKuvLEOiXZwno8JsxKCFR9nkSkfqYpN4G8BF9a1xcAh7PKXbTmZhDhkLph44UO7n
         rF3qE62geMOZ/q97t4VI2mAiCNVSjzuDiw1J3aLBTdqz9fexzB2qtMq5An+FIuWalTBI
         WX8Wh2MP3dl9x1nq7+hKxXcbF30cM1RakU1B6ooP9gkyJK+DnziHpIxTTfp+zU1knf50
         5/cn9vRZTt9j2EpYOJb/TlSNXdD0RBCWYlJOHHPzuhX+nQIWw/PtUiRSJC7+jz6ALWON
         m6Lw==
X-Gm-Message-State: AOJu0Yw0lQ+bZjoPKVA8ehbmOshAe/2nW2+RRT/Tyq7o9YKEtQXhtCdt
	9XUcwXtFh19ZpBocaUNZQFuRTBJpKqwTgXbr9PasYN+Hbt3JPXnk7malkSy9pX6Hnkp8WyyWjeA
	s
X-Google-Smtp-Source: AGHT+IFec3ol0AkuY2HfldQcIvGk1OLNcHICr/1e/BAkACNHHw1CuJSYEOA3Of1d3k/JckNEh30GAA==
X-Received: by 2002:a05:6e02:2164:b0:397:584d:9b73 with SMTP id e9e14a558f8ab-397584d9d43mr42996965ab.7.1721381681956;
        Fri, 19 Jul 2024 02:34:41 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff552816sm831558b3a.139.2024.07.19.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:34:41 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/1] Fix bug in revision walk if --exclude-promisor-objects is set
Date: Fri, 19 Jul 2024 17:34:34 +0800
Message-ID: <20240719093435.69238-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We use --filter=3Dblob:none to clone our large monorepo. After a while we s=
tarted getting reports from engineers complaining that their local reposito=
ry was broken. Upon further investigation, we found that broken repositorie=
s are missing objects that created in that particular local repository. `gi=
t fsck` reports "bad object: xxxx".

Here are the minimal steps to recreate issue.
  # create a normal git repo, add one file and push to remote
  mkdir full && cd full && git init && touch foo && git add foo && git comm=
it -m "commit 1" && git push

  # partial clone a copy of the repo we just created
  cd .. && git clone git@example.org:example/foo.git --filter=3Dblob:none p=
artial

  # create a commit in partial cloned repo and push it to remote
  cd partial && echo 'hello' > foo && git commit -a -m "commit 2" && git pu=
sh

  # run gc in partial repo
  git gc --prune=3Dnow

  # in normal git repo, create another commit on top of the commit we creat=
ed in partial repo
  cd ../full && git pull && echo ' world' >> foo && git commit -a -m "commi=
t 3" && git push

  # pull from remote in partial repo, and run gc again
  cd ../partial && git pull && git gc --prune=3Dnow

The last `git gc` will error out on fsck with error message like this:
  error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94
  error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94

Note that disabling commit graph on the partial repo will cause`git gc` to =
exit normally, but will still not solve the underlying problem. And in more=
 complex situations, disabling commit graph will not avoid the error.

The problem is caused by the wrong result returned by setup_revision with `=
--exclude-promisor-objects` enabled. `git gc` will call `git repack`, which=
 will call `git pack-objects` twice on a partially cloned repo. The first c=
all to pack-objects combines all the promisor packfiles, and the second pac=
k-objects command packs all reachable non-promisor objects into a normal pa=
ckfile. However, a bug in setup_revision caused some non-promisor objects t=
o be mistakenly marked as in promisor packfiles in the second call to pack-=
objects. These incorrectly marked objects are never repacked, and were dele=
ted from the object store as a result. In revision.c, `process_parents()` r=
ecursively marks commit parents as UNINTERESTING if the commit itself is UN=
INTERESTING. `--exclude-promisor-objects` is implemented as "iterate all ob=
jects in promisor packfiles, mark them as UNINTERESTING". So when we find a=
 commit object in a promisor packfile, we also set its ancestors as UNINTER=
ESTING, whether the ancestor is a promisor object or not. In the example ab=
ove, "commit 2" is a normal commit object, living in a normal packfile, but=
 marked as a promisor object and gc'ed from the object store.

Han Young (1):
  revision: don't set parents as uninteresting if exclude promisor

 revision.c               |  2 +-
 t/t0410-partial-clone.sh | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--=20
2.46.0.rc0.107.gae139121ac.dirty

