Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66177346E44
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841726; cv=none; b=QqoodvkH8DukeRw/6iHTQpGtJKIOzckEpsIOPrHdTD7dMXYu5WJp8lufmXgI+pbMG2zR0t7Ya9XUuPMeYxth0bdJJsok4Xx/vbWQM6aoedH18lSZykvb0OfMxLZv1Zpoq30ZEE1/VmtLyCYiumdSKrvgGl7B5BT/zJRdQFmRN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841726; c=relaxed/simple;
	bh=AGTjJ4njci0zupOax4HlTN8H8ZTcyOe06xZxp9ThD4I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rDA75oCQxpNKAghQZ2NZRbS2a8khMcEGixV8eRzVwc1W/GpBR72KcpQPr0ndNxctC7t4Jb/HYqtVDiMp5SsrYV5OHNqv5dBFCPyPJG++rJhC8s0ewM724dOyAacU46DB1dKDnwBjXedhs9HBsXUQtbhUbsk2vcnlCBY7AVxy2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiA/ANX5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiA/ANX5"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-934956bee57so237898585a.2
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841723; x=1788446523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8TXffpdy1uCzS0D+NJX+pRwVVNoIqRCcs3ObM3P0mkw=;
        b=NiA/ANX5xUl9njX+sv4fYKH62y2sWofKVfESALtJ4xD6E86KjYNM2C3MgimEpvbXbY
         3oEhjrtP9QSiYK1gXsqFf1jEK/0NSij1Wzst67hH0TwBbCi1qUcpm//sdfjupmYk1lej
         BmbWUi8fAQi4syguR6RK0LGlzMSPWI53j0/tb1PbC1lklxW4aKC6dfzA7EzJN/sgUqPM
         9ZXN+iDUsb0EFUJ+gYQQQZI1ZVPuxmTzIZNNcw30nCwwaJZXzy3WPQBbPAsFA1hbN6Q+
         E2N8iJ1KZjfVUMyN12MIgVP1jUb0KVKA7x6n+UQnHtVH8rmFQq+NXik3xmhZMcF/uOXZ
         joCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841723; x=1788446523;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8TXffpdy1uCzS0D+NJX+pRwVVNoIqRCcs3ObM3P0mkw=;
        b=Dv0qc4vnsNAGYQwR7EczSi9mojDYPZubPQX4NHXv4h6nFCtEbLQzLRhtrCtpotRE5g
         wDvBohLYMt31KFjeiJMm3y0mLKCUpwd4PZJRlRNxh+2fUKGjmaMThEiSzrODrenNRaRy
         ipBUFUYkAyy/qObJGNtufpCq9lrPsebelQeFJQZ2aysT79N3DBt/jI3yAW0NHg+iBNKR
         xu0cFB/K70CqhQvc7A+sLTWIs1lqtVP/AS9n7l3miwCbY+gqsoRrLWmGRBQolRrMZ3wr
         fkpZ4idtoNt7zsJZhguNmhUg37rMyiL3zhd8+anYOSVvjzIsMcuBBWelr8GFzS2sJTZ9
         kP6A==
X-Gm-Message-State: AFuF++nwS7LXXqRL6+7QhU2i7jHK9r8XcaEmT1MlqmeYQm+/S32967Ka
	HA0NU1S+ekEHR2kQi0a2XMSAEhikEKzrH84YYPifAe1S2BqXRNPe7J9mfo3iQA==
X-Gm-Gg: AR+sD127m4vQtV7L5Rg3hMAwbLwh+rAM/jV7eDdbDsAnoy/TIAUYTuBexYl1PRMbYvZ
	rGq7Ia/MAXYH84t6ac1hYN+ETOIKbEWWZZq0Y7SU1aPz/QQnNf++cldfH8mFnXI3eh9tXvvS8nd
	7MhqNbRL+NtHfTtMT27gz8x/u0g/c88Rfzg+Mkp66BzuJV+c7Xz53Nxa6nafCRq6qJ9gxrJkydm
	QPpj7bMYlzVoM3lZZ0NqvrOZUqZiX710Ch5MrqRoUJLqa5ZawFlDKQ3vMAfbY3LdEFpWb6Ijsqe
	muvogThTGsxYEAnlBNREiTVyB9eqoLIidLxw7hRct7aDV1N64gL575bmeY82CAW9gaXLPA9PZwM
	A4IDjV97zGlAXy0yZKR/PeSt5qLzBFiLz6anoCzrVB+1umqI8/TJiFAOZAysMesSYO9Z29llrCr
	I7Ky5GQG8aMvrDgFOUbwbtJtP8XbN1+St/RrRUc6eCM7mmKf7ls2H4huW004zRkbjv
X-Received: by 2002:a05:620a:3198:b0:932:df7e:b31d with SMTP id af79cd13be357-937801be91emr1402822285a.12.1787841722199;
        Thu, 27 Aug 2026 07:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93904601cb7sm162472985a.18.2026.08.27.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:42:01 -0700 (PDT)
Message-Id: <35814b47a49d7e6c0b3f19e8bf179f0bc7be2117.1787841717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 14:41:56 +0000
Subject: [PATCH v10 3/4] worktree add: improve message for ambiguous remote
 branch name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' without
specifying a remote, and there is no local branch named bar-topic, we
try to guess which remote branch bar-topic refers to, then create a
new branch named bar-topic that tracks the remote branch.

If multiple remotes have a branch named bar-topic, we silently gave
up, leaving the variable 'branch' intact.  We then entered the
conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered an "invalid
reference" error.  This error message did not provide enough
information to resolve the ambiguity.

When multiple matching branches are found, display a hint and a
descriptive error message and die immediately.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++---
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..c745deddde 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -764,6 +764,25 @@ static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
 	return 1;
 }
 
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static char *dwim_branch(const char *path, char **new_branch)
 {
 	int n;
@@ -898,17 +917,29 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			struct object_id oid;
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_disambiguating_remotes(path, branch,
+								      &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget

