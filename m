Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D0202F70
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753425; cv=none; b=a2KrPqhCC9QxKtmWP8Uc0inFFFInayMBkzCmomx/YrrMCeQi7kjJFxmfWX6Oe7BP/0c1XMQccJk6h8OWLdf2a4fMzYkdR+Ct/Dl9Xu7ioPsUxd9lbR69rpUlR4b1reHLX7vefowvFUFFWr+xdGj+mGsuFDiZ8/lvOgoY/XBphp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753425; c=relaxed/simple;
	bh=pf87GmJ9thZAN1CnCTKeutWU+WsrCRZp6R9QeO21I3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiZoBGLdeEyfpyAQm4sXNPXfdVOBxzzyZ05Bm9SPF0TbROZa8ax7Gt+cN4c/h/6+CK2G3srVBxr6Fm2ceMBaAXIl69Hb8SbJFoUft06UOn5R5wl1RyBijdHyR3aE4nqfbICi8HqA53fMrK4kORQ6EPPqCIOLapNmPKAb78Nn1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MLbfuAkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nfu64azf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MLbfuAkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nfu64azf"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2C3C7A012E;
	Tue, 10 Feb 2026 14:57:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 10 Feb 2026 14:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770753422;
	 x=1770839822; bh=w+9k2DTazzoDMR6c+n/qdKWMJxFr4Nbu4uQLL8riCdY=; b=
	MLbfuAkdyMkS6yNOlpTYDW7Hn4oc/BEnkSqGtImh+LcKWoF9JmGRJ8aOZb0qOgHi
	5jlX8z9EQYa8AKtbqu9kpDOWhZxoe2UAnsiEIuqe3pKqEV70M94vuwm/9arQY7ce
	WTXZySpRqAW3XR45gwoOuTJiicyQGYQ+CZilOa0AuHhgGCUDLgwaOsS8f5nqxfuY
	Oe9bI+0ZjGZP+g3ORYzGUufs1L7FUtrc9C41Tr87HVn/m5kov9f1/BX/s66NsmGJ
	z7t+lVyfR4z4DwEOCbISUe0h2TH7IGKi7OoZtnow39IoqPyso2jXoXDq/FOIxVsR
	iVOd6brB/iFMO5qCInMJFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770753422; x=
	1770839822; bh=w+9k2DTazzoDMR6c+n/qdKWMJxFr4Nbu4uQLL8riCdY=; b=N
	fu64azfokBx3AXRhZpGiNR3ODD+Ruwi9yc4UqQizQD5n4DQob81L36glrkTq7dwX
	BiFLVQcxMzqV+iRRMlLKmt2vfHaopitz2SjH+5JA75nSuKuoJMv2RbqDP7nx+1Lt
	JGZRgKnb5/yvbxVDHzw85ZM8nigXfdrkEGA2dgLRSPzna7w3gkQmal+5zySpNWoA
	HnVht8JDXpmqJT4X4xGSPCUbXN2uQL7UQJ+hvtD/9vbVAGccuhug1XHl+vaqL4sX
	urFyw58ogRnXxpqrbXfOVZxUeW8/WtT7E+szgqkgOZKkl0eRJ/07JygCGVh5d78Q
	cN62WmOJqTENbhuqgoQTw==
X-ME-Sender: <xms:jo2LaWp8HSr61mXDymvG_zEsnyeAwHoUGaSk49guty8S_c2Z_AYJ9_M>
    <xme:jo2LacEs37vxQ76deBWmu0ohls7VJ-XGcKFeNN1ESsqjcARWV2PEyAKT_GtC_vH9a
    6sZ4QeelSjH53GiHdXMvyB-0GBi5qWZAaoBbvDODsVpNYyOmBYYm-g>
X-ME-Received: <xmr:jo2LaYl8pVR57mChLz0m88M-H7KpCLgrEIk29wAr7rlWkoOwL2H9GWxzPVoQlX3wejD2FfWRUbTY8zgadrr2_GfYskeP8bQ1MVeIeg7nbkLjYbcec9aAHRqZKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jo2Lafmfbz1U6fYi98DDFcwZe6tkCrwjzLYpwx2ayb8LMRnBupzdAQ>
    <xmx:jo2LaZtOLkSb2_HYK08CpAGc0yOT_nm7jJG4mrviy99SkWcdIpuuSw>
    <xmx:jo2LaSk7zI2u_5DdSRK1rLTcLwcqyHIGvI42FeSoQ8p9HrpPlPxVtw>
    <xmx:jo2LaUsQu2L8Gr4mc60qbM5eSmIu0rNKg1wiAQshfQQwcTjM4Aatsw>
    <xmx:jo2LaUHymmTymIREg8xRwqfyoEr1LdFustN6H9aluryQk5zzS6EiXc_d>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 14:57:01 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v2] doc: rerere-options.adoc: link to git-rerere(1)
Date: Tue, 10 Feb 2026 20:56:49 +0100
Message-ID: <V2_doc_link_rerere.34f@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <doc_link_rerere.328@msgid.xyz>
References: <doc_link_rerere.328@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Five commands include these options. Let’s link to the command so that
the curious user can learn more about what “rerere” is about.

It’s also better to consistently refer to things like
e.g. “git-subcommand(1)” over `git subcommand` or `subcommand`.

Also apply the same treatment to git-add(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name (applied): kh/doc-rerere-options-xref
    
    v2: Same for git-add(1) and expand on the more general point of it all.

 Documentation/rerere-options.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
index b0b920144a6..4395fe05356 100644
--- a/Documentation/rerere-options.adoc
+++ b/Documentation/rerere-options.adoc
@@ -4,6 +4,6 @@
 	the current conflict to update the files in the working
 	tree, allow it to also update the index with the result of
 	resolution.  `--no-rerere-autoupdate` is a good way to
-	double-check what `rerere` did and catch potential
+	double-check what linkgit:git-rerere[1] did and catch potential
 	mismerges, before committing the result to the index with a
-	separate `git add`.
+	separate linkgit:git-add[1].

Interdiff against v1:
  diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-options.adoc
  index 115882edab1..4395fe05356 100644
  --- a/Documentation/rerere-options.adoc
  +++ b/Documentation/rerere-options.adoc
  @@ -6,4 +6,4 @@
   	resolution.  `--no-rerere-autoupdate` is a good way to
   	double-check what linkgit:git-rerere[1] did and catch potential
   	mismerges, before committing the result to the index with a
  -	separate `git add`.
  +	separate linkgit:git-add[1].

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

