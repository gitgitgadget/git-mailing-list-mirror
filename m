Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18B1C3034
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810364; cv=none; b=lAlUhBfPeJfIWi5UKjaIt3nCJl9cLSvWNKrR558tBpfUJPMI13uTmwUGxgsz8ZFlFNjTlCmEZCz6rh1SF44eeWyd1Tf+iBcCD1hNttJNsyE0n6TfeBrStELbppQGIC3YT9Nrh7P/3ZH78PNHxlTOz4zAXVuUxDquPGJcnzSsS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810364; c=relaxed/simple;
	bh=uSIQ/70SqcMeIlWaa2Bc8ZZf1yJBCPEmXNkgmKAT+KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZgZ6JNCpI48rMYQM9ayfvJEYclQAHTT38+1S8hg0gn1BAihpaNawJZikqBstPjjvGPTU5+c0h9wxPBgBddX3hoGkAuD76CnHcaDk+ZuXdCwPRqpPo3D1XAqqNDuO3/s6jmMqkhlbf+l4pRNM+yOyYh23doKwOBj++XKofZUBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sl4FRU6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5YS/2WlB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sl4FRU6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5YS/2WlB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 116A11140151;
	Thu, 28 Nov 2024 11:12:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 28 Nov 2024 11:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810362;
	 x=1732896762; bh=Ce9/+sefwLIOge5mIpMLeQ3t7sYviyRxxx+bQ/Flj18=; b=
	Sl4FRU6r9bNSLJiinjsKOZUbrwyD9bRPOM/3HQL98Dsej0FPI8h+KliyimVUilU5
	9p7jFKq2vTauuB4ek6RFXGyiKGfX++1izXql5AFqmB+KX+HRQmbh37MrI20nlqqm
	GrZ44qX7SjYEwLde5QihTPxYmkpAxorFZ3BSGcozDPOEjFnFokEw8CmjeGWuYphK
	l9CA2C1RjC5t3KY18p008vnSdTIEsVdsBb91akTvRHwjfx/FvIm4ApY1+EYj2hEC
	TbPmPaFFdjPHm+exlYxtR9hj3Ss7/8c3M2KEYf4kvHLICb7U9AfWlhI9N/8qSv1+
	IQq10prghDxOcew+TLo1ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810362; x=
	1732896762; bh=Ce9/+sefwLIOge5mIpMLeQ3t7sYviyRxxx+bQ/Flj18=; b=5
	YS/2WlBXLX/olRkiSJO6eyIiBBAiBYO73e8edQiLVR/zFJ0BVXwacUSDhJetOIFI
	w3QMnRn6tmN2qI5FlNwPJ8gnLCIdfMmyPchKC33RuYZnuJZ+spAq63CVxPxp4Gb2
	uziiXw/VnMU3Pm3mxwn9V4iCALsEtdaWzLGiYZBrjX0LyA+86bevHBniAjBU/f/t
	TbhbjXjDKLiilQP2Bp4A/GSn6/7i6hm0AXgx7ab3sNvQy/Ya8BMOR3r0kNIjUQ/P
	CgZ3bz3j/D6iJ5LJf9iZsxczo8WruY9JBaUAtmE3I1qc3azcTjxKQ1278KBuUHuo
	xFRC8QlhFNc4jWxrwb44g==
X-ME-Sender: <xms:eZZIZ6PVwZtL7PN6XXsm5Xy-_DzZMixrWBsx8_pSysPMBvXk6a12tQ>
    <xme:eZZIZ4-Esgsq-1AeWW_iIB6YEhQfQXhW09aY51EeSDtkZDyDgWmy3pmEWuWuu09KK
    8ErkaXAyk4BAF24sw>
X-ME-Received: <xmr:eZZIZxRDT4uGest6Qa_rxQ4_dMUwylbMiRxpDZUJ02FO-R63J5OR5F3W_hHx1ke9BsmZpbAmIp1TyDPTbhAUfx6Q-uA5LNDmu1Dq5wBuvIR3cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgr
    hiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:eZZIZ6vzVvpZ1ePJGrKUx0IM-jpK1F5OiXNzFQNjKWVa1p4CgLZKUg>
    <xmx:eZZIZycm2d0P6PpsWxsXo4JmBxQQv2mwzHWl_6VcRGpgh6C1_qF-xQ>
    <xmx:eZZIZ-3klgxfOX63HPPc923MuY-9UNTkOiPXjGV1rIFfsJ096WLsjg>
    <xmx:eZZIZ2_4BfF135rlCbE9CFS3KLJ0eZXL7hneGAjKMFaQHERViduAhQ>
    <xmx:epZIZ-0MFDphPsusFOYvqZcasZ9vRHmNdg3EG9-pX4YMPCPmwvZw8mDZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8cc64cd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:21 +0100
Subject: [PATCH v10 20/23] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-20-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
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
2.47.0.366.g5daf58cba8.dirty

