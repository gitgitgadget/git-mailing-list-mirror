Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031D27B4FF
	for <git@vger.kernel.org>; Fri,  9 May 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782239; cv=none; b=mgewLMw+SHwDUDPBIbkwwOHgUQpoyitLBj5sS3QQcJORJOiN4r5087My6M3rbBFyxw72U+1imEYNANaQlJMGTYdNeGHqpnphrtuzs3qwmnlwndFpWFzkTb1LwuGiBIBZHzVEYQjsfWihcfMPVqHBx5D60Z1w+ghVw5RY7k3koIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782239; c=relaxed/simple;
	bh=DYXz3R2iAN4T8YmhqmqOAzuxBPDXf4r3Oi/sCFwjdDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCIt4MYLBe3qORceU3oth+C9CRAYgwdOSleWi670pJ3xtqKqcFCiQPYMD3Ra3OEq5aLEPYftou8MGx73ROBwuqUvgwx1ddKxDVZajPVf2iXktgajOwqqVNdRl8qfc0wrSrVd3o5JcyZ2+2GaYI5zrHO936WqXS7upy8gZRweJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZYFZNIfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz/DdoOG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZYFZNIfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz/DdoOG"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F76C1140174;
	Fri,  9 May 2025 05:17:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 09 May 2025 05:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746782235;
	 x=1746868635; bh=QXVuZCusP6VjfXfpNsOji3wI0fvuy4UpWMvnW3z9pRk=; b=
	ZYFZNIfF6dHM11WKwTzMZVFbxr4dQF74oh1jwuShDyRYrtGEdtonnWnv1WMEcg9s
	oKYGkGvfoqIb01FgJe7DFWBartLNY5+W0SGgni2RS8WscV0e5mBO1j8zdGtAiJvr
	rHus8IwjNNzQgeDujTeDKtd1AEedyq5bNCj1lI2bfarNxipQnH8EA/MFVPlYpA0b
	PC7aL+XiW0uT36mDAbeCf8Cx/W/Y6bNcpNevbt4yKeI67RKi3WNv0iYd8FAsosVM
	qDKJxmKYdK+gYFpDDu8h+V2bUpSybZVH9P3By4s6eS2CTYB2phJ39L4k5+a9ixjQ
	0yeFBtlhYlbBUI0cxTRQdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746782235; x=
	1746868635; bh=QXVuZCusP6VjfXfpNsOji3wI0fvuy4UpWMvnW3z9pRk=; b=Y
	z/DdoOGigIikkzszjhmWjQNX65hImXW13quQTp5JOlVhU+bNl2HPXDZztkYj6KcG
	4h0yOlOVbsW+HDvKWuHdhPejPWHE+5mH//zBpGXghM+1EPTxMig5TN79k9VwiAjz
	NHk1HIXTCPLFYXTY+yi6waBMZkiBeWjLwkcKLKFolACttisbN9RGu1i8kdb5YEil
	6B4dRvV/q58qEZsaX6hlbVTBuAkkWuFqkfdlh3f1EZOVZWQc8jAZpW8XI2w+SEHu
	fMFKNuNYztisbs2a0glIzsqhO2NwBbbA3EwJciDNniJQJgTyihOdhfUj006Ru1u3
	sFqqEMWJ+FasOfhYR1w6g==
X-ME-Sender: <xms:G8gdaFWvJ-KcjjCltcItfY0FdMsoejNLJcTrX1L4sNdr9eoAEvAttQ>
    <xme:G8gdaFkhvpLN6l5kPbu0VxOULfhnp6u1DIX3mjt_FWa0IutaBkX0cw7pRbgyCGZEh
    VtAos9-lhjTWCL2xw>
X-ME-Received: <xmr:G8gdaBaBVjCkX-qLmCem2_9Fl2yPwFrZeJZbOYVFPgpUjbgiLi_qAff1vDC2IWsGQwxzQzhDGpnq3yG-UXVldlRO-X1iZOilI9e5SyLJjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeekkeehfefhteekffelueeuleejffeutdeuieeg
    veffjedvjedtveevffegfffhheenucffohhmrghinhepghhlohgsshdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G8gdaIUm-qVqNjCuc-W1j-BTXuwsBwLslmlXP68FW5Q8-jWCRHxtTw>
    <xmx:G8gdaPmo_X5d9P7QYntCuZMSQrRfaNmoy97U7fGZLzmsjsZ-ZEGgiA>
    <xmx:G8gdaFdEQyyaWr-sMuOYYCSx9no8vl4s_T6dJDLmdEmf_72yy8mI9w>
    <xmx:G8gdaJHU2yzi8XYqQhSfW5DA27k8rnoFM9NpB9IUsW1vKJpoIjuo6g>
    <xmx:G8gdaMdScauucT6dgdT6lOPAR7hZw5CArs0F1bi0MjcvO10UbI4Ogd4f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 05:17:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e07e4e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 09:17:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 11:17:04 +0200
Subject: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250509-pks-contrib-spring-cleanup-v2-4-14e20d95ec68@pks.im>
References: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
 Todd Zullinger <tmz@pobox.com>
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
2.49.0.1077.gc0e912fd4c.dirty

