Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE640281369
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540768; cv=none; b=AiiAGBQ3lAOeXfybELmq86/Iu6ZEMr3jbS5MNzJaQh8K/LNhkT+Dfjr+6CL92AG6H8RcZ5Mx8ETEkqeeR6tKiqsFdGzsPoudNVB+kmCo1S08J1WImFU/AUKpfrUlQUJ7rdesR9ZFTdYhkI4k1l8opAb9nLzY74Gh6159NYQPtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540768; c=relaxed/simple;
	bh=hP+3tXRIDJuk6CI/2QBdtBlSXyk7OxPLwvcwvNFXoFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTjYrCn6FIqWKoj0q64Jaf2LZ0Yx+LZIFNnkdIH7726OiOUQKeMpKcnLk6WcOmpNUAP0afZNQg4x5VOHMzOh1MVvQxinnOVelt79ovMjsp1O59Yqxb/g0GfGTFoQ0tQMTFdGoRwwKq64nU6o8Mk9IbolNlwCLAfVN2pE5/2N7is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tDF1dDGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=La9muKUS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tDF1dDGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="La9muKUS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8BD811401BA
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540764;
	 x=1746627164; bh=gqnaxH1rgRDFOzHXBloh3p+8/CkUfuecT1ZNGIAJxUA=; b=
	tDF1dDGJwPQokNPgSZEC2nKwIJnfIrtDEEKbSSVS2vB7FH2Jd5G1aY86MUM2zQ2v
	5l9tudqespN3BZAVVcf4kAj78fTCSWZniRU+sHKgp2tfx2kljO6wI3UINzJEgwBL
	xEy5rn5hU1tAE6DIHA4jsP1hJ/9qxNFSdoCRtnsNW35PF3t3sXOrfet9N9OnRo4O
	LsqtLEgxucbw28E+xGDo984q+AWkmXiblIYW/u0yWKULVN0ydyI57Gewc5MkfvTg
	U2Qzzdp9aZjvbpfszs7RRJHHyy/lX7x1SAI6tdS459or8Sf8zO0n5l6QTYKKQ01u
	m+BLeyGOjCl8Pi6lkDjBEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540764; x=
	1746627164; bh=gqnaxH1rgRDFOzHXBloh3p+8/CkUfuecT1ZNGIAJxUA=; b=L
	a9muKUSt99AwfBmXceXp7W3qhZJaNrz2dDvAH5Q44mHwsm2FzgP8vI6gKf/TvQOt
	xG0zZIE2U7YTTmUReIoUeYSWTi6ouL/ssuiRGjAfhntAcloUcwxBPtN6jIXfLGq8
	Spmjpx74Yq8d3C8nre7ytlKnWoR1nL7eSBh1CSiAaDlZ08665oEtyz9eP7GnDl0i
	S5HQ68DODKNEBgiBoSoYunffOpSPt2PTixno+uyjJ3E12d/rbmfuF+RaPnknhUnt
	mmN8jizkvtSn7PCvEsk2ec6B0UaBcnjplAulPXPkjbBa7NDt5h4uO4ThtMaPXyht
	8/QPXIYkik1RuWcrRi2Ow==
X-ME-Sender: <xms:3BgaaM6cHGLwrDyeAVzjKft3kWwmfbNwMX1awNvVXZ-ZjhcXIwLe9w>
    <xme:3BgaaN7z7fTJXXHzJ7DYvVhMZNeoGXrIEUBNSL_sfn57JXeKbwq4tulVSGFY8T_cN
    5CbPVikY8u1TuSK-Q>
X-ME-Received: <xmr:3BgaaLehcl5tiAJuHjZhq8tapkr9kwsEZQiOT3tq_eqRHl_BcOLaDYBKTMeTUR4pbRPk6dHM9G33iE8ec_cY1l4XNoGQVFLTbw7cO2jC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepkeekhe
    efhfetkeffleeuueeljeffuedtueeigeevffejvdejtdevveffgeffhfehnecuffhomhgr
    ihhnpehglhhosghsrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3BgaaBKxsD_oq5d9qfvLCJ8ruiwMZ_akDuZIkjxF9v9YblupaX0fCA>
    <xmx:3BgaaAJVLfIkJEOLtZpuiQER1OYQjmRoPEqJAFRogRCnowVGbOEteg>
    <xmx:3BgaaCyaa3Km94O9DJ79w_UCi7ROnR7OK4-Kd1_f-0N7SEMygwUrWw>
    <xmx:3BgaaEK-gR8KgQgdSC51hMd54nZC6laUHOOFKq5zDiejwPy_zfpcww>
    <xmx:3BgaaFU6fKYvC1hHR5rXtQlYn0P2iYjAONzv24TxJtTalwQrWXvyooNr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 811590a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:37 +0200
