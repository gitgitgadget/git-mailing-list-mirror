Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CE27817F
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382900; cv=none; b=bSwjwkqQCyMIODhgl6U5CSiHkQRm3Kkw978U9NdAywMFHAjCY85HeMleIumTqYp/kYnqW/duV786Tkf8+PwWnOrFVP4aP+704BLFiMkL9zPi7m314ENVrkx134sKUxHw/TDTX+4xescl0MVZ3v4julHyFt+0KtMrxEJZQ+Z/tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382900; c=relaxed/simple;
	bh=u16hkVUI6Um3UfVWZzU8RLtvq8eacKoDEN/YLT5yqTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLxmpYXr+/5orc8sIvjW5DhQ0fWQzKjapYlysSXLCdbRuhLMIf7UFjyrHluY32TK1X9D5FBItc0GQb8FsSYcIQZgGwQtijVIfNXtEkO8hwnRIR6MMEigT/5wdzeoqv5yOOalYMit3vKCTVbeH2LUDBWEU8Wsl4k6wbQEQrz8EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=v2+5Z0C5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgNP9viC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="v2+5Z0C5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgNP9viC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A41511400317;
	Tue,  1 Jul 2025 11:14:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 11:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751382897;
	 x=1751469297; bh=Xdfpug8dzvG7sAKhmguRbC1Wz5ZNTpRmWQIWGb2fva4=; b=
	v2+5Z0C52C//7jzRdU5xZ9kOouRXmt9qsaHHMICVXEd8LtnR145w9FQPpIBIjnRz
	esQsvaKp6HwNQypkjrshsB33BEP159xrpf8X4DDj9SHA83jG1Jth1I+Wr4sVnASU
	CxODoNtvmyqaQJdrPU+oF7ENxyFOBEujTPBolPxScLzXWWArTods9ZMk7qN6DcON
	HwKOpXsc4J4zP14EnKTgClXNYKHxIRvdA41blmK1R7GMU6AcMgSHo8mANzsomt9P
	bDdL4Nj2WOCMvVQluBmEdfiK6nQtaIvcfQhVZP9cshILo9l5Qu0AmTIOS3xZuGaJ
	VOL8jyuQzpjsg1yNsn/Gvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382897; x=
	1751469297; bh=Xdfpug8dzvG7sAKhmguRbC1Wz5ZNTpRmWQIWGb2fva4=; b=G
	gNP9viC+gPwiUVEj7/lA6RcoTVwWxMoIPRZ/gQb4sFqpN7zXasTTDgN6/rd3hWo0
	4TOmeNFTljmpabrANG/uDEi2Ptwlfv7wpsJP5mG2yYOXHLjQtwpP2a0PlFYbGxj0
	LjcrQO5Y+idzx07uJzWZ+nv7c03BZmaQSvjiGwPEF16sDrOKMZpgZn+asKt+yeu1
	ypNV9kCHZwOue2nupG0q/+P8iQYjvEeVildNzUQCOEPz9KwmMzjulDUwHFnCKKrY
	U5TR8QoVDJN3gcEm5JMjw/yZetAZYfFs0Z536EX7QXvUqKXl0NG6I2RTgNcMsMnX
	BYkFZ6Ip4ARPQDXEZfufg==
X-ME-Sender: <xms:cftjaE_7aDIfRLO5qAw4qlj1lIClTYW38IOPxdclORJLo0gcp-w9Ytc>
    <xme:cftjaMsWRj9JiNk6yoVLr3QEjMbQE7ZPzAIFM4K4wJV579EzxZWtXMLzquhaWJTJF
    0xuuOwksA7911M-7Q>
X-ME-Received: <xmr:cftjaKBu1u02x31T_BAn2pevbNO963oCep2rl-2LA3kQ26C0qEy-uGeQM6L1s1l9Gf2fOq1Ovod-cfd_jxLc2TZn9fePJ6xFNZwUw2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:cftjaEdGFOzcX0HckgACICPpVLJ_rs0OQB7-cXtGzghXi14EQr0fuw>
    <xmx:cftjaJN6fVOZRv2W-ii5VGyPlkwybGenRcCiWQGlQYQGkSuLurEXhQ>
    <xmx:cftjaOne90K5zhx8btseWNpbW10GQbPCVuksab28yCCJn31cfAQ2ag>
    <xmx:cftjaLvQODUQGvMLs_QBWAnxjQQYASQDrsXTchPm1oVpcrcV0zz5Gw>
    <xmx:cftjaBbsc2F9tCAvjOXc5ISqhaGhhI6UPgJqM3KanPnyK1uvJiEeirWR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:14:56 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] doc: config: document --[no-]show-names
Date: Tue,  1 Jul 2025 17:14:28 +0200
Message-ID: <3c90ec17459096bab7f1268c7b5e5e3e7f7bcccd.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751382830.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name> <cover.1751382830.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These options were introduced in 4e513890008 (builtin/config:
introduce "get" subcommand, 2024-05-06) but not documented here.
Use the description from the source code.

Document this option and the negated form according to the current
convention.[1]

`--show-names` is also the default when `--get-regexp` is given.  But
don’t mention it here since all the deprecated modes are quarantined in
the “Deprecated Modes” section.

[1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    >The default is `--no-show-names` unless `--url` is given and there are
    > no subsections in _<name>_.
    
    See: d4770964d50 (config: "git config --get-urlmatch" parses
    section.<url>.key, 2013-07-31)

 Documentation/git-config.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 936e0c5130f..e05bf813d46 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -259,6 +259,12 @@ Valid `<type>`'s include:
 	Output only the names of config variables for `list` or
 	`get`.
 
+`--show-names`::
+`--no-show-names`::
+	With `get`, show config keys in addition to their values. The
+	default is `--no-show-names` unless `--url` is given and there
+	are no subsections in _<name>_.
+
 --show-origin::
 	Augment the output of all queried config options with the
 	origin type (file, standard input, blob, command line) and
-- 
2.50.0.136.g303b50f9132

