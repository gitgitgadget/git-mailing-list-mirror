Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA7207A03
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624778; cv=none; b=ck3LsdXhUdQLBOQ1WXNQ/AViiqZY07Bk0QAClBEZFGV28PpeRhpqKKAPahrcXFh3tLC8wSy6NKPQoCt6Mvd/8jV1YR8BKsAiE9f5S/DVtyRZpuqlBQHrhs55G/0wSAls4QPrz1g6AjSgU08YekWrLT7vvQnr0bYK1zWWSNFDdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624778; c=relaxed/simple;
	bh=yaTz0OuvfIZSewtasO5Y0812oJPDC04C0/PZEkT5I5g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYC+qN6kW0TEtmDCEhugPtWiQzVkWETqRGFzxeb/FHHR4hoXcMxKpe9OxjtSDV+aZxPssRkNxTrSOG5+ygGPuAGayT/EJE6UwyX13y5ZZz8FUA5iUYx2NAyfscM2e/dQDgH7i6365Ud3EhdrmeVY2g+P/HNYpnTlOx4QYJjnPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+csHf8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qKcYPwl4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+csHf8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qKcYPwl4"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 407E011400C4
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 11 Oct 2024 01:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624776; x=1728711176; bh=MWc6OZvi6N
	j80bKJ4FI+H/LCdF+lXw3y0fGje5nkQjY=; b=J+csHf8hTHisf0EBWwD7amhFMl
	75Vfhlmo6A2oNhRv7eX3g5x/EsSMK2iaWLxZwp5aybLrJHcCQNk34wT50+k41EAQ
	4tTmCd7+JP4f2+TWHBkwXcc9SMLtAR7JHlGdBBEW1g7bNjVDpU4AmicMMZ5ONOvn
	et8ANetjVnzfBseHsYjjpJ+wA3Kj0oXpOjvaJnxI7tPNoZ/gYN6n407U1cU63voP
	nzeq04lVj022LQbZ2dyjyade/Geffqx/AC7kucyBzD/H/MY3aNmJb8EgFxZfByE8
	lQgIaO2jd+tjUfew3NCdqTfuGH9zYsR68F81CnwXIMPGk9dm33wglQrS3lRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624776; x=1728711176; bh=MWc6OZvi6Nj80bKJ4FI+H/LCdF+l
	Xw3y0fGje5nkQjY=; b=qKcYPwl4NBYCt8v72zyBnvK8TMsOQfpKJoO7Ft1ID2Ch
	mugDWMlQjav5qT0fyxMJwNQxTkEsYpfaWtcvFWV3hZr4N3uWLFGMMIIq0sO7sFPZ
	7pOcrhCtgYMZeaRYOJsVuJKhulrrbyA53cGO3Ltug8MmRxySruxWq0Ki9nQ5I5Va
	zbXGZUKjEl0hCHWNrh3N7qDMGGF7R6qL6mr5glqyiSIViT8EMCgtjcf75Vsf7zRr
	2AIcQVWfHPZxztKNc0gDT0whwDvFisWI4MoIYBx2AeY0qnpQ+S3IiYV1H6BXliXl
	XHFnuSvC8lVueEu43qMYHIKEQ8YFfnqOCAGVxhWYMQ==
X-ME-Sender: <xms:iLgIZ62fD4A3Tehyp9ceAchtbZ75Xy54oFD8UZGy637qIu6vxYf7zg>
    <xme:iLgIZ9GGjhGxCKxZMQMH9-EK6YdxNfB7aNhqA7Yglb7r9QEZAvg2U9QwAfEKjsHqh
    TU3S7I1ofyU-J1UTw>
X-ME-Received: <xmr:iLgIZy6F2wTcNV4FTyq849GNVnrM-JWES7BdPRzn7e5ANnI9tVfw899-_ZBUoz2Gx0w37ieedcm3zUqfWbDpZp5FLgNZmHTR5zMz8mY0omdbPiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iLgIZ710ajqLbVRVTmpw3STzcXFRJRsZ5Ns35kvJS9Rau6vByoCwsw>
    <xmx:iLgIZ9FGtURI9gSgjdPRF5cHfj6k2uwL0zlp9lGgWKeXoi9Nnf2J8w>
    <xmx:iLgIZ0-JYSbl1qY0aD419u-VxnzujjF6QaAZrcg3lVyz0KfA2jbgoA>
    <xmx:iLgIZykCVoInomAMwtw3EXEXEf81ztzsm1kcHLR7WiLOtbJuogfvCQ>
    <xmx:iLgIZ7N64gM_TK6uUX9blziupngfh5cSmEMMqPDn8b414pNkg-jB8cF_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb6ad03c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:49 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/21] dir: release untracked cache data
Message-ID: <f977a033cf4b9d09ec32cac841038d1f5ea98374.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

There are several cases where we invalidate untracked cache directory
entries where we do not free the underlying data, but reset the number
of entries. This causes us to leak memory because `free_untracked()`
will not iterate over any potential entries which we still had in the
array.

Fix this issue by freeing old entries. The leak is exposed by t7519, but
plugging it alone does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dir.c b/dir.c
index e3ddd5b5296..cb9782fa11f 100644
--- a/dir.c
+++ b/dir.c
@@ -1056,6 +1056,8 @@ static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
 {
 	int i;
 	dir->valid = 0;
+	for (size_t i = 0; i < dir->untracked_nr; i++)
+		free(dir->untracked[i]);
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
 		do_invalidate_gitignore(dir->dirs[i]);
@@ -1083,6 +1085,8 @@ static void invalidate_directory(struct untracked_cache *uc,
 		uc->dir_invalidated++;
 
 	dir->valid = 0;
+	for (size_t i = 0; i < dir->untracked_nr; i++)
+		free(dir->untracked[i]);
 	dir->untracked_nr = 0;
 	for (i = 0; i < dir->dirs_nr; i++)
 		dir->dirs[i]->recurse = 0;
@@ -3573,6 +3577,8 @@ static void write_one_dir(struct untracked_cache_dir *untracked,
 	 * for safety..
 	 */
 	if (!untracked->valid) {
+		for (size_t i = 0; i < untracked->untracked_nr; i++)
+			free(untracked->untracked[i]);
 		untracked->untracked_nr = 0;
 		untracked->check_only = 0;
 	}
@@ -3905,6 +3911,8 @@ static void invalidate_one_directory(struct untracked_cache *uc,
 {
 	uc->dir_invalidated++;
 	ucd->valid = 0;
+	for (size_t i = 0; i < ucd->untracked_nr; i++)
+		free(ucd->untracked[i]);
 	ucd->untracked_nr = 0;
 }
 
-- 
2.47.0.dirty

