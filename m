Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0261A2C0E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343994; cv=none; b=EPdEAGLWUaxwnR60vqlU3JIHuxOMdRIu54i4MZ4gvMeCGtzH5FLhsjeJdzRtk/OX2y8fZDpIF52KfdFshu+EFJNvjfDLHPq3x+ULNYjQ8KFMqwfpDekYYq1vRThzuJYtfE5RJwhtRX+LfDQE61sSEDJSLilA3IfBvTXrJDjSZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343994; c=relaxed/simple;
	bh=0NYo/XYeH3+n/Qry/njTb1AtkwL6TFmD58G4xKjP9Tc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=S2IJuM7VV3ZLAWs/wvxJvkduuENvopiMXtT6d4pCcRruk5VUSTkgyjLMAM9iV6Zl3dBjSbCOqyyfg2/Hg1MnUKPyX1fxCXWNUs8yMUrzzJmxvC6UC9TXtD2G+9KgGgDtd2bAKHAQJh9QcYs3U8Ch+Te290ghuerD3EgsdooKluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqswO02u; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqswO02u"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3637309f8f.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343991; x=1731948791; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=ZqswO02udq+pufpZbwtj0uVzNsMJ+PJdlolB19HdQJzaswOnDxx6T/5ha9rQGXjzZC
         Dswew7MLRp+pD/wLsIWguWZIQSQFdaigSefc+xMhmzD98DEr1u7RfAiSherEUhne94vL
         7r4TMFf487bZw+uH2XCIm586EdL8Njt/zOhmU85VWhZfOc8grktNEYngNTCu9Yfabx5o
         e5mLZuWw/etUPY8arAP78aJ30rPsOxdu8OeCCoevDhhBJ5Rr6HYDoaU6iX9Bkea0fYqa
         APhUNJS3+2A6OUze788SmHFV/9IIZ4cGbiSX60C0nxpMoOUH5KZ5V2KHLDsxK62vE/Hv
         EJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343991; x=1731948791;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhawjVpJghbDgtfyy8U3o7VjiknI4ER7dr7TL3PtJ38=;
        b=EDjlsh8SNKxg25qfUxQfuGzoMqK5+urjkjc55v1EkM4Ys3avdUDMjcMyWmUZX41Ubd
         WNQn4EQ7d9q60S31Rxf9+xhwIDTToc8N9KlwgmiYYj5Kakj8taD8gwyECaPxbpGdqgY9
         aZWVTS8y4pmcqQqBiomJoBhEnWgmf/KLIv2zxY0j9NIISafGOZS9F4gj1u5LWyJCXgPI
         /OKV0a25nOfdwe0vjJRXmXBpxbn0gTqzhIVoAZcBKrUKt6s5OPQtNpXAeO5Lk4DB0sJa
         EseRlYXfifGU96xrTo3l7JKV4jYpGAcuUcwHqCiX7f8bfeW3R7yFwx0dU5f/3VeS5XO9
         sJ1w==
X-Gm-Message-State: AOJu0Yxk8iPQMzU6yLn/VZQEHMbM4YYX3ohAgYgAuk0b5gqxKMnYrXDr
	C48gMo/0NoVb4ZRfSMXhHsSOf8jPQ972Rd1Sl+UYCGUZzq9djm+rri8NTw==
X-Google-Smtp-Source: AGHT+IGCxYrKCs/YKShuGuKtoc25GpueNP2L0n9K46zzdH3nKOdxZL09Q1mut+vK9FwFEkYkHulGCg==
X-Received: by 2002:a5d:5f49:0:b0:37d:52db:a0a7 with SMTP id ffacd0b85a97d-381f171cc78mr11324093f8f.2.1731343990899;
        Mon, 11 Nov 2024 08:53:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04211sm13335377f8f.94.2024.11.11.08.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 08:53:10 -0800 (PST)
Message-Id: <daed146639dee800531a477bbb8d4b6f7f5bf0d8.1731343985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<pull.1769.v2.git.1731343985.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 16:53:04 +0000
Subject: [PATCH v2 4/5] doc: git-diff: apply format changes to
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

