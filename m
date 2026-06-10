Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77413ACA5F
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126571; cv=none; b=MTMwrxXb5ucGkWALADMFAruWUEb9HnL5xdXWL+lPVWD566TZVsD8pNCn2TDYOgzDTRiwoR1dPqE2bLLVHWCAAeqdPjDz3LBS/5ADKVIaBGS9qcuqXHjWiV2IDLEuzRFLDOAc1xBRtlOwTmw01b33eWZMgpix8BLHiH1INdBEpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126571; c=relaxed/simple;
	bh=6BdojFRmHzD8W/4GeJ2E83bdh7yTdRN9eokI7JXXZOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qttaOSzxVWvgkPwu6qDtjLjDJFUM+ptmJVOhYOcdTskrKVQWlv1ldwftJuGdCpynov0s2PEoe2E9Em1Mw0fwQf9Pi8iUybi1KzR7lMAq6puJTMIPo6kjNVqW++74uDqeC+EhdElu34KWM13DhrD9QyYp92bBvPTSe7k9yBfYfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F3b09WLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hmms23r2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F3b09WLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hmms23r2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 498BE1D000FB;
	Wed, 10 Jun 2026 17:22:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 17:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126569;
	 x=1781212969; bh=f5O65itaunRb2b5eGXZucgUeZmTLdQhkzGbALz4ZHX8=; b=
	F3b09WLlHT9AoWjSvsKtBX/ZPStqYzHhEGD10KB2qlvUigTnKYlpIjNUsVdkIZYa
	BgaA4oba+gdVvUiJRPLHP+lEsnGSb/4mbuJwup7Gydo3mJ+Iho75qGgfJ38B9Aqf
	4Yz6+WPVWLyyz/41UNxtBx8dBBrIXR4k5ZxX/iYT9pot/HD8LRle6N41MxKakhrT
	xFyCNIsdo/UJNF2F9K9c1OE+wKP7eSSsaHuSGxnO+ztT2mJbDfsaMhKf4i1w2o60
	+FFRP42dYzpvtjzf87r8UTLdI0A6o8wrPqaCw9lgKnS30o3UF3ZhXtCsmwqlm81+
	usWbz0lEduJdP6cdZbTgIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126569; x=
	1781212969; bh=f5O65itaunRb2b5eGXZucgUeZmTLdQhkzGbALz4ZHX8=; b=H
	mms23r2BcKsbATzcyqVg67I1SUIGCSfCSB839o+Y9u8Zoj8yWbETyGOFmwumob5f
	W4HQeGSa5yROIkrlSkWKV6XlmOQ/aZZtG9PfBwGaKay2g/E/KUE9DmOeuA5web7U
	akBqMXfEZyvB+N68jA3uGw8sm2Q3kG+qJi0PL4XRKsp8dn8U6rHfdbXR4nI0EwIr
	Iv/pF5XgJaBw9hzEFMleimQT4Kkg4CZugBHMT5V1DhkmxHdpfdIrpEURbXOTZ21V
	MHt6aHW7eui5hcewEjtQ4Xn9Keb3ZrnYKmmCaLcG1e0iaYpJyEEDPMCI9N3PEnf9
	XXSBCdPWCLdloFeW9cf9Q==
X-ME-Sender: <xms:qNUpasrcDGkGdz4TLBWPoyNRqTBSsgAz-lViO3RTpmfkd2LVKIs3tgs>
    <xme:qNUpamW_gPaRgfPth5iFkP-lzNp_1HG5ZJy8AIpiWXTnrxiDAjlh2Yuyf-ZJDNOsc
    n9Wq8ieNROTDPnVK-FNU7MRUNA03rH6mJzCqCM6mUu2AU9SmQ2l>
X-ME-Received: <xmr:qNUparCWpfAQuKN5rQPML49A_d9GzC4-kuV3iAjSrj8hhF9HfGK1B_GO4xdAA7v-i_QMQQqOHmr-jqxlV-hnZSh7tT6LZUNN0RTQhzcsqF4md5JZnzK60yRCDQ>
X-ME-Proxy-Cause: dmFkZTEaFEwPJpc3GDjZQ0ko3I90dDZJ4E8uHr7r2H1x15coZGzJd3TnFG/lKQm4ZfZmdO
    kJl1dk80yqZqMZykzygwYvapWn+IW64TB7sN89lfa1Lh0GJ+6riPHFuVitSfCwlrky/nFD
    MhgZR2A0RZljvEFp/cNWqCwOlLAsCQXaQtqAiFRW77mtHZwQYYcl22DilURNbrfvdoW7Fq
    ATtEJA6N2BX8/iz5NU3mw+RxqN+26ga1dzqXLvPmC6wbsDm4ay/RZtBzLyspHPkC8Ojvru
    DX3+cW+2a3oz/T8fVW/XLSsO9hQZ4xU1/oMhaCeMPMUML65UW8xZ6AcK4r/YAenRbs6nGK
    2BqyZ5UVRLR19drgc/Xfzv0IXh+Jl5WeldYI9cE///Bh7oIqhmuvkMysgs++z5PQ7HMV8S
    NMtKI1dRke84rbotCCqv/Ex9pN7CYtmsLmjDVALWP6BhmkRkyTu+T617feZpt4BHvOk5ks
    KkuDz1O+cuzMM4TwzbkA/gtH1TKMcnYexBpcx2PnY4rL+O94ga+oxaX9JZCDHvUX6pCuXV
    xCGw3WVAOC08WC0yNehzbrWKjVNWCgl3YViYtZmnhvaay37vCgHZW+DEAcDv5u4f0eXqNE
    7/YqMnvbG+B0DTWpPrQzU7rGjA9zcX6r7vemg50rcoFu7bZ5D1b8QY4XDtNQ
X-ME-Proxy: <xmx:qNUpaq24EKrnklvlnV5T66jC37xXhpWhqvSQkSx6PloK53PMjEVydg>
    <xmx:qdUpat3e-xp5_FQdCZFeIuuzQhGsPOXQripkfL7x4Xnww8WBM5Pzeg>
    <xmx:qdUpavCQZHAUP6a_GsTvF0ur2sazUnwgbLjrktVWc_5g1SiwW05kjg>
    <xmx:qdUpas7MUQAsqSCpsfIKLibnA9pFWHgIH9XVVYuLNHXD6yTu1cFndg>
    <xmx:qdUpau2aBxtTdcZ9_BknIakUbHb6E5qevLRhdMuWhRMblisof5yQfqlF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:22:47 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 04/11] doc: interpret-trailers: not just for commit messages
Date: Wed, 10 Jun 2026 23:21:22 +0200
Message-ID: <V3_cmt_msg_or_other_texts.8a7@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
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
2.54.0.22.g9e26862b904

