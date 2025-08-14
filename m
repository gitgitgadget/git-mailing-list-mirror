Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0771ADFFB
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184162; cv=none; b=cbaZiXjOl2OxHA1rG+EWCQkvQVjXI4KPMP2Amt83p9qyMmjwbIV+vNLCh3kcfO7biIOjp4LkOz6H3RRthK7hK8XIMs7rP0VV7dzWaxjEkHB2cbYqkgzcy1ozNp8bjciSl7aBWq4OmIcvdeFTz64DXNN25w3B4VteHQBe78yI1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184162; c=relaxed/simple;
	bh=++jSLhspqpUbeEWHBUyaZCjGfmNM03BFW+DlbAvzyJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpRfEWa5/c9ROcC4Bkiz+AnnSL7F/AmrxkkvRe3AwyFYN2LMyw5Y7V+WxXpRp3vSniJd9i6uKmI0STUjrS0bQ6IjaJmaJNS/yBAFf417bDAq2Z577jX3rH/X+dKi/KKhIxBLuS04SVmvNFEeCYLfb/WFvPWzAFpm4crJ0a0FOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fg70dJJR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDjqimd/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fg70dJJR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDjqimd/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5242BEC0128;
	Thu, 14 Aug 2025 11:09:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 14 Aug 2025 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755184159;
	 x=1755270559; bh=vDsmR0xwXc5wKP9Pnz8XBrVuuIokRthjkUI4H45Sbo8=; b=
	Fg70dJJRZhBDcdJrMegWyUou1MZ1Y8jX0CFNPBgHRMAu6tl4VtuMEB6x97MtJzwt
	kwl5iVXVkMc1X8uug3+GXR/hge5OhNSMt/LPg3fTqjj7y8uQEj+lIRCvRlPksHo3
	XEVpyfBQJDVWPMd6Dnk0WPYRcHOD6NaiRJ39xu1mNbk9Ws41hRX+2CZNoWxeOAP3
	UqsAU/2kjX12Eaox2V+r0vIDcis48YkYLLgCjZjUIYZ5ERoyysshPeHUk54Z5ay0
	5kXHXySnR7RnMhDobGY8EZ0Gc+SpPw/zmdeBNVCTjAC999/UziIyMLIuQ6gTsOGP
	2BYeMkaWtsppiARGecX17Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755184159; x=
	1755270559; bh=vDsmR0xwXc5wKP9Pnz8XBrVuuIokRthjkUI4H45Sbo8=; b=Q
	Djqimd/aTB2kKPgIOxbxuRWSACVV1mhWiFgE9INpjbou+VI8rLkHtPfl/1PG1rHl
	DYUpTmvAOFyxQWTeMYV0ml1SQkp1+kvXGrcWx1f52wbiXpoRKN0eARy7PWB76jGT
	EY4nlnETkKeArr9sPeyHp321hKYK0p9ARFG4BCshiTy3sxHu70Lo5rQXxHXrnAfb
	w0Tp5VwdpjSPE+B8T6n8jTpQ4XGLNAEluzbcy/W+KYb3WOxTy1jfp8hEiVx+M9nu
	AHG2SyVSwVdHEqLtQV2Qxqf5VDzrOZTgAR5erWwJYmoUtC3YBL97MtMZXUYTqAON
	QZtSNjgd+Bs2NSK5vqcTw==
X-ME-Sender: <xms:H_ydaFQMeHNDzbozimYcVxQMXR-1vKhARP5zTf4YCNeEYpyMGMkVXw>
    <xme:H_ydaKRKs92yMFB6FpQEBq70UZlJQEXSOa0QkMoMnRM2LCLE3_mvMLGcLI4MdX523
    NmX20vmn2IJdbJWNA>
X-ME-Received: <xmr:H_ydaBRKNwehghMh94Tj-EiO4B2fKUw8l8GqDna97lWqspH2oCUA4zNPaFc0X_nGWZLuSvl8goW23Jgzy99lL1hHdHMQGPTgF93jtBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhhosghoiihosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhl
    vggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H_ydaH4_npbVWYF7IOmHZTtXAaaNFxL1F-JSyJaWJaMgNZXO1K3IbA>
    <xmx:H_ydaF2WkB5lfQ_kXlCy50dohk91492zPd2TLNp-mkcIKnSGMeaGjA>
    <xmx:H_ydaKDbnIQeAdFsoqahAMhshNomMbdEukU0vU3QlIMCs0zl9hc7tw>
    <xmx:H_ydaIOEDJPzOoZY-BoNSX75xlKL5qY33hdEDxsjCZP0NYtCYuCd-w>
    <xmx:H_ydaPNSjtHXu3QSM1XbNE14imqwgjZCW7nZGF4k716yvrX8Jq3VISIE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 11:09:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jon Forrest <nobozo@gmail.com>,  Derrick Stolee <stolee@gmail.com>,
    =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3] abbrev: allow extending beyond 32 chars to disambiguate
In-Reply-To: <xmqqzfc51xvk.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Aug 2025 12:06:39 -0700")
References: <xmqqfrdx517b.fsf@gitster.g> <xmqqzfc51xvk.fsf@gitster.g>
Date: Thu, 14 Aug 2025 08:09:17 -0700
Message-ID: <xmqqh5ya6iua.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

When you have two or more objects with object names that share more
than 32 letters in an SHA-1 repository, find_unique_abbrev() fails
to show disambiguation.

To see how many leading letters of a given full object name is
sufficiently unambiguous, the algorithm starts from a initial
length, guessed based on the estimated number of objects in the
repository, and see if another object that shares the prefix, and
keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
which is counted as the number of bytes, since 5b20ace6 (sha1_name:
unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
change, it extended up to GIT_SHA1_HEXSZ, which meant to stop at the
end of hexadecimal SHA-1 object name.

Because the hexadecimal object name passed to the function is
NUL-terminated, and this fact is used to correctly terminate the
loop that scans for the first difference earlier in the function,
use it to make sure we do not increment the .cur_len member beyond
the end of the string.

Noticed-by: Jon Forrest <nobozo@gmail.com>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To tie the loose ends, here is what is in 'seen'.  We may want to
   merge it down once 2.51 final gets tagged.

 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 11aa0e6afc..4cd1d38778 100644
--- a/object-name.c
+++ b/object-name.c
@@ -704,7 +704,7 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
-	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+	if (mad->hex[i] && i >= mad->cur_len)
 		mad->cur_len = i + 1;
 
 	return 0;
-- 
2.51.0-rc2-158-gf97fc618fa

