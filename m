Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90B318ED2
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968920; cv=none; b=GC0sznvBbzjQmz+DG110kI2hWfW5+oF+wCvw+uJa8kcVUvcc37Bvw20vcvzornssjUI3LU1CvoJHRuvAPwGKanBBPAX3K/EsTLT2KAXBmpc9szWh8wjvdMMjdVrkUK1uzMjZ+ZnMRNlhpmYcMBjyUxMumiZ1yqU62IprIaTMW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968920; c=relaxed/simple;
	bh=W0WRfjfNy4KoYuTfKwFUjpzs4raa8xc4J6aghb9mkoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqlY1VVWNAfizH3Y82D3M2+dHq8UHHR+eiLSal9+S49qeHpfYfvWFEjRFv0kq5/5M+9ZxXHw/e91CuT1KGd/4M8jYxV+ems/LQQIIU1/AjPUkHd9IyepvlrxSyhNR/XnihyYx3+Na5K8Lypv1ITiJsCdE1Om5zLskDdC5A3phmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q1vGAdLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yDgbkTID; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q1vGAdLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yDgbkTID"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3F297A0170;
	Fri,  9 Jan 2026 09:28:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 09:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767968917;
	 x=1768055317; bh=pFgisnDVxqng1XqA+0K4OqDHLj38+O055Kz25V0m4pU=; b=
	Q1vGAdLjhE6N4MIFeVMH24lqqjEoRPJ49ycwNCUEhUFx3oQMnDZn/7MlaxrvVB2D
	V186WAE+80RfGf94tDHGBBgzium05K8CWUAtRTbS64g7n+MWa45hQKAaFpByBal3
	7Sy8JLwAYiMuTSm6GGjtmRNXrR6G1iPgXObjdW/nUzSHWM/lth2j9i4DSIOk0MIJ
	FQD/kzjeuQ0Ihfu8xQc81T3vYnRVEG1LlV9Hvadc0nDQJj5G+MKJPdEZEnfAgOcH
	39Nj9kvY8ohAgKe9GmfxzHZCPQOijHpUfLQuCq+W1aojDOoQPejpHVK2ZyyWVxiw
	D33wL+E+k6RReOmMMAhmww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767968917; x=
	1768055317; bh=pFgisnDVxqng1XqA+0K4OqDHLj38+O055Kz25V0m4pU=; b=y
	DgbkTIDEUrLNsiC3UiSt129JHvucoyASRxbLW9lWsUDXBZO64kjJz9YMcxQtFHT+
	hQHdj/1oeWAyLI9Oq9QSbC8bq2/+3XXS+uKkkX1d8B/mOrPZ1zINQDIa8Qk4U2aq
	8FggRAKrNv1CAiTqFn++fn+6bPdk7BI4354j3obKBP2gQ8TMKQC7magbi2rYR93w
	OJ5cGW/XrtAkcscbOMwOpMJfYtq5/eSPU5DTWYWgr+xbelHwmGnhnK/vmo88RK50
	hH7lkRS9cmcJJRVSy4lhAAHCfbRLdQlxPYDZ7XwEooOJKFN1SO5CF2rlFS5jSeVQ
	wAti3H0p4iySxJ1yu2sIg==
X-ME-Sender: <xms:lRBhaTxrg0XreaM1bcT6_oBmeGXTnVuQIntOSoqgml-y3BqAYqtE6SU>
    <xme:lRBhaSRRy_HPU90oSeqFtjPot9_QlysXoq0-pbkBL1kh8ZRgeWntjGw2x-5AMqQOq
    Fdw2PD_giY9PlbSDNF2olXwruddeTQCeS3yhXYd1qpXt3Mp-eKtjA>
X-ME-Received: <xmr:lRBhaSXykRGAwNO3zXAgLZ_j32zuPog2ueQn-_gpxcgGhfeVUCv3R6rTyct2tCN6Gr2Wa4-aa7EgX1nDwDxAaOAak3BWGQ_rcuLzZcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhushhhkhgrrhhkuh
    hmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:lRBhacZl7cMMe7iBrKXTaAZf9I-WUxoDjlIbMaE-dOaH14u_TZ7ArA>
    <xmx:lRBhaQ1vTenqlz0V6ErWmetaAqvJSaDgk3lwPcFNNxOXVb7urPGj7Q>
    <xmx:lRBhaWhEUNyX70BBAQWcDuM7wqODdSWyaZC36_Tpc_xNCorwT9VQCQ>
    <xmx:lRBhacajbbOAF47Exz0ZXKB9Ffyndd5-mf5Pxp7bRM2RT5RXKqAcVQ>
    <xmx:lRBhaZ1YBuh83gp6S9WmyBjT2Ig69KhKFAOWF1JUDAm2POjIiaQ41zjF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:28:36 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 6/6] doc: patch-id: --verbatim locks in --stable
Date: Fri,  9 Jan 2026 15:26:02 +0100
Message-ID: <V2_--verbatim_and_--stable.1b8@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The default `--unstable` is a legacy format that predates `--stable`.
That’s why 2871f4d4 (builtin: patch-id: add --verbatim as a command mode,
2022-10-24) made `--verbatim` lock in[1] `--stable`:

    Users of --unstable mainly care about compatibility with old git
    versions, which unstripping the whitespace would break. Thus there
    isn't a usecase for the combination of --verbatim and --unstable,
    and we don't expose this so as to not add maintainence burden.

† 1: imply `--stable`, disallow `--unstable`

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    Fix “markup” in commit message: `--unstable`.

 Documentation/git-patch-id.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 61498def317..013e1a61906 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -32,7 +32,7 @@ OPTIONS
 
 `--verbatim`::
 	Calculate the patch ID of the input as it is given, do not strip
-	any whitespace.
+	any whitespace. Implies `--stable` and forbids `--unstable`.
 +
 This is the default if `patchid.verbatim` is `true`.
 
-- 
2.52.0.421.gc32ead4fc78

