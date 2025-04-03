Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54733C9
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656761; cv=none; b=fUn4D2HT16cn4mOxNChgjJYt6YTjkyogWHQ3iqMgy7Q6Yuky7wbE6jjA8DNXsrW/f5B1xPrkyIUp1GNG6LFijIjtX4AvvstqsBZ0zC2jOSZHSiOgdDVpeqHjNd5eFkfTQaW8hiDfpQv6C0/MUZeGjJ8fptqowQAyFCiwBQBA7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656761; c=relaxed/simple;
	bh=NNc68ugVGKEU+YTVtZPS1Y5K2G0dZ07zMUGuK6SuVig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMWqrXBk2wey1oxZNN6zwWZxcp+l7ACc/ITtb5rdSDOrf/5pgYkmlXHfdbXZGyflAf1r1gY8sBSCNxj9ztMbj8ciuAwkYvksRQdEmUXZRdYtlLp7hvLIhKukIKzZkYkxLDpiQGRE5850fmh9EIUAm4aoz7e1yi4cjsKRYclu27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ru16JZW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QAPWWt5S; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ru16JZW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QAPWWt5S"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E04BA114019B;
	Thu,  3 Apr 2025 01:05:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 03 Apr 2025 01:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656758;
	 x=1743743158; bh=PzvnlTnBbUEI2ew2XsNQCTjoeWocFZxjtxChSwvd7aA=; b=
	Ru16JZW4O3W8o2j0CLp8/N5T62I/0Mf3Q7pkDFAgK0Lbay42KvByP8eN9GfgmWVd
	kbI5fkLJgVwNmpSM8fgxw/awlqVl/07yYZ9SS2V+CwzfspbC7K2tB7L18W4Ce8TQ
	JuZNWUB3ZT1K5ztxyrzwoOveYTwfEjSgdwi2UGri4egfUD75rL8gpSvbzMyrbPts
	XJ3jY0yFLDMbwpVyiunH//3AS3GHMuWFWlAIGNs4mnNU2qEBjs+tUiNJkrZ+97sM
	+0AaeklVr0hT+UD7OjesyVxeFfsEQmXyb3aDRQxSWihiuO0ixdKxcK/1s1dccz7d
	kw4ymVp2/U0IPXdttlJ91A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656758; x=
	1743743158; bh=PzvnlTnBbUEI2ew2XsNQCTjoeWocFZxjtxChSwvd7aA=; b=Q
	APWWt5Spw7Gu+q4iBASC7SyNH3cwl3akfhHzXfFTmYodhHOUbXslIWQwUjAaorpv
	dwsoMCrf3SeAfZGfcR0JrSYGuWSmBZkdFWzTIxJYrpgYv3tcC+llKqEMz0X6OSGf
	ouvUCIJcqcCo5Hm77ovNUIHhcPy9W2aD3rLuQJqHIeg89DI706el5LQ35oI4u5zr
	cWBCy1UNqWb7PN/9SqXtRfUFbRsznFuwtU6sfJ1DRZLIKjL7IefXybyT8+/UIs7X
	xxImOkh7507SyuCQHjcptcyMcJe7ePz20iv1HWfJuC77mw+rTaNjQNZRKrDOyPi2
	ajzc5Oii70yiOFE3rbFYA==
X-ME-Sender: <xms:NhfuZxNlb6wXWDeSYTFz0TUmLugf0QcW-16zU0fjxPWmiNAOpdegdQ>
    <xme:NhfuZz83t2_Wn0IOw6DobJghvaGuGwsdvw3IPX7vPGv5A0KBiBTSlnST3N8F_lzPu
    eRahLkeYeBgCIpogg>
X-ME-Received: <xmr:NhfuZwR4GbQDMJIVqgNPJYkUC6hMOznb3UjD-iZ4Q5CC3oHl9mEBl6tdXcjSoJ-oeLX8Yv-pOBTGawX6oPJCXCXoZ_6l9BhXLOMedVWfK3vnjLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NhfuZ9sdP_EUpwR-YUHgBKQucBMnK6cAt-z5AqhpzV9N-K-LiTLXrw>
    <xmx:NhfuZ5c82hiyp-IIfeuvB-UEMUutegY2QIvDKxtnfp6cN7FzjX6E5g>
    <xmx:NhfuZ50SdvUouL5OK2YR4bU_tQJS3iSWsQFruGZBEP1krEHRBneM9Q>
    <xmx:NhfuZ1-MWFkHi2fKE1VmAK8FIbY8tlmCBQOqPzXJCpAYp9_TbX5iRw>
    <xmx:NhfuZxQxM2uE5u8L2kRSR61b9AK-26lqhQBezEnRp2pBM9gnmxUgWTeV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:05:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8911774b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:52 +0200
Subject: [PATCH v4 01/20] t: skip chain lint when PERL_PATH is unset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-1-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Our chainlint script verifies that test files have proper '&&' chains.
This script is written in Perl and executed for every test file before
executing the test logic itself.

In subsequent commits we're about to refactor our test suite so that
Perl becomes an optional dependency, only. And while it is already
possible to disable this linter, developers that don't have Perl
available at all would always have to disable the linter manually, which
is rather cumbersome.

Disable the chain linter automatically in case PERL_PATH isn't set to
make this a bit less annoying. Bail out with an error in case the
developer has asked explicitly for the chain linter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9001ed3a647..1ce3b32fcac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1523,6 +1523,22 @@ then
 	export LSAN_OPTIONS
 fi
 
+if test -z "$PERL_PATH"
+then
+	case "${GIT_TEST_CHAIN_LINT:-unset}" in
+	unset)
+		GIT_TEST_CHAIN_LINT=0
+		;;
+	0)
+		# The user has explicitly disabled the chain linter, so we
+		# don't have anything to worry about.
+		;;
+	*)
+		BAIL_OUT 'You need Perl for the chain linter'
+		;;
+	esac
+fi
+
 if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&
    test "${GIT_TEST_EXT_CHAIN_LINT:-1}" != 0
 then

-- 
2.49.0.604.gff1f9ca942.dirty

