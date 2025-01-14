Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D0234CF3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855782; cv=none; b=TuEhulz68UAS+Y7JkGG0z4E8IiJ9mA61kuRedInoQqE9XPu/uDcSVBHKsq1cyQICNUDDB8U0O26WRq9HFK/nMslY6x6qF6SXqAwX8xWwbi+24ycHcARCOo3EwceHamisMUP9rsVFNbtn3wzkyceYBgZJhuD5L6JnzfL+ZtCVMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855782; c=relaxed/simple;
	bh=eNmMP7xiuRZzPfxvWj0JrXYlRpEoBdJJmLY4EnD7vAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBU3pHEmegjXOIs8vMC5pbHca1BWbSE8mTIjo+YRJcv3MWe8cUkSZWlEJhItq/Alp33voL7eNt+xjadfAFGLoGSNQyLm4zPWTk+x7iI3SFVOUilx5lqnCO7/MJcUH06NjkNhAlc/IWiX6lj4nbMWCuriaaV2PjugevXslUQrU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z5JEbkMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAmNyKNW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z5JEbkMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAmNyKNW"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 528371140161;
	Tue, 14 Jan 2025 06:56:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 06:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855779;
	 x=1736942179; bh=hPMlmK8xuzjkpL6Z16LUUBfypbQatgwbb69UZoqwT3o=; b=
	Z5JEbkMo3AI/orW5Y3kzafKpl9gBZ59Xyxj3yqXokGv4zCs6j9YIe9cB1CPz/YzE
	VQm8G0Rk6s3wfS6GlnsTz+MnWHUxgMjNNvcpRp+G50x6fi4ApjgZwt2I/pPE/lwj
	4SR1tAxQVlPLLIIlZlqxRt3lYZZwNLHOvi7UJjkI6sOfbxKTdsLoSZTzCZK71Vee
	ZlFLR7zuUgKXvcU9CoJmPuYuMoaA+yUJfB04WEum2C5ZE7pxAoM6moO/5A5FdYH9
	f8vWfz/evlrTuCJ2qz79ePG5pZxBFP8W2iVS4NHjq3LRf7++NjdkgURjCRGnj8vA
	vDUKBOihjvNrRo7jpOrllw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855779; x=
	1736942179; bh=hPMlmK8xuzjkpL6Z16LUUBfypbQatgwbb69UZoqwT3o=; b=e
	AmNyKNWDW0tVSjIqvhpySzAgY7RbLwQcKVJ9a9GGkHE2Pd90NQ1YLKZggeNmP0ZI
	k1ns+B09+yUYv9hAor8DHejMzm7Ytmsk+v5VERXm0HNUP2NHAlXiOecoW0PHroBy
	uRWy79IWpKAjbrjIDWpU91PbgoEIQu9ApYF2wmGbEeAee5XB/+h7ALj6CaAU6v84
	zsSq8s2BlR6O/tGGZw8ws/lF0rBQYjTe7kjf4mBPyRchb68cWcnPx3KwFS2s5bX0
	KR6FoENnl69XNnX7y+hAbF+cSMiGR7K1pBtQi6rd6Gk9e0uBPBqSI3Empvph7Qlf
	9apeFswz3hKROxpDFA0Fw==
X-ME-Sender: <xms:41CGZ93gwEb-ajbFrADgydnpJdf-x7dwaB_4JiYr5w8nK013ZPHWfg>
    <xme:41CGZ0Fo2KO-VNGkN2R0oji0VbjyXnxeTUhnAMYBT-K9UdPbbUD3bWzK35B_tgJRb
    btiq1v2lCpoFHuDvQ>
X-ME-Received: <xmr:41CGZ94hG6IrGvh4-qwupAq6hzjFT3fke3duPSbCo9c90T-0n1PSbzcIG6lyYV43dcM6oFg2OteHJN07Tdx0Ba0Jvspp91GGpPCIAuXgr7Smcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghvrg
    hnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:41CGZ61Lhmc4qLUoUNgFnS-8u5MP3TIWclWpv1BOxYflA0gt-ePiWA>
    <xmx:41CGZwFr68EgJqb5ofWIOZhwpCegwlB-RpH6LGueFydl5L-4sAXJ8g>
    <xmx:41CGZ78RMhfFEQQ7DwiMSRNyl6oo2ybxOYsg1K2WmmHjS2JLFWfLAg>
    <xmx:41CGZ9m59EwJF_IzLBlEzTgFXgsR8SSGh3Nf1lzJzrTLbmvzB1Dz0A>
    <xmx:41CGZ1N9oE1EyCPdDkxtCw1N3hNwHkyCkSDDHbpSY2QIS0sfAp-TP1iE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64589ae3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:12 +0100
Subject: [PATCH v2 02/11] GIT-VERSION-GEN: allow running without input and
 output files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-2-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

The GIT-VERSION-GEN script requires an input file containing formatting
directives to be replaced as well as an output file that will get
overwritten in case the file contents have changed. When computing the
project version for Meson we don't want to have either though:

  - We only want to compute the version without anything else, but don't
    have an input file that would match that exact format. While we
    could of course introduce a new file just for that usecase, it feels
    suboptimal to add another file every time we want to have a slightly
    different format for versioned data.

  - The computed version needs to be read from stdout so that Meson can
    wire it up for the project.

Extend the script to handle both usecases by recognizing `--format=` as
alternative to providing an input path and by writing to stdout in case
no output file was given.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b8b683b9337e5771e14a2cfb84022a11489bb432..9d201a98fd2766911544225c62159cbfe8dff5fe 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,21 +5,29 @@ DEF_VER=v2.48.0
 LF='
 '
 
-if test "$#" -ne 3
+if test "$#" -lt 2 || test "$#" -gt 3
 then
-    echo >&2 "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>"
+    echo >&2 "USAGE: $0 <SOURCE_DIR> (--format=<STRING>|<INPUT>) [<OUTPUT>]"
     exit 1
 fi
 
 SOURCE_DIR="$1"
-INPUT="$2"
-OUTPUT="$3"
 
-if ! test -f "$INPUT"
-then
-	echo >&2 "Input is not a file: $INPUT"
-	exit 1
-fi
+case "$2" in
+--format=*)
+	INPUT="${2#--format=}"
+	;;
+*)
+	if ! test -f "$2"
+	then
+		echo >&2 "Input is not a file: $2"
+		exit 1
+	fi
+	INPUT=$(cat "$2")
+	;;
+esac
+
+OUTPUT="$3"
 
 # Protect us from reading Git version information outside of the Git directory
 # in case it is not a repository itself, but embedded in an unrelated
@@ -74,19 +82,25 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
 $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
 EOF
 
-sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
 	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
-	-e "s|@GIT_DATE@|$GIT_DATE|" \
-	"$INPUT" >"$OUTPUT".$$+
+	-e "s|@GIT_DATE@|$GIT_DATE|"
+)
 
-if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
+if test -z "$OUTPUT"
 then
-	mv "$OUTPUT".$$+ "$OUTPUT"
+	printf "%s\n" "$REPLACED"
 else
-	rm "$OUTPUT".$$+
+	printf "%s\n" "$REPLACED" >"$OUTPUT".$$+
+	if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
+	then
+		mv "$OUTPUT".$$+ "$OUTPUT"
+	else
+		rm "$OUTPUT".$$+
+	fi
 fi

-- 
2.48.0.257.gd3603152ad.dirty

