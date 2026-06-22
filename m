Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29872DCBFA
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118087; cv=none; b=DldDgoIhGI17bU5ndjKDaWaDiCJLFWNVZ2tejHXue/yDnwXLoIFhpHzz+eMg1mlv1ck18GYQYg5znOEDRCgAmAma0KX5sojLkzj8uo0HT5YVUYX8vMT8ZEtSr7MAf0E0JBA7sU713hjUg1dTmkrNjRuzYB5wbnjoBKbqQfYgyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118087; c=relaxed/simple;
	bh=uY3bP63u18Aohg3mAacZOcWjFLBcleaup5xIrAwhBKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sRO+a/9YMzn6wEjrJgqzkcxlvHQa04isUamyVBWtVRBK7Vqw3449t6bEU9Dhw3l2kb1UzaCFvnSjSMVopzWvbyi0+T40vwDD/02I11SUfoFTNF4lPnBKmJ5BUGhiu4ioyix86ahTXrtJWqMFldW/lGDTkNPyzXeInNW9imfvUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yx2RJx1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPhQfyoB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yx2RJx1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPhQfyoB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 291827A0154
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 22 Jun 2026 04:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1782118084; x=1782204484; bh=5PVsv6N9aJ
	A4YSsgcVD96HrrUZIBHhPz8oQMHeoc88E=; b=Yx2RJx1+SpfbC43FsF4vKA0f6e
	2V5eyjXXHWgpfH0w0f2c+yrO4QH470J+sAbHBidDVm7fuE0p4KSzjJMBkK5Ny6FG
	3VlAPVn4KcyXsfb+4hAgZ8nbF6rzAZXgIGGIBP1xgT8hYbj7QNk84LgKCNpKfAO5
	whZAkNHzsXw76KOgcq0Wsi3kB9RBiP/I/cDdOb1HpfzX92ILFYQMCoS5YC0zjFk/
	wfhBTFIiRhBnJ0tfa24biWPQbLelTawuZ9WNjWiBXrMzeH6NNcQWK76nVBhu+v/q
	joOm46QdaU96kTpKxmMl+C+Sb53a9hKIaycaxJz3crTZ818q5s60BjrLSNtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782118084; x=1782204484; bh=5PVsv6N9aJA4YSsgcVD96HrrUZIB
	HhPz8oQMHeoc88E=; b=gPhQfyoBVp4KG4jkwfs4L6m4rPMWsSZEEjFN5IRjho1E
	EnyoLSUeq8yoVL5fQ+cjFcc1utBvCZpkBK1NvxEFfc03XVA6fpT11iYSt2U5kAhf
	VAE3Bhi8VZzaLRbw4JE0LcBkEJxwGH7CMMRzWISA5ohqeCm/jekfAQcP6Yvk1J8g
	f7nznwdS5IaYKjXQianRNazwoQeAT5RBV7/wOJ1a2hQ2h55agaf6X+tidDNEKeME
	eT6ag7YkUNLsc8Oski6/OKKGkNcePXw6bntsAWI9eENTPb/xKGTm9X5mxqtKLkO4
	+u/nmZjZE3INx7Nt/Yx1Q7Ja6YiebtFPkts1r9oZYQ==
X-ME-Sender: <xms:xPY4ajexB1ef7zT69g_AcMlI0KLhabI_SdSxh9FQytXfgK66xb5b5A>
    <xme:xPY4agLz0a5GJ6NARjehq221eVMcZfFGR70B4g5Ysgs64LvEnPRsDNJc-8ssVWNO1
    Em3jrtmv6bRsC_T3DLpeqr3dmyr-Oi475AIyk1xwXr58hPRq1eNjBA>
