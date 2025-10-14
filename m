Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7E313546
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444964; cv=pass; b=fweZU1Dff8sjy/uWRbamITsj1vdePW25T2I8dzkVlawPK7RGvtiyozUQwnK5ex92GcAWLMswuKOqHkHt0rfIw1cAtV9o4QWm5syyABUh246qUBs5OHF/1Wn0s7c8/8oaoiCPUSaE+yuSTALij8Kn/Y3v8e8us5EH0x2LzNAROV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444964; c=relaxed/simple;
	bh=/3cqqugHz/lveTKzuMlA3YyWqYG4+HnUAln+Es5dShU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9BW9J/TvieIV/DZtsELSeGsRNRZO9f8PX85Q3s87i4h9kI14NY4EEeXRN2iLr6+tiHNmXka5cCcVxe5GhZ4KonbyYsp1uofDfbFTnf4lnUdCbf78PTHINTCApgK/xYSn5iJfXrpXThpgS2Mas4nW7+ONXIvOR7gnzxfdunJAik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jFAMi3kM; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jFAMi3kM"
ARC-Seal: i=1; a=rsa-sha256; t=1760444790; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G/CExoxqAKaltON3JlmZql6naueQDJsCFTEdlByzOiCstxLFGKRV9TrAbxdCu3VkZb9bu0Hfih4ZZHnoJRqHAG1tX52t+6hF2KLixv38+IUzbPKZpenWoITvcL+3cWJwjHqGw+oKEcMjhnBoKZuJNfEsCyOIAIT3EC4RwX5J5W4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444790; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=/zR08JxZTanJwW8q+6jFD9DK9ER6BCCmFMBWG3eVlEw=; 
	b=dOcmT0JjsQdMlaEaLuh6G1Vb0Rp6EeIvKGaSgWwu+yU5TFWfkp7GmXxWN9DzzXaHKKwdYEcDv7vl4wk3E2Aau95eKe9ZDfDhBLhk48k++v9PaOaxsUUKJVYx5dcBLIG6eu5p0OXySz1T9A4sFh3xgPoq4mANjcLGCShAetUni8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444790;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=/zR08JxZTanJwW8q+6jFD9DK9ER6BCCmFMBWG3eVlEw=;
	b=jFAMi3kM+jk+2opLk8vR6DHnrXYI8J4Y99EXAtnojuzIpv3vc2h4+N/8WcuIRqQh
	SQkoupLAV5b89975WGqq65aweFkhLG7T3hyFlaVjAvx0pUxcJRIAGKB3u/jdPiPFKW/
	DnFL8srL01+ctqn4HM70xCLCTnLEkj3cdtvOkyIM=
Received: by mx.zohomail.com with SMTPS id 1760444784948274.78046935376005;
	Tue, 14 Oct 2025 05:26:24 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 28/29] tests: t3440: exercise trailer config mapping
Date: Tue, 14 Oct 2025 20:24:41 +0800
Message-ID: <20251014122452.1851103-29-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Updated the rebase --root --trailer test
to exercise trailer.review.key configuration
and the --trailer= CLI form that uses an
equals separator, ensuring we still add the
expected Reviewed-by trailer.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 7a2ddb440e..ca0619655e 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -99,8 +99,8 @@ test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
 	git checkout first &&
-	git rebase --root \
-		--trailer "$REVIEWED_BY_TRAILER" &&
+	git -c trailer.review.key=Reviewed-by rebase --root \
+		--trailer=review="Dev <dev@example.com>" &&
 	expect_trailer_msg HEAD  "first" &&
 	expect_trailer_msg HEAD^ "Initial empty commit"
 '
-- 
2.51.0

