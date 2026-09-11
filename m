Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042C49E14F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105942; cv=none; b=mvgC9C3Ud6TjHHO0gsaghYXx8zt/X7Goxfh9MsUt1k15WvbwIBC/GTALGo+RTNFkgys4buu5WrM4JGZaiN9zOBr4zBxoDbA1S6nlNzX6wwVofplOckkiF+D3bYcf7hAMeFbOxgW1Cnxtrk1AGNuOaWXDedx8Jeh+l9RhWZAZ/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105942; c=relaxed/simple;
	bh=BdMXbkO7H4HwNns9i3eZqJURxHGC5xnsjmfX5JGnb2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvSoUTyPkvGOTosgxtBSQ9g5rJN6NiVhDiY5sPoe4nxT+fcPJRMgTco0SW3YIH3WUmhfnwA0EginWRitJg3VnM94SK0Wbl4VKneWnYgCGmh0w4iN3tzm/RIW8DF3HhcO2kaeD5oYHJmkRbunAxHsG817M5vtIyBz0Oo0idWUr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TPIIPGsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9x96aKe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TPIIPGsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9x96aKe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0164FEC06F3;
	Fri, 11 Sep 2026 01:52:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 01:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105939;
	 x=1789192339; bh=VLA5O4YQRDcjx4EHDlP9FA9mqfBNH0RGdJIOM1NZc6s=; b=
	TPIIPGszhdQiy1vQ9rIKkFBXS+aeC1jFh13eNX7kPyMBlELdoclpJeuYWmkUoH0t
	2d0iUX8Urf+r9E5fWI61lg0lAoY/Wx1rvhIH1vD/GJ52550XWsD6KMsiSoXuDcJ4
	sRdXef4UI8GtrdpBjGvjFGqLMAFxdC/VdlSexoz58PsghEXjJPEUNjNja8D2c/4Y
	ZWxAZzcnoHbORBLN5hisZXFrEr5CICE+n1zpCIIvCSBM2eq9jiMo9EN+G/qUyQjp
	mRmZHkZqkSife3RvhWjI/ANdKOWhAZLmsW1zzBeHM8sQU/fi67c3+WQUET2Fa/Sy
	SCenG+RiudO0xFFJDeDPLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105939; x=
	1789192339; bh=VLA5O4YQRDcjx4EHDlP9FA9mqfBNH0RGdJIOM1NZc6s=; b=B
	9x96aKekp2ciT5GmNDmkykx9OW+JLgeC3lIUxtgo7G2DG/3NgQAtny5FNmshqK20
	N5r/6woFuKX6NzQLZcEsP7TE3HSbqjQMR2pWOzGmZXSZBoFKZVPiSFSfcgeZWuHR
	zl7Ok1ntzOWsFHbn780xZaGx/u8UGK8ly3zxG6/zSycBOit86l0N4dEevO+CiBBN
	89b3GEGbPMnxhR9vIxojeGnYuHCPqjU+68KA4J1JKQNpAMzpYpJmC594NMlm/W4m
	4y51/ytQm+9UTv4sw2tyDijdB7cMw2CflkTuXfyvWFuMpvbSyRoe5GW4BWXAPAHX
	pXUi3GLeh1/+OfL/5/WIQ==
X-ME-Sender: <xms:E5ejanMQi82gr3lYRRj9hOpcjR5jlfoKluFdJ7rXUoD2qLYT__cwQg>
    <xme:E5ejapZK0wroKYKO_7tye7RBh_hQ-jV2ZV_hebT5PAys99ez_ZrXbh917y7EkiCr6
    9V5S1luUOhwv24dRqx61dFjWtA6kv0nb6rDTVDdJv2u2HdjRpNivA>
