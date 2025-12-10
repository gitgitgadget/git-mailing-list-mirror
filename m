Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A81DDC3F
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380764; cv=none; b=FNB0543NszQlBXbJWPIpTZ1ahl7Vxg4sqK4RuXl79CgDH3vziZx0rO694DIpR/mDkPaEhy3pn+FerZeO8Fv3fesMoFcg++IwRQaH6eZ4wf1WmLZzZ/2s3aKI0okW1JO4MAA1wg1D6Y7/OqnlTS9aD0fCVPVI4H1L7wbS+Ugpqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380764; c=relaxed/simple;
	bh=v7nzd9yo/KXTfKsbbRyRZ2CYrmFMs80nOVtfCngLb6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=RiVKdTCQppJHp3nmd7UxZFQ+kTO0WsWYJEkctxMSnj+pKANsGnHsv2gVx3pBNylN/2nHCSFaFWJOFF0EcBeqtc/QripBUeOBmvL8dDx4knSc707r4ws/KuC8rYQRkr3sroxTw7fDL6STr0y6SWBElMImWhOZ3HihJ6MvzVNtePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p5zeY1Z/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBCs0nRS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p5zeY1Z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBCs0nRS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9262C1400009;
	Wed, 10 Dec 2025 10:32:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 10:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765380760;
	 x=1765467160; bh=meV91VzBIT61zcmA7axb8t0Y9Yrqz4eBZzTGqhkpWyg=; b=
	p5zeY1Z/UnAJdzUjfiW45XDngeionM9nfD33yhVIxUoQf/qFit/m9NPN/lTPz5hQ
	0DwiUOmmQty2vm5ZeFCbw++zF1nI3M49awog4HIm4VSvelynvzlnDX6jNe/73+Gg
	usK2CRafcDKMTpHI303amNd73GAV5s8pGT6EhglhbHLwxujDUrfhgOvpqa0XrGbM
	BTmrpLdp/FNv/z/iiYGy90FhZtxdagxZ93ECZSU3uK322K5QVsAEcE0hVfa1uAJh
	xRKHclsBfribW/w5lWvQ6E8IkRQTTAuiMNqcPKdwAl3EHRsLraUux/OGFqioPbNa
	d4hnJ34M+UWnWNzBWPmjyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765380760; x=
	1765467160; bh=meV91VzBIT61zcmA7axb8t0Y9Yrqz4eBZzTGqhkpWyg=; b=t
	BCs0nRSCMMvedHrV3VPFY0VjKPw/wfR3RsGwJP9/Ii3bwUmDcHajYq747/mTnkVO
	vVKnVvaWsSw00PiPSN29YuwkZ71CFkyxXSmFTBGZPD/JdHna3dti/1QxrHdSF0j1
	FM5lJb9/0skEjkFTXpI5hTjpc2Ka0OZj/pmIfKDNSPEC45g6H5f/raFTeBw7YtoL
	3FoNVDQTszx+Ln2dgMhcJ/8neA3VbsCsdQbjVS8+/9HtmVkMYGSQUc4SuR5tiBpS
	wQkbBwdzOJ8K6DP2U2kb5XDUQxEiSC3TlMdjfrH28hJ8eJ5ifgiMhEcyIdOk+djT
	dtvTgUVGbL7ch9O7ZYBOg==
X-ME-Sender: <xms:mJI5aX5FB9sMqAfCr6SctaxMOe5sRnk4v__nGH430Ts_gbpEdz9KMw>
    <xme:mJI5aS5qQ_dif72A8jwN_S3Xd0gErlzRwBpxMXwNw5jl5eOKXd6FFOVQPvPZFT6JE
    7NnA3NGch1OwnuXV58JbsqNeIfWYG1CuqaL6aeRhitPLDyFmrqPzg>
X-ME-Received: <xmr:mJI5acF_ytNDbREzEuYWk4sd_JmXj3gCf4Ta-X32p3Jp09YL3kfHTL4kTB6nbDd_X6Itgne-oUA3pc7H2eGCdrrkPz7PEx3LwkZsbaMA1ZTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mJI5aTQUxmcNf0P9thOCXd6r8BtfrTbcUBWl7gj7bgi-Rialzk2vKw>
    <xmx:mJI5advPM8dHozGhvvk5JQGKJCABT65V5h2otqbVTLamCZaFtGRy4g>
    <xmx:mJI5aawtSoPxE_-ZhuIBtzpQvPXO3oG9bTaz5t9nH42-k6k11Xv_jA>
    <xmx:mJI5af6swqnQj6uYBj4m-DhRXvRMrEPWUOYaOp3wEmBdlYb0kjaz0w>
    <xmx:mJI5aVroZYGw-6mvZXI60pRa1MPjae_26JQamSEwbsyk7yijlbEUjInU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:32:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 412f6b74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 15:32:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] Refactor handling of alternates to work via sources
