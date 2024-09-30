Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAB175D4F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683697; cv=none; b=J+0De9rlAMIHIOJ0T8HCKckhv+N58NmncJvqoq30nh/zcAPoxnV2jbf84Qkudc8M0wUSBc8WbiS4Tf2F3fA0Ywt0nVaZU8OJzh5rFDzLnb2fzxfzdWqEL0smJPYhNzWMkxkKKNvyelZB2WfllambEYkatscfk6Rc3HCz1CRGGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683697; c=relaxed/simple;
	bh=AiQX07E0onb+qLzuGv9MMQJwWgEBOoebvoNHBQSywFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS+kABPhQssJHfGjL3+vmwfWBALw1VDXURMAlSQmm7Yy1mwAloak4/p7QIqV5ZDj9ow0jJEtsPq/OhMdLh/3ujnQOK+wWHE0KcUhOv4cCw3Z7yOp7jg2sI9TuA52xYYJGnh7Fmdj8L0RgYnlLTTeNPHNkKeTqdQ7jXvzhXrzIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MVdqzwtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AYhjo1Nv; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MVdqzwtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AYhjo1Nv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CFA61380446;
	Mon, 30 Sep 2024 04:08:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Sep 2024 04:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683694; x=1727770094; bh=lkmtDWKB6j
	5uabDeeINEVcz512DtZMwDDeOCH2btGYM=; b=MVdqzwtJZIKlj0K1QogTKMo8j6
	erJWUvX99UZf0S1I5DQNHm9q3U0n0OAp3vkWOFkArS4PwHF7twibaDlN1et96ZcH
	aptsflGcrr1JZPOGc0NlfIOrOEKdCmsyKFS+g72NMrtipU6eFyW6QuHTGXj6WNpq
	csNSOlp+ha6beq/waiCh5IGSX7knwX4NuD+eDuGxWsnkrwUaVL7iSDoFAHxGIIoW
	ulTUBo3wi1Fn4xnfRgRb15NZ0jHiqZPPqOD+SI5n0RKWE+Ze26TCR1vSna2zOMdO
	HDz5G69hIeUXwxMhJN/3lvaK5aWMv6plG2IZpZDCpok3qzbCKH5KqJS4scSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683694; x=1727770094; bh=lkmtDWKB6j5uabDeeINEVcz512Dt
	ZMwDDeOCH2btGYM=; b=AYhjo1Nv5ByLiKUvuFhrhomZVLEhAg3JFuWJN6oLDs1S
	fypOfWZbF1D7a5rp52kOkgpcWVBr1Rukb/FzD8rmRS1zr5o4vRFrZoTulO0J038q
	xxB5B1M6bIlVsUZXPlGrW/JdPKV5pHedqyMeCjEV+rW4Kdf1D4abltwLcZldqCFS
	3C7bw+85mJaLXXm3f3lgHg6mYX+Gv3TaolvIPIqjKRC5R+xdjnmQ7lBeH0MrbbKb
	jvDgYpkSyF8Mdzcmda62PZPlwPv8HWyfF4ymT4KwCSqoU0ysyFmc3+HeB1r8QG2P
	PWOxHM0gRS/ilTBVGw3qk+ZQhIl52+b7KZTbdNAqlw==
X-ME-Sender: <xms:blz6ZvqyWltWC-5WEdjHo58ed8LbxGajLU1lE5c3BNCwruX2jl2DXQ>
    <xme:blz6Zprs2HQWNKGcd1zrWnpwtvjEsOMRHfO3z11mfP1jOeMRJgUmBb2cEt7FDm9td
    U6wjeRiv_InCcgvRg>
X-ME-Received: <xmr:blz6ZsNxR0asTnCSChnqW29EZEaIPAQf3WWHEZQ0eTag-y0dM2RvlH0H4lxthwOfIoyo8XBYSClp4df6cZ1-_zBQYTqbSVg2NlOWermz5GtgJi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:blz6Zi4OSFtwTsonJJWbm9rrM0-o1A8nFitvf9pqVF-4bX4G7cLjvg>
    <xmx:blz6Zu4hF81eoro7sPvIxm3uFuA4_0VN5ePlhOXi0wHbmQUPzkmsig>
    <xmx:blz6Zqjio0drw3XgQkjvy5tYo83BwQs0Ri3hc-cqO_9kC1ko7eSENA>
    <xmx:blz6Zg4D6NMSIPwyKCA6zAV2sOs_zYTqjv-GiCrB4ldlyKFXgvaeBw>
    <xmx:blz6Zp2lxeLQN3ECbk2zwYPv8ZyLI3mh3NYlP8S1jaUQabKdwTYlBIok>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8dd0c37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:28 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 01/22] reftable/error: introduce out-of-memory error code
Message-ID: <8c99ecc3255b1b10cdec047da01804dc23a7d287.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

The reftable library does not use the same memory allocation functions
as the rest of the Git codebase. Instead, as the reftable library is
supposed to be usable as a standalone library without Git, it provides a
set of pluggable memory allocators.

Compared to `xmalloc()` and friends these allocators are _not_ expected
to die when an allocation fails. This design choice is concious, as a
library should leave it to its caller to handle any kind of error. While
it is very likely that the caller cannot really do much in the case of
an out-of-memory situation anyway, we are not the ones to make that
decision.

Curiously though, we never handle allocation errors even though memory
allocation functions are allowed to fail. And as we do not plug in Git's
memory allocator via `reftable_set_alloc()` either the consequence is
that we'd instead segfault as soon as we run out of memory.

While the easy fix would be to wire up `xmalloc()` and friends, it
would only fix the usage of the reftable library in Git itself. Other
users like libgit2, which is about to revive its efforts to land a
backend for reftables, wouldn't be able to benefit from this solution.

Instead, we are about to do it the hard way: adapt all allocation sites
to perform error checking. Introduce a new error code for out-of-memory
errors that we will wire up in subsequent steps.

This commit also serves as the motivator for all the remaining steps in
this series such that we do not have to repeat the same arguments in
every single subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/error.c          | 2 ++
 reftable/reftable-error.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/reftable/error.c b/reftable/error.c
index a25f28a43e..660d029617 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -35,6 +35,8 @@ const char *reftable_error_str(int err)
 		return "entry too large";
 	case REFTABLE_OUTDATED_ERROR:
 		return "data concurrently modified";
+	case REFTABLE_OUT_OF_MEMORY_ERROR:
+		return "out of memory";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 6368cd9ed9..f404826562 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -57,6 +57,9 @@ enum reftable_error {
 
 	/* Trying to write out-of-date data. */
 	REFTABLE_OUTDATED_ERROR = -12,
+
+	/* An allocation has failed due to an out-of-memory situation. */
+	REFTABLE_OUT_OF_MEMORY_ERROR = -13,
 };
 
 /* convert the numeric error code to a string. The string should not be
-- 
2.46.2.852.g229c0bf0e5.dirty

