Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1F212B1F
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547556; cv=none; b=ZiA2qqf2QKFnuASQlfAUDsWPdaE6HDFT0aDZnVRKVJJig8OEqGzLXTUUp2w19hmR+eyDNn6pnc4JXR4HetlrRejskFH2iXZZ9v4usrHZgqFNs3l2kfQDauQaBvprRfetm/Oj0fVsUEkGlPlQvES9aoukppKmGogorP2B0G3nziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547556; c=relaxed/simple;
	bh=OJgDr53N9mr9neTmn/NxZo907K4+s7jNEqhCEZUOC04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6l3BlVko/rdOwcNLhhgHD28/wu516jiXIiKr5S5Vad/SKvIzTxJNctuEoZUmFgBmae9pJuYWwsbBf3MoxHzDEwi7TEhzPKgaSHgwRcylMgBv5xn9sIQhGACqiO7ThCxJgYNNyf9oxDflKE6PJl4M20goAUFCC9ZQF8v7WkR2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BJaAK7HW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wCO+pN4H; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BJaAK7HW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wCO+pN4H"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 499CC1140141;
	Wed, 22 Jan 2025 07:05:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 22 Jan 2025 07:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547553;
	 x=1737633953; bh=fUZzubkqQmpkkKUta1dfLjqL0X3NP0+/cAhn6g57o0o=; b=
	BJaAK7HWOn0nV7x2bR5ZZahPwN+8heb0vBKDjp1jbHevmwEEXGesT9NDGRuJOx3n
	JPg5d0/T1VzcAMaBj9xWKgrl5IJiIScMsOa17wXrAfXrA4efLSYE6FqmWDzL4H+V
	+SZdKHKg3UOvmW+xJxoCEmMV3K3Nw/YMvhy6y9g0qACEX1vaVfDL8LRncwfm2FvF
	1Dw47bnysBsTuyhg2Hs3ehsicwR1mDg8KQbrfA7Ncfm6eoYJw75UG0E+bq+6NWQP
	8no8ewZLywKOzZV885AojDAm/TC/JjeZgB8eLdPg/DqWWx+IXUBQU3KVh919hZ8z
	knEBqWL+fDyUsCQ3QNsBug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547553; x=
	1737633953; bh=fUZzubkqQmpkkKUta1dfLjqL0X3NP0+/cAhn6g57o0o=; b=w
	CO+pN4HfYtQLADjC/PEUuqKk2GDwbVL+6RNFTnGqHe2GM+CTHi5ySlINCyfK8BW1
	xxPXnZXOOt3dZ+555v4GJlFsgTUOfj3Qc7b8jwwYrGb4u8UHKWWWmbZU52tyMZPv
	h1J6tbpnpOMBfmAJDdl8TmXcv5JWSJDWNdg8/UXmFvtLSFjYrxZ2mA7PZfzRxtJ0
	IJczogvXyWttkwinSVQE37jI2fnZNRnahnAhPlBVCUjUo5vRbrVUNoT0qmmhJ97r
	JKpp2pTVhcc65pg2KjTVdDNdHYpqXMVVnnZ4QVqLr4jLXXtfwetpDlNpAMZvkbO+
	igXU8Rkoq1LSll4/pPneA==
X-ME-Sender: <xms:Id-QZxTakAElVW-7J6CcseRciLrYW-Flku0IkzSEjoL5YvIEUW-ddQ>
    <xme:Id-QZ6zuAHn8acO5TTdF7B3nprbvF7ZhgViZ9cLr8BXmagP_-UHZzbu00rH4EYNKM
    8OSq16SBfWdvejZsg>
X-ME-Received: <xmr:Id-QZ21_xIEiPIHVOTIhNGjo7_eIOSNjvb9i2VR4twBhpJBAPGh70MJOhB8WDXM7wN0l63iKiDAoefJcFptbFxZ3XJje9f6_ickyK1hFgZQo6tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmihhrthhhrdhh
    ihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdr
    tghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:Id-QZ5CbhQ5KAI9s9IBt45fYt884i9K2FAfnTfPmS2_OPkqkImlBSQ>
    <xmx:Id-QZ6hgqr0iBkhBQZeSF1cIt1uVjEGKm4gh-q6pBb_jK9Hsie_Oug>
    <xmx:Id-QZ9qzKCCSQoSq6d5DKCxScyZUzZBQOrHmdVFdrO0BpSnCtKWJbw>
    <xmx:Id-QZ1gBgI4wqKuMAmmREag6KBF0jyJjAmSvPX_XK9EkemVsPrvdBw>
    <xmx:Id-QZ1Xs-INnn0uctux_ivM9gCZnmsmifMoM9nBqqrYOkF8AQXQS07NC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 570da590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:45 +0100
Subject: [PATCH v3 02/11] GIT-VERSION-GEN: allow running without input and
 output files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-b4-pks-meson-additions-v3-2-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
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
index b8b683b933..9d201a98fd 100755
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
2.48.1.321.gbf1f004a4a.dirty

