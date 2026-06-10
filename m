Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D0331EA0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126552; cv=none; b=NXc29zkSMBUZsFW0hCPsL5rp1J58zbAqASQ93M8OncvWnXa0qJzyxhexgM4gYTUcUoiOVSpaT2Dz/rv8MKOQLkOIFPYesAxIhkkhOHQAE/Yu5Q4BCo3ntJmRJBcWu1sTxpanhwuX/owOfuICzXBGD9jH0NossbUxisDaIU3LwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126552; c=relaxed/simple;
	bh=J8AccSRORl6Mq+C2egc+oI6BxbuN2NNrZ2qV//VCPJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azWoV5nSrilubJewC92ehTAvY6jmGT8khqf819HlqDxpqT84VNdY/ELNwmbxgtcv2K3WRibRkyP7kMGi5MHtrG5BsAyZHHHqmlL5/sMkoTX36wpwfrx9fGYGwft0SZYnzIAWMiqKmzEyquYSneM+dDjR8FFHHxBPl2jAo7GdsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HkNZ9qSR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gzY/Rzm3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HkNZ9qSR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gzY/Rzm3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 59EE81D00073;
	Wed, 10 Jun 2026 17:22:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 17:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126550;
	 x=1781212950; bh=ok1HTq5Q582Tg4KMr9pvfqD8dqNzh9Pb8sVOjOn6j5k=; b=
	HkNZ9qSRZoYh4ouLOS5zvmzSZXhYltGgagsNZeuYIXN7gGDgXN3y8cJch8VB94Mc
	ijo7XmYPLoBWhRcOHy0hq2aULR45l4d3Sm8WgCp16tRTFRlI2Ut9GWUcPGUBhLHw
	6vZLFlCPvOwoEobml4nbQ917EDiTdNOtamvZvGLTQy6BkYKjEkKSk1ddyuxWdy5j
	jYd2X4ygQyXI+I+bxBQrif3mwGjDjyII6gVIxf7UZC2IfL3XbKkBqtSeg4HXG/Sr
	h/pvu7EkaDW5SitEmpsYlLh6tpLqGkh2pFwSADgF/fXBRbcdi+p9U0WlFODO04mx
	nFzrGO4P7DRCGE03iNxuQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126550; x=
	1781212950; bh=ok1HTq5Q582Tg4KMr9pvfqD8dqNzh9Pb8sVOjOn6j5k=; b=g
	zY/Rzm3aZaEqbIWC8ZsFkW1RU/ZXal/yrYUCgEDdIpsw5cxtaYVE8RuX5ZKoWj4w
	NxsehhDt+RAem7f6nc4HeIQEEbAhabQ3aoA6G6Kkao+mJbUW2Mf/Or+4QT+4l2qo
	o+QDf6ivNr7U+A+Ii4zggLxfGvDwN8bJ/PE6RhSUXjiyL9ISI22cw95ek+G7DSH3
	4kQ5s+bHv760C4OC2wJVRVFfi6rKEuHQgsKxExiB8Vqsx4Ob74oogM3K3Qcz43jZ
	n0FR/iU7uACQ/NoAtIug6NV73PvqezTEqEknw9VkqBh7EHdwjhL2Il4KTHPERHwQ
	e8f78CF7Tuy6CyijJMaNw==
X-ME-Sender: <xms:ltUpaiTDs3nGQ3y1zCaCsPHmg2cSC6SITQ7PHwQkmoiZDfzykcJfcZ4>
    <xme:ltUparevfWfyVF2BCdEsY59dfHmx46FziBDO5a0yX34U2SE5VPvIQaCd4KlpIOIOd
    nRX_IuBPwcNiFBnpPxsOpDkSR6zncD36JoZsnNb2O10idW4JJCY8XM>
