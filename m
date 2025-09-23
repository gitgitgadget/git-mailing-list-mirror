Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E31285073
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649485; cv=none; b=nJykhbW2S8u5krc3LI9nagDT4xnNLyYlssvaxCoL7+G+PAl4BQHSTaSqVV8BvLYSsLIwZsM0t44m7rLCUQ05BnaNWfJ+hhxdqzAFontB05SgLsZhaOa+nx0hz2kliMZJ9GP8vgK9LgV9RFrmwFZzbrmtxfroVpB4RQC9qbId89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649485; c=relaxed/simple;
	bh=Jzhnyq9+W+GntfnzF3FtN4Kys6RGZslXGFClr8IoQTs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fZsKRtXsF716bnAMLYPm4foKZiKhEM1hEQmgn1GuQVRzzzFNgOr28joAhlZsG/zP5d1Dc25iJHV7qsf0Y4RQzH+7lYioIeCmZtTU1E5nln5nh95mI/bZrVTsPtHTEU8k2xyRswZhE/U/nT98DFLIlo1PMOzboVfh1/GIJbMWoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3WRBZ4G; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3WRBZ4G"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4248b07bb14so16585385ab.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649482; x=1759254282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orlfTCAfcTcInZAIGxb3X5lgRpwxAmOGy4uYmZRhuE0=;
        b=M3WRBZ4GMB+F1ZZH6KiZXVvdDXGc+6wVhJCNUFgzEZiUcoSH2H49ID+aqMKCr6uawf
         N0UBDSLam/X5u9ZvgA3Ja5DD/BFEl77Y9+ROf8uvXa3cuHI8rt5K1YKiBU5sjxFKaXO3
         nAJ32AVcxBFCd2MQJBe27ktp/O1vKG0u7r0MNSNfKA2GSOBLX/622B4/6GYV0OQxqoXR
         1K1Mlp/rQRioKidcH8K6xTz6jYZlZlA2H4XfJ17ztl12241NbZB5xJu+bCmctByLHsQ7
         g8YHAhi187eCoC7s6gpP5QWGYlK4jWWeNz7Ey9Vx7Y53Le9qU1d4d6+oWaHReaxfamx/
         KrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649482; x=1759254282;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orlfTCAfcTcInZAIGxb3X5lgRpwxAmOGy4uYmZRhuE0=;
        b=d1YOnnY62W353HhTREfekJzqlenRKMPIz9I7IeaQWgGan/ilDmWzfRkpPMiCqVjw8V
         yS4SAlutKEyzRpI9ammHBNJeU/4TQk/7//7e+nKGvdAdngSbyDW5FTbkOUKNK/CF96qL
         64hWOjrpbN8aYjL/KsW+UU7jIyWismwCCIfvH9ycUPEw0gZE0qMjFHVxUinhIWIubaxn
         fI785o9yVhFWPSR8FP+uO88715vUp+JP55zZpzhS54vmHKI7u1X3hoxFXGfOyu970pbT
         i8PtkV0EL+6KdiMFcmYNq2Ftu89XcF0RDRsT1P4INFY3PayqVzSCOTCuKJNn7Vi3Z8j4
         1MUA==
X-Gm-Message-State: AOJu0YyGA1ufa41Zl8hqHQ7DTsgljiNXtyBSS+WNHQvbgd4B3aiRAiXu
	nozRJik7sT6WZXbJQ9GO6/DIkxQEp5Cg9JQlSZ//iPzZNnQhxEypFIJhJx/sUOdJ
X-Gm-Gg: ASbGncssnnU2AUcfEp1WFYmJB4D5nChvilOmnDyYsCrREySpphYePQKx68L/zA8HTE+
	tBLxduTN2hMVF/fa+MecwsCAxKwWGQL4QlfAssPNbJIZHlMbMqjhmHMYgygR/kdYVV9USjYYCLy
	7l3pmwnAm/4c6Tir/qWOM4EwF3uXydBccvJeZh3oDdqmoR5NxFimAdiIVfQUWHAOEt135UOECKY
	V/UCwWRxun1wn3nThowuzIgOd8E7CVJnlbSCzQeknSnt9Hc2CwGcP+l8kXRt08sChck/a1DNkSu
	Lzm7TP2fyYnpL+C3nkiXvZj6BPzzW1fhEyzQcjuRei2xHe1v3id11L/QNwPCd5Pk+eto8qzvzTS
	nDB1QHzezUGxMTtJ2RTLHNsMO
X-Google-Smtp-Source: AGHT+IETRgkyIDlxOSlnpieOuaGH6IfQsHGUEqgnyY9HNg110Q7vcW6xhRjP3vtb7h1LF5g8uZprjw==
X-Received: by 2002:a05:6e02:168a:b0:41d:5ef3:e06 with SMTP id e9e14a558f8ab-42581e37017mr59867055ab.12.1758649482441;
        Tue, 23 Sep 2025 10:44:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56e41e3csm7253649173.71.2025.09.23.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:44:41 -0700 (PDT)
Message-Id: <be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 17:44:32 +0000
Subject: [PATCH v3 4/4] doc: git-push: clarify "what to push"
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: 6 users says they found the "what to push"
paragraphs confusing, for many different reasons, including:

* what does "..." in <refspec>... mean?
* "consult XXX configuration" is hard to parse
* it refers to the `git-config` man page even though the config
  information for `git push` is included in this man page under
  CONFIGURATION
* the default ("push to a branch with the same name") is what they use
  99% of the time, they would have expected it to appear earlier instead
  of at the very end
* not understanding what the term "upstream" means in Git
  ("are branches tracked by some system besides their names?"")

Address all of these by using a numbered "in order of precedence" list
(similar to the previous commit), by giving a little bit of context
around "upstream branch": it's something that you may have to set
explicitly, and referring to the new UPSTREAM BRANCHES section.

The default behaviour is still discussed pretty late but it should be
easier to skim now to get to the relevant information.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 368f2625a2..839e6abeec 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -28,18 +28,20 @@ argument (for example `git push dev`), then if that's not specified the
 upstream configuration for the current branch, and then defaults
 to `origin`.
 
-When the command line does not specify what to push with `<refspec>...`
-arguments or `--all`, `--mirror`, `--tags` options, the command finds
-the default `<refspec>` by consulting `remote.*.push` configuration,
-and if it is not found, honors `push.default` configuration to decide
-what to push (See linkgit:git-config[1] for the meaning of `push.default`).
-
-When neither the command-line nor the configuration specifies what to
-push, the default behavior is used, which corresponds to the `simple`
-value for `push.default`: the current branch is pushed to the
-corresponding upstream branch, but as a safety measure, the push is
-aborted if the upstream branch does not have the same name as the
-local one.
+To decide which branches, tags, or other refs to push, Git uses
+(in order of precedence):
+
+1. The `<refspec>` argument(s) (for example `main` in `git push origin main`)
+   or the `--all`, `--mirror`, or `--tags` options
+2. The `remote.*.push` configuration for the repository being pushed to
+3. The `push.default` configuration. The default is `push.default=simple`,
+   which will push to a branch with the same name as the current branch.
+   See the CONFIGURATION section below for more on `push.default`.
+
+As a safety measure, `git push` may fail if you haven't set an upstream
+for the current branch, depending on what `push.default` is set to.
+See the UPSTREAM BRANCHES section below for more on how to set and
+use upstreams.
 
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
-- 
gitgitgadget
