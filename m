Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679D2EC08E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111807; cv=pass; b=LSUiFIbFEhD6FgyuLvTkVtymT5ShvNcYK4fXoZofTlSexUWvikrNKm83ty6ncEmFGJaeoJ+hdHL1FTK8b+PDiKPrUR+/Dq08LbmteCPAGriOqsvzMG1k9J2vWLYkToU7aKMbAb3zB8q1EeFTkmnhng48/xBPTLJvf8mxYADQl+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111807; c=relaxed/simple;
	bh=fEbv0tt1U0lsliwTD//NoEKABkk0wzbn9VPTG6L5l9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+VZEWpETXMS/vPG3JiWTEqM3c8nxdHU922stM248wu9G7CvZ2nDrgwC0PEruMgqdXBAnlS3Twc6kB8DJbXoT77J6F4MnnXOmXYc9TOP+rcBEqi3MLwvuIGHuO7+4J4dMn2u4hnZVARoSk2WKiVscyUGSpXt1jYNsCr07SghphU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=rgfo4pAM; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="rgfo4pAM"
ARC-Seal: i=1; a=rsa-sha256; t=1761111635; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bCfUEKd7DEIUwn3b3+rfjZiEGsTfQAScN+Rdm01ZmVJ/jyCCg5/9vmMYIUy2GJ2+RGuoMIcEInf0z6evKb005hUuxF+KVQRhX2BN53HiZn114alh0fmn4p7224oI7p8kl9lqoPvqFGo8DBJF2xT73vKOeIiK9ekthKaYoG++7Og=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111635; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=GoBNUen+moQagZFLtwfdGjDQ6gFWQ/Kevi444jusdQY=; 
	b=g51Y6ylU0PPZ9CbMuYxqTL+9uUxztS83CI7GlRBiQ/F7u2cQOBaoEV7/GtxSl6158+woQPXqdYXyfYwEGQWaJSG322RoWXovE8+Tx2deZkfaxNXVhePuGJkXk/PNybqyUXSCfAFKHbtbjL1YjHFX5HGQ/vfU5JtdZdhgHG1wzJA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111635;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=GoBNUen+moQagZFLtwfdGjDQ6gFWQ/Kevi444jusdQY=;
	b=rgfo4pAM3cXosIYfSQER0nW5VAKQbW6IFfaCX5++Xlh7kGZHGFw3NNtPwQYzGNdi
	MGO0QNprv9bCpTy2nOnBPpYm7SNSrGmJMZ8ku+YjxVCXlmYJSJsY+OdsM5bctKFfo1a
	UQhQsvFNHzg/84OKgb2T8RR2MCccWQvKixBOJ02M=
Received: by mx.zohomail.com with SMTPS id 1761111632395244.21064389867843;
	Tue, 21 Oct 2025 22:40:32 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 18/29] t3440: check apply backend error includes option
Date: Wed, 22 Oct 2025 13:39:38 +0800
Message-ID: <20251022053951.602605-19-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Updated the rebase trailer test to assert that
the apply-backend error explicitly includes the
--trailer option in its message while retaining
the existing backend check.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index a8108f2296..6b1c93b4cb 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -34,7 +34,7 @@ test_expect_success 'apply backend is rejected with --trailer' '
 	test_expect_code 128 \
 	git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
 				HEAD^ 2>err &&
-	test_grep "requires the merge backend" err &&
+	test_grep "fatal: --trailer requires the merge backend" err &&
 	test_cmp_rev HEAD $head_before
 '
 
-- 
2.51.0

