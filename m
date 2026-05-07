Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C2481647
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182524; cv=none; b=UpuKTOqkhkkb6PvLvWmvScBIBzc6DtAFbsCT6bZo+DXeoyNqhE4lDfT899RrlwD3cQrU+fMI7Yf9Rm0kAkZmy4WTQNYf05H0+j49NlCRRqxLCweIS+lEbY32HCO4eXO1ATaI+WcE1Qmg3HvxlXnlyMYKmjG+av3P5F6zGARrEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182524; c=relaxed/simple;
	bh=4U6QVcBwMbI2NUKi2kfKTisXqNAXJKOaFyiP+r1H2/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATw151pd48yVu0PsyVYOKxj8F3xZA5LaXYuoOaXJGfm0O2nV9Rx3KldTm0ToUDY70lUDyfPUN8YtTv9TORLtkZdGl+SLcoBirruzd16Fev9kQmobOCAUV9Od8qBXPv/pv811FuLXiXdHKMsXKfOyEiMosflpy4HKrNeBA/s78LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qp0r4zwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNIII+Y6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qp0r4zwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNIII+Y6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EAB9EC00DF;
	Thu,  7 May 2026 15:35:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 15:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778182517;
	 x=1778268917; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=
	Qp0r4zwT0PI6xVoMKJ25ZgICb4yU0L1W8Jcg89ouZFdehVKyOYCMHDOxYithuX+/
	HlTSLay+qkx0279z6dzEOa6bwbq79BDss4m1ZYNpuYO9bH0f/rPea6vOsbPKkOzG
	iwvzdTyoJeBKt2nb70RAipEXPngBnjBsl/uEEcOTtZtNcwjpgzuaJoqtrG3svf2p
	s1/28qa8XqYDsjp2wMTKTSDI6dAEpI005wAkQAF/0HlJr1j2r2xE8sn+/xMadMmX
	HfyKYEexAf0h2LM1bcglS5zeV4qPOQKvHTD3augw9SlW5IBZxSM5XLLTjHcgvQbe
	Ztbq8KHlkH9imt+ljEjvfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778182517; x=
	1778268917; bh=oQYDX71i8fAbasWRRrib7kxSNBjTXEYZIddHoa+SKzQ=; b=V
	NIII+Y60n+eybIy3P2aEq9A4bUN2KTMMpfIzwCuw7swlLTQHOY+ihahjK3EfU5DW
	cUBfKNc0nJJvjDF42d1BPHL/KOjhNS6e4KycypRYN8euR1XK+gOi2w9Y5ngMnjHI
	4/VZfcaw6CAK+JmcZM2D4Hz63LCt9Sl3258DXH+AkKTQGfutrtAHbAJm6kyD5z94
	4OBXr3E3TQSQe6MLjJJgZnYa2MMuv1DN6bMmO76TVNfScgrDm9hHO3fvVwnkggX2
	GcnjDfBJmz3rfqQp2nRjUhki9KyCrYTm/gr6VkGI5jktsE1TzHeAh7vpjU1Z7PMz
	jqCWq1kaEuRwEEzlQd60Q==
X-ME-Sender: <xms:den8aW83EGFVfrZX5Ef5iUb5_hyA9GSWM0uw5_IlpcbrGfkb94iKyPQ>
    <xme:den8afqtBUY0z1FWWqTh3RRNxHQ5EL2PdvrwYhcvaXMKuy1RP1euz01NS-PTY-U0W
    rz05HJLohvPzDlXd0eUz73eTyRcdbFnwRE9ZPdmGPzt19dE5Xep7g>
X-ME-Received: <xmr:den8aXn3am-0VQyIof96f0vSRtg811hAzqar3ioe9OHtOLV4wFHWD9_2PHV6Y7KMDcE2v7AIS0HZ5PZFwMj93UlsHf9Ze9HKdeEm7eM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:den8aehV35MukJpH-A48uK62-DrLz8GVwOg7PDQYvhpX7iltVxxU3g>
    <xmx:den8aXde6UdNcK4m2D-U8ZOTYuQwj0yH7_S4B2aMiCyGuKx0W8ejQw>
    <xmx:den8aWiS3XQYRxyLz6g2Kx_ABNiCySFF3UuIlJiZUN65yXw5ENRqdQ>
    <xmx:den8aXyVNmJUflwfiNMnDbwYn6KCn_Dn8zNIvE_bM12DxlG8iNs6oQ>
    <xmx:den8aRfILOfn4VPvx9TLUe43tIN7sCSNqFzIhGpVBnsTe7PcD3cg24-d>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:35:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 2/5] name-rev: run clang-format before factoring code
Date: Thu,  7 May 2026 21:34:21 +0200
Message-ID: <V4_name-rev_clang-format.6ac@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V4_CV_format-rev.6aa@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
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

