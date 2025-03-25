Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88296268FCF
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908487; cv=none; b=Kxk0YMeXlVxjsccS7opCyD2LI+L7fUBF1Y4ZfhfBaALYDjzd8nCfY3fPdsSMDrajBHimS3Sp2mAr/2NHliNmVGMza5wx15ceTihKRcN+bER2BDT4HL8v3BHbySFAv2GDdF+ALEeGfLNRjE6UGMHc8xhT3LEH5WlyKsaclSf9PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908487; c=relaxed/simple;
	bh=0vDLZtJoO0JWlSJGdB1334hkWHi1ZII88VJ3KTVuw4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cys79bhbHM1/DDMHqc5jrZ8lr2hSOGEwjHFNMylH4W2OOBPhSXY8C09iqqON1bqpxUC+9tSmDNck9LzpLtBj6qH/LPx7jMTfDaXcfa09a4TXHuXUHaRW37xaEe3pWZt6lsgYr6VmtxOHhGtaBUGldSpyDTHbInlQhywmN9bEqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFvC7AIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v6uJDqFk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFvC7AIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v6uJDqFk"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AFF941383844;
	Tue, 25 Mar 2025 09:14:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 25 Mar 2025 09:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908484;
	 x=1742994884; bh=8mNJ6Dr3p2I6SWEWYBP3GmUzLBsShSYpobEZZTH9ZWE=; b=
	VFvC7AIjXAB+4mZ1gaW8b4kazYPPSSlKKLjY3C5SeXiSasjICixIKC1MEzoPqYfq
	JfT1wiZACUrF8FIEN+zcdCQCS3KWqzE3NY+x3U58XTc99nfWRkQRhVCFD79pxPEE
	iT2HspE374HsQ7DLjOqEkILuMRr/WvoeeADAztZCoQ8W6HdTl/KVMAntSjtIbh2A
	bVg5amR/s6edT5nOB6EZWFRXvqI/CMBZ02tKnUyD8RbDy/lCqMbaimMNkWwE51tW
	KrDt5fIzdHzLY+Fi5AVokWBGaHzOJzfdQVQ+C3xJy17wtSxRA/ZrUi+2Im71IGEL
	j8HGnzBtWNIitCKl+TgPOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908484; x=
	1742994884; bh=8mNJ6Dr3p2I6SWEWYBP3GmUzLBsShSYpobEZZTH9ZWE=; b=v
	6uJDqFkVrOmYEF6+KdcdmrsachKwNbIK+6pUbHiMzesELy2My3rTO15EjDSuu/Uu
	509IWEX67MEMq4GxVhIkRuqnBmf9XX9Da+t4dV+j9eHOW5BwZ980GUeLUZHcuYzn
	KHIlsqlhgYvGU1+IGjqdknbimVjHv6e5h9dEvMWSUqWmH1QxcwUsmuUZZ3YEw/FH
	caZ67+c5ZnfUAC3QP6TYxgwstKo++57J2YEfPPfn++2NOQ+MK+CC42/9DaOU6i0f
	z0M1ZNgKYLFwNBvM+wcr5L3Ase0CtCWZInHpl1jNA1WiNlV6WWwL92eW+32hNbsn
	n+dDVzVWga5UzCOZvCNNQ==
X-ME-Sender: <xms:RKziZxWrlcsiNcMTucRdnIQnsdAVd50pMYwjDwZC-m19zPeH6ciy8w>
    <xme:RKziZxnSwFtMWq9tVqKQ44oaGqjAZTBltIQR7A6cKFw6UknAbzqj7tEVP3DRc8BZj
    r4FU5pKEPPDTOu9Nw>
X-ME-Received: <xmr:RKziZ9ZCSKJnmex77UO46cb24xE07YudckAFMjCqUpfQrTu_arAcLATsTvT0Fl9rUcF9BNS2Ctf4NJczpsBq-uOCwXnRFZN_50RJ8Txw3pX6EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:RKziZ0Ul_HoAVPsYfV_uMviIe-2Hng5IRQWu_4_1qvLHRwrdj5EDqw>
    <xmx:RKziZ7mgt1Qi5NMYkZ-e5SCebIKNMmRi2zJGc3I-Xp6LIGkQG9DgQw>
    <xmx:RKziZxdBCCblH7EpitN0ODv4HJhza7lTkSqkdz34dMiBO8iUsxs3EQ>
    <xmx:RKziZ1HyzwExCclzNzrjq8DlsxWRn6P1Jz10eG3189zyL__10vUVYQ>
    <xmx:RKziZ2ujOqF6l7tEgON6aihoYHEF19svEp37Pk46XB1ZLVa2elhKMl7K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 671ede3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:38 +0100
Subject: [PATCH v2 20/20] t5703: refactor test to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-20-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We use Perl due to two different reasons in t5703:

  - To filter advertised capabilities.

  - To set up a CGI script with HTTPD.

Refactor the first category to use `test_grep` instead. Refactoring the
second category would be a bit more involved, so instead we add the
PERL_TEST_HELPERS prerequisite to those individual tests now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5703-upload-pack-ref-in-want.sh | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index ac7266126a0..1ab3191d72d 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -4,12 +4,6 @@ test_description='upload-pack ref-in-want'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping upload-pack ref-in-want tests; Perl not available'
-	test_done
-fi
-
 get_actual_refs () {
 	sed -n -e '/wanted-refs/,/0001/{
 		/wanted-refs/d
@@ -89,18 +83,15 @@ test_expect_success 'setup repository' '
 
 test_expect_success 'config controls ref-in-want advertisement' '
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_must_be_empty out.filter &&
+	test_grep ! "ref-in-want" out &&
 
 	git config uploadpack.allowRefInWant false &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_must_be_empty out.filter &&
+	test_grep ! "ref-in-want" out &&
 
 	git config uploadpack.allowRefInWant true &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_file_not_empty out.filter
+	test_grep "ref-in-want" out
 '
 
 test_expect_success 'invalid want-ref line' '
@@ -486,7 +477,7 @@ inconsistency () {
 	EOF
 }
 
-test_expect_success 'server is initially ahead - no ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -495,7 +486,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	test_grep "fatal: remote error: upload-pack: not our ref" err
 '
 
-test_expect_success 'server is initially ahead - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -507,7 +498,7 @@ test_expect_success 'server is initially ahead - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server is initially behind - no ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially behind - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -519,7 +510,7 @@ test_expect_success 'server is initially behind - no ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server is initially behind - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -531,7 +522,7 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server loses a ref - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&

-- 
2.49.0.472.ge94155a9ec.dirty

