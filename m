Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D22D5946
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996912; cv=none; b=jLpAtOSdMggMzspX6H7dQDnbrv4/qFhk9zznIoZ70TPM9or7V6Ovneketj/L9IUFhGUoprSbtY7S9nOZqYmvlHivsAaeeBK+dF6pADkP38Ydu8LCj4nRMFtkKEol3ICSK/mFZGfyjGQvWdro5QznTUp4nvvvWlZtYop6dO4+/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996912; c=relaxed/simple;
	bh=VD5sXU+vVGEwmaCSp1yuK9UeEyox+ufIBrYyM+J21dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fopjo0kGzjOcbhewRHT4d8mNGKUT6qJc2wEwLVVI4+jPiXhJtzmzM9GArOPWumz7ZwWMeVynUXLyypyRgHYaoMFvNjdEp2PmHPLM0A5ctk6xG8CDpuC6quesRs9oeHGw1pT0XKsLJzbv5Yy9Ug4uzglbAQ2qEgxix5Vh1F+5zbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CAIvtin9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJ5/ZYJp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CAIvtin9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJ5/ZYJp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 164B07A00D2;
	Thu,  9 Oct 2025 04:01:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 04:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996909;
	 x=1760083309; bh=MUPZrMInjOhbsmL9emwFgCv9lbPG2TOSNr9BywTv1ZQ=; b=
	CAIvtin9O5rrMcD8WwIpwUsMPa8xIV2vvC6WrGQFOXp1kO53gZt7kjGCLIkM7BrG
	V/5RM1tffzI2yF0HUv09tzx6UMVo7fi7fELTLsxahKq+/m+FQwXINW2NSdBRT3ag
	bu0n5L6uRxDvXZbX+lEbV6m+odL9WudBpvVPJ6a1+3Mk1XGLbH6tDW26mDaDc0Kk
	NdSjlw2r5oHpLt70uD4EfKvLnKOayH9F3HIfKKz7tb9nF8r1fv3ukpVdqG24YIZn
	CBrL/8RaasmtZbx1XIpROIkUjdH5nvGEWcOJrTW5pCmgV5vr91c/H1AL8hQrfaz+
	KX1BgNQQVX0OCx11DfxOag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996909; x=
	1760083309; bh=MUPZrMInjOhbsmL9emwFgCv9lbPG2TOSNr9BywTv1ZQ=; b=J
	J5/ZYJp7if7PS/1aiM94covt/tpyz8ooN2KoQHkw7Uso6dr0o8zNXdo/mu+UKTbx
	QUufnVcn3p/trpMrqhUCVOHPdgP1ivYeaBmU2lV6Av2kO4rfSt+nQermK0Np5mxm
	+XH6lRt+Ox5ASgyPtvy9abrrDACoehOkycY4s0oBVQ4aRiS0ktAcZa7FG6mMPl7b
	Wvg+gukaN5q0xR7CIOcB0m/AhiZyRRzUDRxJ0WoWqltGyRBcycx5Ai/IFcfdq3yc
	Q022gfWjzKJvKjHWI5Rp4FRF1xTaGS/0fUmNdJB5eel0u5x+32numweVGwvulQdz
	Ssw8QaqlA3je5PEmIRygw==
X-ME-Sender: <xms:7WvnaNrJp2fuiRisRJVMDvLY-irI--dV_FsyE7Jdereafbir7lSoAA>
    <xme:7WvnaFptVttJCwi0tfEYB_ckbFXAUWdEGF54yCpTbw1VB62da20KkOY7qoJTqV0AJ
    oLIQc-2EYZSwzI8otMZ9aLflbgdHtsbblEdq68IkiCWReTYA6ri5QE>
X-ME-Received: <xmr:7WvnaH1hTBlP1iYS73s8ZGz_mfmhioOWckgScx96VI9We0MhtzS0G96vfnRfk9hn4C32qQxFzKbfbmpuhv4H6ZhZc2roMuaL9yIVkeONwWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7WvnaEAZMtI4_BO6dYhqoggjuOEg1Jc0I8DT26kabjHZXTsHDts37A>
    <xmx:7WvnaPe9yjJcEplq7PlS5u_KvXuP14Q4eT80L_uHt8OUgNOaAiMxNQ>
    <xmx:7WvnaJi3Srb1cfzWcKjDK43_aI7rv5maPZSwLjRwOu9pYv5Sj9Ds1g>
    <xmx:7WvnaHpud6oIG-o5uAQsvfkXyN7cr_alY8N-zDITeb5JgrzmD5LHMw>
    <xmx:7WvnaGwBgjoN5UMFkoqkCdIyFPy40wV26mHlFelMY9StZuaZXGjrjCx8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0353f1e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:36 +0200
Subject: [PATCH v2 2/6] builtin/gc: convert to use
 `packfile_store_get_all_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-2-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When running maintenance tasks via git-maintenance(1) we have a couple
of auto-conditions that check whether or not a specific task should be
running. One such check is for incremental repacks, which essentially
use `git multi-pack-index repack` to repack a set of smaller packfiles
into one larger packfile.

The auto-condition for this task checks how many packfiles there are
that aren't indexed by any multi-pack index. If there is a sufficient
number then we execute the above command to combine those into a single
pack and add that pack to the MIDX.

As we don't care about MIDX'd packs we use `packfile_store_get_packs()`,
which knows to not load any packs that are indexed by a MIDX. But as
explained in the preceding commit, we want to get rid of that function.

We already handle packfiles that have a MIDX by the very nature of this
function, as we explicitly count non-MIDX'd packs. As such, we can
trivially switch over to use `packfile_store_get_all_packs()` instead.

Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e19e13d978..ab6d6d3bd1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1425,7 +1425,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
+	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)

-- 
2.51.0.764.g787ff6f08a.dirty

