Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7D38F22C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840113; cv=none; b=oyP0URQkoSE2ADaGWXJsuRE65jihVospsFQRYXIZY3pEz9Rqb3oSjJOm0faq7cxlnYDVggrSxas2oUy6l1Ox8VItR8O7l/d0NH4RctsvfBAYgvbNU8d+jYCkN+IcYydDq5LffiEa6+an1A/N8NtsCtqDfjTnfp7dbXhv8yDKESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840113; c=relaxed/simple;
	bh=+iVX8sXfdj0IFTayZbWAtHFADzc5bf2ovrRpMXm/c8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhNA8FbkJ3XTEPUVsM6IfcQM0DOi5zlRkX5NFqcLVXN8KwtHRMxuCpVO5DfKNzP2CgzLWTPvlSHstFDzKcVyEI6z7lWF+NnLaYq2BuIKpKr14/vxRrK1noehllODuWCo/N+OGASA8w4QjQWSK/mbL9fPxXsNtTlDl1mr3IyQZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=fjWuMY1/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="fjWuMY1/"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772840105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93QULg6kWIX+DTKun151ccARm0iRReUgkzsNXffniFE=;
	b=fjWuMY1/tsTIDiImRAMuY32S4HE7nF52eWdcgre0/ncQbtbnpmsYRlhNMVpnP4jZ5hbVEn
	h9EEcFclh83pZyblD50IhrqwqLV1oVrm5KeJdf3qSH+BAORhcKcOYIbsuMAGkKig++Mrxz
	0V9PiZBoEaS/bp0o2QWCRS0VszQUGwhQNQFZgFCrhtIgMp4PesCVCYnIeuHfOj+tMHTVVe
	MZiCWuZrxwQtLASDOXKuGWlyXm3d8hdS49G7H6SoHYqBlN62HpuIs9hc0CoKtSpjvKVW6o
	XZfaM0KSAD0sFZOtD/2ZJL9kqfWpWQT4hn5XyAl0LUvfkVwSz3C8kmcm+AbVjw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v7 5/5] docs: add usage for the cover-letter fmt feature
Date: Sat,  7 Mar 2026 00:34:44 +0100
Message-ID: <be7197aef5a7bc3de06216054fee6ee67e65cc33.1772839973.git.mroik@delayed.space>
In-Reply-To: <cover.1772839973.git.mroik@delayed.space>
References: <cover.1772837832.git.mroik@delayed.space> <cover.1772839973.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601; i=mroik@delayed.space; h=from:subject:message-id; bh=+iVX8sXfdj0IFTayZbWAtHFADzc5bf2ovrRpMXm/c8E=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq2SAQBltZW6rCbH87s+MaBZX/sxBugRknm3hU mAW/P0VlzWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatkgAAKCRBIeX6hnBm+ 0dSSEACjf4c3P5Y1oQqFjCeFyf9Qt9TMj4J/7d1ZiqaKP7sTTIh2GGBiM8pgCLg3nsuDw8DOMjx eAQ88/DYrBLW4u2pBTsnWBsLYa9nHa8Bc98YPMd/pxjRxZkE4iYT4YC3zjIR1tOnjlp+oA9geOM dZatueOgziP12/90JyYrxTPxN5waZ2Bk+DkxY+Qfkx4YAkonVxu3oSY/vQG0Qg1if3YJsOP5Cvl PyK3E6aTfdlRRPaNqWh/pgN64t2WGB17l33staLGaXX9Y9VzKiOfdqxeDQF44Q9wvs1ySeUKpFl 52kWXBDN+nrpyKMwVpLeCa58JwoGR4KzJlOTTXxAhstRZb3l8nsWINwsn1uovsuNEFEaCFvxAGu 7WF2Vtr/TMdWtiGwTXxwkPWhkgR8GSmtz1XdstMsrQwdOTCtPIxQ47Nv02Et5euXAUjkzXD3rlV 4MemfG9FKv13PZiXjvmfsYXmcJ6ZuMC+Z6A9anPBja8Vg0ZHMQ6qqpCxdCpMo/7bXl8Ok/Jw8If Heyohz6CJcHOC2LwLXtvRNvyaCvN7zTlbcHu8oYeLgJ7vCk/Td6KJM6Kmwc8USNHqLJSQRNx/Yb HYByIK3xv0X3N/w9bgCiOn7E3hnW4edihCsq8zzN+QFUWOH0IDF10pnXH3pjeVjN3tfakhw8DG3 nsS8tsuRt
 wYpl8Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Document the new "--cover-letter-format" option in format-patch and its
related configuration variable "format.commitListFormat".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  5 +++++
 Documentation/git-format-patch.adoc | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..ea5ec5df7a 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -101,6 +101,11 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 	Default is false.
 
+format.commitListFormat::
+	When the `--cover-letter-format` option is not given, `format-patch`
+	uses the value of this variable to decide how to format the title of
+	each commit. Default to `shortlog`.
+
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..668330a015 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,6 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
+		   [--cover-letter-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -321,6 +322,17 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-format=<format-spec>::
+	Specify the format in which to generate the commit list of the
+	patch series. This option is available if the user wants to use
+	an alternative to the default `shortlog` format. The accepted
+	values for format-spec are "shortlog" or a format string
+	prefixed with `log:`.
+	e.g. `log: %s (%an)`
+	If defined, defaults to the `format.commitListFormat` configuration
+	variable.
+	This option is relevant only if a cover letter is generated.
+
 --encode-email-headers::
 --no-encode-email-headers::
 	Encode email headers that have non-ASCII characters with
@@ -452,6 +464,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	commitListFormat = shortlog
 	coverFromDescription = auto
 ------------
 
-- 
2.53.0.5.gbe7197aef5

