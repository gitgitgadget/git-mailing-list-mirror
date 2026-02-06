Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA13451B0
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770364213; cv=none; b=LAF+IAIyzmaxJE9+0s1FDS8Uub8f7BhRUVwGeOpNHudJ4JCMSaDSZ4r1jviD3wnFBTLnQZN9M8ySyp7elc2BwUTIEzQD3izGC4Wa2Dzeqc6O2oKurSH3hbLFMC8ZDYSofxH5Uo/SkIwwk6FzK/u62tXp+z1ZId4NDHdRz20IxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770364213; c=relaxed/simple;
	bh=gcjLNnpegjc2lMQAmCw0jofg++ojxSWwUU+gOemXuc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuYSlWCtLHFNsW4DufZSujkp7JWxz/EiH2rUTAsaIQzkc0S3yKz1rt/pZWxoS/qG22ch2KOHfARt80u66sY4nlEA8s+Z+YpfWKa3Dyv1AIQVWOAG6tJR1vImCu83X474XhOYBVXAe9MdGXh6R85P2E/3U3pNApa4rh+x2KJ1pRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hFdo2UTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Asb2aEa5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hFdo2UTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Asb2aEa5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FC481D0007A;
	Fri,  6 Feb 2026 02:50:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 06 Feb 2026 02:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770364212;
	 x=1770450612; bh=DppaE/W1aBgmhDA4lIbgFUZU+wH2oTin9PpchYSye1U=; b=
	hFdo2UTaoUSaJDW8d9WvU2TehMVVwWlh0tnSodRwhVcGTfTaEzOv+yoVYL7l66S8
	ZFDohdYSpAXDgztY/2kwI32QdvLZUsR1AO1STDu7A5gsBQqkdUrPeEr//CIu7iDs
	x3UgaSHXBRljv3igW//cD3zxEAhfCTUBGghCvGtGDAYdcykMGe1jiyvPTk8Mq1uQ
	1WRpRQwpnkPGCrgQ0HFChoXp+52iFrWos9f9AAcjcxx6gL2JT1QYVJjN6mQPYZwP
	cY0IAg6B+BI5Uw8kYYGJhiaAJsD9zWuiQUE62ZYazJL17/ZAkz4CU5gkBU+vvskP
	c8ovrgDP8hcHHKAs3mjqag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770364212; x=
	1770450612; bh=DppaE/W1aBgmhDA4lIbgFUZU+wH2oTin9PpchYSye1U=; b=A
	sb2aEa5y5T41TObJ+R7KH7YrEuMLLF5j/+quybViPxMoOXWWvbFLR6UJnNzXYcOj
	Mtgei5cyiX+LCIhplzUFjVWYn+jSzg5O1mR53rmEv9Yh/DWrJOq3iQ/0kR8LbMwg
	lFtOV3JB8HPvkLkRYlgAIr0pSn9a5noit3tTI2zZnk6T4ib5kn0uvzs3Zx2xlDFq
	a5MB78sd+XkkeHQvJZCKGI8Muyl6TYR8UeGlZgB/0acgIW6PF9Owo08raDuiYTub
	EM0KZsPQCSgg5PClKKCur0hvhUk8h+qhfTKmueNPyuCMcy2b/KStxAEp7s9HcLCP
	uIW+/aaGlPaFMcuALgV3Q==
X-ME-Sender: <xms:NJ2Fafs2NMtuB8J7mhlUax9SowgiW9u_hBU7SjE7xPSUiL0he1WBrQ>
    <xme:NJ2FaXerMyswZG-TVlTQGPCQ9kUU_sDR5EnlBqtFYa4GMZBD6qMb_fF-XS3Fw6DWU
    wx7ZIlkq2lLtfGWQ1dt4EXCPzGnnU2GlDa2nG3hZBfiFSL_SxmbHA>
X-ME-Received: <xmr:NJ2FaXz5qoKhu742gyfCL5S-G4TiwRBwuSF4Lw5N1p4IVBHTpLJyrT-fBlV6qKkpkHYX-VS8LQi99OG2CYLzHnVzmOvgNBR0at9XuzzLhps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:NJ2FadGvYZ7Ot4VjBzhfzv31OPN7jBvI9JY1vUSit-RSLM6b8LXQqg>
    <xmx:NJ2FabzXejOwPgaIn0I2q-Y5nx0LJAHgt_rZdAeXWbNneMmZwiZ3eA>
    <xmx:NJ2FaesQB4GbxYHkgXrztGI2Kz_WXQ96htjn0R1Zae_1pinpL2Dykw>
    <xmx:NJ2FaY1pxDOYCU-0lmThecxbbGqWolmVaCmmC95Cbz0DtV8pflnE2g>
    <xmx:NJ2FabRSOmSbgqTp1Jkd0iOwTgBwmYn_dYMEFBzKoXB1i8ILg5J4iDey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 02:50:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61cf8626 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 07:50:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Feb 2026 08:49:58 +0100
Subject: [PATCH v3 3/4] bisect: fix misuse of `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-3-1e050c3d6a50@pks.im>
References: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
In-Reply-To: <20260206-b4-pks-fix-for-each-ref-in-misuse-v3-0-1e050c3d6a50@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
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
2.53.0.239.g8d8fc8a987.dirty

