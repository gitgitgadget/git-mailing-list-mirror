Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E981DED58
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190884; cv=none; b=KvpObzqEBV5gkWxlbq3FHxIuRjO40vItb648c6+zUZ5UuFMt8AVnXItyJDzYQ6OpgGWNxkZ21LGbB4HRFURQftAoUjpPvKhnGEnD3txv07W84L8NnuN6FYrV4PeAaKjzZ8gfuhAXCN9YFoMNS8tUL69pjdbu6bLLbj2iYLQlFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190884; c=relaxed/simple;
	bh=Q7/s3knV1iPBIaqsacFXfftdYGSrphdiQFTIQ1Sxu7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkrH4ZNuaFkvcxj6WjlZqS4/Mp7Wqtx/p7NGfcSS/JneyPOaXkPk52bP51r0ILrro2qnREhr8raF9gPFUKwX6x6RFIrgrtHskzFmkMkSudiqKXMfgIvS1C+tb1i4ebd1WWDZOx/EymqPM9hi2nw35eUHRXLZSWAu2oa07uukZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=hHBY8UoZ; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="hHBY8UoZ"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tUsTd-003JHA-4Z; Mon, 06 Jan 2025 20:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=unC5M9H6fSQmOq4y3fWMF7t0vqeeXbk15rlW2JsZ6c4=; b=hHBY8UoZ3JGuhBhxpLRgjp091q
	WiTYIntGysViNvBnxOFdgUNet8rrUuyBN2kqa0iCIxd7IoQT6y+jzAoBc3y2SV8FWh7pEen2InZ49
	EmfxYaAkiYmE2enJYiEbYCwNlp25plv4hnp0vaq7Jo/qvuuB0sfjLD5v0KsQGX26QRnB5P/ZAGEtU
	efaLM9Erf4tYbaCWM/oTDt4lxwaBC1ZyIKgjrU8EetZsxb2QaRHqzmLbUc9eJ5grb/zAsY88pbr3Q
	2JRhreKcylF3fV9/DjHGLWEO6mVmOwQu1bs/+KDm5Eme/ahZHR2/i5Le4wm9AcyzEt+URaD6LG/gj
	4F9jqeTg==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:46380 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tUsTc-00Brik-RI; Mon, 06 Jan 2025 20:09:24 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCHv2 2/4] date.c: Fix type missmatch warings from msvc
Date: Mon,  6 Jan 2025 20:08:53 +0100
Message-Id: <20250106190855.3098-3-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106190855.3098-1-soekkle@freenet.de>
References: <20250106190855.3098-1-soekkle@freenet.de>
Reply-To: <xmqqfrm9t6up.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1736190564167A1567EA1FO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!46380
X-Scan-TS: Mon, 06 Jan 2025 20:09:24 +0100

Fix compiler warings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 date.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index a1b26a8dce..17a95077cf 100644
--- a/date.c
+++ b/date.c
@@ -1244,7 +1244,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	}
 
 	for (s = special; s->name; s++) {
-		int len = strlen(s->name);
+		size_t len = strlen(s->name);
 		if (match_string(date, s->name) == len) {
 			s->fn(tm, now, num);
 			*touched = 1;
@@ -1254,7 +1254,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 
 	if (!*num) {
 		for (i = 1; i < 11; i++) {
-			int len = strlen(number_name[i]);
+			size_t len = strlen(number_name[i]);
 			if (match_string(date, number_name[i]) == len) {
 				*num = i;
 				*touched = 1;
@@ -1270,7 +1270,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 
 	tl = typelen;
 	while (tl->type) {
-		int len = strlen(tl->type);
+		size_t len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
 			update_tm(tm, now, tl->length * *num);
 			*num = 0;
-- 
2.39.5

