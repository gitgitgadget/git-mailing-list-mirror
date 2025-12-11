Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FF201004
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445421; cv=none; b=gQo3Fys14vE+uTlOnwICTShQG/FGtiZaeTlbJbFVAQrzyDgUOk1EZw7Ofy/M6Aw0rXXqT9qqJyluBNiXO7ntFY7EEBcnn7vCXNYVeuO5WfR/6oiUo8NABoMSrqo0H16J2NGYuRifGnkc9gBHB4c+MGtSVIX6O5fYSqYvBDFzCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445421; c=relaxed/simple;
	bh=KjjKl6abPWQwlpceVbgIAfcXrMgohtgw5sgsGCBd2ZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mP97ODnjKZBYJiM4MJTz47LoLk9CGpuzpbsVJcwp8TCA4P3vwYbtOzUOe0zkf88wsqA2z5yo2VL/mA3Jqxuf/M+ni37aeeLRp/bYdy6IeffopegYlcgXGK3n6dYjKj5vctNn6+Hk/lEenS+ak7smC8/RFKRaP3hP6cWXxx6ftmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s9QX6gns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNeGV0jb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s9QX6gns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNeGV0jb"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B66771D0018D;
	Thu, 11 Dec 2025 04:30:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 11 Dec 2025 04:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445416;
	 x=1765531816; bh=FHnH82U0ADwL60wvqKuk/z9f8FEUubjqh2IBsPFsoms=; b=
	s9QX6gns4q4v1YoJUkVHhzODLRFsG+bXUSvyePqno1vYzhjYv+r974rK53m+HVB1
	Ic9LGG6vhL5++wGnh2x+3JXBqiY7ef2lQ/NFH2cGpZWCzmlIO5/hw+lasl7VJ3Ww
	DQTGoF4wk2ZVhf1ud65GOt6oSmJTq0kyDcPC5iwJFqhPh7cnd/eQJkUZeXbSJQKZ
	JDqfVLLe2pypgmVQilGpeTFlS+rjH1MYtuaYuJHkVGaSYKB6OitfcYuyKHP/ptev
	gm/paWIlNl2n4O91uxmV7yXJ5jc8DebYVwbx9l36KVNIf8fQmoqqChbuzbmuTwjS
	0ChIPYUh4I2su78pgFKA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445416; x=
	1765531816; bh=FHnH82U0ADwL60wvqKuk/z9f8FEUubjqh2IBsPFsoms=; b=L
	NeGV0jb9Ye27aJ1QCKsRQ9XrMGEZYgGPoeCi6R5NE1Feblqk1te78HwPVX0Mbc62
	y/bKiJrWRiKH+/oj7aftVPL4Fq6GCc7BewXIMMAaBLT4MvC+BIkdPde/UJija0Rc
	4LmvprCRIsLKNgNp+azlSKqINSnUM02HbvQEJX+xBBSaqtQB4MotxP7nCtZaoPM2
	DTEb6Zum67VT1+9/JFMfzIMyrRbcHWn0RQxexQQJZ1DBmPI08AjaXt60V12oAxVE
	R+AHhvgCvNP4C3uSmQgWCTj1xnOcy1KYrvWclLcoQ/4hZLlUzwefKHcxeA1vRmwe
	2zFtUjzhEtQ4m34ZJpFpQ==
X-ME-Sender: <xms:KI86aTZiV036FoF0m5EQgBmw3RzsS_d9abo-NTKfijeiC5lZl0D5fA>
    <xme:KI86aZ1MC4ACqbRAuJcmEUES5X6ZmXGbJ50hYZtuJblzY9REX1b9gogsitfLGKzWZ
    5i8ww77KK8ke-sImyQDM0QMzDxqa9hQbVMjRl9-2njIbu4RQlyg8g>
X-ME-Received: <xmr:KI86aTW13qYYHryXivL_iAVegF-c-mPguT36-ajKWo85w5cuQSL1P86Mh0ZsjaKxtwKjDuDZzfLbtUibtYkFgal4hJ4yCJAOGECKEypmfTMP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KI86aTVJRw_QB-KLnIEhbBtp9q0S3qdIkwoQuxb7J4FufZNI3zZMZQ>
    <xmx:KI86aSdFXWr8jgaML9BZyu6W9jZD-kY_N8cNO4YjwICIv4tyXW9FWw>
    <xmx:KI86acX8XLIpwSCqy9U4V8bhKp9nR5ukoRKapZHIv5jFTM08FncKZg>
    <xmx:KI86abenH8a-7NoNhGezO4hEPCs_lRkWp8c7CZRMVbOecwXnt25g4w>
    <xmx:KI86abTmjT3Ss9IkX8ZD1ssXuq5ocuG6ugzk1wCTjhgNN9AMD31aNTAl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30d2f74f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] Refactor handling of alternates to work via sources
