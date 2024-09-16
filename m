Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB8157476
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487171; cv=none; b=Q5LUtD0RJb12/dQf7twRPfpKfImrUwfNBk7E8k6tmL5cYRZ9ndCMnL/UeGHoUxmZ4YOBKhwVuMMEf76oIjxa0K0EKbY58SPVZggX9bZgzjINc2D/5Vr4rhj2XDnvnGMRETOGRgRACZ0nzPaVby/0ri/wv73ALEolCzXfSUMpf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487171; c=relaxed/simple;
	bh=3+yNKQw1w9E9FTISRrFs/Falu4Othrcghak8m/MyEQc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ5VJ+S+ntawDwovRXkunVzlkP5mSJM9gbOF9CjRloZpiFYeE/hN0jP/xS7ADmApXpCRkLW47ettdA2SGIMRD7BGJH0PrULi+xIfBDm5dEy2NT9qD6KnBRgZZX4rpFdeNyvEj6EYzWfG4kUlY/7mySQkHnEjGZVJ/NpyDcwcZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MvYdvTsy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDDfMLlD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MvYdvTsy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDDfMLlD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2E17114007D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 07:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487168; x=1726573568; bh=M5bnu8rJ3B
	wQ05XHmI91cca2PD0JkumNfKQcMxWY1yU=; b=MvYdvTsyew6AJvetvL4zhPlfaF
	YNPaxOlGb8ifaYhBjqHiPr1cHDc3EBanqkpIAK2jHL8VbjvoxPWX+HhQgECAL25D
	MC81ZsfzmWr9Q59clK8pcMD+dbRsTqN47F5F06xKy6IPXB3+uy1GDs+NxLp/1rxM
	pmy8EpVnejeFTlDImm1hiz3bITXxqG8hNR/EaKGf+gptMkb3YhSDyH40Km3DcbM5
	mBZOI2ljYngXaNjzGe0jBR9LOIj/byrRjL6yle6tgI/k8jgudKwJA8dFUzKpz3aJ
	pmw0ycRhkhPXDeS6DX5Fp08T1quRUBSrZ28X+WuRToyq3veLDPPososD0VpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487168; x=1726573568; bh=M5bnu8rJ3BwQ05XHmI91cca2PD0J
	kumNfKQcMxWY1yU=; b=XDDfMLlDWaIpD/7xoalE4FZ009DU1gX1VvExKaIzYZ5o
	5pUXecdgXT+QPZmn0hyBks/yG+SzgR4ajy1GjzhNtK00dIAMpu14vjVTneJPgPt1
	3sSLSfe1UtwqFCDr1FJH2iYw70O3/s/9KdQaYcISjQVuiCcbOso0it3O2XPAhsE8
	Mzg0IhI7TxtaMy4oM1jJQmPkMqKmQ/FA6/GgvF0RQpOVQuIO623mSN4APyC2dQY1
	0694YxdkDnDttP2yoXx76KcmFaTXWY9wvtNEPAOKFFxXtp7Be8dWiS3D3HEAVv9Y
	a95BZQwmGEjH378y2s9CbTbgMb0Nid1NTciiYqkfkQ==
X-ME-Sender: <xms:gBroZu-gjacLbmYMko-lKqVyJELIRFlyr_eXI_J1xU6GXcbb4STCWA>
    <xme:gBroZutbLnyn1HNAdZtcEkfiHur63BCPd9n2ylu_0LScP6bq7xDAOhAHxNuc3NvHU
    tiB1tmYPrbodyXwcA>
X-ME-Received: <xmr:gBroZkCdVgRvdWpNkdMAQBWvwT8yBVIDYAof8u6QeX2bFlJczdFpztOdn7SQdLo_raSZdy-HbVXlJH2_TpJwB-BOQUEDEWrkwIdXpPN-E-c6a8Uh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gBroZmfgC2a2Z6JqqhGnDoXEsZvGeiXwFJJ-KzvyB7uPaoxkuH3pLA>
    <xmx:gBroZjPa4otnRN-rVzUv6Bu6DjVJQtu-OgfNhTuxerL2QyaCdutMZg>
    <xmx:gBroZglWi0E6lkunEQP04sGn116DEjoaDWydM3tqT_nK408EE0lnpQ>
    <xmx:gBroZltJiahLJUazFG405Z7A6DLuPOfZUnUcGRGPxDMdIJKK_3phqA>
    <xmx:gBroZp3xIQvL-gbcgHaeXsTz95wmFh7ijaeH_h509cNrTGLkXqCrz8fD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0db8af92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:51 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/23] builtin/difftool: plug several trivial memory leaks
Message-ID: <c79a5118e42284cd59e1003a2637cd0491cec050.1726484308.git.ps@pks.im>
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

There are several leaking data structures in git-difftool(1). Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/difftool.c  | 6 ++++++
 t/t7800-difftool.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index dcc68e190c2..1a68ab66993 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -660,6 +660,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	if (fp)
 		fclose(fp);
 
+	hashmap_clear_and_free(&working_tree_dups, struct working_tree_entry, entry);
+	hashmap_clear_and_free(&wt_modified, struct path_entry, entry);
+	hashmap_clear_and_free(&tmp_modified, struct path_entry, entry);
+	hashmap_clear_and_free(&submodules, struct pair_entry, entry);
+	hashmap_clear_and_free(&symlinks2, struct pair_entry, entry);
+	release_index(&wtindex);
 	free(lbase_dir);
 	free(rbase_dir);
 	strbuf_release(&info);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index cc917b257e3..f67b9345b8a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -11,6 +11,7 @@ Testing basic diff tool invocation
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 difftool_test_setup ()
-- 
2.46.0.551.gc5ee8f2d1c.dirty

