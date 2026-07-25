Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD642571A0
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784940210; cv=none; b=X9bS8rOsJuVHumT+nN4iGmV46iT4TIhs2BU2I6jOb7F4zgUozEm6PSvvXZFaWs6be8gd/ud3LXC+yKEv2PuPHtPcIaTXYN4QbMHAJb1PkLPQ41dt6B6Dbg5YbDIcpS83gYxZopZYD5t6icWCilTKg9V8PdfdYHTkSZHbceyqk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784940210; c=relaxed/simple;
	bh=i/VHSfV/DzWZs3tCSBxLsO92EO0Ti3E/VcWIwUX8cbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFIB5wyUKPA8ezVY2BeNKCd7y6dzDgZGpBTZPRwNdb5PdxJ1FOEsd6ecB0UVuJWvjM8Wo+fbZKTGGS/Il5FT7eMjSc2TJFhh00k7l1ge87Nl2viJLKNo1KX/iAUkTCkr86yVi2DPeWHEHEHKZWTwzHWHlExhYWhebz0/JjNGuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nYOwcbix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wgm0rCRO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nYOwcbix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wgm0rCRO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A5C4EC01DB;
	Fri, 24 Jul 2026 20:43:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 20:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1784940208; x=1785026608; bh=YLifFARasdlRrrYlOk+0qO0ofVGf4hTJ
	ri1hZzpugBM=; b=nYOwcbixsS2b6Z+TEApFDilAbksiBROKE88VI9gfyVKTKGrD
	GQyOV/rJvv67CPsDbWoMF0c7RoarCtQ7L7TBY4p7YntP1Ol6D+nowXQwLR/7cY83
	i0EwIhUbsgAPEQRJGclYWjTxZRrkJKppn87xtXCasZjKVzOQqtSMCQx9RakQNeEt
	xXJZOt1WnXYMvbbnUOJpSbyinHQ5RP3upH5T3IwWo13E1e0AYOSAq2L3tN5kjscH
	yP69cbwbsOQ+SY3cf/UkBbMP0/c9V9Klb/Exc9NQZUt8JltSrlrFm2DhdaZFDD4F
	TgJOYoB+MB+Qy1oGoa/vjnLjsyMUEF8ar1AWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784940208; x=
	1785026608; bh=YLifFARasdlRrrYlOk+0qO0ofVGf4hTJri1hZzpugBM=; b=W
	gm0rCROL6hg6XhETxKORkXu5WNdn+IaOGVUQk3spyYFMpcjVO8U1GYntXnvmtJy6
	V0rHcNRlyV49iqTSrQWDhRVfPxs3/v7+wVQDulsjTNOylqyl6pWTOKTNVZpsx0a4
	8v0Ym0hswkeuAKKqx8InFvXr6f1VhIYrP2dGRaz++yh8MCdFREx4Mkhv7SPTmRKx
	eWkfZi5URx2tYjwFYGLaka5B+o/qsx8rZXQR4xz1AGT95zC1L+1iEQxGVJ9zvpXO
	/GwDDIVspLXXbl5zJ6FjJ/7udSjJH+MHTfzc6knXioG92Hd9KT1ZhxkjdgqbyAeW
	aowglPZP6BuJUE5AhYZ5g==
X-ME-Sender: <xms:sAZkatVRvXVwkQNBasfyUnG5_YJTjFHu8HJPQBF4VSTYR2qiJ_t5bw>
    <xme:sAZkalAtTxEP-d5BY_zlPEB_tc82VkGD9-tusrT17ubTGYmi6J9kplPTkHKtfnAya
    BGpdYop0kI41C9ifYOpiYVT0eWkddxX2ue_pu_9s0mn35eeSaYd>
