Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BF36605A
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756874; cv=none; b=eRk667Bp7WMN9mJmuQ1sxRAwu0odIXbIVbSmJn8QE4rSQ+si2aEwQ8OyIizi3szQgbQ1zNhPIAhxuv1lkt73COpU5RGesqjRfywDsak3v720+TjFw/7MK2bgDleDuwtddthd0ewwhsgcKrPSxYNds/lcsUSPabEMQdx54QylLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756874; c=relaxed/simple;
	bh=9F5Qys3sCQrWROCnwiZC2mMgJn3qvL+0pzw7tA6OOLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rkzMmu3PiHuAUDcxD3kOEYyDtZpCPS+sWfmqByuRfN90gaf43OzKHsxxm+jVs7hRLRNXscXBdRdmx2qS/Ij23YdDGW/aNEQySs1C8WIZFVFhDUi+KWk1qBpQdUmHUZvo2UAhTWuPnCb9IDwBc2THGiimkp+uwDBereV0A02zVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JR2foN9x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNmD9vQW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JR2foN9x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNmD9vQW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 523AC140006E;
	Tue, 21 Apr 2026 03:34:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 03:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756872;
	 x=1776843272; bh=WyRyCHonYwsgD7MGPZgh5Q6kx9Qcg93ZASOjGWSQEig=; b=
	JR2foN9xPDdPgu5eDqR+JqrMEq+i958AAIy8dxwVQBbSy88BQl1ea47vPTXU/eSl
	5/jfU01tmDhrgv3ICbhTX7tfERK5pa3VrIP1JLpOx/js1/Y/676xiG/64wQpElPT
	63CwVq4WDs+VFP5OUh35UZGX0mbR5+7f78wYYJug3NmpjEp8EA7fMIFbB6g8Jbps
	dN7MstTCXcFEp4Lh0qLIFCJgDtTOiItaCawXy2bh31zUW6AhwHBqaoUQU13UOov8
	6RPlEbiX0kscPA0DKpMIF9szYBVkLnSG8uszVj/dIQdbcaw/OwElbyDiPQizcLQ7
	DQ3Cch/LysC9glnnHCw5Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756872; x=
	1776843272; bh=WyRyCHonYwsgD7MGPZgh5Q6kx9Qcg93ZASOjGWSQEig=; b=K
	NmD9vQWJmEfGW7UVQ/Y0USxSet8C6miGJCKJzMcoxW25vECbnNLOrXUKNrj6t1uU
	V9PoHodl0QD8XZ5BP6gZ7fS8cjfamfutux11Cw9Whm5ikvdtb/WE/iaY9yMJMGop
	4qlw9wJSYhCjA7cH1ZhNNH0F8nctilafA+fl+IQpxZpwDwP312TCAFZ76V8YQR7a
	9kNs6iYTbtkrQDl0tirgqCyy89i69pRuxlpIuLusJZAG3vXTBV1b4y8TmIgDZBN9
	mcPNG6FSx8fjCT7IzhRcPNcsBxYk+W+rtHLh3sZRPH0LsZIkyXgfXDGU8msiY/Am
	TbP/2Zh2Obv9EBS0iEDdw==
X-ME-Sender: <xms:iCjnadukd_VKKjmbH45Wrb9ynnVdzanlFAGPbJk9Q-OMWO2tF28zTQ>
    <xme:iCjnadezIEn5Wt60I8K277gRtCiH0Mar4KMiT3NvlZamTVR5KloaP4PACzunvwk41
    PQ6kPKvfErdO7wPHAfvmTgSvxCt7VC9tH-TBLj3oq7ioTuikDnfug>
X-ME-Received: <xmr:iCjnaVzKnS6yYQrzhNGlF8dZ32mgeExhm0biadEno29hfkmGeBp7GQad48bLHgGViJuqzguGiWQ3gcqcRBhyBt2t-C1A1LPL-vwBTurGOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:iCjnaTHf7cpvbq7RixbVafq7cvHNZQSqw18oyeZ3JP-PZWJKDmwtZA>
    <xmx:iCjnaZxDOwqP2TGd1ABFGR5hVtI4G5EAOPjYPQr_Pj83pA75TrMAHw>
    <xmx:iCjnaUs_YIT-0YObkM1O9nLRwcQgsUtFQ7BhjfWzxj7XlNeFiQmf5Q>
    <xmx:iCjnaW1o58A1XUtkHPkqAf6MJlduUAlzeRwBBWSAJ6N7WbR7yEjGZw>
    <xmx:iCjnaRvMiSmiaeDPItiC_Jw-vhMogqGJ1JkSaQOsAR7rFujmEtDZ8BUL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ca84ed9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:18 +0200
Subject: [PATCH v6 05/12] t: prepare conditional test execution for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-5-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

We have some test in our test suite where we use the pattern of
`test ... && test_expect_succeess` to conditionally execute a test. The
problem is that when we decide to not execute the test, we'll indeed
skip the test, but the overall statement will also be unsuccessful. This
will become a problem once we enable `set -e`.

Prepare for this future by turning this into a proper conditional, which
is also a bit easier to read overall.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 12 +++++++-----
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index c98eb6abb2..2d216fb70f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -40,11 +40,13 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
-	test_expect_success "$label: check output" "
-		git $cmd $file | grep -v '^index ' >actual &&
-		test_cmp $expected actual
-	"
+	if test -f $expected
+	then
+		test_expect_success "$label: check output" "
+			git $cmd $file | grep -v '^index ' >actual &&
+			test_cmp $expected actual
+		"
+	fi
 }
 
 cat <<EOF >expected.f1.0.1 || exit 1
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index f512eed278..8cc86522b2 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -220,17 +220,19 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
-	test_expect_success "refuse to load symlinked $name into index ($type)" '
-		test_must_fail \
-			git -C $dir \
-			    -c core.protectntfs \
-			    -c core.protecthfs \
-			    read-tree $tree 2>err &&
-		grep "invalid path.*$name" err &&
-		git -C $dir ls-files -s >out &&
-		test_must_be_empty out
-	'
+	if test -n "$refuse_index"
+	then
+		test_expect_success "refuse to load symlinked $name into index ($type)" '
+			test_must_fail \
+				git -C $dir \
+				    -c core.protectntfs \
+				    -c core.protecthfs \
+				    read-tree $tree 2>err &&
+			grep "invalid path.*$name" err &&
+			git -C $dir ls-files -s >out &&
+			test_must_be_empty out
+		'
+	fi
 }
 
 check_dotx_symlink gitmodules vanilla .gitmodules

-- 
2.54.0.545.g6539524ca2.dirty

