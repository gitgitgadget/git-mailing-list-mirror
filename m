Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B094A06
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951541; cv=none; b=jGzpRVj4G3lJs1UaYyLi9b0G5I1Cqe82BCovjzYDk774Os71e2GHE7EqZYCnRfMtJzZbKdRK9qZBmh9AJ07Qnv1hCkjA/h/RFx+OZLQxf2EEQcrpiuyX4h3u/Cwwc9m7NyggGyQqYLUPxNIvVw42Svu2iHbrfYJiyTwo+5rHugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951541; c=relaxed/simple;
	bh=wAQzSoQhc/A8pW+/Xbjjh1AlNpHo3+cvJMsbk2FSF+c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D0ZY+yDHaginA1r80ofNx8oyXE0dtLRS6P8KryNZhTnzlm2WCWhEsZHlU0rq2q3tlFCDhdO/RgvgDE+/qm1KswvgdKhh6aVfLx2cOeKEhVvI3zjMzIyznu/jlMYoA40r3JmdXd09hjVRaVC0YVqKL4BA9JXyO5D9IwFfGAxFUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHIJq85P; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHIJq85P"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b62e7221351so114580a12.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759951539; x=1760556339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxEKoU+WML4xsThBqLEbxk/DjGYcFZxkTyDmAEfAADc=;
        b=aHIJq85PQIu2LQx21MrHVsXTzX1rRBIKu6QEymddaa7xElSzj9J5aaDkg0uqEAYg/F
         HELWfZqrmLxVJOE1CUexqG29xJTYOQqybPzV56Mesammu3ddx2wLTJLUsLjw5z4lw6x4
         HV+79KURRv1KZ/0Xuz1EfX4XXqVyr9inWDVNtlwTjr0iyzi572BxkYKoEMRa3qCfAHVL
         YtY2YezekL3DbjXJUkU9zAqomQSJsF9D46LUXYvWqqrmkgOV/pnGVqRgrsxlGYsHo+/L
         RyUdhCMlxZisTBCURZ0YwyLw8JY5K+aB2OsiMK9JS/ZxePLfrDSmCq22J/tTMrNfB8kV
         URzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951539; x=1760556339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxEKoU+WML4xsThBqLEbxk/DjGYcFZxkTyDmAEfAADc=;
        b=YWm2vLGtD+mfOaYp90cidNQfh0v62e6XDMu9z3yrcpwIuLw3c70fhq5W+wONEu0TZW
         NZ5mv7EDfro8uNyRWeFOj2wylqaD/xTtLpYQ9JdwCgwW8wtyYe1Xcwaow9i2Zx/YoIv8
         n4o5IiCnjCWq5ljTGxDS2WKb2Bn00wuGiotkBm3cYLvn3K0/SmdNVqAkLRJJptOgXvdO
         xab2pQ4YVfzFJCvMkEt5qA48yya6E9cC3fJ/oHcR7X1Cf8+a/R2873snWhPVXiZlYbYG
         f/j2X2dke5Pw/dU0//yBmo25V38QZpNNW+pXO94TKKvDutz7/V8eEjWrJp0oA1yiZLIM
         3Pug==
X-Gm-Message-State: AOJu0YwuZqKLgvsfd+ZuiViuLvC4A2vzOAR7koFB6kIg7t1FAgbg/hxA
	SALn98imhc0RSonvh9QHJV3P1FD55/48cP+QM9mVJIeuUPIizJrntUGsRUHLHw==
X-Gm-Gg: ASbGncu/uklE7aY5TEaB186nUDw2v+ipoF+Js+dMDWzvjfWWEMdPuur2XJlhEDviRkT
	vxr+3O3Fd3kpRM81U8Yw/lBrT7P+cwfVHRl2/wAgpmFpy5LlHj0P4Twoyh4KiN4frVBYT88/QJA
	WPGWELL4NSgQs+Z8tPLxhqB5xvqPby32XCFyavSYtPVgkUygknwFqkuk6QmkenV6YsbVswo8gEn
	KjI9efOvdZVp5U8kcIiPQY8hjDbSBM6h63neRAvaS7AbTTybNo6PfGkHcUxcxDUuzW8PY4t4qGG
	4zkxKlugiJT9uTWm39/hDxg8GAAK1JkH1y/nYY8vHMiZjGib6gv5j+02AcRYCcMBiCax3557irs
	wAK7sJfgfK8NWn0c+/7c7TZ+UyyPv6La5GfIozO8HsGwFowzfKxg=