Date: Wed, 10 Dec 2025 16:32:33 +0100
Message-Id: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKSOWkC/4WNywrCMBBFf6Vk7UgSrQ2u/A/pIo/RDmpTMjEop
 f9uLLh2eS6Xc2bBmAhZHJtZJCzEFMcKetMIP9jxikChstBSt0rLA7g9TDeGGBzYe8Y02owMhSx
 wfCaPYKQOpvPOBduKqpkSXui1Js595YE4x/Rei0V915/c/JcXBRKwQ+eMU8bL3an+t/QQ/bIsH
 zY8innNAAAA
X-Change-ID: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series refactors how we handle alternate object directories
so that the interface is structured around the object database source.

Next to being simpler to reason about, it also allows us to eventually
abstract handling of alternates to use different mechanisms based on the
specific backend used. In a world of pluggable object databases not
every backend may use a physical directory, so it may not be possible to
read alternates via "objects/info/alternates". Consequently, formats may
need a different mechanism entirely to make this list available.

Changes in v2:
  - Rename `odb_add_source()` to `odb_add_alternates_recursive()` to
    highlight that this function is recursive.
  - Link to v1: https://lore.kernel.org/r/20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (8):
      odb: refactor parsing of alternates to be self-contained
      odb: resolve relative alternative paths when parsing
      odb: move computation of normalized objdir into `alt_odb_usable()`
      odb: adapt `odb_add_to_alternates_file()` to call `odb_add_source()`
      odb: remove mutual recursion when parsing alternates
      odb: drop forward declaration of `read_info_alternates()`
      odb: read alternates via sources
      odb: write alternates via sources

 odb.c | 307 ++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 149 deletions(-)

Range-diff versus v1:

1:  18b0d15865 = 1:  392036039f odb: refactor parsing of alternates to be self-contained
2:  aaf9d4e162 ! 2:  0107d40816 odb: resolve relative alternative paths when parsing
    @@ Commit message
         cannot be resolved to a directory then `alt_odb_usable()` still knows to
         bail out.
     
    -    While at it, rename the function to `odb_add_source()` to more clearly
    -    indicate what its intent is and to align it with modern terminology.
    +    While at it, rename the function to `odb_add_alternate_recursively()` to
    +    more clearly indicate what its intent is and to align it with modern
    +    terminology.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ odb.c: static struct odb_source *odb_source_new(struct object_database *odb,
     -					     const char *dir,
     -					     const char *relative_base,
     -					     int depth)
    -+static struct odb_source *odb_add_source(struct object_database *odb,
    -+					 const char *source,
    -+					 int depth)
    ++static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
    ++							const char *source,
    ++							int depth)
      {
      	struct odb_source *alternate = NULL;
     -	struct strbuf pathbuf = STRBUF_INIT;
    @@ odb.c: static void link_alt_odb_entries(struct object_database *odb, const char
      
      	for (size_t i = 0; i < alternates.nr; i++)
     -		link_alt_odb_entry(odb, alternates.v[i], relative_base, depth);
    -+		odb_add_source(odb, alternates.v[i], depth);
    ++		odb_add_alternate_recursively(odb, alternates.v[i], depth);
      
      	strvec_clear(&alternates);
      }
    @@ odb.c: struct odb_source *odb_add_to_alternates_memory(struct object_database *o
      	 */
      	odb_prepare_alternates(odb);
     -	return link_alt_odb_entry(odb, dir, NULL, 0);
    -+	return odb_add_source(odb, dir, 0);
    ++	return odb_add_alternate_recursively(odb, dir, 0);
      }
      
      struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
3:  077480d200 ! 3:  8b918fec33 odb: move computation of normalized objdir into `alt_odb_usable()`
    @@ odb.c: static int alt_odb_usable(struct object_database *o, const char *path,
      }
      
      /*
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    - 					 int depth)
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
    + 							int depth)
      {
      	struct odb_source *alternate = NULL;
     -	struct strbuf tmp = STRBUF_INIT;
    @@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
      		goto error;
      
      	alternate = odb_source_new(odb, source, false);
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
      	read_info_alternates(odb, alternate->path, depth + 1);
      
       error:
4:  f536d0afc3 = 4:  618bfedf22 odb: adapt `odb_add_to_alternates_file()` to call `odb_add_source()`
5:  0930371378 ! 5:  50e93145e4 odb: remove mutual recursion when parsing alternates
    @@ Commit message
         Refactor the function to remove the mutual recursion between adding
         sources and parsing alternates. The parsing step thus becomes completely
         oblivious to the fact that there is recursive behaviour going on at all.
    -    Instead, the recursion is handled exclusively by `odb_add_source()`,
    +    The recursion is handled by `odb_add_alternate_recursively()` instead,
         which now recurses with itself.
     
         This refactoring allows us to move parsing of alternates into object
    @@ odb.c: static bool odb_is_source_usable(struct object_database *o, const char *p
      
      static struct odb_source *odb_source_new(struct object_database *odb,
      					 const char *path,
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    - 					 int depth)
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
    + 							int depth)
      {
      	struct odb_source *alternate = NULL;
     +	struct strvec sources = STRVEC_INIT;
      	khiter_t pos;
      	int ret;
      
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
      	kh_value(odb->source_by_path, pos) = alternate;
      
      	/* recursively add alternates */
    @@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
     +		      source);
     +	} else {
     +		for (size_t i = 0; i < sources.nr; i++)
    -+			odb_add_source(odb, sources.v[i], depth + 1);
    ++			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
     +	}
      
       error:
    @@ odb.c: static void parse_alternates(const char *string,
     -	parse_alternates(alt, sep, relative_base, &alternates);
     -
     -	for (size_t i = 0; i < alternates.nr; i++)
    --		odb_add_source(odb, alternates.v[i], depth);
    +-		odb_add_alternate_recursively(odb, alternates.v[i], depth);
     -
     -	strvec_clear(&alternates);
     -}
    @@ odb.c: static void read_info_alternates(struct object_database *odb,
      	strbuf_release(&buf);
      	free(path);
      }
    +@@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
    + 		if (commit_lock_file(&lock))
    + 			die_errno(_("unable to move new alternates file into place"));
    + 		if (odb->loaded_alternates)
    +-			odb_add_source(odb, dir, 0);
    ++			odb_add_alternate_recursively(odb, dir, 0);
    + 	}
    + 	free(alts);
    + }
     @@ odb.c: int odb_for_each_alternate(struct object_database *odb,
      
      void odb_prepare_alternates(struct object_database *odb)
    @@ odb.c: int odb_for_each_alternate(struct object_database *odb,
     +	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
     +	read_info_alternates(odb->sources->path, &sources);
     +	for (size_t i = 0; i < sources.nr; i++)
    -+		odb_add_source(odb, sources.v[i], 0);
    ++		odb_add_alternate_recursively(odb, sources.v[i], 0);
      
     -	read_info_alternates(odb, odb->sources->path, 0);
      	odb->loaded_alternates = 1;
6:  be857d1b09 ! 6:  d397255cdb odb: drop forward declaration of `read_info_alternates()`
    @@ odb.c: static bool odb_is_source_usable(struct object_database *o, const char *p
     -	return source;
     -}
     -
    --static struct odb_source *odb_add_source(struct object_database *odb,
    --					 const char *source,
    --					 int depth)
    +-static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
    +-							const char *source,
    +-							int depth)
     -{
     -	struct odb_source *alternate = NULL;
     -	struct strvec sources = STRVEC_INIT;
    @@ odb.c: static bool odb_is_source_usable(struct object_database *o, const char *p
     -		      source);
     -	} else {
     -		for (size_t i = 0; i < sources.nr; i++)
    --			odb_add_source(odb, sources.v[i], depth + 1);
    +-			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
     -	}
     -
     - error:
    @@ odb.c: static void read_info_alternates(const char *relative_base,
     +	return source;
     +}
     +
    -+static struct odb_source *odb_add_source(struct object_database *odb,
    -+					 const char *source,
    -+					 int depth)
    ++static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
    ++							const char *source,
    ++							int depth)
     +{
     +	struct odb_source *alternate = NULL;
     +	struct strvec sources = STRVEC_INIT;
    @@ odb.c: static void read_info_alternates(const char *relative_base,
     +		      source);
     +	} else {
     +		for (size_t i = 0; i < sources.nr; i++)
    -+			odb_add_source(odb, sources.v[i], depth + 1);
    ++			odb_add_alternate_recursively(odb, sources.v[i], depth + 1);
     +	}
     +
     + error:
