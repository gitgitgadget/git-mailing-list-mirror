Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB146BF
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896402; cv=none; b=bL6OpPoHiHCsXet/ZW2/pYpZ0EW5Ia48cbNBXYB+NOGwG0sFxapARbElcEoCfSDz/O3tbAixzfGIEH7zRsGAPLihrNYMeZ7obgLPRns7ZilOZnZK1wFsn3Wf4eAbvXyGgeJmmWDpGzUVWRUGCBCTJHSgVk1rm7Nrbp9cRGd0brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896402; c=relaxed/simple;
	bh=Eg1Ub5ioWmudowdm+mEoqlte6wo6Mvt4aV5ZGF/o25I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eFLEKfZV83gT9k5Kp+WcDLK94YvoMNYwkre6MYXLTDHErqXyztqmspMPpGWP4B10hcbTGMtQI4SGwGVei6Ah6htmofHHHW2bm39EMN2lBrrK9vmW0js2TuYNQr51xwCYK2kUStADFdwkdzal0llhElMHBYHLSf3YUIZ1wmeTLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=I5dqXXYU; arc=none smtp.client-ip=195.4.92.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="I5dqXXYU"
Received: from [194.97.202.53] (helo=sub8.mail.fnrz.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tc2E1-00EmPd-PT; Sun, 26 Jan 2025 13:58:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3jzfFgbqyo7aV7LaySd9WcqP5Sp+pHT39X8Lj1EbI8E=; b=I5dqXXYU5Ufl/MvsKsBzqznZoX
	DTT8bCBA/Q3y0NtZuWK4LR1vSEvHj2tvzbbqsgAMafNvRBdPlDFpU0lka+xN2skU4Z6mDNsnl2Wfo
	f5XdhBj5TLOOPWgAIu8q5rvozS7hTwWjC6NSNKPevSWeBZyPfR+vAaQpQYjAlGPBsUYNj/ABoxcgU
	pYzffEaCvYUJclC+6Lpm/k4IeWMMBx0oDruhMwfXrMcOxz+01j6S1d66AcDhPPeLWTQ/VtLRBvSOR
	BUs7D3VzFMCjnRc0/7V2eaelgnL8X08nzQO2t8ietxGsl5wReuvHUIy0Ed/LA2xevgo8yQR2Wec8h
	SUzruvUA==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:49204 helo=localhost.localdomain)
	by sub8.mail.fnrz.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.96 #2)
	id 1tc2E1-008RKU-1k;
	Sun, 26 Jan 2025 13:58:53 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v3 2/4] date.c: Fix type conversation warnings from msvc
Date: Sun, 26 Jan 2025 13:58:50 +0100
Message-Id: <20250126125850.3195-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Reply-To: 20250126125638.3089-1-soekkle@freenet.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1737896333651569745F97O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!49204
X-Scan-TS: Sun, 26 Jan 2025 13:58:53 +0100

Fix compiler warnings from msvc in date.c for value truncation from 64
bit to 32 bit integers.

Also switch from int to size_t for all variables with result of strlen()
which cannot become negative.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 date.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index a1b26a8dce..0a3fafc8a4 100644
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
@@ -1270,8 +1270,8 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 
 	tl = typelen;
 	while (tl->type) {
-		int len = strlen(tl->type);
-		if (match_string(date, tl->type) >= len-1) {
+		size_t len = strlen(tl->type);
+		if (match_string(date, tl->type)+1 >= len) {
 			update_tm(tm, now, tl->length * *num);
 			*num = 0;
 			*touched = 1;
-- 
2.39.5