X-ME-Received: <xmr:E5ejajqOv3ufg8gsxqlGJ3E7qe4U_yvEP8T96YeuFOdXuyvXgAabONw4mPTCQRiiURRrNQ>
X-ME-Proxy-Cause: dmFkZTFGFEz1AV46mB0H5IUnOtgcTKabM/fOWdn1U32UtnAQCX7C9Kwl1UF/lK3aecPx95
    pwrzbSMo0jFTe4y6M9wP3j4PvyZ/ZbEnXlwcVhCIODBJ2zHPDEgNd6iVKvcXKLFsvGHjJY
    vWs+JOO1zUtcRsF/A4WjHSwr6DdB/6IXCdE8e3Jyy4OKiwY0OVWLq9Z8TBsacm3WsPCloK
    ydyMq7csyq3iJZTpyMsmr5YvZ/wQUfMMCCzLj3JXj48UbmBWjnybLxvLJ7a8U/gD4J8oSE
    nUcFm76zJB8wqT3mqBkmo3OeFknnRDh7XPU0VX9uvjH+wWvsGiO52yVJkRj13Bl6YbnHcr
    FM89IzHILA6HaOO/wlTTT2yEYXZJ1SyC3tTv6/0+Ru777hOv5g2iB2+vAWIKADH49IyPYz
    NOA3ZqPpf+0VL3BVjMkPZvumvqCCvpR6zspY5uwR45ugDj+FyCTtU7Aae6t9MyhJzOAIZX
    roHc9Fbki89MqT+cMjExPtkAY7NRT5dX9lKRYh/jidNuw4p0Rix4O/6phNbXIc/5xV/LLC
    87ks7iCSodlAdgiCv8+hrF0MuTS4GcMPaAwNmuoD0c8J9YpVPLXA3dD3+X6sv3CMIdWk4m
    +EIDqyF134MwokDRXlDi8SmPfkNq2Xxx3v4SKBVLMXUFQDEr8Q6gc2L7eYYQ
X-ME-Proxy: <xmx:E5ejalYumhyvRnBMB2rqTFp0GsbBPSDPfJiKyns3WQfLiRBPlmu8WQ>
    <xmx:E5ejajR68GiNx-Yn4yv6BkCD03XEESQJxKWyrJiYjRKNJAzMu7LCzA>
    <xmx:E5ejak5BsIZt_ZVaQw-oaNJY2qWruf3m8pimTQH_CVC2qVMJVD-tJQ>
    <xmx:E5ejagzscvkUh3cZGSvXNU9f59bL2B9tho-zHH_EhDc0kt8FKgYnng>
    <xmx:E5ejalbMuRUAeE1UV8r-TwbbMawG1uN1MtFFlHnX-MndC7NQnBXTNSOE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ef6908f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:55 +0200
Subject: [PATCH v3 12/13] t/helper: stop registering alternates in
 "ref-store" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-12-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When using the "ref-store" command we support access to multiple
different reference stores. As part of that we allow the caller to
explicitly exercise stores of a submodule. This allows us to verify
low-level behaviour of submodule stores, which is exercised in t1406.

When doing so we also link the submodule's object database into the main
object database. The intent of this is that it allows us to access
objects of the submodule, too. But that functionality is not even
needed anymore: when creating a submodule reference store, we will first
initialize the submodule repository and then initialize the store with
that repository. And as the reference subsystem doesn't depend on
`the_repository` anymore all subsequent object lookups performed by the
reference store will be routed to the submodule repository.

It is thus not needed anymore to register the submodule object store
with the main object database. Remove the call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 5a9a3053d9..db58f00589 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -74,14 +74,6 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	} else if (!strcmp(argv[0], "main")) {
 		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (!repo_submodule_path_append(the_repository,
-						&sb, gitdir, "objects/"))
-			die("computing submodule path failed");
-		odb_add_to_alternates_memory(the_repository->objects, sb.buf);
-		strbuf_release(&sb);
-
 		*refs = repo_get_submodule_ref_store(the_repository, gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
 		struct worktree **p, **worktrees = get_worktrees(the_repository);

-- 
2.55.0.1074.ge7621b4bad.dirty

