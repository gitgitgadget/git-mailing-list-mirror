Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC89267F75
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908474; cv=none; b=YAG0wX3L0fliDco+7RWTjfICLwCFRHjTJ2hn7tIQxY9G5fo4q4nhUT0mtd4AXqUffXGu0a5x3opMqBaVC7HkfQtctUUEMeH8lsbx8/zDXLSZysxtK+Z0dFsQ4ZV6cX9FrJ/Z7HyQI1Nc9cRomwiZ9NMzteh045smNuIg2X0/HVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908474; c=relaxed/simple;
	bh=SqgwrBTkrYbv5glFIrb56jno8ArmyZR/5hk9xLLHDZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnWNRLlLM7LpkZNeOvqjv4n1xK+VD3CuFPSIh5xgTVAGgqEXGjhhFf6ldGbjx0dmvOaum5Q3DbCkRLN0pmhSnuNZmAA17oie+HrAH5TlyDPZw8yT46jUzeR93OWC05wbdT308VgZnDqrtuBrv/Jeqi2o3nPMvv/kh9Ab8pOmyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=afQiFhcq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgwQCAF0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="afQiFhcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgwQCAF0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DC9F1383844;
	Tue, 25 Mar 2025 09:14:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908471;
	 x=1742994871; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=
	afQiFhcqNP511e4hpzM62OfBj+u9ycG3BxMrAJkfcRZMKwgZZXP0ATnXS7Tw8WSp
	DmE6hE4r1XCaPPewlLLO+C3hMRnSUCVRi05WtueZysv3vXWC5/IG8qstZbT9x6Nv
	R4FtN4Xt5D91ZRqSkV7USlEwqGt9XGZPpS4PeFgrKqWPpFZi/D6qP+mEcO/BOtlm
	6hlNH1qKxRckRsoDjAUX1xK/jiOjRET7PkEHkpiCfrrvcp4cygtaiMNSWkvc+1q6
	P53eCoA95fMYvNibaaJbIYXAlLcDSfwoGkzLnwNk+/CBSjEurVWWgoiAoBPkKhmo
	QR4TT6mgCj/4u5DqXfu1Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908471; x=
	1742994871; bh=qOkz5tNStvWV5OcPZ4w3xCtLyTUs4qHhI9eqR2Q3F9M=; b=S
	gwQCAF0aW6XcbuDG9WEEctFycJN47W0/FxLN2j7fgNi/9EKr7QRuN+BLBHdivqdk
	IasHCxtDT+8VyD0p3cP+csmWCUerIqWIPjo4v4Gu8UuGf8ocz5yUKl9Ntr5pK2um
	9u5b2yeaZCrTS1iJzp0Lr3MXl9BMoIEQClvy7oGsf0+CENopE8GcakztyKPT4krO
	pUPTuRGR2ghMmDYUBYP6Y2cie/RoRElr2AN8MrfvRmXu4ZNhxg2TCchDpZ7KMW3Q
	9XZkcumfzCzkkI11/jbXkFmRg0z2fhPnydsp0C/sFRuf/sDlEN+6JW58tNXB+d89
	ccGfZAGQc5+ckqn90V6iA==
X-ME-Sender: <xms:N6ziZ8Jqp7F3z8wMrdMresPA19PEu39IgA6NeuRvraWNBBE5hD7-xQ>
    <xme:N6ziZ8LcAP2mcM1QE0z7kt-b4LJEDA0VZ7kiKQFnCH8FOgVFbiD36ZtagjpSDzjGf
    eJRNWnBeKS2lt5fFg>
X-ME-Received: <xmr:N6ziZ8ui7DU5ERjvWBrddmBbHimPlkqURuvqQMuTZnhZuguvj4EbyaERmdbdgPZxvLorT_ySuCoxOPtStXKTe0lrrqvdvi4WN5SRR0jA5rmi4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N6ziZ5YeC_JzoLc9inYwmT0JDuVMwPVZ7iJ5wHXncCt3calyfTbf5g>
    <xmx:N6ziZzaOwo7a2I5inb5bKP-cp6HLau-mriTf51SppMQHi8Nn2MolnA>
    <xmx:N6ziZ1CtSQM3D4f1UjZJHwyHgiklG0tPaceSat94kNwbowyafW_ZuA>
    <xmx:N6ziZ5Y8cjD5ke7YSRroNW6zsZtnUV1R3pimnUpFJTqwyUNfYwa-mg>
    <xmx:N6ziZ-wrYtcOx6YDnKwptKIhubDGMiasnRIRlq1Po2js-2832mMzBJLM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 555acbb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:26 +0100
Subject: [PATCH v2 08/20] meson: stop requiring Perl when tests are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-8-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The Perl interpreter used to be a strict dependency for running our test
suite. This requirement is explicit in the Meson build system, where we
require Perl to be present unless tests have been disabled.

With the preceding commits we have loosened this restriction so that it
is now possible to run tests when Perl is unavailable. Loosen the above
requirement accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index efe2871c9db..d6e27b236fa 100644
--- a/meson.build
+++ b/meson.build
@@ -772,7 +772,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.472.ge94155a9ec.dirty

