Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905CF2556E
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357148; cv=none; b=hCZPmfaU0NgrRYLsFndc9y+1Tv2yk+dNibGuFBgps8SuarivXotxZs0Kzo3enXikTNFxRWdzmaRTWCEJaLBYmuNAgKF50JV7wJiEXEZGx60mehlCo5DP5Pi0kY/ORsLvlRdXb3m3nyGMKuC5PLTGpHEVFY369sExfevOyAuL//w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357148; c=relaxed/simple;
	bh=tise922n3JEurN7F76kc6rEf1Wwd43entZZJGe0i1gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5nnvRE/mBZ2tv7bo/ceWQUtcBS3GAU/+KTfFxfB5IfSmHH0cFpd+6hOIpixHw7BlFkpcnR0wOYUczgD/SugurwclyIz/wy5WhZLW/cLNDG67cnL8Xwyq6/0wy9xiLb6RICKCl9eIIbReoKMCWpKFrni0qEc8NoGRN1ODNUATQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQmgAuWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DJUyOX/n; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQmgAuWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DJUyOX/n"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A2271140123;
	Mon, 16 Dec 2024 08:52:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Dec 2024 08:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734357144;
	 x=1734443544; bh=0mQvV9X3bikXpapjpUrAOh3edn8OeG5X99/Z1g2nI9M=; b=
	bQmgAuWS/Yptvu9rM8YVoF+wxD73DKPjC2Uu1bzFAZUQw2/zBcbgacTrcU5Cabh2
	akujCGn1RZDjjZmN0SmO+vR5lnUqm4Z74vsXd60qjrhen3oaK6ZZ5xImmRIib8Rp
	ThrF/8+q/kWfH2EspRgYJLiKMIkEgSfKjK5WWYNgxo5CAcptMqBggEtsFwoJVc2/
	kl462ikYzdMf10VR3zkC2wDZp0JhICcuyjCj7qj0hIxHzQBQJugsRO+rP931y0qq
	Rz3wa4alsUaVujXUEH5IuI21rinQVAmLqO09UKhyqK7428lNOxm58uS8iCsjvR0g
	FmbF+b+yHNMor+Mv95MOYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734357144; x=
	1734443544; bh=0mQvV9X3bikXpapjpUrAOh3edn8OeG5X99/Z1g2nI9M=; b=D
	JUyOX/nquT1+BTBB/OLP6Fwh9CwYpWcGJ3kmrDBb2rUcE0trkGjbCF8KBx/PPXQu
	ANV93/cthUcRABR1L5lb8Wj5rdAcfM+cV8UN21TZL+ncFOr5CtsQSEcQ+RlZumF8
	UU5dvp6rRXYd9H1sn/qTirUJ9FkSv+hzBJ+f0hbKoz0iN3FA9x6oKkjSzzDkoCJd
	fbRm3kj2zonDjPNIsNczthg3PJoPd7NNtmXtLH/Mzer7vqeNTkhFENEi6y1LEShg
	gHabvYQdh2lw7UXpqq+uANGy+NdFTKWtSoY5SFQ632DzYBGu2Qi48GE5H4BsValq
	T4LllY7kn2W10UGpPVT8Q==
X-ME-Sender: <xms:mDBgZ2MF4JdYJo1Ke-jBUJaJvQsG0UAOILpPe5wsRZj_zrHGVTf9Tw>
    <xme:mDBgZ09ZcwiXz7XC8yrb43IwEHpWm3Ax92J2Ze9dPRCYMkSWyQEvlobHuBW4Yx-BG
    zkqCcvBx5roREm8og>
X-ME-Received: <xmr:mDBgZ9RYjgk90YiwRN4j4f3GmR9MK6RGtZdJZ93VvtpH1cd3Vflg0Yrmk5140nyvE6zYKPo5MTYN2OBZT2M1h46AU14weBGWawJpGZ5MScdMmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mDBgZ2u2vfV7qd6rYMbpVqj8eTxI986fVnafSJDR7oRNHiFJ2c7l3Q>
    <xmx:mDBgZ-eRkkS4ykYXMkiT0FHpOKwW2vd1bMQ0vzJJObuWIuG6kUY-WA>
    <xmx:mDBgZ61FWDVXWQmohdSI49RXUSCQA5iE2mVKTzXkuTj64MIFHkRYig>
    <xmx:mDBgZy-qSLkYMQwbuem4qxt6row9WnOFwIffeBa438ePaTrC0TBfcw>
    <xmx:mDBgZ_pUsSsYBF5PwWy9ynRxvvQIxbReI2mMTO6HL5npUYNOCFw1BLq2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 08:52:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c2052ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 13:50:38 +0000 (UTC)
Date: Mon, 16 Dec 2024 14:52:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] Introduction and selecting microproject
Message-ID: <Z2AwhvaE4DLAxzDy@pks.im>
References: <CAPhwyn20hzG=kBz1cUFhCaEbh1upV3V+M=PRuO=3MugDAKQiWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhwyn20hzG=kBz1cUFhCaEbh1upV3V+M=PRuO=3MugDAKQiWA@mail.gmail.com>

Hi,

On Mon, Dec 16, 2024 at 05:16:01PM +0530, Meet Soni wrote:
> Hi everyone,
> 
> I am Meet Soni, a Computer Engineering bachelor’s student currently in
> my 6th semester. I am an open-source enthusiast and enjoy contributing
> to various projects. I had the privilege of being a GSoC 2024 student
> with the Python Software Foundation, where I worked with cve-bin-tool.
> 
> I’ve been using Linux and Git for a couple of years now. Contributing
> to Git feels like a natural step forward - a great opportunity to give
> back and learn while contributing to a project that has been so useful
> to my everyday workflow.
> 
> After reading the applicant microproject documentation, I have
> selected the microproject involving the modernization of test scripts
> and would like to work on implementing test_path_is_* in the script
> t7611-merge-abort.sh.
> 
> I look forward to your guidance and feedback as I begin this
> contribution. Please let me know if there are any additional steps I
> need to follow or considerations to keep in mind.

GSoC for 2024 is already over, and we have not yet started to think
about GSoC 2025. So while you are of course free to start working on any
of the microprojects and contribute to Git, this would not be in the
context of GSoC for now. You should keep an eye on the mailing list and
on official announcements made by Google to learn when the next set of
GSoC projects will be announced.

Patrick
