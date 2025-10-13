Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C969312815
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370068; cv=none; b=X6ihNGJKsH96xD6phU44crANAlHW9rgGKSosX0P/LvRUOlMwhvnrYbTY0KBc059Obtgi/A+7ZAUQSz1dw7l/Tz3XVzBogoa/T02tTJhGsIviJTcqOItjZrw2PlBluLyrSvwLR7F+h51VEilL07Q6L4dUmUXAJwg3TaJnDSagaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370068; c=relaxed/simple;
	bh=5BKd7xZsdZDjM9DzmmXBWNoEk+BBrfBjCVoi0q6R7cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chZC4ULp4GOIYSVOVDtY9C5/3uzMy1GucUGGmltgCb1/TaXoV4OeVgqcY1uvIS+EEqmPsiqUYZQUZa2HpLDEoeqfT67aTrhvuX+7+9MsBLv6hOAo+G2928ybCf1xUHxyzD6XTJS/9QLpVc0Qi60sUGOWSvT4sIQ/3augc6tczXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VCXxPb01; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xg2hU4OX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCXxPb01";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xg2hU4OX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 97AB3EC00E1;
	Mon, 13 Oct 2025 11:41:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 11:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760370065; x=1760456465; bh=uVmEuF+UKH
	qcUu2w3fuFpC27/V6XpfHixWljNVN2TT4=; b=VCXxPb01PxXsWc02rxuJwr277G
	YO6617bhKKxmuBlqpFJC9f2vV5xE3DJmQV/rC1hxziBP/hL3geu875MVFzxp/+JL
	G1/AlkZcyinH57WBD9GNlagLpdW4XH3whR6PFJbTe11QVtbLFh6RNhc4Vyhm1cRG
	2rWmXPmrfVkltGU80Peeut5KJD0ZB1JGuq6+v81725i0rFhqYEq1UwY/ANM+D39o
	oENW2Lsl9kOQS/quEtIrYa5LWDfpE+Tu5hbPvRg8wFmgZrzQBL8n/EBKIuTZE/+x
	38e1ZODgwpDGoF9ueULemIa7lv5W066k9sL1OOpTdy9CTsKALamjn4pVXpcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760370065; x=1760456465; bh=uVmEuF+UKHqcUu2w3fuFpC27/V6XpfHixWl
	jNVN2TT4=; b=xg2hU4OXfBeOLGxnIaaieELmMUeFMQR9LEHFMbBDHxWwKqi0OUj
	pcEbnxPVsbdlGE7WFUDCaL3t2OTKO4xEJRsJV68Y7EqIhHO9Itm86qc95PzVwkRj
	0/r+zJqKV3KDI+wnSBkFrNbl7YMXHysIvaKr93pZ7nfRrY+WOhBu/JyljZryq7nd
	rsxSv5Gi1HhaPAhXaptAX9NLRyCZv39p5MphMf9QwmmbXXVVffORqm+JNzJIDUjl
	ZOmYDZbrGdH8lxmpY5lgP8QHL2i7a1rmKkbcbTcq8+60IlLVUGef5RLjgl55WTRl
	rg2JMSJY8ydq+C2o4XUxk7u33HTtXtvaNUA==
X-ME-Sender: <xms:kR3taFexOUNyKTDX81kTMPcwPFbPox-V--j6UbmN43Y3RfGwWLKoqA>
    <xme:kR3taKGSRX77DpiVR7SiCbFHRkHzs2joguesAmNIDQ1GhhWd3lxNDTTnu6c78F3Vf
    DAUCR-z36v80UmlwgnWDvnb0VRIgTjmk7rpaDiGNCVzjxrS9D9wew>
X-ME-Received: <xmr:kR3taG2n2rKCIB8IbnLCJRB7-2UZ3iNbsaATv16C8f2nJzNXlJTBf9TwL82LmwzA-bwtrtI1_SsyN_VSIRq9erx6_DFQ1F5OIutI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kR3taKlhov1GWvAtKYEAPTMmSIRByK9CWbH_vcldhZRwxzdEL_vbEQ>
    <xmx:kR3taO8nw6yXcDK51_aOIOX9zkmAv92A8YetohDAqNYjzoddsIXbrw>
    <xmx:kR3taHoUSfvYCDQMqV69VxKcWpLCIzeW04g5ZryNxXR7eg4iGnwfEQ>
    <xmx:kR3taPmbNKnC2tkPOEqcDpiH9uB63DOWPfJytVaDl01MrqRzftvCKg>
    <xmx:kR3taB0RoxnmPzj4gxh1vxQMBGj1uLrMo2S-BHqN2hpc3i82_cPSP58Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:41:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [RFC Outreachy] Teach ci/check-whitespace to flag incomplete
 lines as an error
In-Reply-To: <CAD=f0L-QAfMhBw1_RyLkpdntjPfu4M+temmawWGEZjAJn_iQdQ@mail.gmail.com>
	(Bello Olamide's message of "Mon, 13 Oct 2025 00:41:51 +0100")
References: <aOporVVSRRL/v4Lq@ubuntu> <xmqqecr95ib0.fsf@gitster.g>
	<CAD=f0L-QAfMhBw1_RyLkpdntjPfu4M+temmawWGEZjAJn_iQdQ@mail.gmail.com>
Date: Mon, 13 Oct 2025 08:41:03 -0700
Message-ID: <xmqqh5w23j3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bello Olamide <belkid98@gmail.com> writes:

>> we want.  We need a mechanism that notices and warns when a commit
>> makes a file, which used to end with a newline, end in an incomplete
>> line.
>
> Thank you for the clarity. This would mean to compare the relevant files in the
> current commit with its parent commit and report when the current commit removes
> the new line at the end of file which was present in the parent commit.
>
> But how about when a file is newly added and lacks the new line?

Yes, you should notice and flag any new incomplete line that did not
exist before that are added by the commit.
