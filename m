Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C558AD4
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258966; cv=none; b=iEbfo4SI9hycOpqb+eChnMB7RwsFfWjBq/Bz/FMFYWCUWSO5S9cFKEssqz3hJHo7Q48ZEREKUp59uQrKk2+9gPm7HuSvtJvnsqNzNzwQ36Fei3q3oonOpZ0YHBzJVTMx0KwsUMldsgdgWeOsasPNwkIyLNh9NLqq5ZLkoW4pWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258966; c=relaxed/simple;
	bh=fxYyDC8OzIaArvqfrguKgyDnp3O4i/e8FloEHfVGExs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUDueJqvRcr14CL3UYEpE6VNJqH4pBfj7+stactWJtMYvFEv2rtVk8JLoMdcsXTmGn2X6iASCHbhCoAeGVEkuKASNPVzhZ8OqKa57gtlBT2Ylkog2RN1c10ek8aaXstFJSjxtwkjnbP7VPSY3iFfM/Ic8xzvosSZdsAayH1Mfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ni9JFdEr; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ni9JFdEr"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710258954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35VwkdjCMUKWvPMNgVyBpq2mZyx4ACeeruGwIiODmYM=;
	b=Ni9JFdErtAFCrjo0o5BBUg7+kXBNPWNhYuYv/1vFMm7ZCRxbm9BIAofOimtZtURdWawtBk
	PKr8shPKIpu+yoW/fMlUgVqxIrlxMKRwrEb2C5NxOCAn4eGXUGe+ikeLIbbFISSYkaGDpM
	E902+fecUma/vRFuLvf4VdHDjz0Njn4K6WCU9AFMeDiAlj3sqOml/WvC8ftsXg6u8N87bl
	Zp9bLsO4nKLPaLwIkxqfPMb1rog2ELp2HIF99zNgtlpR6POUitcABWAT93XYbWByWPlVBy
	fKmR4GkxJjHSQD8ggwIaqgQQ/FLNlNiST9IE580/VYc5PJN5qvHJZuuwECfJ1Q==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 1/3] config.txt: describe whitespace characters further and more accurately
Date: Tue, 12 Mar 2024 16:55:44 +0100
Message-Id: <1c670101fc29a9ccc71cf4d213545a564e14aa05.1710258538.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710258538.git.dsimic@manjaro.org>
References: <cover.1710258538.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Make it more clear what the whitespace characters are in the context of git
configuration, improve the description of the trailing whitespace handling,
and correct the description of the value-internal whitespace handling.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906c..4480bb44203b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -22,9 +22,10 @@ multivalued.
 Syntax
 ~~~~~~
 
-The syntax is fairly flexible and permissive; whitespaces are mostly
-ignored.  The '#' and ';' characters begin comments to the end of line,
-blank lines are ignored.
+The syntax is fairly flexible and permissive.  Whitespace characters,
+which in this context are the space character (SP) and the horizontal
+tabulation (HT), are mostly ignored.  The '#' and ';' characters begin
+comments to the end of line.  Blank lines are ignored.
 
 The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
@@ -64,12 +65,14 @@ The variable names are case-insensitive, allow only alphanumeric characters
 and `-`, and must start with an alphabetic character.
 
 A line that defines a value can be continued to the next line by
-ending it with a `\`; the backslash and the end-of-line are
-stripped.  Leading whitespaces after 'name =', the remainder of the
+ending it with a `\`; the backslash and the end-of-line are stripped.
+Leading whitespace characters after 'name =', the remainder of the
 line after the first comment character '#' or ';', and trailing
-whitespaces of the line are discarded unless they are enclosed in
-double quotes.  Internal whitespaces within the value are retained
-verbatim.
+whitespace characters of the line are discarded unless they are enclosed
+in double quotes.  This discarding of the trailing whitespace characters
+also applies after the remainder of the line after the comment character
+is discarded.  Any number of internal whitespace characters found within
+the value are converted to the same number of space (SP) characters.
 
 Inside double quotes, double quote `"` and backslash `\` characters
 must be escaped: use `\"` for `"` and `\\` for `\`.
