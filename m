Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351C2BFC60
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765911260; cv=none; b=aGCi8K6EcVy6J8CAxLqHv4lBBLTJDJq+VmAxrMNPo0XODCwSB3W2WaxFWUtVrkxO8HhvaFka5a5yD8frdgh/a9DhmWWiL7MFAq6gW8B/fd0hdVEn13CIjrXUG8EOK7+8uxvulc0DHQlCHlT0aYlkyJjeZN5SWKyj7iRZKoej3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765911260; c=relaxed/simple;
	bh=Vl4VzyHxndpxTGJGG9douHiPpOOzoCOxiezmPX/FuP4=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=pa/3DhIQWbrFTGvGW0x17hkAoi7drCggtBpaRRoLhJUExNC+WaD5JjtywWx/bkceBatuooZdINxoVKJ+w3VAbwctWxs399d80iiWaLaRSLXnxGODmOc/4EiecUPMWPCeKxv9HpyvHIKWLzx1TDCk4ZQQB21TWqOymKyvcN6jo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jMT1FZoj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N5DOOOkp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jMT1FZoj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5DOOOkp"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 77031EC00AC;
	Tue, 16 Dec 2025 13:54:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 16 Dec 2025 13:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1765911257; x=
	1765997657; bh=3Kp1Xwiv3wSgk7LoeMOmtf+2++OgvtwfICV2hykbSGw=; b=j
	MT1FZoj49eVukRL/o1SxySkUh5qAKTXzWtsbcaR8Vo0Rhg+XSWkz1YYmMYfoM30w
	IaoZM+qX7I90Kbk7PQJrL/Uzb7udq0UNQQZMeR6CeCxY6Gt8QlAlLWFlcivUpt2c
	D00kxOy4Kfh1qS+iRTfsGJ7tzZV1L+F/baPuZ9g8dap1+rsTsUUPGA6Y1XH9c4m4
	8MluQAJMUvJSa+nlB+WnsX1haOORromR/LdZr8ylIxZHtHcP5bNixJfRtlClHpOJ
	O0fPDBelatRocm4RFd5oWz+ZgS/GoNJ9w+yWhngTiCDaXgq41sw8HDZqnuUVeWcS
	udKjOslxQeKMTGCg/6zug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765911257; x=1765997657; bh=3
	Kp1Xwiv3wSgk7LoeMOmtf+2++OgvtwfICV2hykbSGw=; b=N5DOOOkpFMS82eeQp
	Aunhv6eCAE2yO1fVyhxNxebBDFMPx+/l8Q5KVqin+Vut+xIMnI3FWDLpiw/drRIg
	IXsE0gqGadS2j0N7F6YUNI4Y7J9jc2ehfizPOhrAYQprtz1X9yUNV0sWLSyWomSL
	m4T+vPPyHg5iFVlyFF+X5wYlcuCawiaJ3uRV9CVJmJ7fhc50V1J/4lMVXTXCrypp
	mepjOB/d3FgjcAPtdlWAu8oTM3XEqRhjtuTAOrumI9gY6D8oquc6iLVCkfy+bsFR
	lORZb2aQulPfYTHsYugQS+BAkeG6YIWFue4xGETr3F//L8ajOkaWmF7VbH/EoIpY
	aPlOQ==
X-ME-Sender: <xms:2apBaVDNS53yo-QShrL6NqbMjqHvl3CRRebjdkKtdNBF95UHRuq2ZQ>
    <xme:2apBaaYxqdQ2pjf65_8ktw9eTlVbI0XnN4EgsJE4LFfCUSWXFS801r0e2Ut2PR-Bl
    _TrAO1zmuMFE93fzho6XrV6dDTqugsO00VURkQiMZyFJV5dFoFNdg>
X-ME-Received: <xmr:2apBaY7av-oDFkJkbev4ZMI63ZUjPkT6ZKyodCO9RP7VP3yrpNDa3SEfpbDBHuCaEb5B8NDr528z5fn36O6hl_alCOaLvEDGow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufhffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehffehfeeggfeghfdvfeffudeileeutedtjeehtddvgfehjedutdehgefhhffg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2apBabbMlHaB-Hj5Ha_zxPPP7i8x8FHjJNPjdePZIM7VKykE9RO6fg>
    <xmx:2apBaXhqJO6j0lQvoloo9M94PamOy7FbZMryRVBm6j_YCZfUkzNOqg>
    <xmx:2apBac9-xVd0bVELAsrfkoFYzuajEuEbNYMzk8qPhle1KEn_Tg7r4g>
    <xmx:2apBaSpAEo57KX59Yo8DGE8mQjIG71b-ZiIEDnJu7OP0A-9Lh8hJXg>
    <xmx:2apBaU2SA5bQJBjlhAev72dRs99bbzfIlJ5AtFSeDdrupGKEb-lGadFe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 13:54:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] commit: document that $command.signoff will not be added
References: <xmqqldj48pyl.fsf@gitster.g>
Date: Wed, 17 Dec 2025 03:54:15 +0900
Message-ID: <xmqqv7i62r6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Every now and then we see this coming up on the list.  Let's help
new contributors who are not aware of past discussions by clearly
documenting our past consensus.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The text is from Elijah and Johannes this round; I am merely
   playing a copybot.

 Documentation/gitfaq.adoc         | 19 +++++++++++++++++++
 Documentation/signoff-option.adoc |  4 ++++
 2 files changed, 23 insertions(+)

diff --git c/Documentation/gitfaq.adoc w/Documentation/gitfaq.adoc
index f2917d142c..0e40befb77 100644
--- c/Documentation/gitfaq.adoc
+++ w/Documentation/gitfaq.adoc
@@ -83,6 +83,25 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
 which quotes the filename with spaces and specifies the `--nofork` option to
 avoid backgrounding the process.
 
+[[sign-off]]
+Why not have `commit.signoff` and other configuration variables?::
+	Git intentionally does not (and will not) provide a
+	configuration variable, such as `commit.signoff`, to
+	automatically add `--signoff` by default.  The reason is to
+	protect the legal and intentional significance of a sign-off.
+	If there were more automated and widely publicized ways for
+	sign-offs to be appended, it would become easier for someone
+	to argue later that a "Signed-off-by" trailer was just added
+	out of habit or by automation, without the committer's full
+	awareness or intent to certify their agreement with the
+	Developer Certificate of Origin (DCO) or a similar statement.
+	This could undermine the sign-off’s credibility in legal or
+	contractual situations.
++
+There exists `format.signoff`, but that is a historical mistake, and
+it is not an excuse to pile on more mistakes of the same kind on top.
+
+
 Credentials
 -----------
 
diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-option.adoc
index cddfb225d1..9a80d60f1b 100644
--- c/Documentation/signoff-option.adoc
+++ w/Documentation/signoff-option.adoc
@@ -16,3 +16,7 @@ endif::git-commit[]
 +
 The `--no-signoff` option can be used to countermand an earlier `--signoff`
 option on the command line.
++
+Git does not (and will not) have a configuration variable to enable
+the `--signoff` command line option by default; see the
+`commit.signoff` entry in the gitfaq for more details.
