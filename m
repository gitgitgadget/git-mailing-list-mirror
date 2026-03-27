Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5979386544
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640940; cv=none; b=UQPWjPZlIyBzUG7A+AijPCQjayO6QOoJQ9aAwoV35WgRaC79b7cGXCPyAJon3d02VdQ8w79hRQTwfibL2wdNxCNY4tT12Fp+Xyy+z+Eduh5Eqn6qrUyN2oQyZ+X0Xvtz5k/zStsAAbBO2jjvtJG3rml9kfQyKshsCwdJ5hsilas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640940; c=relaxed/simple;
	bh=ODfKYK63c0P2fb4eJmvRkfvCLpRd3p/HzYug4m9KqVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHNZPdIPDMN3NxltZihjHTF+bRQcR92zCYr7Dv1F6nJgdWDekSAVILL16scu027BUlKKdxm2IFKfSPuNM12KHfs6wQq+MG7+EkNfq+nYSKVrp35Sd5b9Di9ysOVqC9H3DApL945qZbtCAmm64MFTfRyTYDWRGl+smD/8DPhFY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=OlniYX0b; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="OlniYX0b"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774640930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKvtd3xYYzIyWVKhFOIMTbTBxHSY3X63z4kE69pt0XM=;
	b=OlniYX0b3dmuUg9yUJMemke7VrhJpvWjEYIyASspd5jaZsS+R/psck8B4mBjx7S5ftIVXg
	Nms2mnBv2WFSrJXFXUD1L8cd5wQECJ0zQ96znCUD/8lkLvlbrPu6Nvc4JeyTyFOiCX1Kr1
	R+PdJGcAWbT4Oa83y91mbMGK1LfuMcXBuiNCzN1EgR+g91mL0iMVYFMo0bRSR/uZYqH42b
	4qN2hNH6KlGukJf5w49en3zPjv6XXoiAkclw2+HenjzEiiBtlLOePJodU6knLg7OL3YSnu
	5tATArHpRiCylVI3tFkE/XplbWS4TAZt56YtYoE2FgVUJf0JhZ62pgwgkU26sw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] docs: fix --commit-list-format related entries
Date: Fri, 27 Mar 2026 20:48:09 +0100
Message-ID: <ce285272c4a1ab09a03c9219066674f0bd9c59c2.1774640789.git.mroik@delayed.space>
In-Reply-To: <cover.1774640789.git.mroik@delayed.space>
References: <20260326200643.20251-1-mroik@delayed.space> <cover.1774640789.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Documentation specifies that "git format-patch" would default to
format.commitListFormat if --commit-list-format is not given, but
doesn't specify the default if the format.commitListFormat is not set.
The text for --cover-letter is also obsolete as the commit list can now
be something other than a shortlog.

Document to reflect changes.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

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
index c52dbcc170..cbbb292cb5 100644
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
-	The user is allowed to drop the prefix if the format-string contains a
-	`%<placeholder>`.
-	If not given, defaults to the `format.commitListFormat` configuration
-	variable.
-	This option implies the use of `--cover-letter` unless
-	`--no-cover-letter` is given.
+	series. The accepted values for format-spec are `shortlog`, `modern` or
+	a format-string prefixed with `log:`. E.g. `log: %s (%an)`.
+	`modern` is the same as `log:[%(count)/%(total)] %s`.
+	The `log:` prefix can be omitted if the format-string has a `%` in it
+	(expecting that it is part of `%<placeholder>`).
+	Defaults to the `format.commitListFormat` configuration variable, if
+	set, or `shortlog`.
+	This option given from the command-line implies the use of
+	`--cover-letter` unless `--no-cover-letter` is given.
 
 --encode-email-headers::
 --no-encode-email-headers::
-- 
2.53.0.1181.g1066ffbbbe