7:  a811f6abd6 ! 7:  a39997318c odb: read alternates via sources
    @@ odb.c: static void parse_alternates(const char *string,
      
      	strbuf_release(&buf);
      	free(path);
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
      	kh_value(odb->source_by_path, pos) = alternate;
      
      	/* recursively add alternates */
    @@ odb.c: void odb_prepare_alternates(struct object_database *odb)
     -	read_info_alternates(odb->sources->path, &sources);
     +	odb_source_read_alternates(odb->sources, &sources);
      	for (size_t i = 0; i < sources.nr; i++)
    - 		odb_add_source(odb, sources.v[i], 0);
    + 		odb_add_alternate_recursively(odb, sources.v[i], 0);
      
8:  be62ab52ab ! 8:  082eb43b82 odb: write alternates via sources
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb.c ##
    -@@ odb.c: static struct odb_source *odb_add_source(struct object_database *odb,
    +@@ odb.c: static struct odb_source *odb_add_alternate_recursively(struct object_database *
      	return alternate;
      }
      
    @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
     -		if (commit_lock_file(&lock))
     -			die_errno(_("unable to move new alternates file into place"));
     -		if (odb->loaded_alternates)
    --			odb_add_source(odb, dir, 0);
    +-			odb_add_alternate_recursively(odb, dir, 0);
     +		fprintf_or_die(out, "%s\n", alternate);
     +		if (commit_lock_file(&lock)) {
     +			ret = error_errno(_("unable to move new alternates file into place"));
    @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
     +	if (ret < 0)
     +		die(NULL);
     +	if (odb->loaded_alternates)
    -+		odb_add_source(odb, dir, 0);
    ++		odb_add_alternate_recursively(odb, dir, 0);
      }
      
      struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,

---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5

