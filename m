Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF95A0E9
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800671; cv=none; b=oiMDPrLXinDqR9iglWOZ4seKri/m65uhy6q+3I3GWuMgCmAxVSwAan82XQJ+2cTR8a/uiX73gEkVVRfG4Z9q9qIgNvQBwCWtfRBRKbNtcHnlZwfSVSw5WgobwIanuHbUvVPPyrb9xSOnARwFKReJL/USnwsiiy760BkqfIgsvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800671; c=relaxed/simple;
	bh=p1PfeyuxxycBrbMdREyxM1PNgEic96mNcz1+OhApmRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcP7BelVJQAJ3WfdcEoJZwIO2cFR9DH2kZD7xjOaBNbWW0MFeHsf9sCGpWcsjroFKsJYojg8/Ha6GcE/xpMlO9VrI2KxbHI7/m504Ao+KKIF3nCqPWr3MKt/KWZ6Qc5vVI1PrXZOqktGfaqfokFkL9ihr4J9P9sK/HguTRDM6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OMGd85Kc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OMGd85Kc"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7Pd1vNNG8RFCIEeb3W6bTh3erqBwKPwxFGU4RXDAKo=;
	b=OMGd85Kc4WTT2TLyZbov3gw3KybejIZdFgs5E4EDzOTZalOSAmBSZCV8sEY0nHJR9T0b1I
	8wg18MC9TPsjH34Uf7+aiNH/grxoESQNC0tU59dckf3BOKnA0v8dweiRdLu1jZfDJqwkz8
	M9pSsUw12Z9BcbsL4MmrSivx+jz3Qtt47HD4nhSv/RnEu9ipcwSVxdyEEoj3F1OLtKHMqc
	OZpZFj1x+2k8FrjcsZ8334UbR0oXvtB6jFSiBib5KYoXU8yelj1uRf7ZT/gPdXNin6ZoP7
	pyfTipYb7Y7qm3mgMpL1HcPD1EFyT0z5RmOAXVwtNny9Qp7lNmin2X/W1TeUJg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v3 4/4] config.txt: describe handling of whitespace further
Date: Mon, 18 Mar 2024 23:24:22 +0100
Message-Id: <e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710800549.git.dsimic@manjaro.org>
References: <cover.1710800549.git.dsimic@manjaro.org>
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
handling a bit, especially how it works out together with the presence of
inline comments.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v3:
        - Patch description was expanded a bit, to make it more on point
        - No changes to the documentation were introduced
    
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
