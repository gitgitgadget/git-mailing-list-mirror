Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6B1A726B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339097; cv=none; b=gLyNkPUSYvpPIDaF8xxKrpWOyB6if1IOMGYtDkTDY8kzF0aNCjBngfOIjhFscq6r8ILciPOoca72P6czEeKVTMWzYZHzpR2ksbsqjvZH/Vie26bGHMcGLXhUOLseHmlatgPusgdZ49wbq9gsJDXt46yU78EBrszz0u4lavKqsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339097; c=relaxed/simple;
	bh=exbVk4+FmdTUqPq6CXwOSfwofqofExo6fUdFnf8JEXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMPDMdpRa3pVLsN0R38v/qaE2+bJY5/klikE4CO5dhFtxBaju7EVYG3kFSQFkJcobBoIc0z1ykZSe3eT+RXry+S4Qjw4tK9VzaZteoNco56qryN643JLTJesjNCPrzf69DkYM26rLvbghDqa5/VK/uOS/HnLR5xc6N6Kyb3+8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EOf2A4xU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F6WOx6J+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EOf2A4xU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6WOx6J+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC09D1140143;
	Mon, 11 Nov 2024 10:31:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 10:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339094; x=1731425494; bh=bNDa7b0JK5
	wNo4lTl9DPm3IlxO5MCwDerD6XpQMyz5g=; b=EOf2A4xUvyMNX2I2fsUR/7XNQi
	uho/ZnySKg57s4qfHsmyqMJdMqLrBCknsdjqlA2YtKm53npYI5KrHo+Q7RnqJnaE
	Wuj+lboJj+Q6uN6JEPKBGLgjWh60uyGyW0Uhwe7jMswtdH+YDg66KB6QSr0JFuzB
	TKT7OucK+KzFTPBp6nG8FbpfIB6IYuxPGC94M1L9/h2gMli5aDxSl1zQpeQlxRVq
	xJGeXKiBIVXIb6bEFrm6yX02/Dljc0TnVEC/TXR0vuYgUCDLklRroh+jsWPiVEiH
	7Mn2NnnxyQsFK6LTV50AtEVv79Fnfrx3htdOKZKo9FE+I0IPk7M4P7c+TvkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339094; x=1731425494; bh=bNDa7b0JK5wNo4lTl9DPm3IlxO5MCwDerD6
	XpQMyz5g=; b=F6WOx6J+5LDfRJJpMNMV9di6MfgZZtyLFQZWXN/bSay/BCaCPX7
	mXihGINWgRlihi8Uby65mWFXG9lEqXlH8AsFmqwyWHAXaURXb2/Yt2xaKE6KhR/i
	UHceRxE8rpObsKmKVhjorpKp7qAuS2FdaPRWa14Wug2ysbqTmbkNLG9L0TLhVJvy
	SrCBZhtm2wJRMrYhOGvHtbYMQKMMo5QPUXeNz5V7W57H1c1kGr2LioVH3YsrznEY
	cGJy04COGCsZD+oYvQFKV5u3jU8eT/CI/lUQ/XlDWVMVDcv0upYIhyFy3YJadi1D
	z5XIZjPDe7+OdP2yAWWkEbtCXE147R4sNvA==
X-ME-Sender: <xms:ViMyZ8Z18Z2xUz6xvXXWougtggVFyhTfFps2Swc9laUYsNecZ2_fdA>
    <xme:ViMyZ3YlHb4FT5xMzS-Sn857tmkkyc_cZpm4Zk7YvlK25ktON1eniYMT2GEWlxIx4
    e93_54Uv1Vn6H1zSA>
X-ME-Received: <xmr:ViMyZ29POfZyprSGih2ZfuovSxdcqXVPczKcAE5DAFfcoSfSruPPOpriTCqQxpEnR9txUXZS_cdY38kdkl6v35aOe1EQh7o9yTRbWWOCQ3KZ8rM7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpedthfeiteevkeeggeekleeiffehvdefieeggfevhfdthffg
    hfeltdelgfdtieejheenucffohhmrghinhephhhtthhprdhshhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdroh
    hrgh
