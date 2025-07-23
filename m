Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985918991E
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248494; cv=none; b=KC0cE5QXDL+Rw/xbGzgajKxg7/U6PzNOAf35XTsxlNMci1uUFJdhdT7bH4Ievng6E2anNqrJeMdhpCQ4ks5K/MhxY1AsPtQ+F8zNbYCFuzz6xp1VjPB7MQ4akblxWnQmtKmM7kEU2V8+vZts2xhLgJZcBKbLpkFhSJpc5nqKTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248494; c=relaxed/simple;
	bh=sJD14RYcKDQNgY6+hiorqde8AuISxq+acDarQxLQLXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxdwvJUvioj5HdoOTww60lIu2wskZ91ueUm4dk29Eq3/Ub/QSk2bpfbEgI2ZxHtA5IyuCvQ1syX1ckPjspFa4WlMyLZWwPdG++fdWN9pxSUjQbeuIhHYzHB/29WMsGGabPlZUbeCHqS+1WljF2dvm8tdapsUZ6vut25PiYlSA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=llt/WCDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1Z6QVSl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="llt/WCDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1Z6QVSl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 558F91D00103;
	Wed, 23 Jul 2025 01:28:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 01:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753248491; x=1753334891; bh=yn5oqwmqvV
	O7uwJyYnmYwFewRQ7phICwL38LWl0/WIk=; b=llt/WCDxx7gFc71nh3pR3M8XU0
	Uhl0brTdWBv84chXnLIavcafLoNqJaOjm/ND4cfxyuCD8KpaaceaEPbpPPhLinCN
	W3hxKo5WmlmYsxkULBrtrPGyvp+wNjCV60t5eDTo/HaLgDTv5M4UrlD6lr/T8d89
	rs/5Oj0KUKyKMZdvCBhVWr55lPkK830kuNxHu22qIb7q2JNel1erJqS4gtKZASbt
	uCnDYiTyumVSr0F8uXuQbYk1+/eU3n8f3lvvgfvoZdjHQBdiTVRLYYHqTiuwuWJP
	cWFT0qyV89FzkOhiZynYSrNEuiqsxAZKc/xysLkKcR36fegfHONwWbjRuLiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753248491; x=1753334891; bh=yn5oqwmqvVO7uwJyYnmYwFewRQ7phICwL38
	LWl0/WIk=; b=M1Z6QVSl8wc262flQLyCxMirA7hZoe0NhMEu5fES1/1ZWlI/lBU
	DOFvxewduWgyj9E/L4Tv4IsF7rsjLMKHXt7VfRQmWWyxYAPd+C/wzMRWg20RH5Za
	7eDWf33uYlvo5WETMmbfKjz8hUXJMtfuDnbELZilJOeQyICVXHNvzhyIvaP6GVe7
	NDm6+jYmRJ8FLG+jMTp/atzLyUX21D8Tb5HEcUb2xjhJ2reIOufIybZtLaGcPYcA
	Vi8FOtb5qU6gspOca2q11mfUCKpccFLXyuN6A7Y4CAuryvTQh1KACvMqysIkkdjJ
	Utw7dETkEz120xdpSXCRNI6ASZFATMowvDw==
X-ME-Sender: <xms:6nKAaLe7GYV5hyiRyOA7JrnzAzZLstHBeQXtP1Dt4jgN1zKFDpm3KQ>
    <xme:6nKAaBZNmL0lQil-dQbQX0qph0t0ll_OOxD3PqmwRzTdS0JrO1pzO-dWTIx3pIwqW
    0YvXpRHw_q_ytb_bw>
X-ME-Received: <xmr:6nKAaGXfPNvY_2eS8iAxXBXeryRo4-nH1I2WvpPqaSlNk12iArBgTk-MOz8lsYvoJ8uOs2KI95DgqLbgddJuBP_A-jOBN5mxF2d5U_7Q1li7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhinhhfvghngh
    drfigrnhhgrdgtnhesfihinhgurhhivhgvrhdrtghomh
X-ME-Proxy: <xmx:6nKAaLhZgnpaMvGc0hS4BrvheGkCd3KSYjd54967eK0IWvnwZS5moQ>
    <xmx:6nKAaMVuUynYmqfPkEphpiE-Y5TXvXX8qIDPj8GpaE3Z-423VZo-QQ>
    <xmx:6nKAaKPaO126Xv0VpDEbvg1aoH3Asy4MtJo3hKo56fm5B7LYFWbfxA>
    <xmx:6nKAaAaBABPgEzXDu3_tO0YliFhvJHeFZTHBLWAAiDioxfr7iVdKLg>
    <xmx:63KAaM0aIlCMRzTNRx-covjiMysXcV-ImBb_O6Nwn-Tg8mnzFku7G0Of>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 01:28:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8192055 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 05:28:08 +0000 (UTC)
Date: Wed, 23 Jul 2025 07:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Wang, Jinfeng (CN)" <jinfeng.wang.cn@windriver.com>
Cc: git@vger.kernel.org
Subject: Re: warning: ignoring unknown core.fsync component 'true'
Message-ID: <aIBy3xH2eZsCZYiY@pks.im>
References: <209ecbf7-0d53-4674-bb7b-3ca084edb761@windriver.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209ecbf7-0d53-4674-bb7b-3ca084edb761@windriver.com>

Hi Jinfeng,

On Wed, Jul 23, 2025 at 11:07:37AM +0800, Wang, Jinfeng (CN) wrote:
> For a specific git repo, when I clone or fetch the repo, I encounters the
> warning
> 
> remote: warning: ignoring unknown core.fsync component 'true'
> remote: Enumerating objects: 41, done.
> remote: Total 41 (delta 0), reused 0 (delta 0), pack-reused 41
> Unpacking objects: 100% (41/41), 37.51 MiB | 10.91 MiB/s, done.
> 
> But after clone the repo, I didn't see core.fsync in my .git/config. And
> there isn't anything relates core.fsync.

The problem doesn't exist on the client-side, but rather on the remote
as indicated by the "remote: " prefix. So there's nothing you can do on
the client-side to address the problem, you'll have to reach out to the
admin of that repository and tell them that the repository uses an
invalid value for "core.fsync".

> I also tried git with different version (2.25.1 and 2.34.1) to clone the
> repo, both will show this warning. What configuration causes this warning?

It's "core.fsync" indeed, but not on your side. The config does not take
a boolean, but rather a list of components that should use fsync. I
guess the admin wanted to just fsync everything, but in that case you
don't want "core.fsync=true" but "core.fsync=all".

Patrick
