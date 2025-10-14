Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AE313554
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444904; cv=pass; b=jfKUzEtECnTydjQww8/OLyApYlBKNTirxiNih99IFlQIfNTyro5JqzgHHLFaZhjf8+zbWjEQIDeQH/DH4A4KT2iEgx9RiWqrNNedw38bU21tkAeizpWZVIYUdNFEU8Tho9h5sT80weCkjx6nTSKMQhSdlc0WnVNer4wi+ugi0Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444904; c=relaxed/simple;
	bh=pG2txUOWUOGinjYC/aBya2pk+VOV7UM8Lls35sLTVtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X87faUXcxNvnuVbxfKkeh8LNSUVOECyUjCIk5vy6P7+En2Wvroe0xssikhSb15eJUlyxnXsDDK21a1+jBERSFaQfu9hyxPw6OqcQOVcJUAazUYCulZih7GdKNChO2RWikAoyJDASWANpY8uKT61cEMvg9XZvMooMBC0CvoNT1Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jrTCki/t; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jrTCki/t"
ARC-Seal: i=1; a=rsa-sha256; t=1760444766; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eQ4WT2Ew55n+uMbLKC+RF6jg5RFQiqHDRoeUbl2N+8DjENA8F/JL+lSTFR2LCLCVRdBABoVE9bockyWgG58wFjkvBUrf8cfA/KeXPAmlpb+cJ187ExvJgb45gFENFpWxFHCCmaWp3+BnbIC0gimRDFPg8rVsPseQ1//epvPlRrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444766; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=DJwGuJkD0KxFWiHaYylpV3JyNn4zJsjoMDy0nxfglv8=; 
	b=LICUhcrw8lOWljewq4FBcSYil/JI/74GcimlylewfRqGyxwqm/2OF67IlqoOujdOZxrqdzu3P1DTxCjAa+VAkvJKgS+lw4FemOEIv5xpC+RVZaX00MGxKxoHQZymgoNNI0BDBhXqr9SFjNigUDMkETnRLlRQZPnYvsmwk8kwlf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444766;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=DJwGuJkD0KxFWiHaYylpV3JyNn4zJsjoMDy0nxfglv8=;
	b=jrTCki/t9PeeqidHZbnZbuPw8QY/TZ/F06/RWhGidDseNNR81TtZf5g/N/pqiliW
	tGct6aI/SPXqsdMPKyrNOqVqaiduHkqjrO8hVWL1wwA9WQY9UyOmWalFALZ1lC5VUev
	1SpqVTpuWCO1NYw4PbB9YIc4rPvgVBKkyuCvar3c=
Received: by mx.zohomail.com with SMTPS id 1760444765534650.9182792245767;
	Tue, 14 Oct 2025 05:26:05 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 21/29] tests: t3440: assert trailer on HEAD after conflict rebase
Date: Tue, 14 Oct 2025 20:24:34 +0800
Message-ID: <20251014122452.1851103-22-me@linux.beauty>
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

From: Li Chen <chenl311@chinatelecom.cn>

Switch the test to check the trailer on HEAD (not HEAD~2) and build the
expected message for "third", matching the rebased tip after conflicts.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 4f313654d6..e1a3d2e3eb 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -73,14 +73,14 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
-	create_expect file2-signed "file-2" &&
+	create_expect third-signed "third" &&
 	test_must_fail git rebase -m \
 		--trailer "Reviewed-by: Dev <dev@example.com>" \
 		second third &&
 	git checkout --theirs file &&
 	git add file &&
 	git rebase --continue &&
-	test_commit_message HEAD~2 file2-signed
+	test_commit_message HEAD third-signed
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
-- 
2.51.0

