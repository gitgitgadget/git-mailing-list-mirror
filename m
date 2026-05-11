Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B503BA25F
	for <git@vger.kernel.org>; Mon, 11 May 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488270; cv=none; b=Yahw/yqHmozcnHGt/r9tmL03FUffKBJee0DkCrsRHLxfFXAK31V+0uBmBqvfdoFEE7umN4vh0V5D8smPshbK7h1XQgOUszP6kNO1Gf5vmhNHMbAi+0vpmcDZk8/pY4t8pjnxDyQFDBBENVdCDKpaV8c7pU6aJ3Vh61/D90mqBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488270; c=relaxed/simple;
	bh=1DmhHGqnLCn7jCv33987weFfhH4Un4xU+RWCzedQsNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wc0XPkc6zoiNkfL2omR3T3oYTzBObofu3NSk4QG0vnRzxYx/doCW1zJUO4wM4YQaB8Gm5XWo9UVz1nu4L+K3UskaPm94VECUubLHSnVnsvGraJ2EP5Wr4M/xRJpmkFFGjgcYesqXt10nW+GYWoN34cD8Q8okXZs5Jql8f/TyzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M02QulQW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=by6oRHES; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M02QulQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="by6oRHES"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D8681D000E7;
	Mon, 11 May 2026 04:30:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 04:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778488255;
	 x=1778574655; bh=L6KBS5ae/gpKTEPo2ED0yI426KdP5I1868aUgF6GPik=; b=
	M02QulQWKrRQ6UtK/UtfIQU4c775l8FXVi/bHawv1XWRCZWmtUGz5WAMDu4Blsa7
	YPjw0GAS7MMr5Gxs1xBD+Gh1t+bLZlG8sc4NvdV74RZ7RkKrWLqeh5LNYNvd2CbG
	tyTjYlN8zCL34cdQISZozaPl1T3G+MmfiNK55Lc2EXpbqb+tZlw2uK1NOF+rtGwb
	wrPh4kmcEHWYtCeT8hVSbMvKAePAdkXVtvntJXIF+vaQdRlnpp5u6qv3NeDNRveU
	Dgh5AX1WvayfqDLF3Ofh/OC8e58oi2GmAD6kIY8ds02IdR9WWnhktkJX0ygKe/Og
	TjC9+XkSs9PmuZtAeQnNYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778488255; x=
	1778574655; bh=L6KBS5ae/gpKTEPo2ED0yI426KdP5I1868aUgF6GPik=; b=b
	y6oRHES9+IhQM3WmA330SNIhdKQzh/9qAjfAzR8CBw/C2x41shyFVg+TCLzH+8k5
	l7lmVAzVTQUDq+4mhoNDpKU72cRt61ujWUhWWPT0jvcCKKkqVCWb0vI5Z1f39K02
	cMAshesIgFgRBVPGn/srIS0s8oUlvYyhLawBV/1C/1DEzyu539Rcl9WLpgA7gW67
	odrFg0cmG1mX+0Bb3ELsLkC8wIQlLzHDGH9DqUrFnZ8ldUkU2C8umprfw9xLXCRE
	CQttASoRkB+vluc18dN+5eweve5xz/1Mfytx1navunx4P0PljYEeDceRswu5930B
	/ih7g8Z4QFdbvY7cCYZbw==
X-ME-Sender: <xms:vpMBamohTrQCDYXAaO2P2_uoTUPraqUtLWO7z2uBwzXVbhJPMKYnQA>
    <xme:vpMBamKgojZFOoD9_quk19XZT-JoAQiF1kvb-b_RN7nw5go9NKtIXOxyL42skH9Kl
    zrQWfjVSOnbQ6JQMr4Scvu3IRJElnyRrE8kojO-PXygQZajvkLFtvo>
X-ME-Received: <xmr:vpMBarQSxGqld4cHfgnVzLVsONHA8Op3_cFFK9HH2sa_JxSTP9pGS2wbgx2_fB1XXIbOA0ZIao1xY0jcV9lMue5VPCUwMN3Vyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hsrghmohgpphhoghgrtghnihhksehtqddvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehofigvnhesohifvghnshhtvghphh
    gvnhhsrdgtohdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vpMBalsINvhTnpheawWrVxqQ_FHEpOt_DZZPzIoC93cAzSDaScdg4w>
    <xmx:vpMBasaYoC49-KjX2k6u-9ORzPbRxBzMSIO3yzAZdQuEp9X5BHLySw>
    <xmx:vpMBarExnKUIPSW_w_mQiC7Hx0e_LFgYSOZGuuQdYKmuYFHKyI66Sg>
    <xmx:vpMBagyJFW41AMFVyta4TvqksHOrlXnWdRM4GiY_ipISUTy7IYuAYQ>
    <xmx:v5MBamavy3shxfjeWd_zZD7ONcb2hWKFB69ZuemYWMibP76orvbUXP6W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:30:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Samo =?utf-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
  git@vger.kernel.org,
  owen@owenstephens.co.uk
Subject: Re: [PATCH 1/1] shallow: fix relative deepen on non-shallow
 repositories
In-Reply-To: <ac1aac76-17bc-469b-8dc1-d3a384f5c6af@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 11 May 2026 09:45:58 +0200")
References: <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
	<20260506215647.3011769-1-samo_pogacnik@t-2.net>
	<xmqqzf26x0vi.fsf@gitster.g>
	<ac1aac76-17bc-469b-8dc1-d3a384f5c6af@web.de>
Date: Mon, 11 May 2026 17:30:53 +0900
Message-ID: <xmqqy0hqqreq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Perhaps, but no warning has been given for deepening a non-shallow repo
> since the introduction of this option by cccf74e2da (fetch, upload-pack:
> --deepen=N extends shallow boundary by N commits, 2016-06-12).
>
> The best place for such a warning would be close to the user, in fetch,
> no?  And in its own patch.

Yeah, the lack of warning may or may not be considered a bug, but I
agree that it is totally orthogonal to the problem the patch is
trying to address.

Thanks.
