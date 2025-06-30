Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B732E716B
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751310657; cv=none; b=Lcydsz8tItnyqeFPXc2oBs7EpkEtBJUxHfGWJX3raPaY4wVMp2uGq+UBxgED9n6dexEB6frd/cyjT9FuiD392/J25n7wGXnIaq8n5DNeSaubHDnnSNnOsemQIU0u0xnv8VPzEb6+TcR5MCz/jyMjYFGjITA9RbYHhI81WOvwYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751310657; c=relaxed/simple;
	bh=VQuM+ZB9jJF5gEp/O4K4FkZeJN4luQfwtaJr0/k9u7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t15XuJrAoTXGTvYLqSXiewtUFRepE9odXSUgSmoBaZtzp+VEm9lCBw7wQhSIEs5uWiu5tG3fd4b3Nk08QxGJ6vhRLvPJwvA1qAy0BBS0loJ+qlTP4c9zthApfOZKxTkWK/dvAiiAukNevYDxwq8AcBUe7gPiNtUY/genGi1lrg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q3hcBpRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9iUjz18; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q3hcBpRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9iUjz18"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E0EB8EC03AE;
	Mon, 30 Jun 2025 15:10:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Jun 2025 15:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751310654;
	 x=1751397054; bh=3pCw82SNiKFM4XFa6xgAwTDO4V1/ALE92nRPDzjpNZE=; b=
	Q3hcBpRKhjQYlJKrdnZMBZsZ+6kofUHFFWSWPpBfyhjQDhPAGuztReBp8NCTCAea
	6cdBkLPu13HjxP/ioUrCRsV9D3uZUOIgUDWDeolFf58jynpvLrViskhUplLEdOwY
	aIgJwl6DuZ5iVdcqpWzocSyThi0pP8HSFqbfS8YOsC565wsow4+n+AXcwWvF2XU4
	sbYy/+cDHt3hXnxRdt0Q2NBOPCd0cS+NzmlbTU36I7XWvYRcCWP4ziWoTpdvlwd1
	9CFWzXLIOv0Zt86V/9xub/Ev5UaZPu+zX0XOmapTgfNK6Ct/QmUOr2V61stmf4VD
	zF+W/t5QyMVb4rBsjp92NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751310654; x=
	1751397054; bh=3pCw82SNiKFM4XFa6xgAwTDO4V1/ALE92nRPDzjpNZE=; b=H
	9iUjz18MZqbmhWSMvP548Myc6PXO/tfEJ/UCqex1PcssYlVnODsQks56akGmmS3H
	KEQ/JUjTb4+I+6ixBF/QxSh0IAjZ5k+C03aqE8Rst32HJ8HL5cHiL98TkTDDoAhk
	xHUJrUVQ2uhqOg8oRwo9kLKG6GpEUvqLEDRNWtdssaeiOp4Sm3RFXiw5h3TrN2fA
	MJ0KgpKt6WRdpvygxHrtCl1+pm4x32EEE9soFFERJMAQjeqiDABsB360H3KJjZcP
	ry0JPfA9eiGfev9ydoy7MnBBJ6LbHc6t0bvfjB/vvGWd4P34BVw7V7+8EhYxincC
	7QIB0waEdo+ulkVYDw+cg==
X-ME-Sender: <xms:PuFiaGxDKnvb0fSlU2qjYJK9cPh7ZCuxacMN920e8ZPgINllk7Bo_ss>
    <xme:PuFiaCTZF4HKmrIUIf-68JOE7HmPDZ1VeDODLsnyJQqsx9AHZZqMQSYGtKqYfj9oU
    jvUl2wS4x2oDx6Mlw>
X-ME-Received: <xmr:PuFiaIUkzsAiKbKSW5Ff7T-MUf3-evgEY0YVwYasA4Wst3w-PpYjlAmnJONRWez8cUi8kIbpsUyQ_PfdTkrQAhW3MIhoHlgqresRSfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PuFiaMh2FJKVWcY2MTNDnYNJOywdUcN42nscRLMhg0LpA6FC2CguZA>
    <xmx:PuFiaIAHEsKKgSrkBNtqLli81Vq7TwHHpsAQn3JT2ffIAit4NAaPkw>
    <xmx:PuFiaNLNUD8JCaWubFs7RdENrW585yZtnmNp1XL2K8aNJV2VpEXzCg>
    <xmx:PuFiaPDfh9qgXNFojcFiDEMm4yp0IZEEdW2eiQk_RwiOwLNgs9hiHA>
    <xmx:PuFiaOjDPFaWeddMCm0QyjFjl5LrGZtU0jxfg0XtvsXHHeFRCCY1DOWa>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jun 2025 15:10:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 2/5] doc: config: use --value=<pattern> consistently
Date: Mon, 30 Jun 2025 21:10:24 +0200
Message-ID: <a52322528dac34827abd5100a2d3ee49e376e2ed.1751310455.git.code@khaugsbakk.name>
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
branch 'ps/config-subcommands', 2024-05-15).  But two styles were used
for the value provided to the option:

1. Synopsis: `--value=<value>`
2. Deprecated Modes: `--value=<pattern>`

(2) is also used in the synopsis on the command.

Use (2) consistently throughout since it’s a pattern in the general
case (`value` sounds more generic).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-config.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index e05bf813d46..d3ddc538555 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -10,9 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
-'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
-'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
-'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>
+'git config set' [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
+'git config unset' [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config remove-section' [<file-option>] <name>
 'git config edit' [<file-option>]
-- 
2.50.0.138.gf67de2ec4e7

