Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A98F19F115
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528653; cv=none; b=aRGYFF3h7DR4MNyzYpzQvBXWQ/QldfA8MUO1BI7WA5IbYk9lfmVfLisdo1vQnrvttBhUEmGXfPzBg3xRLXFNbzG+TEFhlLlz40y5W3GLH/2DA0qQ2fllNNlH4XKoL/9w+rlm+CFlchJexYJEC6PGUB28DtMvlArgnNdXiL+qNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528653; c=relaxed/simple;
	bh=cP9HawXrVy/GuKz1g1osBGap3tFDkkDXxcjKZtoeuQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZtT8Wz1uleMKQJi36jilwT0GdpOXk4F6lzArHD/ffNT9UeRnzuACpQyfyr+LLhxnLp+S2pyi2Ul7mco1vQSMjflT7OAK+30hR/JfgTOzP2c58yoqp8p12fGhi0UzorbASV98xoRMoagyPeaFpZprQpw0e/6c396/sp/GW9HvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PdXc8Y5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/vZ+zS4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PdXc8Y5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/vZ+zS4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 701FE1140174;
	Mon, 25 Nov 2024 04:57:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 Nov 2024 04:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528651;
	 x=1732615051; bh=XZlbKzGgb5gQBOpSL2PePrbXjmJJX3ZbocFPz8AQzKg=; b=
	PdXc8Y5oKEB7PNSeL641NSMYl8srzYdxQnpRfy93VteLsUOwwRQEHs191wieuUlx
	JsvUZdkbW+xjhic3sA040wF/rN3dzOKulLGvjLBAq+1XZRRRr6wAM1BPl0eebbyS
	i6qvAkT75DCmS2Y+VpQcEtFj24gWtTAnYIjBGBXgY+sDTCpY2v1tfKhpY0Cs2iI6
	VqPA7w0G+3rUscn5MkRHHWW/lTR7Cft0gMT566Zo7uUZy1IfPwFq1JEtfkzKvlab
	iwsjChNGL53d3HdabiOXjPHCyEVXfP1J+evqncjWDWlYLhB6M7P6XpimxpQ/rJwv
	hBl3em6jp/wMgY8DbO8ZvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528651; x=
	1732615051; bh=XZlbKzGgb5gQBOpSL2PePrbXjmJJX3ZbocFPz8AQzKg=; b=W
	/vZ+zS4pOiTZlBzl+5tyeXOt8BCFkopB4cIktEEsGL5Lbu+ckIBi9hMjrndW+8vf
	kBFQmaKHTOb01PsBw7uuqyn7WtZdvQ9NPNjg9c5jCbSE1P9fKUyDwWL0JkJ4R378
	pVHzi5wh5zPsdEqw4BXt3d1VME7jjeVFkyOO/myXYVXe1q1N9DMOJ1iZoaTID7f0
	Sdxds+QoTVB7u+QpYtg4leomv94D3xGOgtPec1efUIVWVZceOnOmCgQj1/AJgZgG
	kvcEfBkl4cc4kJM4qbX/3hHGFjWm6m/w+iBB/gn3Y7NzyQtwtBMVQEf2HiOv5lz+
	7pcSsKWVRRopmloLKAiRQ==
X-ME-Sender: <xms:C0pEZ8LdBLD44WbMWoKw5Pq3oPY1Nk7VkmogRi2TGo8SC3ighJ1XBg>
    <xme:C0pEZ8LTHETjbVfVEKkzEGrXDeZMRVd_TqJ5gNlqWZmFa1qaDZWwCuDhMM5zYzf7W
    C7XO6UDgVp4WXoQpg>
X-ME-Received: <xmr:C0pEZ8vNvlCFCHqQOT-_PNJnFtGm2sRVotNwcc6ysyWWbE0LDt0KSRzE9j5YiKAQrNvq9GfMO9KSsHk0ek8UFCGwH9mytT5FpTPZ3bXZKxzW0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    uggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomh
X-ME-Proxy: <xmx:C0pEZ5ZtKdSUauPQitzGrVAEsFtJU4_tlcWkB54LCdImTMlNCFE95Q>
    <xmx:C0pEZzYxpOSq1j2YQ1Cmz3SDRcxaAMwoF7ZJOKx5WRXt6lOil9nCeg>
    <xmx:C0pEZ1AUzpCdV_CCjrs0PiDLA-XDSukjomjxh3RpqpNsQ2EHV9zbow>
    <xmx:C0pEZ5YXXFpBsI3uDr15hX8-YvpYjB3duzAS2Qv1EJZw2OzCRGdbpA>
    <xmx:C0pEZxDbUdMC1WFPb_RIc_uIpqTzZ3n5NZWiYllbDQRNmmbRHcvrITiP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 059e5e69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:08 +0100
Subject: [PATCH v9 20/23] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-20-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

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
index 13ae044808f28067a67cd2e02674b4add14ad9f4..570be8de059283084ddb3acff1d9efe1278ee730 100644
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
@@ -522,6 +522,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);

-- 
2.47.0.274.g962d0b743d.dirty

