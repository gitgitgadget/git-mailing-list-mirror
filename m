Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8793264C7
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627126; cv=none; b=F24BAthMevE8aHbBgtWtP28mzBhmNLCKnOBDcKwr1UTV0XKGkXIlotbnyxWmgNOO4ZGZD9ggV6BcqNzsNs+N8GcXUaG187zk0TYC41mdxU9q3PT8tfhHL8B918f0o35O3eYLGvT5c7P1DdDUTcHy7/8dgHEhXJxjpaxLQz6BCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627126; c=relaxed/simple;
	bh=KaRodkphrjFWASOgrTQKOJnMcdtF3OULtZZOMOA4ubM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=CS3XF26EE4Bt/FikbMNc8NawSfdAJH6fCp7RjyYEMlxuuhndaRGuqFJES2+/R1OWRwDDaKaoL67QAv971Bt5v5Wf1R6scFIKQmPuGCA80y/iSxSwewtQt4C3GpVLxLwCNVc99nirps5cuvrtOOiGx1ShlPK8aiBOOlp//xZj8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDxpQfIp; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDxpQfIp"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166b8fso232146085a.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790627124; x=1791231924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lLGA+5Hb64d0lIv7ipPCDyzN2+RlxBg9YGdeHYNsDVs=;
        b=GDxpQfIpshe0MP586b9jn55dS7wBPNbF6WsaEgx+n69p9o+mZvd0ZGfHDrvHO6r/Go
         DGZgO3aaouz03QoxAAo25EgUcwRmF9OFoOjO8VhaWW0yxtojAXc7Ow4x/gUrt4cllqt/
         fGlFl5jLAxsSH3f5XeVMeCr9c9+UyCuigha0tpFwjP0Pq4R+MnoyV1/bwfaU+NeWe1tY
         5zhFWfqbeYwdOO4+1WbgMghEwFlmPssEZPEhAaWgeIZhNL2Anka+HqAub/WzE9KA919V
         Q7wn7+Sw/LF6Ux1VRhcUVr64gmsexnr7FbPyCGit/ce3vaUz6TPncRM5c2BbgtS/oo36
         sFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627124; x=1791231924;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lLGA+5Hb64d0lIv7ipPCDyzN2+RlxBg9YGdeHYNsDVs=;
        b=u+Ln5z0Qf0yaGmvPoIr1uzVRYO7vp8aKzj2jpVcBPD4Cy50RZ8CIQPmpzd2JOv4ILn
         Q19U4QLEFMyvnZ+fMml9uzW9rYKHEYDw4R0r61pkfOFipB+fuWjww2uq5qyZbACX5tfK
         8lgjNiJmKWZOc1CIfS0QWt++Sfym6ZzEqv6uB3IpEtZp9Mvy3AfrGMMwJU4WWndRuW6G
         evIZkC4WN+QB3LwchdN7ZSh48w1RmJkNiJ0kftGmDqbTN/d6PdYWdBNvC/+jmEVO5LvR
         ropCedOobux2oAnDEJovYpnezLDzcTUbwkYzpXAOq7UtLw5rWcxVPa7+oGldgRUUWJF8
         OT0w==
X-Gm-Message-State: AFuF++lKwNdfUM0Avtu4agnAIs/T0QJQw7EeKd1yGzzQ4C/skZcRApZk
	Xae1YikdW4SUYtu0QvtyOcKdQXMgo1lJwNa3kBdB6WkpCHShpCgCDnsg9c2GPQ==
X-Gm-Gg: AYBFou1WXuamXT5hae5+yyzDyB0MXLRvBr403MHq0/uhnbg1UWv6Sasge8XnyXCDua2
	bX2KUz6Z6DRKM/zlbdt3lx7xnr/I23QqC+nmN43HWWj/d3ozJQWxUP+ZX0bDDwI1lJHBhFu5/hE
	tIGUqEG/8wbtdVMYwwHEvgqF2644CSE24CvfZmscRbAo4oTC+ga/JyZoQuLx1GjMV9ShYSqXBh1
	Djk+/fb5Bj0nOQx987w9I2sWARMxvSrAnd6ttyOY364RhpqNgDjzSpCw25m+pU1Ev/qnhVS37Fy
	nH8noQMH4du9RUw5VpT7mneShQZIO2722wYtD766KaUkHPVbHG+VokNm3FQasSIil5H6eY/JeC7
	27LsxTbVT3ZT7SjHG6I67RQOVBLHJMNilkZDiL6DL285ljGd3aJJT9cuSuyUfGzGaVKBk7tcZ8+
	B/sJ9L3q+67acm43MapN+I8kSqFats5WbaAY5j/yj1srY/qK1fk8Y25h4NFZWSeWNhoXqziUL26
	A==
X-Received: by 2002:a05:620a:3190:b0:93b:d7a2:dd2b with SMTP id af79cd13be357-93c43d2e555mr2303955285a.59.1790627123594;
        Mon, 28 Sep 2026 13:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.79.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dd2858sm88311116d6.21.2026.09.28.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:25:23 -0700 (PDT)
Message-Id: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 20:25:19 +0000
Subject: [PATCH 0/3] [doc] Remove gittutorial-2
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
Cc: Julia Evans <julia@jvns.ca>

This patch series removes gittutorial-2 and all references to it, leaving a
stub behind to help out any users who might be looking for this
documentation.

The goal is to remove obsolete documentation and make it easier to improve
our tutorial material in the future.

I tested that the docs are staying internally consistent by running git grep
tutorial-2 and making sure that the only remaining references are in the
Makefiles, the document itself, and some example output in user-manual.adoc
which isn't relevant to the actual manual.

Here's a pointer to a past discussion:

https://lore.kernel.org/git/7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com/T/#mf600063180d6239916e3fa6e9d33da86969547ec

Julia Evans (3):
  [doc] Remove gittutorial-2
  [doc] Remove references to gittutorial-2
  [doc] Delete translations of gittutorial-2 description

 Documentation/MyFirstObjectWalk.adoc |   2 +-
 Documentation/git.adoc               |   2 +-
 Documentation/gitcore-tutorial.adoc  |   1 -
 Documentation/gitcvs-migration.adoc  |   2 +-
 Documentation/gitglossary.adoc       |   1 -
 Documentation/gittutorial-2.adoc     | 422 +--------------------------
 Documentation/gittutorial.adoc       |  23 +-
 command-list.txt                     |   1 -
 po/bg.po                             |   3 -
 po/ca.po                             |   4 -
 po/de.po                             |   3 -
 po/el.po                             |   4 -
 po/es.po                             |   3 -
 po/fr.po                             |   3 -
 po/ga.po                             |   3 -
 po/id.po                             |   3 -
 po/it.po                             |   4 -
 po/ko.po                             |   3 -
 po/pl.po                             |   3 -
 po/pt_PT.po                          |   4 -
 po/ru.po                             |   3 -
 po/sv.po                             |   3 -
 po/tr.po                             |   3 -
 po/uk.po                             |   3 -
 po/vi.po                             |   3 -
 po/zh_CN.po                          |   4 -
 po/zh_TW.po                          |   4 -
 27 files changed, 14 insertions(+), 503 deletions(-)


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2241%2Fjvns%2Fdelete-tutorial2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2241/jvns/delete-tutorial2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2241
-- 
gitgitgadget
