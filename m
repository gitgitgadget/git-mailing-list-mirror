Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F82D46DF
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531676; cv=none; b=PYjYBxx2lSnCklKydjJypBOl3ocr6wyOguXtw+lbkPpHHWBXZ5PXjmRts3rZOzTlH+3Nm2xELOeOHN/KBDlCUkd6xclhQPsALyHizcUGchAR/Qqdkl1USrjTku4UK/d6jZ71emDMX2UVjQXGZg69lTKG/iwPN5768PcEJUfjqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531676; c=relaxed/simple;
	bh=8MDZDK7fM61f1y+JRx1AeT0qdYmS/u62ZCcFx/iynkk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tq+o78GN/Ons2VFBup9CeNaLYz6fd+3gSLpMToAw66V4zXtlduvDbZkP8IOaOkMxhQVQeBkrkLhwXXgvyhmp4Pi9UYPKxwyxTDIUZUsOi5WSBpd+WmtuYEGcXipZUkA6P88VufZdSxn18sIokiXbLLxzle4O5RqAAzuSSSkiWu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXuve10t; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXuve10t"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7728a8862ccso1049062b3a.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531674; x=1758136474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXLBMf1LT1cW6FSgy5AnlMhiDWnQk8CYn8okt3F32zE=;
        b=OXuve10t7ptsQNibk4oqAIgZTHUhaaX+178d3tDtT6K87MlQHDvuJBgoMe9Q4mJg6Q
         RkND2KVXRiKIjBmD76QLUFlRisX1EWeydVLomS/2i3kEWB0vqY7VQslTUCHeCoAZx7G2
         sXmP124gbqpSZt5exCWNHAQ04x0JaZjc0K4CDj/64Wenh9H+zPJvf4m/i4oKkd7T3pbz
         0c4vDAUvBbjWW3LqnpGNwnX2biv3NOmY32IiOrT+DPVxEMm23or4ZOXxoSKRk8JOXiaV
         xylewYMdHjjDYMC6rCm7LLPL4z4dM1Za0+l5LRVgfgBENOb8LGQIyIRpube3FxcCg0/Q
         VYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531674; x=1758136474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXLBMf1LT1cW6FSgy5AnlMhiDWnQk8CYn8okt3F32zE=;
        b=fPzcHN2XU4ilIU/BuoIHyj4+rXJn9yfTBh6Y30dHyIbDu0LanSJURzMw+Ku98bF8EC
         q1rtbWjaZlNOHxGFuq9GEVvJGBpakPllw0bww8+RC0NsHyYPJN7Yog2okb7A13J/rgCD
         GBksbDhmdjBHPSx3EYOK/S2lgOfNouVGEGj3mwzkQGxhWlKvZ2eCPyNem3pxePjbEqFP
         kMZiEBpdrOEgvJGU8z9bsHaqA0d4oUMXVJpl3WDN2ITgggMWeCfdzEyOeCzhXPdiRFJB
         2PoyY2WBZUo6tz3NHr1I0la53aoa8bvfoGXsaagoDO5Oj3z8xYNAmlHvYVrF7ClflXKv
         1OfQ==
X-Gm-Message-State: AOJu0YxxPGKtRWcUZcM1F4RY/SIF0qloYYf/1yqcxAfRkwU521qFtEDg
	1GaDooBudgUs1o4dyed/hLIbQhcun6oIBZPX/SUHgywQE3GGLLkhKYjCwNM/lA==
X-Gm-Gg: ASbGncuZbkdt51W09i5j27o48arGtqzx0jAei4E4BgjpmMiJ3n8P8dXuYhtztV2V02V
	HpOhgwVxHJBSikDFEQeH5W4naMau18lYhqDcdU6cB+ownAkJgp4AoKq9HS6Ne/euHyA8Rg8zJTv
	RPHfqAERNDAPDj+GrjCiBhxr9FYSxC91UpGLoOl7S1T+14/1BN3dqPSp0cdUFWfMzWsnH98zUyg
	Wx6Vlp2iqG9YwL7VVholDPgEhmqx2RptlbMQ6XYLBKmO4mYFpy8ELFxrEsM+rAP1tlhnx50upBn
	azLFcFoV4C7ijrNINonKIY7nSi7XdxKDM2I/9ch4LmJElefaLVP5UuWODdbGN/OoMeaZF/hrgFZ
	rEolB/rb5IqLYaE5k4UCaJSfG/FCQGUaY68ZY0g==
X-Google-Smtp-Source: AGHT+IE+dsn7+pmBVXya6IP/+sVuNFJAyqTfbLUSdFq0383B6Bk4zQramzB9Zpoja0w9H2L6AgkYPg==
X-Received: by 2002:a05:6a20:7287:b0:246:273:1c67 with SMTP id adf61e73a8af0-25cf704f7f9mr913864637.18.1757531673896;
        Wed, 10 Sep 2025 12:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a3f4df2sm3418076a12.3.2025.09.10.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:33 -0700 (PDT)
Message-Id: <08f0a5efab9d5dd57e1a49d00664e9453b6413f5.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:24 +0000
Subject: [PATCH v4 2/7] doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
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
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

There's no need to use the terms "pathspec" or "tree-ish" in the
ARGUMENT DISAMBIGUATION section, which are terms that (from user
feedback on this page) many users do not understand.

"tree-ish" is actually not accurate here: `git checkout` in this case
takes a commit-ish, not a tree-ish. So we can say "branch or commit"
instead of "tree-ish" which is both more accurate and uses more familiar
terms.

And now that the intro to the man pages mentions that `git checkout` has
"two main modes", it makes sense to refer to this disambiguation section
to understand how Git decides which one to use when there's an overlap
in syntax.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 9733c73450..d6f4044a09 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -27,6 +27,8 @@ DESCRIPTION
 2. **Restore a different version of a file**, for example with
    `git checkout <commit> <filename>` or `git checkout <filename>`
 
+See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
+
 `git checkout [<branch>]`::
 	To prepare for working on _<branch>_, switch to it by updating
 	the index and the files in the working tree, and by pointing
@@ -513,14 +515,18 @@ $ git log -g -2 HEAD
 ARGUMENT DISAMBIGUATION
 -----------------------
 
-When there is only one argument given and it is not `--` (e.g. `git
-checkout abc`), and when the argument is both a valid _<tree-ish>_
-(e.g. a branch `abc` exists) and a valid _<pathspec>_ (e.g. a file
-or a directory whose name is "abc" exists), Git would usually ask
-you to disambiguate.  Because checking out a branch is so common an
-operation, however, `git checkout abc` takes "abc" as a _<tree-ish>_
-in such a situation.  Use `git checkout -- <pathspec>` if you want
-to checkout these paths out of the index.
+When you run `git checkout <something>`, Git tries to guess whether
+`<something>` is intended to be a branch, a commit, or a set of file(s),
+and then either switches to that branch or commit, or restores the
+specified files.
+
+If there's any ambiguity, Git will treat `<something>` as a branch or
+commit, but you can use the double dash `--` to force Git to treat the
+parameter as a list of files and/or directories, like this:
+
+----------
+git checkout -- file.txt
+----------
 
 EXAMPLES
 --------
-- 
gitgitgadget

