Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE5241695
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603686; cv=none; b=hDF8YRn7eHcDpuxjNhYQxoF4c8YMaJkkImM4UKv6NvrUdGXOsGFQmNj3DWeZlpPp2LSrVcCzra14VIAPPYYPlus3O077veMpCXAgJvmI8aG68lRwdr06bMpbI69XaGeQQ/SEOUw/5KX5uExJw09WDsyKIDsyKvz/9t770emlyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603686; c=relaxed/simple;
	bh=IzNAFWGjWna7VZnDxUAMVzRHSdnedVy5V6W6GBGu+Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCaIFYHW6gzjp0W17ol1+4DHEhYYT+MDpwxZV+jVgEslzoY7//wNLMbAZXfrwVM7LmZJQEAY6ZdHNLEHgSbgCoZ0K/uflWxUtmxmsWUiVEJFddJZxFLExFpO1/itpB5UtkXR9bqYtc9bAOfpPtmCOOyLscjMlTK2z7hsil0PTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zwQLoPFG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uBMMyYfv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zwQLoPFG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uBMMyYfv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A9C414001DA;
	Fri, 20 Feb 2026 11:08:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 20 Feb 2026 11:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771603684; x=1771690084; bh=KYt6Inn2O3
	BPd7kdXcM8IiyGorF2lXAsyC9c3V4rw8k=; b=zwQLoPFG3Li0QiRsxxbQbIDK5N
	4VfntlU5xl3tI/TqwTNnl7JbEG4P/IJJbDIqilhnTLr4sCUpR1SIIPzOuJ4KkTd3
	S/5dIb3oVpp9KM0bk6YZH9slroWS7rsgNSgJzvFqfZTMqRaILDAWafbsJ6L6u8Y6
	975YHwlPB3r/Hp1oaNGpIo3J+dtNw3SpdRMViiPl3wqECIlj484O/B3dt3a80sLi
	Idx9Vzrf+SyQvlc42c3v7OhhL1ZgokFNVKvzQ9rpf7iBC1XP1y2CSFJ24RQVqIXP
	zY+DSHdVfVsH9Tug+mKgk3g4uffZoA85YTY5bSzJTBD8ExZfa/Fh0AMN5/Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771603684; x=1771690084; bh=KYt6Inn2O3BPd7kdXcM8IiyGorF2lXAsyC9
	c3V4rw8k=; b=uBMMyYfvNm8jh0kX5HyPKdvN605oDc0/pEmFWycMDOZKBzm/Wy2
	l7hIRDHtEllk5IsdyuWFND/8lyrBYdC+tSjfs4tR6qR6lJZGyW8Nb2IcVt7xKi3b
	Ur/zLZ6MEMsf66JyGa212mW4Nfdz0vIVGbTnEHl8TaOGWbKCuo5h0h9FhtLefXK2
	9C6Z992OLAyuEa0l+bATblscB7cuaKmr5PWLJvvhAddct/oQJ1HfsRj6J8PoBOhU
	uCPBiTWISXQ7QaAZh7lZBaoT9vXQTia7etQDikrsWNG0FGaJraFVdjTo8ZDa0lkO
	ZSZ2/Qa9vDasp4rFvXy0pL3pIGSPUtutdCg==
X-ME-Sender: <xms:5IaYaV-0T40CFTnLKYPGo7Glw0jpLBZ51ECR1xijaGZISrpTwYjKoA>
    <xme:5IaYaQkNvot0x-e9jHhsZuwTGk3Tx2XH7sQB1eYl14-BqepAq2CQUKDeJxBQJEm2z
    FF8JlL9XTiZOLEsYKlTP0976RkC14ce5M6Ee1ZSLbEQKdJMJOYs4g>
X-ME-Received: <xmr:5IaYabU1ALX28HWh5dIfyVv0cMvQLgWZt_uauI7UyESgN1ET1oq-qr8xzITcdt8gEhlzc8p8CcYarpk9YhH3Rky_1Yo7bJC-HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohephihorghnnhdrvhgrlhgvrhhisegtvggrrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5IaYaVGm1D_s3fVRi_n6Rh_McxGQ02p0ZIZiILbBLT8BbMSwj3rH6A>
    <xmx:5IaYaXdTuQBaMX3jLu0OcNa4IeDMInDzCQaQd0VE-N5zIcHRWNXiQw>
    <xmx:5IaYaWLNlfdBoQdEdv5GX9Y0-jPK10CHgM1ic-I6QoigXrPs1DnuZA>
    <xmx:5IaYacHG36ngIWgRZ-tZM3w_5f3rvX0Vre7I7JJestTWAzh9zvg7xw>
    <xmx:5IaYaaiBu7mWNfsaeCoKKFBHMG3Jbw7LJ7rpy5ZS-Jhym1G2J_T_sHK9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 11:08:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
  Yoann Valeri <yoann.valeri@cea.fr>
Subject: Re: [PATCH] branch: add 'branch.addCurrentBranchAsPrefix' config param
In-Reply-To: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com> (Yoann
	Valeri via GitGitGadget's message of "Fri, 20 Feb 2026 08:07:13
	+0000")
References: <pull.2202.git.git.1771574833967.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 08:08:02 -0800
Message-ID: <xmqqy0knz9ct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

By the way, the address at @cea.fr used as the author ident and for
sign-off seems to be bouncing, due to "550 mailbox unavailable".

Two requests:

 * To the author of the patch.  Could you make sure to sign-off with
   reachable e-mail address?  It cannot be helped that years after a
   patch is written, the author may become unreachable, but we do
   not want to see it happen even before we accept the patch.

 * To GitGitGadget maintainers.  Could you think about ways to catch
   an incident like this, perhaps by sending a ping e-mail to first
   time contributors to request response before allowing /submit or
   something?



