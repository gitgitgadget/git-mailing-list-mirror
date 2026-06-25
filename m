Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ABD380FC4
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379239; cv=none; b=kGd7z/2liGIXZHZCntxBVV/7zjzvcwioBxFe1VAc2Ze5HxLRTdRVnS/72g/VJMCrKGVmb4qohX7fd4/IAcpOMGb15NM5EODo4Tnswcfo/9SgWZRTqO53UesF6f/o2fgowlOeCSBgiqgSPQXMRNR8v9FVBgFtQ0rmngiKRhfeP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379239; c=relaxed/simple;
	bh=Kr80nzQbcM8c5bi+DAsnrGWgqHTypnuEq2rCI/5E2bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vwi23SH9uB0b67C0u+GC1AdlpKpaZ9PCjnI8G9YnHCJsD1kOOXvxIkT8fZmtecBM9smW+rpZAze8AgmNfy8F0exJrOmzZ5oGFaNizIyAEMcxYlBJIYjpujFKBtEfdnaVxOMGy5jpvghRYu/x0U5WQgFFsfLLaaCr9XjNfxhkXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UECCTNpi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLJDoM36; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UECCTNpi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLJDoM36"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C64B7A0162;
	Thu, 25 Jun 2026 05:20:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 25 Jun 2026 05:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379237;
	 x=1782465637; bh=neR+tVEDYOSdy354voOiPSodt4y98BRYeSvVJ2N9lwQ=; b=
	UECCTNpi30rzbtCeM18PNyZWlvwB46Y8sdffjASDZnJrZ8Fp4f6wdkw5U45UfiZl
	zfq8tGtofJR7F9m3N/90z5kTwYmKCEO4VxyMzdVe2sSPEzWEenqjwPa/RQMRHLYV
	Fo7wPOagmTAmbwcHyukXykK3p8/3cVoW4Gs4MjHvaGNX9D/j8nNXhRLSFJXZPanH
	1Qv2YZyARQIoD3NW4EundDlNIBEJVAclaw5uQd6U9rXuyBaPRNtPd0DkgflJKbgn
	MJVjc49lz43/zR1WG3TTRTVPYahAolgnI6F0gA796Jo5SVCT28tKcTryhYbxe4cq
	J9pyV/NIhrq5iGmHiyJ5MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379237; x=
	1782465637; bh=neR+tVEDYOSdy354voOiPSodt4y98BRYeSvVJ2N9lwQ=; b=b
	LJDoM36+Po0QKx3T5o/y72cNB52y+b1Z+p53I7XwKQfLXs48ywC8XQnruKVVrn2u
	oNuuEe/UompIBHFOyeCJa5ehO6pm4UmlR91YtZIOWmvnOdgbXIdDvERZmE0RwEY9
	Hfj0rGIR/kn7nLYa7qWuRJZj7DlKxdP4whwS02kU3VvUfXq4e7Za8fHGmYKrYswF
	7g6dwxel7FhQMKvX2V+SznglYhiZ6zHmbVeJAwCdhFG8i9LCU1BrHN+2I5FiRAco
	GhqAX7yYaeln+8ItaxaWauDCoU41jBsborYwxJrqs+k57YPQ7lc4cUUDeywMThaw
	UkXQxs5fZcPtWnR5i2+ZQ==
X-ME-Sender: <xms:5fI8amKSHhcAw5ntS_qsjxcMLzpp16epirNEqrZPUEYvUfKrfuhpHA>
    <xme:5fI8alIgD6E4E-ouPGGGzo2kgoZKR0NdqlMkq7csQy_DbqPYhZfRjtirrw_M8YUOX
    AnD3a7kHBFKnbKnCEi1bVM4AnQxLH7WWw6DBzWqcZNQvvxmmaPDcA>
X-ME-Received: <xmr:5fI8art8_H--LJeN0Q9Qk6DB4TTez3CoTStQFh1mcud2QbNuZj8wlvhEVRn9clp_FZzaTHLBiuYCzZAk0zVyiPRi-nMx5wI96Io3dVCiCg>
X-ME-Proxy-Cause: dmFkZTFDkaiEwMNfNKhUFmFqPW6+gIVtJ+TQ0x+eU1LJTAXOIoLsb/XxaWtlQqMIf9H6ak
    vv//LcI64loNAITt4OOQHOFy9WgByvNooIhJ2XlbTwdm6xBD19WPorDKcwOiR9pFZWYeRv
    2607fP2WCMejJ/uDjbOk+fpMEtTUZFFdt3j4ptZxyzkdYRLWbgeFFctod5KWBn8IP9fqHb
    7n5+J4i874CRT6uVOVvLP+BfWY7Uvc/qddGmGd+VQcdNPVInko49U8Hg7Z1CxzNqHtDkwP
    UF2JmCj+2LIZ1DRydCyM1v3SG2n9G+rp5MMnguBrnPoRL80fus1QwEoY52U10taAPz2/Fx
    QJfwOHuZ1fRr+Ck5jWJEWAq3Yb4V58MK0id66En297fTIzKl77S5z55CEtG2WFvpPUum3M
    g13B3DdmN2SHvhERYM6MOQK71Ueb5f16tMfKIwWlSj+trk5OTdxDWqIQVSUNGZum9Vz7G6
    X8iVf1q24USufVza/ztGknhiASSvLLrKIuwGPhy39tBdppTXzEi0aMCLfkX4IUUZyUYGqb
    7GwxwBcRQtcQ//K3XnytsqUwYpJ47WveCwaUJAKdqI+woruMemIvtg29Z43oMytRQGbAgJ
    pzayXdrYpkMaR2Osd4gXxbBkAaO4DjnmIWfxhuEJuR6HrYSWki28aufc1UPQ
X-ME-Proxy: <xmx:5fI8aqQrFVaNP3A7t94FEYFTeifY27JpixOiewPnr03JURALfvfglA>
    <xmx:5fI8apMiqsy738NOHFlnt4EsIPgZNfVjF_OJ763GXY6aG8AbsvMG8A>
    <xmx:5fI8anYYm6cC83ge--GAtkjn942QSgea61DkvIR0AXc_4xISSGkn5w>
    <xmx:5fI8aryBth0aQbuRSiyc8gnCpLe6JM77c-BKQGoGh4D0hdYpoISZ2w>
    <xmx:5fI8ahyLg9uFJgLFa_oZmbBts77hDeaePY8jEWce9HiI-1ePt1PvTDLF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e483a539 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:09 +0200
Subject: [PATCH v6 11/11] refs: protect against chicken-and-egg recursion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-11-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commits we have fixed recursion when creating the
reference backends due to a chicken-and-egg situation with "onbranch"
conditions. Unfortunately, this issue has existed for a while, and we
didn't really have a good mechanism to detect this recursion.

Improve the status quo by detecting the recursion when creating the main
reference store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index 5b773b1c15..1d24637891 100644
--- a/refs.c
+++ b/refs.c
@@ -2359,15 +2359,22 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	static bool initializing;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
+	if (initializing)
+		BUG("initialization of main ref store is recursing");
 
+	initializing = true;
 	r->refs_private = ref_store_init(r, r->ref_storage_format,
 					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	initializing = false;
+
 	return r->refs_private;
 }
 

-- 
2.55.0.rc1.745.g43192e7977.dirty

