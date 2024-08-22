Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E31D12EA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308482; cv=none; b=mkHkvRYprBiVzhvUeUwC2q8MG6KpPw7FX2FfG7nhQnIEX8QElYTCqdsaBgAYNuAA0ClYaA/cbhZ6yUey+WjBRDcNe1Tav61A8qJQ/BC29let/ucLHgILYvaWyfgzqicxm8e+YXAvQXMvIBN75xb3xRrEkh6eGtFI7/cYkchXcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308482; c=relaxed/simple;
	bh=d6+TSJaWxtoKpbfSvSKidADxB64icz0ZxylZ7uh5nX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAk7e5TKHhBejpZvz+cq7evdKtSrgC6ieuTMs9oGRk4PK3kagxFv1S/HIxJ9TjJcxndq1cvaPHesprLk1BaRoV7xaOcH99uXemTNdYBbVLxvNo/BRB8Oeo15mhg9my205T4nXAxgudzDZN6Ex8tvmjgVVm+ABfHgmdeuFBOELuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CAw0eKIZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImGHQyXC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CAw0eKIZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImGHQyXC"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2857138FC16;
	Thu, 22 Aug 2024 02:34:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 02:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308479; x=1724394879; bh=r0nyzQo7l8
	mAtK9UfcVpkhaqmQ+rXR9us+dh7yGLe/s=; b=CAw0eKIZBXsh1YOcUHGEt26YYO
	dTuhxK2vGNF9WVdBZRHkKgzHdiMa0oMm3lrz9w1VIpslJBix1qZlDPNCkpHxFRrq
	aJw3MdNgQDhvJAV9AMxs5lKcGmgQGE6PQrc/Ev5ApvzKWrvtKtiT7ApTnYHHXbxP
	PQ578XXJq6i74DQDMxcjiubmLjjNIqqjqjbnBPdyExjh9ww0HnFqr1zvosT9ErMj
	3ezcUbmnQt9/Iuig8ingVoCeTl3luaxeWoWSeWMbDq/127VlS1dPH2efeJYTK7ub
	GogKI86gh6fQCMZK3EPXOSxPzG1qWZjU+0xTYa9VAyJzBUMfWep6Tov29DkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308479; x=1724394879; bh=r0nyzQo7l8mAtK9UfcVpkhaqmQ+r
	XR9us+dh7yGLe/s=; b=ImGHQyXCFI6V1YiCi1WMmSQ0kmnfu9EECu7kesi2Vxod
	f4wBQeCOMICC5hdPI3nUZXBoFLBeKEZBZ0uriIEGurZ7BtmSk9r2HqVq7wXbHJlI
	YfuoFOy1Ddq3LOYpC8+QJPh9sNEmrHYp9k4bkAcVsj/T8PURpdJT6jR1s5rdqXiw
	AZa5t6Y0SwRDR7dgd5sHD29nkWbLLsIbYJZa+MSjx9XxiIywiPzKMIM7FdCKjUIU
	jm6kvR4UBjsMUq+CVvKOe7Zol9giL9z3PBM1EYA/0WftZz34d4cvuc3H7nA/WLQi
	5UaPWlwLanf8DQLkmGE4LZQe8anOot9zg8KQq8TfaA==
X-ME-Sender: <xms:_9vGZscOkg7fjVQQYn6OeaX3hROhFKpZpFoUuRjHeattmyHTQ4Vn1g>
    <xme:_9vGZuMw4eYhitPGLhctrQe7lF98ESGos1jz3mGVF5bZCCQFyr0bwFIWehFMeOZ1Y
    1gYqLgXASeSTLkW0A>
X-ME-Received: <xmr:_9vGZtgacoLwJZAfacwX4QDapDWLXhmDMhynan9nkpKBPRKSWq_2V33wz-qbkhts8lz4uYhJfSTSha_cP_CZN8Syg8MsLLDytfp1Flzwyj350kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_9vGZh_qtmLvyq-kf_oXfuG6-40UsgNM_sy-CPz-4IxnoTE_WE5OTQ>
    <xmx:_9vGZotNEVGZZwA6UAGu476sMx03_NXOLxmZHSa6YVoW1UTC6m86Yw>
    <xmx:_9vGZoGCE5e1l0iBwBrXG-zF7t7CGLZj4hY0okTO1C_KIH48TeLE0g>
    <xmx:_9vGZnMIGHoib93Q5GJxYi1lzdIzeIXZuJgg0SZDwH3BjtWiib_Oxw>
    <xmx:_9vGZkJX33iQrHiSJen1SWphyH9PGmxF3pPfX-bwdDshlWDQxF1-IR4z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3905f5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:03 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 00/15] reftable: drop generic `reftable_table` interface
Message-ID: <cover.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

Hi,

this is the third version of my patch series that gets rid of the
generic `reftable_table` interface. It made it way harder to understand
the reftable code base and is not really required nowadays anymore where
we have generic re-seekable reftable iterators.

