Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E3308F38
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466734; cv=none; b=o6nB7FLHmJ21krK0elY+Ii8Jnhyrpw3sGuTxjL4rg6XuQBPfpKW86eu5UtS5JLjHw5/H9PZd4Pf+fVQtWCjxedrx/TdA1rOyQpK0bdPUBwEzxGFOJbOQwETEMcUkCKZRE5P/MujVsuUlA0qXvg+Ymg68JyL09q8Sp2rwk9mWL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466734; c=relaxed/simple;
	bh=k3G/t8APawwshlr5hPBrMyfnTp4EkQkqthRyEFMKfdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGFzCABYiF37YQ4e0FORvisDTgguWz590/Fqg3Jm0RqF4DFg+cZJm4/0bEVefIzw4krSWwum+sz2khcZawlD3iIQr9+n6ooi/L7C4iQGAzElz+v1blkaOERVWAyWHLNi76Nt135Wyfi82wv9tQf/P+jNYdnHDC4MnZrecnT26yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJMR1Wxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FpHTPoh3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJMR1Wxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FpHTPoh3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D99FF7A00D4;
	Mon, 26 Jan 2026 17:32:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 26 Jan 2026 17:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769466731;
	 x=1769553131; bh=xbMGw3Y7+IAIDe4VfLSW+B23R4FANWtenK4gkjFurrw=; b=
	kJMR1Wxh1qE1bohw/62/Vcnb4mZ1E2YCWi40Ud+hn9/Z6S8d7H6DVTiWfRkJB3z3
	f4WMRDECOeCBxFt/wAdRqWSR7Iz/JJW7j4QhppYYo76/pqVNbP/PelwdIETgeRK7
	5pFwKFXQvhynndGN3S6IAVQakPmaOQhHRa9phxcQJsaKLrf0GIzYVO9bDv880z5b
	L5pd279Vp5JxOigt10Zxl4DEcu8mAu4lyG+MclwnH97vwFrNGj/3YEdfLUVjR9cg
	ZpKEI13dOXFHzDO3QXlF4Bc+8oxVxwQSq6Qd8CD+XxlQRDpLllbBhTxzvghWKcxi
	j0gV+ept5Jm+7vL2Ha6+fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769466731; x=
	1769553131; bh=xbMGw3Y7+IAIDe4VfLSW+B23R4FANWtenK4gkjFurrw=; b=F
	pHTPoh3sQVx5MxBeqtgiDHufw5SjtBSUDmG2x+9u9/q6GzxYAbmmINl/gYgaUpWB
	43sTyF4kb5EVFq3z7fVHme7i9eE02wsKmjXsmSFxb3T+EeJzIJjcvl8QudEtgGJ6
	KNcbIQ1gCPtbEX+RlHx0eGCufQhZkp0kpHiNO2gZom+Ic21gNHbKlqUMkFRdf0eT
	61DXoVayJ4KWUoensChXb0PcEuxHYhSeTBi7GEmbE1zv2PlcqqjYXGRY/noPaEDP
	2LaAsLVvf2PRYXA+tIxTRqZnl4CXCnPi1mkkB66B8APodrVEA4XWwoLjskjHsR+/
	K4ymp/MI7NVd/+g+VfGhw==
X-ME-Sender: <xms:a-t3aR_ULcCPydvaqqgUM-PpOEsJLX2eL5dAuFQU__6Fa27y3t7CaA>
    <xme:a-t3aX8veW1p_w662W2GH9jwh611BV65z1FMR0Mu4dXadL3sPmAlFLruRuyUisgEA
    ijWgVja8NtW4GGaYBewlaNXQb2fu2LJf2uC-6klkJSt3p7JxrNTqA>
X-ME-Received: <xmr:a-t3aRQvnVNhMiMCF0S7GKL1opplnZft8prGGHB7qvfs_gOALCN4bFtC1US4J3SGqd_SpoqFq-JfdbZmSHHKkFJsS0lPPdCIAIwyqR8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a-t3abdxWB-VEeIbzFOJEcoqI7fHC6qHrs67mUV_L_j9JDyarrKYbQ>
    <xmx:a-t3aVCpO51XmBJohYKNAiHVsWMDXnjEQwgtUYIXI7o6Z69XcxBCNg>
    <xmx:a-t3adlWklSbHSpxQNtePQOfUq7nbHtstUGwXn7S4K-PE1STMcvmSA>
    <xmx:a-t3aQdMPC5SKpV1uIBSWadKr8c4dPjkLYrwA-QIIleRhAUp3VF1kg>
    <xmx:a-t3ab-neVaIIrzYLeCtrrRyeMEQkHSybmDwqyIytmGGa240ggFWcGHi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 17:32:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
In-Reply-To: <20260122192337.GC2098026@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 Jan 2026 14:23:37 -0500")
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
	<20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
	<20260121211128.GB723458@coredump.intra.peff.net>
	<aXFosXv328ZPjlcw@nand.local> <xmqqcy31pscg.fsf@gitster.g>
	<20260122192337.GC2098026@coredump.intra.peff.net>
Date: Mon, 26 Jan 2026 14:32:09 -0800
Message-ID: <xmqqsebsgg46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> I don't think there's any disagreement over using enums in general. It's
> just a question of what type to declare in function interfaces.
>
>>  (1) enum gives a false sense of type safety to casual coders. If I
>>      have two enum types and pass one to as a parameter to a
>>      function that expects the other one, would the compiler help me
>>      catch that as a potential mistake?  -Wenum-conversion is not
>>      enabled even with -Wall so I am assuming that the compiler
>>      folks fells that it is not reliable enough.
>
> It is enabled with -Wextra, which we turn on with DEVELOPER=1. I think
> gcc will catch the most obvious mismatches like:
>
>   enum one { FOO };
>   enum two { BAR };
>   void func(enum one value);
>   void doit(void) { func(BAR); }
>
> which yields:
>
>   $ gcc -c -Wall -Wextra foo.c
>   foo.c: In function ‘doit’:
>   foo.c:4:24: warning: implicit conversion from ‘enum two’ to ‘enum one’ [-Wenum-conversion]
>       4 | void doit(void) { func(BAR); }
>         |                        ^~~

This is good.  I think we just saw a potential use of this feature
in Patrick's topic to turn a #define to an enum in <odb.h>.

>>  (2) it is not easy to force an enum type to be unsigned, unless you
>>      are at C23 or above.  If shifting enums are warned by the
>>      compilers by default, I wouldn't worry about it, but use of
>>      unsigned is more explicit in this regard.
>
> Do we need to force unsignedness for bit-flags? The compiler will use a
> type that is sufficiently large for the enum values defined, and I would
> not expect anybody to shift them.

Yes, as long as nobody shifts, it does not matter.  It's just not
having to worry about it trumps having to declare that we would
immediately notice if anybody does something strange like that ;-)

