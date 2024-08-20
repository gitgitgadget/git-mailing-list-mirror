Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCE1917CC
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162726; cv=none; b=VL4uzl5zJOg7k1w1ha0KeoV9nzGLbU2+SdVRNsUY4T77keO64ytOykVIIUDFzI67VVvJSdT128MvjOUc2v9c0QRxxrimge9kPy/SNjLRI24Lss4pFXPHjFJ3YbTF/fdIxtEgfRSc+Y7lW9m+ifuVDVOeQD0uckRRPyVbkZvlV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162726; c=relaxed/simple;
	bh=+efCFzN5AJynIXOyAn8If4Vqm3JpKtRIWXMyvKo6mk0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrSC1nA1kAIoT4jA+JGs/y2TtFTzYTIqq6Zu6W5OG9Y+1DVi5l0yv/lbOJQW6lfxKxh0SRc56kkV09AZ0HZKmj1mPAe21WLX4f4xLnstaLISkCMA2QvH1hGNSojR2JzdvdqFF3B9LQ/4fSztVsgKtRikHAMjqX9DA/+RFqyqGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Upy595PG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJcOHGLS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Upy595PG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJcOHGLS"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4BD771151A9D
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162723; x=1724249123; bh=bAkMX/B++S
	8eeyt+CSPR2tJB/BpVSX65rkau1VWDiR4=; b=Upy595PGrtRKmV5MlyOBG+dKGk
	LkeBkt4h8N5XttWb9k8dUfifYGvQzseZ9E/rC+RH6C6DrQCzRsUDPW4ZVIdCNv8e
	xItX774qlmRCq9KLGKeePzhoJHwgutwBmuOBvK6M9Iooh/Y5YMkzMpzGHG/AmGyP
	0fTk6M6ZiUILdcEqjbiF8BMK6qmXfKThDiUrRsGfCDpieGa/lavCifXGxVsAIWAI
	QjZNXuwxybLKBSk0Ih5a3njDjLpZ+XphyV1NZaBUoKHqBZJ8tOEMjdijSVh8kZXD
	rVRIFhJmtgkBSfa97xK8ua+kobO/rehWHoTzSoeaQcCSNGxB0XhETCXhLBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162723; x=1724249123; bh=bAkMX/B++S8eeyt+CSPR2tJB/BpV
	SX65rkau1VWDiR4=; b=FJcOHGLS03bMyLp1bPUBHscCfqBx3+hZ9mndXJxvBaeW
	mznuocYV8EbOJHhjtT6ln+kNbgCNu99qRF3AZZcqWTZQahCPEhGQloOVchQL7GVI
	n02vVpG9vaBhpTG4521qVWUHovD/Tdk6Cbb5hm/SKdWCBMpuA1o5SwOqZwWeqnq2
	eF1srX9vRAMZbMiU1nAV6ONvVPTrEWv3D6O4Cljd0dREcqMQ7chNACF9b6WSwbbr
	p9JkRE6QDnuszQ4hwAjI80fbYpT167hTaaxwD+6/KM/8JDe5UVml38q4QIkWC2hE
	AzknjsUyDoHJKWT5gDv8TQ/uHLBn2eyV6ozfN2OU1w==
X-ME-Sender: <xms:oqLEZn9ZzC0qAvS24lElH8VKkn4pKXoyZuLpGEGxnYFIO6CRghgBCQ>
    <xme:oqLEZjtRdAM3y5aH5OxT51k7gt9w5MuvgANX1UdfvfVKkotHAbl79G2HHS92u6pV5
    tfmJGDh7WIeI4M8ug>
X-ME-Received: <xmr:oqLEZlDwRf2pSkqKfyNwvIfO5RELB9PCxjDGWejqjShyAwlRzAi4AjFLtcFeOR28n5YzT--1T8WIRM3TPjXIe3FbW6i-tkkDQo6ojZVTzVqou_XW_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oqLEZjeeUtuE4wcrlB2Qgn9UEgSI5NWvf9qzOA7BexGAYEuykIb3zQ>
    <xmx:o6LEZsOLSmXT0JaJBJ1ZwAmihvxfr74VCwIPMrdW8U8yW8-VxRcNDg>
    <xmx:o6LEZllQ-YxcoKrx7JBuqUWCJxLcP2c-eebEXzCsV7c5bcmA0NZYsQ>
    <xmx:o6LEZmu9ALeP7z-I2xxBXv4BLdWMBpl7s5mZSQ5NtEcriQTdXL37TQ>
    <xmx:o6LEZm2ZNLjYbShqNb2HW097glrFfaqrKaUcjy016Srw0OHIjpVcpQeC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 637a47ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:04:50 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/20] builtin/archive: fix leaking `OPT_FILENAME()` value
Message-ID: <bad575df12658ea63fddf082a60be6cb87c34972.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

The "--output" switch is an `OPT_FILENAME()` option, which allocates
memory when specified by the user. But while we free the string when
executed without the "--remote" switch, we don't otherwise because we
return via a separate exit path that doesn't know to free it.

Fix this by creating a common exit path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/archive.c      | 7 +++++--
 t/t5000-tar-tree.sh    | 1 +
 t/t5003-archive-zip.sh | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index b50981504f3..63f02990d11 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -100,13 +100,16 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	if (output)
 		create_output_file(output);
 
-	if (remote)
-		return run_remote_archiver(argc, argv, remote, exec, output);
+	if (remote) {
+		ret = run_remote_archiver(argc, argv, remote, exec, output);
+		goto out;
+	}
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
 	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
 
+out:
 	free(output);
 	return ret;
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 72b8d0ff02e..7abba8a4b20 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,6 +25,7 @@ commit id embedding:
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 961c6aac256..01f591c99b9 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -3,6 +3,7 @@
 test_description='git archive --format=zip test'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
-- 
2.46.0.164.g477ce5ccd6.dirty

