Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30739331EA0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126609; cv=none; b=EHzaKzCoqZwusDXDNM2+EIRKcpPNodnmHT55eGPs8XKK76Wwww+/fZZExMp13DDSzQOImIFvBegkhG6GDt96Na4tbj22i4JAUgwNKLFGLOnzj4SMr25hf6W03aswru62gaj12oV76TsmTYyV7+HgHo6Pgm+V4P9wZVldf4Y2DOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126609; c=relaxed/simple;
	bh=oveSlfA/2T2laZNYkKzLZKG/hTEt/PpM9mrESGHkjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlA55cifZG8ZbUQt8PBLMaHLMdnN+LMQt4ixbqHhxQeXVSSwFV5E1t1Bpc1lN/6kkxihDNCCP2g8+7FuYvdiXMCm6+LEQm1wS/s6Y6Hbvj6zZmNNnmX2Mk+d2U5npjN7XsLeeoOhDlDMVcxII9QIdxJrXqBawREUlg+j3j8Efqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XZMFgdrO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N94XxGT1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XZMFgdrO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N94XxGT1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 88D4B7A0137;
	Wed, 10 Jun 2026 17:23:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 17:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126607;
	 x=1781213007; bh=S72JFEkRUq5frf4WXSYN20Rv8Lh4GCGrWZFGKzFjf6g=; b=
	XZMFgdrO5ZbHp5gb8LVpMfdGF45q9w0Gk8lsBXNZ2GQxn+jzIw/fStR8Ve1jBLd+
	yDQTL0aAf4Eh+QvOFx5RfPVOXZNAF6PU8aecdK9wL6MKtQV/p/FlALYr9oS8bmoB
	QJWUMGoMNzhf8lMD24KLG7I+lasWVqP1xwtxl6elQVDf0Zm+1nEjDajq3bVUPCJq
	unCarQhAtDA7xm3PRUM7N5blsvkZ3I95LF6lqDDy7MtCEydzMtqdRg3Vo7Oqzjip
	oGRrH7StvWAqpQjDAtZ9BeKQf2wnsBGuiJ+nuAcmJN3uMmVTwGu2m/KYTgBhNsbw
	vbM7YEw52VHVdHw7M3eAIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126607; x=
	1781213007; bh=S72JFEkRUq5frf4WXSYN20Rv8Lh4GCGrWZFGKzFjf6g=; b=N
	94XxGT1Pr/3Oo68fEdhIIV9xObl7tZMsWIGVia2/Skxdrvy0JoUXrEHlA8y6JqAA
	CbyoQNaWBcRrKSirK08a6vYIqwCXOpTFXMK21kiKL6Wy/6/1hnJKz1e2F+4X0Mio
	INoSfFncfx4L8pxdxacWtdspaWfYeAbaIP5EKnLl/P+cPup5OJznEMk5eQEV1Twn
	bfIkiiFGMr+4wgxSS7w6p17Lpl8my4Z9Toz9y0x4kNT9WkSdTE/VIWX6ri9HyzuU
	jhXscXqpQGM6LwIXEPh7TPve3/DiJUPqK4atmlUdanGqHE31/4iGh8wCYO4VpPRP
	YLmTVUDLSv/ZSPSu/v+Tg==
X-ME-Sender: <xms:z9UpaqdLcNPhU0quPBrMUIIIErGR5XTIhfrsXF-Q9H5wvMIiryUB51o>
    <xme:z9Upan6BLXKdW5KZncUVALc6b1KGtt5aJMAdXOg8VGmA6hMMBMqSqAgS1-X-3vys4
    766b5C42P9zoAQNC3ZYHaPCkOa02ub_-oA-cC6v_vRm0emitqAxMQ>
