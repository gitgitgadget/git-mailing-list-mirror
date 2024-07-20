Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDED28D
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721453335; cv=none; b=mGh61WgFbLZ4FoUZ9RUY8JEGpIwiEM+Hfz0wXE4zWIhbAZ+nA2gbO1A1HDjHdsnOThZt9snY58JYZK7McsXaNljfwOdFAjRGGLHqs3sLlNvpGbJoLWtpkm0XwHQzXXdAyL1fnlRsXJkP+UYLiJEwfN8C6kygmiBeSZqVEwYBXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721453335; c=relaxed/simple;
	bh=+N+703+TWhvs5YkH8t4mSKdcvLPKSxJsHD39dGpo29E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzYjoQw4nNoPBi+KzxOZy0TZR7LYGVeUnyYPt14kwnclF8eqw5Sovok892cjOWD7HHK8SetCy35g4cU3adlyOsHEgNDilc8gdKGr8lCVkBbKBam589ZvgRzLrM/dGWHOGZJ/BFbEG05Pe1GE6ZQHZwhE5hHR9olOqZwTcLPTFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fk3S15sh; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fk3S15sh"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6510c0c8e29so25540347b3.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 22:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721453332; x=1722058132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayEKl5LCmBrAvNyTII7eFEAfQryT77n63+wGpjWzZIc=;
        b=Fk3S15sh+qTrOGP35aNRWN4WTUqb5QPAL84uAADaA0ASDyFP4k1XPdiHtBx67qa0Qe
         Zh8IzkZf+UXLb61vO6mGwp76F3u9Zr2BcCBK9Rzx7UyZiCbfLMnzXc9yWirymQf0liop
         84snockgSw6+M5YOgkeweoWYz2lTY97YTGxL7SSvaEkivAWb9i0sgYg3lq+tIEY78oVd
         oQ8ONzirZRv+5ZpKnUEYPa+J+/9lmE2MzsW67P2nMCKDVYoM4+FaZF3AYilrlfVi98fk
         8GFrxGxT4m0+DDJWz5cgk25JzsAgMKD1Oi0/iw/KATvZLNy3kXRVE8vEscT6asm+ySLe
         9o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721453332; x=1722058132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayEKl5LCmBrAvNyTII7eFEAfQryT77n63+wGpjWzZIc=;
        b=qxihqEDM405qzhFq+4dEpXN09oSMlOU6P3UMcM4Bj3dT8QPP5O2A57ilxkzz52iP79
         kxR9ug189WDCnSj5VE7qbKzu1t2TqbOTDGiDJitocv0ssxIJwMEq3FDr05C0mFjjUYFP
         pEUSCov8N2UkVA1iw56wI5BCC6coXsJEVyqZPOXlPqwNi0YY4eH7K3yakQYufGy9Ub1I
         1V4sA7Y2xLaXMyiYG/tpCLWHBHTyCvEV+NLu4KRcuSBpE4oDEJXKsTiCLvVqVAXKSOBi
         LPwL5L/Wit0ZvGca2XJdFJJqWTY+s8GEb9iuDZ6YGIB3ifaqVd2T98OXQOQkDekrPNGD
         cRvA==
X-Gm-Message-State: AOJu0Yw6OGJ9YPpHU9nornjJwfLjY/ulZfDlFcHuZDNpnDCxLdaTNRiw
	EHbmXmAfaSwfMAhY5p2Jg7gCyRON2vMpf1NDfcP1sdB3j5wWP0XVdMiwXfgz8/WtX8nkUoCTFqa
	m
X-Google-Smtp-Source: AGHT+IEX8hQC5EbI32D9Y7DbOuhr1vvTkQf+dZWETBH4bvJ8c4io9/I1WtFmAE9AySeF5TdOzJLpyQ==
X-Received: by 2002:a05:690c:2e0f:b0:664:4b9c:3e3 with SMTP id 00721157ae682-66ada628082mr5533607b3.44.1721453331997;
        Fri, 19 Jul 2024 22:28:51 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff491088sm2013070b3a.41.2024.07.19.22.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 22:28:51 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/1] Fix bug in revision walk if --exclude-promisor-objects is set
Date: Sat, 20 Jul 2024 13:28:44 +0800
Message-ID: <20240720052845.89111-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719093435.69238-1-hanyang.tony@bytedance.com>
References: <20240719093435.69238-1-hanyang.tony@bytedance.com>
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
  mkdir full && cd full && git init && touch foo
  git add foo && git commit -m "commit 1" && git push

  # partial clone a copy of the repo we just created
  cd ..
  git clone git@example.org:example/foo.git --filter=blob:none partial

  # create a commit in partial cloned repo and push it to remote
  cd partial && echo 'hello' > foo && git commit -a -m "commit 2"
  git push

  # run gc in partial repo
  git gc --prune=now

  # in normal git repo, create another commit on top of the
  # commit we created in partial repo
  cd ../full && git pull && echo ' world' >> foo
  git commit -a -m "commit 3" && git push

  # pull from remote in partial repo, and run gc again
  cd ../partial && git pull && git gc --prune=now

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

