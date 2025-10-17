Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC0255E27
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731569; cv=none; b=RUbIqMVJd190lmJq8fLWwhwPsoEdWup8HFQlo5gulZRfczKECRyAsMIcwqqyNvyAK/yO3uv5TikMqr2iIyTyUYpIyjNbJRHXXa0Dt3Xdl2N4McxNepUoOTQSdynKqzpjFHFBq3UcAi6cKIJeV2HQB9kYIKoSFwx9F19VnmhcB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731569; c=relaxed/simple;
	bh=sDZGwNvgNs1SdqYPZJeLFu8/bfB2dUWF4nIudgH/KXA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V/wDidshUaz4vPkv1i64wVQuevsLm//iyeN4YC/eikGiqtW8GfMJg2ZxHs3pCg+L7mWrYhpWM2p7bjPi/D2P6i25t35N0B9O6wQPABTS3I+kD1BpTc2ud9SGFCY6M+hUix+XsMpb5g+tn9QebnbD6/p3SD4/4n01ENUgHfdG1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAKERV6f; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAKERV6f"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78af743c232so2064608b3a.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731565; x=1761336365; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LroRuBFfUMFkgn7juYJ9dL/YD37trb3sE+GzPgx+Mk=;
        b=UAKERV6fYOzY9HNrfMGiPdfi1w+5C4eoDbHNcm8pCHDyzeQa1EHIr9hmuBr8K2RvYC
         G2m9LkSsuQ4rpFC4ZJJ0cQwls7V2rEqlfVVoJ3nbnVzcNFfI/dykIxLcNH+5vx1Wa52A
         ndhiC4y4ACKQTnv2RYB+eEaH3cNHLfNgUz0QVJH0tOFxHA9w9ddPtjdbCV4P8W9FaLi+
         oILzJedOf0m7j7wh45VekmrWD05QzgIKX9D0TU0rdsaRoZRvJtkKV2+iF9OAynwo/g5E
         Yb2sM8XcE03l1iW5VUDQFVNReY6XHtL0QO8f6qApJ2Kea0C18HbLV57kEAEfwZKJhG+l
         WbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731565; x=1761336365;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LroRuBFfUMFkgn7juYJ9dL/YD37trb3sE+GzPgx+Mk=;
        b=Cwe45B5p8qbP1dYpgfmPBkrwB3lJKxHYVaoeFpo911J43rR459ZmpYEvoGt2ndxNhw
         EBE95yQ1/sjEGyXf3JwBYERaEsgZ2XRJIL15MGO3JKaYE2HBfYMySK9SbqC8ofasxwUb
         U42SkdWzzl3rMQOYXQ5zb7dTTbV1kVbpMW/q6OWmnKL7tgUIMQuHoTx3owkvDMgy35s6
         jB2tIiiO9YqaKN3svBvWdzmYCoyeIslNj7a52WXMUZ97wLzQH2Fl6EkkNy9tVAQbim2g
         mC5a0nleXQTvxQw1q8NYIOb6YrA//PfFVNrjWRRangG76BlydnSAgcKfRdT8cnPiuCpK
         r7Lg==
X-Gm-Message-State: AOJu0Yz8R3YrlTIYdSy+2oNyMg7j5RF4uWua2EtHMbTeI76lq3a8Cy1p
	gowQe8+VKkQUXUrB79gh0Sj7ykBz/WWYae9L7F0uKJMOIi+YQBMlo92eVuMWmL52
X-Gm-Gg: ASbGncvYB73yqEff2kqPaT0UdVSsCQmcLLkESS0W8xRky3IciDd6mdbCyRwmsKgojF5
	at/0JFQCoSio/cDKNVm1LxSBQ73cX0BZq7y5vyW8ZDWlCULuUtT3wNU1Jr6VhMBamc6aVMLjyOk
	JOHD/d2KYq0WuArw9ZLc1GLnmoE4sTdYIhEASGjp+LVBGPUwR8BLk19lW/WBJ74SO8DbduBRqFF
	8vjmquAYaz0/NGjBWUkNaMYlRfaRmr77QZHcd2pECVIzSDL9JWjd4zNeAAZdBdry+pIaB1trJKe
	o6B2XzfbRWVCjfK49i4gJui8tQx5N6g+bJvQrkCbHykm0dNtdDj8/iYFPkldVrfWLForrm3fkQQ
	QjQvooVbV0wAnKe9BAp1IuGQZnSzHuGipNR31UT83vECvP3N0yTLhxs0u6cxkbcaUZ3a9KeKxyQ
	PFLb4AT5V0NiZG
X-Google-Smtp-Source: AGHT+IHnkgvdd1lsrnWB1/dMwcYAMilTjLH0AgSgN/leMP6KJd5rzpTDD1EOhZT9gY5iwISGebIfZw==
X-Received: by 2002:a17:902:ea03:b0:28e:7567:3c45 with SMTP id d9443c01a7336-290c9c897damr71773715ad.9.1760731565254;
        Fri, 17 Oct 2025 13:06:05 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5965sm3575265ad.75.2025.10.17.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:06:04 -0700 (PDT)
Message-Id: <0be166483f547de866744917e6cb19eed13a8088.1760731558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:05:58 +0000
Subject: [PATCH 4/4] doc: git-reset: clarify `git reset <pathspec>`
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- Continued confusion about the terms "tree-ish" and "pathspec"
- The word "hunks" is confusing folks, use "changes" instead.
- On the part about `git restore`, there were a few comments to the
  effect of "wait, this doesn't actually update any files? What? Why?"
  Be more direct that `git reset` does not update files: there's no
  obvious reason to suggest that folks use `git reset` followed by `git
  restore`, instead suggest just using `git restore`.

Continue avoiding the use of the word "reset" to
describe what "git reset" does.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-reset.adoc | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index fa4bb2b551..52d380a756 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -79,29 +79,24 @@ linkgit:git-add[1]).
 
 `git reset [-q] [<tree-ish>] [--] <pathspec>...`::
 `git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
+	For all specified files or directories, set the staged version to
+	the version from the given commit or tree (which defaults to `HEAD`).
 +
 This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
+<pathspec>`: it unstages all changes to the specified file(s) or
+directories. This is equivalent to `git restore --staged <pathspec>...`.
 +
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
+`git reset` only modifies the index: use linkgit:git-restore[1] instead
+if you'd like to also update the file in your working directory.
 
 `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
+	Interactively select changes from the difference between the index
+	and the specified commit or tree (which defaults to `HEAD`).
+	The chosen changes are unstaged.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+you can use it to selectively unstage changes. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to use the `--patch` option.
 
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
-- 
gitgitgadget
