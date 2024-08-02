Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE51BF31C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583920; cv=none; b=BGPFCa9iTw1GxMH0DgIus05CfZKsufT8Pg6uOQyXYuM3jT6ZHUeUpcdULkMfSDtIA4QKPP6UuQ/3cTNVGATnCtP9zHtyuOpyU2FFBDB5upxmmv6gUKQoBzB9sa4pZb6Y7DqcSeVuDRYxBq665wuLPgup4zRe8ZHdcb73cKICtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583920; c=relaxed/simple;
	bh=93CQOEO4gEIzGZPshEbRw1NC5V4dDstzSJTH6uXuAgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRhjoAtqkmmOSlyLcaKJr9zZNWd4PHIt4c3WoW8vz8S8IC0hgLKmh37h+YNq+9Uf107aZCgC7HJ5VyR4GxiNBKHumtW71WIHrirDC0W85SUDwflyNcGpqOxqVI/1tTq5V3cf4Cf0SK5sTR3ZpUXC1b183BjpyC8lcZdRbo2hVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z19zHaHe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z19zHaHe"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d162eef54so5640106b3a.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722583918; x=1723188718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOePw+Vs4uV1DQDDouaTeAGuDiFlpC5QBrGh/qPRLh8=;
        b=Z19zHaHe5k5qQMB8xIGmlTF9Z6F7Olp/lOAHb68nt3O7tsb7s8w+JVovwjN6giTVPk
         VIjOB8er6KpM9K8ttacbImnw8ei0CpBQqSg9eDdLB26Mc0GmIQ9u5nmw7B+N/eZeLmzC
         Zi0m4E5BQch34PLtnY7nu+7HZZiGDu0BXRmFnyVh/b3fK2/AnUxCiR8C+ZrKsTzrxCc0
         QclOceVbIc+7lD8p59MEbyzaKOFSetiY6G65HnnC3D7nW7qCzmdcjvqwO8ZNcKsPkcUD
         bZPkHQanvWT9WZL6Uao4bwzUgtVoazboaRG8Yjk/UlYuqouI6ur1dHT16rZQibHVW58o
         ZxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583918; x=1723188718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOePw+Vs4uV1DQDDouaTeAGuDiFlpC5QBrGh/qPRLh8=;
        b=B1eUYmMAeLw0nE2lbbfCEwU4TxMC7Ko3tZc6sNEJajOkbcbLQkPgM6b95NdcI/jP56
         5TlcmM4DCFGTk9m2LBuWEqzlv5fNSyEMutNQaPm2+tdDss0gnIp9Bf+PtOKmPZuWIL41
         9NZTvw11ziXbc8b5MUU8iVefRZpo1rZirAM0tlGUHoPXS6GSmeFei+EsQ0WWiCtzBHV+
         OOmRmqzqWZ3d47m14gJn5MgpGlL/R7n0zKwzK2obWY6kHvCkVSU9wum28jnwTX3WdXII
         J7ppGeYwBnZCi4v3I/YtE1QpVT6AxOeha7BIAMt8/8M79JJ0bovfOj5m+Bjddokx/hWf
         p5Mg==
X-Gm-Message-State: AOJu0YzmIde5Q9fddiOnLzIwQ0h1YNK3fE2DMU4STfr6kUOwGTHnLHvE
	6Doc2Yo8Uk8f1fF3d9PLuW0h5N7HftFTgCVkjKBTKE3f0SpVCXzgI2ifuIRb1ZD7Z3vxu7AOxc7
	f
X-Google-Smtp-Source: AGHT+IFLYhEWO9khExJylmrAEOMRmhUTeFn4QsPlid+3EDr0E1o8GjIRRcYmqi8c+AvVk95VV0/7Ew==
X-Received: by 2002:a05:6a00:a24:b0:70d:26b5:3b43 with SMTP id d2e1a72fcca58-7106d081363mr3992874b3a.19.1722583917636;
        Fri, 02 Aug 2024 00:31:57 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec01cbesm887410b3a.12.2024.08.02.00.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:31:57 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/1] revision: fix reachable objects being gc'ed in no blob clone repo
Date: Fri,  2 Aug 2024 15:31:42 +0800
Message-ID: <20240802073143.56731-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use --filter=blob:none to clone our large monorepo.
After a while we started getting reports from engineers complaining 
that their local repository was broken. Upon further investigation, 
we found that broken repositories are missing objects that created 
in that particular local repository. git fsck reports "bad object: xxx".

Here are the minimal steps to recreate issue.
    # create a normal git repo, add one file and push to remote
    $ mkdir full && cd full && git init && touch foo
    $ git add foo && git commit -m "commit 1" && git push

    # partial clone a copy of the repo we just created
    $ cd ..
    $ git clone git@example.org:example/foo.git --filter=blob:none partial

    # create a commit in partial cloned repo and push it to remote
    $ cd partial && echo 'hello' > foo && git commit -a -m "commit 2"
    $ git push

    # run gc in partial repo
    $ git gc --prune=now

    # in normal git repo, create another commit on top of the
    # commit we created in partial repo
    $ cd ../full && git pull && echo ' world' >> foo
    $ git commit -a -m "commit 3" && git push

    # pull from remote in partial repo, and run gc again
    $ cd ../partial && git pull && git gc --prune=now

The last `git gc` will error out on fsck with error message like this:

  error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94
  error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94

Note that disabling commit graph on the partial repo will cause 
`git gc` to exit normally, but will still not solve the 
underlying problem. And in more complex situations, 
disabling commit graph will not avoid the error.

The problem is caused by the wrong result returned by setup_revision
with `--exclude-promisor-objects` enabled.
`git gc` will call `git repack`, which will call `git pack-objects`
twice on a partially cloned repo. The first call to pack-objects 
combines all the promisor packfiles, and the second pack-objects 
command packs all reachable non-promisor objects into a normal packfile.
However, a bug in setup_revision caused some non-promisor objects 
to be mistakenly marked as in promisor packfiles in the second call 
to pack-objects. These incorrectly marked objects are never repacked, 
and were deleted from the object store as a result. In revision.c, 
`process_parents()` recursively marks commit parents as UNINTERESTING 
if the commit itself is UNINTERESTING. `--exclude-promisor-objects` 
is implemented as "iterate all objects in promisor packfiles, 
mark them as UNINTERESTING". So when we find a commit object in 
a promisor packfile, we also set its ancestors as UNINTERESTING, 
whether the ancestor is a promisor object or not. In the example above, 
"commit 2" is a normal commit object, living in a normal packfile, 
but marked as a promisor object and gc'ed from the object store.

Han Young (1):
  revision: don't set parents as uninteresting if exclude promisor

 revision.c               |  2 +-
 t/t0410-partial-clone.sh | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.46.0.rc0.107.gae139121ac.dirty

