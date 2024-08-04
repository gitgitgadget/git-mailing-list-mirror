Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C24139CF6
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801945; cv=none; b=TRYO7Pt8jezzkv7VUQmDpYV9sMWrpGnCJM/ks9icGMraIj8i+rVNigHggW9hC5+IQ+578njxw1nFInXLn97d4v3zWZXYjYHpU1IoJjEqu7TZUbNY87YRd4wJL1GFPH0ZYN4oMeTJ8lfz1wlz/yQaswznT1281gDLB42/4BHALD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801945; c=relaxed/simple;
	bh=13JfRuOwcmuErvGwV2WSRF1KM9VSFTaD5Sc4KYZNx5o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XWrDKwF7sDQJZzM+ig08BnSA3VV35NsBiR5jbZ6bJ2thrlH/sGf0ZhbThaRSTxgxddxn55C0Q41Q89YslvUnEq2jh/PABiHpu8zp9Me/9PrTMlqjqCmKRfPmutWnElrVcUMyyDimXsTx5wymJ/XG6Y0+STcqnIyWr4YAWnqezwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm5NdAGj; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm5NdAGj"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36bd70f6522so519036f8f.1
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801942; x=1723406742; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBSjyove8FUBZ+4GrRW35tziJ0BZa+Z5bWbZS2UTwCE=;
        b=gm5NdAGj+vjbZ5/fnSRpIddU16vXPkRBPDGtezPcS54SrhEw0j8vm8LPA3hVppln0f
         lJncddFFGIbyZwfepJSAGgCQYIAoAAhsCY8GoCxfaZM4F5YqT8K388jAyxXFZ1PETwcy
         wlSwu94ECr0hDVIJse0OpODfokX0ixGapf3d8koM20fO2D2lNkuWLtDTZPhmlmVQQ72o
         sJ5RjwKVC+O4QJIlMkKwxmPpd6Fgiyi7Nt5qsk4tcAYKH07gvQnk8yg/H4j6WYwyR4+U
         RrhqtyorB0LKDjYdA6VoSMagXmeg8ztjUwcV+MjMislhw9MKWuYt6AKpcgwgi3g1Y0PY
         7xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801942; x=1723406742;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBSjyove8FUBZ+4GrRW35tziJ0BZa+Z5bWbZS2UTwCE=;
        b=A7FQJLr6txIMw2r9jLf2t0U62xy7+UbeP8Q7w+fDKpFeSclHBofhJgkkeViFv2NUpQ
         nR8V+BRXCoeFY0Uj8s75aC6j16pdC3c7VdJSD+wjZ4c1w2lTuWgOU+lzfDkigRDrem3L
         9RfnyBUGjvSrBhy+C/7Ym0TqcA02Q+FeA9db8ku6sWxGPVyOYqkYsuvMdAwgj9OUBDhv
         6ypVHdignBQdzwt+kncjWC8X0bCexs1Qh/l2+QLLq0o1H6O3y3PsMVuFTP5G43ZD+hFP
         ucdX1Nv5uVcGzTe2JgI82Mi/uNUmfWo2LK9Ad3KkQRYuKRfRLCbWQnfpXDpM5tX2hE8f
         +bNg==
X-Gm-Message-State: AOJu0YzeDmB0G92dm3amvF2xwod0t5udzQvGlMuFZBBeivkGfxiki8MD
	lk6ivJvUivfBUQWo6BKpRGgxDRRxPbjp7n+BYe7ZdA+mz/GxD9geSboSeg==
X-Google-Smtp-Source: AGHT+IEtqR8afMrRpkbNi0Ex0wmvy5Aecb02cBbcmT1MzcCifQB72Ms7mXmXHc8peHL5KoMzxLOTog==
X-Received: by 2002:a5d:5003:0:b0:368:3b1a:8350 with SMTP id ffacd0b85a97d-36bbc0c9a9amr7006564f8f.19.1722801942072;
        Sun, 04 Aug 2024 13:05:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c33bsm7785420f8f.22.2024.08.04.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:41 -0700 (PDT)
Message-Id: <3c475a2ee4ecfb79a1174fa693b592ebafdbf5f9.1722801936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:35 +0000
Subject: [PATCH 4/5]  doc: git-diff: apply format changes to
 diff-generate-patch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-generate-patch.txt | 48 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 4b5aa5c2e04..0a4dc761e64 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -14,7 +14,7 @@ You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
 (see linkgit:git[1]), and the `diff` attribute (see linkgit:gitattributes[5]).
 
-What the -p option produces is slightly different from the traditional
+What the `-p` option produces is slightly different from the traditional
 diff format:
 
 1.   It is preceded by a "git diff" header that looks like this:
@@ -30,20 +30,21 @@ name of the source file of the rename/copy and the name of
 the file that the rename/copy produces, respectively.
 
 2.   It is followed by one or more extended header lines:
-
-       old mode <mode>
-       new mode <mode>
-       deleted file mode <mode>
-       new file mode <mode>
-       copy from <path>
-       copy to <path>
-       rename from <path>
-       rename to <path>
-       similarity index <number>
-       dissimilarity index <number>
-       index <hash>..<hash> <mode>
 +
-File modes are printed as 6-digit octal numbers including the file type
+[synopsis]
+old mode <mode>
+new mode <mode>
+deleted file mode <mode>
+new file mode <mode>
+copy from <path>
+copy to <path>
+rename from <path>
+rename to <path>
+similarity index <number>
+dissimilarity index <number>
+index <hash>..<hash> <mode>
++
+File modes _<mode>_ are printed as 6-digit octal numbers including the file type
 and file permission bits.
 +
 Path names in extended headers do not include the `a/` and `b/` prefixes.
@@ -56,7 +57,7 @@ files, while 100% dissimilarity means that no line from the old
 file made it into the new one.
 +
 The index line includes the blob object names before and after the change.
-The <mode> is included if the file mode does not change; otherwise,
+The _<mode>_ is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
 3.  Pathnames with "unusual" characters are quoted as explained for
@@ -134,17 +135,18 @@ or like this (when the `--cc` option is used):
 
 2.   It is followed by one or more extended header lines
      (this example shows a merge with two parents):
-
-       index <hash>,<hash>..<hash>
-       mode <mode>,<mode>..<mode>
-       new file mode <mode>
-       deleted file mode <mode>,<mode>
 +
-The `mode <mode>,<mode>..<mode>` line appears only if at least one of
-the <mode> is different from the rest. Extended headers with
+[synopsis]
+index <hash>,<hash>`..`<hash>
+mode <mode>,<mode>`..`<mode>
+new file mode <mode>
+deleted file mode <mode>,<mode>
++
+The `mode` __<mode>__++,++__<mode>__++..++__<mode>__ line appears only if at least one of
+the _<mode>_ is different from the rest. Extended headers with
 information about detected content movement (renames and
 copying detection) are designed to work with the diff of two
-<tree-ish> and are not used by combined diff format.
+_<tree-ish>_ and are not used by combined diff format.
 
 3.   It is followed by a two-line from-file/to-file header:
 
-- 
gitgitgadget

