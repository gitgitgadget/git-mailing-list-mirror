Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644EF44C66A
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218587; cv=none; b=do8RfGMD/wu8mPB6D2pZu27Voz0TOGJY/Nq932lEuVTbgxH3Wzkra6Q8W6FxY2qdA5hwkqpv9tQsWDrsRFaO7nxEBXiC50QN203RzcST66IRstEN0Rd+ioQSB8k4CHRjg8EQzhofnAaGuFKzTT/wACHF2QT2B+XuPeR+pg8LQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218587; c=relaxed/simple;
	bh=m5vtmU6UZIIohJ6Crt5IwPb+2w8s0TW/CkJSTUPa/ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsW3AMv1UenmRDwKiIwWeWSzxXEtNBddmrPjOheAG+ASR16bcsxKGpioaKtBQNsRRzbR4eplAeuLv0zDkzQyTo1mDNtL4R306VXqFM++VuttcjFTktO8Up/X11UJ3ORw4XUOeeLX2yya8DdGuR1w+7GM5f0hvomGbWGPQdnx3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KcbuEDgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIqqy9KH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KcbuEDgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIqqy9KH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60B3B1400186
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:43:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 12:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791218585;
	 x=1791304985; bh=OsyFtuXmRxWKhsKHFdQbrI3oWwMLJPxHeytuER9Q1u8=; b=
	KcbuEDgyL3LWod+Kvg8zrTkseS2WMV0reUcedsp8FSbmRw58a/3OZrzbfbW3DRpI
	Eh4aGWuwFGNwzlO4KXAvbY57EJTY+Nft5KW5LY4yj13A08hvPVFDtSBMZ4duQla1
	/mJaMoT2Phm74byKFDWHdQ5NYsDdhtag+YP+bM499VGJbB9mN/MtgyvWtkyYgCGJ
	l60nEVqfnUOI4xUu6GTc9NLIVDCbjJ9NPeCMopXXkM66fxA4DJQkLDVM0qO1cN0g
	jy4YqkUTP0Pc31hiplLYIni2MRubRC+zxLfkz5C/ViaXUTgokgi97Gv6EBJaGFta
	EHDgazf6ipm8XcbqGvTNTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791218585; x=
	1791304985; bh=OsyFtuXmRxWKhsKHFdQbrI3oWwMLJPxHeytuER9Q1u8=; b=u
	Iqqy9KHXomlZzkE3mHDkj4rBJsvovdUScfxZGARQsANMUb4XMZdCnFkG/QamUwLj
	RCUTyrUBdVTm34QE9Q1s4lFvAOwrB2o0UeQt2PUT597neoCbhO4whSOLK927NrI3
	RoN64FIvkoo1edwuI1Lp8QgaMu+468raIhaeTD7MUlyfKJ82w14lwHBj1Av2Ws5c
	wZm370ThGaBvilk+yWgeJdT1NkcZ4EjDs6pS8Ndf/fjLXDUTQBejyE6VUe7hwTFQ
	kA895lSsip3MJz0QNwQ2HuF8b0dL6HVnzQlFX/9CfSmB9kMmYkobQlX1lJSzfBqS
	DqsQ8CHK13JKsvFWFA4qA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791218585; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oDphbNiPCx3m3MrT0q+niFdNCxw2QpyNUA5dl1g5q4NwYhb
	0m+xE95pAgSoUKL8vG9YDs3gnJ9LitfOtzVmIw45/OVlc3LIMZ0DYQ3F7nZa9MJ4
	prj8bLsEW/jm1cINywtJoRK78XnfXLTa/xbbhImvi/hqa+hpnR+9P2lW7ZEp6l38
	2e8mglqBCHGccT1MKNDwBwuLuWHgTeGGQorrdQ+iyOvCCExXMguGD2CIBwMH42qg
	4vlB7fCKOgu1/jMj88WIJrvF/zuQLyuAEkSXJtU1pfjRsUIDfKVwwrx+fUQ1ZFs9
	WnvKbzO0ygmOvnQ2Xr1CsnpSsh/mYpRwGzokt8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:YA4g6YI4fWVNbZ30mRu90ihMCvTD0liupz2PU65Gpls=:m5vtmU6UZIIohJ6Crt5IwPb+2w8s0TW/CkJSTUPa/ao=;
X-ME-Sender: <xms:mdPDaqmW1kVvzGca7NS7xtlvBVBKcQmq1w4PEOBnpyWRrghZQOFUig>
    <xme:mdPDarJrc93zCMbraqp1vVWWkf5veehFW1OFr_bKGFOkYfk6SM6hwj2nu1q47w27K
    6vQiWx7Hnye2XVhqKLEWMlIBdMX6hovQhNR3N5NZoZCtWBjipWs38Q>
