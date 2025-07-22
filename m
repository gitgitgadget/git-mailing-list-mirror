Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EC27A92B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211434; cv=none; b=u69pvbECOc+hLJj5solBvkE203P0LhCy7onQHYs0GF21OS1StiuPjZ0yC21l3SosmlJu+9C4FHOLs8iI+0CBVvZMh+LyU8GPzMpYhGpZV1GkpPcW3prppis2Ad8JL9f/zHomWWv3T5y6ao8eN6U8KljU46CJ+VPMvEU0SZ6iSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211434; c=relaxed/simple;
	bh=RpgpYDtReYMGRp0AMIUa+/akzKVUTtAlFXCs98542wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkdDarnVj7gMWPGUYMg3GMeQjAnwh3ngJWexPokPRCXUjFNH1XyVBNbcvg7iCqDZuIE68BCN64GpNGYALnrtTq0BxSMvgjmJVUPscsPREVTGyeWL8TD8SoWtc/a+XXN1zDhHJ8abKdQ5wCHe3K/D2bxMeA1qEbojxgLQv5vuiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b=ZjpmVWUC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b="ZjpmVWUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1753211429; x=1753816229;
	i=jonas.brandstoetter@gmx.at;
	bh=diZB47j6+FessrcrBh4q5jGX6KdoxlMTPxERDYyoSwA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZjpmVWUCHrV+nJGsk6U1EUMjcdd6PXWiyJREGNGrSL+GUiu8bh9bPLsnyKsXrqbm
	 rxrmIUkXuSaalvW8r76b2K29QZaCguQuAp0VrPyId2ngQYgdFcDcpWfDG2UOIThHc
	 6YB6YqtUYukvE2NaxcL+toOq4u8svDI8MWl9kTaxlPdUHQWCro93IB7myIIcGQURB
	 Ah4nIu3OiyUxOj3aJbSkiySm3byaU8g/kgJR0m83vb01V9+MNP2F8Jxz24y1lqf3u
	 YcO3aegwNYWMWOLD1wI8+FSWCSXyJnWuw05JheH+bpiKAXdWCf5puwFOF5ToYYYGN
	 LeTOzObBgAYoJoXlKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.fritz.box ([185.89.163.201]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1ukOF42ZIH-016HbZ; Tue, 22
 Jul 2025 21:10:29 +0200
From: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
Subject: [PATCH v2 2/2] t7510: add test cases for non-absolute gpg program
Date: Tue, 22 Jul 2025 21:09:22 +0200
Message-ID: <20250722190922.51183-3-jonas.brandstoetter@gmx.at>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
References: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w/ApEPbb6RSi3RYlPf5+Ru1NWYdeIimi/V89HT/uwWkAq2ppgVg
 yip9tFv3ogQpPa+T07tLE+Tn/N8ikMncnu7qihiYrPJsM+9ixtDlrd0LLFkNeRutfls5xHq
 q7vlGGnzAgM059oRu1Oq+RWHqHyNB5F1sPz3ygeOCmdmN6orRu8faT34dOUxJgBKY3IsXWA
 Dsnct2wxZqM9zzH6PdnYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oyzm0e/JlxE=;w8IYurU+iFr2QAjYAJ5L45MAlqT
 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
 TLBhpD2paLyMISDHvNZw==

These cases cover scenarios where `gpg.program` is set as a program in
`$PATH` or as a path relative to the user's home directory.

Signed-off-by: Jonas Brandst=C3=B6tter <jonas.brandstoetter@gmx.at>
=2D--
 t/t7510-signed-commit.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 39677e859a..95d2ebe277 100755
=2D-- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -449,7 +449,17 @@ test_expect_success 'custom `gpg.program`' '
=20
 	test_must_fail env LET_GPG_PROGRAM_FAIL=3D1 \
 	git commit -S --allow-empty -m must-fail 2>err &&
-	grep zOMG err
+	grep zOMG err &&
+
+	# `gpg.program` starts with `~`, the path should be interpreted to be re=
lative to `$HOME`
+	test_config gpg.program "~/fake-gpg" &&
+	env HOME=3D"$(pwd)" \
+	git commit -S --allow-empty -m signed-commit &&
+
+	# `gpg.program` does not specify an absolute path, it should find a prog=
ram in `$PATH`
+	test_config gpg.program "fake-gpg" &&
+	env PATH=3D"$(pwd):$PATH" \
+	git commit -S --allow-empty -m signed-commit
 '
=20
 test_done
=2D-=20
2.50.1

