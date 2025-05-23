Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AE2BD00C
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028738; cv=none; b=DGCO7/U1dr8HtA1qGW3C8SeimXt1Dbzyte9O5EUQFpbhJ/vLQUxO9Y1qDyPcLqwzfNGQHXpxKgGggWHpVXEdO13vCkyHGb0sWROxDS62lCjImdG0ebLfFHv//59Zkf+ocagWyB1FHurzTHpzaPFXs6zd/EyotBY6EQD/ite7J5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028738; c=relaxed/simple;
	bh=/L7FwpeenGNGwygSx3Q2gBx+7bCOOYhx+VScEKAgGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN77akz4ABE4zUwY8qYLFIvzsAi93sTKehZE2VluRbKhDfDDX6CjwErKrPWLtlBaop8YDOlYiBZ/kdkm4kOucqJzvc3EuCSyEIifkyXPhbji/NCCxfiwIDGHeuJaKeoZTof+FE2CQDHnUdpLuVgSrfcJgsggW545rc+s5I+4+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e5oH+WMW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oxX5pJmB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e5oH+WMW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oxX5pJmB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 644D111400C7;
	Fri, 23 May 2025 15:32:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 May 2025 15:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748028736;
	 x=1748115136; bh=7nXT43S7irfzADLcgjTfof8ApO8asRbCR96BPO7lmvE=; b=
	e5oH+WMWaGKMF3GLd/W6BANGDT+diXZM06MqR/Lndq48jc4e+hwRMZGQ24uVO+oy
	w6YiffDsiOpoDftj3j5g4+TR5x6JTc4O9/He9/l3gsHlUmfNSuo7Mc8z7Ke436Ju
	dUowJFeonathLfY3U7Zt2JwinhtJZhfUwWnWDy6XACKnPAkkylSswitO4U/vGUzx
	guqTfm/wUDS4/Lsp9b6OQ3VGPJVynSTE2Gbun4DnTfdebemJQZuM9z4bXgN3B/Fd
	UCSRjK/nKK+1XpPiJTGdy3m1PjbN57ykkUD7vWSAbu5X4cRf3+cx0Ed/Zij4sDFj
	bkuGSkjLCiYIveExxiuSHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748028736; x=
	1748115136; bh=7nXT43S7irfzADLcgjTfof8ApO8asRbCR96BPO7lmvE=; b=o
	xX5pJmBk/JOUJN4qVuiQfFWZhioVGHT1Kc195PozU2596NRuvv5+uOFdGDtSYeku
	5jqms/eY+JAACCNdGkEHWM4Mq7Lc1m8snc9bkxpwqaUlr/kJPyW/hrb8ZXw8iaA5
	8APjZM0Fk7ZxUHspIPk6JyvnflS3nSIVqklEoZm0iz4xQTPF+osDw/mdvo82LyaT
	9tLXwPGhcFNozYbqC4ZX/GvWemk64xFDIPyDnr7zrRfEdyrmwKvpPwr90RmDJP1v
	jsn/2h0135MEelDpB2wuWKHPpnbqiUAgRS6/unZjLHelM08Dtxdx4QS2QJuLHmQC
	GsQTp/Je0SuSgl3X8Mjow==
X-ME-Sender: <xms:QM0waI3_sjU5M3_NVFPkihTyW5HUqLVHmsexqoRlqFY3LJ-xaj9O_zg>
    <xme:QM0waDGZwdJTtf5JFF87IP9_h8xat1jbmMSg3Jbmw-Ux_eF5Txyqquc47YkUuHyBV
    9XxbsY7WgsjMXyLgA>
X-ME-Received: <xmr:QM0waA6YnFp2_JOKu7KefdC7is5sIqhwctZ42c_XmCzuPWcNGM6o2SZtVfi2VTsHt6EpXokvmW9xiZKjlvEcoopW5KfH4qUJcyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelieelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedulefgueeiueet
    keelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopeguhihrohhnvghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QM0waB2-FNsmD74y21XEQkmRb4fiOAlj43VJ5hlhISwdhnTZ0wRhFA>
    <xmx:QM0waLHEoo80J0WUwoO3iS07bcBTLswBrvQCHFGPg07gK3Ypzb3aAQ>
    <xmx:QM0waK9hF7dBbyta-3l69I9IoLwRlNIR9ifIzwgTaWst_oa0XUKAVA>
    <xmx:QM0waAljqTjkOJwJ3snQNcRR5VKZ1dDvt966nW8Uartgon3ivlz2WA>
    <xmx:QM0waHwBp9F3nS6a8CtOLLnGriHHY06NLCR2u4DyZqT1WU_FEOQeIWQB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 8/9] doc: notes: treat --stdin equally between copy/remove
Date: Fri, 23 May 2025 21:29:54 +0200
Message-ID: <3e8ecf1b668277988cc5d166586105d1d5018366.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

46538012d94 (notes remove: --stdin reads from the standard input,
2011-05-18) added `--stdin` for the `remove` subcommand, documenting it
in the “Options” section.  But `copy --stdin` was added before that, in
160baa0d9cb (notes: implement 'git notes copy --stdin', 2010-03-12).

Treat this option equally between the two subcommands:

• remove: mention `--stdin` on the subcommand as well, like for `copy`
• copy: mention it as well under the option documentation

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • On --stdin: just refer to the respective subcommands and stop there.
      As suggested.
    
      Link: https://lore.kernel.org/git/xmqq34czhyz8.fsf@gitster.g/

 Documentation/git-notes.adoc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index ad152aa94ce..a0167af5aba 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -127,6 +127,10 @@ When done, the user can either finalize the merge with
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
++
+In `--stdin` mode, also remove the object names given on standard
+input. In other words, `--stdin` can be combined with object names from
+the command line.
 
 `prune`::
 	Remove all notes for non-existing/unreachable objects.
@@ -207,9 +211,7 @@ previous `-C`.
 	object that does not have notes attached to it.
 
 `--stdin`::
-	Also read the object names to remove notes from the standard
-	input (there is no reason you cannot combine this with object
-	names from the command line).
+	For `remove` and `copy`. See the respective subcommands.
 
 `-n`::
 `--dry-run`::
-- 
2.49.0.780.g892193c3f50

