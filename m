Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9223FC3
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714449; cv=none; b=mfHM9Y/Uj9E/pRfRNuxWnF4c/UsFFpVB7uaA4cBzVvfBNp4BYpvJoNhUle1MKUvX05lkmCMgmN98h+EwN5Zefuu/7eTc1dVNtDcu3gDy9rPJRzjsgXFdkk711l87ejbp8lQNiWunastQjf3mbi6FOTvW2vpN2jQE0pkmnrg9Mi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714449; c=relaxed/simple;
	bh=CoP88hG5sa9VNVTKkpObI1kTOiH3LuCmF6Anx62nLb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VenJa8u0MLKvBcjoqo9/cR+XeSyxxkH4FlTE+fObr9iawed7n0xwi5w0KkMRyjPLQ5bJeE0DjahN/SFp+DvVq+R4ICcUmdHKpwBV6Et1Fne/saw7/P/uXS3rGOiqK1gdQmAjhw+WLyxmwfiGm/8npiEsSKbWG29iroI9Ou0MzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q/hWEUDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOwpEroq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q/hWEUDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOwpEroq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3B0B1140155;
	Thu, 27 Feb 2025 22:47:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 27 Feb 2025 22:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740714445; x=
	1740800845; bh=nUZub2ucFTZuqHsR/fcuM/50P1dmZTMhsUQnxZrFlF0=; b=q
	/hWEUDzD6Hw02pP1t3ONIaV7xvSbieqCSWRZ/sK1pAN/jct2b8To8GglNJYwZyCT
	6SgPMPDWk1pwnSv86R7gO7evIJSY4TzNTvyhYPEp0w+gHBhMnJ5VkRrI38YCnfuq
	WXqc31pORLti3QGyJjeBTIvbf+St6ZjUh6nkPL0UBFfvuTWk2DFrze5QtxTSPo38
	7pwc7HZ2yTPptfVhmg4hI6NWk6PtPRfffLhLDaiIzwsUeOpr+FfYd5Znd/q4l7JN
	RrWPTT/j327PtuhG2M3+J7oRWd7cQD449VWm2C8BHLMFsfm+namMKRpwIXGTASRp
	xgcZac6bSOOmchae+ptQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740714445; x=1740800845; bh=n
	UZub2ucFTZuqHsR/fcuM/50P1dmZTMhsUQnxZrFlF0=; b=HOwpEroqSXmkNox/j
	lMzjW+bAGmvafD8Dp7syLt0BpqVmQAebW18xQ4vtZss5ZBcXLGIaTqRsEn/RXmWC
	6c1WfnIwZ+d661t8VJZuOV0yGZTzpx/I6bgJ43wwKOf41uuugRkHEIdBH7gu0O2e
	rHgXmsJBazvW2lvxEu6fZQHPwp2RZxmvaS2azSK7c5L8ICzx95HzeOK9rF2mUnkW
	kZdBIar/eEFmM7jVY11UbnvIkpTfN0MbE1XEWaXskf98bNbXUkxE0ilVb5RAThwE
	94JuaJ4AxwNqdpPMGnWEJJzUW+MDpkYFcPi4tURUBreSJdmprBWT5xJM8kFHmyow
	yqhIQ==
X-ME-Sender: <xms:zTHBZ7j2W0k2Qux7v59eSy2KTteuejy_sUN56kLLUkzj3gPeSnNKFg>
    <xme:zTHBZ4B4ZyUfk2ATZV7imKbyaAeRmmv-QFjYgfyxJFbFOOmXfT2B2qLbuWjyB0uN4
    zqjiipn7xjWNImtnQ>
X-ME-Received: <xmr:zTHBZ7GmsfBpYQpuJtgj1a89__AzoqvHgGHTjnu6HBQMxmBk9XVGyYrOMwn_lz6lyTBADBzuXZHzKgKVu6-mK698m7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zTHBZ4RrdoVEYEj1skq1M4OVBS_FJLcqilX-nDqugTHQd7yHxoXWRg>
    <xmx:zTHBZ4wj-AmMZS2-IXuV8QGu0Xz9kTBnAdAwfbIm3rJJYaXEcO_lEQ>
    <xmx:zTHBZ-6Gjdz116qz7ngRGC6B0Qct44uvTmbkD0shDjM89RnEe1jLfg>
    <xmx:zTHBZ9zYgUmrPMN8XCBt3qDWf7CjMQK8aPGBehx2AcrY4yb9OqWyTw>
    <xmx:zTHBZ0-cGo2va95axF7cJSUQtMiuvcS9eSzdmLyqce7eyc7o_tbmbnuE>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 22:47:24 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/3] doc: update howto-index.sh for .adoc extensions
Date: Thu, 27 Feb 2025 22:47:04 -0500
Message-ID: <20250228034713.203461-2-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228034713.203461-1-tmz@pobox.com>
References: <20250228034713.203461-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
extension for AsciiDoc files, 2025-01-20).  This left broken links in
the generated howto-index.html.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/howto/howto-index.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/howto/howto-index.sh b/Documentation/howto/howto-index.sh
index eecd123a93..ace49830a8 100755
--- a/Documentation/howto/howto-index.sh
+++ b/Documentation/howto/howto-index.sh
@@ -9,9 +9,9 @@ people describing how they use Git in their workflow.
 
 EOF
 
-for txt
+for adoc
 do
-	title=$(expr "$txt" : '.*/\(.*\)\.txt$')
+	title=$(expr "$adoc" : '.*/\(.*\)\.adoc$')
 	from=$(sed -ne '
 	/^$/q
 	/^From:[ 	]/{
@@ -21,7 +21,7 @@ do
 		s/^/by /
 		p
 	}
-	' "$txt")
+	' "$adoc")
 
 	abstract=$(sed -ne '
 	/^Abstract:[ 	]/{
@@ -39,13 +39,13 @@ do
 		x
 		p
 		q
-	}' "$txt")
+	}' "$adoc")
 
-	if grep 'Content-type: text/asciidoc' >/dev/null $txt
+	if grep 'Content-type: text/asciidoc' >/dev/null $adoc
 	then
-		file=$(expr "$txt" : '\(.*\)\.txt$').html
+		file=$(expr "$adoc" : '\(.*\)\.adoc$').html
 	else
-		file="$txt"
+		file="$adoc"
 	fi
 
 	echo "* link:howto/$(basename "$file")[$title] $from
-- 
2.49.0.rc0

