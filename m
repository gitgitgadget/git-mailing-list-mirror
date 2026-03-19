Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B035A933
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959878; cv=none; b=QY3Iff62a8iT6YVM27Rq4eT8Em8S0ZevKKxFb4A7KIWIc2L+YXYtzhAb+fwB3G3KtjSuD5wxHZ0JzNTnrFo4zQOrT2QGrpRTyjI0TeWnd+pwkC+7lTUR1EqlYie8YPPiQ8m8EDtS8vm4OVyyYs49BN++cyFv1y6sgGOPkavBs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959878; c=relaxed/simple;
	bh=Qp1zVDNfSl6ecXhm5iRfAjoj+NbOhRnI2nmr63BXG9E=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=ewRyBhFAmWqqAcN0MV/O7wZRiHXKo0NASJ5XDrBC+aLRRfWKgOjV+A26C23gxZeFNRsg7DzoHGWgDoO4Y5cSAOZj0FJLVVJ+DycwzHR7jOWEuaV2TZxccyNOpDxvxuT/GDKegkX+4RXWq/BCaiKFDgvvAdtRlItV4qNsxabn6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QnoCQmyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WA8XKZuP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QnoCQmyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WA8XKZuP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 222107A024C;
	Thu, 19 Mar 2026 18:37:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 18:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773959875; x=1774046275; bh=lmWn+cQCXNgjbvfITofoz4MV7/CMjZaL
	WaAPxOg1WLY=; b=QnoCQmygYFvRPApuVFxxo2k18Y1YYeSk4OOewwQ5JdGoYtcp
	nsyEP5QbQD8+d/2in3foqEsDIl6DjJrzK01oE367+mCrcqZONBu5CUSoMATE86r0
	gG36q1aYMaLbEfl+l9l/lnBtu4mUBsFj8EzKCcHvBXiwWUkQZzbm1X0Hg7WR0s95
	zPh2Qde/kEcctUO5z8tdHggj0wlQcsLAyAinKVV6a+2dUCIdtv2IxNG6fET99kDt
	KzGxcQhT3vzmJoxVPWZJ10StLtccU8ik0+AzWekkDxT56Rxi5UDFiPXGfmuTKU/G
	Jhwu3UWtBIQQLJlp5HchH/pF71WuKOZs7XlvCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773959875; x=
	1774046275; bh=lmWn+cQCXNgjbvfITofoz4MV7/CMjZaLWaAPxOg1WLY=; b=W
	A8XKZuPsu8nOpcbunijoEw36yMl/pAwcj14vF9nE0QL/xEbDXSTJB9hvrO+L9iIh
	qvwqvWZ/iUuo/opYQh+p8jsS3keiB0bI8pmxJb4gkufBmz24v9XHwryGA3Jz7TFj
	vk28HHtEt9RkLTqzeX0Y5szUXKWNziH23bI75uJvADycX3aO2mILKRglwMHw/8Yx
	OIVviKOQDvaYFIdDtExt6loFqbRWAcWroCJL5wJnGR8ucgeqNNcsqqGeGyov5JQJ
	P+oAI/HwyhnUEc4BlvuDEeOmxgpP0MOaNxRissnsYHtl8wBcy+nGjuyh/ZqVB2Lr
	tBTNnZpXP3z8M3jXaYVUQ==
X-ME-Sender: <xms:w3q8ab0LDD22LJgQgv61XaTbeVJubKxleRstJUS9InQ1cQdymjGQKw>
    <xme:w3q8aRjFujpGBKLmtrsAliverb3qoP6Em83fMbmtjznHQqseAm0XtIHYWPvcxi3d6
    IwWSHDwPx-mccHX3tTbQr-G58JOQHq7qVovFxR4oEeRlB1LlqKGgQ>
X-ME-Received: <xmr:w3q8aZSDN4XffLOJjG1CdJ7h4QlCrIP4Zbk-bJVk3exLE-4qQ7Hg9xvAj0iJ92SSNMPrH618e4tGloHCxzzd536r0_ro7PURIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffuveffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhteefgffgvdevteegvdegiefffeeule
    fhjedvhfekleduieevveeutdefleegueenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:w3q8aaiBFCbIr6IXPM7iLOSdj0YsW7H5glUcvQ08Eao3BoJz-cJr7A>
    <xmx:w3q8aR6geURFfInhB1nYYJCwArACEM9MSe7ugDqGItgoQAtv4HXccg>
    <xmx:w3q8afCh3RdZJA4WYB9uBxcbKT54CVPXOAACNi_BWd4Vcl59T-Z3xw>
    <xmx:w3q8aQad7h-XbirsxPsXZDdcDP15MvyWsr8Dz1gnYp6haFa502buew>
    <xmx:w3q8aXJLBcxDhBRGiqiOrBsWIetlh_Eg1HwRlbMixYa0_GstupPkl9LZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 18:37:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Date: Thu, 19 Mar 2026 15:37:54 -0700
Message-ID: <xmqq8qbnigxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
2023-01-08) started to use the REG_ENHANCED option when ERE is not
in use on macOS.  The build seems to have started failing on
macos-14 CI jobs at GitHub, however, as apparently not all the macOS
platforms have this flag defined.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/regcomp_enhanced.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
index 84193ce53b..51e1358170 100644
--- a/compat/regcomp_enhanced.c
+++ b/compat/regcomp_enhanced.c
@@ -3,7 +3,9 @@
 
 int git_regcomp(regex_t *preg, const char *pattern, int cflags)
 {
+#ifdef REG_ENHANCED
 	if (!(cflags & REG_EXTENDED))
 		cflags |= REG_ENHANCED;
+#endif
 	return regcomp(preg, pattern, cflags);
 }
-- 
2.53.0-816-g44373249a2

