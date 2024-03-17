Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFCF510
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647305; cv=none; b=LHU8aFAJVJ5SFqyu9azpzjph1sfs6a8AuZD98KBEwoV4r6zr8TmH9XWn3rgDAa9lYbuRPUBZROOV/DAGCu6KHxGU0DYSD6nk4J0y9XHN+T8MoPwOHq3EaQGk2aGHJIx8BvkXeGsMf0fLmQZgUXFNsBFTMUL3HoZeT9ndKKaJKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647305; c=relaxed/simple;
	bh=bfMqUooiRw/RNsr33+IRAqg00ygPGTU6NapqHVRDudc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1PWB1DGbFp5Ff4k7tkaSkFnS/YG86ydR+/RxrzJb+EoV0QxXWjlmLewscbgwFQV6iR2zDLGUK/+YRKFD/lRai6jiC/FQ/BMDCfVqOoDfMVYF64F8fTfvWuO1T2S1A3bIrSQHFm3dZyS8O9K5GNqzpQ9+VximBIXWd5Nd+bG9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SfBsc4g9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SfBsc4g9"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jv4wuO2E/x/EtdlWKN3ptgzVZrIQ+2mVNL2cFUHWO4=;
	b=SfBsc4g9K0Ppb6/fA36cybxZDyQmq83/nOH6d/Cdaw0Zfry7I2oecUR7ecyDwpJtkYXgBc
	ihpEurAOu9DQ0QFM1G7O6h3d0MGCQjsOOrelK2aCR5kve14Dmym8vNNqIxJUUudarMaCW2
	W0npLAHXAQw2u0LAHEqj8DnpflPO8zwkcl7wRhp4JiCEqW8Ewk2PlzD8/542eBYs/sPAEs
	0ayM8qlL2LZZN23Cep55dTyt1kJX5jK6t74farNGAJqgvAy4tsMyzbYP8mhUlAuDGdd+GV
	Eyf2nst7mhkddou80aEi1hdwyoUNdxcVx4gNC5QLMYljUd4b9pNbXGmlrMLKOg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 5/5] config.txt: describe handling of whitespace further
Date: Sun, 17 Mar 2024 04:48:05 +0100
Message-Id: <041e0bb6fd72d12318130e7010a75dc8321e2d34.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710646998.git.dsimic@manjaro.org>
References: <cover.1710646998.git.dsimic@manjaro.org>
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
configuration files, and improve the description of the trailing whitespace
handling a bit.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
        - No changes were introduced

 Documentation/config.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 782c2bab906c..20f3300dc706 100644
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
+in double quotes.  The discarding of the trailing whitespace characters
+applies regardless of the discarding of the portion of the line after
+the first comment character.  Internal whitespace characters within the
+value are retained verbatim.
 
 Inside double quotes, double quote `"` and backslash `\` characters
 must be escaped: use `\"` for `"` and `\\` for `\`.
