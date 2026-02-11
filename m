Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CB331A5C
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806093; cv=none; b=BQoAwPjGTbXeb2VRp4ICZo13oP4u1CaTwSbkMbXs1HsIsnQQwCp7x/MGxTYD6U8292LZhcIunjloKEVFD1pRqK+AIbjdhD4p9lMB2jMEvTQxvQyO/A5UBw6YdVsLbKMso8miOL66/kv8eoT0FNYBvNhaAfmuWAtz7N2j15jtWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806093; c=relaxed/simple;
	bh=bDmBPO/ES6gL/l/3wmY69KTX8GsH/5RQpqNnE/3v5rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFZVT7KMMrHoAkPX3Wwvq/44MMMQVS76bw6/ui6027lCYJWrjHfNRQiY4pMgZuxzYaHWytvpHGq7THKQhjapwyiYBmNtColKHA8dqG5VSGEsZdzMWgdEHQ6PoGsgGGSvQvlg65phtN3R1oAq2TE+fJ6k6xAHwTs19AnoOzSTqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rK+LOD+v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsUXX/PQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rK+LOD+v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsUXX/PQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 777B67A010F;
	Wed, 11 Feb 2026 05:34:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 11 Feb 2026 05:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770806091;
	 x=1770892491; bh=9tbR4Ktv8mkUSmZCkaDTnQIYK29aGTODpF78+mE4veQ=; b=
	rK+LOD+vffGwvmh98Dnao035uKYgkFvN+H8wevNbIDtmQEYuzBtddUs0LOPVebQ/
	rnKz80djGPbbB1rWz4Otu+cOOcHp5nVuXrJne1jCwJ65qAE8qQWCf9JBVJb1tfpU
	0FVbZRv9YXHzoz4mgMDAH7udE2yeIrWCaMRoJUzrJkNPS/JuyeeP+c94YSaHxtlY
	y1USuh+67KU8y9pSZMiShTMcrrktxl+waBNMhnoZU20tuKf/VrDvSeCSyg8c9lwB
	pnfbSFbJJB5ppXQuRTnE70RcIaJ7uSG0pJS2Y0soRpD0lvzMPE4VD1fg5o/ajJQ6
	WmbSYMQGK0EYDtXeuGGPzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806091; x=
	1770892491; bh=9tbR4Ktv8mkUSmZCkaDTnQIYK29aGTODpF78+mE4veQ=; b=g
	sUXX/PQ+k7TADSnNpwMsxJNSNJs0i4CO57TGSeMHZTJb325crygS6JhU5aby9HWO
	H0Eqns86Q2m7U3pLRiWKV1vpOMU+90K1pQOBa2ts3dcd/kTE8aVi2Wpkm2/+ui5+
	9dRPrMcsXVNhelXpjvY7lF9H843lxpaGi50dKbklql4jsaXj6Sn5VFNRN9jCUC2W
	Av1IoNWv5eIDdkS+GGRmq7w/jzBIi8fqbYzJwaK4JimOjCHyhKYakFS4+cEOrNk2
	oYp9sH10jJQQ06I1CJw3DMQjEzhSD9PbqcxATRqQ+7jkFgelTOU4EoFARAln2gGB
	1QkA10ez4W9oEGvG8Ul3w==
X-ME-Sender: <xms:S1uMaQux4929YYAZSUERp5UUuQp6D1wICWcJzRI2a_96xXpCy8sCsw>
    <xme:S1uMaUcEVS6eKd6HiiYVo5qGgEKvuXL6m7wBhoYqg2VOAczj1loiNFww_0vis4BEG
    9xwdRKNCGW7z9aAxgJJT8s9sp5sBVVZ6LcKlGKpHTQDiMdiSoxk>
X-ME-Received: <xmr:S1uMaQyqaA3c-EIoL5wQ_4X3z5bbFT1mEWpi7NZ6zYeFPGSjfZTQxSltpUx7gPwiTQY825VcVEZMCxDD1vamDg2P8eFzYOh-QN5VeMEHOgD2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S1uMaSE9h8IVGfizJ0iIGE4qCWX9Fv1-EBNnJYZBoUlmDHI6SwDCJQ>
    <xmx:S1uMacziLfq7yaTK467nCZyX6KxNsB9xUshiOP3Oi4BLckDENpwVUw>
    <xmx:S1uMabsm8wm12VaPZy5bYyNbjAsXeA7InvnStFnQ8z_VeX457JTXfQ>
    <xmx:S1uMaR2ToheI5Z6ggsxDPhnMfv9QaerqxDq1WzvV55Hpuj73qnwHpQ>
    <xmx:S1uMacvtJJ_55-_QNK9K3AWErED9NwT2EG6NRsJzMjlj3ebcvqdpgMAV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:34:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e2a1015 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:34:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 11:34:30 +0100
Subject: [PATCH 4/7] github: fix Meson tests not executing at all
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-b4-pks-ci-meson-improvements-v1-4-cb167cc80b86@pks.im>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

While the win+Meson test jobs run in GitHub workflows, the shell script
that is supposed to run the jobs is seemingly not running at all. All
that the CI job prints is the following:

  Run ci/run-test-slice-meson.sh build 1 10
    ci/run-test-slice-meson.sh build 1 10
    shell: C:\Program Files\PowerShell\7\pwsh.EXE -command ". '{0}'"
    env:
      DEVELOPER: 1

The step is currently defined to use PowerShell, and of course it
doesn't know how to execute POSIX shell scripts. What's surprising
though is that this step doesn't even lead to a CI failure.

Fix the issue by using Bash instead of PowerShell, as we do in other
steps that execute shell scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index ebb1a06bfa..76ef513e72 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -297,7 +297,7 @@ jobs:
         name: windows-meson-artifacts
         path: build
     - name: Test
-      shell: pwsh
+      shell: bash
       run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''

-- 
2.53.0.295.g64333814d3.dirty