X-ME-Received: <xmr:sAZkamwzqtu-Jsh9IGi1wWCeRcmzxN-5uwCQ8qaQXjn-jq76Yw0elB9QNJpfqPTWx0i1SIklmhgGDQJztaCIbP2f-ehOFXZfKg>
X-ME-Proxy-Cause: dmFkZTGotRkIHdYDbalOd9yEukz/MK8XvjSRxTRwNpG2phy1oqZ8gbUN2Eq/LBCiPKXd4N
    Q4FR/cEgHGSG7CC/ptbLhQ2sn+K32Qzh/h6kheA7FkOAvMr0xVZxRMaHIeCb7n8FBCiyw6
    17F8Oxx+gNnITkrAu4dtpXplmQYjiuiPFVbb8EG6SN36JLBwjxKIkc7+gWK9Sy7uPPGoNw
    iW9FFdIQcI3rxe2Evwh4y2TaMwu1oMRMJH4bXbCxAqP3QJw8hglKXToGq0Lj7By7JQg1mm
    RMzdfS1639+g3YulWTv/+LT+zqdOVRzm4SyjEhh5SrnASKCLBG8II62cUV1ld+DRjklpAl
    PI40iYFgJxPe7ABAnvlUWbwFpRNmNB+BpjcdAm5UpfpIBbQ9VM8ZRB6IfBik8hw+2y/gCC
    HGMh05X65ZxqumOIjwcMxpfaPeHswxCIC3G3FBgC3EAxHL2zPizb5HHCjG37cZS41MYEj4
    cFah5GPe/PF0m0MssqMtCGxK7R4H3Vbmu3vrHDG9qpz2ArmmBSadJxHk8rDmIgJ6BhitUl
    8sB58rRX0kKgIzoqbW58EV6zJWCFUyPuTuWdG4+l6NJQ4u+W0Db/7sRYsTXZKBu3q3l+7S
    0aEF77PnkRsiVI4OfBE6ZeLdkbG4Pft8Ul5K7YyxHCyqjrWxOYYbXvNF7S7A
X-ME-Proxy: <xmx:sAZkaqBwBWpsJicQSdXS5eCgpIK0gljYE6uYYRqkonvq7WPO-iBlvg>
    <xmx:sAZkarYvYgXaJncIRc5DjmjUXJMvGn9y4IlaXrL8IvaRhaTe6xcVBQ>
    <xmx:sAZkaqhVBVyz3Tl0T83qy8GfGR5OudKTgI5RIZI8nlI_iRB3BX-iZg>
    <xmx:sAZkal5y7Q11WhJZlW6jaHXSyPA8S3UbgsH20TuVCCf1z5ibSXEs1A>
    <xmx:sAZkapCb7M01bHrkr5EFsf3z2N4aRW_REcpnX6ComlWjFpOpGd-GCKcZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 20:43:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?=C3=89ric?= NICOLAS <ccjmne@gmail.com>
Subject: [PATCH] remote: plug memory leaks
Date: Fri, 24 Jul 2026 17:43:26 -0700
Message-ID: <xmqqv7a33nm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The in-core data structure used to keep track of
'url.<real>.{insteadOf,pushInsteadOf} = <alias>' settings is not
properly cleaned up when the process is done with it.

Fix the rewrites_release() function to free not just the 'struct
rewrites' instance itself, but also allocated structures that are
pointed at by the 'struct rewrites' instance.  One of the embedded
structures holds a 'const char *' to point at a borrowed constant
string from a configuration callback.  Since the code does not
modify this string, stop copying the value (alias URL) before
registering it in 'struct rewrite', as nobody is freeing this
member, to avoid leaking the extra copy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * These are not recently introduced leaks as far as I can tell, but
   the new tests in en/submodule-insteadof-remote-match expose them.

 remote.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 368a43c1b2..e3d4b25040 100644
--- a/remote.c
+++ b/remote.c
@@ -309,8 +309,11 @@ static struct rewrite *make_rewrite(struct rewrites *r,
 
 static void rewrites_release(struct rewrites *r)
 {
-	for (int i = 0; i < r->rewrite_nr; i++)
+	for (int i = 0; i < r->rewrite_nr; i++) {
 		free((char *)r->rewrite[i]->base);
+		free(r->rewrite[i]->instead_of);
+		free(r->rewrite[i]);
+	}
 	free(r->rewrite);
 	memset(r, 0, sizeof(*r));
 }
@@ -469,13 +472,13 @@ static int handle_config(const char *key, const char *value,
 				return config_error_nonbool(key);
 			rewrite = make_rewrite(&remote_state->rewrites, name,
 					       namelen);
-			add_instead_of(rewrite, xstrdup(value));
+			add_instead_of(rewrite, value);
 		} else if (!strcmp(subkey, "pushinsteadof")) {
 			if (!value)
 				return config_error_nonbool(key);
 			rewrite = make_rewrite(&remote_state->rewrites_push,
 					       name, namelen);
-			add_instead_of(rewrite, xstrdup(value));
+			add_instead_of(rewrite, value);
 		}
 	}
 
-- 
2.55.0-576-g1c3ad6b142