X-ME-Received: <xmr:mdPDav6VdAe2oLv1HCglM1tQvDnGRFrO7Ym09p5f-EIS7XUbAfUqhQP--BL7AuQzdJzI8mnPXJQCdxs_TTDGtjqpUGq8-IWYcvhf>
X-ME-Proxy-Cause: dmFkZTFDRUontDxMDUZ3KuTB2Jq5eiudjCwXB6+Pd5KnvyPcmYayFGDxA5LWCTHte4fUnX
    naH2EqC/E1B7NqvQVbHrdktecVgOZRn+ivrm3I9DX2cCay/Yjp/rihcKOohqJUbXAys98a
    j6h5CegthiKni6xAXbZCw5Td/jd6CBeQlyhJb7FMWUnw/nNImzYEClPCFzV5rmiWYd7EoX
    auSnzt4bDfBRnDoC9aJbDV20IAyXeXa7qd7lVJ/qtBS5b7TvS8LL6h69xfv8qXb2a8zg6L
    FhFbJELde5eQv+ufcCkqyOiGxhFZRXQQLEFziCEXcIyvDdbGoYemNd8UfHmJ8cbKUUqhi3
    36xsiwiE8guxEtuTSEdHB4VLjxqU2N5C7M0G0nHhs0QzFt4dQM6qMej0waFpKWHEtzaiPm
    l9TzMNSeLn6FVNf+cKv34DFWvU1Xzzf/G0efD1oz8Wq6n/YQA5PNAsVWLimrSjL/U5kG1X
    8FYl8nd+i029okGvE20VBkaoCTLuZiLZ48pnyFxx5MwEm/gRZJF7RiRrvrGjmg3t7JQwxj
    /VACGcLMMXjtEyq5AHH6/iLKndDmocoelf56WxVIgKWJ3x5lMU3Re2QkB1t6C+DqMCeTd6
    3gglEOEIOlpexNtZ8iJ/vvyKRsS1TLVdqUWNBn2CYGQs5W79T3AJCtMnElHg
X-ME-Proxy: <xmx:mdPDav0vvgRwsy-CYY-UOs5Le2f0R5dlPNMlD5DsMJobuL3wMGF8JA>
    <xmx:mdPDalczXJW1_mXVuAWDzJU1zhwvv98noy76VwdDltMu7fQJoooVVQ>
    <xmx:mdPDalcKZDPpTm1yUQNAJegG3cJlmo9-N0AwX8px6NsP5yNtiZpt4A>
    <xmx:mdPDagxtWqhxvDIt7b9DtTaoNmhgwEpc9zgp-rDffZZsX_7Xtv75sw>
    <xmx:mdPDapF-oLFWUsMhbcKq1yFnXvKRqyTw-ZnmIvuHoh33vOtFcHsDufzs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Cc: git@vger.kernel.org,  shabbir.r.bhojani@gmail.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im
Subject: Re: [PATCH v2] stash: expose untracked modes in create
In-Reply-To: <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
	(=?utf-8?B?IumHjeeUsOS4gOiBliIncw==?= message of "Mon, 5 Oct 2026 01:55:18
 -0400")
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
	<20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
	<xmqq7bk173qm.fsf@gitster.g>
	<CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
	<CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
X-Gnus-Delayed: Mon, 05 Oct 2026 10:48:34 -0700
Date: Mon, 05 Oct 2026 09:43:03 -0700
Message-ID: <xmqq1pa4ksiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

重田一聖 <kazumasa.shigeta@kanamei.com> writes:

> Your question made me realize that I had focused too narrowly on the
> untracked modes. The larger issue is not simply that `do_create_stash()`
> has capabilities that `git stash create` does not expose.

Brilliant.  I agree that is the right way to frame the issue.

> Making more of those capabilities available through `create` would
> therefore mean either changing that contract or designing around it.
> That is a much larger interface decision than I appreciated when I sent
> the patch.

Perhaps, but I do not think it is too huge a backward-compatibility
breakage to forbid giving a message lazily (i.e., all strings in
argv[] after 'git stash create' gets concatenated and becomes a
single message) that begins with "-", with an escape hatch that a
leading "-m" will take the next argv[] element as the message, for
example.

> 2. Add a new stash subcommand for the creation functionality.

This is essentially how 'git stash save' came about, to give us ways
to control how a new stash entry is created and how the working tree
is cleared with command line options.  In the beginning, you did not
even have to say 'save', because 'git stash <message>' was invented
as a way to say "the boss is here and tells me to work on something
unrelated. clear the slate with minimum number of keystrokes to
continue working on what I have been working on later."  And that
later became 'git stash push'.

> 3. Add something like `--create-only` to `git stash push`.

This also would work and sounds the safest.
