Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAA380FF6
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338950; cv=none; b=NZhvsUZEkDl1qj4++Ea81Y/EWRKjck/lmiUlrMviHGNn1i6STykN3bDNaBKF6hlMi4eMeYHhPDXLb4vM29CJC3kCXBSwaen2Xgn/L0igZedJ5nI3qgA8n5TzMdT4RE88LpNE2+pA5RxKxWsS2wCMMKVZt9oKpSrcXcdJ7MoVlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338950; c=relaxed/simple;
	bh=xvG5QZ8X2sBZ+j7cgiEjLxETYBtsoVOaPLHSOi4hYeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7jL885JbLM6C3DUeymqYNzQR/YnqzJ+3BbDk1RE7XUIPxfwH+MwjP0Sjk1lWTJF8LheXVUk3BiwLyIpbXV53unCTwR53iJ17fhfy8i4cRnBKGKM8UYh0JKHyigMvv3NuFbmH32etK4bwUKyrwIUJLODRaF1t470G0zAlyjoDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TxK3seCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=er4Xmahy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TxK3seCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="er4Xmahy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44C6B140005F;
	Mon, 10 Aug 2026 01:15:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 01:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786338947; x=1786425347; bh=u+Z313s8KQ
	TrUi8P/dgu0ImHjIt0gA9Yykikb+D5U3E=; b=TxK3seCvV39fuNkA4BwNCGNJiP
	663y87pz+m66+OHEZgQ560YGJ/9yO2VgViQemU/wBgSZss8ZM4n324dHQ3AGLSmT
	NkYQZffWN2Ie1n04CzOgoAwlIpiHpsmqIIM9hPbktsj5IC9qBp/hwhEJXO2HPbkP
	8nLB5/F5/k0R2oKeo69McTqczUHw9wTq9cC1XUH4HkeHquSmnL4XhYLkaYYf3yVJ
	Mk4SNOw9l+c5BaQhzYzuBBaKKTM/+/JM6wsZNqQ0qy034vyKefQz6mRHdJMEl4ka
	AWt1yF7i9XPSgU8H7VLgsG+aYiC3u7FFXoH2uQ7cF+X/AxY12MfQ7GROq00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786338947; x=1786425347; bh=u+Z313s8KQTrUi8P/dgu0ImHjIt0gA9Yyki
	kb+D5U3E=; b=er4Xmahy7GyaHYJBK9WYbJNk+hkedJYKPTlRoSG7PupHp2cnFWd
	4E8Qt73Vp1Zx7zlboZZxOHE0XOPuSMyAQSd3AljkfKMIsMnqXI0DGUSij1xRUC9l
	SsgQxc8wNQ4HGDRpPvDcAdJQb6o3PtWP/lvaKzAG/Nn+6wJH/gObnQghMuBu2eBd
	InZr+6pFS8nIue2IPpgnacIQ9rEL3CHcHNbTyuEMEOyljilNcZip5Y2TzL371iT3
	FMIioueh1xQs2tWjJU90UUN96fAAtqpjI9QqV/u0ZBmVrDg9CaoFJJ9QGj+/t52z
	KzYNIZtlkR2jZ9ZnO4EFAiSPm2PydgJ0BQQ==
X-ME-Sender: <xms:g155aojStabN6XQFC3KZ8mLs_yGMmG-vQVsiMqT6-n1N9ZHDqUichg>
    <xme:g155anBzhDSPo1YDq7XQEVpokdIHVVdcVlVUO5n24E4CB5W4iydClhR_-o16YIwLr
    NDOPQ102uud2rLpDQQ1Va6agKWyJ6yXU4rnWraIRGTErmqAQWrzwnM>
