Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B682E92C1
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069547; cv=none; b=DvRklPaCXyE5e8uQXOR9IkDP42dj57d7ubidyYo9IcJyCYXApbkVAV9yKCdvx0Pq0DvMyP5Irx/eHtMDG/hyRSJLhbhHneGeAujUCWHU8wPP3G1o5eraH+zfa2uRU08qBPi/We3MEFAWtvqQnu9JRl2CtWhwxa4nQQAqgKIwcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069547; c=relaxed/simple;
	bh=Bw/6mSuZQ+bEQfOpI+bLEZYv/Sk8tNkPyo5Ec827i04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItZD6pSRAb89oYObAjayUpsA7mndkcerLtCdJKlcrqUhfsFhRluwT2K4steK9BqZB3W3HrpXlsKTSmDaPHxo7TBxTRHFKmWdSTBTw5fF4f6zSPajKig+XXEM1ijOkVmBCdCh3W8+fxL07t473CfIDuzxWvIhxbjqPt6RfPxlu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IZc3gxxI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzs5k+hs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IZc3gxxI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzs5k+hs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 828AFEC04D8;
	Wed,  9 Jul 2025 09:59:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 09:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752069544;
	 x=1752155944; bh=P9EGcNHFEz+bHUQrugDUYe3KgEBlRi9GVJqiSyQYG6M=; b=
	IZc3gxxInpaHGqGMYhQiNT34U0NFWxTxVjeyoYK4EDmtubikndx+WCs4cFjzuIlx
	J8qsGWYGTzIHJAiqYfD7knGJRbPUgZ1ZbBfC+GxTdrCtQ6wg8V7UBaqSMbLMHQLW
	2CRezAtObcltakywMWo3a2TaAsNVeD1ed1IVGBbCK4F7HC/sBdFudKFBqiJCU6SO
	jLemaAKBAEzVda2pOVsSlTcBzodMuzk2RdWpFBcbpVJkxUMTqkXIHxj0P3HQ7PR9
	3iUPrumMhSQ6C3aaaN0P6+FeceVJsZchU5vuSXdlBUNqG6sMmfCvH+19f/seYHDq
	bZlIutUspvVRcXbRR30DVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752069544; x=
	1752155944; bh=P9EGcNHFEz+bHUQrugDUYe3KgEBlRi9GVJqiSyQYG6M=; b=d
	zs5k+hsxaoXfG9Coo8mLfacRm9U7V2lx/jhGfeH8XveXhCKlIXlZb0eOEopgocys
	IXAB1cX6/K01M+oue+KlUBY+VU1MzBwpn8OUsNWgFA0xejTaXoOVTr5/Cvfj57wq
	eq4eRXztReqcHUte/Ezyf9TUayFYf/rcs+uweSKWgP0gX3qE6dF5mD+82mLyzdtg
	bbS/xTbTVJQxkSF329J4W9CJ7ho896VIBA3MMEBA6CpjbMS4gWq9SlN318GSGAmI
	jtD/Del8oetGIlz7jzEX49e7CUzDsfi4aM24wARpAweoYzU8+Qu3MrjwZAQGvyUy
	u5Obth3DWG9XiSIWpoLoQ==
X-ME-Sender: <xms:qHVuaL4oYrNl_jZ7weBMxLXBUZEjC09Yu1wKud_YrzHzcV3eHBUYMA>
    <xme:qHVuaBED1xg0z4pcNxjjE-QYtiwa-NkdlzIC_DpqQub2I-dkS67-V1TWvO1cWDES0
    9OXbDwKXFgUPzE_Yw>
X-ME-Received: <xmr:qHVuaETd03n5q2orKDobPp6bMa5QgL362PdZwM-arJniXlMV1evZtp75OBmyMxN_KIjy7jkpE-siXpFwlEqL0NUFxmC0Mlqa0r1IoVaCw0J7FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qHVuaKvLdhRl2DLGEY8v7YYvZWm7RVVXRG7Sz-xWoSe-ii9JO4p4RQ>
    <xmx:qHVuaDxFzBqXFCJ8KArx59L70uV97YQ4mu6uGU1YEfFc8NkwX_2iRw>
    <xmx:qHVuaE4VEqZHd4KhAmH48D5rWFxLZVDCzOaUgsEDQSXNCgzwzHnMvA>
    <xmx:qHVuaNUdke5weJS1RsbkwVuWxNzS2Kvlt23EcsA7jVaAZbd2z6TTuw>
    <xmx:qHVuaGdbPMEXAlqT_Oevmz6rN3zupIIS8wdKnM1LiCvIABQq73Khqxfz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 09:59:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5789c316 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 13:59:03 +0000 (UTC)
Date: Wed, 9 Jul 2025 15:59:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] parse-options: require PARSE_OPT_NOARG for
 OPTION_BITOP
Message-ID: <aG51pI-_xv5abGwz@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <802eba72-c100-429a-80b7-7a0e8b6559ed@web.de>
 <4d91754b-00a4-47ab-86eb-0da201e7889d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d91754b-00a4-47ab-86eb-0da201e7889d@web.de>

On Wed, Jul 09, 2025 at 11:44:09AM +0200, René Scharfe wrote:
> OPTION_BITOP options don't take arguments.  Make sure they are declared
> that way using the flag PARSE_OPT_NOARG.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>

Nice, splitting out this commit makes it way easier to understand.

Patrick
