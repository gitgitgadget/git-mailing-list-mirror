Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034F39EF24
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905153; cv=none; b=ZSnm8QJ8n8VSvM/IP5jGpnqbTRd3XIaVEiF8FKujk0d2NIxBJV04+FwevPsi25JoARqCwBvrjVjJkgWBefkd5CyAbgBgPVI9XMHJVlq5rra2Yh4bC6zBtYarpKBvX0kestLQTmEfsz1qQhvp64UPtyEN1N0xTKyhBVRmwt/tXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905153; c=relaxed/simple;
	bh=4EdmaIOsTxR+GoDuG20oTfz/06HAqM7hZlBocRflmaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XA134ivhnELRu+PSMQYZUR0O++Bhcu/YODYzwVR2EbPi9SfePIWJfmkAeTAEt4saTgJLRJ1cwOnYBk6tDyc0PdXfO1G7V9tmvo9LQ6T61jopmGnmBvgvMIpC9am8e4IDvHBoocSfNDKA5Xei29/5KG/Oqh33WahE4vAioLC533I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PaYSirUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8iJxoIR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PaYSirUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8iJxoIR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8EE107A003E;
	Mon, 30 Mar 2026 17:12:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Mar 2026 17:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774905151;
	 x=1774991551; bh=UMoLejiW6rAqT7w58dAu3rQBtScmTb+OXR7b0BMF/N4=; b=
	PaYSirUwy+3glxHnXWqrlCX0iPxqe0IQmOZjZSpzr4cN0vCNw4ni/FraE0ue/CsD
	DQyz/+qn/eSTAyId+0Racgs/NWEn8kBauQ0p16KY3Pko+asvYBA8DAr0V9WJZp98
	QZtYGEQKmIRtMJcNaUS3FbmG5qY1SXACZlh47ZN78RW7pUxl9mlGiJ67EE09xEEd
	AFwwk3RStJpLn1v+TRl9ODgTuiFfkZ+XNf1LsrmYjYmI0qcal35hTv+vB3Ue0L3h
	04n3RPq+2lIBuM0XY90Gn7CqEAqhCod36T7qce+9OSfYweoLd+mp7FcmpM0WStgz
	roJ5NALww7du81I+La/C1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774905151; x=
	1774991551; bh=UMoLejiW6rAqT7w58dAu3rQBtScmTb+OXR7b0BMF/N4=; b=I
	8iJxoIR34h4X4Yb+vc64jQKi127Gc9EiSAngPLKbChSC/rg2J7pEVp8d95pEMyep
	0O4xEiEFIrc+y+9m4ZAvUhDm8ep1hwn78EOWD6mP73hWmgBHDwFExZsTwLHCMe/B
	kQzUTDdc6Z5gWH4c8B6i2ua8nQ63D29FStbusSPYwTCShxlSle2kcZ57Q5BNGMpH
	oNqsgObBhl1YtGDK5eog+7mwOLORGmRiLLiqABHGE3FqcsXHRSS8jYjDD31iDIZG
	4AjuRIoS66XZVk5d/C/RiXxjhm+1pmJ5gS25n5lQvmSgKYnGAnMg0QGjkdSIVuZ9
	JF0Ke8pvNju6VOJ9CphAg==
X-ME-Sender: <xms:P-fKadsiwpwEQa6aSiLEc3D5DA_WgEqiB6kn_AYtHzgWWKOuQfTJ3nU>
    <xme:P-fKadV_ClG1JaTqoLB2l-aiDWF9xpZXUsbJNtKiqU1GCxcRsr0yq7N4mmBXn3mNf
    EhBaposYQYviSdcqH-3yDY7TipyO9voCw_FrTT267ucr7rly1a9tw>
X-ME-Received: <xmr:P-fKaZFewCHS3E4CB0nyZeNEOOHjyYrjWemXprHSiiXH5fimYvJ7Obnck75Xr3wx03OJIVbhVR-Qs1t0YRLhmbEvxbWVzexYmAwFmGX4URmwoHT0q8DGqQb7Ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghkmhgrnhgssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhhssehutghlrgdrvgguuh
X-ME-Proxy: <xmx:P-fKaf2zK6Ugic7_VqOFZZs7K1J7dMRM5SErIbU07ZfodsptWV52bg>
    <xmx:P-fKabOtoh-4dzVbSkNz8e_u1B7sAqjHLOVRpkIT_bqvLSuek7PSaA>
    <xmx:P-fKae4gU_8OmnoC2DcHspM1U7uQeaPpJabNin3fml_gNS4JQQ5m7A>
    <xmx:P-fKaV0hnHs62DaKIFYc9eLSZM9q6cBdWkdHh7kCQNiOI_iDZmDzXA>
    <xmx:P-fKaenPPiC3bL-C5r-1cR3m3eatl1yrXgVtcFzC_RoPr3HpfCe3SegC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:12:29 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH 2/2] doc: interpret-trailers: explain key format
Date: Mon, 30 Mar 2026 23:11:33 +0200
Message-ID: <doc_int-tr_not_rfc.535@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_int-tr_key_format.533@msgid.xyz>
References: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com> <CV_doc_int-tr_key_format.533@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

A trailer key must consist of ASCII alphanumeric characters and
hyphens *only*. Let’s document it explicitly instead of relying on
readers being conservative and painting their trailers by numbers
(by the documentation examples).

The previous commit for “key–value pairs” allows us to segue right into
describing these lines as consisting of a key and a value, which is our
opening to describing the key format.

Just like *trailer* we emphasize these two first standalone word
mentions. They are then mostly used in placeholders throughout the rest
of the document (<key> and <value>).

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    `trailer.c` uses `isalnum()`. That short research together with a little
    testing left me with this conclusion. (The C unit tests for trailers and
    t7513-interpret-trailers.sh seem to just use lines with spaces and no
    separators for non-trailer lines.)

 Documentation/git-interpret-trailers.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index e7c1f821619..92d9c95f9d2 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -27,7 +27,10 @@ Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------------------------------------------
 
-the last two lines starting with `Signed-off-by` are trailers.
+the last two lines starting with `Signed-off-by` are trailers. These two
+trailers have the _key_ `Signed-off-by` and a _value_ (Alice and Bob).
+The key must consist of only ASCII alphanumeric characters and hyphens
+(`-`). The hyphens serve as interword separators.
 
 This command reads commit messages from either the
 _<file>_ arguments or the standard input if no _<file>_ is specified.
-- 
2.53.0.32.gf6228eaf9cc

