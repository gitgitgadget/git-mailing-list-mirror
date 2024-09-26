Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B515AD9C
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351182; cv=none; b=imxkpuvpdtSgKhEigdfX3ED1n2fB+Ptuv3/CjTPO1PSA9ulmCgxAaLvelFvNUnvbBKDRHlxztQOAWHdAqvaUBhy6W8H2N1redouGLfVH3Oyf0JdB+pApxc/nt26i7vFbzckfDEP6X6+9fkJBXfWpFr/I3Av8wMhnaW8OZgMEIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351182; c=relaxed/simple;
	bh=bGu/PXxKaHnHMs4sPvlSoj+Nx7CrDWrZtiWsPKxFMbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO5lbagpJv5jhpG+7M2d6jZCz0Oq2c4wbnFkQ9p1W5O4CmselOgQaasF0mrFNkkEepJcmV3xoQMKz3cnnRq1o0aIc1QSF0J2W/T/42A7P0tjN5GXJww7lf4WkRs0Oz7dS9HqZ0NdhmGU1kyI196BovcDEXSI3lrx3c6g3RfLc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwGfGCol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R566r97Z; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwGfGCol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R566r97Z"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C37D11401C1;
	Thu, 26 Sep 2024 07:46:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 26 Sep 2024 07:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351180; x=1727437580; bh=gs2WHV3oxh
	4JybMSCOA0pfVrISrAbMFEd1WNL38fA+E=; b=mwGfGColgnHg4Hvv1uxnA9kwdz
	kEw6rOl2mGHZ5/3Qie9oac++WCP1sGh4NVN8Nm4R+Dpf4WogyxV1ILJxhvIOZVw+
	uoiGSHYDaa6EqGvWQqSHb4GUMIqqponCIwdPq9p48qQmAw6pttWqsMiPSi/tzZaN
	9ZSv1r0hbQLN/ONUkAg5Gx4T4gA4f1SJqbi/9xb57GwWxKa5aWlJFTGCpBa/bUzH
	kaaZ+9OOjhkV6EotKTvRwFMgI1GX8CMJTIJFYt7Gc8n5ygvfg4/pwdwqWjqhv0sa
	5FnN88Ie+bpSgQaRqCyhpe3Hegm+pV8YBPh1Lf/bnFUVAnCYorr4iDj3uQIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351180; x=1727437580; bh=gs2WHV3oxh4JybMSCOA0pfVrISrA
	bMFEd1WNL38fA+E=; b=R566r97ZbOsL+2fRHfmwp6gBY8zbjkEv/DXHHgJjfZWX
	9kUKYeKEHswgiNQN0iu/F1UkXEqqxQixtUFTp87/FxbC3sm2oMXzjrEU860fUO4U
	Ypr1EPx6cUrYxy0CHqZLrcsTX2YBBZCp+okMVfTBr3RhwF+fzCj4Waxxkkmhlhj1
	LQ+PC36rrqq0NMKpyIRQta7YY6CIca2tHtRLn7pCItX7+A1uuMHle3ZNF1iuEiE5
	P6uV4fzgHMncZdU+AIvQEMdEvR7USgzDxAuUwjVImtrHhd0EOsLBn122M9MGmQRe
	2JAwy+BmjsMRiFre/kkH0foZVXsVUAX797ooeI3JCw==
X-ME-Sender: <xms:jEn1ZnfnJJYj_mEvSmWWpbV1czmCIFp4Gkeh_1awjWZ-wg2Eyjl9ug>
    <xme:jEn1ZtOTVfFlW9GO9ZYgOU8E1J_WwAl_GlqZu2gMW_Z9_iMDrdOO_rK0mWk8X3er6
    ih_msXh-lXxkGTkvw>
X-ME-Received: <xmr:jEn1ZgjbI9ydu41MbxLAdmrEMwxIibNRWoe0LwCWg7-tsbLb7VNEgy63wYiwtf6Ew9dtPHsktB6kmaRlUIjGKUaB4OUNdstwXrggu_nQLJEiLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jEn1Zo_eUBJfs9V16O2rVNi2K9v5i8n0RqMdWomnoL9PT3lEvpnzmw>
    <xmx:jEn1ZjsBe974DuSAcOddV2XlIO2IaZ6_P7i-cmtyXcRtsKEo7GHNeQ>
    <xmx:jEn1ZnEkxQqil8QP18G9CfYBI31KJ3B84hLXMDquJjz0vZCJwrti1g>
    <xmx:jEn1ZqObd72kPnAvCSVINvUba5IroaHViDmeVcJlYtxcb9D9BhDPyQ>
    <xmx:jEn1ZjJHCS6-86KiYH9uar9gglqJoROW0568pTeHhoNuo0DkklAzP7vv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf344658 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:41 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/23] builtin/submodule--helper: fix leaking error buffer
Message-ID: <52d12e034b8104a0283958ada013b028322ce421.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

Fix leaking error buffer when `compute_alternate_path()` fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c    | 2 ++
 t/t7408-submodule-reference.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fd1b679408..ff1376f69f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1621,6 +1621,8 @@ static int add_possible_reference_from_superproject(
 				; /* nothing */
 			}
 		}
+
+		strbuf_release(&err);
 		strbuf_release(&sb);
 	}
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index d6040e0a33..7e1afa9ce4 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='test clone --reference'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
-- 
2.46.2.852.g229c0bf0e5.dirty

