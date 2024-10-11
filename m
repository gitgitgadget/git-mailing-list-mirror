Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C319CD19
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629653; cv=none; b=qe4Tyguzp5CqJKBAg0A27JqEkcy4SHUPDAKQgnXbtJSNU2V8dPfhqzqyEm5g/3sKgmeOGAS+NWXr6s/nn/oL1fqB0mxnGGkaYVAYYBs6YxABW9x5rcWwEPV0nfV+ChXkfY6PhMLa9VLp91j/AEQq6ltQPp6i4j9cj+YzZEo8h1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629653; c=relaxed/simple;
	bh=Jq4OOEx6wrZz4FlKFvd8rdMWhEwWNZjW5IMH7zFIkvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X8EIonHP2AGCiwNeD+i3s4h01uaFkCdACqw4U76YHDZArYVwKpLWfXbxbgJGpR13Wp+UyBniuLXCIDbvBkUsCz2sste1wbAoCl4RN2xOKTGL34H0O3THurp9aqd8ITvH0FfeDr+QnWyr+XegQi14ccWgze33fCVCbTORj41wlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cVMzaqdD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5XmeehA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cVMzaqdD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5XmeehA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 046121380215;
	Fri, 11 Oct 2024 02:54:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 02:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1728629651; x=1728716051; bh=hqYjUN2uM8jDbhPWsPqUxmYSUEyaA3xt
	KOSpXDLv/no=; b=cVMzaqdDbfSPRYfv3KZZPjnnLPfWuJ0j1YL98mSHbnBj9Uyl
	r7Jd1SoBoxVl0p6aW0DI2xLnSofEbV8SLW9mkB/Zc4aTnotzsFVSZhIIFdPT7oOS
	Oo4/BGgx/ao1M05PhVqa3s3wZO0wWA6AQBM5b0kkufyn1IpS7lWn9Pv6feF3zhyf
	p4+yoEz9gfHIfQy1vgfMPqXltzUoUWwOuFXgt0cN4s9oJhzEQCp+yst1dmqdPwKw
	JxKZlp0FDdKjV1F9Tt4Ffif3zCfn+sA2HK9nPP34Mv+Uj1L8TNaoFdvPCCAQ+NwK
	bM1Z44qkhZtEuXB55q7tQg6BgYvzoJEwEHZfQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728629651; x=1728716051; bh=hqYjUN2uM8jDbhPWsPqUxmYSUEyaA3xtKOS
	pXDLv/no=; b=V5XmeehAvqVJzRVQLbb8E9ZP2fHaqJZr/ZUShnhjhfLCotNwZ61
	F/ES2NE0cmz49168AbQgn3S5KRB9uK/PxGA8n4Y44tm6bUsjpy63lDIp0g+fZBTl
	lU41kyUc4AmlpCWVViqiy/gNiBmG9Uv/N0Xu3lI8tLbWynSZ2eXfIcjer1+Brkgx
	1CEuIxMgHTGkvPsQGaDTg9h8LKJFFXvDGvhowIEQK/yjA8yDJJK7OzIund1cjd6Z
	HlHXshfpf31nMAE/2HRSv3lO0awdSv0CgVnUuciIsgigyiA2tIQJvJlzMX4sbkr5
	Or8+Rnb+BZS79KLqqxMSHFG2FUTRrlSj9sA==
X-ME-Sender: <xms:kssIZ4q8wKz3EhYim_PN0NRmVqG2fo0-NIYJd_YtpWAZ6vEphaM4cw>
    <xme:kssIZ-peonqLhLPizRD5tVbZeEzk8nGa2ML-AXurlOtsYnKw7WBOXpIdwQXfFYFWA
    F9aSx72gvfRkrAH_Q>
X-ME-Received: <xmr:kssIZ9P9gHsPlE7uIiCrA6B8cFvw0-ChHttQI38ZKmlEN2lybnkQjWE5OzFBr9RU5N56nz5CjOpss7FH7aON4kZm2LUFllUveU2G3GSnjsDhocE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeiuedvhfetteelgffhhedtvdehlefhtdffhffhgfeljeef
    vdetfeevledtueeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:kssIZ_4QX7ddFC2LWn1crE18i5ML0T8C9azbchX250RVtO4Xe5lePg>
    <xmx:kssIZ340Kqe_PvzAreL0C4-E6FWp1Dk8RYbNOjGzoM3Cmvt-MuLbcQ>
    <xmx:kssIZ_gpMEFRXVoQ1SpMGURphr9jjHQ67wNP1XRfChNZq65i1vzjLw>
    <xmx:kssIZx5AdDp7e3j4iIxB5sAG-cW_svKJbqf9aBV5nhcC7sR4ei9a6A>
    <xmx:kssIZ3ETDFgB7_3lK1UuSqRQEDqcPnPF1F30fkG56vkkpEph4N-bNodn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d74f29fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:02 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 00/10] reftable: stop using `struct strbuf`
Message-ID: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this is the second patch series on my quest to make the reftable library
become a standalone library again that can be used by libgit2 without
pulling in all kinds of dependencies from the Git codebase. This part
makes us lose the dependency on `struct strbuf`, which is done due to
three reasons:

  - To make us independent of libgit.a.

  - To ensure that we use the pluggable allocators that users can set up
    via `reftable_set_alloc()`.

  - To make it possible to handle memory allocation failures.

While this leads to some duplication, we're only talking about ~70 lines
of code.

Thanks!

Patrick

Patrick Steinhardt (10):
  reftable: stop using `strbuf_addbuf()`
  reftable: stop using `strbuf_addf()`
  reftable/basics: provide new `reftable_buf` interface
  reftable: convert from `strbuf` to `reftable_buf`
  reftable/blocksource: adapt interface name
  t/unit-tests: check for `reftable_buf` allocation errors
  reftable/stack: adapt `format_name()` to handle allocation failures
  reftable/record: adapt `reftable_record_key()` to handle allocation
    failures
  reftable/stack: adapt `stack_filename()` to handle allocation failures
  reftable: handle trivial `reftable_buf` errors

 reftable/basics.c                   |  75 +++++++++-
 reftable/basics.h                   |  19 ++-
 reftable/block.c                    |  61 +++++---
 reftable/block.h                    |  14 +-
 reftable/blocksource.c              |  30 ++--
 reftable/blocksource.h              |   5 +-
 reftable/iter.c                     |   9 +-
 reftable/iter.h                     |   8 +-
 reftable/reader.c                   |  27 ++--
 reftable/record.c                   | 114 ++++++++------
 reftable/record.h                   |  21 +--
 reftable/stack.c                    | 221 ++++++++++++++++++----------
 reftable/system.h                   |   1 -
 reftable/writer.c                   | 102 ++++++++-----
 reftable/writer.h                   |   2 +-
 t/unit-tests/lib-reftable.c         |   4 +-
 t/unit-tests/lib-reftable.h         |   7 +-
 t/unit-tests/t-reftable-basics.c    |  16 +-
 t/unit-tests/t-reftable-block.c     |  53 +++----
 t/unit-tests/t-reftable-merged.c    |  32 ++--
 t/unit-tests/t-reftable-reader.c    |  12 +-
 t/unit-tests/t-reftable-readwrite.c | 134 +++++++++--------
 t/unit-tests/t-reftable-record.c    |  74 +++++-----
 t/unit-tests/t-reftable-stack.c     |  96 ++++++------
 24 files changed, 685 insertions(+), 452 deletions(-)

-- 
2.47.0.dirty

