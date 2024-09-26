Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8615C133
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351169; cv=none; b=jfZ66HCCLhm6sEF/4sETlfM6aOwFhSoy78X/wF8Nosl+9M2z07oahyLR5ISjR4V2wIeEh3gaLKHu9jeFUqVBEGNppgIg/nUORocKQY3EeNhwW6VSH0YWQccB8oeNyXSr8lRc6/qtp8ejUQfhdxjeVgMS7jPW4OumpEGwX14Uio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351169; c=relaxed/simple;
	bh=lNcvcT0Ptll5cEtKf32WIi4ORKzsbi0qptuFZwI7xak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2ev2lzAfCVkEPaOwuWnBmxKCLt9ykNHvstutyP8CD0ED0d0LpkDM4kuqIVPq1MYI2Q6O1lTm9o/se0ALgvwrnTXVOjdW0QIjIotWGVMnGLJemdSwVWrnHH9dvWKD/Sw3q3ki/XZlq4bzL88ULyohVeMiEYTBzSXDaKedDHf27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBAL8Jdh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkVZ9mAS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBAL8Jdh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkVZ9mAS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BACF138052D;
	Thu, 26 Sep 2024 07:46:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351166; x=1727437566; bh=r78A8I/csO
	Vzz1KLgi/TG0c4X8b0TGyOr7EvOV36vbU=; b=VBAL8Jdhr2TByckFHoO/Tl4gKL
	Aju/f3q9Vjwrd4dwhxThaU0m2+soeTBTgUamV8LDKa4i8+DdXVDYnEUCzYMe/86m
	V0MoOkI+dh9hEq4VrNz28vDYDcmnN054jphS5jZm/7AMqbDFNtFsfuUUCnwzJ4j1
	iiMbsSmnp/fP0rlwL6lDzi3OYvBm+8wh09sdR/6GFWuME9WNDEK6qJGDxce5EDS4
	1Y74zuyYtboj1AwYN4LYDE4GP9kC055uGu4M5wnVttjpXBmZVj3VRD6me245SHQ7
	kExWBf4MM3SIcn3FN4XEXt9qYsfDOKf2VvYFOQIeyVpCpMrgE3L1iZDysj9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351166; x=1727437566; bh=r78A8I/csOVzz1KLgi/TG0c4X8b0
	TGyOr7EvOV36vbU=; b=lkVZ9mASm7vv5bE/FOMytm2HkzseOXAYCXHKopeFZR+M
	Vv/1WQO1xBHZjm+ClJtMUsIQg3SafIl1sJeRYTSj+BpADwNwJjcC36nolaDAODAF
	BP/RjeOmZM7OnaonJEjOvZto4mpEJ0pwhsHlSxfJfWXGPgBTxfA7rotiWmYGY8v6
	gLHqay03zJdz1DRAfiNtoIBFnbXXac0NT1P2uIXoMLF+6YVRRK+Rv574vR5zDeYJ
	EciSIeQGRRI2EyruUPxdnMVB4prON9JF4pefNWKAtoZqqZ/u6fsKk3mIEmlf/def
	n+XDOpMGg9EDa7+6Q5taqoY3Akj62fBlV9YBKBCeDw==
X-ME-Sender: <xms:fkn1Zj4PSHpNT5tzkyJ2BtghBc69eeaMIUGPjfnTIkmcmYNlQikNVA>
    <xme:fkn1Zo5Nfuf1K3-SDvILMGOD4OtCWKELA8H-_q_elX0OwcRaTKAkjiQsXbeRMeUXg
    K1eGWz-se14iwBQ8w>
X-ME-Received: <xmr:fkn1ZqfxvKTHHQPYU3ATUjt3JUFLR9TlPCoBtgLH_cquRddLXtVR-gqLZrLjPHQfXcANshUeFabGJ4PKfeXcCT5lqJhZvfHSERBjb1C-gTIQyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fkn1ZkJaZsLqaz80ebX0edq3aMRCA10uawcWyM2Qw-RpwzqUTtv9eQ>
    <xmx:fkn1ZnJ-x2cxI1W9KFVl5cErwweIJFJFZEJH0hB2FesEa0nEEYTJmw>
    <xmx:fkn1ZtzeiVn9scJD233rnYos5gqogbUYs42lBm-NGpGYx1OUioSQEw>
    <xmx:fkn1ZjIdW6tLnWW5FUUoMOCI1MhlxSFkfElMLe0GECOpIAp7oBpWag>
    <xmx:fkn1Zv3DpOu8GpM3rs2JBwIlqemI7LiNh3TpdDkO6vCVKeyxL9RwBwbk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd644710 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:26 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/23] builtin/help: fix dangling reference to `html_path`
Message-ID: <e3bed973afacaec801cff1e77aeea6050cb34f57.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

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
index dc1fbe2b98..282ea5721f 100644
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
2.46.2.852.g229c0bf0e5.dirty