X-ME-Proxy: <xmx:ViMyZ2r4-xSTAT6n91UTtiy96BRcmYgRXLdV9uYTc9CAfbgFtlS1gg>
    <xmx:ViMyZ3rFc3pYhE-eCZlWL7VSiddKHw_tu6QLJMtErAW2fWM7FSEScQ>
    <xmx:ViMyZ0RNFYCtHRIyumyG-WgJ0gwIJPPfsSvOAnNYRDLF4O2OKEzYjA>
    <xmx:ViMyZ3qPylG0AFXw8hiyvMAfi1hr07FY1xYVdyyqBFZWCQPl6Ym1HA>
    <xmx:ViMyZ7fxJs1BlFdELuLqyd9aZFwuhgDOyYfyYBbTgPnQQPutScWubvJS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7dafe94a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:58 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 19/19] meson: fix conflicts with in-flight topics
Message-ID: <0be293e8bff0904aed6852b4aee376f9e9170c54.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

As support for Meson is still in-flight we have to accommodate for
conflicts with topics in "seen". The following conflicts are being
addressed in this commit:

  - ej/cat-file-remote-object-info adds t1017.

  - cc/promisor-remote-capability adds t5710.

  - ds/path-walk adds t6601 as well as "path-walk.c" and
    "test-path-walk.c".

  - am/git-blame-ignore-revs-by-default adds t8015 and t8016.

  - ps/reftable-detach adds "reftable/system.c".

  - js/libgit-rust adds "common-exit.c" and "common-init.c".

This is somewhat painful in the current state where Meson is not yet
part of the main tree, but we'll have to live with that for the time
being.

I've split this commit out into a separate fixup-style commit such that
it is possible to test this topic both with and without "seen" merged
into it. You can simply revert this commit to test without "seen".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 4 ++++
 t/helper/meson.build | 1 +
 t/meson.build        | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/meson.build b/meson.build
index 86d9a5c9f94..d1b97443b8f 100644
--- a/meson.build
+++ b/meson.build
@@ -65,6 +65,8 @@ libgit_sources = [
   'commit-graph.c',
   'commit-reach.c',
   'commit.c',
+  'common-exit.c',
+  'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
@@ -177,6 +179,7 @@ libgit_sources = [
   'parse-options.c',
   'patch-delta.c',
   'patch-ids.c',
+  'path-walk.c',
   'path.c',
   'pathspec.c',
   'pkt-line.c',
@@ -217,6 +220,7 @@ libgit_sources = [
   'reftable/reader.c',
   'reftable/record.c',
   'reftable/stack.c',
+  'reftable/system.c',
   'reftable/tree.c',
   'reftable/writer.c',
   'remote.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 5e83884246e..f502d1aaa36 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -40,6 +40,7 @@ test_tool_sources = [
   'test-parse-pathspec-file.c',
   'test-partial-clone.c',
   'test-path-utils.c',
+  'test-path-walk.c',
   'test-pcre2-config.c',
   'test-pkt-line.c',
   'test-proc-receive.c',
diff --git a/t/meson.build b/t/meson.build
index 9ec0b7fa34a..c9ea849233c 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -168,6 +168,7 @@ integration_tests = [
   't1014-read-tree-confusing.sh',
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
+  't1017-cat-file-remote-object-info.sh',
   't1020-subdirectory.sh',
   't1021-rerere-in-workdir.sh',
   't1022-read-tree-partial-clone.sh',
@@ -719,6 +720,7 @@ integration_tests = [
   't5703-upload-pack-ref-in-want.sh',
   't5704-protocol-violations.sh',
   't5705-session-id-in-capabilities.sh',
+  't5710-promisor-remote-capability.sh',
   't5730-protocol-v2-bundle-uri-file.sh',
   't5731-protocol-v2-bundle-uri-git.sh',
   't5732-protocol-v2-bundle-uri-http.sh',
@@ -821,6 +823,7 @@ integration_tests = [
   't6500-gc.sh',
   't6501-freshen-objects.sh',
   't6600-test-reach.sh',
+  't6601-path-walk.sh',
   't6700-tree-depth.sh',
   't7001-mv.sh',
   't7002-mv-sparse-checkout.sh',
@@ -947,6 +950,8 @@ integration_tests = [
   't8012-blame-colors.sh',
   't8013-blame-ignore-revs.sh',
   't8014-blame-ignore-fuzzy.sh',
+  't8015-blame-default-ignore-revs.sh',
+  't8016-blame-override-ignore-revs.sh',
   't9001-send-email.sh',
   't9002-column.sh',
   't9003-help-autocorrect.sh',
-- 
2.47.0.229.g8f8d6eee53.dirty

