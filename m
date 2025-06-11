Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FF246766
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676623; cv=none; b=FUL0DgHAYBbIkiEotJ79TauNyzLT0jqXwd8jqFvVpqoUavvLZ6JMtxg36hJ7lqaPemdZy77EvtYZRqD2B6Loag3pNOeRQ2G0arQrup6spLa5X7hhH0s2fFYGDIv6P5JVxa0dU5JFw09HIgZFefXz5lMfWGWsg5eD581Uaik6ppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676623; c=relaxed/simple;
	bh=yL+vwznT3HcBALQUt7ylcNFlFkN6FPhOy0r6IWSIUuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jdq4JMcwkgCubqPg85KceUC784wSL0Ijf+cAxoQk6yFC4b1XrEamPFkMnEebTTQ03p86zWdRdooRs7vClMwF19xczKLYF9yvDYg4YBemEP0NSWEiZPlv1VyJmIp7SsIDi2Jp6YW1gfRc4D0/h0LVfrS/fKMRYPU27rFcnzfXZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pZiFASex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOohemOC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pZiFASex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOohemOC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E0E2D138036F;
	Wed, 11 Jun 2025 17:16:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Jun 2025 17:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1749676619; x=1749763019; bh=HAOEA73xGlhcDZusAz463VQqK0dqvbTO
	ET5mbFaa9D4=; b=pZiFASexmKshiUaFi2IVxiRmUsPxH7PRetWDFBC8hwz+wOZg
	EcR8W8725RKW1AfggFkH4fxp2a08ZzwBfWTvmxyd6rJSyOvHlld9mfJM/EywzpTY
	nzQaEYw2nlc0rZmadv+zlVP4v4l140fGehkgpR2itT0aJBjaMiz0kIayaevzCxMz
	euYkr0P0aZFiVStuUMQkTfcVfwGokkrrYCrTdpUEPyxtX9oNWOsL/lLGmZptqNKb
	lTH/e6pcxUTjyfyV2kGdul8oX4noeZtDCv5W+JaB27ATHXBCjtJphNr2OVVXqN7Q
	cE44Vo+Ej1YjRzw19pQRI55V1jVOFyy5F8+x5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749676619; x=
	1749763019; bh=HAOEA73xGlhcDZusAz463VQqK0dqvbTOET5mbFaa9D4=; b=K
	OohemOCNRCFiqz/X348Kh/TJv0pRPMy11CQRoAwG0s37MkUDnXrbnrE7nM9C7kYK
	e/hOLiu8ECw6rg6O+AoFK0inkS9x5GuLpigGDdytTg7/0xr3UoLMzXopEGP5bos/
	zl5lhr/WJye8JNtZFriac2beTFOxN8NTllKRxta26m8OcOP+WpgHMAAEaFJCyjvt
	EX5Ch+C6GTrKDzp86NzAhRT7UWEY+VtV+pHRguAK1bxjmuX+3suUBRC6HV2NDuPb
	1CZj89/pPZVPE5xFO6F7jjfdsUkumrf6fXOjHo6i7s91JtsSz14bJJzWKSSb5HA2
	1atoB2nUITA5knpx3rQ+w==
X-ME-Sender: <xms:S_JJaLFDivJUvOczfB3eGKv-Vl_m543e00dVBy_QKfxQGcOCxPxUNQ>
    <xme:S_JJaIX00apcEd48v6DlzOjsToFkD3NwCe78oyHFMMFgwkqLQ76aK6M_szu77es-A
    B6OKkli97lyPXxV8A>
X-ME-Received: <xmr:S_JJaNLyEBWRRIMDbbOetD4sBkItHmtfYYXvnFJo0FM3ABHxqPBchkgg6DIaq8amG8Yp_qly-YMGU8PJAQu0TGlj7UOvhirgEhbV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftd
    eftdekfeeuveelgfelteeiueffffekhffgkeevheekhffgteejhfffgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S_JJaJF722xRZXBgTci1wBLPnKL7-m3zPMCsox8Dj3zrFtXGzKi4mg>
    <xmx:S_JJaBWnZ26fIlYxuKHaCU2ELs_NF9ec_PgtQBFGcQq42fieu_jpJA>
    <xmx:S_JJaEOegeDJ73-emtii38sCscgpVcc1KqOlo2Aq-y1H_OIHqJk6aA>
    <xmx:S_JJaA0mwn3a8tv1QGsW-YbBSaGONVzXgj1tsKunzsae10OLZsjkAw>
    <xmx:S_JJaHEKyOV55yt81m1lJFSQ7nhTF0_ftdsSqHkS2gpbuz4iI7kTUrZh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 17:16:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] CodingGuidelines: let BSS do its job
Date: Wed, 11 Jun 2025 14:16:58 -0700
Message-ID: <xmqqh60mger9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We have mentioned this in various reviews, but I didn't see it
mentioned in the CodingGuildelines document.  Let's add it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a0e7041c54..4d1d52aa37 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -315,6 +315,9 @@ For C programs:
    encouraged to have a blank line between the end of the declarations
    and the first statement in the block.
 
+ - Do not explicitly initialize global variables to 0 or NULL;
+   instead, let BSS take care of the zero initialization.
+
  - NULL pointers shall be written as NULL, not as 0.
 
  - When declaring pointers, the star sides with the variable
-- 
2.50.0-rc2-207-gc448ca4963

