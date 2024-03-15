Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD645376E6
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508945; cv=none; b=lz08hhe9/Wp0mkybq2wqgDmDXBdmNBIOEjck35Th4i7BhPtEMrFgvqUQQTzvkcyDtg49S8dx6Fy9G9sj66AQA1iz19/laLELG03+PBTK6FlMs5qT2Wqdw46lPiZMGYJhMUBfHjefzJndp6dfzc4H0eV7LERDj0NJ8hxXDquMOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508945; c=relaxed/simple;
	bh=1Ef/rV2XBUkFYHC1H/QnmhT1MchVMEzS87Q91PftKXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HM0RV0ugN2KOSkHPOVJ+QeVBtrU64/oiFKZAC2tqEEb+m0PPVkWtYSFoVepZ+i9hB0PYqE9byjmWjDnoO3lbfc9HWgL91bjWs30V11hu5rAYUlLff6f6zr5bMR4T6+w7WhVOOnqxbXy5izkzbPV8T1UsYnkBsKQGmsbEfWM77fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ZzhVuy11; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ZzhVuy11"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710508936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2A+F5zjzkW3ogS75d/ZB86Pfo3/d8eCQTXyAym7cZBk=;
	b=ZzhVuy11xQuJ6yQidPs6LVNsjw+HK4yibHI8wwkT5/kaCzfVqpZ3CydBTEG6kpAQPafSQ0
	XEUvDI8uVtROFa6QLDmw/JQaM6ZK/D0cAfgFuoVYSNIDknxyWThdtlm0gfi7ZP4967zJC4
	nzbgBW/HB54B3EOqAKF/2XOeSoO83hc11XCtnMFeGSiugdvWCKPCiciApo3lpmyENd3rHd
	XO44aGTHnsyLDfYgdbwhQLzGPI4sEIU8KsLEFxFXTyp0uHKwsgh6h1JqsmSOw7jMiZdzlX
	arPi2fK7KuyFv6UscBI6x+9kFv494J+D/zPms7O/xnyy/qRd4hXVzhDpD5M5VA==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 4/4] config.txt: describe handling of whitespace further
Date: Fri, 15 Mar 2024 14:22:10 +0100
Message-Id: <d310d8c28baaf9b938f7ebbbf534997364c6f6bc.1710508691.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710508691.git.dsimic@manjaro.org>
References: <cover.1710508691.git.dsimic@manjaro.org>
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
