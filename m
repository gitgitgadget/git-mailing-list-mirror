Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BB15DBDD
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566666; cv=none; b=quUTnD6395LZkEU10qMtIsaMHalgvWD2gBTExgep6auzsNETUFu1oACQv0xpP7UsFBNp4ybBKWSXvAR65FJxzu7D+XEMW24ZVLr6vwKAvRuXB4mKCFPcnFFlLswz9NzWEc/M3VHUORlnqOEHMpMOx2GNKo3bhz82nBzMYn+JI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566666; c=relaxed/simple;
	bh=R+sYyR/RFlPZdEOVanarzAbYgMFIZ1DSBR58XY7IHRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwEyWCLT4t2sXd/8PHrdCVgCQedFZgLmuGcte5Yaw+iDX7U2tjurAjm1peGgeSf+SwALDF8yvmWZpgQVk0mKELCXukpb6u3wruXkcnDNQI/gSv5qSVzg0O3qbiU8JBMDlrgIdT47Vj6cy5b9PDMZgUfzbRfSrog+4YZV7Sf+OHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aI4060SL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2G0nZfJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aI4060SL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2G0nZfJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 764F713804A5;
	Tue, 17 Sep 2024 05:51:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 17 Sep 2024 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726566663; x=1726653063; bh=TznKwZuWZB
	y9bEYWVx+U0/CToE5nrZWck6Irs/MZcSE=; b=aI4060SL9NqpdNYKwcI9RxoJit
	Q2uCv86FJ+zZGhsZhTa89Nyj84yP41Eptvpxyy36VG2VLMuD/WDBTFeaLffEuYEW
	bIxBO9R8LKjmw4ISK1tAJtMjovADzOHk5YTtreunfyVwlIJyw5LL49et6SiQhzKn
	BPH7QqhPN6znU0PDblvFXvOFH7U9c36BMV3wdKrEBbJa03nQF5aBDRFvztFAX+bg
	hcEjmnPUAE9YCcOW3AAG2mBtCv9BOA4wxAteoh1+b+XTlPVG3oR8SYeBDRgtgr7a
	ibiliU/LxBayM4Xe6ubpxHdjHAizJI5GuR1B72SV919Qq4a8lfgJnKEIgj5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726566663; x=1726653063; bh=TznKwZuWZBy9bEYWVx+U0/CToE5n
	rZWck6Irs/MZcSE=; b=X2G0nZfJ3vPGrRS7ITt0mdXUZhzWLmjP0TAWJonxUGmy
	gaWpyzjmvJCs47x9Af2Qf932ur1ba8GLi/NiLfFPyxZ6TcjTv/Z5SVc2wW60PM+l
	+bRxx0gg6TDhLfhErLs9hqC3YPwZohFyYXcWxN1iqcKig1mfUDPZ/fYoiR9b+g+J
	Ai0a6yD5aTPf0ZLpWoMZCynv6ylnc+VRj3mF9arYIyk1UZY2oM6Cu7/CdSoHLD6D
	Yw59gbFNb1ZHDku95/SxUoMYmXJ9vTq/ZOjKa5gI4cOdK1jzxYsk5SzB2M6znKeY
	zfE/uqGrzc9tL/NGCzVIyqhm4yzBuvwB3tYnixl8BQ==
X-ME-Sender: <xms:B1HpZmbPs6QtO_IGTu8lH3VNoDZlpvUvGq3_pAWf1ooKN5KAJs-Rew>
    <xme:B1HpZpYO45oltZiMZvpC7pp_NYvRiVBg1OWgPYM0RRE3F1W1zvcktwsDBYVCZV0a8
    RhYIWFzscu0YkYbCQ>
X-ME-Received: <xmr:B1HpZg9ScG9l5q8N3LzFomwLiI0Xoz6LFoER8Xuvx5k4Q9R2G5iyezCAorIZJrcmUm4nBZD2mqudcWuBWa1DLfA3GToDO5N2Kn5MKW7kwlU_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:B1HpZorWQ0kdfiuFT3nhoNXZ79lLPz5Xnq71t_jwYlVRIF84uujvBg>
    <xmx:B1HpZhoZHtRfB19Xv_01CsG3sQB2W0Zh4FT7T-pHOlp2_Lo6rgD8FQ>
    <xmx:B1HpZmSoPIwmjxFr3WWhSL_qbMBJWpLxW55ZzZKc1zdVWZWsqLzPcQ>
    <xmx:B1HpZhoc65thUo6HgGb9i6iDV2qz-Q22ybjMSwcCaWTlLdknQORzHg>
    <xmx:B1HpZo1vBY0wuCHfvxCAFKRb3rfqthzHD-5OOHwsvsfNc06UPC0kWxZE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 05:51:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75779921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 09:50:42 +0000 (UTC)
Date: Tue, 17 Sep 2024 11:50:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] apply: refactor code to drop `line_allocated`
Message-ID: <ZulRAiILnz8WZSz4@pks.im>
References: <cover.1726470385.git.ps@pks.im>
 <0427cb72507bba7ed62d13a5523fea351a0cb35f.1726470385.git.ps@pks.im>
 <xmqqldzrmnqn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldzrmnqn.fsf@gitster.g>

On Mon, Sep 16, 2024 at 11:56:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor the function to use memmove(3P) instead, which allows us to get
> > rid of this double bookkeeping. We call this function at most once per
> > image anyway, so this shouldn't cause any performance regressions.
> 
> Don't we call remove_first_line() as long as leading is larger than
> trailing repeatedly?  Is "at most once" accurate?
> 
> As to the correctness, I think nobody takes the address of an
> element in the line[] array and expects the address to stay valid
> across a call to remove_first_line(), so this should be safe.

Oh, you're right. I did search for a loop surrounding
`image_remove_first_line()`, but somehow I completely missed the obvious
`for (;;)` loop around it. No idea how I was able to miss it.

I still very much doubt that this will cause performance issues in
practice (even though it's only by gut feeling), but the statement is
obviously incorrect. In case the assumption ever turns out to be wrong
we can likely refactor the loop to only trim contents after we have
found how many lines to remove, at which point we can remove them with a
single call to `strbuf_remove()`.

Patrick
