Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293401E47C9
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502939; cv=none; b=Zpxf4HUF01rlKAJBWyjPykKdLtZGKUoQUriLXVYzmIdGnLfbcOUTo/PzEhYGjGZCr0AJcYCfNAHE2iJquFbtlygSg1l5V8FusGG0cwhiLNJ9A7C5yERwd5MDpoVYmL7MC++iodJMdoUlR2ACnJcGJh8ksJNXW0AII8v6gfKq4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502939; c=relaxed/simple;
	bh=FkBBlyoH1KNAQSKhqT34mXsi5arMIb7M9Jms4/JedWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeiS+mPSGm5KcNYxvFxE6nSc3HxcDZIvLqIhFsV+5lBpG2ySwDhYJzMLwxZuTIX/Ts8u2nMhAI7IGRFdyiOMP/BtkUbkGmUnL6rlbmGsTV5y9G1t8LsIN4wG+r1kNVFwIRfHzdmA3LyE1BwubqYzT+fGcqK/RuaA9sCU9FdmCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mxwHl8Ls; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aETkfPMf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mxwHl8Ls";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aETkfPMf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4825E114022C;
	Mon, 21 Oct 2024 05:28:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Oct 2024 05:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502937; x=1729589337; bh=LMiyU56njg
	9h8odthdkvYbFy7O3nhHjOiFJzweQgGXk=; b=mxwHl8LsEwQN5L9NXDKJPvdIyG
	qkS8TrENW+WAy0MN0/G339sTBYgJwYxC0cgTQB2pFrOK+fYS0Sk7QT3S1cFLriqr
	edTCEi20DnHOzKvBZGV85GBu7iPNYoONUCJX7HCYEyUe8fJvL8VjqE6jgvXVWqnr
	/zEilEP+RLzQ91Kn8nVpU7WhD8fFmplOfuE6N77jVMmVGw4LFh5bTcCnWM/gD78O
	BmnUppuQVQ+KY6h+lkenotIj4fG41kzHBqKWpE3mT63IV2hzBacZTl/pw240gk9K
	tlJqHs60bDsSi+h3kHGHxjINkb9Y3aPjdpUbdT4xnaRm9pKZZKwxVJJBOYqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502937; x=1729589337; bh=LMiyU56njg9h8odthdkvYbFy7O3n
	hHjOiFJzweQgGXk=; b=aETkfPMfG1MEVU4yiFmzZAtNJnGCgAZRNr8IRfkWgfHv
	At0v5u25kLjmtSDRJNbjopLxl4CLON6wxS7Yu4x1sZAmZEG80hi1n1tIBLgFreWJ
	5EphA9Q9s1B9neeIOsXcoifLK64f5r/rL/2FP4K5QS0RCHFLmFPHRRCLaaF3vrpr
	fud6Cx7ys+SEzBednIbxMQgg5d6MQXTilFSLCIk2YOYo9GTeGMQ6wXOjN3hFu+cH
	pItxTCYDTjr7e2tzPTQlh9id2rl3TDM4nvmvFA2Nkr0iTTNDiT2Q5cXbA10wW8Vv
	/VVVGuPz7H5sWhkJoHoyRKQFaof7CrWq6jalna8NTQ==
X-ME-Sender: <xms:2R4WZ6mtsBAJKP-7Hkr89WpG0LXXTv8MKHrPd4HWJNI9jDMv1RnYRQ>
    <xme:2R4WZx3jAcUDGBeZAUnL-JIcxX_4v6p1o0ezvFXcxAfuOOxXKQkgtEWlDHqugp29p
    Jp83uVYQ-XkH1qb6A>
X-ME-Received: <xmr:2R4WZ4oZ9g_A3jc_oWhpa3-SvgJoPJLhJIz85gIBilJ6VG4XjC3corOSsH2BJCNd1vmR3D4j54s3CbCe-n5z_r2c6HfZIIpt_2Duzis8_PPX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:2R4WZ-lH1mIP5me_Dz6S8bZvaJ6H7rXqVb3bE2mTIl8i8ePwHElBjg>
    <xmx:2R4WZ4245y40YAokANuX6qYnuM3aGEdaCy0xBYjYY6h-0QaU7y0eUA>
    <xmx:2R4WZ1veWhGGd_EMY-_CDOAN2Lktm82-mqoMijA1tgF2q5QpJe1jPg>
    <xmx:2R4WZ0UA-F_GX2UPFqT0iHblVDWfD8OR6X0W2YNBUi3mTJ8w6p4mWw>
    <xmx:2R4WZ1yUoDrkzGrmWoQ0VziqG8jFHWMSjGhVtmBNJ1opPirBug26zA-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa281710 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:28 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 17/22] sparse-index: correctly free EWAH contents
Message-ID: <3aa6bac50793b2453e5933a5125bb8e146e3f569.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

While we free the `fsmonitor_dirty` member of `struct index_state`, we
do not free the contents of that EWAH. Do so by using `ewah_free()`
instead of `FREE_AND_NULL()`.

This leak is exposed by t7519, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sparse-index.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 3d7f2164e25..2107840bfc5 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "environment.h"
+#include "ewah/ewok.h"
 #include "gettext.h"
 #include "name-hash.h"
 #include "read-cache-ll.h"
@@ -242,7 +243,8 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	cache_tree_update(istate, 0);
 
 	istate->fsmonitor_has_run_once = 0;
-	FREE_AND_NULL(istate->fsmonitor_dirty);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	istate->sparse_index = INDEX_COLLAPSED;
@@ -438,7 +440,8 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
 	istate->fsmonitor_has_run_once = 0;
-	FREE_AND_NULL(istate->fsmonitor_dirty);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
-- 
2.47.0.72.gef8ce8f3d4.dirty

