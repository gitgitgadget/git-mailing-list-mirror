Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981E1487D1
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843376; cv=none; b=BUampj7Gvnc8PRqcC5Pt/x12JnQGvjrvQaw4B/2vBK7lCSmh5aga+EabF64IdG7UW6EFo8z+f4sp5b6ZAUJFCsxaUA35eHv7v7Pxs/rXze5XK/+FX86v3z/RAEov4p6Ju4xfOsDs5gRXb2N77mSHK6oJhx5iUP3feBytRIhGUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843376; c=relaxed/simple;
	bh=CoP88hG5sa9VNVTKkpObI1kTOiH3LuCmF6Anx62nLb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukfukORAVj94F0FkYhBy7vEyTh7ff+n0SwRaSfooomN3rsSLf3fAqDsvLFf04sTb8NLQzqCrhMK6dO6Rf5BCxHFGOZ8At/UmYf3G8BmUC8AsMigH3g92Jz31hy4VVJUuA0IW7z7w8cs/i1BlPxtOVOX6t/GaKzPyS/MXOXmjRJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zgJ3DuYG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AnPhhwir; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zgJ3DuYG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AnPhhwir"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D53825401A0;
	Sat,  1 Mar 2025 10:36:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Sat, 01 Mar 2025 10:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740843373; x=
	1740929773; bh=nUZub2ucFTZuqHsR/fcuM/50P1dmZTMhsUQnxZrFlF0=; b=z
	gJ3DuYGxxDYTuZJsWZn+1IMJaSQ2nEi6pr915m4R5ggCo7aHE2bIE/a7yDpLd87Q
	FbZTJuYgBceM+a1vAsM+Hynpe4pIGh1PMeIsscmWfcXSL2C1tsDtTVwVdE/KFEzW
	Urr/6XyR2nzn8pGyBaKuPXXWbRVqBxPMs2p36xb5YFjLHLdTntbOsbAwT4ZH3AC1
	2ichMdqTr6qd5aDzM1ix9KNw/dn3Pe4GBMDjjLZYq+aEZvX8W0fCTAxpNECZecqA
	9TJ9++EsgDani7sxz4iC9/pZf1GcPiH7OAAF2LQpoDlfn4I34KSpmyivVphDtFwe
	JveqGlsc2gCXsZ0Q8jaVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740843373; x=1740929773; bh=n
	UZub2ucFTZuqHsR/fcuM/50P1dmZTMhsUQnxZrFlF0=; b=AnPhhwirPXPpKerlD
	YC1khKRCwIp9RFtTsywfRiaSVQZT0e5QMLKEfhq5dLBwwIRyew+pJKfVMb4r5sJW
	gz3RyH0PBZnzwRC/kUHwUWIsNnkG7BAKu6sNdn76x56b6Z+vYDcwRiaceODTjP4b
	A57627cNHFE7VL49lxJzedsZTd8qxediU/9tBPUgu/NsUuJFBy6IZjyUKukf87O0
	UnTTdpSWcBxAMRb4k4Xlbm4VmSbKXdl/FtC+wF4Z2kLyDO5hEFtk8myLpeEDNTFR
	cHTlegCsLvagKeg/q1vOMpdaut0aSyWmjFpTPn1fPSyXnnCk50Q5YxNl9kYi4CxI
	95DDA==
X-ME-Sender: <xms:bCnDZ89i7sgUbIDDNrfKG_oCbEJeEmXnfOi9-ZesHdFZceHrX2wtag>
    <xme:bCnDZ0soEJu-48TA-t9zx7tNujGUwlsmj-H2tfDt8-toT1z0xbK5DqlGhpHOsl2Hb
    jv_M3YsBnklS2OgxQ>
X-ME-Received: <xmr:bCnDZyDimLBFX-lAR5U1TpgutmoxxYPwC54T9417-hbo7IJwFwyU5GCnf1houjdzeOZiD4-UYXfMkxB8FXxfjVd_Jbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bCnDZ8dzpAYIYtyfZyiTtqiPqClHO2YS7WizkkK-9cZ3-uhHMhLSGg>
    <xmx:bCnDZxPawR1RSzTST84wYxfocUGXp5X_mUkg9sBETGEdzfxnYRJxRQ>
    <xmx:bCnDZ2mI4dkYxW7UIcnqPoeM0hY2ehmcA9yrhT_HbQsaibkye6BzFg>
    <xmx:bCnDZzv8_qa8ChQM0RWWfjXOgA3ud6qyKjdRpp6YoCmlsFs478kSgA>
    <xmx:bSnDZ2q3_1OgINnLlqXn1Z-vxJ99n7GcZGxMpA8DbeCAeEaE7t2NP4aj>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 10:36:12 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] doc: update howto-index.sh for .adoc extensions
Date: Sat,  1 Mar 2025 10:36:02 -0500
Message-ID: <20250301153607.95746-2-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250301153607.95746-1-tmz@pobox.com>
References: <20250301153607.95746-1-tmz@pobox.com>
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

