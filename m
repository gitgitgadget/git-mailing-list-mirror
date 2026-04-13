Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0235AC0A
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075785; cv=none; b=KcRfThzFYcfowKE8JA8Ef6KMeNDOSQe1X7a41MYxemKgPQUIu0vfv1XTxlg/riw99lNCkrzV/4cuMAfdJUPpGfKyWkfr3P8ZjcxpzZeAOTNHbiBwcWjwiVwg0h+vBje/TxJxaeZHCBuK2tvB7snCLDtXyqTlnL/Tdq4Ap0Gmvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075785; c=relaxed/simple;
	bh=8tB0H15GQq6GbyD5ZrKVkZTXJFaYxPoWrueOIMeyWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJImiPC0Ih073G6SyI8hBmHl4aPoSVhfg54pkZj936Cx9U/fivieSQ1fEinT/FLMA3asqAMo7cYNi3O2MnVwFeQvogazHsAuBuDrD32y64rJ+uq1fbOWP4dbtQYZyrZ/oXDcig/A4IlCW7mUb9YtBAys0xBCmk6CGn0Y1Ua2Av4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NNckCgIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mu1Rg3AV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NNckCgIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mu1Rg3AV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 82CC3EC00BD;
	Mon, 13 Apr 2026 06:23:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 13 Apr 2026 06:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075783;
	 x=1776162183; bh=xqdAI8Ty/J/ESLOIDNNfsjo4TgqLktRZUfoEUVEtMaE=; b=
	NNckCgIvF/1a95hL6Lt3ZT8dUcSVRa2B36VSaD8wyqoKi0OpaXoRHd7NEWJhIesC
	RJzO3RakW2aNcXMrqF/NYpV006K2yQAHKuXGnYwxyYhOWh+wdPNE/fxo/rA25RC8
	D2Xa1tv18JU1NHkOzw3/WO2+3mEGjmFsw45lfUK+y4HIpv2vBExqB9MpWCW8/V+e
	xJKJu6SlaQHH95n0+ixedofO8P3Samke4af4qKyiYwJWPDEJ346fiNCsOjtjZrNJ
	4CjpmqEKJ3g/eYyYNpl1M+Tj///+Joa5P3LH9fJAPOmTJwyQGwuVN4RmTIUHRiWD
	MLv0hq4ANjgjcjY12Y5JWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075783; x=
	1776162183; bh=xqdAI8Ty/J/ESLOIDNNfsjo4TgqLktRZUfoEUVEtMaE=; b=M
	u1Rg3AVR9Gh1G0LX/CogeRuygCFm5UdOwIaioMSaCz7ahvnitGgCEmcoru9QNUCP
	+fn6pWYGaFKsaDBrBee2aeUskyuHcQ4qK98Vc0YWsZX+WQ6t5Y2seWOG0+FudrMO
	GyFLHmkD/RcrBeit0H59DPJqsjnmDMApmK6T9LV6zHu0+MjF/2P9KhQHvZhiFe8z
	KwsI99QNHmH+aG6t28C6xyKB4FW3/Egs90UAWVqamAVQxZI8+rCb5wHNIux7FvIZ
	tnFHdXSJczshWshLmoIjYiaNupRLzKYlvQnOUolkVs3qaYRcYlYpxG5WC/7dC5Mc
	cTFR6fx8YjEY0932mDCAg==
X-ME-Sender: <xms:B8TcabCkZuIyzjyqB7qs3pfKRnjXvcBhqzcdGENuztxQS6RlmDoG4hc>
    <xme:B8TcaVOAWwcPIkDpqRWphabyDkjnihWLjAbBFmmCiScj8QI_vkOfLZqvg0j2IauvB
    qfy7-nR3OchzeFjs8xNUB5qcq217p7AH83fU2AdyrjiKJ3De0Yx>
X-ME-Received: <xmr:B8TcaQaQh-ZIK5om9JIsPC8LlCj8s75Y0tuvw-ZApiawMHsrx4FSO_5IftvdQtTixRwNffdQl8OXvH0DH8UyGNL2U4MuUYZvjjYsH6wdhJmHqc7KTTagvD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughupdhrtghpth
    htohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:B8TcaUsmk9CGjW5cesJOMLG64dvM-k1PKbs-Kb5f796TbY0lX4Pqfg>
    <xmx:B8TcaSN_qMDpo7BELq1cNs5PRfuGvBadbC6j3ROEyKwl48bIQm8FSw>
    <xmx:B8Tcab6ya4fkI7bU_iCqr9BIwD9X2tJlaUfIJKmcO2q-XsnaRo8NJQ>
    <xmx:B8TcaYRFogT7iKK2tzwlf3I2j_-vLD8vqV-1pSj5ae_RfLkbc8IK7g>
    <xmx:B8TcaYNgU_cM1alFK5xeglTwXvlgd1uf4rZoYmU6xUf1qhdeJLEJCKw4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:23:01 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v2 5/9] doc: interpret-trailers: explain the format after the intro
Date: Mon, 13 Apr 2026 12:21:04 +0200
Message-ID: <V2_trailer_explain_format.618@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

You need to read the entire “Description” section in order to understand
the full trailer format. But there are many nuances, so that’s fine.
As a starter though we have an introductory example.[1] That turns out
to be crucial; the rest of this section talks about the mechanics of the
command and only incidentally the format itself.

Now, although the example might arguably be self-explanatory, we can
add a little preamble which defines the format in its simplest form as
well as define the most important terms.

Note that we name the “blank line” rule since I want to use that term
every time it comes up. It gets very mildly obfuscated if you call it a
“blank line” in one place[2] and “empty (or whitespace-only) ...” in
another one.[3]

We will define the format of the *key* in the next commit.

† 1: from d57fa7fc (doc: trailer: add more examples in DESCRIPTION,
     2023-06-15)
† 2: `Documentation/git-interpret-trailers.adoc:86` in
     5361983c (The 22nd batch, 2026-03-27)
† 3: `Documentation/git-interpret-trailers.adoc:93` in
     5361983c (The 22nd batch, 2026-03-27)

Suggested-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 7329e710e1a..bcd79b19bd7 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -16,7 +16,12 @@ DESCRIPTION
 -----------
 Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
-For example, in the following commit message
+
+A _trailer_ in its simplest form is a key-value pair with a colon as a
+separator. A _trailer block_ consists of one or more trailers. The
+trailer block needs to be preceded by a blank line, where a _blank line_
+is either an empty or a whitespace-only line. For example, in the
+following commit message
 
 ------------------------------------------------
 subject
-- 
2.53.0.32.gf6228eaf9cc