There is only a single change compared to v2, which updates one of the
commit messages to explain why it is fine to drop tests for the printing
functionality.

This patch series continues to build on top of 25673b1c47 (The third
batch, 2024-08-07) with Junio's ps/reftable-stack-compaction at
f234df07f6 (reftable/stack: handle locked tables during auto-compaction,
2024-08-08) merged into it.

Thanks!

Patrick

Patrick Steinhardt (15):
  reftable/merged: expose functions to initialize iterators
  reftable/merged: rename `reftable_new_merged_table()`
  reftable/merged: stop using generic tables in the merged table
  reftable/stack: open-code reading refs
  reftable/iter: drop double-checking logic
  reftable/generic: move generic iterator code into iterator interface
  reftable/dump: drop unused `compact_stack()`
  t/helper: inline `reftable_dump_main()`
  t/helper: inline `reftable_reader_print_file()`
  t/helper: inline `reftable_stack_print_directory()`
  t/helper: inline `reftable_table_print()`
  t/helper: inline printing of reftable records
  t/helper: use `hash_to_hex_algop()` to print hashes
  t/helper: refactor to not use `struct reftable_table`
  reftable/generic: drop interface

 Makefile                         |   2 -
 reftable/dump.c                  | 111 ---------------
 reftable/generic.c               | 229 -------------------------------
 reftable/generic.h               |  37 -----
 reftable/iter.c                  | 126 ++++++++++++++---
 reftable/iter.h                  |  30 +++-
 reftable/merged.c                |  72 ++++------
 reftable/merged.h                |   4 +-
 reftable/reader.c                |  70 +---------
 reftable/reader.h                |   4 +
 reftable/record.c                | 127 -----------------
 reftable/record.h                |   1 -
 reftable/reftable-generic.h      |  47 -------
 reftable/reftable-merged.h       |  26 ++--
 reftable/reftable-reader.h       |   9 --
 reftable/reftable-record.h       |   8 --
 reftable/reftable-stack.h        |   3 -
 reftable/reftable-tests.h        |   1 -
 reftable/stack.c                 |  94 ++++++-------
 reftable/stack_test.c            |  29 ++--
 t/helper/test-reftable.c         | 189 ++++++++++++++++++++++++-
 t/unit-tests/t-reftable-merged.c |  17 +--
 22 files changed, 422 insertions(+), 814 deletions(-)
 delete mode 100644 reftable/dump.c
 delete mode 100644 reftable/generic.c
 delete mode 100644 reftable/generic.h
 delete mode 100644 reftable/reftable-generic.h

Range-diff against v2:
 1:  472c169b501 =  1:  472c169b501 reftable/merged: expose functions to initialize iterators
 2:  bc6f1cd8c1b =  2:  bc6f1cd8c1b reftable/merged: rename `reftable_new_merged_table()`
 3:  58e91ab4b34 =  3:  58e91ab4b34 reftable/merged: stop using generic tables in the merged table
 4:  6ba3fcee411 =  4:  6ba3fcee411 reftable/stack: open-code reading refs
 5:  cac08a934c5 =  5:  cac08a934c5 reftable/iter: drop double-checking logic
 6:  103262dc79c =  6:  103262dc79c reftable/generic: move generic iterator code into iterator interface
 7:  4011fa65d81 =  7:  4011fa65d81 reftable/dump: drop unused `compact_stack()`
 8:  ceaa296bfd4 =  8:  ceaa296bfd4 t/helper: inline `reftable_dump_main()`
 9:  a62e4612e97 =  9:  a62e4612e97 t/helper: inline `reftable_reader_print_file()`
10:  7acfe4fecc5 ! 10:  242c179df5f t/helper: inline `reftable_stack_print_directory()`
    @@ Commit message
         Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
         This follows the same reasoning as the preceding commit.
     
    +    Note that this requires us to remove the tests for this functionality in
    +    `reftable/stack_test.c`. The test does not really add much anyway,
    +    because all it verifies is that we do not crash or run into an error,
    +    and it specifically doesn't check the outputted data. Also, as the code
    +    is now part of the test helper, it doesn't make much sense to have a
    +    unit test for it in the first place.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/reftable-stack.h ##
11:  8bd53a1a656 = 11:  a05e2060996 t/helper: inline `reftable_table_print()`
12:  c50aabbb804 = 12:  ee22a08e11e t/helper: inline printing of reftable records
13:  5498395872c = 13:  0a3c619e842 t/helper: use `hash_to_hex_algop()` to print hashes
14:  5390be75c37 = 14:  8eab399dfc6 t/helper: refactor to not use `struct reftable_table`
15:  5aeab8ee077 = 15:  b5d7b5679b5 reftable/generic: drop interface
-- 
2.46.0.164.g477ce5ccd6.dirty

