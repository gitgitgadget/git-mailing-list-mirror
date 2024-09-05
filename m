Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242419938D
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530974; cv=none; b=j0Kn7LIhqAlMD3F/CHMkGRjAFRIyIhQmzHxCXtU6VRQ/pveY/LkcvQ9VythRQSweK/BXBGAsfd2krQsD7GrHgphyWRb3gfKzU2y4Vm+PDCNO2/naJ5Hrk9Vi5x4wrUAGqLfyszlzPYzla+pqa0QsaZX2G3Ir8Bx7aQOeTXgK2QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530974; c=relaxed/simple;
	bh=UkobPt+kUPJJmSZWlB1xIwYc2IKeEIOwOvTmVu8B42I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCuPZHa+8DTxiYu62AFwhSaaWcsjgawozZ4hEvUY+IEI0hGLJNKrZE7M+jy22k99Z8Df5X+qBMcRVb/C8a4N1W0YPod6rEFHMI63rdvZnFl/PhElEjOiq78SXlOuZkpFV3k0ZguDR8H1E4ayWPww24YFVwXW53qkKrqW16Mwsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFEXgOJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGlfsB9L; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFEXgOJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGlfsB9L"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFA3B1140299;
	Thu,  5 Sep 2024 06:09:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530971; x=1725617371; bh=H3wJk/Ia3P
	bKA2JM4Qw3J5eyt1/rUcKQl7L/vqWfzmY=; b=RFEXgOJ+6wDDNNfhjD/z+tbRE+
	Exd26NyMBGBmvOLVhKoSJKc79Au1Hz4qaZ8n4Zzb2YdrSui12pyxTxxBYWMdz1wG
	xDkYw0/0pPD5M1WkSDF0R1xuyQ3FrHKoe0n9KtpH45VlgP9A94XSE8Soevb3yAFQ
	xJh9b0HLyFbs6XbaghDou/wqq4YJb498MxLDckwGxe5PJgvNxCOZwU6QMVhx5ima
	P/lzU1K8h1O6Vx4tBY3HL5P0h2h/g349qbRtmIKohesUOws/x4baaKdcV+7ea2rX
	PAZDTRXLcQveIKqqOtaQvBM+fjd8QFm3jZ1y902Jc6fJfz+Fi40EAHdnQ/Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530971; x=1725617371; bh=H3wJk/Ia3PbKA2JM4Qw3J5eyt1/r
	UcKQl7L/vqWfzmY=; b=YGlfsB9LCbvhEa1yOVJyXWDKVawGkNGoZA6H1kbPiYXc
	X9WLcHJ0ambXINM2aytHcjThpt9WQftRb9SIxQ/Y/V8XD5oOi5+WX6igzXfl+3ck
	oXpIIJ72JjwIpfBgQwFE4SaX6HGYn+UgcQzpALW6wkw+Qy9DhcHQDTeaP8JRMBQO
	VdaaaQGdmrespXL08bBYDrm7A9pJlIL2TLys2jEcaMhbxX4b7XFRBBLg1iMVnIkv
	oNNUoHjvpOTJW8Z6lydy4m/zgCBLh58Zd9ObBBjK/C1VI5+IoZRKmiHkR9Cd9fN/
	LkW6EHoiBrOL/UNJH3XOKjnk5uh4g1bVtiYvFk+8PQ==
X-ME-Sender: <xms:W4PZZvfi38r4Ms-P6l8uvz3xSPJLSon-yQI-IQDWJKxdoNMtr9zJJQ>
    <xme:W4PZZlOp5zwjpEy6HhXA5lhfU60giqZKNLZNkntfU9AogEdUtcoj1AasQKxp436dV
    09UcAyUz11g08JzDw>
X-ME-Received: <xmr:W4PZZogCqBrg5vAJRczEe9nwQhTUr2s9Gi9nThXaFqed_MjCuPivlWZpCyrL1pumr6MsAxVqle-27WnsIGBtMW_HTSDHIUQFGbFmQJDrJwKdnZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W4PZZg-wEtZQQAm501sfrOKWTFrpAtBnA0nVKNTWf-99JKqxxycm1g>
    <xmx:W4PZZrs0Onz0rQoODo9LdJdy47rpoxqmi7oeWPZZONiy6Mpo489idg>
    <xmx:W4PZZvERc3cU3OV7P5aJkfB1kc5vzadZBTn_GaT-WKZzA29YHh8I1Q>
    <xmx:W4PZZiO75jgOW9jH5PtZyxd_TFcVK_Wz7VIwI4E3X3UZAxmbHGRguA>
    <xmx:W4PZZvjz92W_aDjxxbjKaka1dxNP1mAqyjWys7bH0rKMqhJU1Bqi1pG1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0ed7b24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:19 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 17/22] builtin/pack-objects: plug leaking list of
 keep-packs
Message-ID: <d2e108040fd1064a25bc9cb416d301504529781d.1725530720.git.ps@pks.im>
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

The `--keep-pack` option of git-pack-objects(1) populates the arguments
into a string list. And while the list is marked as `NODUP` and thus
won't duplicate the strings, the list entries themselves still need to
be free'd. We don't though, causing a leak.

Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c   | 1 +
 t/t5616-partial-clone.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c481feadbfa..ab78d72e273 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4641,6 +4641,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
+	string_list_clear(&keep_pack_list, 0);
 	strvec_clear(&rp);
 
 	return 0;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 2da7291e379..467c46dccf6 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -5,6 +5,7 @@ test_description='git partial clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # create a normal "src" repo where we can later create new commits.
-- 
2.46.0.519.g2e7b89e038.dirty

