Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC061FA25C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787448; cv=none; b=lj7urEqUkRsJ6Ex5jHoZMGsk6WoZ3FsFFLtifCelokwybkuLqdmRXrAAo8/KW+XDt/vTiE1FdW3dvPYvugxVFapoTcItcdkMt0YhkY9ClDNj0IydUgPC+2QK6uUUBoI63zBA56mDBM9x0KztBrsUoAKUkHw/vNjh1j5aPiEmZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787448; c=relaxed/simple;
	bh=vA4Tf9iTVhnFO2ImhPZl5QHn+1iBiA9FclnOFl0t4qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znu0DboUI/8i4JGPPIo2j1C/Wx1H5H9nEIlU6xlAdALgcTcTimjz4LljMIt/s+VdW4WEtuY98mcST52Sp4gXN/nVHtuldwNGy/vYXIQtpt+LI9JyQMv6OAKLho11qGsojlzyYAafGdjkRRspZQ5IXnWPP5BG5n57yWpezlqCAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TyQIqkrG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMb0+Rb2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TyQIqkrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMb0+Rb2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B243F2540076;
	Tue,  5 Nov 2024 01:17:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 05 Nov 2024 01:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787445; x=1730873845; bh=XmXwYZVWy3
	D5JIX08C7nWbknqetoExDfb7x+zQ0GwNU=; b=TyQIqkrGicvZr4xCvlM1XSP39X
	YFTQgWCxDWdebZRbaGFZkgiUroQE/l6NR079ldTxJacRAh/ucF/jHTMOg0UHN4M1
	lEHVsPLeKK54rpQfpam51x9fuaksTLat10tC0I0GslOq912NnIgF1CchCj1zhVhP
	5lOw8ugIwKztCxWM4eW/J5Ser/WTC545vaBekGY6hjyyYSFLNdjHybln6VgpAxhK
	BWDFHSkQfrlp43bGowSgIg4M2UU2RLUhmhNJ7fFEH7BwccApLdZ8Ho0XhjKwVw+d
	PIasXvUSt2mOCyJA6otasXLe3c12wwZ8rW/0PdQdu2aG+8XBSNP1NzY1tj4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787445; x=1730873845; bh=XmXwYZVWy3D5JIX08C7nWbknqetoExDfb7x
	+zQ0GwNU=; b=UMb0+Rb2XQW64hAFUlk1VxghBJ9QMCdCR9g/iMv865AzZViL5Ra
	4DP/3r0uK7/3mjntl8XKa+RXSUk4IaGACC9E/9QGOPIhPBv4TTesu3W17dD/1X0Y
	gfF0C0Jp2BJzJ8w7Wy4J/GCXje+w3KPflTju1R8L2t1J40Z74ClCHXYJRwnBoNJ5
	564s87zY+JFzLZmClxxF3OwnkrTtkL7uvVYHfyVoRwVuKSEIDzKQte8icVW0wVwh
	6FBoct/9wbGDlVEGv3u341EnWRtoPIY75PwsICyeQPoosul44MgF93jSiXtNCUPt
	6jJOgZAQJUQiI/PWdyut8aexUerTZ2FE4dA==
X-ME-Sender: <xms:dbgpZ9-d4BCAUWH1zRGEhoPHis1foUzWVjNIpviDk0KBXUtA0v7IKA>
    <xme:dbgpZxuuAzGiirzIpzJaI5v-Xw55WJyrJUlosxgj9qcD7gh-vMVglJztzBANi620v
    TSiLqn4-WxQiqxSOw>
X-ME-Received: <xmr:dbgpZ7C7QQ-p7Cahep7NFGusD22gX3E31lG8L7-dnJ8Ajylgp6a-_JaMkH7q-MrrzRCZUAFV7IL_k83-lHImRYdtBns_HO0n-DJ0gFeSdjk4eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghl
    rdgtohhm
X-ME-Proxy: <xmx:dbgpZxd2wHjnp2CJFB4y3mgLzlpR9wB9DrXMcZ8JzjwhgfIvG0AWvw>
    <xmx:dbgpZyO2gl9NhfgEEQRXFUwW-1Hc5kb9kolboo5UTvEuHvCfUBBimA>
    <xmx:dbgpZzmbdd34qfHWucewqz5G1nTaD4Tf3kpMPH91F3cPAspKoxsyYQ>
    <xmx:dbgpZ8vese16A5gNGbMQl5BQMUmlIgMAR6xkUqJLZsvvAHk2c286-w>
    <xmx:dbgpZ527aFPjHVG-zasYoIkZFaqQux44JLmHzcVEVqgPHhD7aE-OQKbh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf788c7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:02 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/22] trailer: fix leaking strbufs when formatting
 trailers
Message-ID: <82269e5d5be012f24f52504986a1eb043b9dc17a.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

When formatting trailer lines we iterate through each of the trailers
and munge their respective token/value pairs according to the trailer
options. When formatting a trailer that has its `item->token` pointer
set we perform the munging in two local buffers. In the case where we
figure out that the value is empty and `trim_empty` is set we just skip
over the trailer item. But the buffers are local to the loop and we
don't release their contents, leading to a memory leak.

Plug this leak by lifting the buffers outside of the loop and releasing
them on function return. This fixes the memory leaks, but also optimizes
the loop as we don't have to reallocate the buffers on every single
iteration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7513-interpret-trailers.sh |  1 +
 trailer.c                     | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0f7d8938d98..38d6ccaa001 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -5,6 +5,7 @@
 
 test_description='git interpret-trailers'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # When we want one trailing space at the end of each line, let's use sed
diff --git a/trailer.c b/trailer.c
index 6bafe92b326..8ba350404d4 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1111,6 +1111,8 @@ void format_trailers(const struct process_trailer_options *opts,
 		     struct list_head *trailers,
 		     struct strbuf *out)
 {
+	struct strbuf tok = STRBUF_INIT;
+	struct strbuf val = STRBUF_INIT;
 	size_t origlen = out->len;
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -1118,9 +1120,9 @@ void format_trailers(const struct process_trailer_options *opts,
 	list_for_each(pos, trailers) {
 		item = list_entry(pos, struct trailer_item, list);
 		if (item->token) {
-			struct strbuf tok = STRBUF_INIT;
-			struct strbuf val = STRBUF_INIT;
+			strbuf_reset(&tok);
 			strbuf_addstr(&tok, item->token);
+			strbuf_reset(&val);
 			strbuf_addstr(&val, item->value);
 
 			/*
@@ -1151,9 +1153,6 @@ void format_trailers(const struct process_trailer_options *opts,
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
-			strbuf_release(&tok);
-			strbuf_release(&val);
-
 		} else if (!opts->only_trailers) {
 			if (opts->separator && out->len != origlen) {
 				strbuf_addbuf(out, opts->separator);
@@ -1165,6 +1164,9 @@ void format_trailers(const struct process_trailer_options *opts,
 				strbuf_addch(out, '\n');
 		}
 	}
+
+	strbuf_release(&tok);
+	strbuf_release(&val);
 }
 
 void format_trailers_from_commit(const struct process_trailer_options *opts,
-- 
2.47.0.229.g8f8d6eee53.dirty