X-ME-Received: <xmr:ltUpapqV2fOcXl2eY_QrJxWgjvJxgoc1kJv_DIn2HdbpV4ygNs6CuoGHsBN-_MGrZx1AksdxdAYu__8I-rNU6rhgFhT7r0jqpJevK9o-gnikz4SDkaF-1aYHAQ>
X-ME-Proxy-Cause: dmFkZTEaFEwPJpc3GDjZQ0ko3I90dDZJ4E8uHr7r2H1x15coZGzJd3TnFG/lKQm4ZfZmdO
    kJl1dk80yqZqMZykzygwYvapWn+IW64TB7sN89lfa1Lh0GJ+6riPHFuVitSfCwlrky/nFD
    MhgZR2A0RZljvEFp/cNWqCwOlLAsCQXaQtqAiFRW77mtHZwQYYcl22DilURNbrfvdoW7Fq
    ATtEJA6N2BX8/iz5NU3mw+RxqN+26ga1dzqXLvPmC6wbsDm4ay/RZtBzLyspHPkC8Ojvru
    DX3+cW+2a3oz/T8fVW/XLSsO9hQZ4xU1/oMhaCeMPMUML65UW8xZ6AcK4r/YAenRbs6nNK
    fum7gwD2veekDQWeawoDKiL4skDton8oFMEMzg2a4oFOTSD7V6+UQ71dlZDm4q9C9h9Z2r
    oeBlIT2oVECooeitaE3U2Gw6oJOU9J2HmZjqlZ5f0luNDsY4d8keAgn8HqP0bbE8VlJDma
    t1mcpHLOJP4khTs7Mw3JbXTRHg5b4hxaMS5sYQkz/WmV2uQ1q9OT+iVLvman0N8Dk2poiO
    3QROjLw47XJxP0MBgmkIRPqZBfK4SKVwBKkLLCmABlN/VQTlJFwmqjs6X1UAfIjWm/vnyP
    2tUYEzRNZ6V1qs0UiTefv85rIjDSWXuWId9iEQY4OA3P//78BUkK0q7MSjAA
X-ME-Proxy: <xmx:ltUpak9-8qmQMgz68qfPBN7BOxlgXuVZeSkBW5GrcB5QK4oX1rA4UA>
    <xmx:ltUpateQBJNzz2OMLT2klRet2qfLZ8Ukrt5qvgxjnwU5Vbc96-KfGQ>
    <xmx:ltUpamL0djqed5ivVHuCvXnu9laepbcOKoQOm-K9TK0hOOwIeqjqCA>
    <xmx:ltUpaliQlhgFnIXBw2-xn6S8VNXPnTYJdkwXEmYcexqHoDyicHHz-g>
    <xmx:ltUpapdlG_YSNGGmrlMizf6AgdjYXtuH7zMutZ0cn_gPCo_weRT-K_Q2>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:22:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 03/11] =?UTF-8?q?doc:=20interpret-trailers:=20use=20?= =?UTF-8?q?=E2=80=9Cmetadata=E2=80=9D=20in=20Name=20as=20well?=
Date: Wed, 10 Jun 2026 23:21:21 +0200
Message-ID: <V3_metadata_Name_section.8a6@msgid.xyz>
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

We now since the previous commit introduce the format as “trailers
metadata”. We can replace “structured information” with “metadata”
in the “Name” section to be consistent.

While “structured information” does emphasize that the data is not
loosely structured, we also say that this command adds to or parses
this format. I don’t think that we need to emphasize that it is
structured since clearly there is some structure there.

Both “metadata” and “structured information” can convey the same
information. But “metadata” is shorter and easier to deploy since
it’s just one word.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 3f60fd9b720..4e92c8299bb 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -3,7 +3,7 @@ git-interpret-trailers(1)
 
 NAME
 ----
-git-interpret-trailers - Add or parse structured information in commit messages
+git-interpret-trailers - Add or parse metadata in commit messages
 
 SYNOPSIS
 --------
-- 
2.54.0.22.g9e26862b904

