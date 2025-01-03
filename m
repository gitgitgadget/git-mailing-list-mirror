Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4F1F8F09
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912053; cv=none; b=nY8uZVO/UqtntbnXxSFrH6vbJhROsMuhUTfVLlvIo/mjbk1TA1KNFbYhpGEcr4/hoVi6J41cYBJl1VHxHr8oAlna+JDpUzxycNpeKLWM3NT9lAo/zOMrJax5mN2PopbetAc2956v1zCa4S/2a/PQ66XFJRGCd63wxEml0of7jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912053; c=relaxed/simple;
	bh=efnIpStd5jHGO1ve/52THf/x12gFpGmXfsj3McIpR+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=LYUoUBBpjOtoAcbFkdyHBkUqHv/ZQcQAl8mZKe6E4yAU7EC14b6JRWWHYK588qjii5qwynmtPbsc0KltxOddwLeRwZ66uR2jvu/Zl/iZpA4YPRPFTzx4y1fRAecKjcXgnKCBV4TWXXLhBzreUfaFxTeuWH7h6hMzFZYpENFdRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Afd+SJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Afd+SJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385dece873cso4585527f8f.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912050; x=1736516850; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV3Tnhd4Lkpqe31w4AFtjUiY/lPcnfC0zvcd0UAd0u0=;
        b=F5Afd+SJuKiMigVcNEtwVq25XOEdp6rpFi0I0vTmebd47AH05gDBGgS8m9dwBu4x2V
         aqL9WqKY5iqnaI/zclYsnXdaGaDNAifJBzBcJKiUGesicUfN1p3m8vDSYMuLPbOAxYwi
         GXTr4gaJtH/1RQFbZqfuSEpzluG/DhmbnqfSE0tkFtzkqzxrmXxr973ejmQutXFs4Zgc
         GO0uUVLnzlPRK5xALguNX8YzEhRre2ciypZKJ2drdlwgqwUXlJfdv66Xmga9sBh0is0r
         tT1OMa1b870QvB2itfdTm3zJZ+d8X+uLhn6yRZKvoEv2S1vsRfXI5QN2b1rfRnV1+01p
         S5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912050; x=1736516850;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV3Tnhd4Lkpqe31w4AFtjUiY/lPcnfC0zvcd0UAd0u0=;
        b=T+LK/2zzF+JFDTcYZoHRDZXZLHak2t8/leB9JUbyiGTosTZSEbhkh+k/acpuyJZTTF
         yEXDjVr07/hRCb/Y4GNKGu2FpF3q9ch26Vgr5newUaFsxbDprLJEG03cQE0Vze340ALk
         XZeB8Y6G2R9DCbdry2S0sr5adLFHxmKMxwnWAHRyU+Y/OAYNQxihtUp2VyYSXwxuanqo
         uOV5NxG71wcxMXlhLFlw/ShqhZ0XBLEYmT4cxYUiNZXBr3Gmy6w6K36vDhM6GiTyCWB7
         Aj8KwTInxuCoaMYrfAI8XDt9Cz1Pxpo05VaHoJPXxJ93FasdmVVRfS6JDxmhO50hT0mt
         CuQw==
X-Gm-Message-State: AOJu0Yybzoa84sdvzvGToQ8dI/8c5Ubb9HNRCfyYrNUxWtAmCZXwHJWx
	8BljAxErcL9ZlJp9x8oXbgDFcmbkCsy0rIMdPPz3maNPC+LPog9oyTfZ5A==
X-Gm-Gg: ASbGnctqTUNBSZUHa4nJ/cdeWli1D+AojAtaRcCR3wqSObsxobgOhRiLJAGXT1ooOr4
	WL6ypT/cpEQgut3AdBC/zR5DWd8OdmqRcVSorfAysiIMYABIx/CEvbLHnDqwR8I/QVSKNFpDX7F
	yGmlzkofd8ooq9Ty+xlbQjbgAUlkz5dYls9CjKzzLm+WOniw9ygIu7TZFRN7AcQLF2sCK+KlYYc
	Y+llKqBhLWwXFaywmEh0uBmiLBaZG3ngR2BgHBMgyidTf37adS3dlFuLg==
X-Google-Smtp-Source: AGHT+IH8T7CT6YqC256i0j6yrKXadzNGJP0lN9P6coRDDuMiQ06+23jAzRPGmNmu/9b5KuZLkSbkKw==
X-Received: by 2002:a5d:5885:0:b0:385:ef8e:a641 with SMTP id ffacd0b85a97d-38a221ffb82mr44865883f8f.28.1735912049718;
        Fri, 03 Jan 2025 05:47:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1cesm40114023f8f.64.2025.01.03.05.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:47:29 -0800 (PST)
Message-Id: <9f518ec8f9d564107d9953bdb3bb20048cdd60e6.1735912046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 13:47:25 +0000
Subject: [PATCH 2/3] doc: git-commit.txt: convert git commit config to new
 format
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

Also prevent git-commit manpage to refer to itself in the config
description by using a variable.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/commit.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 62f0d92fda5..d3f4624fd27 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -1,29 +1,34 @@
-commit.cleanup::
+ifdef::git-commit[]
+:see-git-commit:
+endif::git-commit[]
+ifndef::git-commit[]
+:see-git-commit: See linkgit:git-commit[1] for details.
+endif::git-commit[]
+`commit.cleanup`::
 	This setting overrides the default of the `--cleanup` option in
-	`git commit`. See linkgit:git-commit[1] for details. Changing the
-	default can be useful when you always want to keep lines that begin
+	`git commit`. {see-git-commit} Changing the default can be useful
+	when you always want to keep lines that begin
 	with the comment character `#` in your log message, in which case you
 	would do `git config commit.cleanup whitespace` (note that you will
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
 
-commit.gpgSign::
-
+`commit.gpgSign`::
 	A boolean to specify whether all commits should be GPG signed.
 	Use of this option when doing operations such as rebase can
 	result in a large number of commits being signed. It may be
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
-commit.status::
+`commit.status`::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
-	message.  Defaults to true.
+	message.  Defaults to `true`.
 
-commit.template::
+`commit.template`::
 	Specify the pathname of a file to use as the template for
 	new commit messages.
 
-commit.verbose::
+`commit.verbose`::
 	A boolean or int to specify the level of verbosity with `git commit`.
-	See linkgit:git-commit[1].
+	{see-git-commit}
-- 
gitgitgadget

