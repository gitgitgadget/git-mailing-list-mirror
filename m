Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE4265284
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918209; cv=none; b=AsAdHehARJJ5mbePReQLkRf13muxEYHti1Ns8NWwDro0tDfaE9wjRCCKAno9t6Gb2T/yjSK1vUWG0YMNS6EUosjtfd9lbajUiOT1XVG9YzD5qfTTaZZ7jlbWPE2ztF5g68SnAhJ8ZoOKC6URsh9rTMk9pT6b5wvUPhIxilnlV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918209; c=relaxed/simple;
	bh=htRgc6OwRYtQMs0Nt9TnTJBvvJY+YmPNC9WeohvPEq0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q+PD/qnCjK2kPaXCO/waELZNDW/Dz5gdbXkSHDaG0KiOtzyOhhBPNKnLZpBF3tUvjUKjQySG9kf08Ji60gr6iyc5etTL/tiKs5Y4I25cBQ+lC2x64yfsGQJjUjFyxJ/hHeTIaKPbOCIATTmYJPugozk/ICPhxJxz9I0sS6evxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti+k9yFB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti+k9yFB"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-72374d6a6caso428326d6.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918206; x=1757523006; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhO6iEFHkP0N+zM5HLK+UdikETY/1CzzZbT9N+SAcac=;
        b=Ti+k9yFBPUvNYpozdOY6BV4uoZj0pKRh/zuTeZl17X6agHYMcFYX3aigNf0B4WIVzh
         15vUdQ9Hp/dRqCJSWWwgMq8pQ0jEoNL4dymvWMn1diJHP8q+8DtMl8lJ5hx89prj7bnQ
         Bem4Onr95RT5B+ZOb2hllfC2ihrRl4+++HHJnq9aaf9sbM8KUekJo6dOlasomNbrOyNo
         1u9880cBKCOsw2YVdBWJoq4GiVKQ5RBgKeVCZLEnDeQUDoa9bGppE9ZT/0L1iuho8Dbk
         sz2jwZqHpjSFnfQqpN7z7VFit7a1ZKWJYlP+J2/fDgDesjrggV/HGjGMFAWd5QLkjtUX
         KRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918206; x=1757523006;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhO6iEFHkP0N+zM5HLK+UdikETY/1CzzZbT9N+SAcac=;
        b=da6hjqt/CAkxIfvoTAjVHM/3SIGmRV4DR6rRihXKNW3AuKi2zF0YLAwGMWZuVQm7Ko
         DG16vW5Xsi1NRXJgrtl6Rso3igrX6FADhQfIC9wqhSFWzXk9BbL1LKOus8qoqN32N+W6
         XZ4GoA2fDs7nOkyiHpeE4yl7rKGNWNUu8Jc61VLSLlMK7AZYmf4pTWKgKJCUqMcdImw4
         4OwHfbTKak9fsPA9p+xG/cpBlW5ABiOPdymAJduPGI+BWNo1MANjehz+eN3OLQFC9A5u
         qyrt6MqKjArunm+ogRKYxaG+yAtifIzJE2pKyfoAGHMRV4NASfVqe/V5655sC5dyGu5A
         kIxw==
X-Gm-Message-State: AOJu0YzXG0AcLPEfBYvEtISBJXlosDiHfaHrQe2n44bSwNFQOkeyttJE
	g4tr3zPANdBfrA8enEjb28j9uyY+lCK1Q+LeiFX5g0kjTCAc/ZhM7h/8hOXJHw==
X-Gm-Gg: ASbGncvqSZedKFC0c05L/n8gXNOaka0UM8dpPiEvmGMPy+Spy8NDn25kvZJXyI+bMyP
	MNEZicHYZTeOSUyWXwcuJp3cIQnbMXtkO8wmkFRRk2udfiOOaAjy79VWQ5i5LDbpRPpXpk4LeDL
	gFO2u2V5SP/Qqj7M21BpxXdaYdWjBeGvurQyv+YI+v9C9ZeiUoLJxDdU5G6P02PvxBSEguDKJQn
	LGNoKY9kfN55LfEw9RFhm+CG/vekmnnM/x3jvvE1TnDs1mZwmSMqYgaEJFkC62CkwmoPGeccaJP
	rhnuh6X2WsstMIVt2u0txOkSyxpio6KzmkUYDy0hPu6CEtnte7xgIfPsNUQL9CNsaFO1i7J3EoP
	YwT4Itz9a9hN7hWdldD2Jd8E0NAq1VooSHHg=
X-Google-Smtp-Source: AGHT+IGRjoMVIehuXfSUzYfgxc51Abh1n63mH5aZ7HOD6wWRn1GHUJZl6OguI0Umy0N22pA3nshqng==
X-Received: by 2002:a05:6214:1ccd:b0:70f:ab88:2f75 with SMTP id 6a1803df08f44-70fac902affmr214885196d6.50.1756918205691;
        Wed, 03 Sep 2025 09:50:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4945fd7sm31132956d6.35.2025.09.03.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:05 -0700 (PDT)
Message-Id: <1975384dd04c376fcdf74c9f4217b81aec64e8cf.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:49:57 +0000
Subject: [PATCH v3 1/6] doc: git-checkout: clarify intro
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

- Reduce use of jargon ("index", "pathspec", "tree") by using an
  example, and by mirroring the "switch" and "restore" language from the
  first line of the man page.
- Reference and clarify the ARGUMENT DISAMBIGUATION section, as well
  as fixing a small error (in "`git checkout abc`, `abc` is a commit,
  not a `_<tree-ish>_`)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 40e02cfd65..218d3dd13d 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -20,10 +20,12 @@ git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, `git checkout` will
-also update `HEAD` to set the specified branch as the current
-branch.
+`git checkout` has two main modes: it can
+**switch branches**, for example with `git checkout <branch>`, and
+**restore files from a different version**, for example with
+`git checkout <commit> <filename>` or `git checkout <filename>`
+
+See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 
 `git checkout [<branch>]`::
 	To prepare for working on _<branch>_, switch to it by updating
@@ -511,14 +513,18 @@ $ git log -g -2 HEAD
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
+and then either switches to that branch or commit or restores the
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

