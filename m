Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66468367B92
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405515; cv=none; b=d8aQ2lNXRwHFXH75uwSZs09uKqgUnd5Frw0ejAIF3/0X9u9mK2h0oT2RXemLs6kHZMe28M7Q4ErYt3RRGjdqSBYrimbdt0OjjmoSg2O2+GPAsmJLxatLHAK2blXFIVO13BgkdVA1UI7Ho3r4f/u5MlQ7ujWhZ2U+ewDq3NprX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405515; c=relaxed/simple;
	bh=4jQgUPPdGlTx/I581cSXjQHlnnn96Ei+ZCIETboLqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHk1CTpQr8apfDAuoly+QyqRfjao1krgYaEsn/vvLMLXZEP+skd+fGQC83CtMQ85QJ43Lx/J0HR43bdUSl9d2sWhEDFjVP6wnONvdjMd1XzO3Ok72vjAV9QkbI2e0c0PHKywNzaeD+sHhFidS9blm0/ysAGZA5VN0FUaypxq0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=JVzlpBdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/TRYyOP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="JVzlpBdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/TRYyOP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9ECC31D00114;
	Thu, 30 Jul 2026 05:58:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jul 2026 05:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785405513;
	 x=1785491913; bh=YDEgUM871s+lgkHZnbppOsNxSAf9ckYln+TGan1ieSA=; b=
	JVzlpBdqEGhdUyd44l6a7DRfAifS/joRjDfIcFMcIfYUauARJuA2wwfQPY4bAZFR
	60oPd8mlvwFkofCi151FQe/Ki/JwuyO/JzPwiyq48pyWtapUK/U+JX9Y//Am7Way
	XOvGgT2FaOyE5Py7nzkW5/rAwWxjSeTDzZy4FUiDw1FZ4CSDcSQSpBaLQpRg+7QB
	IfHDy/Wy5Aw6L1uGmIwRSExI4hMjn8M+nEZ13x79rQLbMKuj85X8LgnJeSPpDswv
	f8XcGdovp/UytFUJEx4MOGcXTKmoa+e4RQj8Zub1rBxI2Ro119AjEF02iDqqKfza
	4/uBpC3hZ9zNEshbYNMoBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785405513; x=
	1785491913; bh=YDEgUM871s+lgkHZnbppOsNxSAf9ckYln+TGan1ieSA=; b=j
	/TRYyOPV+fLRFKPsTzmgudpbgjmRQiuZZyu3xXXxCXvGlKt6VP8U6B9NQpkMpeWd
	TH2yyvUWgamYRSCPsTzXbyqAEkmate2ZkKsbVp+Cy9IoLsMaSjQI6utIAMgxqXTm
	RJ6Rizl+y5142vqUmKKRBu0pEPgzIoTvngkQ3dhRwnfaT1RH1vcNWq0GRYrx9tj8
	0rPg4idRSVr7xAtmTLzrepKBsQICgblN88puS5M3Z1WhX9UTXGE6GkABJQbii8cp
	FQ2bE+Pe5nrEMukeiyML41DGgsDd+rJNBLDZyqCjoLc30U+d0p9rRyrZ3PnJIMCp
	MWpRJMt+TPrnMIkK9+DCA==
X-ME-Sender: <xms:SSBrapjqKZQ30Kp3eyYRR8C7oHWjYh_BRzavAVlSJGoQVMqpcQ_iOko>
    <xme:SSBrahu0Lsq6VqykoG06LEjfMPYkXxUpzQx-kjYdDWpQO3TG1sBo4HwvahuffcRmV
    SP9sDvZdbGYoOWLb8L7SL7KEDDWYg803YouMY6dDAqpsc2py25B-Q>
