Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046C2D73B8
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957231; cv=none; b=jmmSyASBkJDPkiy7MN85ssqAlv2S6L90Rti7v8TrcJni0NUOVt32NAAjHaET5WutwgNBgfXAmvPFCvfDKqq4kVjIbl/cpZfphCy2Wz9SxKV+U1FalZjvUCM0M1t1ziLKmts/MBVugcvz2KCsanRUwHCjcGHr39YO9Cfmoj1625M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957231; c=relaxed/simple;
	bh=fdckb0S62mNB3FGI26GYnHZJLRkdTaZPowx63PuBviw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=R4gzQt4uDOHaIZ5ki9Lddt9z4vsGY5SNe231ARItdZZhanw1u/HECIXkJwZVDioTZNWGe1vGWN8upTNMCeEbX3sHnJg6ESTxn/dzakj2yTSVurGIgEbBLXpHCiMouwKAAJTyF3zdWomFC/J2/iZrr3WSUUBFeuGz2urem6Wk0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H997jbCJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H997jbCJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso45643455ad.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957229; x=1791562029; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3j7JcahWm0P5e5tSWuo/wVV1PY+pIyDOr5oFgkyR1qg=;
        b=H997jbCJsE730XcHiyfVazN43pfTqAPAzsTNWfcQqyOeE85jnZOr9SW6r080mh5rvS
         UI+Wj9P1hLMwqm4yq3epWcI3XTbh2GLLby1fWTW8uHUa5bvbDRCquNV8qBIsaC4joiw8
         BntdILwXklG2xQfVn0FGSXyzbQAD/jxgGUOlzDOID5YPR32JM5qUDCRb3L8Bn0limYv6
         FWXl+iIg8FFEeES3h1dq8wQOSYhHC3nrOODjSjMJkTSQLv1Zru+0cG87Yw5Ww+3ThPuo
         2yWco8EhrjYhAKaiDyWg+iUGCUzVzDUwdP6WU9qP4MWoo5Gu/xViUQol0UgdqQDEhOiK
         iJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957229; x=1791562029;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3j7JcahWm0P5e5tSWuo/wVV1PY+pIyDOr5oFgkyR1qg=;
        b=JccqjhehW3ei0irdn1gNUJ7h8HM8+jSz4T3jw4HJyWSG+qqHSfQLiHibBvKiMoE+eP
         EIH/QMe0gR4dJZEfHk7wZlqANm0D1KLjAOtOF+JP/zdA/9irya+fyu7g0hhTLQ+yf26e
         urVV65+YPv2EthUTI0+mdklg28Gg9w1DsN45wWQ6qQBlvqikSeP6XRxnzGdG96Ox0nYP
         Ufi4R/sREUv6/s0/TfQbzNp+94h5BG3E3ZC2a25KTqXlIe7Tus2kyirBC4LhxgpB0/vP
         YEHOeqluhH8/OOQ8oSX04l0NRgbc6pVuRCQStUSo/SPJYHzYRhup4LFlPtdcSD7L+Ja+
         iMcw==
X-Gm-Message-State: AFq9FYI4DjIg73h0e36rjvwGIHgA3j+59UrRroPAoda+1DNUv6yzZpVr
	F3o5NT2u44i+cK23NefoVr2j8TFCk+7YAv468QLjY5dYNDhqvg3hHQ9W0pMIag==
X-Gm-Gg: AYBFou1hzAKqj3BeVC/DpMK3+7P6SgtyojIKOFFs6VHNCdC1jZ3S9Von9so8lpHFgt2
	VS+VUO2f/QMRntzh4yYq4tNMzErX3/3YrPFMtnTZu0S4kcEzrcCaUHccd63z9Sxcu93Q+WluGuR
	puQtX83sUQAI5UOZpV0zyPj92IzMJNQDstKlUL/loLdJ6+fwaZLyTrnGwEpLO3upbMTxpjiQrzQ
	8/GEoC/Ax3b0W7Kn1obnLSBGBmat1dxAoM6wWzwQp7LxZlmfoZ5A1XLNH2BAVtENUxVGSKHq5FF
	KbWOfYE11k92zLhhcLTSM15RaBWuzOnm6rHUunudgJ1G7fgWcvwNPDbA3L0uPi3Azn9NTJECDx7
	JWHjumsXXwvo1rIC2M/x2GswGwL0fyYVNauPxfy8cHY9N+nqUOkYvztVeuRtPN6qkIWVkhmxqNF
	sDPWLp72jyjDum4AqvqOMoUD7CtNWdjWhiUbZ5UI6jf+fVLBOFUyzzMoSAza26UZl38u3zE8rx7
	3o=
X-Received: by 2002:a17:90b:17c6:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3a6ceaab6d4mr3154918a91.29.1790957229151;
        Fri, 02 Oct 2026 09:07:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.194.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd58ade9sm4857252a91.8.2026.10.02.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:07:08 -0700 (PDT)
Message-Id: <pull.2246.git.1790957227881.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 16:07:07 +0000
Subject: [PATCH] doc: don't require a SYNOPSIS in section 7
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

Remove the SYNOPSIS section from the section 7 man pages where
appropriate, to avoid having a section that contains no information.
It's not the norm in section 7 to always require a SYNOPSIS.

Update the perl script with a special case for section 7.

Tested by running `make lint-docs`, and looked at the renaming synopses
with this fish script snippet:

