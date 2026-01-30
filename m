Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E22C21CC
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779700; cv=none; b=AVI4fPaqnxXS4d3gdFUX+NpHcy60l9+cPD64nJQUhIhulSErmOw3XhMjy62SENZjFfdcyyzfbFe/RFE4RkssHjaJzNSjZNgddBOd+nPHxDi3xAiIKVamrLZb1j5q7NaBvlo7X6/9SqdEeooXPdhCuXY728jctDYQ/0xABJnLzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779700; c=relaxed/simple;
	bh=I8+MyBISlIMgEXWRFKbUIgI7mICut4EUZ/B0/2E4Mus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaqINsaDPbzKmGVLDaBuKQY7tYFPCxNUpjcAUshTtYsih+Bgct/f3QIc36mJZF11RoXD9vlY30g4ZrIkrl3gOm/KMtJsQytpgiJ505183d3N8i+BvyXxcJZPO05UIEAqSK1NJZwDNXSL6mOKP+FcAQ2xe9A+cr4OxVF9weSYIv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KowQT7vk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8uKPDew; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KowQT7vk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8uKPDew"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1AE72140015D;
	Fri, 30 Jan 2026 08:28:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Jan 2026 08:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769779698;
	 x=1769866098; bh=E5Leae8LV3MhWfuCgKTWyz+f6BY3ELiIiRzIiI44S0I=; b=
	KowQT7vkhDvQlo+SsK7NTiIC3/uMOCA86Ja7HkNOdgvuMSGmVU1KUYSmDKcTRWop
	BbulsejQdYpz5z0sEvdB6w260XXl/wYprT0S1kjkVs3HZDYJ1Mjx8e751otEPzsY
	qk45Y5fzUT11eXNQahmXxS7z+/yt3b05D6j3wPZaUati/0pS9fZCTeO2oMyc4dh/
	IquBrgxVZZjlEfCtw6QnKGy9nYWAqMAXrxyRXSdhlwajJzkOViNQt90IeG+dvKxm
	y1QFZnJik+plppJqMw3HSKCB7Di/iyuqRpowTLPY3PFb9f49CVxMjeNbqBb0EIUn
	NOIG5rO4GUVczFWFzFDumw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769779698; x=
	1769866098; bh=E5Leae8LV3MhWfuCgKTWyz+f6BY3ELiIiRzIiI44S0I=; b=M
	8uKPDewe8AaJjBY+hgD8NXnJ54BVJvazzs7wwujRHHM/4UR88int4R9jIvmzVzhI
	4ZRk5fiQoFt7oH6kKqB4ZT1eYIiy7y0T00PDyOKTgalXPVPIVQW/ATPCTgPDmEpJ
	IO49ScSkmkMCk8prF0HMrJCrxVoR+3KR+E45gZZtWt/Ls0RPeoMEqOrQ/8/5TmpF
	CzWsGYQ+rXvJr+yz8whc5WNu3u0eCOZrBDNFW9yvOBxybSxkjZLlZDGVXJ3ef4nS
	+yLLyII+uucxPRr4l1YZjrp8RskeBG89d6jG/h/l0MLh1aVMg+HuHdVSv3LwMRE4
	DP3rlB0XJWmQ1WrujBlXg==
X-ME-Sender: <xms:8bF8aRBE-skjrGQ6AMf_NO9KTXGGlRfXgk_J35BcwlVp7ysf54u7jA>
    <xme:8bF8aVj6CFAw-1lKY2jmNeqw6XPFDhFZUpgdc2BjZmDJc7HLjDqDDflYIdRyJwf4_
    bpILZ00JekowXhKfKVf4VHp3zK5y2ITNVUN1ABwaveOFJ3eDD476vY>
X-ME-Received: <xmr:8bF8aaOdJnKer92_Gg4RLqpnDK8JmmWjHtpWKJLFI4PNFf_G7Ugc9PlvcS2sy_cxLfvyDLfWdmY4UPoZUsGl5MkSpWVnXhmjmD527o1aqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:8bF8aW7ZLyDZRbFZipKv1OQejPQA86eq1MhPm5q1lTMRId1v63hqIw>
    <xmx:8rF8aY3l5nCc4Tw_xnftw-j7yJj8cOL8BAhEvCI-lRHua9vxCYd-Jw>
    <xmx:8rF8aXZWIAbBjPFy666TiDHWa3KIxaoBE4JceMiAoWjOrU6vJh6XaQ>
    <xmx:8rF8aQCHz42pwghdSCGTw1KfT0GBelGDVHk3JxWMX_Y0FcWr5WGhDg>
    <xmx:8rF8aUKqTkGt4TPnAfa8CLLE1JrIJbC2sRY7CSVnkg-l080LE_ReY97g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:28:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa80e66f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:28:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Jan 2026 14:27:44 +0100
Subject: [PATCH v2 3/4] bisect: fix misuse of `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-3-0449b198a681@pks.im>
References: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
In-Reply-To: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

All callers of `refs_for_each_ref_in()` pass in a string that is
terminated with a trailing slash to indicate that they only want to see
refs in that specific ref hierarchy. This is in fact a requirement if
one wants to use this function, as the function trims the prefix from
each yielded ref. So if there was a reference that was called
"refs/bisect" as in our example, the result after trimming would be the
empty string, and that's something we disallow.

Fix this by adding the trailing slash.

Furthermore, taking a closer look, we strip the prefix only to re-add it
in `mark_for_removal()`. This is somewhat roundabout, as we can instead
call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
to simplify the code a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 326b59c0dc..4f0d1a1853 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,7 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrfmt("refs/bisect%s", ref->name);
+	char *bisect_ref = xstrdup(ref->name);
 	string_list_append(refs, bisect_ref);
 	return 0;
 }
@@ -1191,9 +1191,9 @@ int bisect_clean_state(void)
 
 	/* There may be some refs packed during bisection */
 	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
-	refs_for_each_ref_in(get_main_ref_store(the_repository),
-			     "refs/bisect", mark_for_removal,
-			     (void *) &refs_for_removal);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository),
+				 "refs/bisect/", NULL, mark_for_removal,
+				 &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
 	result = refs_delete_refs(get_main_ref_store(the_repository),

-- 
2.53.0.rc2.206.g60c1bca835.dirty

