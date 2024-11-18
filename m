Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADD17BA3
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915920; cv=none; b=JQyRtOr6/xaxwerNLrG/3e9g3/RDEQJqc8i1FrlhrKU/L2JRwrbezxeJG+EWY9HFj2Z53HEAnNuZwnb/YiryrDQ4w7rfjpcUTT49Gp7zOloMH9OIHx74Paq1DBZuqaZ71nf8whXQPxl2P2/wZfKFRz+M8Hi4x660JnanZdgmYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915920; c=relaxed/simple;
	bh=ICPSDTG5T9g2S57EBz+MmXeYQPlOKg9nl3sII5oITVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK5FknpCdZkdsrK889cEyi2Br21FocALBIVuzWXfvzI/9FcESTIYIhNzCiIzRofX4TXeUM9d7du0TiNWRV04NfwTQ5Jj1aJmGYfHe4sick7q/cNoQmu17A/gbLAG2kQ56+aKuBowYSrteaTteP5JRAu9e22p3gGAm8IyIvmdw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=btg5AlzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dXd/cCMX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="btg5AlzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dXd/cCMX"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 82BED114011A;
	Mon, 18 Nov 2024 02:45:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 02:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731915916; x=1732002316; bh=9UFQcc3yz4
	E/QD1iGTNox8fciwLnwQ9NN5qJU9wNFuU=; b=btg5AlzGX33jjFj40mweeqHErr
	b1Y2TcbzFtT6PMYwQ+NcQRXeytNNcGC+XbVVmhA9wDLAhktTWF2rI2LFHre0yG4o
	/sOqfk+m18SZ0jgxMW3674wAGXeGRX46CTuXWOxlRmlEDrtvOrmVhFhrc2+PjOrD
	ftus9qssrpjdOsNfv19WNq+RdkbxqJVVMdt9HZLAZ2+lCqlLLufjF1huY6ViF9eo
	d6dgobtCLxUEgyMWbZc1N1B1O69SM1BQ+bQWju621PFISY4NqcR0Y1b+T+7urvYw
	xLjtuHM0KjbnJZFagzbrU9SeWOHTdOB8w3qJc/TGR+CPUNKPKnw9jP3ALtzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731915916; x=1732002316; bh=9UFQcc3yz4E/QD1iGTNox8fciwLnwQ9NN5q
	JU9wNFuU=; b=dXd/cCMXUoxu+MzTbM8kPvQ7+Zpy2LK3G/jQghCsQcP6o2ifvxb
	fAsTO8K4cd6//4gqw0cZftVfWwAWx7J/XexwtZ4CfnzhtuwzAv2YcBSsGT/8Eki6
	4piyvJvQFbNF0bgCufyx0SZsURaLx4iVuArRb2Sh1izt0j1otoIcb2uQiI60KmpG
	7zaWEVgZepePOPA9vMN3TwAIZul/sZ41KWLG/cYNMeDKywG8DONqwJyYAlpE+fOZ
	2fmOQYallWNwyeUfyUboygPdIgxrbbfoSe9FLgY5GshXjLqL4ItAojfDkdys7se7
	j9/wDNMKjLPkabErpnwktccYilcLYBdHuPQ==
X-ME-Sender: <xms:jPA6ZwdM6AJQlmbKqQwN_iabuo0xw-IJVxjhAnsUKWJHZICaNCtblg>
    <xme:jPA6ZyPFoGGLcvd90yrzjf8zixikBmLt9RJuLeCLXuY-mm5LVFbGGXD7WhtTtZhiz
    QIKXhnGL5L1pNoutg>
X-ME-Received: <xmr:jPA6Zxi6NRDYBJ_eLIm8JGeyXJUY9e4q0U_O3lo_KQ0Bb5sA8-2wM1FEcxhMGSu9hHbeFdlNYHTboLYEHH1QytS0gOvcRoFFa81ciU7fMZcobgVz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:jPA6Z184Fc8JH8VGZj3XBBl06DKWUKVlfQ3OtKAoehliny5AESxzUw>
    <xmx:jPA6Z8sehtJ-6zsz1ygkHWKQRXoyXh7k7K0jcVjpK87biRNVFBMtcg>
    <xmx:jPA6Z8Ea0BAQ_mKSNV3H7v_tXwo_edHk5fu-FYuHF39Y9aS4VBUbKw>
    <xmx:jPA6Z7NbLps4Fb2wuhCXPmX75Z0zGjrwivpn4308y-KxR3uMdHLPGw>
    <xmx:jPA6Z-KNvo6mKCWtXbwnbFyOWSw1ncNaOYEXWNS74xJolU9jaqKk_hpL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 02:45:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a8ba6cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 07:44:26 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:45:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH 0/2] C23 compatibility
Message-ID: <Zzrwf2B36RgbhxEa@pks.im>
References: <87ed3apy2u.fsf@gentoo.org>
 <20241117013149.576671-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117013149.576671-1-sandals@crustytoothpaste.net>

On Sun, Nov 17, 2024 at 01:31:47AM +0000, brian m. carlson wrote:
> Most of our code works fine in C23, but there are some new additions to
> the standard that conflict with either our struct tags or functions.
> With this series, the code compiles and passes the testsuite with
> -std=c23 on GCC 14.2.0.
> 
> brian m. carlson (2):
>   index-pack: rename struct thread_local
>   reflog: rename unreachable
> 
>  builtin/index-pack.c | 10 +++++-----
>  reflog.c             |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)

Both of the patches look obviously good to me. I was a bit surprised
that this is required in the first place as I thought we were passing
`-std=gnu99` to our compilers, but that is not the case with our current
Makefile. So I must have been misremembering.

Thanks!

Patrick
