Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79271EB195
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763129149; cv=none; b=GC2v0Qyp3yroAHNsFcmaCUZKBWcDyJdd8qq5k9cqfCCfrVnhWo5iJ9bi9XHi+PJAc/BiHdJfg5AkcGVEoe2mducO1qB+taPg48ufIIm8xOd0VpJr3Gg/dUumaKdLlwY2mgeDXpOkkP6u7KHBlcNaBi7Bi3cBgymoMzpCME0/ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763129149; c=relaxed/simple;
	bh=zTGXXpP+adZifMml4GcDLmDHhT2z2XyhuLwXSEfMeAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAPd0NCV11f/iTazcnOeT6bftC8+SkADpQ2j6Iy1ZQABqNvqpuc3HkTFXb8IcivHRkf3rIgipfuHp45a8D6tW6rgOCbA5BBeH6U/OsUBnGxkRX/im+S+9zBuZoQLZonDQ/bDRZBX48W3SIbF/C5KR3kKX0zRO4ZjB2JPj0pM0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oJBwOtio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5vYSWLx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oJBwOtio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5vYSWLx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EF4BC1D00192;
	Fri, 14 Nov 2025 09:05:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 09:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1763129145; x=1763215545; bh=WM
	XEu8WcRuKCkAAUVG9lEUgvcYJRZbMhl56YUtKX+Rc=; b=oJBwOtiof7WhjQOoBW
	hQOdQI2o5tl++O8G2xlRH8tS/2aYBtyXqiTil1K4NfomSDMM5jbcYy9HK9+VCLQA
	MUICIQTJ59USxOuqW/XAK+1GdeNNjDj5iMZo5RY04GCEoT8sjJXueedXaPfqjXfe
	NDc2gm3hURp0xaQzP29m2DTa/VVgWZzNrXx2F8uGIEcnAewcU/qAu8tHP/cEgY5z
	9kYsFvOeY6WvzwNdTYNLTpN61w7orimLmHFx18U2kkJ1IVdqsTNuuIH+OcB9z67e
	C1Ta6u3++32Yti6YYN2FSmGAtJ3asnj2u8d7G+3V0DjfjSWcqnGApf0m2v5BkOqV
	yb7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1763129145; x=1763215545; bh=WMXEu8WcRuKCkAAUVG9lEUgvcYJR
	ZbMhl56YUtKX+Rc=; b=G5vYSWLx0EbSzbQQwPTt9yDyVSbeZ1BQcNt6iZnPgWmm
	37K9etinKBY4G+OtmyO9Ciqor5HBgWYSbcjMgGgUAsd67dXC21r/wYD9gQj40Cq3
	7qrmUYsGtbJep+CaNKUHI4WEU3qOrBgdUIBIVQcu/xykSc24dLHur7e6lZrAjRgh
	c7guqF1cn4B9P+OmoL3lfBEWZclCqC9jepwGzVw3i7i6CCw8BwVu1Glu2MJhk+SX
	+W7S9OULNbPCGWB5WwyR1pHuIazi44Nlk+V4CqrA4qj5RvrMSkCSzxSRlwBSms9r
	t2OGTADMHTbhWNDwg2pzjPLT34buELITpFYqQHCLRQ==
X-ME-Sender: <xms:OTcXad4vfW5CRNENP0F2oY4GlhTXBE_QxGvkxiUH2jOlSeQqNSo1JjE>
    <xme:OTcXaSXNyNqAJyGias0bn3zq8iTnBuDR8FUy1IZrHBaTGZwIvFb6obJCderTP24BU
    c897eH-tU-Wq8BxK494wcK2zpzW9fXibAUtXUUTMt6AtBPpPawy>
X-ME-Received: <xmr:OTcXaR2faPiWG_uoM0zPs9zHc77E_8QlkEWlEi5NYSXPMXeFOIPSW2BkBP-HxL8UjaLTcGFds1wHhXqVzvRj14fSo7WNlaUGioebKdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekgidtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnhepffffheetgeekfeeijeffveekheefhfetud
    eugffgheekfeekuefgvdehudekjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:OTcXaf1QBoECTRJOresqjO5E_zXq8NLkddKAk8cieI_3cRjXVpiIVg>
    <xmx:OTcXaU9FERZPDHESgSLL7QY0FGsVBWUsnd9R01DhmNrCwPPOhAdcNA>
    <xmx:OTcXac39BFvd9odY3557sO2ml4hwp1uwYhmjGYCV6m-5DvB1YIm03Q>
    <xmx:OTcXaR9I9WlwNAAiq4C0H9_WpIDv6-t7UsfdWw_9NfhpCwWQKzYIog>
    <xmx:OTcXaZHzMlDQ6l2eZln-GzpEJIslfGApbj0cjXCGxs8W0oJwz1PVggzR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 09:05:44 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH] doc: commit: link to git-status(1) on all format options
Date: Fri, 14 Nov 2025 15:04:47 +0100
Message-ID: <c4349a03724.1763129061.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.52.0.rc1.43.gdcab96589da
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`--branch` and `--long` refer to git-status(1) options but they don’t tell us
what `short-format` and `long-format` are, respectively. And `--null`
mentions “status” but does not link to the command.

Refer to git-config(1) on `--branch` like `--short` does.

`long-format` is the git-status(1) output. So we can just say that
directly.

Replace “status” with a `linkgit` on `--null`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § Cc
    
    Cc Peff based on:
    
    • f3f47a1e (status: add --long output format option, 2012-10-18) did not
      • Did not link to git-config(1)
    link to git-config(1) even though the previous
    • 7c9f7038 (commit: support alternate status formats, 2009-09-05)
      • This older commit did
    
    I was going to mention these when I was only changing `--long` but the
    scope expanded to the other two options.

 Documentation/git-commit.adoc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index ae988a883b5..30121b3c861 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -144,24 +144,26 @@ See linkgit:git-rebase[1] for details.
 `--short`::
 	When doing a dry-run, give the output in the short-format. See
 	linkgit:git-status[1] for details. Implies `--dry-run`.
 
 `--branch`::
-	Show the branch and tracking info even in short-format.
+	Show the branch and tracking info even in short-format. See
+	linkgit:git-status[1] for details.
 
 `--porcelain`::
 	When doing a dry-run, give the output in a porcelain-ready
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
 
 `--long`::
-	When doing a dry-run, give the output in the long-format.
-	Implies `--dry-run`.
+	When doing a dry-run, give the output in the long-format. This
+	is the default output of linkgit:git-status[1]. Implies
+	`--dry-run`.
 
 `-z`::
 `--null`::
-	When showing `short` or `porcelain` status output, print the
+	When showing `short` or `porcelain` linkgit:git-status[1] output, print the
 	filename verbatim and terminate the entries with _NUL_, instead of _LF_.
 	If no format is given, implies the `--porcelain` output format.
 	Without the `-z` option, filenames with "unusual" characters are
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]).
-- 
2.52.0.rc1.43.gdcab96589da

