Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC112D047
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487142; cv=none; b=pSTTAQ1K+5PxAR58xQXqw/XmNVpirm8Xu26i/TgcB4w9cHo9TzyLZ/GqvcVwLyKSmgNFM2geUs5RfCdEOzUFX3KoEJZJgf8HYEr3yR52fpZqq773+qSjPSEtUjCTFeZXHuetPoKfcsKU24BzmPwbk+sfL32B2QjM8T51+u5gzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487142; c=relaxed/simple;
	bh=97W48CGMDgv2a9GS5XZ3bLlo9b8bpnNmuIxxtvoGxZU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJPJfVd4bEM2stSoOvVDA2pTMpVF+4zzRa2ov5Akle+kIlx0AQpuBm+NZ478i5/rb5XEccrqseIA+hXHBVjiaoES0fxJ4I2fsc2JGz9xAwto2KCtWwtrVi3heEU/z+2sPiHnWSIfKNg8MMqSqShSBahSQv1rYz6UqdqKR+E8MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CoIQS0en; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a81RIOb6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CoIQS0en";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a81RIOb6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3A9311401BA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 07:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487139; x=1726573539; bh=wCmmLvJQvb
	z2DUfOhHa3djTS8HsjYObJ6IHXjCm8jRI=; b=CoIQS0enV4//9QO+96k1+je79R
	o2m1ftDqPCN9iDHifGpBbZogYNZ3arub8IdBn3FHWZ3fFoXMUsPhIMIKApjW8+pZ
	WvZGjC+/NaNWaq0djT+G0lFLQq3g/HtnTMScGxK0NnKVmVLXBZjkUf44B79e/9rw
	dlwoIiPIk4ubqZgeGPF/8UWNuRRiR46dwksbCf+kJmw3Y4DPwXCkCYafuQ2JctrY
	DwA+R+w30XTc2q/B7KDOvO+9UojnUGVIQY3NSDHxrWREheII2Pflqgpxpoz6+Fkq
	bcw/FCeyiv/S8WLn9dP9m+oAN4koy1NARQr6T/HzlKv0ZdSvmPx7YlDmyl6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487139; x=1726573539; bh=wCmmLvJQvbz2DUfOhHa3djTS8Hsj
	YObJ6IHXjCm8jRI=; b=a81RIOb6BIUO+FHyq6/pVgiOllBHldKQz8+HGKz7MlvK
	7VzoSD9uEmLBxY9iwbyv/gESUomf1JxwUnf11Em/J2JCkwVWDp948yW98zItvq+k
	mYjdfS800u6i2KRphOikalWaVlLQ7o96spMzXdfyduoaB6RLgEX1hVxgqm30mQZg
	cz1OME/O+8kiiUUscdjILM7xWrzIb7JWIacf6v7YuKbvLyF10gxuV0QCD7NN6V4D
	GBJYcDF7q4N3uFJNW/dRCF4UdAtMwKpyuf8bfm+h7n1kT3425qd+VTdFlM/6idoB
	YiZiNayaIYbHuXi00p0YHQJf1WK2PCTiaHLSK/eymQ==
X-ME-Sender: <xms:YxroZrTjWAs7ikzw2AqLkFl5gPjOYzeWVvsb2kDenvNe6SsRnrGH4g>
    <xme:YxroZszHUvtkVv2rB2zyPz6cjjrwOhMtDY1cZyKh3v00DLeqWmQ1mh9fZdu60-Kim
    _rJeN43wMLIV0lJMw>
X-ME-Received: <xmr:YxroZg2yMHEZJHGOTcDHiaUAnk-emYSOgRCKjW5l01_D-K0doTolOFf_1PZxK2_P7bPWy7buXVdxc2qWBBwygUOHqowsKCq3H3oWhrHm0_F5vaS2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YxroZrDpkqDiW-Lkg1vMnasbgRta-x7P5HNp4CsfY87gqfI8FqwExA>
    <xmx:YxroZkhkBadM_R9fYxEkrvB4e2JcBVU5gsG7S6yKPaqoTR0rjbmIMw>
    <xmx:YxroZvr-qlgHLBXNeStUqDs2xcWIFERB-l2yMqjxVCP3UOanAu7fEQ>
    <xmx:YxroZvi9-K6oupusIBz0EON4oewGW2OUoXSnzA3A9f5kzVbEMIqtxQ>
    <xmx:YxroZgZ72yOXPVs3oCInnqzHMfZWgMVK95bgSwj_jJ4VSmyPTWeHq_6P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59a1fab8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:22 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/23] builtin/submodule--helper: clear child process when
 not running it
Message-ID: <0d0964a2bec7c6e6375a65a5ea9dc79a18ad325c.1726484308.git.ps@pks.im>
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

In `runcommand_in_submodule_cb()` we may end up not executing the child
command when `argv` is empty. But we still populate the command with
environment variables and other things, which needs cleanup. This leads
to a memory leak because we do not call `finish_command()`.

Fix this by clearing the child process when we don't execute it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c  | 10 +++++++---
 t/t7407-submodule-foreach.sh |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed05dc51347..fd1b6794083 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -363,9 +363,13 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	if (!info->quiet)
 		printf(_("Entering '%s'\n"), displaypath);
 
-	if (info->argv[0] && run_command(&cp))
-		die(_("run_command returned non-zero status for %s\n."),
-			displaypath);
+	if (info->argv[0]) {
+		if (run_command(&cp))
+			die(_("run_command returned non-zero status for %s\n."),
+			    displaypath);
+	} else {
+		child_process_clear(&cp);
+	}
 
 	if (info->recursive) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 8d7b234beb8..9f688932613 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -12,6 +12,7 @@ that are currently checked out.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty

