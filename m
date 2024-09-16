Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8F1553BC
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487145; cv=none; b=Ufjmfii0mPpeoWw0P0AuizSWYDHZOSgEPLoQ8VwRLzGdxDuTISjgGa82Jt13UvOOFgtu7uhBWAf0EOnbVbtL2TwmC2PYzWW2aI71wCd8DLu959herVsNJR4IJFBsdfN1oOpOgM5yK4cuNbay4kKrBt94XmYsUVRkUMnikokY4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487145; c=relaxed/simple;
	bh=V3xCsOtXq0apgNpjQhNXAUfeqxLCAdHQmKpJ9fPAOPc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/biAxAthJ6rwSvLohVrhYyggxaUm+O86zX2FyFSxyUJEBggFvIH09/Ivhesj6w/3QHao1g1VGc3H2K8XWCdQfeY6fw9ZBDC/wSMJGBSU5oWP7JJCHTBt7lRjqh+xGE8KEdCmUa5wulp2Lb3eyqP3ROzCnnQ5+FVoZs3cTXsmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ptFjLQGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAnDfRZp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ptFjLQGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAnDfRZp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95A971140125
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 07:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487142; x=1726573542; bh=EhH25wvAll
	yDxFvVFSgHZz9YLNgvS1jrUK44mwAFCks=; b=ptFjLQGlhVQvzbIbBIrwg+/L6w
	CFDil86Kk4Qst6PoHWZ99GpJR70f/sp610iodpfGa7dl5n2Wwswnuxo/m8ULrept
	NzPAl0p3SQEgXjhFWHTf0sCIXbKviomfxpuk9sYfbcl/ldlDUP4DyoIGc3n3IZ8n
	dCasnCu/9sqjQ0lwRNRyLjKQORLt2VuP1fBB4F/wGwFrhslv4UtA811wrzssH6/F
	Qwf8eulEStWQNpYNXVba1F3UeiiYWYZZxtDmEMoCD9o2EAtH2w7Ka4Ij7iu/38RF
	3mtfPd92asYVjwQs91/HbyUb7pSI4jmOEXaX18l8fXD7s3gtpu3cs2DtVSmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487142; x=1726573542; bh=EhH25wvAllyDxFvVFSgHZz9YLNgv
	S1jrUK44mwAFCks=; b=fAnDfRZpcDUp1igpkYTgrrpTF8vh+VPU03v2COZXM9k+
	xijk2jRODSeCjMImkVa5VpRXLxCw9WvulaBTBzTKC2L//DJKqfLAkWFSZ+PEVI2P
	of9ZCHKjvgQ8nSPn1U/gRLwY0nLtURIWWCJfBGo4cz2FNigq49U9k0h7gJM/K12c
	Zj07w2iHh4jpZjd2ezvGNo3nA/p1qDg/jlnfEGdDmXGwxxxJ35rJSYsU/I/wbEUJ
	Pfzv0Z7+oIsmI0xcHIkGN19zc09BwUbsQPXgZVKXWo2oiqHaKUaHh++/IJm8Cuw2
	WTM85x+bTgMbUb5vPEm2wxICacFMKICCRxUR8jvy7A==
X-ME-Sender: <xms:ZhroZtbAbG_lzfZAAJsLnkPMWLjlyITjLZKl18kSTne0tcr6UHNkLg>
    <xme:ZhroZkZ7zMdj51fHF4r6jQYULd_8d8gBWz-SJ7bNUEgcPQpX12d9y2-STeZByXiNC
    Yjcc3-u3qYvsY0-tQ>
X-ME-Received: <xmr:ZhroZv-4uRi7P1z5ZRil0BYGeN4Qaa-cSRRUCEjttc71HhB4lCg4JK2dub4skH9oZOtzyie5BUz9QoXdv0ogK96DBH8T4j_I5PHVUSmrddtzgDxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZhroZrpKQFWPkPsOJAaFPge208eKICHHI_BPSfGsr5n4lCca3iEU8Q>
    <xmx:ZhroZoqxPnu2D0_uMA-6SrDhxhiC0Dmwq-p1rpsJLagmSrhearvbZQ>
    <xmx:ZhroZhQwUqViSSBFGOxL_rzvsgPUJBY_p1q2Of4WzZA9AyuXWgsDfQ>
    <xmx:ZhroZgoCPljVBrR4ScX4UNbx00hB14h5ifjpesVQ1vKFTSx2dgOUbA>
    <xmx:ZhroZlAz7FmQyakCqKoy5L9-dnaSUdrwLQE4kmNW7-wwvfcafGIbuUAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4da6ea18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:24 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/23] builtin/submodule--helper: fix leaking error buffer
Message-ID: <52d12e034b8104a0283958ada013b028322ce421.1726484308.git.ps@pks.im>
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

Fix leaking error buffer when `compute_alternate_path()` fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c    | 2 ++
 t/t7408-submodule-reference.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fd1b6794083..ff1376f69fc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1621,6 +1621,8 @@ static int add_possible_reference_from_superproject(
 				; /* nothing */
 			}
 		}
+
+		strbuf_release(&err);
 		strbuf_release(&sb);
 	}
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index d6040e0a337..7e1afa9ce47 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='test clone --reference'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
-- 
2.46.0.551.gc5ee8f2d1c.dirty

