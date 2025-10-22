Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE72EC09C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111857; cv=pass; b=r/Qmy5bxHiPDE3oqKJmygvvVaeZ2QlnJArwIX7MfDWK5tM4wDf5Ue8rGvH3Cfx58yheLteWWdchSPAD5WYnbs3IAVpa13v7/WiIlU/14n2/rZhBNERQ9yPWBdAswR1rTGeYSD/O2ZpHsDSxmdx8UmG6yQbk40n8tJTNnF7LMdn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111857; c=relaxed/simple;
	bh=CYze2r/wRrWbT0rNUt5yZo58g4BhvK9fiZUiU1qRMQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKaPPCibOF1U7K1wq9LJ+4PAIhCQi9dSwHVLOZo9Iq0l5ytWAHVbjiLqeoOUQlboL3V1HeTNP2gWJHkfDd31o3VcqsA2hMmFLbh6NYjN1HjPWh/wGOFm2+SdZAKOR+HgI2F+tth3jhTX3B1bqYoD5hPmGB6rl9BnygiTrz/EQN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=fhS/2g3h; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="fhS/2g3h"
ARC-Seal: i=1; a=rsa-sha256; t=1761111645; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AKbPrDsDERiuuV/zPy2cnwEu9pSwiofPsZleCOWyNhYktcvwZzJepLw0pqmGRs/WHiTgtiQgOyy+frljm6VQUIUTZTrIciJGOEhmTZ2IgH2GuYvhAZ51y8XZ1Ys5MD5wbG4/Ki4ewEXy8Qe46yInIo0PdeDX8YF3y4HmnNcZVtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111645; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=17Q+RC5DR+l0ZZw0HJrtgw8423B2ucDx/hf8T75f1b8=; 
	b=iA8T8QS3hhamrL937GKUPoHUPH1VAyByAs9+6COKdrZNvY1Wf4rz1zp4b42gUIsx0YZoGQzWYa+hlmyd4UkRmD8mPRBITSUTVKaSXKc9SIFb/30Tw6LawBQetB+4W2DUxI1dWytgAppKr0Ln+NB07XWUe3JlPy/orBlUE3liB6A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111645;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=17Q+RC5DR+l0ZZw0HJrtgw8423B2ucDx/hf8T75f1b8=;
	b=fhS/2g3hyJz3q2spwF0JDjAHupdUKQ+9WGpiQ23TgkSY0Cy0tGJLvLV++h1cf9Mw
	2xpjmuV205hckwnnxZWxZrYGDk4MnJg2FHvG77edyBylBtY7pZQ2di3VGGv3zJe6ulP
	fyQ57LsOmGuAVOUtFhdotEr0iiI0LvZaASRoT1i4=
Received: by mx.zohomail.com with SMTPS id 1761111643156765.8949894429744;
	Tue, 21 Oct 2025 22:40:43 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 23/29] t3440: remove redundant --keep-empty
Date: Wed, 22 Oct 2025 13:39:43 +0800
Message-ID: <20251022053951.602605-24-me@linux.beauty>
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

--keep-empty is the default these days so
we can drop that.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index fbc6f209f1..4687be3a21 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -87,7 +87,7 @@ test_expect_success 'rebase --root --trailer updates every commit' '
 	create_expect initial-signed "Initial empty commit" &&
 	create_expect first-signed "first" &&
 	git checkout first &&
-	git rebase --root --keep-empty \
+	git rebase --root \
 		--trailer "Reviewed-by: Dev <dev@example.com>" &&
 	test_commit_message HEAD   first-signed &&
 	test_commit_message HEAD^  initial-signed
-- 
2.51.0

