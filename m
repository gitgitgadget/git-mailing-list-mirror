Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9E13A87C
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618337; cv=none; b=NyUqEbRikHRV+1mlQJWKxmpCbReZJWS7ReaY8csnS1rRCpiVNc7lbhrf+jF77tfDNkmRWVQJcIlwvZklf5UFMyx7QNMmR8/fbjV0SzUnpidcJ5B6wfd44ZpxKEwBamNcm0exE+g38nCzXDdLMgzPRCHNmKBzBpYTSVhoKcAe3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618337; c=relaxed/simple;
	bh=CaOKLE2CK9G7u392qJvsw2Dbm3caVNaWCGfMUY2S+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Icbmk7+FEvGby4cQUura5TFlOfvlme9fA4zFCeJ5MewK10GGD4/6V/T0SXWP7+YXRn+sa/EO4tPJfb341KRg2OganCE+9hbcPx8eeWWVbIBWpXf2BJm+gBoDdes2VNYjs7ylsWIvrrRDm7okp01J5igWd3bywpYJ//0QfHnDsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HjjEBUQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEsaw4cp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HjjEBUQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEsaw4cp"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 68AFC1151A90;
	Wed, 14 Aug 2024 02:52:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 02:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618335; x=1723704735; bh=7Brhjh8WAs
	xHHK5TQO3EKm2eiNXT7xyJHDErGuFzrck=; b=HjjEBUQXl4DyYVRflGn+KBpkh4
	HxM3CQSVi7lu6B5ZxxhfK80L1br3YEnYc/bZ5RyUqRBgfUUERvgUo33KPPCRtmnx
	HAEm4v0w+6n5712l3M0CK7Dp3iPXmcsiHGDw2oSKe2Rd0ha7dJKq5QztS2N6Xxvt
	MuJwHahI5Dv1C4l9/7qO4hzB1Lk5pGRwuRiHpWDM0dOD/dVq787FEK6DBSfii+1F
	Qa45WBE9FKcil+NvWICBhF+tSWXEGnEWQDv8Gb+/bPb0WJqg4+kqeWr2ozkfLsEH
	lax3O/8mb390FPZAdgUHFBCqox1KT/hFftjLZtyQpJDRs+hrM/lPbaxoQnDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618335; x=1723704735; bh=7Brhjh8WAsxHHK5TQO3EKm2eiNXT
	7xyJHDErGuFzrck=; b=hEsaw4cp0iTiPZa4Yxn9GJ9ZRKYjmmdCFEBR9Mzssu56
	fkmQS7v5vye/Owau2np2QllbHwTJTfkELDDhJMZ6BBe+soWUjCxjb+sPntDuW8PU
	1NdJQz2NrKCQ/LLEP5FhwJ37VUJANGQVdQXst2ku6TYg2ys8C/5HspnD60afPOJz
	xiNG3DKrxvucRM9/V8a31yrFtNgPRpJVDKLZCvEkhOYEsWWcP3Tyz1V1FcjW7NSi
	lRp1P/LEYjWmDuRTkh0nB7dB51+WKtdaO0L0l/Mrqg9dxZCHgFRZ1os7p0N+denx
	AN9julQdfqAN1dB3P5S/xDBZYY0qXW9VjbWwwyvpIQ==
X-ME-Sender: <xms:H1S8Zib578IWfWVWJL57BbMk2Z66943yNDrzDd6RYsfOlNxGq8XqqQ>
    <xme:H1S8ZlZVA4U3ySp0eK2ZdcKfW_oTlXfusXKxNJqwE6KmltS9DYFdHmAvPrrub89K_
    p0ozlaxToz5DfJAKw>
X-ME-Received: <xmr:H1S8Zs_xvtcW1Mo3GW6GDnDvGnu-WDN9YZYE93LVOK_MZiq8R-VwR91QqiIyZit7QppA-1MZcBDRxKATcbIVFDqqL2zLh3ZBdda2dVcRpa0UBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:H1S8ZkpbRBtTKnM-a3sOsotCl78vL99gLjdFHtQTYdZ_mO2_z0CX3A>
    <xmx:H1S8Ztoem5a5yaBYqWoAF7TntBWwhV5y-90GfY67d01m_RUU6mCB8w>
    <xmx:H1S8ZiSbonvgIRFXPg_a176rOrDYam-rHuTxA61DVOwnWbXQDoX7NQ>
    <xmx:H1S8Ztr3a2stYBa5hBmUXDwPMpBATMzgX7k8x7ftXKooP4mK0Ij_GQ>
    <xmx:H1S8ZufzhS8njQ-_myh01ngo1wZFkhdHlJjuRyVTGiaoH9Ji2Vm4h57C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e23f9d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:55 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 07/22] submodule-config: fix leaking name entry when
 traversing submodules
Message-ID: <b7a7f88c7d8abe6f0460df20d37001ec26b6d8e9.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

We traverse through submodules in the tree via `tree_entry()`, passing
to it a `struct name_entry` that it is supposed to populate with the
tree entry's contents. We unnecessarily allocate this variable instead
of passing a variable that is allocated on the stack, and the ultimately
don't even free that variable. This is unnecessary and leaks memory.

Convert the variable to instead be allocated on the stack to plug the
memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 9b0bb0b9f4..c8f2bb2bdd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -899,27 +899,25 @@ static void traverse_tree_submodules(struct repository *r,
 {
 	struct tree_desc tree;
 	struct submodule_tree_entry *st_entry;
-	struct name_entry *name_entry;
+	struct name_entry name_entry;
 	char *tree_path = NULL;
 
-	name_entry = xmalloc(sizeof(*name_entry));
-
 	fill_tree_descriptor(r, &tree, treeish_name);
-	while (tree_entry(&tree, name_entry)) {
+	while (tree_entry(&tree, &name_entry)) {
 		if (prefix)
 			tree_path =
-				mkpathdup("%s/%s", prefix, name_entry->path);
+				mkpathdup("%s/%s", prefix, name_entry.path);
 		else
-			tree_path = xstrdup(name_entry->path);
+			tree_path = xstrdup(name_entry.path);
 
-		if (S_ISGITLINK(name_entry->mode) &&
+		if (S_ISGITLINK(name_entry.mode) &&
 		    is_tree_submodule_active(r, root_tree, tree_path)) {
 			ALLOC_GROW(out->entries, out->entry_nr + 1,
 				   out->entry_alloc);
 			st_entry = &out->entries[out->entry_nr++];
 
 			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
-			*st_entry->name_entry = *name_entry;
+			*st_entry->name_entry = name_entry;
 			st_entry->submodule =
 				submodule_from_path(r, root_tree, tree_path);
 			st_entry->repo = xmalloc(sizeof(*st_entry->repo));
@@ -927,9 +925,9 @@ static void traverse_tree_submodules(struct repository *r,
 						root_tree))
 				FREE_AND_NULL(st_entry->repo);
 
-		} else if (S_ISDIR(name_entry->mode))
+		} else if (S_ISDIR(name_entry.mode))
 			traverse_tree_submodules(r, root_tree, tree_path,
-						 &name_entry->oid, out);
+						 &name_entry.oid, out);
 		free(tree_path);
 	}
 }
-- 
2.46.0.46.g406f326d27.dirty