X-ME-Received: <xmr:xPY4aiKvsk3JsG2H9h6lSpsZDAHf1FuA_aStO0TndjvhkxbwlLuV62PGK7a-Rw-WKq6LgRcOh3ydy6_-Olkznzglnt26PQjK88yybMNr-g>
X-ME-Proxy-Cause: dmFkZTFLZJPbAErvg46BhAXAe9bCVnE/S/D/0ITTIZUuL4nch6h1WXIPFKbUllFYqO6AMK
    jryL8WjhBaM860gCdItH5rOH8GPaRGrVJEmg41ERU7WUM1fyKsIY/1+8j9q4UmOKUe4Eyf
    V17p0omFU/SMeVjbJiOakm8QrVXRxMYTqmVY160pt00oSSX5b4xATCVNtUQxi1Zderxi8g
    /2d6eyl/aWBt8xx5bTEf0Ibv/x8hZUC5gNoO4eqxPSPKte+NbTn/v6+n1UvGa0e2m4rTru
    55jiHPqqKxicJPB/lyre1xItDgZOcig8N95lV/tMzqzBpECurBy1D5a+Z6H2JrT1298QNI
    NmSMhkCbVwzPGH514UB6sv47PrUqI5PZ7qUlKzeUsyQJ79jbYw9D3DVpmrm58Ofo7CT/HL
    coIelcySOQy95pvfdVkKrwokWM7MSi4RdlbZwzX9uVWfFMh3lQkycIRyhRJN6H4TzKa+1B
    hbnrxoULLWAQcwZ1SZTGo/LvVL0um27ZpTY+zdK4JfVJT9YkPX1iCQRcped57sdjfqbnud
    vF+CTNt4U5OyPEaYDLSOFZ0A7hw69Kag0IbeaWqzzrGkBnI9Cz5a+2bpZsnBtOsVZDZCOy
    tWZqBTmlvGSe+CDXa0n3lebqdzBPEikENqRjf4r799XZJJO7QFeDP883Deuw
X-ME-Proxy: <xmx:xPY4aqGeOvYNd15UnEJvb84dcd4NCf9vagUNpjzrWowuiFboIL4Xfg>
    <xmx:xPY4avklC_1XfWPJCg22_HXAVMbKlv2iQ1o_exZZot6y9cE4HTMb2A>
    <xmx:xPY4avLNE3N933K9TzKzAmRJakUhxbndp8UHWqBYJgW0OK7K3EYbvA>
    <xmx:xPY4aoYljZCie03K5LmMTFu3InGJB__gRXrV5jxYSJxuFirwF9_bWw>
    <xmx:xPY4alPYB50OKS88z2nHKZWydFkadR9G5E8JYDsc0_RsT74p2vkn2oAv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:48:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d222ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:48:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] odb: generalize `reprepare()` callback
Date: Mon, 22 Jun 2026 10:47:53 +0200
Message-Id: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALr2OGoC/yXMQQrCMBBG4auUWTuQBFvUq4iLJP1TRyUNGRWx9
 O5GXX5v8RZSVIHSoVuo4ikqc26wm47i2ecJLGMzOeMGM1jHYcvlqjyPgSdkVH+TN7hUFF/Bvdm
 nFO0u9cZRe7Se5PX7H09/6yNcEO/fKa3rBy5XbOWBAAAA
X-Change-ID: 20260612-b4-pks-odb-generalize-prepare-509ffc18f502
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series generalizes the `reprepare()` callback into a
`prepare()` callback that accepts an optional flag to also discard any
caches. This is required so that we can make git-grep(1) become fully
generic.

The series is built on top of 8d96f09e92 (Merge branch
'js/objects-larger-than-4gb-on-windows', 2026-06-19) with
ps/odb-source-packed at 1bba3c035d (odb/source-packed: drop pointer to
"files" parent source, 2026-06-17) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      odb/source: generalize `reprepare()` callback
      odb: introduce `odb_prepare()`

 builtin/grep.c        | 14 +++-----------
 midx.c                |  2 +-
 odb.c                 | 18 ++++++++++++------
 odb.h                 | 16 ++++++++++++++--
 odb/source-files.c    |  9 +++++----
 odb/source-inmemory.c |  5 +++--
 odb/source-loose.c    |  8 +++++---
 odb/source-packed.c   | 34 ++++++++++++++++------------------
 odb/source-packed.h   |  9 ---------
 odb/source.h          | 16 +++++++++-------
 packfile.c            |  2 +-
 11 files changed, 69 insertions(+), 64 deletions(-)


---
base-commit: 4a8e7a446f41435e157131162dfe901eca9250fe
change-id: 20260612-b4-pks-odb-generalize-prepare-509ffc18f502

