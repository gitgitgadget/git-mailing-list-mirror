Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EF2E9EAD
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310664; cv=none; b=QwxyapPJYRkM9QtJ43piEbMF4xWmndastNmvb8/dNTf9c/J0GL1M6HfrlCMtcrmMAL9Mv+aBnATeoXz2ZkoO8RRvxD51/X9a8kOurh2H8Wi/WYEQHoLIHpvIL8BeReCk0KlQvDwhPfGSwm1Mvxmmhy23BkIZLKYQum9itg2sGug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310664; c=relaxed/simple;
	bh=uhgcKV7rKJ8Q6KzpQXEtiRNGKOzbiaixaajRgS50C+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2iN/aziSRIVvhdGPkChF2dmHZe6YSPmeCrn2vhkvKLjWXka772b+oNnLAY42nPsi7TqFgY5l6msAlIZ/gMBIBqxHNuFSqGqeZbpOr8xAzw0p5GcbTevi+nbEMQbsGokOtWtRYuBpm5g36yRe+QzTj+u5kjEnhMKNQU1x2qUVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bF63HFxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWi5s3MH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bF63HFxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWi5s3MH"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 9412AEC03AE;
	Mon, 30 Jun 2025 15:11:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 30 Jun 2025 15:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751310661;
	 x=1751397061; bh=y+0BxWMaN0VnX2wmVjPo0RZ3W0Ru3cH87CvGHlpNLf4=; b=
	bF63HFxp6LT3hDUmIqtQcOmia2GnZMSgjSg/5MJolG+Xvy9iOkvYz6xiFqxUH6RD
	/eNw6616dMNLPoDajIwdp1tXfLbNkARFTNDYaggNakG073hY2LG/QTy/Zg8Y0EXw
	MA9tCKmWqD+4LYwVs6Hw4R6GX81FKmTVM6LybUOoOQIOHSn+k0oI7LY67KBMyXMH
	3Z9gPE5c6zDuLghOSyozuFigroRZWCITEKNZ3tNQxl6i1U6NvwxfIue2qwp+tuFT
	p91/75bv2nqKYVitlRuBMOEnWS6tNMYEOd+jiefPobvtzbau6jlFDJtONAzfWSM/
	SVUKkuzi+tLwkUKw24mX5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751310661; x=
	1751397061; bh=y+0BxWMaN0VnX2wmVjPo0RZ3W0Ru3cH87CvGHlpNLf4=; b=T
	Wi5s3MH2TDoZkhfWp2J81djaykkV/J/3B+97+/4CMwWF+eltIxBc3HEwt69kiBWQ
	EMz86DoWIMO9ywupi5W1KF7eb71/hdbhcZL6kAPMPhRr96Jpn1JxaruH/8XJCQF7
	Kw0PZc681GulWhwT12wSLBwyiV2foRrma46pYSmPu7mWGU+ZhHsOuNwBp2II/ISm
	Jb2YeHw1KrQ/PFQ7427Q3pWdeeXzmGnKQNZ1R/YdxIUb8wEkrt6EnJpqKScnclBr
	ctmRyaYGWfuBYHsdMt3nl/R1VEzEa/AutMMdYlTFJe9UVtJrNKJ+JQZknyRVlIDh
	Jlrk0j01SnMWufHkOOlCg==
X-ME-Sender: <xms:ReFiaOFj6QsfSqS4XY9ubxsAw55wBko9_QGI2IZTBBjVIlGF9vbUltY>
    <xme:ReFiaPXIfTtN-2a76C4ZNc9Yb0fEfXvH6_Fr5THQmaEWDr6Jk1aknQo1arOtI_ni0
    dg02mI-cet76js0jg>
X-ME-Received: <xmr:ReFiaIIGVwar2KUjdhid8-F-32wrbNy-uwl68RZP9DRZadmhMn4pfjreRsGbg3hwLkcfkKQZBfX_HSSJ2EWGq56a5RKiw0hcW-R5u8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:ReFiaIH9oeO7Yk6RpN-y9UaOdd3C-33wQ3_K2ngqRs96re4NviUO6Q>
    <xmx:ReFiaEWa6kIJi0w80lp8OxfcCar1C2XZuUYW-EBU1XIDpk3svel61Q>
    <xmx:ReFiaLNJANNuBcyv5Tbet-AGHdOF6qCu45Uvmshpin_L0RirzH3XKQ>
    <xmx:ReFiaL3E97ZhQNhfON_AKSKf41uj5Cw5sI-38DtXFI8Ex02GTQaxpQ>
    <xmx:ReFiaNXPE82rHsx70iSt1bCvhgS883_Da6Q6Ui96ZjHqE9fvA4vQZ__C>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:11:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 4/5] doc: config: use --value instead of value-pattern
Date: Mon, 30 Jun 2025 21:10:26 +0200
Message-ID: <e895215e0cd3bd29c66c3facd168611289af9981.1751310455.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0-KH
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This option was introduced in a series of commits from fe3ccc7aab (Merge
branch 'ps/config-subcommands', 2024-05-15) and deprecated
`value-pattern`.  But `value-pattern` is still used throughout the doc.

The deprecated modes have been quarantined in the “Deprecated Modes”
section.  So let’s only use `--value=<pattern>` in the rest of the doc.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 03808b18d3e..9d8f9bb04e5 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -26,7 +26,7 @@ escaped.
 
 Multiple lines can be added to an option by using the `--append` option.
 If you want to update or unset an option which can occur on multiple
-lines, a `value-pattern` (which is an extended regular expression,
+lines, `--value=<pattern>` (which is an extended regular expression,
 unless the `--fixed-value` option is given) needs to be given.  Only the
 existing values that match the pattern are updated or unset.  If
 you want to handle the lines that do *not* match the pattern, just
@@ -109,7 +109,7 @@ OPTIONS
 
 --replace-all::
 	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the `value-pattern`).
+	all lines matching the key (and optionally `--value=<pattern>`).
 
 --append::
 	Adds a new line to the option without altering any existing
@@ -209,10 +209,10 @@ See also <<FILES>>.
 Use `--no-value` to unset _<pattern>_.
 
 --fixed-value::
-	When used with the `value-pattern` argument, treat `value-pattern` as
+	When used with `--value=<pattern>`, treat _<pattern>_ as
 	an exact string instead of a regular expression. This will restrict
 	the name/value pairs that are matched to only those where the value
-	is exactly equal to the `value-pattern`.
+	is exactly equal to _<pattern>_.
 
 --type <type>::
   'git config' will ensure that any input or output is valid under the given
-- 
2.50.0.138.gf67de2ec4e7

