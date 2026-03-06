Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD809366DB7
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837948; cv=none; b=qj5SkV2lVLBKyyhlH53FkkAlyhMZRlV4Url6fqVLQFDvqQlyJKXpp3cegaeZnP+yyjOFm3aM7O1OKRRzuov9IZFOoLf3DzoYxiZV44vA+XWGkyw/v1xPS81UWHstBMEQTzmb3yWEeHWjYatE8KmAaCZxBGHOo+EZN+cEmtAvVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837948; c=relaxed/simple;
	bh=PXirJdir/PPjIba97KosW0qWoEwe+LhtGSwvyAfUMVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYz1Op7AeVkFIo+oMsPIIJO9henlaEjJ6FNLvLOhOMn08E2M3/gaAjydDmXwE/P/NDIgjtQt2lqv4tvapwsCulkyRhDFv31keFOPxeUPQJR0sOZ2frG5WDl6hRqKceSxEiYn+pHI1aHHE6zkhXw+Ixdgi4D+mD8FEhmbIEgX8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=LOfExP4B; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="LOfExP4B"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CY2kxmRyS/gEJIf6cwbrxf6Cu/ceRExm7it3Vyc9yM=;
	b=LOfExP4BWzFD9vq7HTsKJs/1squX1P9RFK91QPSmsFu2kMKEFmzQlGYtqADKG+nFAUKlUJ
	QEJJ2JHGEw1fbHoGa3RcQT+geFfz0SRr2gP6SmMKh/R68HZWjQBysP0rZFded1dYBThUCU
	15srjTq9wSMcEApl3kv3MzIkiNMSqC/BaY38E7Q9m5pF6IxieCZ3QRZvvEEHwb2sHpjePO
	VxwIVdDwYGaRhlwtQTNeo6jYjJSXHBDHWLmwy5prxACRPgqcHAOKqlx8GD6NVD590id7uk
	w+V/9eifkbWLfNP+VHnbyQWvxSAgzHB1950BKxdvXf9zIY58XHkF6x7fsyxrjg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 5/5] docs: add usage for the cover-letter fmt feature
Date: Fri,  6 Mar 2026 23:58:48 +0100
Message-ID: <1a4ba6dc338e82df1d58c277031d3ec2ec2ccf83.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space> <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=mroik@delayed.space; h=from:subject:message-id; bh=PXirJdir/PPjIba97KosW0qWoEwe+LhtGSwvyAfUMVU=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v9RMOS+5NJhMhnNzjem8pcjkKytbKMU5qvP 5/6iezCtgmJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb/QAKCRBIeX6hnBm+ 0ZY3D/9rQjv8EwdZ7FBpryZzbb0E2hbb4nuTY55ZSGcTPigSG395Y9l+ZE83g4vYMJUk4MFyiJu GJpRRQ1bhJIUM8UNwFIBc3LFvl2/zUFMLYRoDUyCkFpaHa/2vroQIetWFwF2rHvsYv9T9kImtP4 /IdI6NSq8MwL/X/gtElYxHCCyvGC7tZdxcIlAz4ynZXkyuKh8tRE14b4Zn20XCNPixNZUkIZbL2 EGmrc25+/B52XPtTnHF8nSamC8QfsRWjg8EXGYwH+M91c9LiiL79CzDVoxqJ5kX+KfI5cixZhFD C8vYNgoh/9qGrROwpwZzrI3y8G44H1rEEo8E0oPvONnTKZ3k0UBAiTx5EFxLaf+gx5UgeTj4mxx 8ngPXyliJMJG+3ThKHIA3q/OTmYJyzCAQn0LO04KkdjYPLYEzTtxHg/sMsrnuTZ3N5WjbDaVvVL Bm3PksXUJyJ8wEuHdhgsSYnXTWHWiX6SlURwZw11X5TiJHjpjLZ50EFn4yfEdEH43eKpS2Io6K7 DBpjFf96qaPgAxtTjIr1mhJ17VdidrZbYot5krJi5iX9FAQyCiEMUGfLxKcdLoUDXRQRulQ++CA JiSp2C/2St2UuHLt1JRoJDI9s2aJK3zsm6vxQKNEAaHtLL0G0xtd4PU/IeECN8/Er9X09IRdGKi XUZi8+ZiN
 grfqAA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Document the new "--cover-letter-format" option in format-patch and its
related config variable "format.commitListFormat".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  6 ++++++
 Documentation/git-format-patch.adoc | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ab0710e86a..151e574052 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -101,6 +101,12 @@ format.coverLetter::
 	generate a cover-letter only when there's more than one patch.
 	Default is false.
 
+format.commitListFormat::
+	A format string that specifies how to generate the commit list of a
+	cover-letter when format-patch is invoked. This config is coupled with
+	the `--cover-letter-format` format-patch option command and they both
+	accept the same values. Default is `shortlog`.
+
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..42d2633860 100644
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
+	an alternative to the default `shortlog` format. The accepted
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
2.53.0.5.g1a4ba6dc33

