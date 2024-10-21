Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD01E377A
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502936; cv=none; b=Gwmxqd15B2JjK81OMaoHuo7CPX1q2es3qpRCXr7NifD4Ck/H1hK3HPME/KcMDLWXpsBwx65yhCYSUZm7IcF1381x+evoCgMr7/H2DNw2doJkAFrnyvV0QfSVYkHWVgXaQRV74NsFxhP+B1ogp7sZhddFi6853t8gcho/EZ8FnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502936; c=relaxed/simple;
	bh=vfqGwKwztC+oC2i0bag8M0NN+s7plvEbGMS9vS8sOEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4Afy1faGDfYLkxr1qKHiMO3xsS2mBcZEYNYwbYQkG6dxo/wp7oJgu0Lpe4QgTCESJDtI5lKKS5O4vpCyp/D6mCdmzY4O1DW5zLLNYYlD5Lv8bcGpzYmCFJpEdn/rHoXWEAILPydvsMzUbkBSF4OS7HuqJuFsr94Iqdnsrp6IDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gfG/xM7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUL+bPoa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gfG/xM7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUL+bPoa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13D0E1140227;
	Mon, 21 Oct 2024 05:28:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 21 Oct 2024 05:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502934; x=1729589334; bh=D6Vl8Vmttv
	EPW9DxYiUmlnoumtru2EsrmjeH+O72V50=; b=gfG/xM7+JiZgm0UW0C/F49c5yG
	GrOfJxGJ9QrTqdCcdLv8aCjzcm5saOPg5U04lOZdEgFi3A4oj3MkhBlPTnPUWoHq
	XZEQFA/es1kFtBtcsbP2NTiRuhUn0LaGbXD1toiN7PDjkj7FbQ13rKt7e5NjHE87
	y9pWk0yTyxkuOVbaBcOiazkKm2/noRufMNSbMyoV0xRrfXTbms33et0NI3B2bPb+
	HiIxG1n/YsJHeuCUij9aNt3MDkWXiw8ix8pVRPIMso/1q0xOgOSzMMBWzLRwY72P
	pH1oquv9w+x4E6kXntYg920WaZvOE9mdp0Wxn7Uj+XuxhrVn0xp7sYgCa1NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502934; x=1729589334; bh=D6Vl8VmttvEPW9DxYiUmlnoumtru
	2EsrmjeH+O72V50=; b=bUL+bPoailseElZmMoXXbUWPUyvgm+TzD8GaBLrSn5jf
	X0eh4MZZ6xXTj1eFZFPq5eELyn2NAHJiMbraFgzO3C6Z/w7cWPFnHvOr4Kj8FVZK
	ISFJg5guJGLfEZogzeKRXkkFcNLv1VN+AsTvLHd9YOlSeWnhGiSuUYuW1u7J/aGS
	0W7R+c2Ql19LvWS4e7e+kbtsxcjiMn44JNXhlr/VUU3XxAjfF579b7EbR+GidzBf
	SaLSKTvQ7K4YElLt8WTRfeJ83eQXjtJ+yeFG5S8z3gAeJr1nAX4M+fWy5wi4O+QQ
	F9PjRLd/6vZjF8n4B2+sdL4F0xKgc7Vy2OIzTiDFDQ==
X-ME-Sender: <xms:1R4WZ0jTdavvpVL3UwIJVQHfyGOnk_N22H9Lb_N-su05G0DD0TAQDg>
    <xme:1R4WZ9DBU1u2DJRYKsfvBkRyG7n1JF6GTa86nb5BmtpOlxH3CWWkccWq1Ft7nSXwy
    VGNNqgqArc06cO2Kg>
X-ME-Received: <xmr:1R4WZ8G96iVtN-P4iPkPE95g3rER5oXmpfVO0tZTvm8P2uK1pydNF7PB2W860TtiHAikzQFP_B6glgmsgZRSeRkrxQDwwVxOkJzQeJL0ZwRf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1R4WZ1SdPZwPsf7fkvk5e7LT1bOQtjGJBwvb_Bne7jPT6BqiGlQBAg>
    <xmx:1R4WZxw5Sf9JHsOUEiD4KuBGKqCUZ2ywY_PgqVjk6WtlHreLWjy7mQ>
    <xmx:1R4WZz4VM-oc3yGARkhz7ZhW5uZly9N-TAsP-gquc5jScblpf3A70w>
    <xmx:1R4WZ-xQm2h3xP0lHQTDXPoSZX5WqR8L263h2gVYVXLmGO1pqqSE3Q>
    <xmx:1h4WZ5-kZWQ5eWB1HXbn52otCuvN2ITo5JetS1BBsgqM5_q6zv5b1Cr8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17cdb6c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:26 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 16/22] dir: release untracked cache data
Message-ID: <d6b96a4012dca23cae73ce680759783cc49868b3.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

