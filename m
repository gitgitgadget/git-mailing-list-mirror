Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CA18859B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990177; cv=none; b=ipS2X4gOxB1+IUoK9DsOBonraEoj8A8EKnPDIu7oTjc6BU9WzvX7yEW9qXcg5ngUmRs9Lp+tEPozeZT6KxSOzQgQpjubpdm6Pfy41Iy4dYzzqvHNMSKukDO9VeEU70UC6irkiNH8WdQ3ekjrCqOHQkrLK7Rc4pPB71JNLQFLUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990177; c=relaxed/simple;
	bh=9bml/QUQ/gwH6trwa0aq86ZyAat0NQ62NiTnH0lf7ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeIakM56GOxKzR7FpDqs896hVBwb4K87ORFFhvha7R1WzjOg/nzLN5jYmm7OcWA9X8Sl2h3hWcf0TdvROKYsjHIU3xUUR5DYVWQXAD2YnbYM75R/Bs6EYQHpGlVk7N415ag7WY3449nhR4/EPI8B1cdc0shqcO0nJPPmcXUZGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VOaC1ci5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2Eb2zQT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VOaC1ci5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2Eb2zQT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AA7DEC0276;
	Tue, 31 Mar 2026 16:49:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 16:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774990175;
	 x=1775076575; bh=p8SEzCaTDonBMl7BGg+f1MDdXoKS/MKhaYfp+5NW1Yw=; b=
	VOaC1ci5OxgQMVU8fG1MlS1beCkfqfuWtgxtJYubiLhje/fDEiS4nRqz271akpve
	9i6pxqoJks0cfQd1ucFE0Yp9F9aTMUa5ABRIbo/JLopsMHDbL4qHK1DJEzwyKkmH
	8GN6XicAnXg+gsyvjo6lfQGcMtRkR1HAtoe5UjdFaDOQaZQK7qqS5uFa5v6QYgxF
	sRxpG4bl7RQmzsAk0gGjRcwuM9DJiQ4u0j++ozOAn/YpDtWK8fhdyVxxGpdvdoHo
	pzOGfcQJa6fpZhX33bFpipq6ACyv5y6dyy4FBH9OBOg3f6/5etvl7/gAt3lTGw9x
	3bMK5E89Xupb7hknfMB88w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774990175; x=
	1775076575; bh=p8SEzCaTDonBMl7BGg+f1MDdXoKS/MKhaYfp+5NW1Yw=; b=V
	2Eb2zQTpILohc6ioRZvGnWkSFYxRLyBCJpLrplgIwC2nUQsuaUTEd7xy68b0DH8N
	xnCzjp+yFj3K4jP2ZCheyowY0U/pUkTlCvLwKmL8gGofK9vNGJEjkYpFGR7qLS21
	PqnjFXYHrgXmRbgOq8okuAfPUuA1GSSkAXpfYN0/x1y2amfNsk+kOHz7g2/IUON6
	AC0bcolT/y4+O29M/PC19Y6eNQAr0t15toOzPpna0CiB4FK1Y1+6OgnZIHutRru0
	D5OpLWM5V0BGBx0UEsBPFTnHuW5nEI5ZTDl5hJ4AZVoq1gYUfkvkKi3bU66jIjeI
	4yvVud3PLeEhbap7NA/UQ==
X-ME-Sender: <xms:XjPMaRA6jq3E6_CC6lCtaMxFJVXcOwAkXrs6X0YhIRsYmnwOqwhAUr8>
    <xme:XjPMaW8QS8arH3nEdeUKSgFWNRoZJEVXpCeTOafWFhNAsV-DVvV_BPuMzn0xk3pNU
    zEqAyC9B4a_UKr_tIfa2o5hmWT9l8qmP52R1RE1A-Tc0zYAv7PEVQ>
X-ME-Received: <xmr:XjPMaZ_Bi3sV_CpqnHNnjW9QOne0eNhgn6td6tDDHzqoq4FDBrOz9q26rb7_N9uj4eoHpCTRl4pc0qT26nCuUrXAp4JTC7SX-GzXWHQyIRr-2AsA2P-St29xxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkf
    fojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhf
    ejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:XjPMaVfO1HNn2s13qy4_1aCDFo_00iSzZ0t1cs2bO8xfnUrXLnpoPA>
    <xmx:XjPMaaGAk5emMlb8XtggQ8veTGeKNGtfBxjL0DPZVAEzNSYhgerB7A>
    <xmx:XjPMabfrW0xmpn9ODuUkHcMBFVpCVEYrv9vSXQGAh-Fdxnm8EqtBjw>
    <xmx:XjPMacHQcIUzWliCaJc8ktEMgrj0ppRvhebjKV8e6msOrDEElTHmKQ>
    <xmx:XzPMafFhGjqHmkVTRyGrDuqdNpcjyXHctvhn16gzLBGq4pmtJoyShXCF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 16:49:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im
Subject: [PATCH 1/3] doc: var: link -l to git config list
Date: Tue, 31 Mar 2026 22:48:08 +0200
Message-ID: <doc_var_no_config_-l.54b@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The option `-l` is deprecated and links to `git config -l` as the
replacement—which is also deprecated. Break the deprecation chain by
linking to `git config list`, the command which has superseded `git
config -l`.

Also promote this part from a parenthetical to a warning admonition.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-var.adoc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index b606c2d6499..98f4dc1a479 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -21,8 +21,9 @@ OPTIONS
 `-l`::
 	Display the logical variables. In addition, all the
 	variables of the Git configuration file .git/config are listed
-	as well. (However, the configuration variables listing functionality
-	is deprecated in favor of `git config -l`.)
+	as well.
++
+WARNING: Deprecated in favor of `git config list`.
 
 EXAMPLES
 --------
-- 
2.53.0.32.gf6228eaf9cc

