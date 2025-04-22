Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EF2C1E2A
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353825; cv=none; b=htgGB/TPOxw2hKoGkvGwg/BeLi99jBIVfcMEDKmyKaOLvrXiAaAXpHLRmcVBh8KwTyKmQeYBFM/sDAwrB+iwC79G6SRQuK+aG74GvfvVm4s/B65lJXZXNkN+mvHH+ycDa4dCHp9m+DObFJEg6mes7wnD0EPz0gPPThEKd66ui/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353825; c=relaxed/simple;
	bh=7R4SxEXYi6+zFkFl0ExZ89fdxdNxOK6Gy1x10owjb0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enPQIvcM0uobxEakFQCGOb+1V4zygjXC3q37F2I8flafBj3yz78lZuiHSpvWZgpEwakuDlumNTpxz2q9rNch7sdRKCo5vPuVE0McyX7NmUOH2s3CcqUPDiL+cqQGY41s/gNk962ePqewxnO7Ggdqn3umlQhH9YTkgnZtLqDdUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LBkhYp+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xnsuJu8T; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LBkhYp+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xnsuJu8T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5AC0411401CD;
	Tue, 22 Apr 2025 16:30:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 22 Apr 2025 16:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745353821; x=1745440221; bh=7R4SxEXYi6
	+zFkFl0ExZ89fdxdNxOK6Gy1x10owjb0g=; b=LBkhYp+gkPa1HtLf425yG+tWX3
	v2mLpzbXLBJBCz1xyoIytsNrarmxRkvXtIbkx7fW9WRlb6A6ucEc97WTMplyDvTJ
	eRw/wqlpOawIIgKxtFZvo7mX1VTt0TgyZyabSRmvxxLVOujotnGAUwx+IqF0UuOD
	LDZBFcV0xVI5Eqf3i/3UhumM8WLrGoS81Q5pWEO15Syjvt56C16xL4t6eQnJm3m6
	hjZc+jTJaQdaOZoHxqT07iCMAAF38jQixlKz6lICe+dC6N7mvfOHAd+K+sr6tENK
	CAKV8OHiq4JQX4ERa5AAnPP5SLuRqDg9/YnyPnO8+6nBT/qWjZuhRjCsZJEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745353821; x=1745440221; bh=7R4SxEXYi6+zFkFl0ExZ89fdxdNxOK6Gy1x
	10owjb0g=; b=xnsuJu8TN6o/jWWbvAE8RkoxS8xJtZxeWrTZa/2gBTCq7+J2U6t
	BVPHrkJdwfv3EQfKVG7BlE3PW5Qs47LoXMzO41k9dkeupvGgBpLh4LrRm30Q2DEj
	jKFy1H3jY/NA93t4MkkA2YRZtne2SztWMhWz0Qt/1EOOEjLkwxOABjWOnNkOys3v
	WVHYeP+eyaHzTdThhcNQslgJdGCUuuP9pnUkJV3FGIo8nJu9syYfCUqkBQdhfEbL
	J8pZZd8H67KNbOKhpOu9gtDqcXcj//ZhjZoUOv5hNGvF9Iu8NDkZby/4GLQFIyh+
	bOsLsKjpp2EaySPFYA5//PDHV6/g+KGZPTA==
X-ME-Sender: <xms:XfwHaGE9BOprOH1pkQtINliWs3QXrR0j9u0KdwzKI2EIWsnuHHR2kQ>
    <xme:XfwHaHVkVW75ffNDYRUQOScKM9bn_3u3XdvuTwe7cu0ZmNLV-zftpAp1gfT-qTac4
    30ZSIRJHQ54UFyVEA>
X-ME-Received: <xmr:XfwHaAI82buvYFg71T37aX82HGL8jfGyo62hSgiZpIDzXvQoCIE0A-mbYXBfxuyXj9-AqOlvn2rg7ZHFqIjncwZwMFiqTqaDXe9_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XfwHaAHFI3rhGIzc7WAPaz4GBTrLwDGN1OG8sMZP9gq802_FbQmLdQ>
    <xmx:XfwHaMWLadu17lLGJ4pKhpKBrkeOW6HenSMmdA_aoBLasatV7_Vjlw>
    <xmx:XfwHaDMdBnDQ_vknuTqTFwrT4JmoNHxkyFPGuLCvajOCd0xU2dPr1w>
    <xmx:XfwHaD3Sd8iUtVIyu4BtxvJOl8SkdgRQCkfTCWMMm19nL3zsaf5p3w>
    <xmx:XfwHaHAUii9DWr7qQQ0Q9aIOVOgVY4CX9nTfVMpfeyrCbYRJhV0qgvOd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 16:30:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pull: allow branch.<name>.rebase to override pull.ff=only
In-Reply-To: <CALnO6CCMP5qS0f8oMyjav03CzT1AYSCiVCex1C7nqqxg=k7g-w@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 22 Apr 2025 16:07:05 -0400")
References: <20250205030642.95252-1-ben.knoble+github@gmail.com>
	<xmqqbjvgr11y.fsf@gitster.g>
	<CALnO6CA_vF4huxMx6jSS4SVjS4+EO9K16Msco-vMUDzSoYRDOg@mail.gmail.com>
	<xmqq34gsp9tr.fsf@gitster.g>
	<CALnO6CC71A_Bn+RhyXfmhiNCn2vFGJ+WCs8+dAnpQvGFyNZyfA@mail.gmail.com>
	<CALnO6CBi-c9U-UskTzjNBH+k8VQybdSshYgs+A3_DRH-iz7zHA@mail.gmail.com>
	<CALnO6CDq5BRogPCcDozTi1NEYL6nCoEDaNkFdq2+1V6vVRy=1g@mail.gmail.com>
	<CALnO6CCMP5qS0f8oMyjav03CzT1AYSCiVCex1C7nqqxg=k7g-w@mail.gmail.com>
Date: Tue, 22 Apr 2025 13:30:19 -0700
Message-ID: <xmqq7c3c3pno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

>> > So it turns out my itch was already scratched.
>> ...
>> I left out the commit reference, whose message described what I think
>> I originally wanted:
>
> 6b37dff17f (pull: introduce a pull.rebase option to enable --rebase, 2011-11-06)

Good to know that your itch was already scratched ;-)
