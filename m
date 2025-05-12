Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C25B684
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041610; cv=none; b=b5HH0o0+bk316y66uENQwbTVaOIzN0iPRgX2G+BKoQ+bGCmx6lffBh3+8zwC8yJTkeFtJIhQwyvXd+eHLLCt9Nw8gijO4gSXj4yuksDFmaRAZqeMFXS0pkZxl1iXbgcx9/crq2V2k9+aoWkKZ2VKhr0SRddkhyFxbqVQ0ovmNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041610; c=relaxed/simple;
	bh=CM/+wzY4x7LYbY8m4wn174UWtfY18cFs78Amlio1HvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIt5Dbp6UX1KhFj/kQncGmWWAOPJV9ZHLRrthxPD2MEHRb1aL7fCgjWSewePEC1oklzx2108DSUSmlsZSDaRqLFR1nCDC90XH30n9gWuXab0my+JEBqMhmdEtPPJYQzsbMgPmZHY+mXopU7E5/B3oOGox8i6AKiy6EhYDKrgWkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2GFKs0xj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUMYXDVz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2GFKs0xj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUMYXDVz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F2DF911400D0;
	Mon, 12 May 2025 05:20:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 05:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747041607;
	 x=1747128007; bh=7qzoaUnPeoJm1GrkLjd/9G/fU0iJf8R5KIoklKxjSOo=; b=
	2GFKs0xj68kkhqsXceMS0UWnmp00YQJnkz+dp/YCzl/xMbXrZ85nti/NFxPkRWwr
	Fli9KXuTS7mwqdXozQlXXwTbgaWiBb4i9KQ5wpetAkRMrRvPd3Zy9Q2rTr5GMDKD
	7qh3H0NGCGZGTil6Sr8fFyv6cOl6R2xJkeZ7CH1+Lr13tQ47vgvm5BJ7g3FJ3k0M
	2LCZ2DoG43OQ5KZYPsRpftHb2kF6ohiPTv+/U3+swby1NFdZpAPRgj2rZzPIgong
	ZD7/UgZaacJA066QeHrRKfhWVMIhV5DncGeUM7X0an5O5b0+Na65GmJdGWn8J54c
	RZb9Arp0J9PhIi0CxGCvAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747041607; x=
	1747128007; bh=7qzoaUnPeoJm1GrkLjd/9G/fU0iJf8R5KIoklKxjSOo=; b=g
	UMYXDVzhBaoymYjrOBVNB+4iF/vr0RCXG32ulAE23XWPT8NbvT5kmzN4PaA3SfRk
	1SV86+Xp7pqY03KHR63DODHqPf75zV/GuePlpjb0ikue8Jsy2ujkU8jfbcxO/a7g
	Fgz1w4cPrjnngqcGMdCxMMCNLzTfQ3lFAYf6CKRQDgzIKbkAHOaZv1SGInPSePI7
	1YBXS/E1PE/AHHchyqAwTTkW1KdHjYVCOtrKL8eCnIdGEVWUnL56uP0teNF2OuoK
	a7aUB1O1jF81eKrtBbRA4VbLVpHMTmFq3Zrt97f+NlkSHyOF28tCYHh7IJ/Gx+O1
	QxjoYedVUEKXCeedsJQXw==
X-ME-Sender: <xms:R70haD3aBYiI9Y4eEqxvOmhz4sY0QO43O5eSQmtOuysjV5rwSIAFJA>
    <xme:R70haCHWwooJjil-Hg4CEMpaatBTVFV2XwPoa6ouB0EdoPLG8bE0LSqrPfJGjQ1_1
    m1e1f-hLspvtE5w2A>
X-ME-Received: <xmr:R70haD4qIx3Kl698B9LQhN2rmXrlwFzj8QSBeqkp7iJlzZFZkKFTdz4F6CsdZWeyJnCL1rLjkS8v42tV4L3o1j00cShOdWp9f_99mbKmtIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekkeehfefhteekffelueeuleejffeutdeuieeg
    veffjedvjedtveevffegfffhheenucffohhmrghinhepghhlohgsshdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehmrghtth
    hhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:R70haI0c-PkJqRHwD-nAag6gCVprhAJg5gsDFAHR7fB1BeRLLA50Dw>
    <xmx:R70haGGaiiziw7fJpZJcckwJ3iOY-xetpyxh0UBxMC6ferHNIv7LpA>
    <xmx:R70haJ99CW5Jkiu7THsBhZz9NNk4W7iZ3EBOK9OIa4I0iCIZWuQvzg>
    <xmx:R70haDnoGIQpt_f0bQNFyJBagGm0iQz8bZOXT8jM_7MOjzLldG8sQQ>
    <xmx:R70haDEWaeVAIARLm6gg9EKZVQpJOB4x_80ua6X77hT4GFd64_jUHAuV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 05:20:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f145e60 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 09:20:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 11:19:54 +0200
Subject: [PATCH v3 04/11] contrib: remove "thunderbird-patch-inline"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-pks-contrib-spring-cleanup-v3-4-32e151b0bfb0@pks.im>
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

The "thunderbird-patch-inline" directory in "contrib/" contains a script
to send patch files via Thunderbird. This script depends on the
ExternalEditor extension [1], which seems to be effectively unmaintained
with the last update being in 2008. While the extension has eventually
been maintained in [2], that fork hasn't received any updates since
2020, either.

As such, the ExternalEditor extension does not work with modern versions
of Thunderbird anymore, and as the "thunderbird-patch-inline" script
depends on the ExternalEditor extension it likely doesn't work anymore,
either. The fact that this script hasn't been touched for the last 10
years outside of some global cleanup supports the idea that it is not
useful anymore.

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
2.49.0.1101.gccaa498523.dirty

