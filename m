Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB591991C1
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530944; cv=none; b=s8Agvf9BegOm8kQc/ID8S5JGoiQKNMgppCXWRv4V9vQ4TwjC2euzYvphlHeCqZ6d9pP+uGZiVCxTwpP90azT1JHWfGHfcUHxDiyVzrLS4RBzcEHmeMzbgJN0SZ04IhQ9mxABovWYtuRLaiwdVeDen1AeYbZPAcvw3D25/A0hnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530944; c=relaxed/simple;
	bh=rdauaC+lZD8YvtFKTmJvi9KJXvoywRbJ0YoFdi7k0Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWe2z0rY44pyzs/DQwmkkhweZbhsHljrPY/EdEBPu9ygswTcLno2e5cRbcUWURR6OfvT6xuXSXE8dbWH4v13yykYDCCtHMsW/fYlpZYbb2RvFilWPimjGxI7huJIli4tiln5T53WoD9DFZ8SsbHP4i8c6+1vkaxBlk3g+K5m6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oe2HM6+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZTwuoTx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oe2HM6+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZTwuoTx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C482B138035E;
	Thu,  5 Sep 2024 06:09:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530941; x=1725617341; bh=5MglUoFwQc
	9g1+mFtCZkCebJLAZvATufZcbGnBTlQGk=; b=oe2HM6+mhAUALXsoqNoJPgU9PY
	4ie20Fds9qWi6S7O+tBilHm/AGQj412LdSz5NS8cgjZzQnNkWDKQCpLN2ALoJOc7
	Vl6sTTMhxo7rskEhGv23aJ1sWTFBc1UwzgAZdMEoM0HUCwLvzHRmC4KDbZ++QJVb
	VEWHMSMqlsPOXxJK8jlqvppjALh5gmEhSL00BUyXA7jyAfoZBby357uivIHMJSOL
	m0BrMkLWckSwqZa8H12f0WjJtJbvySs1z7tzTORjkIbGUz3MMiD3GR5opIYFt/P6
	x2wisy9+nzWIciD1wnbdQIEYr2cas1VOiB+rC21fUEtT2XLGrR6RCKfzTPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530941; x=1725617341; bh=5MglUoFwQc9g1+mFtCZkCebJLAZv
	ATufZcbGnBTlQGk=; b=RZTwuoTxxGOCr3bFtBKFZ4EI8jjMXZjb3Pwf3qr0zvVM
	IATRsWP9yFY7bGo7Y3iuns42GDLLH7fJ2CCnxFFpdXjEyCwSDeSk8gqvCzJnTnqL
	PhqTW0QSCZ9UNPc4xVH0eUy8X8YA7nyToKzUWzBoJzLW3jML6aMlQmv33sE9ccRw
	5gMrmbvlPe2MCPgQAaATk7pgKQuWQ6o/BvvyTa7VRzqGPWeKGefWV5/N3B6k3BLO
	SBSU3GblvrCK95VpLt7gh/T22W5ZzZDM5kPailPwY3b946HeIqQNrBbyNspO0bv8
	jREYKWeR6cIj9AyiRcePUiWSe+QV3yyNMPCpJY6H0g==
X-ME-Sender: <xms:PYPZZqY3zYmSS0qyOnH6fZY62Kb4SqX0Xapnhd8Hotr817-gUafeVQ>
    <xme:PYPZZtbxXZUbiJMAJ9WP1vBdG1dgD3WTcRGOibTHjqSkSoWFtc6jjFHcXB2m9fMq9
    2UzwsqsYXk22YysDw>
X-ME-Received: <xmr:PYPZZk-U7nz37F2deN4WJ1IVDotjktuw3sAXgNREy2C4i2GIfphLac4jWK26NHvoQVf79b5LK-RGxOUUqcg8UzH0Lzf6RkZ0rMjisGhev9sdWVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgv
    rggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PYPZZsqLiwoFjqpec3SSpFDYaBmBN2AMNg31Aflb6WjxW0KxCahnhg>
    <xmx:PYPZZlrFfSO--SFXm_-0x2MxZd4OKZ0Gf-MqkzJaysb1WYnDGPceiA>
    <xmx:PYPZZqR_upfK_JyF4-bpd_hcFzp-zvFoHXGtdnxJeNsTd89c5NocXQ>
    <xmx:PYPZZlpC434i4vgvJwyTYapj95kSLAod_pPhL8F-AI1tYoLQN2x1Ww>
    <xmx:PYPZZmfSL7o7LLlSu-ZQHpGPMk3WoJqH2nk7t0wUD28z36ul62p_scpO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc509d3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:49 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 08/22] remote: fix leaking tracking refs
Message-ID: <90647301de58b519f36fb0d677ed7be99924769b.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

When computing the remote tracking ref we cause two memory leaks:

  - We leak when `remote_tracking()` fails.

  - We leak when the call to `remote_tracking()` succeeds and sets
    `ref->tracking_ref()`.

Fix both of these leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 8f3dee13186..240311619ab 100644
--- a/remote.c
+++ b/remote.c
@@ -1123,6 +1123,7 @@ void free_one_ref(struct ref *ref)
 		return;
 	free_one_ref(ref->peer_ref);
 	free(ref->remote_status);
+	free(ref->tracking_ref);
 	free(ref->symref);
 	free(ref);
 }
@@ -2620,8 +2621,10 @@ static int remote_tracking(struct remote *remote, const char *refname,
 	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid))
+	if (refs_read_ref(get_main_ref_store(the_repository), dst, oid)) {
+		free(dst);
 		return -1; /* we know what the tracking ref is but we cannot read it */
+	}
 
 	*dst_refname = dst;
 	return 0;
-- 
2.46.0.519.g2e7b89e038.dirty

