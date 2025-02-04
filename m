Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C320E002
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676292; cv=none; b=Xpc3tdeQcymmPu7qipa7TOzSdQCbcinVMTrvy/gGM5f01qiBXJ4rs3i+sGj+TzJTwVvf7X+XKzOdm62tuo5A/r6G9QVKpBSuwMT8zDBlFmiqwM1+n8Fi00xzIIBcaR8knsO6ZDQksC/+htCbLo0Ar4uxNqQeVE0xHOtVsS6Pi+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676292; c=relaxed/simple;
	bh=cwXlTx9GaeR3YI6HvoAT3snin2vubS1hL+fjX9EFVqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGFUNg2XVCbSBN64/15lDCKhRsE1cobDpLZYvwCYDV61FdzvkJUAs1NyyKrU6ErnYh/N30hSNcMWaJhzLrRLJcvpxESOKiLmiawIQ7535s+VxNmfk9UjBW9Dg0T0Z+xSSwTxScVPVHxaftQTtt3Amq0rA8DQsg7jxoI/q4mrCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4iLuFZf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e16y6gPL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4iLuFZf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e16y6gPL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4E1525401DA;
	Tue,  4 Feb 2025 08:38:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 08:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738676289; x=1738762689; bh=IxlASSxiHC
	m6ZXEHkcvrIt7ReBfmINoPQk6KRsgCjIE=; b=h4iLuFZf98Mm6ZbB/ratpdAjCh
	yIRtWzNRXzGliutwfh3yFeG7Ci+h5Q8gk5EcT/etpTs8l9DP9L/T4TbWXLWfBQVw
	ow1LfFXMWsYtmz1vR/WDG1MbL12zLDfjSJAMdpiotvws5xm1X5neIhGvjgzu2tRH
	ZCzXVPhjZ4sHwXIrlYr2ZstI0zBY0iK7wTqGUlUwHLuesMnuCJGH1bEBaD9MOso4
	koQ/D2Y0teEubW/22B2zVX/o72r04rGOBEJ7BDRR73wjUpKZVCA6PtH0wEdF9vLE
	fYcUoHZYUjle/qCVvdAdxdUu236UlYPxuGunNbQWJcIVAs+C5yUrouP7KX+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738676289; x=1738762689; bh=IxlASSxiHCm6ZXEHkcvrIt7ReBfmINoPQk6
	KRsgCjIE=; b=e16y6gPLEON/Fv2XoSW4tqp08VXNbsEeHJTLwTX5nvzmrJQV0BU
	ZVVaMxmGRyKvJKswaxJo/Hxdidfm+bLNPmDFTfq2G9qHS4qHiyRwNVHuzyTLQxq2
	+nC8DfYjGYSqK6yISv/S7Ab6qIH7dUacbhVfD/Wx0QCk+LmzM3meLfa4ZPNzz7WP
	Sjgjyqhyq4lc+gKALi2Npxe6ceoziTU6qGB4fF6A0ZEkRrZ+Ingc14vOZVMNJ6+q
	NKnTUrg6MxB3zQPPserma8w6xRzAHrkFNpNDSVGLDShEzH1FKNlBDM3KAplWKSvC
	hI6AVSPSl4HcJJhMerEiovHk/MMX+IqSJ2w==
X-ME-Sender: <xms:QRiiZ6M51yPMwgYVynHMH-VVLEWsL2NXKjAYraVJ0qssfi1-6Kcjzw>
    <xme:QRiiZ48YpmTHJj2zd6VP9Gpc2aLGvRjS-fSiTP7eLBehrPz51Fhw6IIhzKhhHnVC1
    Y48qb8CXy6MqTLZvQ>
X-ME-Received: <xmr:QRiiZxRH_bG_Pcv4EddY1QzmsEoktpTPK6pZ8MBAFarhzjsbLfYnaH6Db0kakekujT_oTctyYDPdSiIFT6AUvIc1hqIvNKUJbXF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhrggtoh
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohephigvfihonhesrhgvvhhirdgv
    mhgrihhlpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QRiiZ6unBnrtKtzrmaIVU-rexKF9DVrhF1Snbmvt-girbXUuJ8i9dw>
    <xmx:QRiiZyfKYAf0cJuMmuJ5-sIQ0uWPeJTNATfZs6afyQ0txdmrJBxLVA>
    <xmx:QRiiZ-24r8gCYx3GbLUJbH43BsOGjomwaim34qC6M951myknQ6DMPA>
    <xmx:QRiiZ288EMb_zsNRG_takCb6T7O2NDCqulKca6jm673Lz7Md-McZig>
    <xmx:QRiiZ5wcnBhcTIG2uTdyhir7BrpHSYOKw6ITlDPf4dGbJZ6VW0Edwhiy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 08:38:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: David Aguilar <davvid@gmail.com>,  git@vger.kernel.org,  Scott Chacon
 <schacon@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>
Subject: Re: [PATCH 1/2] help: show the suggested command when
 help.autocorrect is false
In-Reply-To: <20250204030501.GD23954@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 3 Feb 2025 22:05:01 -0500")
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
	<20250201213319.153109-1-davvid@gmail.com>
	<xmqqpljyzlmb.fsf@gitster.g>
	<20250204030501.GD23954@coredump.intra.peff.net>
Date: Tue, 04 Feb 2025 05:38:07 -0800
Message-ID: <xmqq34gtx22o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Feb 03, 2025 at 02:53:00PM -0800, Junio C Hamano wrote:
>
>> David Aguilar <davvid@gmail.com> writes:
>> 
>> > Make the handling of false boolean values for help.autocorrect
>> > consistent with the handling of value 0 by showing the suggested
>> > commands but not running them.
>> >
>> > Suggested-by: Junio C Hamano <gitster@pobox.com>
>> > Signed-off-by: David Aguilar <davvid@gmail.com>
>> > ---
>> > This is based on the sc/help-autocorrect-one patches from this thread
>> > and is in response to the open question from "What's coooking in git.git":
>> >
>> >> On Fri, 31 Jan 2025 18:51:33 -0800 Junio C Hamano <gitster@pobox.com> wrote:
>> >> Looking good except for "should 0 and false be 'tell it without doing it'?".
>> >
>> > source: <xmqq5xlu4bt6.fsf@gitster.g>
>> >
>> > This is what it would look like if the answer were to be, "yes".
>> 
>> I obviously like the updated semantics myself.
>> Thanks for updating it.
>> 
>> Let's see what others think.
>
> I like it (including the new "show" which is even more descriptive).

Thanks, really appreciate it.
