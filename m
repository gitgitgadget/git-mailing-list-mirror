Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6E2EDD60
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111877; cv=pass; b=nFEAwKO5hxKAcTFXNSmiIS62VyXi31aU3HksZlBN9S2tlbFdEOqza0X0UIULZSAp7NOojwaPi1N/cthXdNxM+8W9SCm5w/iAg+9SF+N1UFkzslHlOxmW4UxBV3/3z/HKnCvyVuUOCh9TYrVrPudUX9v6Xc+3aXqKUoU0LZnIk1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111877; c=relaxed/simple;
	bh=CwxfETD+Xrb4KmnjucJPCTfIKluWR6MttH12Ip/mPdk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLPW3SNRG6uDH4oxetFTLeKJdR+hQDOhhZZqLNdTnQ3YN/SbMUM9TfAOAOChfG4sIiwDbbU97qebpMuTNhvOR/GN3XIv0bfB9A8NrZlgDsSA3rli7BMSzPv2TVzQnngkH+BZ1PwTzHxnNOG9XLzhKB1fL7yRcdIEbZNmNQVdMPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=TM8b5ij0; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="TM8b5ij0"
ARC-Seal: i=1; a=rsa-sha256; t=1761111649; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IU8AAxxByXqREOhu+gJD7VpyOBAYpqFEuNtFYr5BYdipQrNO2JouibThp8uD9Rnb6bfiCTA5Qp4RxIToPJvzUx6/KsYOjF75OEXEMVGP0Gz2oEsbaMZYymjxwALY8Dh9/5ukZ/gX/x4LHb/J/maK1ZR8JelovKRdFp6t36ktGrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111649; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=fCKYc5ADhiW7iEDC3/2bBxxwPC+JcIQbE9PuTJlfENk=; 
	b=hV/0BFTZ6Zy3X2UEOSBYYplrrG/Z+QOvOtpFXgp5Q6QHWLxIgsXOUXf7C57r2YypED9gGbRDZyA/oj78og652PfmGi9r/WrZK1qSm10DxwQzAAvsE/NLRFL78jcaSn95z7E4Ocjnt5vby/AWHSI0ULcQjdVMfMIoEhWNDHgAmyM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111649;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=fCKYc5ADhiW7iEDC3/2bBxxwPC+JcIQbE9PuTJlfENk=;
	b=TM8b5ij0abU4nfbgz3yMxS4yf9h5rnfv1p3qjf/JQFxBOMk3QgmxAmC1jMGHqVO+
	x+wred9k6vsO3PUZYJKhxgOgBLNo4kRmIkr+vX+A3guk3DTnUA5MmSHWyvCOs6Oerd6
	BMOqwVyGKNLOJZ1vd99YMei7M/eyQSQ6Mj5B/n80=
Received: by mx.zohomail.com with SMTPS id 1761111647038528.2814225377576;
	Tue, 21 Oct 2025 22:40:47 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 25/29] t3440: test --trailer without values
Date: Wed, 22 Oct 2025 13:39:45 +0800
Message-ID: <20251022053951.602605-26-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a regression test to ensure git
rebase --trailer accepts trailers without
values while preserving the separator’s
trailing space in the recorded message.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 4b0b0ee2d3..bed6955001 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -50,6 +50,16 @@ test_expect_success 'reject trailer with missing key before separator' '
 	test_grep "missing key before separator" err
 '
 
+test_expect_success 'allow trailer with missing value after separator' '
+	git rebase -m --trailer "Acked-by:" HEAD~1 third &&
+	sed -e "s/_/ /g" <<-\EOF >expect &&
+	third
+
+	Acked-by:_
+	EOF
+	test_commit_message HEAD expect
+'
+
 test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
 	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
 		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 third &&
-- 
2.51.0

