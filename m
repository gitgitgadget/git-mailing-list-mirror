Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3949213E89
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380817; cv=none; b=Eu5ieXH4ShY53hfsywBKaO5TMU+GqZwuoYrWl4/MRuPDGaUSwQVF2GdqxddNd3aFOnVgfyfLg2aAVZOJwRFhwpBnSJedumSd29WssOQJZYw/7Vyu84PkPL7FBLtoP+N3CbbdxmOqeuaKYxh3Pr9kgOUjveyuLJbFcQcaAnZIHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380817; c=relaxed/simple;
	bh=Jn0bW95eb7+3q8YMPtjsseqDLNI9VM4/4QemWNOY1Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViXOFJRNbHbUg4vFseBXsy21zFcBSvU99dcW77AWW9BDqC5eBEYzD3BabcY69frxpFKVLRkDMo4HZ/Ig68oaa7fzW9FGBEhcC7nD1/NvWTUS/ENnrCbJ7AHIn0kRFJRe9zKEYcpFw3oCoTRr3PXlruRn0MAB7/wmJAHPOqop5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ra0NZnTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNjtp8WX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ra0NZnTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNjtp8WX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4BDE2540132;
	Tue, 27 May 2025 17:20:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 May 2025 17:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380814;
	 x=1748467214; bh=DU7EUSySFXsAUUUtVDKwmhibkeRWcVlerdLH2FUS5ds=; b=
	Ra0NZnTmRSzihZFI/6eiGuyYfrR1Gs0tW2rguyZn25laQejgmk7LWt+bNq5qhNek
	mb1rtvuCgZ34yODj/lfMXiqcPUI0zKfDFdDYlZzDHUgA2zBdNaIYCjttL9fhDYbA
	8ZoH1ZQgVj3c2s2Q6iVJRoMNTxJqhXJmttxGZDmuLp3PEE4/zYAHk0g0J9Pv0aaL
	yv5AzaXa4XuImSwQo4EGR7l/AAENV2WaL7ZJoGEklWdLtMfycB6YiNSc8CM2hyOf
	e1bDA/BpzgbuSm+Ozrw2F3x067QBkoweB5+23bUZqSvP6Ad5oWKV0gmQqsbu81ae
	Ev2hTAqQRwaskdV8GQ4ztw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380814; x=
	1748467214; bh=DU7EUSySFXsAUUUtVDKwmhibkeRWcVlerdLH2FUS5ds=; b=b
	Njtp8WXiV8Hx242joSl7G9dlsFPritRnsznuu5l4PUjYfxP76t0OqnkhJsnAXPoz
	qQZK8AL3N/eCZUQUdu3PpY6zK1XLrmmDkjKx2AlWlGn6CshDY9vfosdCOHmr2TDW
	735uYN+7vKfcH/5s1ANgz+DYZ15ODit05wUhvkDczdCAIrWInkLuXjq8f0DWsCg/
	sX21cxDGunyESn6TPkyGvb99SusQ++bJ59Oxd//CL+M/pVwYDOlAOsleVCYzi8cW
	YigtU+bePH8GjPzaok6ZFFENEDS+ZJ+FqSN5S31DU85YN8F0Er5zu0rcRUuG6s2e
	cbVJfrfOzBrIGYL4t+2HA==
X-ME-Sender: <xms:jiw2aBQHMMv7bo6dlaRaSrjI34CXKsHhgyP8aAFJwt6fiy8EJQjudKw>
    <xme:jiw2aKwXNdBpzQMtLLd75IlACEc1mO9xFhXT8VUVDKllzN4_cQ6rnDva_mzyDTkLq
    XlGIpiy6qZDHHdA1w>
X-ME-Received: <xmr:jiw2aG30z0tt-4lFnuqI_eTbqJC6sio-KGCNUkmfsNQ_jRfXLVPPM5Xnq4PH0jfUzPEVrVVsG_w4pTEBtRW8D7dxZgYNFwnxdqLSREXBQNgs38tmW9hQ9YGTtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudegheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfej
    kefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghes
    ghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:jiw2aJBshDwGNVntjrkOZmhAcS9FW-hKRe4uVPQZHLWgmHsyJQuhkw>
    <xmx:jiw2aKhd7-4zN6vK-RyTuPgYvHwz7X0mZPQb7kFZp2hMZWFwdsduIQ>
    <xmx:jiw2aNps1lF1PwXky4E7ayvGhPzv5g1too1Iq2aiyo0QIWz0FtmS4Q>
    <xmx:jiw2aFjGrVUY1Ma_Rd5lPdrERln9l5R4JfcIxyDuH2MoZSjIg4TB4w>
    <xmx:jiw2aA9RKXckD1DUYbngq3FiVWsiSnpvFIFHO5d-49LjyZMG5rJdVEoK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 5/9] doc: notes: remove stripspace discussion from other options
Date: Tue, 27 May 2025 23:19:34 +0200
Message-ID: <f4755040f38170b508e9cba03a7226b5b4d5cd9c.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Cleaning up whitespace in metadata is typical porcelain behavior and
this default does not need to be pointed out.[1]  Only speak up when
the default `--stripspace` is not used.

Also remove all misleading mentions of comment lines in the process;
see the previous commit.

Also remove the period that trails the parenthetical here.

† 1: See `-F` in git-commit(1) which has nothing to say about whitespace
    cleanup.  The cleanup discussion is on `--cleanup`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • New
    • Together with one other patch replaces v1 patch “doc: notes:
      mention comment character configuration”
    • I figured out that mentioning the comment character/comment lines
      doesn’t make sense here.  So all attempts to rephrase “comment
      character” or “lines that start with `#`” are gone

 Documentation/git-notes.adoc | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index d672794a942..383e8bca685 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -144,26 +144,18 @@ OPTIONS
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-F <file>`::
 `--file=<file>`::
 	Take the note message from the given file.  Use `-` to
 	read the note message from the standard input.
-	Lines starting with `#` and empty lines other than a
-	single line between paragraphs will be stripped out.
-	If you wish to keep them verbatim, use `--no-stripspace`.
 
 `-C <object>`::
 `--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
-	copy notes between objects.).  By default, message will be
-	copied verbatim, but if you wish to strip out the lines
-	starting with `#` and empty lines other than a single line
-	between paragraphs, use with `--stripspace` option.
+	copy notes between objects.)  Implies `--no-stripspace` since
+	the default behavior is to copy the message verbatim.
 
 `-c <object>`::
 `--reedit-message=<object>`::
-- 
2.49.0.780.g892193c3f50

