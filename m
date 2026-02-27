Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0B31A07B
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210580; cv=none; b=LT1+PcdsIQ+RRd5gkx5dZJbTGdYjtZMHtjUmTvq6cxbgJRXnVj3N7sYiNBlZ+BrF+3tDUsK003bYz83O7CMeQyaDXGhoWMmA/quGT+Pmfd2CK+97GDqfx5yVHPBtAB1PtG9TYk6KJYuvxeKZ0o1l9ljB5wqTJXwJWVPjch7iN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210580; c=relaxed/simple;
	bh=MHPz51wjeWjIT4IE2GPdtnK9sLvXz0YvWA884FeaHyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZt2zhXb+7oyMyYNRvFK390EWioDRK5Lx9Cb+XPHm5ZRFNrli6QMxEms0opSkPQ5uRDazs9SKMkoABXLNhsYWE/FTxDh78yp1dprz/06zxOmsNZsglpAikyhEvbHyYQ/ynd6cnew/mItIv8MG+qTtOkEfrQp+DGoNdhNC5t9KAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=gK/c3QLT; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="gK/c3QLT"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772210575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1OhBqQIpOqlCj56jQ//XqRfyQkHA8AICu0fW59jwZs=;
	b=gK/c3QLTUIqRA5M6//ubvGVEfDObEZeBnrr7jA/HDSiXPf0YCnyfiTvvSBZek2hpTebyZ/
	/CxhB63aVkcGPUvUP7S41GDnplh7U9vfEVoEIXTC5vjBHyeo5/RToc0emAw9aXmzPLOj+V
	TnHeoLRZ6U/YExPDyUyTJTrx7k56UGBKk4g04sAr2pnRnkuirJoLlIDvbw8faZpLXY/oAt
	QdbXJxxXrUGWZq8qpQiptAkA1dSHsMRjRkiOb3rIS5iymdYc6Zk6Khw5zs0sAuRH0WT7cJ
	iplgZkl3Pz4I1ej9ciYCmCoz4Ihytjd1c1Tyuyv6QS6L3rH8TUX4BxyUZCjZ7Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 5/4] docs: add usage for the cover-letter fmt feature
Date: Fri, 27 Feb 2026 17:42:33 +0100
Message-ID: <20260227164234.11632-1-mroik@delayed.space>
In-Reply-To: <f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
References: <f9ee8e24001aa16e5df3dc0bbfccd1b381e37d85.1772196510.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=mroik@delayed.space; h=from:subject; bh=MHPz51wjeWjIT4IE2GPdtnK9sLvXz0YvWA884FeaHyY=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoclmf/kaTJDNqjDeGCab2d3db0LE9Pf7YgMLm ziP3tw+r1SJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaHJZgAKCRBIeX6hnBm+ 0Q12D/47lLwRJZf31Dp3sz6d/G+WjpHrSWQJb413XoUXhvE6eR55+r98YwaWJ8Yw5KbV8D6pPP4 wbP023p61WonUDnEp92RcrF+j0D0o5B0GZNLHs/QEwRzFRaGwzkybyEUpwB79T7zHldoKoHqxpC gnEUVlEsINYsS6nn8Y/Ljz+7k1EYAmeVJSpK8DNUbqIz5WNz0N1KcjcTT4g4CEISmJ8dLM60k1a IwX3C/GoJpnC85Y4lJbi0zUg6k+bNkYieyveFog761xALj0yiwrkKuaA8zubfg44lGOLljc5DDJ EEidoEO0rzGvYUAl9hSNMMz3Rxf9M1fyJWPZjBwVic7LW71kDQmxaS1/5cx9vF2+Br/2/+hVpAG DYNcfTC9wyfC5febOLdeELKKfZfhulQGuqmnVFRwPjyDnRYaESBfdmCP8jsOHUHFxkvFMHJx1Pp j/FLBqyUGSd97A9BE28+lp5wynygKuQAvcqUTbwaiMAnmRSwsbRoZjboi1mdIg/yNRe37qZaevm jsRdd2TSJnRgXZSp/GRWjVVZ5eDrDhnjOxiWbjWQp5EyKl1t/oF/EE5wsePZ7mtYe/wTiqEnwV4 WDIsUsrPjtMUj1vFDJi8IWtlA17h0b/m0HmIwKY7Ho3v7xX4OYErWuPPgiiRk+fCX7MFyJk2Lkw 8JQ2noxmc74JFEw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Document the new "--cover-letter-format" feature in format-patch and its
related config variable "format.commitListFormat".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
Sorry, forgot to update the docs. This patch is to be applied on top of
patch #4 of the series.

 Documentation/config/format.adoc    |  6 ++++++
 Documentation/git-format-patch.adoc | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..b91e59321c 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -101,6 +101,12 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 	Default is false.
 
+format.commitListFormat::
+	A format string that specifies how to generate the commit list of a
+	cover-letter when format-patch is invoked. This is the config coupled
+	with `--cover-letter-format` in the format-patch command.
+	Default is "shortlog".
+
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..bdcb5f989c 100644
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
@@ -321,6 +322,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--cover-letter-format=<format-spec>::
+	Specify the format in which to generate the commit list of the
+	patch series. This option is available if the user wants to use
+	an alternative to the default shortlog format. The accepted
+	values for format-spec are "shortlog" or a format string
+	prefixed with `log:`.  
+	e.g. `log: %s (%an)`  
+	This option is relevant only if a cover letter is generated.
+
 --encode-email-headers::
 --no-encode-email-headers::
 	Encode email headers that have non-ASCII characters with
@@ -452,6 +462,7 @@ with configuration variables.
 	signOff = true
 	outputDirectory = <directory>
 	coverLetter = auto
+	commitListFormat = shortlog
 	coverFromDescription = auto
 ------------
 
-- 
2.53.0

