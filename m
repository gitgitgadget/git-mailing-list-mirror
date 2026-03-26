Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76943C05E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551370; cv=none; b=FM15hegHhj9hRTK+Rg5hZi+RQbkOB7WX//saLtAQmRTExMCXFgCVzJYgB3uaWCIv2F0YlRqkSHXWDWAdxtrpFAz29NwXAuo7PNkbsf4rsBvmrLQXEiS7EeWs4TK7UWzoeOz96XAJGGVpJBSCdDtEGH0YRddP5xopWehXJjPND78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551370; c=relaxed/simple;
	bh=66svF18bR/ADr3vpkbpoozpnsmyiIr9rRFqHq0yaP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COu4rrKWVmsjrMPKi5pqmNs8omIoOLigcFEUm6D9ANoLBucG9ppb6jS+KKSiRnz4dtYPzsPSzUpwyrNV+u+67k2tBfpJP8japhocxRAD5kU1nPtSZU8+VhCKuEhzcjyzfll5AQh+fqStvXGFKW4gUQnpbPNonv1LkWj5QK5z+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=IPkBQHfl; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="IPkBQHfl"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774551366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1gfqxxYqqx4uQ3qd4yHrWyTFWHhE1srHkEUDf4NUunc=;
	b=IPkBQHflW6RhRDyAiwV/itYMd4PnDOO/0qKqdW6DMPtVuBNbE+stNu9aZbFyVKdaneamRh
	Prl/Kz6TdpGwZyKP7HqnhHtXjYOMlw9ZL/B/PHaM5HCsnqCLd0FWHnprIb77ycyErpPer9
	iZbwoIEm/L6fv4EMiX++u0WBDBXYWRxt8ruWX6Q4DkRh7gurfKKRKtxb5XpoWhri/iFIXK
	yGAeCpKLCrrvFQpBW3WdaJkRR9/IPfHEUC5z7Omtl+DEd9vjG7cwgG15aexUlde5hAJ5Mf
	4bRpq/gbWddTLePWOQJLTqOJR2YqUpnJZj7QOODBrySf7fSqWpLdOAmKCL0oQQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] docs: fix --commit-list-format related entries
Date: Thu, 26 Mar 2026 19:55:41 +0100
Message-ID: <20260326185541.17523-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Documentation specifies that "git format-patch" would default to
format.commitListFormat if --commit-list-format is not given, but
doesn't specify the default if the format.commitListFormat is not set.
The text for --cover-letter is also obsolete as the commit list can now
be something other than a shortlog.

Document to reflect changes.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
This series is based on top of 41688c1a23 (The 21st batch, 2026-03-25)
with the following series merged into it:
  - mf/format-patch-commit-list-format at 36c16a5b7f (format-patch:
    --commit-list-format without prefix, 2026-03-23)

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ef1ed1d250..dbd186290b 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -103,7 +103,7 @@ format.coverLetter::
 
 format.commitListFormat::
 	When the `--cover-letter-format` option is not given, `format-patch`
-	uses the value of this variable to decide how to format the title of
+	uses the value of this variable to decide how to format the entry of
 	each commit. Defaults to `shortlog`.
 
 format.outputDirectory::
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index c52dbcc170..e74b085c77 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -319,21 +319,21 @@ feeding the result to `git send-email`.
 
 --cover-letter::
 --no-cover-letter::
-	In addition to the patches, generate a cover letter file
-	containing the branch description, shortlog and the overall diffstat.  You can
-	fill in a description in the file before sending it out.
+	In addition to the patches, generate a cover letter file containing the
+	branch description, commit list and the overall diffstat.  You can fill
+	in a description in the file before sending it out.
 
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
-	series. The accepted values for format-spec are `shortlog`, `modern` or a
-	format-string prefixed with `log:`.
-	e.g. `log: %s (%an)`
+	series. The accepted values for format-spec are `shortlog`, `modern` or
+	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
+	Modern is the same as `log:[%(count)/%(total)] %s`.
 	The user is allowed to drop the prefix if the format-string contains a
 	`%<placeholder>`.
-	If not given, defaults to the `format.commitListFormat` configuration
-	variable.
-	This option implies the use of `--cover-letter` unless
-	`--no-cover-letter` is given.
+	If not given, defaults to `shortlog` unless the
+	`format.commitListFormat` configuration variable is set. This option
+	implies the use of `--cover-letter` unless `--no-cover-letter` is
+	given.
 
 --encode-email-headers::
 --no-encode-email-headers::
-- 
2.53.0.1181.g1066ffbbbe

