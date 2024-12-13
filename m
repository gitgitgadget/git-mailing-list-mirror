Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339032A1BB
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060679; cv=none; b=IQ9BeOHrBE+2RtV8QSbaC4VFkyw5TcniShAuhjYhfXxqMCPPGDfAvBoxhUAwZ1ZqfsumkPhqHdOD+74SYkHgMAoPcWACLfgj0Udp3Xz8T/5/zg7FRP094DsNs2AdCn3zmA37wFawFXgzKpdd7Jfr7Omvl4OtL9uKPnP/2P1cN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060679; c=relaxed/simple;
	bh=HCezX4o8TCpXjtX98dlIYUwy5OYmrvL3bkY19eZZPCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0HSN1NZLK1UYlT8vBFYwjnYsO9I5VT499CT3xZ5ULBgRmTyaxevWiuVbMsiIzj2TwAH9X1ULHz/YqQIh2cOzfoCk6tIrjln6O+vctBw/OYVRd3V6miWi0H27aCIOTWVn8a7RRoyjXnyC5DEh0Ct/QvZjAJlqcMYkd1OmEYfkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bRY+upLZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffNT6LBs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRY+upLZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffNT6LBs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 481C7114008E;
	Thu, 12 Dec 2024 22:31:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 22:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734060676; x=1734147076; bh=qQJhURiZOA
	9qFz597ZWFJauMBQDZYLfreoUSKOBMqzc=; b=bRY+upLZszPPdn2MoZPZWbF81z
	PzwdOd9yZpb7jY8xvoX9b++dXgsvQe41k+ekix5sy2FF2oPgRuC/CjtqEgVWgYN7
	GXfsUg0BVb4Na+Kkn9F9uHw+QCoRQoxsTj+96FCOuafm7SYEa3oQagwdJnDMf52C
	ElWygAVbOBbUwrLPCd/vUSNhlxF+wtv0K+DBgNe9bgOeBGlJ4deZPFH3O/sGdO/w
	e7DonnRP3lhZm7FAbS9UZFOyUTKNkWjj79aYwdCrQcgQ573RzZdRCy7/1eOoEsnu
	jjZKJMG7Qr7zsFMxd4voFAr+x8j5+2gMaC/JL+q/pDjz7V/c3CeckKW4o6rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734060676; x=1734147076; bh=qQJhURiZOA9qFz597ZWFJauMBQDZYLfreoU
	SKOBMqzc=; b=ffNT6LBsVpHImJ2BxrLbFL+Md/nlPqe3N0o2f0qDSeBG7iY7GU3
	vqxnHYdwunjF3zcmeq5WvM/T5aTM87BDi6F3NguUCmJYK9QtpPyCgkNfPSkYYLLa
	sYHxypGw7Hm82TXpf9bj7xSrtQx1by9Adki7oMOuwTDF6aah6kMqX0z04MC64k79
	0dZFHP4DBXIQ3bKHx+cRiuTvLOQ/l03vFN/3xdExNQN9TywMPac0YeE4/D71UvIQ
	MdB2lLnWHA3GDv6fm1nq1N+dhbzeWLW094b1+imeZe2mDOgDe8ATqtrBRkAbot/b
	7ogHkPwtrgTQ9g6J91R1d2r5B+9V23YIzog==
X-ME-Sender: <xms:hKpbZ8h91A4kQrGaSJFPk2PFLQbmUvgshk1Xm8HvGO3GxI2sdHAjUQ>
    <xme:hKpbZ1Ba0eU_e7bzQGYSgGQEzSNIYlGF0mHvgXI_5tbFxrpXsbfOLxpxCm0-On5mn
    cV47oPcKBx04ByPWg>
X-ME-Received: <xmr:hKpbZ0GsZ4qOn3Sfl4MbLj7QF2a3z_8SX-pY6EFCIA-PHRexxQmotGVHcUA1Rcm4UgZuczyh6C5aypiMNUlFY1TAy36t27ozGXM4_JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgtrdgrlhhmvghiug
    grsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hKpbZ9QptoGB7gsMlC0E74PFjpNNvCbQLBiIRPHqJdZKqni_HbTRVw>
    <xmx:hKpbZ5wL2IcEWNzfS4JYgFqK1zB2dqSBtJGqfs-g9dgzy2y94VZm5g>
    <xmx:hKpbZ761IW7jwkIzxfRO4xw_dV6RmK4OvySl4lhNrcFZYZ45Vb4xew>
    <xmx:hKpbZ2ynaO-PAS1r-kSDjy3wdcniVVpaTMNRRzwEMcRGPrt29sg2UQ>
    <xmx:hKpbZx_VV07zn8m4rNyFDetX5dFC7znmoPgzj5WSfk6R6cYQ2eqIc_in>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 22:31:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo Almeida <ric.almeida@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git pull --rebase and --reset-author-date
In-Reply-To: <CAMKQPDaB2fP-4n9_bw1fjB7JntZ1DWMSpO01h5uuMJ-LzzufdQ@mail.gmail.com>
	(Ricardo Almeida's message of "Thu, 12 Dec 2024 08:25:06 +0000")
References: <CAMKQPDZWgq_qCdaL_S8cYYn=wtZSJiq6nP5aqFjvUZcFSnrTzQ@mail.gmail.com>
	<xmqqv7vpfv5g.fsf@gitster.g>
	<CAMKQPDaB2fP-4n9_bw1fjB7JntZ1DWMSpO01h5uuMJ-LzzufdQ@mail.gmail.com>
Date: Fri, 13 Dec 2024 12:31:14 +0900
Message-ID: <xmqq4j38fed9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ricardo Almeida <ric.almeida@gmail.com> writes:

> Hi Junio,
>
>> Can't you just use "git fetch && git rebase --..." instead of "pull"
>> short-hand?
>
> But then it wouldn't update the master branch... When I'm on myBranch
> and execute "git pull origin --rebase --stat master:master" it does
> bring the master branch up to date, so...

"git pull origin master:master" is a bit unusal thing to say these
days, but the "take their refs/heads/master, and copy it to my
refs/heads/master (as long as it results in a fast-forward update
and as long as I am not on 'master')" part of it can be reproduced
by "git fetch origin master:master".  So I do not see what you see
as a problem.  You are willing to be explicit to say that unusual
"directly update my local branch 'master'" from the command line for
your "git pull", so I would imagine you are also OK with doing the
same with "git fetch" in the replacement.
