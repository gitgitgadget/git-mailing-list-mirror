Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955FD320CA8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055268; cv=none; b=l3ZGgBrIGZf93VlZkGH8foUJ4MBHcnAiSH7HJ2LI7PcayZ2B4+iwKrpmkFdW7lISdinAiKeIoIvfI0qDFBtPJNWNEYzYkPtNHRc6REMOaNmGrClkc62BcxSLJEiacXhF9pHrU1c4f1myKu5gUmhkWJDTM/MoFyeu5rGQviXSW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055268; c=relaxed/simple;
	bh=1vCejFQCVmd1URMdVpkV9AvoBg1hx4BxfoVjVPW54YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spFd5b81kZNowP08M8/LPX9yIJIsNgb3auC/N5cFu7tJg1KPqFyNkt//kVdUeJcwOOAo5Z9o87Pt++4PGjUQLLT1v/JzuVKrv5OmJw2+vgig0u3tUpd6VBsVzsgPHukIHkWvqbfGDeoW9j3Im0Sl5xg0x/bPFoT9/hXOBmCbesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lyzpRe8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDx4eSni; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lyzpRe8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDx4eSni"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A0D801D00091;
	Thu, 18 Dec 2025 05:54:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 18 Dec 2025 05:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766055264;
	 x=1766141664; bh=WXw22bOTMhPoQKiEu+zjEszi8YqF1G2J26p29tiMR4w=; b=
	lyzpRe8x/MQE0M7fFeMvvzs1ruQP0dpaqZo+FVG3h1gx4Sg0qJMA6P3aBvZDoJoW
	8JmxxNl9lR1OxdYa+Vc1q+3NaDSb4WaOemZY03roQPTlkaYJQITg/VNUxoRUXW17
	809FyoY5BGsohpdIWOVLlcPqTc3Q89gwqGn4AQaF592GfuRbhn7jTD+eUzooZUXK
	OWWlpcl6jFXzbN8hsciYFWbHXq3SFKT8IsZodqeKUMu0n1Pt+HRbIIgp2N1SFQFy
	mxWjlzYZT8GBnR1WpaKzbjuWpPuxFUTYWZnVPXmQhWYA/SmHW0btIRk6+n2A8N6L
	rdT80gSrZIVG1cXXcMuQaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766055264; x=
	1766141664; bh=WXw22bOTMhPoQKiEu+zjEszi8YqF1G2J26p29tiMR4w=; b=E
	Dx4eSniSJ2LRjZ8oH+lNrrfj4ZVic2Qce72tItOEtqh+GjdaGi+h+JZkcFbq+LD3
	3m5/y6id7vj4S7qpJx/IseJkth9JStpPm4IMTOAPi/LjBBG2RZvvv6hD6HIlekt+
	HZxnRlBulysg5xCsKo0nbJJugLvbIWuwo1o2S9uvh4eyZkZFSB0wErnOmEvvvghb
	PuN9YnJyvG0im3FMUvf64KwpH3iznuanFljNN4zb88G3kh6VavOXJQWOo+3Uo8vZ
	ZeCHrxa7++dYqMQFxnbjhaD9OFOeHh3Zip7qxwSAfxSGL+cMAbBLJIXSe/Cvl+Xq
	sL3bgeGSL6/5fGMPAl78g==
X-ME-Sender: <xms:YN1DaS_aYRH9Jt-532oLRWEYiUsh2QSE9LJ8S1ixS4GHSMJhBM7MEA>
    <xme:YN1DaaIX1ueemDZCyIJIchI0b9Nz9rRZnwCRPpt_R34Mq0arGhkzbIwcXxA45-BD2
    T5J-pUpskALbEHOPggbmtL4hn66RhSMWC9h0ZCCL8upDVxJC7Ch8Q>
X-ME-Received: <xmr:YN1DaVakOYk9E5PwbDBy0yJWGRPQTSjuJ9QoAyovLrYH_uct69PSWgw57rVuXF7bC3xPo4MFHkfFPBb-Rcy9RLqV9XeT7EUHR5Es71EulA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeghedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgr
    rdgtohhm
X-ME-Proxy: <xmx:YN1DaULAQjPYdxXofnJSrc91mbAZvI2iDeocMo-UahYnkENHT75K1A>
    <xmx:YN1DabCjYK85ZWPiBV687wP3__jSJUIa4whPd2QMPf-eAISAXYOHTg>
    <xmx:YN1DaRpTBxA6wbIt9xbTTFB6iJ4nVUzQl2boYOyU2OaIFPOpTU0S6Q>
    <xmx:YN1DaejHkv2kCkgdXEw9asH3F5M6W8Lpsu-NYrIRuJlGoJqFLBwR6g>
    <xmx:YN1DaXzOkI_NO54DgkRoStF_iPMv7SAJ6dPWK4tUsZz0j6FQ0Qyv1OpI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 05:54:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce1ea6b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 10:54:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 11:54:13 +0100
Subject: [PATCH v2 1/7] object-file: always set OI_LOOSE when reading
 object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v2-1-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

There are some early returns in ``odb_source_loose_read_object_info()`
in cases where we don't have to open the loose object. These return
paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
it becomes impossible for the caller to tell the format of such an
object.

Nobody seems to care about this right now, but it's a bug waiting to
happen. Fix this by always setting `whence` on success.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6280e42f34..d566df427a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -439,12 +439,23 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 */
 	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
-		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(source->loose, oid) ? 0 : -1;
+
+		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
+			status = quick_has_loose(source->loose, oid) ? 0 : -1;
+			if (!status && oi)
+				oi->whence = OI_LOOSE;
+			return status;
+		}
+
 		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
-		if (oi && oi->disk_sizep)
-			*oi->disk_sizep = st.st_size;
+
+		if (oi) {
+			if (oi->disk_sizep)
+				*oi->disk_sizep = st.st_size;
+			oi->whence = OI_LOOSE;
+		}
+
 		return 0;
 	}
 

-- 
2.52.0.351.gbe84eed79e.dirty

