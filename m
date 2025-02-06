Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD3226523
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828359; cv=none; b=ATux3muvwzvtU83tFvZRhUOP240RbSqzNisdLbuKEYs/z5e8IP03pQMi1CW1+tkIlDXi1kaMVVNDtAhFZvMUaGT1nmcfVeQD6zXxw474j37wqhOGUCFhkn/wmJyo9coj5OLnZl+bm5vxXdjH0OPMblEMn7GU5JXhDcMpCTOZi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828359; c=relaxed/simple;
	bh=UZSyDGHmyvtglQ5JWIG+H3n9BOt/hfmR8oI12SvqJoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTLakkPcs01zHKd9oDt3X+Gy287PdSDV23d1yddUx7vJtHK7W96nlTcyQBBb7yHcsXxG07r/sAbXaXMGolDNsyo0IVhZ6SIksjHNCJaYPf+uir60ZXiJAJcYHX/7pvHhCcu7Vr9Q3pongBOWZLd6f08mXZwDqYsU5H4lLphmqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oHGuR6O/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anqSqlRv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oHGuR6O/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anqSqlRv"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CB4B114006D;
	Thu,  6 Feb 2025 02:52:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 02:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828357;
	 x=1738914757; bh=0cll7B6pvDOi+gm1xYCTi3Yl2LtzE0zaIQ/Na/k6dpc=; b=
	oHGuR6O/SstL7L2fXEblRqYtL/k+21aOmHgLXD8llvGl4LpNadVjgaIWYpBQB/hm
	YiXbJFJShbZoK/0gV7DiZtqtKUqnA3vxyiWRt3VozdH3J6ME5I+cymbrXZ7TPBoj
	73xv2QbmYJAc5/wbdsdsmfdSmsQ7Me0wwN63ud1YwUHUaS5cmNBeuanFP4d9Nwce
	bBrUZuLo2uoTR0MQHbvCzSOEfHS9oqSQxKkfXTDA+Uy7m0msvZPArJvRc51t/20z
	ri4zDDy4yC6Yy11KqyccuccMXUDi2KAgPxgu1/izhfJ8PsjqQC2YntsO2+fUsUYf
	Zo2eKJ326lyeE+Whkuw7kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828357; x=
	1738914757; bh=0cll7B6pvDOi+gm1xYCTi3Yl2LtzE0zaIQ/Na/k6dpc=; b=a
	nqSqlRvcUwVL6+AiIlUNHzc0Qa/8Owch7kBnt2Eg/pk8utzqOCdzwMTqKTuH1Mb+
	3+zjBN9Dy/mTaEBYveH/kMSpbEZIlvTMWl1p4umIbu9itcbwVMxQuaIZWLFiWIS5
	Av8mIQ9hJ+ID/67RK18+rVlwVvHdhDk8WPrVIuPdeQkyhBEuw3uwbppVAr0Lplh7
	vGf9NRtwdx6AUsCba1TrQgZdyrncqSQ9wLWDlS+SgVTRrjrwgccf3nAToIme1qla
	kUJiX6tnwPVNCg/96rBwCoCVsVQQdxzEE+gx8kedbHDwiNuV3yjbo7bGYy0njbIn
	uKJeYfxAOpskUwv3aIaPw==
X-ME-Sender: <xms:RWqkZyhxC2A109Y9jqQWunbTrxS55kFRkzvE5QEYp4cQqBLmz73M3w>
    <xme:RWqkZzA6X3VgGEz0sj4TPk4d0qyTC_dHWkVsPhAq0r8DM3u72JVkkjGiu40ikFR1C
    MTIfp9GI3fwxoG4EQ>
X-ME-Received: <xmr:RWqkZ6E-c8OMaWTGHzF3-JffjieptDpvJWGTopP8Obx7si2_6WC_58fF7dHyCS--cUxmTYIVdoNlB3Ske7IfqKqWIcy1-Z3Y66SrtJZxhlBj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjiehtse
    hkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RWqkZ7S8pWE7lUsBImSeZjvF48uYX2-kTynZAxW17MFuVm8ja3Zilw>
    <xmx:RWqkZ_zUTsXqkGgPUWOkmmLZds8xp-FB9aQ757CNWp9U2raBCy0MVg>
    <xmx:RWqkZ56zITedEaMTIufmgwBUcZ4hpAoPv6Nm5NhX9eV28vtQaycl7g>
    <xmx:RWqkZ8z__synpjd3gjozTxLFDF3bHlwqmmbPAXO2bTp-AqS_L92DBA>
    <xmx:RWqkZ6rPAvtdnbqzDsceU0Vww1qb-RUBB-eFdp7X3Ytkm0KCZFZ_Z5EY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 424de983 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:20 +0100
Subject: [PATCH v4 18/18] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-18-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

The reftable library does not use any of the common helpers that the Git
project has. Consequently, most of the rules that we have in Coccinelle
do not apply to the library at all and may even generate false positives
when a pattern can be converted to use a Git helper function.

Exclude reftable library sources from being checked by Coccinelle to
avoid such false positives.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d3011e30f7..dc2ac32e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -946,7 +946,7 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 

-- 
2.48.1.538.gc4cfc42d60.dirty

