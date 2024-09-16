Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8E156676
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487178; cv=none; b=qjPBqAPTySJoJOAuzgbBPH5zj+9v7MJakS+IPGnp6ljhMGDm8IHLGAB+XdWrbkC7NQT79cJizNPcOt6Uwo6FVP965y0u8DTOYLA8R/VpYpwoXCKy9tVFMRnmeebHRpMiVTqh6QRHworaSdiOGDqw8KN8TPvEWmUsTmv92W9EcCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487178; c=relaxed/simple;
	bh=hNTk47IQ1+FjjGAkEBcnR96D4OcKRvAZGDxyiMHX/2I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pfmhu4jUe8Zb/oMnV+H+TrLXaFIE5jWDS6JkkO7Je9nCwbUFh4415crEt94il+ILvMrKROpBgkGBM2BA6OnLhw2QHyvvwxFdke85fyo9b7aIHnLaJRcMTMvpAH7NavUmmwkLP9S27/PogoBUCSMZX+GT2yHs68olwE7JnAT0NGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZS8WuYJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1lvOXJD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZS8WuYJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1lvOXJD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 801B21140239
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487176; x=1726573576; bh=x3lcHrh9t6
	AApyJ1NTjddk39qA7Xypg7X5U1oGFqQsA=; b=iZS8WuYJpw7PlrwPdmat+DXOLX
	VvvkS1PIBhcE1TsDOoYJsUDoVPcm6iDXYTqhrmsCjy2TPlDRA0dNX83+4QdJjn/f
	fWIUmaQ+0P5AhX8fEGmwwdr7rg+4ozMhz/Gly5uDYu9SMXlrP8u9YDQuVheYH3yO
	bUmMD+NFGa+K5aOoURQ+v3ub2SsgblDU/AE102lYNlXzUxgji4GvmWz1QRDbVGoR
	UOquLRmFgeC9aYYCKLsyr3yyK65LaDUUM5aJ5Nf4J7j/jWQdhBteisE7/Z/yx6ZP
	KIntMvMzv+wfGNyojt5+vsjAL4kt13K84/F9W5IkTrloeGaIRfzQF6KysWUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487176; x=1726573576; bh=x3lcHrh9t6AApyJ1NTjddk39qA7X
	ypg7X5U1oGFqQsA=; b=R1lvOXJDCp4TDg+Ih2Fi3CdFerRbKZxBSA+UbRRCyxL0
	oKCk5a35ETgNqM3nZipwpzSDa/PqF2kGxh6iFbEYgyGSPSwhaV7YB/Jw14FIGtIk
	/MaC2JtLn+27G2sp3j+TRW4nUDLYPjXMsg7BTrnVAeexJpOjSDs0CAaZL8SwTC5i
	/qEmeorlp1xCZC4aXRgcw4o68cS1jPy+VwW8Cs6tn6r6ttawxrIFBLcUrRb3vflg
	/tR2CGX32lCg0Upelf4QgEebjKy7pyCaUF+PqZ7lHieL2FUjGwvo0CALQCIVX/CR
	Z34tfrU0W9yMagV9kb4Bb9hocoROQkEh2ePErPJiwQ==
X-ME-Sender: <xms:iBroZvLuc3-obT40ltpBjr9tB6I_IPbaZqnMI3wko73QfCKmpuigrA>
    <xme:iBroZjJFGNiMxW8PBVvwrS71r2yofXc9R8uQvJjfqHTcGwy3zTx_PNBhURGIjti6e
    mZ_rHXfSz778TW4eg>
X-ME-Received: <xmr:iBroZnu6-O1mNOMNACz4nwx6Utg95EsjBZUF2W20lkmhNUFCvPgtD_8vYmj23Sza670PQHH1SZIot366p8DSyniV8uuH2ZhaysLBg2zzL-Dspyuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iBroZoZUuaIY0Up-K4VYknzXeBTJmIfoO9zCqC5Asg7YRv6jgiU00Q>
    <xmx:iBroZmYlpSatnyayMSHBK6aWa-f7X3Ns3jBWksXFLQ5mwbkBJDU3tQ>
    <xmx:iBroZsAs2UIDpQWEqpsNu5dYQMhnbVYVUoluFd17k9o5YxfgoIJ3Rg>
    <xmx:iBroZkYfSsivxvo61s19FZWnyFVsYJOh2aY9UBSY3NZpgcos-gUc7w>
    <xmx:iBroZpwqGKJb40RX2VXhFFbR1F5tER3YaGMuNHIm0C76VNpt-ymYYzaI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60e98897 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:59 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/23] submodule: fix leaking submodule ODB paths
Message-ID: <f1cb8122d18746852b31f36d49c6aa760c572545.1726484308.git.ps@pks.im>
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

In `add_submodule_odb_by_path()` we add a path into a global string
list. The list is initialized with `NODUP`, which means that we do not
pass ownership of strings to the list. But we use `xstrdup()` when we
insert a path, with the consequence that the string will never get
free'd.

Plug the leak by marking the list as `DUP`. There is only a single
callsite where we insert paths anyway, and as explained above that
callsite was mishandling the allocation.

This leak is exposed by t7814, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0e67984d770..a07debc227f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -175,11 +175,11 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
-static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
+static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_DUP;
 
 void add_submodule_odb_by_path(const char *path)
 {
-	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
+	string_list_insert(&added_submodule_odb_paths, path);
 }
 
 int register_all_submodule_odb_as_alternates(void)
-- 
2.46.0.551.gc5ee8f2d1c.dirty

