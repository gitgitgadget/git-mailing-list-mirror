Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AD25EF92
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908468; cv=none; b=XPsobKAJQOZF4dNa150AjfYZCRft9rtXjm9fl7U5e3Adu5/cZ3+Xr3P2HmSkmrWOGOEPM7FcDCxsepiOO7PnPzQJxFIyeqATep4q+0I6Bbms4SPai+DhoNe5G9Ng+g5EQnpgnHMl/hHBNu5j7MTupmgn0tqgVZzBlQ/S/K0HjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908468; c=relaxed/simple;
	bh=r+44rd782YT6x6dz2cANM6QpWXIcYEb9ttd/QWrrMRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrolIW7jOb3KlnFFldZTTy0U4NQk5rhfju5kXJ2Lw3xJkducmFOke8buD40L2CnPLGDeT6pjsy98rlZUX228bSFoNYu0QLFTyXqahmVIpJkz7EUlKcyG0PdEj6MfL6NONcDTWH97DKzvKG1eEEJF5nS1qZs5itAyWoKNKr4wjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PxCn42XP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQIj08kq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PxCn42XP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQIj08kq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DFA11140272;
	Tue, 25 Mar 2025 09:14:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 25 Mar 2025 09:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908465;
	 x=1742994865; bh=bBnzsBxGrvlhpKUDGvjbdM63lE9bkJM7rbSwjIEVqBc=; b=
	PxCn42XP0n/MyI6tacWLpZIPVEDGg/aJHyIGZLd00yfOi25OwbdWaACM60HS6xEF
	AqJEfCgOIA2s7uWNTNVLG0eSFzPPnqJdKUyW4ST27qQbd7ccHFYdqzCcDeioLHfP
	caTMDtYbG9gqszoSu1KISOp6IHxsxFPZVbREJjkvQKcDHW2uQ1JKtYOkfA7auxEO
	9DOQuDurxWpCkrrNcmCc9sELJbjFuvBJt1bKw5HnzJTzkviWbGyUmkiOaMvRsLWZ
	Lmss24x2FJ5AgE8utj023nx2aSCdZhmjiOOQdK95ZVj9UIOO0bXSrRbEfySt9c0+
	AJ5hEn1EC/jk8wV7ZPwb3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908465; x=
	1742994865; bh=bBnzsBxGrvlhpKUDGvjbdM63lE9bkJM7rbSwjIEVqBc=; b=S
	QIj08kqm64u0hr2NCuEm7f/pR0Scd5OG+oJgf75Mi/N7EPuL2J/t39CZCyR6uSN5
	PW73AcHJSOkcWuW9rIsM0SBpa2reLApe9vyJTptI6S4Czn00S0QeMZKSVx/iyEtc
	RedrAwPj7Cp7dTYL4kmp/cdSGeNW+EDU0cR1IF0xZ1b8hSkRgaHwP/TPAr1R1GvX
	3KalvR79dTTWV58sFgaVTKgspfMxGACYudNEgqrwSpuZedYkah5z14E7dEzz8oXO
	PrV2n4BO/AJZQSWYVMpc7CFthJTWEYa343vM2Ns7Qn2fHYA4PhN8M9X4ZHmrB2rC
	Ruw5ZrwnJCQg/d+LJjiPg==
X-ME-Sender: <xms:MaziZ8CWSX2iQ3s1WThVj5T5tZpprbWnJRmWcqquQ0EvMFn9wmtUbA>
    <xme:MaziZ-jLuzbFeE_HlhiIc1SzrFWjufeciL2lYdkhY_0u50SI49YvCZHCUJOVh-chH
    p8XKG3GiADHjP52hQ>
X-ME-Received: <xmr:MaziZ_mZaChiE-OeZ_3nxtsA2-FYDUBqVyWWihIdbqw-mtPgV-NNNTw-7JQkNilSgfXKzIAb4Yo57TJydayQNl6WRJhHCSNc1c2zz_c25AskiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:MaziZyyxTlNUod6bX7Edtuy6dvJZ3eT9CHehEDmZJHi5QGZ1ISJlEg>
    <xmx:MaziZxS8guTKAl3U_3uGAERk-FLH5Evi37NkftoQLPUwcSS-UCDC_g>
    <xmx:MaziZ9ao-vufx4tfkR28fwYPszIex7af9boNL-Y3DSJTj_uHjoVwng>
    <xmx:MaziZ6S4TylzlngiUZ4Jte15TkCFys4KcNoekNqnrMgI-5VIv0AenQ>
    <xmx:MaziZ6IaOz1TWG16Xgh5Evj0OVf7FXxheUgMuphx6hwk_LcBlNLSJ86L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8dadba2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:19 +0100
Subject: [PATCH v2 01/20] t: skip chain lint when PERL_PATH is unset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-1-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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
2.49.0.472.ge94155a9ec.dirty

