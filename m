Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204326CE35
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111907; cv=pass; b=fwln5yE1JouSeg2PAXekiQ0eMtjou3ukjHQN002xBgY1jpwSJyVa0CKRdPhjbfdlq4VB6BDpN0Inn4ksfu6MLpvOjXqpOE+kCcnzf5wJUDtViTQ44MgsfPIYlqzZEp4qlJ6Y0S3t12aGMAmTaNRdoMtFAm11Nt+GjYnbN5+vZ6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111907; c=relaxed/simple;
	bh=VHmHcq8vIkiIiiC8aDtlqxXupHXp+mXeDtimQFM/7FI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8DUrQQAGaqh0EwgMLslVt6IQHOYmveXdWQC2KifvDIDZQlUN94rTf0Hb6EfDqAu1ktTi31050k3d0QXgYFIBMKbV/mKn8QVomrxz1iJVSd6/cnq3hmgn12Si1uL38ovPjNhoZ1OBiqzT8aJcrWhRFJ2OEfcmB7ba3lbz1uOpR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=JGfjfv9N; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="JGfjfv9N"
ARC-Seal: i=1; a=rsa-sha256; t=1761111655; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bhCxhm8MQ/Ghj9SNE2222d9OGowFwTtM7Yi7imYRtAmJ4n6G7o2HwEbEhC+3fGpUmQ+MAcEjHS0FJJFPi33r0mX7vXjb6x6Ri1YMSrgIB+eodoIXcQSix2f2DfsI29FemD0XTOvYgwq0MLxbuRlbgG6gmtRgnGcIbGAjU8oGkzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111655; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=YCDjqAQMdp+/4Cj+6t/J1MX69wFV+xxy+D+ZqhhlVrA=; 
	b=jfoerTg3OE3qX8FHVqa0+HW3cHc5wjUoKCTuX42DwCNscV2BVjWIj5/Lp5xXqo3XtjZ7Z/N0AK2Lzw7wysBM2TS6IWoB521tzmjhz01++heHnT9suoHnWR2GL3g2H6th4RR+ITFi8ao8oRxGynnhLYABHQw93y23JytwukrHwQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111655;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=YCDjqAQMdp+/4Cj+6t/J1MX69wFV+xxy+D+ZqhhlVrA=;
	b=JGfjfv9NMUMddDx9Ls2sktH9Pd6N6mEiLxD9Ae2IHu+dyx8kE8g4I2c4rrUzfu86
	A0kbfNMEfJkGDYYbcVNY/bkqsUnXltjeYp8WRN9NsTHFmJgUyCr22h+XMTTdo2g0ncD
	5FjP+Isx5Ov9XkIUpaRnz2lhpjtkM4Ka4XuePAUM=
Received: by mx.zohomail.com with SMTPS id 1761111653158313.04315441077483;
	Tue, 21 Oct 2025 22:40:53 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 28/29] t3440: exercise trailer config mapping
Date: Wed, 22 Oct 2025 13:39:48 +0800
Message-ID: <20251022053951.602605-29-me@linux.beauty>
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
index 35d2054716..d697bf558b 100755
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

