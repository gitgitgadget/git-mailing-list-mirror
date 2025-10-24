Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1530CDA9
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299518; cv=none; b=JvSXgc+TqoqpPSIhQRlRNZfSlDBU+1k0UJmBxCYUEhbok7f0b1dzRR8+rei7LrDZJ631lmduKPRowt9zhaVPRLwntjDflyEwjLFy1K8N2tQFVbQ6dMcVboCu0hlE5RfGTAN92uiQmiWwYI3Omtec6vClGqO4uhC+egRmF7geCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299518; c=relaxed/simple;
	bh=ZE8EgEwz4XzSuI6JC/buStuFIlq9FkI/K5I+8FcRWmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6xG0IKdnKa3cn5FySPjYYbG/RgEhnuSn+Nmxhb2UCvrypa4RcB5smdpqF8YmcH5EJzMSrsgi+XwwRDPmvEvdbaDCfHRYr7j/SQGxdedQ1AFvrtUVLp85uwYyHFpuqqO7WOAUZJy8QZKBlByFIO1HcDi2OJOYqMilT+Y2t5hjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ozr7iaUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwxoOZsV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ozr7iaUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwxoOZsV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E497EC016F;
	Fri, 24 Oct 2025 05:51:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 05:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299515;
	 x=1761385915; bh=LzkRFc46aLpinVCcSGKA9eGoEzhfmx5Y3eQj9CCowMQ=; b=
	Ozr7iaUINFfODJGVxt9nA4SxEzasA7KSzRo+MpJ4EDwRV5m9VkkuC8wM7RLftTwX
	RAxv7UdHS6/DHerEskQ7m2oCbPTF4ViHAbSBqNUgjW6ftBiILcJVhzPKzO0rgrWI
	RJLOVVbIlhQ+sHqOZ3313p7j28l5BpiiYlSAn47i81Bd5cgkCwFEnmptlwYDHAab
	U8QVvGNxr6PjTrZfysbyCUH3+xLeCnfGyZyUkqQzoo0a+Cmw7ZyNZkALagmGUZdc
	EE7MTAIDKuOuLJjpnnNzLsbKCI0leW6sUQAZ8UWEQ6KxtlqysouBzVGCwlFF4OOK
	HuvjH0sVs0RmV/moMpThrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299515; x=
	1761385915; bh=LzkRFc46aLpinVCcSGKA9eGoEzhfmx5Y3eQj9CCowMQ=; b=Z
	wxoOZsVQpkY/o3DkcAJFMTRp5FxNi+EGodvRYkHQEnfag8l3GD3UAoFhqdtecAdR
	HzfDP1SfYoFrP+gKFExAChdKXSAEk+rsGr8rHN3vR0m533vk8KQyHXZJxCxQa4HV
	qfXx0eb0SqKWj/JJkC98yglFPB5rU55aArR9y4RyIyiK2ZrLvpDLlKvDHlUbrIBj
	3Ki3cjlP8a803rbAzbNdN9d3+UfoCDJfXVm2NSzqZ6hQ3/+JDRBWa9sCIEcvTCLu
	dTqc9Sf7V1xxL6VVMH6tFHuHq1T4sexw/fAvJcPN2CRgAVmlOWyxIJ6DGqTcuq4a
	yTLsByTz9KbwJ8UdsfQDA==
X-ME-Sender: <xms:O0z7aD6qp7kehEoxaIKMftp7P1i7ZEoAyi1aa2qG2F7kLe7EFdoShw>
    <xme:O0z7aP7wrcd18qhUsjW56WFA4x3Om2wmNaFpuHIAslMdKuokjSI3Ba1Pl5lfE3heF
    4RMeaJpevzH1f8ktLtZXQHMAVyGES3uMApY7B7zuQ_VEJ6B1YjE>
X-ME-Received: <xmr:O0z7aPfdpSfxP39gFa-KYdbqTW5ciMf3CnY0YBIRakBYyA2jIbbrmJXSNIK2OVkyA1zhvcCigDT8VyPmdGz5O5qtLDsTSnjaOCMJsLm-SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:O0z7aDB635HiB916aYtAf42D-vgFJt5QGwFwJuAb4zvrxjGPYfSa9A>
    <xmx:O0z7aC9cb9Wm32PvlaGX5pFxBzZzKsgz4ppTEoczJc0VjFXrOAAG2Q>
    <xmx:O0z7aOLHJvkn8NEDuy6PeH3AjCgoKxXW_JB93PUQoyRAA38rnSty4A>
    <xmx:O0z7aLg6W7W5zPVmav1GATz4W9d0HX0Im8yz4CcljfftKZD5-a30vQ>
    <xmx:O0z7aDvLFNxojVMdh6-I5J_qycsf6SQpyhJEmS9uJRY6zRzNxuAAXkAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:51:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a691383e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:51:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:51:34 +0200
Subject: [PATCH v2 2/5] gitlab-ci: backfill missing Linux jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-2-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We're missing two Linux CI jobs in GitLab's CI that are present in
GitHub's CI. Backfill them to ensure that GitLab has the same test
coverage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 6 ++++++
 ci/lib.sh      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1dbf236b2cd..f61ec2b6989 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -67,6 +67,12 @@ test:linux:
         image: alpine:latest
       - jobname: linux32
         image: i386/ubuntu:20.04
+      # A RHEL 8 compatible distro.  Supported until 2029-05-31.
+      - jobname: almalinux-8
+        image: almalinux:8
+      # Supported until 2026-08-31.
+      - jobname: debian-11
+        image: debian:11
   artifacts:
     paths:
       - t/failed-test-artifacts
diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d401..a5c4eb40bea 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -250,7 +250,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
+	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.51.1.930.gacf6e81ea2.dirty

