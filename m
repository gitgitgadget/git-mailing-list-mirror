Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C9664C6
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558147; cv=none; b=C+bbvlz4L6a8S2GMFUzPMlhOr04j/3ybzx4ZyaFm7FQzFoPOCrTvGdTn+78VETnhmZeeVju04wn28/yLouFdbNQRI+lDkzy3QL8rO5cTIjUDFr6eYBGxcz7Zhq+kXieAMfGHyfbRz6TpfsdWUO4dalipLLRVJRLi9DtKVAST4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558147; c=relaxed/simple;
	bh=dmcJUeWJAgDzjmjEXlwfN1ELTMRyinqvplrwOzKCflA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrFbttq/VgxdTu0I/lbcvWtcQre1mPzurFWH7EiWnoPXPci1mtZnGdkb9fKQZ/+xy5OHLnkBhXcmnnBBcNcSbGhMZM+eCsXVdTVrYwfH/JLWYL34LjHviv5pzonuaK5nu7YdFoyYGxq7MsbYZVcb82NVpxH/YjXXldRGoWscNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jWiRRTDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwAitCh4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jWiRRTDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwAitCh4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 429971140177;
	Wed, 26 Feb 2025 03:22:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 26 Feb 2025 03:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558145;
	 x=1740644545; bh=3Q398hCCOL88eRUISzwy8Wd0OsAoQHJTp+xdpnbPkXY=; b=
	jWiRRTDmW4gIQKZjWuSY1Q+Koi+2q0hdz1IgWDKovnpyzJg1y1CIfXPsPDcNhS7Z
	g3oEClCG2eYaku/W2VRwPErfDmh8NRUY4OyYDdYWaoUQMc5ZXJoh2eZbkTN5JrsJ
	rpz2XW0nyn2it5nZWwM7Lf5zPWR7gpBzAndZJfSE+sKuQrRY3POVdCUgaDXehCF1
	PjOmbLSzGszlTpwmV/Gxr87yylYW4PcnsmC1jwVSWQA2Vk5KXCyWq3mfsJE0rcdq
	FnEciZ89UcRXmytsUBSr01LDxiJsuGrmJ/i8JYKzFfL7bfJpuB3Un0PPUZ5ttCXB
	G1X6nVq9jwJ4nq1SM+mUIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558145; x=
	1740644545; bh=3Q398hCCOL88eRUISzwy8Wd0OsAoQHJTp+xdpnbPkXY=; b=O
	wAitCh46M56SH/MSCEfvVb6zDmbnkpaPNUoBMV+4HY/r/5s0WdcGBTQ3HCTOC5tr
	fP+evmGz5el//+rX2WINUFD/M7v63GKfB6XTUzpThhZEZZHT22qLveKrfx8XTjej
	orgEBHvRfxty+JKN2xB5TCiaztz1DKH6uZrpj5LOcHRdYJQszxUMWVj/v6iMY92p
	tfIKteRzQ+znmIZnvcO5BiVVBlEOKfnIcHYiegz7VJevXNaTXWsVPlK3uE0gjhkb
	7ZZrEweYnSRFvhnATQ+LPnfAcJz/u6X2d2r0/q0ev8wOqvigAOEej+YcNkDtGoq9
	MELZJmnUv3TESUtkLdALA==
X-ME-Sender: <xms:QM--Z1Lgwz04E9bYGqjq5a9qb43em_DKpwt64L3adNKDCSuDpwEG1w>
    <xme:QM--ZxJLfncNycoFNJIPIxJAPecq2rSVkIz1-Mt3Evd5CwFmA_sVBVC4PoEHFIfoi
    rFp-EliaDXuA-dRWg>
X-ME-Received: <xmr:QM--Z9t6MCDtvwKC89TSAEixjzVgAEiJHLgpS358ybp3oA8IsKo4FBCIHRzmnWT8p6HQtL_dS1pFoKWLaIHwwFDM3pQWRb6PBMkQ5x4fBRVkXiaF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:Qc--Z2Z9zLPDlbvRr5bhm1dE-q-Jz6Ii0qMLP0mieXdsyh5RFo0bEA>
    <xmx:Qc--Z8bMBpFGvcSO00deoQ2nbhxc8bGYhoDmKZdZROf6GEx2gRl6qg>
    <xmx:Qc--Z6CwTdeK-WJoVCrpUb2PoWhZNYp459JKptLhsYkgxXqVSYrasA>
    <xmx:Qc--Z6aF4X73V_ht6s0M0alQMffPJ4uGtfmgScZqB1oNzo89qm8OhA>
    <xmx:Qc--ZzXjAy2G5zy62zlZL24AqHe0GImsQhHlwWh-6xHfCqiJT3SOVcdb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 968ab422 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:13 +0100
Subject: [PATCH v3 03/13] meson: inline the static 'git' library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-3-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When setting up `libgit.a` we first create the static library itself,
and then declare it as part of a dependency such that compile arguments,
include directories and transitive dependencies get propagated to the
users of that library. As such, the static library isn't expected to be
used by anything but the declared dependency.

Inline the static library so that we don't even use a separate variable
for it. This avoids any kind of confusion that may arise and clarifies
how the library is supposed to be used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 83ed55c75c6..a124101a73a 100644
--- a/meson.build
+++ b/meson.build
@@ -1555,17 +1555,15 @@ libgit_version_library = static_library('git-version',
   include_directories: libgit_include_directories,
 )
 
-libgit_library = static_library('git',
-  sources: libgit_sources,
-  c_args: libgit_c_args,
-  link_with: libgit_version_library,
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
-
 libgit = declare_dependency(
+  link_with: static_library('git',
+    sources: libgit_sources,
+    c_args: libgit_c_args,
+    link_with: libgit_version_library,
+    dependencies: libgit_dependencies,
+    include_directories: libgit_include_directories,
+  ),
   compile_args: libgit_c_args,
-  link_with: libgit_library,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
 )

-- 
2.48.1.741.g8a9f3a5cdc.dirty

