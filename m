Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00006284663
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648456; cv=none; b=HwvwRkAWf0heYD3cxNdze3BfwkdaUAkpVaGEgZ9IApeCbnTJWFLcFeAr/tQatnqAYNQ8yCVPt23YV2tA58fciacHmTvQJZ/IBl7nY1SmBg5exyLitnv4EKBF/sBRYudw1ErDCWXx5uVcXCrLJoxqKoCaKvKAaQQvmHy5jTeNpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648456; c=relaxed/simple;
	bh=NSL/Y86VZRoFPKB9NNdlkKjm/bBHHiU/r3JHsQtnUU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uonMgsjGSI+f+bIrrrZSaicv79ymnoczG+FGYc/S7vq3Xhx6CzAlqk9bLiugguTA95cKDIElk4Kx5TrLuslF1ndFbu+yerFdoet0kUJAD6LAS8W6kQcLv/N8FzrL3tKAtoNUL27mBc/+kDzfb8tRmihAjEedknwca/J+mFfFgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C77nUqB5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1R4MQ3c; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C77nUqB5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1R4MQ3c"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D71625402EC;
	Mon, 14 Apr 2025 12:34:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 12:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744648452; x=1744734852; bh=49AW9a8Fkq
	D7pthBuVjk7ynSPUb3GxXJBWHTClSCgdQ=; b=C77nUqB5HAKMPVMArAvOZrQgIw
	Hj31AJQmBX7d7p6QoH3d65PfJdUoLbLb9L9LmGUPLhGAsAF2GX9Rx904BcjuEjmZ
	HR1EU1/rVOaFL+TLa/1v/0Fvl9wssUyCIgdjRoUxXdp3CC9xzo8lBadrE6+i3Aai
	jtjv//r/bLhs8vTRIbVd6mYrYMg7jWCma/08obviitHzQEqyIgq0+EEz2QdmEGLv
	sMeyofbcHJ9ae8FtNrsSdCWgovuZwowMX5QAI1yDwWbcqpt7kbMHRzJMsMhoch64
	uIKXzXbeXLNOoj/G2IE/hleDmRhpj6uvrWgDYVMA3yW0nrucpwgYJ9DaWvfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744648452; x=1744734852; bh=49AW9a8FkqD7pthBuVjk7ynSPUb3GxXJBWH
	TClSCgdQ=; b=O1R4MQ3cv4XGgamIE1bU2yNBBtGym7sqywsDzFIchMsvDjJ04QO
	52fLFjM0RlJkqIwb9Dh7lLi+89XyESa9RqK42w/z5sKb/LHZy/ArGn8l6E30mICZ
	XS2EVcLqXaBPBvVVP6caoZ+nIhT1xSolA2bQtrcf6wq9axC1R2jJGtpYkDgOLfLM
	bVPRajuPwgiahZRyUY4anCTZ3Wzc8UFKluLoRUIXarOAINw93Jz8whPAuvfNfXZG
	7BfVmL9IKarX5PdeulpcMMgkqCjA/fGg87R6sXmG8tkPWZKiSV91Rq0sF2x7MKy9
	ZXBfq29vIVk5FCHv3Nh3T5JEhtYYWrEXK7Q==
X-ME-Sender: <xms:BDn9Z4IMZoBv6ghRjFdXvNlaqYjefekjRd59z-eUU5CgsFjPyV4bPw>
    <xme:BDn9Z4I7fuZnv1zVV_BSNG99_rSVnBAoEVze5pUuvwaEU6pGtWcB0PPNFUauH91XL
    2lTOCS46qLrxcDBBQ>
X-ME-Received: <xmr:BDn9Z4t6bhw8BgGOMTRJSMwUHoixgckJc81-8XUqZFfNu0ID3_XU2Q7JMPE-XydHpS8hvwurC7PlmXs7hjcy1nyLCfhRJaSMyhgP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmsehlfhhurhhiohdruhhspdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:BDn9Z1Z7KiRhGIfLA7PHLuB00jngJdOkRrufpszRW3rv3cx_0J6HDw>
    <xmx:BDn9Z_aLcRSv7OX_Fn2nCy3z_HVPqmBUDZzV-OWyX_r0_tqC35XoUw>
    <xmx:BDn9ZxA4xpN4Iw_5UnW8HRg3ys3ESxTsKPZXaxQjJkrvORY-11Z7xA>
    <xmx:BDn9Z1bQIQMJXznRzaDMKPoncMbEeGE34YKqj_FvLJwc2j-X2DneFw>
    <xmx:BDn9Z5xjo6roNhJvHJXjih8tIeQmpN0rnHGPMqyHCZU6NMHCqHKyoKKK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 12:34:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: <git@vger.kernel.org>
Subject: Re: How to gpg signed email patches?
In-Reply-To: <D95V0Z9YMEX2.3J99CE4F6ZP8S@lfurio.us> (Matt Hunter's message of
	"Sun, 13 Apr 2025 18:21:46 -0400")
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
	<D95V0Z9YMEX2.3J99CE4F6ZP8S@lfurio.us>
Date: Mon, 14 Apr 2025 09:34:11 -0700
Message-ID: <xmqqfriar9bw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matt Hunter" <m@lfurio.us> writes:

> Hi
>
> On Sun Apr 13, 2025 at 3:17 PM EDT, Klaus Frank wrote:
>> how do I get "git send-email" to send the patches gpg signed? I tried
>> first signing the commit but after spending time looking into the
>> documentation I couldn't work out how to do it. All I discovered so far
>> is that the "git send-email" appears to be using "git format-patch"
>> internally and that's where it currently gets lost.
>
> There's a conceptual issue with mailing patches from signed commits.
> Once your patch recipient goes to apply it to their branch, they are
> recorded as the "committer" identity of the new commit object.  This
> would break the validity of any existing signature.
>
> This is likely the reason by the related git tools (format-patch, am)
> ignore this information.
>
> You may have also noticed that commands like git-rebase and
> git-cherry-pick will drop signatures from commits as well, since they
> are being replayed onto a different history, changing the commit data.

Very well said.  Protecting the e-mail with GPG is a job for
MUA/MSA, that is independent from signature used to sign objects
like commits and tags, so the signature over objects cannot be
reused by programs like send-email.

But send-email may not have an option to wrap its payload in s-mime
or pgp, which can be a separate project worth looking into.

Thanks.


