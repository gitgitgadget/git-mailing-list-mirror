Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDA13C8EA
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656967; cv=none; b=bPN//LMnE9hFnDb56O1tKVdY5EBvmPxkrl+8Tu8EPG2T7MuZb5dKDX+bTOqoWB2BFkgzyFlsZ5A+Y8FfaRY3Xj4FDwdg5AXAFKqCApcE2uTEa8/sUyPMLHAc4PZSRyXcUWHqgQVdYiAhhwlFIDZzkzkktJ0/oVotyQdwfSGRAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656967; c=relaxed/simple;
	bh=pkTQvDrpLQZ4M1RiBUuXrm24pOrML640LxxclgPE0MY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+mLTyh39lAQ+faCyjLbHzCQKXiCZWR+AD+IRA/+B1lNbo9x5N+gfJYWNy3fNPrrFpBvTThvWPrqYLGGg6jmucFGjaWwPHs44IVZu4yUcL1Q4Ofm/BXKpX94YKAIUVf8obnqzguAEQ2W1hUGMUjrTQL3qintUH8ILykk6i4d/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iome9f0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWgnheGN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iome9f0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWgnheGN"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4789C1146CF3
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656965; x=1724743365; bh=BaXAJwbqp7
	az1rv3oXGyH7Xo4T09q7KKaxnPVNVqaYs=; b=iome9f0NNZ2Q7FI7DgymXhgYTm
	cBA9phV4FKGZU9eFtwYj3Q0bbDVJPXRNWH9mg9FOuz/xy5L7JSKYBbKbSePvsfQ2
	MNIu6eo8lC4BsPEkuGeV8Jw3+evGLuRz6r0uPZBiJZkjNqr9Rp+ScgNQ6VW9s4Qn
	FtoZt/JDFHTcjhtGq2Rw/RUFxX0n1E4m8UBWc7WITDa8VTHyRpqHj2g1UXPjYfqs
	A/DMAxXICM+pzwfO31FTwNbcx57F5Cv7bvM5W92WMoiK69kNqpCzuzoq9gRo1O2n
	Nzfcm5ydNRknBvsHp6dnAmia+ToE7lm3/OaGsC6P7UZuMHrY6bgNwrEJuQGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656965; x=1724743365; bh=BaXAJwbqp7az1rv3oXGyH7Xo4T09
	q7KKaxnPVNVqaYs=; b=bWgnheGNFjE5zEgJRBqakmPSrJB1ppKyHaYxB/vs5Ziu
	rmUwdYqW9tXSpTCi4JCdFOAkEJ1ID+sBLYuGWE7zkEPCT1HPm1w9xFL+AKwNOThl
	C0cdecbBw6t56RSkGcA/bWCIsdU79bYdpFYwOhvXNSZTg+v/XOv3bO8GhyGAUvFT
	+bURfFNaQb/Q9SkMM9jtKgqer09bcR1vwufAY5lT7up1ZBlLlaUq/v3lsuLjbMeL
	y7agbrNRqxGph1RRy8oLJDCoimaaKjPiIGMu/pdIqCeP2qNu3sA4/PG7XTjDWDXU
	pVLeDbbHuqu+/tJ+69x65E8Yo5WuMI6yJQAAc1BQvw==
X-ME-Sender: <xms:RS3MZunapFaN0R8hYNJr-xikjAUVeBmEL1w94_VS90hPNjxV6Gfm0g>
    <xme:RS3MZl2noCUzS9H-etXFx8kdXPdilnN9jKPkAkWlrSzS4cxSSNRKdDr7CQ5pMOb3-
    cRHfZ6K0ykxr8rVcQ>
X-ME-Received: <xmr:RS3MZsoo4UIlW25RGj3PoQ0mKHXcwllLSDwX-JxGJ0BWr9nMn7UZtSaZm8XTKY1mUQ4Jk13M4vmSu4302hh5pa2pjWo4d_SV4QWOklffRa8rFpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RS3MZilGn8-KBc5-pf-cyxsHM71482xz4y3a8O4dWw0a4-GOcUq4iA>
    <xmx:RS3MZs156ffQdqQqi_8gdZyYLMQsrxckXdAurJdF4sABOKMvUiZ61g>
    <xmx:RS3MZpumueGxALyqek5TwE2z9vAXGUigGU_644HvufOQkS2GesAd0Q>
    <xmx:RS3MZoXDPFubkQUvCzOB6kIhhQuh9GrAj8D_vosszmkneuv4p69aMQ>
    <xmx:RS3MZp-NX2YjH2i9vmy6ptpPYq87fkuKB6-0Qu1syHUavAJXfkydFEuE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e70f375 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:42 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 22/22] builtin/repack: fix leaking keep-pack list
Message-ID: <3d30c727fbcb930f34f363a72cf4fbf7168b7504.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

The list of packs to keep is populated via a command line option but
never free'd. Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 1 +
 t/t6500-gc.sh               | 1 +
 t/t7703-repack-geometric.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index a382754feee..3ee8cfa732f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1543,6 +1543,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 cleanup:
+	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1b5909d1b70..58654b3437e 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -3,6 +3,7 @@
 test_description='basic git gc tests
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9fc1626fbfd..8877aea98ba 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack --geometric works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
-- 
2.46.0.164.g477ce5ccd6.dirty

