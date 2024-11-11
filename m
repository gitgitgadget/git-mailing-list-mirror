Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7041A4F1B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339089; cv=none; b=RLWc2Wa3c00nfxkME6e58O+stg7wB/wh8SDriskLNV2XfqsDM7MSTaASm4AzpaCmICbo15y5aA2KlslkFB1CY6KruJ3dHAYvS49h3Wz3VJI7jOGLZR3rSWXenoLQfDnFxiT6EjDM2XcRzaEaipYg9lfE+Enlc/4mlXXXAdVfJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339089; c=relaxed/simple;
	bh=oHa2vsyo+i16Ayf3KjoWhX5QSK+IzqpeGOxVz/S+d+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSf6yVnZ1dObcXirmPbvT3SAmCnQ+P3fhYEWzaMeIu3CH84dTtwn6u8seyu669ATEjyMKPkn9fj8WcJ9ppwGQqbdZqRQwRMETa/bIYfk5GzGZy3rFBNGcr+rqyHxEk/zRXFpS+Q+lG4jX4l2KVdnZ9CiUxYV7KC1g1OLA1jmqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0OcYzls8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwvExr4/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0OcYzls8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwvExr4/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 69CFE13806EF;
	Mon, 11 Nov 2024 10:31:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 10:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339087; x=1731425487; bh=EE0DkUWqYh
	3iE0Xprxw12+q8FJ3aq36GUMw6m/7iYrQ=; b=0OcYzls8R3rTTV258oPYgbB2ra
	1wnLp0tYluhOquO/a4vlTe/UVl0C9oJj0Hcf6OMkk/Jhf2DguHrcLUWlBSK6I+XN
	b6L9jofBcGlQ1pP5Z5poAO8l+AXn3h0/AKZ224H456s5HrOKiUDG+5dYkpn3SJfO
	oCnCGNWKPGB9StLsXVCsh3JAZX2KuohoQS2iSrWUqOfpI4HWTYb365nUPl1rqezp
	WcL6xJHFGqtrzy45Y9Z6IHHamti+tT6QGJiFuMmDVORXR6EaWw6UQrub1fve0zMq
	n57qvC3+/pNsdVritQ6TVeCREWxjQvXnWbpPsd+GvAeWfqsdlH1kYebjEFwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339087; x=1731425487; bh=EE0DkUWqYh3iE0Xprxw12+q8FJ3aq36GUMw
	6m/7iYrQ=; b=HwvExr4/kHJdrKI5RFP3LotLJb5c/shjA9pGFORbQL7p96G/PpG
	lzWMa4LbHRB6kj8eBeqHoqnmZ2JVHWny+lzeR8J8+u4w8YAkNW0SywFLKUDAyX6G
	9XJ4X9VdhEZhvssk7REpz4OI4ASrO/tZ+o+25ZKDW8Pv/Qu3AlbYlJ/RLi9scK75
	A1Trztcx4uExgGsQ7x5CBdrQ+myG1jS2asWJ30YhllU+vuczLYs/Xxq54QJT8bB4
	n1dPm+7+BS+QIpuGaCVUlnzepFnXOjz0k7pDfb79yQPu5+Ykiv9eWemq8FUvJyT8
	z2uohO0Tgv7C64WyWCBJDmSEt7MAlIGJP1A==
X-ME-Sender: <xms:TyMyZyFcEXSA2jYljc3dFxL5dQ_Nf7JF0Sw3L4RvU4WBcnY9JknqDQ>
    <xme:TyMyZzX8i9jNYuzFaaR9RLXgXCtXe1_YBNJ6Uj6TV1c67XCpEVN5Kl3hTrWVuXf-t
    EiSm8e4y3tOkl_YMQ>
X-ME-Received: <xmr:TyMyZ8JYbmauwYVcNiwEI_G8onYy_ZhKXYQpjRXRrAOIfGXCL8hdl21FHOSdDKA1tM0rCFB7z7vwJLsaEiG6gH-tg293XISuVU58yT6LxmZxsn9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhp
    lhhushdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:TyMyZ8GCdRSXlVoZ6X1Ft4Gn5f75c2hsSrh_7BofnlDiM8gZVMw20g>
    <xmx:TyMyZ4XWsW1dRwDiDVf2ZilnLsPjcuK64meq8lV003leq0t3FVYyLw>
    <xmx:TyMyZ_Nw9hQcj700mgpNv_vXseKXd32gA7MtaBPel4T9VgAjAA_G-g>
    <xmx:TyMyZ_36CaPbpLZ6QkqPmJxHVTbDFmVukE1EtJP3FsvZdfkJWNGseQ>
    <xmx:TyMyZ8r1TA7E294S3dneal0UNlkel1-Mrzj_61iizynFKOw8R1aJoCC7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54665b2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:50 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 16/19] t: allow overriding build dir
Message-ID: <8ebb918404304b68eff4e551b87c86784d8795d2.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

Our "test-lib.sh" assumes that our build directory is the parent
directory of "t/". While true when using our Makefile, it's not when
using build systems that support out-of-tree builds.

In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
we have introduce support for overriding the GIT_BUILD_DIR by creating
the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
the location of the build directory. The intent was to stop modifying
"t/test-lib.sh" with the CMake build systems while allowing out-of-tree
builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
fact points to the _source_ directory. So while that commit solved part
of the problem for out-of-tree builds, CMake still has to write files
into the source tree.

Solve the second part of the problem, namely not having to write any
data into the source directory at all, by also supporting an environment
variable that allows us to point to a different build directory. This
allows us to perform properly self-contained out-of-tree builds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 677424ced06..096af9be6b1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,7 +35,7 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
@@ -513,6 +513,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
-- 
2.47.0.229.g8f8d6eee53.dirty

