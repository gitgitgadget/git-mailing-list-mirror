Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8252BCF72
	for <git@vger.kernel.org>; Fri, 23 May 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028735; cv=none; b=jq92UpWgWolICiIuLF9cjSA/shiOzfIoecgYKdY/Z6mY2JSUEWZYDh5hQNlsii9VmhrDCIKpDNlgWleX2+4Mv8d4SeIbsTzhms1V45WXrR1HBOdvjxEV/iAYmkv4M8rb7/A1RrcRYrG6OziKW4b3v1UNn2+XioACGGM2oe/ATgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028735; c=relaxed/simple;
	bh=8WO06gFN5DeXVR4FdvdmLgpnRpsBM805WEkNQCy9LCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHrcuGJWDECjnNtH2f3Blw9ZEr/1epR6QPOTVYAh6qpFxWE7u9z7477eH/H0DFYGBAhBiJO8Uo8jKWlfeHEmpG2bLRKTJn8Lp1I6LWHDzjwElygpwUcICC7aR3rrcIvxeXw8eQPNyihbJ54GawkA5cmhTwVcRBf78hmlh6YSjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Pe0oZrL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU/1FXYf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Pe0oZrL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU/1FXYf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2B5D11400C7;
	Fri, 23 May 2025 15:32:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 23 May 2025 15:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1748028732; x=
	1748115132; bh=+hMkOcEXmI/xsTPTomfUc5AxrI6ICexf6fyEPc5FEEA=; b=P
	e0oZrL7chAOQOFHXRvyq1zSy1HrsczUhc84DX7b5KRJ/1ufUwcoQHagYKRibdH5n
	ZMtWbByyg9NseabHbY9X28Pk/pwneq1iUs4mzMVk/1474pKPx9Mg1Cn2TjkdbUea
	IcppjcHzipsAmv/VXAckhkkcfDoeV8bRksdcq2XZpKleUgCbo24uVWQMna5DUbR7
	Kzjr5Dz4edMwwq/2ecMIMqoQCb0G3XSLHFIVcLbtRCz9uP5vgbD7pOUNe5cInAeL
	c4c4iHelv//2Tb/oTR/FqSuK8G52zhxqd0KhwKWi1nxTznbXcXBp6QTbRhfAxVwm
	MIFbnkn3C/qsiobKGUhsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1748028732; x=1748115132; bh=+
	hMkOcEXmI/xsTPTomfUc5AxrI6ICexf6fyEPc5FEEA=; b=FU/1FXYf20lm0TvBs
	QGGFEJlfjOvCpk8M7rwudJb/7petg/NQmqem7hX9dmc97hNn6/nno3jKF9j1l+f2
	gRfUpENlhnJOgNM91Srn1oxD/RZX+v+S5WTSDrILP7VZykYE5zfTOX0s7zZ/6y+s
	mCSxbWlE0iBvfqqrzF4CMnn+2Wsrl7B953ezb4SyPEE4fRaVXydJrBHMaIMR16yy
	GW4bs/WkB0XmWRn8xRAv1rLWpAZ20kDC3ORjJYEBeBIbiP6sUGy2Lyp0wwocaVQw
	iijXRrF/k2k8Z5CQG3LQZXyi02m/cfgPof2ooyqUBQ6pJknUo0ACMk57HqSyrzMN
	gGeaw==
X-ME-Sender: <xms:PM0waC3Hg7oGr9o20DymxIrbW0MXpWd4wQEywoy4W4H0iL8A3NFJj14>
    <xme:PM0waFFYgLrU6kyrzFTcO8NYkCoHhEHPpmeKraqR3JDIFFzsMhO0TsNNl8ZchVo-g
    n0ipVbtW4DwTQ7qAA>
X-ME-Received: <xmr:PM0waK64ClhXD0X47QigIkqu745jNKQZaUX687zaa4GM_5tJpmWFVIX7ihIHP052V2wPRT_7bh8Z3PVKRFZzfJnjl66_2zlIrQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljedtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgj
    fhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieff
    vdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhnvghtvghnghesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PM0waD1iyIcp47QHg82WmeB6gkUJB6oEXA0tFLMOq_t6NqaXKgPt7w>
    <xmx:PM0waFFmFIu_ltN1SZEb3Frxu4Q983Hkd0qC4r3C-ihmihPH49v5jQ>
    <xmx:PM0waM_yLp3_CEnncAT4lYcGCzJAqcRBqBQeyQb-1GkOjjYOfMSE_w>
    <xmx:PM0waKntlOZjXnUWKIHzGTMe8oCceZG1nOfZfIHYy4D0xu2Touf_Mw>
    <xmx:PM0waJxxjncx_Ex0iXvCM6iq8iZfmXaya_9eH5UQ18xr9iQsY9zfj5pI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 15:32:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v2 7/9] doc: notes: point out copy --stdin use with argv
Date: Fri, 23 May 2025 21:29:53 +0200
Message-ID: <d8a22847a7df16a1a38eeeacaf714015c7c1a3c4.1748028010.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1747763769.git.code@khaugsbakk.name> <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Unlike `remove --stdin`, this option cannot be combined with object
names given via the command line.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-notes.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index bad83116329..ad152aa94ce 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -87,6 +87,9 @@ In `--stdin` mode, take lines in the format
 on standard input, and copy the notes from each _<from-object>_ to its
 corresponding _<to-object>_.  (The optional _<rest>_ is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
++
+`--stdin` cannot be combined with object names given on the command
+line.
 
 `append`::
 	Append new message(s) given by `-m` or `-F` options to an
-- 
2.49.0.780.g892193c3f50