X-ME-Received: <xmr:g155atu8pBv7Mdjd89yUuJFjEG5Qrzsai6LmlkbwioqArCaqtvTT3rjCLUgKUhJCFsyrfzB4zHGqTv5IaS3xpueOzb0Kzd3bPoBBaNnbXA>
X-ME-Proxy-Cause: dmFkZTGWVFP3PcYEuq0QyDQo+nAlZ+DQqsx3Lin0fKC8Dj7HYg2X0YgiUmpXN5pXGIPBMy
    NAYTshknin28qklMpGxPEs9eYsLh2mxi9KUrfxfHiG3PqY+B8Hu4cl4OIU5nWLAR2p/Cw/
    vZJ2wqa38k8WOxWH1gCdaBGSUQ+jrs/GXeGYp7MzicD+Ty1R/6lLyrEZkkCpKxqYs7j7M0
    MmQGWnqGJpDV4lx4QKeT3hMmrGjJ5sJTzX1N9NEoF0RAQtvrrZkFLoR7emhj9YSh4FRyuw
    6AF/aGFtoy908UoyFbn/p2vQUEQuTBTT0Jcc4VPYUi+YIz+Qh0SxyOGccDsCdh2JPHxnP+
    sSfAIZ1n+AyOJyrCTxJ/xX+EJdyPB5uXG4MiadDpHeLuIbR7B2aNAbrZLz7wc7ch2zDbX9
    uC/xejyXqeO0EZ7KPRiWwF6y78OpPFI6h3dN75JkYC2jq3kJTuZphdfsl8+dSu56nSLA9g
    Er1W3UUavxTZcTgQgl8eXtMjhPhbqSoFWylG2UQX75Mha9Ir8WUF/wW28Bn3c0ABgisq7C
    vADQGr5+1wTO/fqo5Dop3QbvKUnYG0j2jzWdLoQdGH/Xxr55XIJHKTxsbzTsaYP0ANqsKP
    GFIu2jUqvKNf5BIld7cobDK4QrvYIxuA3QZnE2J6nF3jhLjwO8btLkMyRvpA
X-ME-Proxy: <xmx:g155akZ0j_I6zICpruPlKRzhPAg2A1LXDUSMnXuLNsKP6RAq6u6ssA>
    <xmx:g155aoXj2ffr4dY7SvL69-FIsbQQjDH_YfJbZpZYIEKaSq7v95yXtA>
    <xmx:g155ag5JY_xDrhcxuK9r8AUTszhRmxGEUuGburP0Mfx1XhAJkuMRdA>
    <xmx:g155arhhZQKZbNdZkMVn_kqRDCTQAd41AIeYi8IMhN5G8BgFCUhYug>
    <xmx:g155agS2yHW9hp-FZ4zfNz7AeQqyzXAoNbvlL2UoBavlJRWTQ2yikAEE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 01:15:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb932015 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 05:15:44 +0000 (UTC)
Date: Mon, 10 Aug 2026 07:15:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/receive-pack: report unpack errors via strbuf
Message-ID: <anlefHYq57Rz5oW9@pks.im>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-5-jltobler@gmail.com>
 <anWDTwCwMn5wEdIQ@pks.im>
 <anX6w0tFV6pCu1ux@denethor>
 <ani4GoefzYFWjTMl@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ani4GoefzYFWjTMl@denethor>

On Sun, Aug 09, 2026 at 02:00:52PM -0500, Justin Tobler wrote:
> On 26/08/07 10:36AM, Justin Tobler wrote:
> > On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> > > > @@ -2711,8 +2719,8 @@ int cmd_receive_pack(int argc,
> > > >  			   PACKET_READ_DIE_ON_ERR_PACKET);
> > > >  
> > > >  	if ((commands = read_head_info(&reader, &shallow))) {
> > > > -		const char *unpack_status = NULL;
> > > >  		struct string_list push_options = STRING_LIST_INIT_DUP;
> > > > +		struct strbuf unpack_status = STRBUF_INIT;
> > > 
> > > Can't we reuse this buffer and reset it on every run to save some memory
> > > allocations?
> 
> Looking at this more closely, there isn't actually any loop we are
> running this in so I don't think there is any need to change how
> `unpack_status` is set up here.

Oh, right. I think I saw the loop in `read_head_info()` itself. My
mistake.

Patrick
