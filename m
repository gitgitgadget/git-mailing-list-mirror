Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDA199248
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708807; cv=none; b=pJ9ZLj81AJ/cFkDJX2zp4UutN3gagessR6GBu72cNUr6Uez5KYiBiITk74nFZcoV7T9znU4UgmjbQkAv4Qb3X6/cW6sym03PTjM9g7kVg2leRV+KANcElGnSv/akqmVJTjJagESQz2rVzcPMYjVVCcBNLeL0QVD6Cw9QpQpHzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708807; c=relaxed/simple;
	bh=vHbON6DJuratdtZPtnxXFhnY2EJKNntpkUDMlQ4pBWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGN+dNWSp0t8HK8eWn70zeAMwlPGPqVYxrzamy9gfJlACucURjay0AJYFlBHk/Vmqb0Ue4kHgGOxx0otR4WAcnIfwIWOXyFiDQAWUiDFbsGx2T153N9XhAw+Rba8SK0kV2D15kVhjrQabAjOsH3tjQU1EIJ7xHXwk1LF1iPVqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ifxgdTXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZoGJsfq; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ifxgdTXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZoGJsfq"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A9C621151D1C;
	Thu, 15 Aug 2024 04:00:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 15 Aug 2024 04:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723708804; x=1723795204; bh=hBcrE6obeU
	l8UAzwXmG1mqpoG637vytBkeS2Sr/rE5M=; b=ifxgdTXLx12636kJL0FIczWNbJ
	57AV8JlIEp8B02SoUjbdeuoqvlFF7i2QRBS3IZdruzvdv/B2an0OzBO5OdaFNMnJ
	KGhNaID7MWo2kRWf3gEnPOX7px4fVIyaxMbL0HczjwyGqs8I0qz3JXCBVSrLOrtA
	iTMhFzzTh4DMwofPbbyM+dFNdmsQup+zeEH2F1dLaMzDb/bubiPlc0X8Snb8QfBw
	5pR6qZFX1Ne9LhORaNFvmXA+msi2m50aLxQ2gqgS9DLuL083vjHupTEzz/HS/9LH
	TXATipuulyhDrNt3hvEtHQcHbEOJxRAyLniOYJzG6WlgEyfaBJqjBzDKvKqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723708804; x=1723795204; bh=hBcrE6obeUl8UAzwXmG1mqpoG637
	vytBkeS2Sr/rE5M=; b=NZoGJsfqIMYdHITfpy27NlVEDUqFzmdgLCyz3OHly1AN
	ASSzk6EP4vTZMXYzED0R+FfQDaJEiqzW33i0WD00AhkaEH33nnHBDzKEP+rGn0E+
	tOJwYvJkiBDrS8PyQcoIWjLAj5QhKLjl7s8KiQXmTXLnvd3/C/hEJWNifsFqQKEe
	tFAJ1gbvTpCR9i4xNnj/IjlHQRjVyK08ZKKQJVzJmUEFif7+9nWW8iWPK8+HaV2g
	soZ/Wlnwt2yxRXTb5PmBELbkiwEZdvnkmesG9kHpXiQYdTrt6sY5SZFxzYbrw1Wp
	7aHOXbYSlMPtQURB91Rsol44KieIZaZPAhaHXvaA4w==
X-ME-Sender: <xms:hLW9ZkBMqG1PtwRg_igZ7kkHtPPmQSnztA3d5K3ZLrVkXIFsyCPfaA>
    <xme:hLW9ZmgTIPhaNmltVUp-vF1c-RXbWjxMXC8y8RwRhDneZKH4KAjy37eqlCarGnu_K
    u1zR7oEXGMXdUWgMA>
X-ME-Received: <xmr:hLW9ZnkLWILF7XNiqqg_fEgQo_oQ3qoXAMSZhjCyAjdRaO87nnF3KBsdxBdtU8Y-lOE8j0aHTHtX4YW7MqCpG4uDWYvW2arHutBJWET2EGPoLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsshgthhhusggvrhhthhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hLW9ZqwEO2A7SP-jHQPD-4STdujzjNsF-bgoE5TqHfzMOvTLs61SSw>
    <xmx:hLW9ZpRJJ7I2gapNrzjtxTNWXJKEtnTPltuNea2sS9xq-t2btpdoLQ>
    <xmx:hLW9ZlboK9Td8dSpTTOVvLf4BEyCAwnNitP6MIOEs9pnPZx58vYvWQ>
    <xmx:hLW9ZiTCVP9xJDIQlgT5DzC3M7k7NlQROCHioW4QXLmamO3Gn7gV7Q>
    <xmx:hLW9Zkd18qg4aFbwPZBn1SGIRBdC1XGDNHfPKtqaQCPJQ4NFLfMTOSSZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:00:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 153acb75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:38 +0000 (UTC)
Date: Thu, 15 Aug 2024 09:59:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/5] t0001: exercise initialization with ref formats more
 thoroughly
Message-ID: <0d3844db32237983a1d85ced1a3b1b25fcd1d6eb.1723708417.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

While our object format tests for git-init(1) exercise tests with all
known formats in t0001, the tests for the ref format don't. This leads
to some missing test coverage for interesting cases, like whether or not
a non-default ref storage format causes us to bump the repository format
version. We also don't test for the precedence of the `--ref-format=`
and the `GIT_DEFAULT_REF_FORMAT=` environment variable.

Extend the test suite to cover more scenarios related to the ref format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 49e9bf77c6..2093f5c1ee 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -558,15 +558,6 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
 '
 
-test_expect_success DEFAULT_REPO_FORMAT 'init with GIT_DEFAULT_REF_FORMAT=files' '
-	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
-	echo 0 >expect &&
-	git -C refformat config core.repositoryformatversion >actual &&
-	test_cmp expect actual &&
-	test_must_fail git -C refformat config extensions.refstorage
-'
-
 test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
@@ -576,15 +567,46 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_cmp expect err
 '
 
-test_expect_success 'init with --ref-format=files' '
+backends="files reftable"
+for format in $backends
+do
+	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '
+		test_when_finished "rm -rf refformat" &&
+		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+
+		if test $format = files
+		then
+			test_must_fail git -C refformat config extensions.refstorage &&
+			echo 0 >expect
+		else
+			git -C refformat config extensions.refstorage &&
+			echo 1 >expect
+		fi &&
+		git -C refformat config core.repositoryformatversion >actual &&
+		test_cmp expect actual &&
+
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "init with --ref-format=$format" '
+		test_when_finished "rm -rf refformat" &&
+		git init --ref-format=$format refformat &&
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
-	git init --ref-format=files refformat &&
-	echo files >expect &&
+	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
+	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
 '
 
-backends="files reftable"
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
-- 
2.46.0.46.g406f326d27.dirty

