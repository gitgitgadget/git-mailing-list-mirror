Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E084199FA4
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952191; cv=none; b=BvuT9N28BZWImdJ23j/xM2SwHSIKSdd3oy02ErYhNVRbpIlYQqqfsEg0gMVjYwlxyWVqipt8KcvGJHnUPjP1aU2yMc+4E1VCOpeomIzkcVfZUDtiku6AjM32Yk2Q4R1ZI/pXyleNSngFG4XYp319b/1F4EOGLBG9p+56CZkt4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952191; c=relaxed/simple;
	bh=GAs7RAu8TZe+wmBCkENTpUGya2ho9jR/+uD1UbJzX9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uutz284GhmhSzX94i0Y0YCT7xKDwZD3Uv/GQz6DwCWo0rAAZqcEDup5DgaGzyuQ5tYMiNt7ymBb2kLtGawSFbEcuvCmDLY6cJn+NzhlyhKuszHpwDAwa74co0nAn5LZo2a3uDJra+8hlHlGAKEaXP9hsTy7gqoHz0p5BPBahp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=QnYsL2Ak; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="QnYsL2Ak"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tPgEe-0042gR-9m
	for git@vger.kernel.org; Mon, 23 Dec 2024 12:04:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b6CMf94hWqinn1WiMMNMI2/53yVM/Fvnt3CMwY2WX0k=; b=QnYsL2AkepqPVEnPtjYaQoSx+f
	30yVRF16omHQAQlq0UEnZb6DTS1DfUDaDVkuO9lA3+TM1pzIy8ga2xj98YePX+WcEbjaM9xzLLMuk
	hXJLFf2I5ljn4XpahiucCldASA4s3mdBlnqel3m2wx+ewtZNnecu4JYTlDcoLU/H7AZM1lJBy5hZw
	pxg4bPwZPOTsZh85VrXAOiibB98pvka+YGml2VjFZj8uN/9Gl3exjpZGrtM1BKxcfE9kP6dPJ2Emc
	Z3VyHGncCS5BA6aFBCXrN2zomslkx9TAMD8ro6LxHrFUj9XWATjDrkbwgphBuzbxFgjvQDlKEhK11
	qQWVwL5g==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53566 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tPgEc-00BYML-VB; Mon, 23 Dec 2024 12:04:28 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 2/4] date.c: Fix type missmatch warings from msvc
Date: Mon, 23 Dec 2024 12:04:05 +0100
Message-Id: <20241223110407.3308-3-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241223110407.3308-1-soekkle@freenet.de>
References: <20241223110407.3308-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17349518669BFD4AD2FCC1O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53566
X-Scan-TS: Mon, 23 Dec 2024 12:04:27 +0100

Fix compiler warings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 date.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index bee9fe8f10..8ae19f9ecc 100644
--- a/date.c
+++ b/date.c
@@ -1242,7 +1242,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	for (s = special; s->name; s++) {
-		int len = strlen(s->name);
+		size_t len = strlen(s->name);
 		if (match_string(date, s->name) == len) {
 			s->fn(tm, now, num);
 			*touched = 1;
@@ -1252,7 +1252,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 
 	if (!*num) {
 		for (i = 1; i < 11; i++) {
-			int len = strlen(number_name[i]);
+			size_t len = strlen(number_name[i]);
 			if (match_string(date, number_name[i]) == len) {
 				*num = i;
 				*touched = 1;
@@ -1268,7 +1268,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 
 	tl = typelen;
 	while (tl->type) {
-		int len = strlen(tl->type);
+		size_t len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
 			update_tm(tm, now, tl->length * *num);
 			*num = 0;
-- 
2.39.5