for i in *.7
   echo $i; grep SYNOPSIS -A 5 (string replace .7 .adoc $i)
end

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: don't require a SYNOPSIS in section 7
    
    Seemed like a nice quick improvement, though happy to drop this if it
    turns into a can of worms
    
    I haven't written Perl since probably 2007 so might have made a mistake
    there but the code does seem to run :). Even managed to write it with no
    LLMs and just some good ol perlrequick.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2246%2Fjvns%2Fno-synopsis-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2246/jvns/no-synopsis-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2246

 Documentation/gitcli.adoc                 | 5 -----
 Documentation/gitcore-tutorial.adoc       | 4 ----
 Documentation/gitdatamodel.adoc           | 4 ----
 Documentation/giteveryday.adoc            | 5 -----
 Documentation/gitfaq.adoc                 | 4 ----
 Documentation/gitglossary.adoc            | 4 ----
 Documentation/gitpacking.adoc             | 4 ----
 Documentation/gitrevisions.adoc           | 5 -----
 Documentation/gittutorial-2.adoc          | 5 -----
 Documentation/gittutorial.adoc            | 5 -----
 Documentation/gitworkflows.adoc           | 6 ------
 Documentation/lint-man-section-order.perl | 7 +++++++
 12 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 6815d6bfb7..9c4598e29c 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gitcli - Git command-line interface and conventions
 
-SYNOPSIS
---------
-gitcli
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitcore-tutorial.adoc b/Documentation/gitcore-tutorial.adoc
index 2122aeb976..71fda63a1c 100644
--- a/Documentation/gitcore-tutorial.adoc
+++ b/Documentation/gitcore-tutorial.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitcore-tutorial - A Git core tutorial for developers
 
-SYNOPSIS
---------
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 56b7635c19..8d9be02036 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitdatamodel - Git's core data model
 
-SYNOPSIS
---------
-gitdatamodel
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/giteveryday.adoc b/Documentation/giteveryday.adoc
index 6cfdd0e07b..0c9db2f150 100644
--- a/Documentation/giteveryday.adoc
+++ b/Documentation/giteveryday.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 giteveryday - A useful minimum set of commands for Everyday Git
 
-SYNOPSIS
---------
-
-Everyday Git With 20 Commands Or So
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
index f6c9b9d9f7..b26e4e3a09 100644
--- a/Documentation/gitfaq.adoc
+++ b/Documentation/gitfaq.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitfaq - Frequently asked questions about using Git
 
-SYNOPSIS
---------
-gitfaq
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitglossary.adoc b/Documentation/gitglossary.adoc
index b046d9cb29..eb1e60832e 100644
--- a/Documentation/gitglossary.adoc
+++ b/Documentation/gitglossary.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitglossary - A Git Glossary
 
-SYNOPSIS
---------
-*
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitpacking.adoc b/Documentation/gitpacking.adoc
index e6de6ec824..b0d952c797 100644
--- a/Documentation/gitpacking.adoc
+++ b/Documentation/gitpacking.adoc
@@ -5,10 +5,6 @@ NAME
 ----
 gitpacking - Advanced concepts related to packing in Git
 
-SYNOPSIS
---------
-gitpacking
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitrevisions.adoc b/Documentation/gitrevisions.adoc
index 7146117de5..4412f84d83 100644
--- a/Documentation/gitrevisions.adoc
+++ b/Documentation/gitrevisions.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gitrevisions - Specifying revisions and ranges for Git
 
-SYNOPSIS
---------
-gitrevisions
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gittutorial-2.adoc b/Documentation/gittutorial-2.adoc
index 8bdb7d0bd3..6a4d482ed6 100644
--- a/Documentation/gittutorial-2.adoc
+++ b/Documentation/gittutorial-2.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gittutorial-2 - A tutorial introduction to Git: part two
 
-SYNOPSIS
---------
-[verse]
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
index 519b8d8be2..03120ba191 100644
--- a/Documentation/gittutorial.adoc
+++ b/Documentation/gittutorial.adoc
@@ -5,11 +5,6 @@ NAME
 ----
 gittutorial - A tutorial introduction to Git
 
-SYNOPSIS
---------
-[verse]
-git *
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/gitworkflows.adoc b/Documentation/gitworkflows.adoc
index 59305265c5..ad02828bff 100644
--- a/Documentation/gitworkflows.adoc
+++ b/Documentation/gitworkflows.adoc
@@ -5,12 +5,6 @@ NAME
 ----
 gitworkflows - An overview of recommended workflows with Git
 
-SYNOPSIS
---------
-[verse]
-git *
-
-
 DESCRIPTION
 -----------
 
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index 02408a0062..e032f6ae53 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -53,6 +53,11 @@ sub report {
 	$exit_code = 1;
 }
 
+# assume the first line is formatted like 'gitglossary(7)'
+my $firstline = <>;
+$firstline =~ m/\((\d)\)/;
+my $man_section_number = $1;
+
 my $last_was_section;
 my @actual_order;
 while (my $line = <>) {
@@ -93,6 +98,8 @@ while (my $line = <>) {
 
 		for my $section (sort keys %SECTIONS) {
 			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
+			# Synopsis is not required in section 7
+			next if ($section eq "SYNOPSIS" && $man_section_number eq "7");
 			report("has no required '$section' section!");
 		}
 

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
