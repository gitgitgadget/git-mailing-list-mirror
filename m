Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7184FA0
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130276; cv=none; b=VK/MYElbjKqv5DexniC5ANw0rHfrEiF8Pc0toRs2sgsQhSDim7GFAMRu7B4vrQ3ezFITnIrH6TwAexsFCDVCrZyfGPmobosI3Xfdm+59mFXpLvHIs2GTrPu1x9gGDSukQR0lnYnUZZUC4o8EnwQj567u6Ao8TKAMMyjZh1r7LP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130276; c=relaxed/simple;
	bh=+fYMwYg4DDJIc/6f7tFgoidovHPCHC/w8/aBQmfQLRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mafIcFKF2RQ5LVaKdBAcyZxqJf79eetd7lzMYygVprzl6FqU2um8V94E8vI8RBuzfy8Dbj8WiYTifLesvhIWWBtwvxlWDffd/C2sIoh3mbU0rc7jhaS3J4sy0mReMeklTMO+AOTYo9ZWIOcIocX3aWH1XJGwsrdpbwoCeuIM8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDVuCphJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDVuCphJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727130275; x=1758666275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+fYMwYg4DDJIc/6f7tFgoidovHPCHC/w8/aBQmfQLRc=;
  b=JDVuCphJbZKM6N1RM03/saC7zxoLEm7hwm0PVW1XkSStSVCz9rEmqnKV
   Sb+AwUacYNOQqqKRd/5h/JxpsBhU+gKjDRZqWqKJxMaQ+tapb6+RhxwSz
   4KqQAOYhj8erCf0drwy6xl0g5uqsRVB6KreEr3NCE5LiK0YBbfvwcqdl+
   Iihab08J0lkNMlwJgSV9R0zN8ekRZRUS4L5jPLK3i8NS/UwpdRpzgOKzK
   tSKnQPm01/6PeW0FGlFAF0nr3O2DY/MPYgR8tLf8ZqsMsZSV5j/BsIiWk
   HE2lybDpvtOC3K1aIZvNoem51cFnui03J7d9EEWT+r9kVTH5eiCX3zOEe
   g==;
X-CSE-ConnectionGUID: iobEmHSDQfqJtKP3ustZAw==
X-CSE-MsgGUID: 4jBVStCIRUCo1pMVFAmthA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="51518597"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="51518597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 15:24:34 -0700
X-CSE-ConnectionGUID: fwBqsJrdSdCAFf6QoOjNgg==
X-CSE-MsgGUID: zA4p0PBNTn+6E/Zo6Y25cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="102043305"
Received: from jekeller-desk.jf.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 15:24:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] send-email: document --mailmap and associated configuration
Date: Mon, 23 Sep 2024 15:24:28 -0700
Message-ID: <20240923222429.4102405-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.46.2.828.g9e56e24342b6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.keller@gmail.com>

241499aba007 ("send-email: add mailmap support via sendemail.mailmap and
--mailmap", 2024-08-27) added support for --mailmap, and the associated
sendemail.mailmap.* configuration variables. Add documentation to
reflect this feature.

Fixes: 241499aba007 ("send-email: add mailmap support via sendemail.mailmap and --mailmap")
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config/sendemail.txt | 15 +++++++++++++++
 Documentation/git-send-email.txt   |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 6a869d67eb90..14a58b3749e2 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -30,6 +30,21 @@ sendemail.confirm::
 	in the linkgit:git-send-email[1] documentation for the meaning of these
 	values.
 
+sendemail.mailmap::
+	If true, makes linkgit:git-send-email[1] assume `--mailmap`,
+	otherwise assume `--no-mailmap`. False by default.
+
+sendemail.mailmap.file::
+	The location of a linkgit:git-send-email[1] specific augmenting
+	mailmap file. The default mailmap and `mailmap.file` are loaded
+	first. Thus, entries in this file take precedence over entries in
+	the default mailmap locations. See linkgit:git-mailmap[1].
+
+sendemail.mailmap.blob::
+	Like `sendemail.mailmap.file`, but consider the value as a reference
+	to a blob in the repository. Entries in `sendemail.mailmap.file`
+	take precedence over entries here. See linkgit:git-mailmap[1].
+
 sendemail.aliasesFile::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply `sendemail.aliasFileType`.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 2e6f1d63ae4a..dc5b122bb8e6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -414,6 +414,12 @@ exists when 'git send-email' is asked to add it (especially note that
 Failure to do so may not produce the expected result in the
 recipient's MUA.
 
+--[no-]mailmap::
+	Use the mailmap file (see linkgit:git-mailmap[1]) to map all
+	addresses to their canonical real name and email address. Additional
+	mailmap data specific to git-send-email may be provided using the
+	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
+	values. Defaults to `sendemail.mailmap`.
 
 Administering
 ~~~~~~~~~~~~~
-- 
2.46.2.828.g9e56e24342b6

