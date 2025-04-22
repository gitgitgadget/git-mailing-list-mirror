Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1681EB187
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304624; cv=none; b=X7QwVTcP9AuJUELgVy5WpHsQqXC2CfvQAC3srMpcD+EMpqThMjlR0ch07AFJFfi2zlDZFKUVQyV+7y+vtPqteZb1Rgju60hZVbFLT1tloUOhhiQIuN6eNi1o5M5BvC6uvMl3yRd+dJWNprHlQw8qhxTzvNe7pkBycP8cu4LO3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304624; c=relaxed/simple;
	bh=23+Vk+T31Bo9zkpDtj+AY7LFPfyehDzNWXBz44k3XjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfTd+08P6CGWcMB3IWN1TGVN7qr162tXKXFY1RCcRdWQ1s3aIpUI+XZ1tK7uIhkWHbc7pIahxnVVqK2bcf+O8pZq0Pte5MllpO8h/OCjpLDOyoUN2EqsVMWDR/JXD+NkBCkZFj9Mzo4An2YV2GQHK3gEApkSvYYGcbfj3dIjQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZSjS7M26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rENM0RR1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZSjS7M26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rENM0RR1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B3CB511401C1;
	Tue, 22 Apr 2025 02:50:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304621;
	 x=1745391021; bh=6RP8VZ8y8ycAvjA/Nxsskt5SLCTtXCQ2HFMv+khAgyw=; b=
	ZSjS7M26rhvwN9xchfyzroeCRrIaoeDIC0EiXvZbb1C8+dulfs7Oc8byo6ITEjPk
	THieZ+FVBHBIInGdKyHXVmBINYjI+EtCbuRjpTpmO1lRRH8pX2tlJT7CwPeoyLon
	t3sGTPvA1dV9vHNh2h6cekX8bCNHrGOftXa2BMzzKHcWa6aXfOSDcXcOe2ByRtgH
	Kc2nPr4FeeTMXkXu++B3olyxH18lP1afEFb2zWcw+Zuy2AiuE1b2VortZjA6Z2t7
	xdK98hSTSIAOYrVz9v8tpbBmQ2doaQrMnJi7TsSfr3YCzrCDdVGTa9vcnNVaDxd/
	JeiiK6qQa06H81YLS1bqgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304621; x=
	1745391021; bh=6RP8VZ8y8ycAvjA/Nxsskt5SLCTtXCQ2HFMv+khAgyw=; b=r
	ENM0RR1nQSgNgmSrFSMEB/FYGQuHKJa0FThh9pVFnuyely+56gwCCrbzM0MWWKZX
	GoUG+/vT4OMbC587x5TL3D79Ag9AZ9mwSHwGcsQiugvkYq6k2EX7agALfplZHVy7
	VymKQ4aPY/H/9g/tnbv744lNgsy6XZANTWu9Z4lofsxGzx7xPYdcoGMNIWAqAbvk
	07B5YUl+HyGUhx83qHWFMOg6vLFLNciFqDT0kuAJGwzHmaAL0F6UDxSTnCfIr00Q
	435US+CzXItWl3F0iUI0if+hQAKIoj4Vxw6pMLYdCtsxUxVyIlHDXu4Es/OVi6am
	tHqLfg+/5Dg4enOpq8aCA==
X-ME-Sender: <xms:LTwHaM07K7DWh_38tSdH5MdSLayKC6Rxf8mx9IARAvB9U-jAhC3rdw>
    <xme:LTwHaHHAFAnZ0N7m4AzB1iN-R1uepWiwope8JHGoan6x-nawmVzfUNqk88KjEUYt-
    hYya4dHmvVoh8Qqew>
X-ME-Received: <xmr:LTwHaE7OR-BkbfpXUwIxlfTpwU9PASkOFVhelGuaLxnW_yGTQWmzAEshn4JRF0HiDKd18cQlmpubEpG8boBDLKUHpjiYhy1ctxR-3opepxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:LTwHaF1XuBocOxiAQUkOhu624Lw38MnFC53IcSflI-qeppppHJ4S_w>
    <xmx:LTwHaPGE-mq3sr2EUYjvbej_YQ125fnbC3M-iJ6hBftzuhC7-T237Q>
    <xmx:LTwHaO-8La0D9uEIu71u7FcBChhCpjNoDcS_aFTPlYA2P7rq07c_Eg>
    <xmx:LTwHaEm9KbVsLI96pyDMZuJUYZyPtBd_X-ipCjl1EL8VCY7eXnTUoA>
    <xmx:LTwHaKa36ztEaXGxttA2L3w8l_QvjQ0e5uN0K_7RL-ZaBOSvgGSXsZ1T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8e9645b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 22 Apr 2025 08:50:11 +0200
Subject: [PATCH v3 1/5] t/perf: fix benchmarks with alternate repo formats
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pks-meson-benchmarks-v3-1-7aad68bac6fd@pks.im>
References: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
In-Reply-To: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Many of our benchmarks operate on a user-defined repository that we copy
over before running the benchmarked logic. To keep unintentional side
effects caused by on-disk state at bay we skip copying some files. This
includes for example hooks, but also the repo's configuration.

It is quite sensible to not copy over the configuration, as it is quite
easy to inadvertently carry over configuration that may significantly
impact the performance measurements. But we cannot fully ignore the
configuration either, as it may contain information about the repository
format. This will cause failures when for example using a repository
with SHA256 object format or the reftable ref format.

Fix the issue by parsing the reference and object formats from the
source repository and passing them to git-init(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/perf-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 8ab6d9c4694..1a9a51ca3cc 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -98,6 +98,8 @@ test_perf_create_repo_from () {
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
+	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
+	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
@@ -114,7 +116,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q &&
+		"$MODERN_GIT" init -q --ref-format="$refformat" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock

-- 
2.49.0.901.g37484f566f.dirty