X-ME-Received: <xmr:SSBrai5MWsenlrINTbD89QzJWwUyInmKRBFOXGLi1nKRutSSmsHN-IrBM0Mtc4QP-q8W_Isv4HWxarelWjk60DiWHZZj-14zls-hgPMy9_Y_YjhY2i0MfUo>
X-ME-Proxy-Cause: dmFkZTFWKTUTenwbTic7A2L9dR0P/KNA35vUSOhMHjyZ+NzizX2hp50PZXp5tU3dtvtiqF
    RK+U0WrW7uQ9lzgpvH/xZBJDVEZIzuHrU6m4ynqJinfty0dfGZ6yErDIQ8x5UsoSuaDNV7
    K5X1Iov7Bt0pdewoByYywdWl+zsdcBB0tlQq/vE1m12a8sFIl39b3zYN0gPtFHdJk6o0J1
    4KhzD0yEEiYnIJi9HF6loAZ6jydY2QXR9MEMUusf/fqbundg3STn/EvRkhA8tqyiElDtZP
    KWNFDqRPasOpI2ZXEdQ6BJlsVd7QqjBEx1LzOolFXOuizyXiSJM4d5SEP9B0c5jkQwg4QA
    rakCpBK7mNkuHG6J7WN5qmkYMVHT1KNv4IXN0Y/Xz18DGd+GP2A2N793Z1tHI7QF3KIKWZ
    +MgvHTnfGQ1aiObOMnOPW6/OA7+anX5T4y3D4+TlK0lc+CaWLVBuV0LL5rK6KhlkAWXcqy
    +1h2g/4QHx84eVRtem7wmkpb1Fim5JuFFw20wBE2g5ex4vunzezpPHWlyqn+eIqXVW3I2/
    2H1nEQUadvY2ON04jySFtmSceD2xXgfEDaKGp8uwS9mMOMtkesG/GCwZQKnudOn/4orFLh
    6j0vMvzjI+dTdb6bZo43wjhiLXLGSshWjwHIUWv00ZJqfLlQLuMqpS5RgTbA
X-ME-Proxy: <xmx:SSBralMzOQRK8623GV1TUGfNj5sliqvmnvJy2cLCjBoKIcHPjYHbYg>
    <xmx:SSBraos7ceG5yLDEDgtHNGGrFE935IfGA1D9cnRLau2okeAjgZYqjA>
    <xmx:SSBragZbCbYA7im2HQg9FnJyRe6tgTm-B9uZE8prdHFpdRF7dlGr9Q>
    <xmx:SSBraiycUxWTJ3e35fJgvAaBUQfwe7QbxMyZ-q06K_YaDhl7OwTJKg>
    <xmx:SSBraimCBG3SiPWESyaN8PauqzilSwQrcm9rMPmcSaMmJarBv2i--Lxb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:58:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4 3/4] doc: replay: use a nested description list
Date: Thu, 30 Jul 2026 11:57:15 +0200
Message-ID: <V4_--ref-action_definition_list.af6@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_replay_config.af3@msgid.xyz>
References: <CV_doc_replay_config.709@msgid.xyz> <V4_CV_doc_replay_config.af3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This bullet list for `--ref-action` introduces a term with a colon.
This is exactly what a description list is, structurally. Let’s be
stylistically consistent and use the desc. list markup construct.

In short, just transform this unordered list in the same way that we
did for `replay.refAction` in the previous commit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Msg:[1] Fix typo: “stylistically”
    • Msg: Simplify message. Devote one paragraph to   † 1: Commit
      explain the transformation. Then delegate to the         message
      previous patch since we did the same trans-
      formation there.
    
    ---
    
    v2:
    • Msg: Mention that the explanation for the description list is the
      same as in the previous commit
    • Msg: It’s “description list”, not “definition list”

 Documentation/git-replay.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4de85088d6c..b4fe43ec687 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -80,10 +80,10 @@ incompatible with `--contained` (which is a modifier for `--onto` only).
 	Control how references are updated. The mode can be:
 +
 --
-	* `update` (default): Update refs directly using an atomic transaction.
-	  All refs are updated or none are (all-or-nothing behavior).
-	* `print`: Output update-ref commands for pipeline use. This is the
-	  traditional behavior where output can be piped to `git update-ref --stdin`.
+`update` (default);; Update refs directly using an atomic transaction.
+	All refs are updated or none are (all-or-nothing behavior).
+`print`;; Output update-ref commands for pipeline use. This is the
+	traditional behavior where output can be piped to `git update-ref --stdin`.
 --
 +
 The default mode can be configured via the `replay.refAction` configuration variable.
-- 
2.54.0.22.g9e26862b904