X-ME-Received: <xmr:z9UpalWxomxSD33m3_UuF7a-8lTB1HxcKvrHKzHZOVGCXM_eDDZ077sLRdYY61DBTkutgaNdmFQhJqTIsPkxURwi-lMR3dpfbgEGpS2Q4blxO_7JQTw-funl_g>
X-ME-Proxy-Cause: dmFkZTEgt8YghDK55FIjASenY5Jk1wT2v1OemYqbHW+kBEf1AI/Eec0pNx3+dF8kwt9HAY
    XIG3xI+of9vo33Hr6QH7lhAL5xEdotBeh7dnXG5Gn8aZZvt++9dPohMUq7ErGSYawJmj7H
    MApKtbxmsd9sjKteX/PmyoO6+NDRjz1HgI5fF25lVezjf/64H/8/EyMvax33ui+JO4ctbB
    4v/LFXuUuf9mLNUvMgs4nv67W8KustpmvKiyzifbBWRUDCkkDyVlP6ixOm4wPEssETmUc4
    50BSYiCuhzyTodLiLZzj2Jw4BiwHJwob7Ve3q+uqUVi8DxPxPSJ/FfwXqPcnZDEI6navXs
    uNF38U4DetrR1wSA+0OTVsgUk+Nl7ovGN6EA+FSm+Wti2pNN4A7um3OZ8uAYpFP1n7hXAt
    rKeBsxkx+szcYoVy/7wCEue4zEHnFWMQYroxp004adJ1BSsyKB764kzXoHBFZ6DVac7XO2
    7r0GvkrJBzSZdgan590oGaeIehx+IycKATp3qGIOjVkiPDNGK/jaCYPNqhLAKVMD71knii
    1AW0xd1sSXwB5jWcQGMbWG0NAzIk6d7fLoIqcJ7wpvq4ilk2P2sdWuKv8eNLWaQ6FRLnge
    pwE0+HHgsvisCPdvOWR0uWNL02xvvTiAIcD7zD64yxf/N6z+Vfn/WT+fj6jQ
X-ME-Proxy: <xmx:z9Upau5O4YAjTCHt26Oz3sSU9YlhF69eckmG8qh537o-ZQb0CbvjYw>
    <xmx:z9Upaoo-ttrlOKEbglgcCOmJlsWhfzJdzoh7HDq_VIVsV-RzPpm0QA>
    <xmx:z9Upapm7ML79KUvrnwIQrrflg-9OEr_SOaQ4pcA6NDwFgifq_LVR_g>
    <xmx:z9UpasPMX3DmSiURAqdkTvgw2lpen4chqnzUIN-1uvlHU5qn2ZsBZA>
    <xmx:z9UpanItWuqiXxBke7SH3Oes1o2xDAweXGu5ZVRfv67KIMYOiXlCYNiC>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:23:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 06/11] doc: interpret-trailers: explain key format
Date: Wed, 10 Jun 2026 23:21:24 +0200
Message-ID: <V3_trailer_key_format.8a9@msgid.xyz>
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

A trailer key must consist of ASCII alphanumeric characters and
hyphens *only*. Let’s document it explicitly instead of relying on
readers being conservative and only basing their trailer keys on the
documentation examples.[1]

The previous commit provided us with an appropriate paragraph to
describe the key format.

† 1: Technically they would then miss out on using digits in them since
     all of the example keys just use letters and hyphens

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • PS: Reported in https://lore.kernel.org/git/CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com/
    • Remove the “paint by numbers” reference after review (unclear)
    • Add apropos footnote
    • Tweak the paragraph about how we now have a context to describe
      this format
    v1: [had a note about code spelunking (isalnum(3))]

 Documentation/git-interpret-trailers.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index bcd79b19bd7..c35fa9c688d 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -18,7 +18,8 @@ Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
 
 A _trailer_ in its simplest form is a key-value pair with a colon as a
-separator. A _trailer block_ consists of one or more trailers. The
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
 trailer block needs to be preceded by a blank line, where a _blank line_
 is either an empty or a whitespace-only line. For example, in the
 following commit message
-- 
2.54.0.22.g9e26862b904

