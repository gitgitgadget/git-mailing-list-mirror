Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64B3B38B7
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075768; cv=none; b=VSEiwfhS1PaRv+OV1NrrJStM96F474fEr5mukfFZ6BUGSHujeMNfuImdOg729O/9AHuo/+XXBhl+fFYXSahUXwju2MUom0x29/b0jtCM2G54znO5ZFNIBRCbYPKuogPiX1AK1iYX92LqLaP/5XOiGrjmPFxdWJtVhb/9ZCmgxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075768; c=relaxed/simple;
	bh=8eStCbKrYGKg6EBf0dYYkiRIf2X6n4k7mvmrCTezAYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FohdueddX0CdBaNysjUUHZYYngjI9rLaFHGQD9LmKrh3KgDGyEOVUKwd6Zkp/m2qQkof63trrB+n7rNkQoJxCV9GOhypFKsOLrbIx/yw9o1HFUn/rKUBcHX2020GVQ6ed4gWqqiiTShcXvqI9WTDH5g04FMRPxzx4gSC4zsDP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RAzgVcZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rquwF434; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RAzgVcZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rquwF434"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 88FA9EC00B6;
	Mon, 13 Apr 2026 06:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 06:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776075764;
	 x=1776162164; bh=f5piGLMiEYuvtQQYmpeP4MtAAHtWT8O/z4H+QMo5wjU=; b=
	RAzgVcZo/RBx/767IOLCdeNCRk7WtNKYTUOOsMwqM5bKLfIWfZbGWacaM4UOo06V
	2qxIiJ0B0DiuOS5gOhi3AGoPyV3BWhZ/EOtAVLBBbeT/kFtJ3lEnKxsaT5jZPie7
	St9aO4VMfhY0rIKxKDRTGoD4+GgSQgtTzWqGmJniV8bJLzeWVzukNPvukMQ9TPkY
	Ff+1Egy8cR8KplFUszrKiaEtljWBrdcbvPQbF/1QfRAZDpZ34OTr9qdqRGfL13YS
	aNXEFZ80lt8Ig/V6bU3Nf1buGF2zpOEXN3ja5lJEQBNvGfFmh4mI56BK5eITf2v8
	cBXc43Kgd/vzQp3TTe9IBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776075764; x=
	1776162164; bh=f5piGLMiEYuvtQQYmpeP4MtAAHtWT8O/z4H+QMo5wjU=; b=r
	quwF434526wZKQgKq6cbKaa4ST0exxsTYUKkHQShFK2m0v3VyUQ58QrYYauCiBPv
	327Y1kwNlIl60G0Rz5I9vXBB6ZghIieh9F4u6WFWZLLytIf7LsLljmDD0yVRVul+
	ULMZBzAyz7CrfPVVhIG3es2D+9+TCaFXcoyEhDfi9vFe6UgXCBCTe7n2COdcC7gH
	t27yl9xd8GAOpPIUYGFUKhXV7r3cmJ7Aczted1Ibkl5RHzh7Z/KDyEcN/xW1/8Hz
	4GMdJCCyTuCarJVzC11dlunNmKtaOGsHyfFzfTnQriFuDNp3//rYirF5T0LYUvT+
	oFLKVbls6WAd61Mo0COjw==
X-ME-Sender: <xms:9MPcaTw1UCienJNN2QP82QEbOlVn1xBdQFz0Kd1itId8WCXTVh4Vego>
    <xme:9MPcaSJ5d3BC36y6iakn7PPfgHlK2Qqei9oZuXyB__IePInDamliixepWoO8GUiMD
    3I9X5C50VzFRJfZXr66Qqzc4bRI9AXY1gKD6y0ywBfRA21Rd9slQQ>
X-ME-Received: <xmr:9MPcaVqyHQRlFE4VdCIfNcIEdwNuMcVRGn6rfgPUUOa6SkP5P07whdrAjIHyV39FPzXHtpcEXi6BqRZ-Jc13Q03B5dApiwcecorS7pdn5MEHDwGgb2TnKOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhushesuhgtlhgrrdgvughu
X-ME-Proxy: <xmx:9MPcaZL2emsBGvaNUKxfmJG7eP9MhRIFR2kU6b80kA7Ci2i91XKo3A>
    <xmx:9MPcaSTlj1wtNfJiTohF20EB8kdITcXT8ELLL1hwzKBYbcBvt-ucVA>
    <xmx:9MPcaQtCTyq_2aIFMwkfRVQvwoq7PB511vuDbNqM0_KKoMO0MSpsag>
    <xmx:9MPcabZIcvvVcAZqageRfbc3oT-x4q83blO1qCH7r6HrRZ0mUom7Aw>
    <xmx:9MPcaRaQi8NiQOR6a7to7Ztr07DJBMWOnmTMgRKbjsXH2o7F8be32IH4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 06:22:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>
Subject: [PATCH v2 4/9] doc: interpret-trailers: not just for commit messages
Date: Mon, 13 Apr 2026 12:21:03 +0200
Message-ID: <V2_cmt_msg_or_other_texts.617@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command doesn’t interface with commits directly. You can
interpret or modify any kind of text, even though commit messages
are the most relevant.

The git(1) suite also isn’t restricted to only direct commit support
since git-tag(1) learned `--trailer` in 066cef77 (builtin/tag: add
--trailer option, 2024-05-05)

Now, we already introduce the command in the “Name” section as dealing
with commit messages as well. That is fine since that intro line needs
to remain pretty short.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 4e92c8299bb..7329e710e1a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -15,8 +15,8 @@ git interpret-trailers [--in-place] [--trim-empty]
 DESCRIPTION
 -----------
 Add or parse trailers metadata at the end of the otherwise
-free-form part of a commit message. For example, in the following commit
-message
+free-form part of a commit message, or any other kind of text.
+For example, in the following commit message
 
 ------------------------------------------------
 subject
-- 
2.53.0.32.gf6228eaf9cc