Date: Thu, 11 Dec 2025 10:30:09 +0100
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKPOmkC/43NTQ6CMBCG4auQrh3TH4HqynsYF50ySqNS0mKjI
 dzdQqJxp8t3Mnm+kUUKjiLbFSMLlFx0vsuhVgWzrenOBK7JzSSXpZC8AtxAf4ngGwRzHSh0ZqA
 IyRmI/h4sgeay0bVFbEzJMtMHOrnHMnE45m5dHHx4LotJzNc3rn/jSQAHqglRo9CWq33+X7sbm
 +UkvzTB/9DkrKFSlRblaWvwo03T9AKIZb5FGwEAAA==
X-Change-ID: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

Changes in v3:
  - Fix commit messages that still refer to `odb_add_source()`.
  - Fix intermediate commit that still refers to `odb_add_source()`.
  - Link to v2: https://lore.kernel.org/r/20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im

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
      odb: stop splitting alternate in `odb_add_to_alternates_file()`
      odb: remove mutual recursion when parsing alternates
      odb: drop forward declaration of `read_info_alternates()`
      odb: read alternates via sources
      odb: write alternates via sources

 odb.c | 307 ++++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 149 deletions(-)

Range-diff versus v2:

1:  74d2596ef6 = 1:  4a85139a75 odb: refactor parsing of alternates to be self-contained
2:  16d6e482d7 = 2:  1b16c0a164 odb: resolve relative alternative paths when parsing
3:  16cce7f52e = 3:  ceb6e8494c odb: move computation of normalized objdir into `alt_odb_usable()`
4:  b8a7138a51 ! 4:  99dbd11c48 odb: adapt `odb_add_to_alternates_file()` to call `odb_add_source()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: adapt `odb_add_to_alternates_file()` to call `odb_add_source()`
    +    odb: stop splitting alternate in `odb_add_to_alternates_file()`
     
         When calling `odb_add_to_alternates_file()` we know to add the newly
         added source to the object database in case we have already loaded
    @@ Commit message
         callers only ever pass a single directory to it. It's thus entirely
         surprising and a conceptual mismatch.
     
    -    Fix this issue by directly calling `odb_add_source()` instead.
    +    Fix this issue by directly calling `odb_add_alternate_recursively()`
    +    instead.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
      			die_errno(_("unable to move new alternates file into place"));
      		if (odb->loaded_alternates)
     -			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
    -+			odb_add_source(odb, dir, 0);
    ++			odb_add_alternate_recursively(odb, dir, 0);
      	}
      	free(alts);
      }
5:  2b2d4788bf ! 5:  b9300667a6 odb: remove mutual recursion when parsing alternates
    @@ Commit message
     
           2. `link_alt_odb_entries()` calls `parse_alternates()`.
     
    -      3. We then add each parsed alternate via `odb_add_source()`.
    +      3. We then add each alternate via `odb_add_alternate_recursively()`.
     
    -      4. `odb_add_source()` calls `link_alt_odb_entries()` again.
    +      4. `odb_add_alternate_recursively()` calls `link_alt_odb_entries()`
    +         again.
     
         This flow is somewhat hard to follow, but more importantly it means that
         parsing of alternates is somewhat tied to the recursive behaviour.
    @@ odb.c: static void read_info_alternates(struct object_database *odb,
      	strbuf_release(&buf);
      	free(path);
      }
    -@@ odb.c: void odb_add_to_alternates_file(struct object_database *odb,
    - 		if (commit_lock_file(&lock))
    - 			die_errno(_("unable to move new alternates file into place"));
    - 		if (odb->loaded_alternates)
    --			odb_add_source(odb, dir, 0);
    -+			odb_add_alternate_recursively(odb, dir, 0);
    - 	}
    - 	free(alts);
    - }
     @@ odb.c: int odb_for_each_alternate(struct object_database *odb,
      
      void odb_prepare_alternates(struct object_database *odb)
6:  3294336d85 = 6:  1e3a1fb081 odb: drop forward declaration of `read_info_alternates()`
7:  55ba5815d4 = 7:  1d6a9b3c1b odb: read alternates via sources
8:  225bcc37de ! 8:  79a053fb2b odb: write alternates via sources
    @@ Commit message
         allow us to have different logic for writing alternates depending on the
         backend used.
     
    -    Note that after the refactoring we start to call `odb_add_source()`
    -    unconditionally. This is fine though as we know to skip adding sources
    -    that are tracked already.
    +    Note that after the refactoring we start to call
    +    `odb_add_alternate_recursively()` unconditionally. This is fine though
    +    as we know to skip adding sources that are tracked already.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     

---
base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
change-id: 20251206-b4-pks-odb-alternates-via-source-802d87cbbda5

