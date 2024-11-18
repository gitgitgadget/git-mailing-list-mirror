Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA51E7C0A
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967562; cv=none; b=V7jn8lqjwHT84ws0vJhj/dlxXuAirMZAOuMSaSK7h3VDZE5NK3r7wFPVZX1AI5McynRKXRP574lIv0ypMqvxX5zaOADB1hSdRbG+KmOOggV43Az6be2BlwYEBLn2xLsS7dvzghAlW7Aw16/n7sjsmliWvexOhs/1IMZSPWMwynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967562; c=relaxed/simple;
	bh=0NYo/XYeH3+n/Qry/njTb1AtkwL6TFmD58G4xKjP9Tc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=I8nISPl4QhmMCbAkCNve7TqPPUkRavxKqIOr2pOYfEv2Xd0k4kMJl0DbOrdBQ1dSVXU1RfEgHMp5K5HLO7cqzxiEsVsp11GPmDygliUixkOA44K92Vrz6EzXplgtxIw6A3eQ6Ot72absC6P0IKf2R4i/T3/rzUWL8cnl5xYC7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr/j/acX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr/j/acX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3824a8a5c56so693918f8f.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731967559; x=1732572359; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=Sr/j/acXvo6kH+eRCr2nSUrO2Dum91YN6Ed0tANNLC45yowyG6UECR/P2jX112NrCP
         VbY6wN+Xohw1R/ZMU0jnnXKBzMmX6H+tJ3CKXb3FWCn7l4sK2kyHBAWwMq4MG9j8qJ9x
         GGSrYZFykUBPclU2YXkkAKYXYgPAFUT6gX1kVmqIkyfowAlKnuqxWzj16cC+GCv1HrSZ
         TtBVZ1n8i/I8Lfiyibz70tWRhsilALeyKnpdOvWr6fRTBrHL1H0DzdHmzt9Y3RHumkpL
         h6BlEzhK36e+xP8UPprt5crbZNAoozmKVMBS2GZ4w5LvCzTIvYWAa77s06d66fhBF5Zg
         DAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967559; x=1732572359;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=kOcyDb5TnHSw0tbf7SdfnZsfWl9B7G7BoIs2ta1DWp5Gpdle8ODdvDOIsJV0tp0jF4
         /aoxfyeY8nEQU/EcUtvu393ejLQ07gb+1FPK4DMLgM+OzOUpBXPCl/yyE9JXgKfC0pqH
         Uk3NjYOLk0A+UhfGE03b+ADDO6kgSflb3fs06wYx/VIQdpoRzhLj3JBXOV4s4axgCh39
         wiFhWyU/gfLo6XuTQhFAUesrWE05MSXqcI0xRdGSO7apTjy45q9nxUgxg/8wtnRrzq09
         sNu6rTa4pGpohm3Xx9mFh4uA6O8wHfzngrWC5k0PAAvx7SkjIizZVkI6zt1FOL1kg7F2
         ZRzw==
X-Gm-Message-State: AOJu0YwZY4k/zG6wORK6L3H2bqGZopkxVtH6QcBaBB81Zf2jggjIG4rW
	nqNCT5oRCZrk9X1mbqlbMgUghRosT/eoF/4cfjAxTR3cTIVa2wUT2rSmpw==
X-Google-Smtp-Source: AGHT+IEMp5sjFPeJMWF4WeNkX30mG8w/oetNmj1l+4JfKXBstJMVDNKLGdNVDxasW2YB3mdpm96XMQ==
X-Received: by 2002:a05:6000:1ac9:b0:37d:5232:a963 with SMTP id ffacd0b85a97d-382259051a9mr11542557f8f.14.1731967558752;
        Mon, 18 Nov 2024 14:05:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823a0e8f26sm7712710f8f.31.2024.11.18.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:05:58 -0800 (PST)
Message-Id: <0e6162d02d102531dd07673845d02fe2385d61df.1731967553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:05:52 +0000
Subject: [PATCH v4 4/5] doc: git-diff: apply format changes to
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/diff-generate-patch.txt | 44 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 4b5aa5c2e04..e5c813c96f3 100644
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
++
+[synopsis]
+index <hash>,<hash>..<hash>
+mode <mode>,<mode>`..`<mode>
+new file mode <mode>
+deleted file mode <mode>,<mode>
 +
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
 information about detected content movement (renames and
 copying detection) are designed to work with the diff of two
-<tree-ish> and are not used by combined diff format.
+_<tree-ish>_ and are not used by combined diff format.
 
 3.   It is followed by a two-line from-file/to-file header:
 
-- 
gitgitgadget