X-Google-Smtp-Source: AGHT+IFpeyroMKHh0pPblKzL0VUnBu+uqYU7oFkpDV57bvjf5n3YFPSSgno9DZuMWJ21lUaUNClrdQ==
X-Received: by 2002:a17:903:238a:b0:27e:d4a8:56ad with SMTP id d9443c01a7336-29027327499mr59955565ad.61.1759951538932;
        Wed, 08 Oct 2025 12:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm4855285ad.114.2025.10.08.12.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:38 -0700 (PDT)
Message-Id: <4cc87ec354f7b9ec599d70046f3263363546bebe.1759951536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 19:25:33 +0000
Subject: [PATCH v2 1/4] doc: git-pull: move <repository> and <refspec> params
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- it's confusing that we use both <branch> and <refspec> to refer to the
  second argument
- one user is not clear about what `refs/heads/*:refs/remotes/origin/*`
  is meant to be an example of ("is it like a path?")

The DESCRIPTION section is also doing a lot right now: it's trying to
describe both how the <repository> and <refspec> arguments work (which
is pretty complex, as seen in the DEFAULT BEHAVIOUR section)
as well as how `git pull` calls `git fetch` and merge/rebase/etc
depending on the arguments.

Handle this by moving the description of the <repository> and <refspec>
arguments to the OPTIONS section, so that we can focus on the
merge/rebase/etc behaviour in the DESCRIPTION section, and refer folks
to the later sections for details.

Use the term "upstream" instead of 'the "remote" and "merge"
configuration for the current branch' since users are more likely to
know what an "upstream" is.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc         | 32 +++++++++++++++++++----------
 Documentation/pull-fetch-param.adoc |  1 +
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 48e924a10a..a3d248dd1d 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -27,17 +27,6 @@ and then depending on configuration options or command line flags,
 will call either `git rebase` or `git merge` to reconcile diverging
 branches.
 
-<repository> should be the name of a remote repository as
-passed to linkgit:git-fetch[1].  <refspec> can name an
-arbitrary remote ref (for example, the name of a tag) or even
-a collection of refs with corresponding remote-tracking branches
-(e.g., refs/heads/{asterisk}:refs/remotes/origin/{asterisk}),
-but usually it is the name of a branch in the remote repository.
-
-Default values for <repository> and <branch> are read from the
-"remote" and "merge" configuration for the current branch
-as set by linkgit:git-branch[1] `--track`.
-
 Assume the following history exists and the current branch is
 "`master`":
 
@@ -77,6 +66,26 @@ pulling or stash them away with linkgit:git-stash[1].
 OPTIONS
 -------
 
+<repository>::
+	The "remote" repository to pull from.  This can be either
+	a URL (see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
++
+Defaults to the configured upstream for the current branch, or `origin`.
+See <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> below for more on how to
+configure upstreams.
+
+<refspec>::
+	Which branch or other reference(s) to fetch and integrate into the
+	current branch, for example `main` in `git pull origin main`.
+	Defaults to the configured upstream for the current branch.
++
+This can be a branch, tag, or other collection of reference(s).
+See <<fetch-refspec,<refspec>>> below under "Options related to fetching"
+for the full syntax, and <<DEFAULT-BEHAVIOUR,DEFAULT BEHAVIOUR>> below
+for how `git pull` uses this argument to determine which remote branch
+to integrate.
+
 -q::
 --quiet::
 	This is passed to both underlying git-fetch to squelch reporting of
@@ -145,6 +154,7 @@ include::urls-remotes.adoc[]
 
 include::merge-strategies.adoc[]
 
+[[DEFAULT-BEHAVIOUR]]
 DEFAULT BEHAVIOUR
 -----------------
 
diff --git a/Documentation/pull-fetch-param.adoc b/Documentation/pull-fetch-param.adoc
index d79d2f6065..bb2cf6a462 100644
--- a/Documentation/pull-fetch-param.adoc
+++ b/Documentation/pull-fetch-param.adoc
@@ -11,6 +11,7 @@ ifndef::git-pull[]
 	(See linkgit:git-config[1]).
 endif::git-pull[]
 
+[[fetch-refspec]]
 <refspec>::
 	Specifies which refs to fetch and which local refs to update.
 	When no <refspec>s appear on the command line, the refs to fetch
-- 
gitgitgadget

