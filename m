Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED97262A
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770682969; cv=none; b=ED4CSKYpi1uGVRF1CJHWtJfuReEKyL5BvpYgTq5qsR4ut3GgzLGYdO2fghhg93B+jNUlUNWIt4yscIthUH2VwTUop6SSbCk4nZ84TTuvAD5B7Rvmmf3DR7LQTf++fOHVUhVWe59Z4T8h/DxoHIjyfNgqvQhBLNOryZxvOt2y18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770682969; c=relaxed/simple;
	bh=QL3gVEJNQsgxs2N/aqH/fgpBhG6RWs/F+GWZvQrpTK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pg3aN6TtzNAKyRcrpzOgiYYX6120iQzNgoWVTgC35T9wOBvrUs/xYishMYu2bLfYFW84T0hEuehqaleVt375cndmhXBtGiHEabTon1e88UN3rtTWUGZHJUTLtq6p9XTTez3szuv7+Oz5YcjdsueLu7FzoGrb3R0Hj982iyCb2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aksODOsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wFHprEmd; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aksODOsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wFHprEmd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 910B0EC0550;
	Mon,  9 Feb 2026 19:22:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 19:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770682966; x=1770769366; bh=ChHptXdfvg
	hEzw84MLS4Xx8LXn9TEC+/SCY5GbEYu1c=; b=aksODOscHY4G6+bzaLCpkSNafo
	9MpQiM07Lu49EJVHNhZ/ADcx4PSuStFqG1I6plRPW63FQLfKa+/x4HpduvqAoKaQ
	EiUfa6KHNhbCQ6Q/0KX9uhnL7lGmt1MrU3nsS/mQA6H8/NAYSpaLleTi1oFj2u6B
	FiKUaHzOxT2haJq0eiuLKfspU52RbO61sBwoiSIcMRlAokCNNgY9SYNPK0fhk8Qb
	sA/OTG0okEiOwI0Yr4IuY35NK+oMq/kK6quRyhNTfbKeb1GDvGud4tFX+oTkE2v7
	oSZNhLe2uSC/YMhTFq+VGRlrX2aoTxP/Cyju2GA4b1sHd4xBJhkWhFiZAkLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770682966; x=1770769366; bh=ChHptXdfvghEzw84MLS4Xx8LXn9TEC+/SCY
	5GbEYu1c=; b=wFHprEmd+ZdIENbNRRs7VWOaluKEoJHk7/HEG4XsPRaF6DmRa+1
	Lq5PlBCEGhDqHVy27CU8gN9ygst81vLMxiDYL2RMw5+PR4xKVJFm6RYkYdCdNHgE
	w01ZeLWKXiv4akFFJbXkObKf2dG1PHsJtXEEPNJolElyP6sQBvy3WkjKpz2atRD1
	gy3+kOt3//0FgDEUvMUtbgoTkPOByWxjvsv7XkgHWMNuWeRERyWDi30CO12ayDZV
	P4HutvQ4BcnASck0BQKJBRo/HLvJwFds3tmfiSKCkj8Oc8mvaoRo7QraVcHbFm3C
	MAY2dYbfVo+itMk9GnERsFrXTmP5LXLK9jw==
X-ME-Sender: <xms:VnqKaXeCSxQMK4iCVonMDdTmBr2lYCkhHBAh8tq2sVLvqN4XgnH9_A>
    <xme:VnqKaUpu46ShEoCaig_iYSSsvE-lE2Ykz24U8EmxqF8C3dhNuZ4rRQebA6qr7QNE_
    mPzB-M2nIm870AiUqQsfCsvwAjZ7wNWbAB5SYoD_iblJYZeIYTS-g>
X-ME-Received: <xmr:VnqKad55opZbBibCeBppnFHPUaLq5ao1DuEvPmpnNsIHKJC8FfRiHF99h39L3nwSm3HHllgFm-tiMs4MDtGN8f4xntaVxxdj0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjihhmrdgt
    rhhomhhivgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VnqKaSrbHeLtK1kt5sCpPr_yQNfDALXDF43_akb9GZ8Ywno1DiJTbQ>
    <xmx:VnqKaXiIt_otL7Z30Y-wocGwKT2J-8PuSAx0kKOSk1XhCjzh0CznDw>
    <xmx:VnqKaUJs8o2bDATxCu5kim7lU5zklQ9RLk7az5oT5W3pnxk8ixBBmQ>
    <xmx:VnqKafBtJrRjqPHcq3gNjGonZ9T9qyKwz0Ib_s0-NAUHyMQAUltRfw>
    <xmx:VnqKaQoZxHvqeuATLeaiyKWR5eTcDgGR-lgXpM9qYIb9YoXyZUI3eCXH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 19:22:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: jim.cromie@gmail.com
Cc: git@vger.kernel.org
Subject: Re: --suppress-* options error out, apparently passing to
 format-patch too.
In-Reply-To: <CAJfuBxwJ_=4mh4gBd3Y98rVRWNZ=xyJAiDxMXb+2TEn6uJM_6g@mail.gmail.com>
	(jim cromie's message of "Mon, 9 Feb 2026 16:42:52 -0700")
References: <CAJfuBxwJ_=4mh4gBd3Y98rVRWNZ=xyJAiDxMXb+2TEn6uJM_6g@mail.gmail.com>
Date: Mon, 09 Feb 2026 16:22:44 -0800
Message-ID: <xmqq7bsl30rv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

jim.cromie@gmail.com writes:

> [jimc@godzilla wk-test]$ git send-email --to=$trybot --no-to
> --suppress-to --no-cc --dry-run
> 0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
> fatal: unrecognized argument: --suppress-to
> format-patch -o /tmp/tXB5tLINzc --suppress-to: command returned error: 128
> [jimc@godzilla wk-test]$ git send-email --to=$trybot --no-to
> --suppress-to=all --no-cc --dry-run
> 0001-dyndbg-fix-NULL-ptr-on-i386-due-to-section-alignment.patch
> fatal: unrecognized argument: --suppress-to=all
> format-patch -o /tmp/Y47eIqlSDG --suppress-to=all: command returned error: 128
>
> --no-to --no-cc also doesnt work (as Id expect), it still wants to cc
> to one given in patch-file.

My findings from a quick read of the send-email script:

 * There are --suppress-cc and --suppress-from but there is no
   --suppress-to option at all.

 * There are --no-cc and --no-to but they suppress cc and to
   addresses from the command line (and probably from the
   configuration); addresses a specific patch file lists to be sent
   are not affected.

Documentation updates might be needed.