Subject: [PATCH 04/10] contrib: remove "thunderbird-patch-inline"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-4-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "thunderbird-patch-inline" directory in "contrib/" contains a script
to send patch files via Thunderbird. This script depends on the
ExternalEditor extension [1], which seems to be effectively unmaintained
with the last update being in 2008. While the extension has eventually
been maintained in [2], that fork hasn't received any updates since
2020, either.

In addition, the script itself hasn't really seen a lot of maintenance
outside of a couple of global cleanups. It is quite unlikely that this
setup still works, and if it did it's even less likely that somebody
uses this script.

Remove it.

[1]: https://globs.org/articles.php?lng=en&pg=2
[2]: https://github.com/exteditor/exteditor/releases

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/thunderbird-patch-inline/README  | 20 ------------
 contrib/thunderbird-patch-inline/appp.sh | 55 --------------------------------
 2 files changed, 75 deletions(-)

diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderbird-patch-inline/README
deleted file mode 100644
index 000147bbe4a..00000000000
--- a/contrib/thunderbird-patch-inline/README
+++ /dev/null
@@ -1,20 +0,0 @@
-appp.sh is a script that is supposed to be used together with ExternalEditor
-for Mozilla Thunderbird. It will let you include patches inline in e-mails
-in an easy way.
-
-Usage:
-- Generate the patch with git format-patch.
-- Start writing a new e-mail in Thunderbird.
-- Press the external editor button (or Ctrl-E) to run appp.sh
-- Select the previously generated patch file.
-- Finish editing the e-mail.
-
-Any text that is entered into the message editor before appp.sh is called
-will be moved to the section between the --- and the diffstat.
-
-All S-O-B:s and Cc:s in the patch will be added to the CC list.
-
-To set it up, just install External Editor and tell it to use appp.sh as the
-editor.
-
-Zenity is a required dependency.
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbird-patch-inline/appp.sh
deleted file mode 100755
index fdcc9483520..00000000000
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/sh
-# Copyright 2008 Lukas Sandström <luksan@gmail.com>
-#
-# AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include patches inline in e-mails.
-
-# ExternalEditor can be downloaded at http://globs.org/articles.php?lng=en&pg=2
-
-CONFFILE=~/.appprc
-
-SEP="-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-"
-if [ -e "$CONFFILE" ] ; then
-	LAST_DIR=$(grep -m 1 "^LAST_DIR=" "${CONFFILE}"|sed -e 's/^LAST_DIR=//')
-	cd "${LAST_DIR}"
-else
-	cd > /dev/null
-fi
-
-PATCH=$(zenity --file-selection)
-
-if [ "$?" != "0" ] ; then
-	#zenity --error --text "No patchfile given."
-	exit 1
-fi
-
-cd - > /dev/null
-
-SUBJECT=$(sed -n -e '/^Subject: /p' "${PATCH}")
-HEADERS=$(sed -e '/^'"${SEP}"'$/,$d' $1)
-BODY=$(sed -e "1,/${SEP}/d" $1)
-CMT_MSG=$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
-DIFF=$(sed -e '1,/^---$/d' "${PATCH}")
-
-CCS=$(printf '%s\n%s\n' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp')
-
-echo "$SUBJECT" > $1
-echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
-echo "$SEP" >> $1
-
-echo "$CMT_MSG" >> $1
-echo "---" >> $1
-if [ "x${BODY}x" != "xx" ] ; then
-	echo >> $1
-	echo "$BODY" >> $1
-	echo >> $1
-fi
-echo "$DIFF" >> $1
-
-LAST_DIR=$(dirname "${PATCH}")
-
-grep -v "^LAST_DIR=" "${CONFFILE}" > "${CONFFILE}_"
-echo "LAST_DIR=${LAST_DIR}" >> "${CONFFILE}_"
-mv "${CONFFILE}_" "${CONFFILE}"

-- 
2.49.0.1045.g170613ef41.dirty

