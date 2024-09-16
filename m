Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1015531A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487128; cv=none; b=FeCwQDSYHV5XIBnfMq/kGu4BT4VA3PCUO0r9ppoGvxLqGnlgkSvPTCyUIzexEhmii9XKmoxGiF31cPZmfjlSO6rdEvgWllbjV1gjC5MzAub1mVFCMrj70Ib26cC6m+7d7l6UcpV2cxZeyWzgiHbhwvxML9mzeEAtbfKprhgee90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487128; c=relaxed/simple;
	bh=MhEp8N82CtTYaYucNOduWOUJLLKUOrdkaKiBeogl+7Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pknFmikbL0i5OqASESL6g+4BlKSASe3PAonoCVofgkObJtr2WzrmzVx6PN0zciJ+kerwsbk52gM233fTpbfB7V3p3EQjYWtjBMAKixNIib1D8pRt9eQhdioEAxs02YESd89Ncpz9xQI8qVEJZp1AjbE2YpE9krmJGIjzqfOd5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X+jLHkyH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWTcIaFm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X+jLHkyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWTcIaFm"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B7F81140125
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Sep 2024 07:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487125; x=1726573525; bh=KvAVlW2joO
	Lw1w0vsTKGfRpz9NM0Xadr6jGYuKOhiW0=; b=X+jLHkyHZOZW48MJ3orUi/N72a
	OMRrAz0B3ozcRnlR9fiOBiGCkl8tFa78EhuCAjC5sCJz2Bzd0TW79EI/gdz1tXX7
	ufphgNQbzs6Mk1UWuXsZIODAixIFjtoIAfHeefaS+Yqx6ruG21TfUtQ/TmfGaGGo
	jsaTkMRY3X1uNjEEbjYh/yECj5x59LRyRVIOqaKYGj8gsQ6QlwcCC7JA0hvDaIPR
	Bx6j8H5Zbh7Z0EN1kMlNppIk1E9sDkozVTWucjRStc5kHAsaUluPoNSvsabztx24
	InfdFAFcqbbhv+fHrKyFCnpOIIP52+Nq3dqusSzqWSJ5hDtH4n3m/9Ibhl4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487125; x=1726573525; bh=KvAVlW2joOLw1w0vsTKGfRpz9NM0
	Xadr6jGYuKOhiW0=; b=SWTcIaFmUIjvV1/3wZ+sTUr9qrWDVNZrssRBsyxa7W48
	Dmtx5+xjbpTGGZLAZYI3OmeM7dKVZc91tX61hJYPz6NX3wC/6DlKSbZYk0YhzmLC
	FLo/8QiCs5Jb/4PilYtBRRIoXI0s5uh1aIWkI2xmUbOMxUVfGM0zRkNz4YEZU5RJ
	lOw6pUHPLVV0GBSw6uLMsqq+/L5UeientwkwyS2mY7HEnfDFLXa035bAM9UKYDjU
	gOON+V3mUA8cSMuqd1i3ltoMFfrDu4LFvTik7JT65n1NdiZfvCHmfSqHvOmoYPvA
	0xZHgpxyB+qFKQYvbAWF/dujoPacshqXdw8m3Mi5eQ==
X-ME-Sender: <xms:VRroZixUcf0DPxJriUAYt68MxlLdLV4ScMIUYyC2nqBHf49CxRS3HA>
    <xme:VRroZuR6ZsN1bjIPQJ_U_k5dGS9XaVWVqS_ojTZcEA31NWURIW5P-nMJGdmlMsApM
    G1STo_bsf3hI50hXQ>
X-ME-Received: <xmr:VRroZkWDmz7sQwj11IKF08ao1qKCKMVCl_VlxhWdyaU4g9rWN24O48XoV6gDXNiwjMFab6BHVScFldzCRSWKgyubbPkUyR-wz2ltovUJR5Z1W7Mh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VRroZohOpn73uXgQBBUfXHt8WR138ihujlvf01vm-Zs7gz2LZVJeWQ>
    <xmx:VRroZkBkAeny3qjH-y2hooOK4LhS2KgZWSIQ6O8R4vby7ClNdHMNTw>
    <xmx:VRroZpLLj-HCOTUng7h4eiWWqWOKx0m_s34PgZ5C54OHeGLTIHC2uQ>
    <xmx:VRroZrBqVPSSQ03ziJz8TIioGGVTH4b2pPe9cmMQ8UbSnuSjaffPsQ>
    <xmx:VRroZt6iNYuKOa2Hn7ZcVqH_098Br8_ZXbJRBCoo_towwIipaqq_IOpl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4750f47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:08 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/23] builtin/help: fix dangling reference to `html_path`
Message-ID: <e3bed973afacaec801cff1e77aeea6050cb34f57.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

In `get_html_page_path()` we may end up assigning the return value of
`system_path()` to the global `html_path` variable. But as we also
assign the returned value to `to_free`, we will deallocate its memory
upon returning from the function. Consequently, `html_path` will now
point to deallocated memory.

Fix this issue by instead assigning the value to a separate local
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/help.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b986..282ea5721fa 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -513,23 +513,24 @@ static void show_info_page(const char *page)
 static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
+	const char *path = html_path;
 	char *to_free = NULL;
 
-	if (!html_path)
-		html_path = to_free = system_path(GIT_HTML_PATH);
+	if (!path)
+		path = to_free = system_path(GIT_HTML_PATH);
 
 	/*
 	 * Check that the page we're looking for exists.
 	 */
-	if (!strstr(html_path, "://")) {
-		if (stat(mkpath("%s/%s.html", html_path, page), &st)
+	if (!strstr(path, "://")) {
+		if (stat(mkpath("%s/%s.html", path, page), &st)
 		    || !S_ISREG(st.st_mode))
 			die("'%s/%s.html': documentation file not found.",
-				html_path, page);
+				path, page);
 	}
 
 	strbuf_init(page_path, 0);
-	strbuf_addf(page_path, "%s/%s.html", html_path, page);
+	strbuf_addf(page_path, "%s/%s.html", path, page);
 	free(to_free);
 }
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

