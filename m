Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065B32BF58
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534017; cv=none; b=OH3TOtdTcBS6x5akht8Img9HcFrfevUo/ZFedgioubHFJgEryFNSeiSy/50+0U4OFAIkOIuTUliVZ+1xr8mMgqM0ekIRQgbsnMZwEj7Kr5T+EGEPAJqLXe9jvR8j4ooOEdeRPmZt4XFbLT7j+mOKvKPbR8fcN6BzeakAgHvo3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534017; c=relaxed/simple;
	bh=wAQzSoQhc/A8pW+/Xbjjh1AlNpHo3+cvJMsbk2FSF+c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VptNrhge02A4GagbcyUc/pc6BMwkbD7U4KNm0FijAB+lXEOuxk2trnZMFJS0smfkXppMID7ZH3+Y7wfjKaGE8FmufyOTQyi4HhuGFGx+co4icCYraffa60LLawkFoAfGbMJ9n/+CMxb7BaIrajEw7Kv2tJxWQ9DJohQbCvZYhqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmJg0Tdb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmJg0Tdb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7841da939deso5912872b3a.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760534015; x=1761138815; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxEKoU+WML4xsThBqLEbxk/DjGYcFZxkTyDmAEfAADc=;
        b=JmJg0TdbYUBZfJ+5mOyY5qTb3i3djvqiJY5IgCis1e7zrQ1AOO6rglEZc7nYej9gtn
         jUHU/T2ikPN7um7fLRKuYRehZTmGQF6I2nbPI/VtIbS5D3UTgTOzhAqwnmkYXhmqzBOE
         xBbj5VeWVdt/Skc9MKXcNM0ODwD/Urmtd1tmxtyB7ysbzLOjUb/U8Eu7DeMBFpNd6khP
         xoYrLhnynWGHWU+1aercsqd/QK916gJmFGppN0jkAiDyNemftDHFXkJ63zeltVZjWin5
         nMTyCAYwCIneYSD7Xb3SIAqABgonpoOp46XBYJd6vql8CsluwIExXq++4eBojriXOeXN
         ConQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534015; x=1761138815;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxEKoU+WML4xsThBqLEbxk/DjGYcFZxkTyDmAEfAADc=;
        b=FWRf60ykGan8kM6dATFPeBELr2ifoj0UMoBPjGpE2V4MRw34Lt+xZm6uUN9XdgHcUq
         1HKH5CCPwUQgaoFZ1mJEDb0RBsSPNze+nuQCub/en74zHGFMo4uMbtrlvilo9GH7C/CG
         JHe2AFwuRKB3rRTc45pjW/oSddQ01Vplb27DtW7Uw00pPZmu8r8u+Azo7w1+gz6k5iZV
         xhY2zBTSFatF87VOLwkrhfxnmdGRm14nW8g1zxqzkq6jMBmjwtuZ1zdgLsGtZw2gpz0a
         wR7F8DKjoNFESRKRFixhTIDPvbq+hFwW+ZYKQLpIGp5DIlPEXfDoUnVdW0iJkq7lHcfv
         mEnw==
X-Gm-Message-State: AOJu0YwGJSdsdMx0A8E2Q59fo4BfQk9iZO3ICldvH/zXHALYbV5AmjpJ
	VgASew4yPbf+1TJPqeiEmvw1JOXD/gWa0jrjMGpKUAoObYOBubUV+C/z/uMagTdg
X-Gm-Gg: ASbGncseeaDZta0zkLuxDp+/Bg0sVxZ5kQpsUOptMYHBRpc7D90KIxMmQ7FmZWIcS9k
	tIGP+go58CRPER2AHVQFgmNkZhT6KTcTKkov9l6JJnD1uVdVWPWUoYJREzi/F/SA4Y5UeKAH8bR
	li+0q49MQCDt0grjItmkGp15UIBk/dur/E7g9Wm92dy95G6mcPFvlk09oobF1GnRVzBHbJuwLv/
	5LGoV1/Y3LOrok+pkUcIVphIFIOY4pNUlgtxWPrxJP7R2Id6dx4RjYPuIyUKws8H+fjCyqLhp9y
	nDoSi+IwPc+M0Asr814l8oP1o8dPU64aenBI/BBfHf0YXaOpScqdUsq/A8uayikicWZYGnweHzi
	lIJ6BTNHMc0Fy4A1Fd+0T7uKMJhAvYqbvga3VxrmnHBw4FaYKzRoY9DV8eBC0uQ==
X-Google-Smtp-Source: AGHT+IGsPw71KT6QUiKCRK5wLNBoYMkc9ns5rLzVXR4VysjNILmL+IEeQss/UnxWesag/g+QzM+lmg==
X-Received: by 2002:a05:6a00:1402:b0:781:17fb:d3ca with SMTP id d2e1a72fcca58-793870524dcmr37948196b3a.15.1760534014871;
        Wed, 15 Oct 2025 06:13:34 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc12a8asm18690019b3a.34.2025.10.15.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:13:33 -0700 (PDT)
Message-Id: <96b2673e04ea151a2464fd960fac0db8c58ab8fd.1760534011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:13:28 +0000
Subject: [PATCH v3 1/4] doc: git-pull: move <repository> and <refspec> params
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
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

