Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC58206F02
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255618; cv=none; b=Nxdk9bNNB4saTcBSi9GqH/40m00o9MTIM7uuh9BtO2KoaHxUQzW2H4j0lbmkor/CJ13A63JnQ7CPaiaI6sDVldUkYcoFmKg5JbTclP1KkGpRtLEDEOCQT89VXv0CxoQdBVWEIx0EgrGsJ+qsbhdiClL74Z1dHaSXNiNMHm1HbH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255618; c=relaxed/simple;
	bh=bGdhZ9IiHyWntm97SONjhEL0UfyywXjg70q6HOrWMpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATydyk2j3nwZyTr21rQuCFlVbt8Be4q+9xAfOfZnGi1CfvuhkBWYcOe248mzy4sIXC8VTdS4p3zPtHzEO84PdFD8l2o2E1g+yjtDZutANEnDzyZUDG0rwi0F4aP4hRiGwh6e0nagpMukl02gcti53pUUy1a3bVTmbs63MEeDrhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zvOhq64e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3VmZl7l; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zvOhq64e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3VmZl7l"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B51A13833D1;
	Mon, 17 Mar 2025 19:53:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 19:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742255616; x=
	1742342016; bh=p8Wr1apITdRz3Ry/xFoAmQ39yukL6fGj7U8PpnWf4rc=; b=z
	vOhq64eI569uMFYPPvISIQ6TFpH0lgIg4IlaLy8/ON55hq7rIxTWFdmuU25haxvu
	OC6HUt/pU1cS6pjCdSjQvfDVtwd/Y7f4bRIanvW+okoKsC4Ube3p3SmnrWjXBJ/I
	BXcAA5dlYvH0mOfSHPTn9MHy/AxGijiRaE2ZHKPq6OZzaKWCydbbIcGTPM3fsLvl
	wo0kYnestyyFW+8sYgG4aoB9DgcE/ZeLBhTfWfuG55h7TCdWZ+gyEsZw2yMqfs6x
	/mevQkslOo/vVQ6Hd1tzukEx1r880KbPfKlZQeWVGoqFbmnO6bKoXvvXW+fOTnaQ
	dlCtaz/iWStsp+OwebRiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742255616; x=1742342016; bh=p
	8Wr1apITdRz3Ry/xFoAmQ39yukL6fGj7U8PpnWf4rc=; b=o3VmZl7lPkuHUcosE
	7On3JvFZXTUI1gd/72j1EwobeMGP+Z1x01bviT5Xkh/Y/x1flYSYLVgzY/wrERsT
	gzRc/TYnqyCjT9DNsaTL7qRbw+4E/bAPLGtG9jMNmIXToQKj8vO7Ol0maV25UxnG
	NmQtOOzvHmCR7T9EN+nKqZmTViajbJdbuarEkNHtTwDJ2n8A6Jp9I1FqMy2s7K2V
	n/5DWTYIqchRYhX1LDj0SIvTUVmC9SgTRK53+uioCe0ihYaocTDbT05CZIoer4Ag
	X78dmRnu1yyHNMU6luvm+xQzwe6uYswgLJuuHOUkr6pAnfxVg7o8Iwin7WZF1E+9
	C4T9A==
X-ME-Sender: <xms:ALbYZ0-3HtW1rzR9LMq7NPHd_LTpngXA3uEVFAGFafEW2f3X6bvWQA>
    <xme:ALbYZ8sijx2EBkMfbnFZtYOGoNkJNT84zdbyYskLvoYGaWod4mTXy7AYocWwHdpHP
    x3LP9GIDYLP04wsmQ>
X-ME-Received: <xmr:ALbYZ6CKuENf-FgvYU6SlqgLY6VpV82k9dHtWOavM01T9TkgbTAA45ADktDTGfJHMsj_Ws2DqkBw-c7uw-vea1zHhuDg9LDrvjnLoiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    elveeigfelgeefieffgeeftedvtedttdffiefggfelveeiueevudfffefgvedtleenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsthgrtghkohhvvghrfhhlohifrdgtohhmpd
    hmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ALbYZ0cygnKo3Yz6odjBLEvbFhDYiny2EMdouA5bm7GexNhpv4dwgQ>
    <xmx:ALbYZ5P2UuKHopwbTLX3hwzUjuDuuxdKpUujqcbWlOygd-VSJMN3fQ>
    <xmx:ALbYZ-mqRTHXTOapao2ge6dbBDFLXtzwzLVT8HjFrXmtf6rKT53_xg>
    <xmx:ALbYZ7usoKH9FnyfMfqpBXy0eVJd7-gBHjaxKEpzIDiuLKCdDS15Dg>
    <xmx:ALbYZ6okd--ujW3NQAZh304HH-8J0ehHEmjIBIIkP0HHEiB-lQhabmn1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:53:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v3 3/3] config.mak.dev: enable -Wunreachable-code
Date: Mon, 17 Mar 2025 16:53:29 -0700
Message-ID: <20250317235329.809302-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-207-gc8924421c3
In-Reply-To: <20250317235329.809302-1-gitster@pobox.com>
References: <20250314210909.3776678-1-gitster@pobox.com>
 <20250317235329.809302-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff King <peff@peff.net>

Having the compiler point out unreachable code can help avoid bugs, like
the one discussed in:

  https://lore.kernel.org/git/20250307195057.GA3675279@coredump.intra.peff.net/

In that case it was found by Coverity, but finding it earlier saves
everybody time and effort.

We can use -Wunreachable-code to get some help from the compiler here.
Interestingly, this is a noop in gcc. It was a real warning up until gcc
4.x, when it was removed for being too flaky, but they left the
command-line option to avoid breaking users. See:

  https://stackoverflow.com/questions/17249934/why-does-gcc-not-warn-for-unreachable-code

However, clang does implement this option, and it finds the case
mentioned above (and no other cases within the code base). And since we
run clang in several of our CI jobs, that's enough to get an early
warning of breakage.

We could enable it only for clang, but since gcc is happy to ignore it,
it's simpler to just turn it on for all developer builds.

Signed-off-by: Jeff King <peff@peff.net>
[jc: squashed meson.build change sent by Patrick]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 1 +
 meson.build    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 0fd8cc4d35..95b7bc46ae 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -39,6 +39,7 @@ DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
+DEVELOPER_CFLAGS += -Wunreachable-code
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
diff --git a/meson.build b/meson.build
index 373524dad2..fdccc59945 100644
--- a/meson.build
+++ b/meson.build
@@ -698,6 +698,7 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
     '-Woverflow',
     '-Wpointer-arith',
     '-Wstrict-prototypes',
+    '-Wunreachable-code',
     '-Wunused',
     '-Wvla',
     '-Wwrite-strings',
-- 
2.49.0-207-gc8924421c3

