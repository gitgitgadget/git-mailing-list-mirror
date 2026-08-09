Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696324B0493
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306096; cv=none; b=bSOUOTUtFHqgYPovonunb2EqxOApcAhgEs9Pri9/OwXZn3/DKcDLd93qc+5EIyEkr+8//NUX2OSXDie6YRtCIuLWZo7voycBp6BXM3UMTUompWXhBFOzyiIJST0VAxgf/AS6EIJxKUmo3x705WdTq828hvYn6ZF3OPmjG6d1HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306096; c=relaxed/simple;
	bh=67V3WXRFDFhJfMB2tBRGE6tNePIak36ec6k/0KO5Ymk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HP6jvD7DlF4MYz1IEbrVn7RcrjFxS9RkCAivom/09Ghy2eMS4ydYMmvm6RJ9isAhPPuOPCV9Du0SijCTNxIqwWgZSzUH5Ms1da+kx0jIUlc4x3ULh2xartgZBOjTzq7OE3hbb+arDB+O87kcvxL3xXhLOxjnltcNNiuKj28g2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eBWlhjFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccHPuObj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eBWlhjFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccHPuObj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55E667A014C;
	Sun,  9 Aug 2026 16:08:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 16:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306094;
	 x=1786392494; bh=O7f15Ts2O8N2gHo9x59jPskd9V4Z4bm7Jv6Mu5LCL0Y=; b=
	eBWlhjFNs43ZxZEQ3/FIKfJAUjzd/MlgLMi8MNa2M3M9RgaxFoOtGQV2GUwYn1Un
	ZYD89zN6JNKNyxIK4xecAyUjk85bAX0IPFw2L07JqimND25zSfj4DWTZctmdyjB2
	dKlcoNvNBOY8qZowl5FRToS7g7HglkMHT+kexikGlrQ44adhBjb0IKQ8Zas8nt9f
	1V6qFrLftRL+S6is3vi/A4WkuzjrQnKxJj5EsaL6uBRcff9ADZ/ZFT/+LDkre7G6
	eKKub73NBM+/J3I5tA/CMMkBuOlqsYrFpLneI1FkRKtZDPetoNFUMUs6K6TaerkB
	LojNGO21Y/saswKr0gZziQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306094; x=
	1786392494; bh=O7f15Ts2O8N2gHo9x59jPskd9V4Z4bm7Jv6Mu5LCL0Y=; b=c
	cHPuObjmChUx+e3cVxdmvlRidDJDLsREt3RtodqftpCGoKlA4HQ8uSIhyzamDj9l
	eLTdS2nd8J6l6oUevgN4prg5e03RagHs/qtqQa/Ws8nzcnXl+8aY1h66+BsVFXC8
	13NwoIPodetp1FsUkRpdvxLVVilcR4oqHZuLaJE6R/x0dozlOWjVfK+H20PnJhDP
	im8erpBNzuDOvz4I4l1iaEF2eYl2kc6Wp5tvqW/f2NsQGY2xwikI8wVQEEnxpN+k
	AkMgC/bKyOxQLD8TZXYTVheqFuqgQ25Fah6EkKns5jU+JlZgMRSoP0jV70CJ2q12
	j6vlvHPtuMOZrFbEQDFpg==
X-ME-Sender: <xms:Lt54aupC53zUqvzbC1nLETWV_De2U2SoqCa5_Cw05ceEM8t1AY50A2E>
    <xme:Lt54aru0th7yFcvcx9JDXtmrsI4DzOjfWoO_pwYfcHW1UdpS_drYCoMaLpTz3NL6S
    YswTLDEcw9ETeOYRebHMKAFTS70XECA1LspqunIDDebmpQt9jnBLpg>
X-ME-Received: <xmr:Lt54apazG5QTwlTkxVsP0-Tdtt4ddUfFv0ojdqpgHqOFMkyz9PDi--erkw83UkJ0P77mkeDn-6vJ-usM7qjBi5t-_0dWRNKgOOJ7rUTg6amjGuQs0GdWKgo>
X-ME-Proxy-Cause: dmFkZTGDgrJ11887wtahT2bOh7OYHsQUBgHnp9OycZqCDEYNX5Ufjd0PxPUgc93BAA44II
    4K3JRUK1n8IGY3QHnIosZnp+TKJiHUC3HOsCfTBgty9wfQwVRAj8BcVCtpdQi8RC5673Az
    RwlFGzPD8HVQuhjfthfHqTn9ng8YBO+NA1cUY6G7k74yuCagrr2gUe50/jCZjzfzptmS05
    td8pBKp1QKamNnJ1jFU+YZ+bN8W5Q8gJDQeRlu7rp3dczGUnNahSqgfh+rN9l2NjXUq6HF
    UEEiPcsIQkA45TEwZiJj4fqDyM1u+4fxM4QCyl5fNuziPGAG1B0cjqT5uyOSEMuwJLvOO8
    JZAtZ1qovJUH9EXoh5bZ/uHukAB9s3sLpDDxW3Nsl4xONlRwNgcrsyLpYW5qKROOUYzKL2
    Biw/6CISEQ/JcGjvhVGJCqfK0EtqmYF941gZzNFxWGNVjY0ihjsbPES2KCAe4IkI+kYB1A
    mG+IVdmk4z3+RtOaC0st57Ap3QiZ6ujR7xKvqlLvcfyK06uGeKsS7u04z+OoQHnW9wYBa+
    EBui+14QKAHhtSeD3BOphXM7DM/OrmV3fW8XtrVJxb8XJOgc4z5vVVkQZZ1yuV2aZdLAuy
    ALz5LIt8gMX4/VVb+aNNp84haBrMzA7Z0D9PXtpftjJgN0SA10hDU2e9eIGQ
X-ME-Proxy: <xmx:Lt54aqZYVQoYQN-STNIFeX3H1FllNydZ6mg6iLex-6Me_Z9_IBysWQ>
    <xmx:Lt54ailxQum7WqMvVwtLiOGFNCfsxTu_ZHAZlPC2X_a5wOLqZoVIMQ>
    <xmx:Lt54al0CecPyT2mrTAW4DolEUs5UF9yr2ZuXkAvJngrFChn9A3Hq4w>
    <xmx:Lt54ai3gJEkpTaiM2eRI1Z3gQRRn4lyxmzKSh2H1TitFJz3CCPsTfQ>
    <xmx:Lt54atEIhn_YIxikauoe9BFvyUE2ttea4aNU1BH1BYk92RIP-3_xOKpH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:08:12 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 03/11] =?UTF-8?q?doc:=20interpret-trailers:=20use=20?= =?UTF-8?q?=E2=80=9Cmetadata=E2=80=9D=20in=20Name=20as=20well?=
Date: Sun,  9 Aug 2026 22:06:27 +0200
Message-ID: <V5_metadata_Name_section.b29@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We now since the previous commit introduce the format as “trailer
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
    v4:
    • Msg: s/trailers metadata/trailer metadata/ (knock-on effect from
      change in the prevoius commit)
    
    ---
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index c8950d3babc..5e776f0059a 100644
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

