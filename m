Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75E5FEED
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358606; cv=none; b=b/ZUCWoQfkVOlRagDOJc47giM1m5F2HZiQtt5D2PZ/gt+JRAz7ASc1xrcDSv411Kv8NTASRf3UEGB0YME22ln/h1S3VBRZ4iqIrfNUs+j4SjvmIzOHfH34XAULBUai8zN4l296fdUq2RYFDGkXh5YKxTyVWjroc0gGSkZIithYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358606; c=relaxed/simple;
	bh=Rd8M26++fEAn7ZT7R8zApEPL9yEMy2M/UMQgTZy5O5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSjwEpZldR1k68Su1vxjVzrqKgCv3lqml+HIm/qa6jJprELx6c5Ci90Ua2Q0+QrtF3F6jX7oVlgIMKfYLiVzoY8jTyrEzjoHLMnwfPKTOBpY611N4e+2+UpNIC2tw43B1qfOL8n9iKnWNGgr4uM2wlTgFsM8rWLasUs1O7pf9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RbVniD5/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0WQZWEP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RbVniD5/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0WQZWEP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65844114020E;
	Thu, 26 Sep 2024 09:50:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358603; x=1727445003; bh=lpnX7KqrtE
	bNGTHhNejBHOA+8pIUIiBXBWHg/axRa7E=; b=RbVniD5/kJ8To5G/88XJLPqTSM
	SsydqtEsR/x3vXlrdVWXf0+qTUehqE4SSrdNuvyPrCa7rn7Xy5y7vW2lap7nzv0t
	PuM0sAaflr8f+wvNOA+NDMwdyYb5eEX0vebT1oUArysTlemIrfXHjp/dB6wHigQn
	nDF29x+PMzdvQ0ltTg+SMNlb7wPHXx0PwL5IuhooZLsSDTAVrxQxT4y2+R9dPfq/
	bkOSg3cZQqVChIs9QlQmMM8wk4jLnGYE4uylP2fXXVMNxBC6LtOja1zZhb3WF7mF
	E4xSVqKaomh+NGRroQCjx39eKpDTGyt5oQxGBCiMcA0d2rqxtAALgt9u+QtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358603; x=1727445003; bh=lpnX7KqrtEbNGTHhNejBHOA+8pIU
	IiBXBWHg/axRa7E=; b=b0WQZWEPGUCXu14A+BZcyJ0SbQPMndU+uH/V1bKLl0Cc
	6wlGYi59O871UthGZKsn07gb9AtAka4Jn0BVMYRI5M5b2xk2I91jWga/VkttAiFV
	rdGNLUhv1SH/X3twQbSxw9Jk/5Y4+Wip8PxSoAuxOIismrKzS9Y8sLYfr6M369nK
	AeYW/G/kgKVA4BfwMl56TNc2H6YcmMs938ZFQJR8MK4aioEyfxyinXWTk6r+0g6a
	K7wsD6boW7FXpApsMgTblE8TYZnJ78F2l+1w6qG80naNXMlbiI0l3t2ntyae+J1M
	RYexEcHPPRa1HD4j6qzMzJmsbqUBnwlHpCeSyQpQ5g==
X-ME-Sender: <xms:i2b1Zn-RD-vgTR4DpLsuMDEpc-jIhuYtAcaB3wAqLk92X8gC8BOrZw>
    <xme:i2b1ZjspY51bpuDELsAlX5KYS88SPN-ZCAo5QHbC78xKVm0GXtFdEU27OWHahsKpJ
    fBCYzTgixJ2Cjwxrg>
X-ME-Received: <xmr:i2b1ZlDoBz6vbFVxVjkGnWP7Ksmp4damTDK-HYzGek2eChsmJPqaIKch9muFrQL_3EOFAxhN3BRqjRlaVV-dBjnPMNoECYDw2UNXTcMqgqQORg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffke
    dujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:i2b1Zjc2uVIEWPQPSe4bbUo3Vgez3kVu2a8guzjjrMsgWWwxYjg1VQ>
    <xmx:i2b1ZsNDiYi9RVVlCjswSRxNEj3iDXpNMw_u7jQLBg3_BGonofjFwA>
    <xmx:i2b1Zlmo_YewaefEPuWysFVex6tcsmTueJuW3A777Yt3VywhaMMufg>
    <xmx:i2b1Zms16p7JD2awJIPs_9TX1EjqMZKuu2h3S0xKOztP7eMTbc4-qw>
    <xmx:i2b1ZlbmwX-qnO7g-gy6oJYbn5FhAPLOXVAbQ2m3sFD1QbgI2mh98OCt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9b2ea0cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:24 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:49:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/28] fetch-pack: free object filter before exiting
Message-ID: <ZvVmhxWGJEWQiWYY@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215207.GE1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215207.GE1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:52:07PM -0400, Jeff King wrote:
> Our fetch_pack_args holds a filter_options struct that may be populated
> with allocated strings by the by the "--filter" command-line option. We

s/by the by the/by the/

> must free it before exiting to avoid a leak when the program exits.
> 
> The usual fetch code paths that use transport.c don't have the same
> leak, because we do the cleanup in disconnect_git().
> 
> Fixing this leak lets us mark t5500 as leak-free.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fetch-pack.c  | 1 +
>  t/t5500-fetch-pack.sh | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index c5319232a5..cfc6951d23 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -293,5 +293,6 @@ int cmd_fetch_pack(int argc,
>  	free(sought);
>  	free_refs(fetched_refs);
>  	free_refs(remote_refs);
> +	list_objects_filter_release(&args.filter_options);
>  	return ret;
>  }

This fix seems familiar to me, I think I also had it at one point in
time. Cannot find it in any of my series though, so... *shrug* Anyway,
this looks good to me.

Patrick
