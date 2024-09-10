Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35217B427
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951442; cv=none; b=uGJ5XQOgY99fxoyrrzFhwzrmrWCeqsxTqssiuGaLp2Ov9SdfRbKF0sfE75fbNJXrDVKRWMeHoE8KjozFS64Q6mvS8AVa/QYAOQY7WUnGRLhx+oMhB4zTPONK6EpGEo49X3bn9uIHznquPE4nb8wRUzqKCebKSsY9S6fSHNeYhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951442; c=relaxed/simple;
	bh=eB/mDpVnZOz0f1vG96el4mvQ1kxX5BuvOnNBbmXiNnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDuby+vxqWyefV0LWmZF2vBHLVX292if5TVFt6RrFPO7D29+EsxPUXWrZO5jPEz2SbZwimQjZmqz6lbdpKz0I7wWPc75eptf08tWlhi5pCyu2FwWUQvOymjCkZ3Bu/lI8DXrPC96KfOK8DPPy2BLH9Vvr1dvWpNprkb5JAGpNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qg+swm8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWiLmtTW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qg+swm8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWiLmtTW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84C3511402B8;
	Tue, 10 Sep 2024 02:57:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 10 Sep 2024 02:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725951439; x=1726037839; bh=6BfAQu3dKI
	ah+5idCk3G6TZeL+avCyO+6AvCcqq7TX0=; b=qg+swm8AUVperTMBlzDnAYfZmn
	ci/W5N+FaHBn3Yus66oxcj9TLm81ZBWXJbDCHrMhDIuEGYA1SEzLEVUXfK4t3eR3
	bdd3OeYOhUnex1V27kVJuPKDIRnfXyDFzxSzRufKn7/cZQqSgla9F9CqI3JeToOv
	hDoatGOKoc+iFTgxDnhO9vEIOxCUMRLcK8W2Hw6PNezP5n9sXX5Lklew6eYxoC+8
	0i7WT3TR1UXcFL5EdvI/ARVB4lXZbvBLWal524zIQYUIBbkYb0upHdHhhfgKIhho
	RJbg8gLBSoy47BU26KDV9M/nLOInlpBUAqxG6bDBR/6qVlMYip/QQFrMMBPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725951439; x=1726037839; bh=6BfAQu3dKIah+5idCk3G6TZeL+av
	CyO+6AvCcqq7TX0=; b=OWiLmtTW3ZztH19lrTfdpHXX5xomOWy7Eq3cXhUCblQi
	qTiWe/aCmgcODp3mLobgyy+nkQiIiX/1MFJN93n4zB3SthKdBaRZI2BNxhWuwlPX
	GNSCnZv6BneAkX3H4P8QZob8OvLCX/klIH0ODKvus4AkqBo9nJ/kpRPwex3vJD3N
	MvVC6rFDq0t4RAxJ+0GnjzgEJGR9rYeHRcn3QRHbDw93BpKHHK1iIpenbQq+9EOT
	IRKeVDumnvnIsLNPcXF+UyhRQG+jsF/HHzZjDaM6bhLcIjk6Vm+xwKWfp8ir1ZAS
	QhEsn8EdoHGmPD//KIX9E6G7NNq5TzCtdUgcbaAprA==
X-ME-Sender: <xms:z-3fZikXwjFY0y7e8HH7Vt7L3XpX1TQxsNrDVTYCJVDGAVp_y4qanQ>
    <xme:z-3fZp3ONMABChu6aoiSZ9_DVUqD9AmyNw79MyWDGmJlT_OEi7i6XcNwDqVM4fIpu
    1nnzPTpPrv0QYcyFw>
X-ME-Received: <xmr:z-3fZgpfOd7mzwackpq0iACgp0URAsKA9-WbRygfJlYRqB5ZdSLyeLtRac96SOQwlvabL8oq8F-N1INbMkwVQxqIXWSGfSfF_RZJ4aWUwEaDI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioh
X-ME-Proxy: <xmx:z-3fZmnf67frAVtsxQUD_0azuOTYe3Pc5dxArI8BVLMhseX3zIoMVQ>
    <xmx:z-3fZg06NnkPz9b0ZoQU3izx6mVzIt8qfmvTTjwsJmJa4q2oW4Fb5Q>
    <xmx:z-3fZtsBIZ_f3_jB2SO6YYGvtmev23tq23n-YlSkYszYFtQfqXahiQ>
    <xmx:z-3fZsUdOnu0yOk4yo0EJ70nR58d02NEZ5LOiebHYqzKZMUh53gWJw>
    <xmx:z-3fZtyntzLAxDWfBLwToDu-dMvCNkG07W7RuAglsVV0pcJUGuTkBtd3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:57:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46964f4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:57:12 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:57:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
Message-ID: <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

When parsing `%(if)` atoms we expect a few other atoms to exist to
complete it, like `%(then)` and `%(end)`. Whether or not we have seen
these other atoms is tracked in an allocated `if_then_else` structure,
which gets free'd by the `if_then_else_handler()` once we have parsed
the complete conditional expression.

This results in a memory leak when the `%(if)` atom is not terminated
correctly and thus incomplete. We never end up executing its handler and
thus don't end up freeing the structure.

Plug this memory leak by introducing a new `at_end_data_free` callback
function. If set, we'll execute it in `pop_stack_element()` and pass it
the `at_end_data` variable with the intent to free its state. Wire it up
for the `%(if)` atom accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c                   | 8 +++++---
 t/t6302-for-each-ref-filter.sh | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ce1bcfad857..b06e18a569a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1001,6 +1001,7 @@ struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
 	void (*at_end)(struct ref_formatting_stack **stack);
+	void (*at_end_data_free)(void *data);
 	void *at_end_data;
 };
 
@@ -1169,6 +1170,8 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	if (prev)
 		strbuf_addbuf(&prev->output, &current->output);
 	strbuf_release(&current->output);
+	if (current->at_end_data_free)
+		current->at_end_data_free(current->at_end_data);
 	free(current);
 	*stack = prev;
 }
@@ -1228,15 +1231,13 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	}
 
 	*stack = cur;
-	free(if_then_else);
 }
 
 static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
 			   struct strbuf *err UNUSED)
 {
 	struct ref_formatting_stack *new_stack;
-	struct if_then_else *if_then_else = xcalloc(1,
-						    sizeof(struct if_then_else));
+	struct if_then_else *if_then_else = xcalloc(1, sizeof(*if_then_else));
 
 	if_then_else->str = atomv->atom->u.if_then_else.str;
 	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
@@ -1245,6 +1246,7 @@ static int if_atom_handler(struct atom_value *atomv, struct ref_formatting_state
 	new_stack = state->stack;
 	new_stack->at_end = if_then_else_handler;
 	new_stack->at_end_data = if_then_else;
+	new_stack->at_end_data_free = free;
 	return 0;
 }
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 163c378cfd1..7f44d3c3f22 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -2,6 +2,7 @@
 
 test_description='test for-each-refs usage of ref-filter APIs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-- 
2.46.0.519.g2e7b89e038.dirty

