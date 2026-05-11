Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BE31282F
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514407; cv=none; b=QJN3yGU9My7cK9uAF+UR46WFdzgWp283C44Ib0f8V0d41bA4LlABQOzE50efaa3EWAzZkPpzQPf9X9ILCq82VNNKIyqTjuQnDtEb7V4EHmVSBH/fXwybVxSwL0VGRC4ygDL5uJy/LZolMS1vf3c55IIAV0+P6Eg6Fq2jZnRvwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514407; c=relaxed/simple;
	bh=4U6QVcBwMbI2NUKi2kfKTisXqNAXJKOaFyiP+r1H2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chJk+N9q+56bemMIaZVgzO8cIbJmo0miuoyecicy8c1PZ79q/FZNLb78Xv+WcJEPInedUyE2H0z7nnDSK793aE+mB+b7CQ3ucqaPCZ5KdzmN6HfQViXFiOGd4nvti44EsElgIQgrTWh7jWPOAUlfeMk8p17M1n/vpMhGad7LDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oACD+Eyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fm1TuDiW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oACD+Eyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fm1TuDiW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3A9C14000F8;
	Mon, 11 May 2026 11:46:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 11:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778514405;
	 x=1778600805; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=
	oACD+EyzRBKAeQaCfq9PLmyt6xO4V465rB2AX4MOhlCyFOBSYAZXnBpA3xOA0kj+
	z+PG/Ruvz2J4tmBxUihdCRCJi1RZyZfSSTwensNTtOt2nduolErTZ7FVMF4ePEgV
	u1NcCG/gUtFitRhGtylpUETZoLE/KmSmVT+ZYX/RYGv8tantWwxL1SFzFUkDPbdU
	DZ7fpR0NjwHt9aJgLuJPwnXd1yu8BH264CYRRuNvy7JL+eCHotqBWyqNd0wmiRx4
	bCDOt9k0wrvRxUOHILxEIA1bCYHA0xv2eZ+DisFBxUyC46NSJNDoPItBU8JB/kec
	QKc5e0JXdO5/Rdw+tiHqGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778514405; x=
	1778600805; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=F
	m1TuDiW2rnULynPqUp7qWKvxSGc9Wvf18jjaGwg6y4iVV65QZVkKbrTs2s9wX9YR
	SRBuXWHGcBYyK+xgoM1k8SOpNUyi/LCLzFNpC0+LiIFZuxHze4uu1CWkMocGArbZ
	SMQQPz8MNPF/HkNBPUorwgNEgwsDBHmpLq8piOjwpFb28tweN2krQGagi1e4ZIDg
	HAxCx0D0d+MK1CCU7WoxE6Z9V+p0Cd5d7hBPK7pHWIEcK3kYWTz947TJbDRG9QNb
	mT/nYdh8rC+4bKWy8vzWayHX1ZIcBLJw5AOO4wK68gZizeTV+SscqU0lAnizdUFE
	gvxJDyP1WIdtR0CFlEbLw==
X-ME-Sender: <xms:5fkBapwFXBfpZoqq5ewAP4YFpal7xlWDW4NIq7If8OisB7jImmdzL0E>
    <xme:5fkBagoCESEaMIa4dwKCdJ4UpGB-imkxs6mKLe4g4oyT6jPzkGv3sF4XMmlodF6EM
    _rrR65QsNIYv7VIcChNeAYIg5clnTHSL0xmUjn6iDlf-QyVKpzRKg>
X-ME-Received: <xmr:5fkBao7eGOjlaSjy0OsTAKPpAVlkfbeLT96mlG8JZMuSvfDZ3MBEGWH7KjPMe8ZcPZJh8n5w31cDQ0NdQKoukwHy9KBj52j0VaACB5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:5fkBancytmSUAlas9sm5kXWD1LYMW320P4rvGM6sF7OA9sQ1Mpx53w>
    <xmx:5fkBat7UTdljNeZdHct4MGU5Y6bJHfsiftdWSwZKNzZ_5yx2bZsi6w>
    <xmx:5fkBauvqv3u_63Q6jpprrWaOWf5JtdFpa4kcs37AZdiJIuNYz2DUSw>
    <xmx:5fkBatiHt8rRM3TlVSIuV6MNcRSL7WDjrOUmnRbpk8eTZAH2s_RJfw>
    <xmx:5fkBanA5FkhLp2Fm-Z4J5DR8Vk0LlsEY6X6Rze0SU5hsxZ_w9L1JZKWr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:46:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 2/5] name-rev: run clang-format before factoring code
Date: Mon, 11 May 2026 17:45:46 +0200
Message-ID: <V5_name-rev_clang-format.6cb@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V5_CV_format-rev.6c9@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz> <V5_CV_format-rev.6c9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We are about to move code around to prepare for adding a new
command. Let’s deal with clang-format changes first in the affected
areas.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/name-rev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 171e7bd0e98..6357eaa76d0 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -519,22 +519,22 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
-			 !ishex(*(p+1))) {
+			   !ishex(*(p + 1))) {
 			struct object_id oid;
 			const char *name = NULL;
-			char c = *(p+1);
+			char c = *(p + 1);
 			int p_len = p - p_start + 1;
 
 			counter = 0;
 
-			*(p+1) = 0;
+			*(p + 1) = 0;
 			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
 				struct object *o =
 					lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
 			}
-			*(p+1) = c;
+			*(p + 1) = c;
 
 			if (!name)
 				continue;
@@ -571,9 +571,9 @@ int cmd_name_rev(int argc,
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
 		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
-				   N_("only use refs matching <pattern>")),
+				N_("only use refs matching <pattern>")),
 		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
-				   N_("ignore refs matching <pattern>")),
+				N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 #ifndef WITH_BREAKING_CHANGES
@@ -585,10 +585,10 @@ int cmd_name_rev(int argc,
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
-		OPT_BOOL(0, "always",     &always,
-			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "always", &always,
+			 N_("show abbreviated commit object as fallback")),
 		OPT_HIDDEN_BOOL(0, "peel-tag", &peel_tag,
-			   N_("dereference tags in the input (internal use)")),
+				N_("dereference tags in the input (internal use)")),
 		OPT_END(),
 	};
 
-- 
2.54.0.13.g9c7419e39f8

