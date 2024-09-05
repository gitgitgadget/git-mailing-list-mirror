Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CE199939
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530976; cv=none; b=bPyBJqmnWuZHhIm6lCCiH/ssEf+7wjNVpGXiPG0xecYXZ8I2d02Dqh3FQ/cmfGheT7TsU9n/lCzCxxAManTYkaFG8YMz+W1HoAN6jAp+vZNnnsJ57K/Ue8f5xvxp/DKzSJUoXnB076HEmWl1Hscfn5KTxH6Kjtmyk9bhrDR66vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530976; c=relaxed/simple;
	bh=6HjMh0PC04bLWX6kUMBMU49FQyJ1qHBYkjqQ319Z/UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCpsd0LHi2gFQosBpuTLRXDB+Fc7yFn8wlJC9djl6UZieswZikQnvIa00ThN4nDtiuVvPELULH4il1oG2zU/efonfEQclrGjlXtdyfdMkgLZimDdjq7VjgF9U32WKbyTBI+USsOt4ezdDkQiHRjBjWxhdgYFO3WDkgCECOsQSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=laFf/Pxs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jb+4rbDq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="laFf/Pxs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jb+4rbDq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AF501140142;
	Thu,  5 Sep 2024 06:09:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530974; x=1725617374; bh=5X1K3yxkDP
	A6xlYNhmXOiHf+wP9eEYMqFSidkM1JlLY=; b=laFf/PxsDu2HYWt7NuL97XOkcP
	IqMASauinpQQk3woIQve2XicibD3gQCie4/nu944hTPi886z5xTt/5NA2BQMrrIO
	xqH5xy7izo2P4GdGgQmUahigG958xy+4QYrI1E20VRXjPPQoF3fSyoSDIsAZze5/
	WHj3t5e153ac/cU6Cl4sFpEo37jDjf/D7lFfuzg3JOXIdaiHw9DRTmaR46GOfnaU
	ZhyX4Ah9qx/LelorqmK+P6t7JG9F1t4gQtqNp9To5p/2+1Z2PXtpGjyNdUnnUJbB
	YN6CkvkqKMOfJ6Iaw2JSt0oYgYxpweOddQX9BcbMpOmEFZ8D1dtlSr0FPEKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530974; x=1725617374; bh=5X1K3yxkDPA6xlYNhmXOiHf+wP9e
	EYMqFSidkM1JlLY=; b=jb+4rbDq636QN+XcYisIjJWSQ4qP0HR8lmyA8GqEyg4I
	K+eImOYk9KGJUvcsZK9T8rcoqmbCX/m+Bo0NvT6EEvYdNLRchzgkr6Q6GQTAiVws
	wBgWho1O0WBxmucRrFfIm2mIS7Cj8bpH/Y76pqfaQQuxlKIgiFIdH8RQWgarGd81
	2OoB3Of863CGU3hPTuIfHHFjXbUdyjdRIGE9X1CM2LwxxIBXVTkycY+4KgzzGCC7
	biN/7+sX75TJ5QiOggHj1b8pPIC2ve+u0upg+Nevqd+Hltc5xvKAu6CHs8UfAgTV
	ndSXxzemnA1z1iwEKM69YGkbUwGu8uaR7PON3mM8MQ==
X-ME-Sender: <xms:XoPZZjHBXjvGruwNt02emY1gcWGXVJ3GmsEDp1jK33A0AfCsebxDew>
    <xme:XoPZZgVkDEi9lX2SKygGDOhCpaoG8xQrg7AGWz_nkA_od3SKIkYF7nsDxFwYGNIH5
    Lyaw85q60muNg3iOA>
X-ME-Received: <xmr:XoPZZlJsH1HphgCCwC1HYfB6ndm8QLnQchVrbqpkI4dplCqh-DnASBEU8nANezq1gHg33uriyr7FmSnXG1eEoWU6gKfSWWRLqjPvNQrdLEjvbAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhv
    ihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:XoPZZhE3LgK9Rfz3Qgv2Xace-_mKqhhJN_VbZw1q7I9GwRYJB1QB2w>
    <xmx:XoPZZpV8FjHFHj7WJCV-shfg1HcFa3QDcnBmZdku5xwRCuxCOmv85w>
    <xmx:XoPZZsOFw6qIUUBZH2XJC26S-K_Ou_JGxz-VOKraG1LecVzTSv93Wg>
    <xmx:XoPZZo23zjsPJWsl4I2F2F1T5hyjzy2LmSgT87IUAQ_08hq_TlvZfw>
    <xmx:XoPZZrLUMmbQGbikzMu-w5pi6Hldo_-V5ChbJZdzIjapy9iLTGhqR0D1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a3a368d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:21 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 18/22] builtin/grep: fix leaking object context
Message-ID: <9fd891f5222163d1cc61281ec9f91e9e35481eeb.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

Even when `get_oid_with_context()` fails it may have allocated some data
in the object context. But we do not release it in git-grep(1) when the
call fails, leading to a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c                 | 1 +
 t/t6132-pathspec-exclude.sh    | 1 +
 t/t6135-pathspec-with-attrs.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index dfc3c3e8bd2..dda4582d646 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1133,6 +1133,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
+			object_context_release(&oc);
 			break;
 		}
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e90..f31c09c056f 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -2,6 +2,7 @@
 
 test_description='test case exclude pathspec'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 120dcd74a51..794bc7daf05 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test labels in pathspecs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
-- 
2.46.0.519.g2e7b89e038.dirty

