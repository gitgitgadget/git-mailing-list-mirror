Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28F15530C
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277931; cv=none; b=WerVFI9XbBw/2ug5YrT0QvnsQ+nvA3KfwLOyxxKPemB2fjRr+Mu6Q7K1qaTZ8jRHkBqkhg7Q0Bpb9Z1g9lhPnPS6iPNUZ1yJdpeLmGkM+g5grdWPVjvuJJR0E3qzJ9eap198uS3c696RPreR7ntSX0io0n0xay832GGCHBAC/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277931; c=relaxed/simple;
	bh=yNg9wKFWd4j7wM8B4B/UVZocssCq575lKtAcqoJDWLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWOE1OJe5sy6uwHbmrS4xVHmUkZAnrtZuOfpFQVGk3UBthdEJuswqUq0yozktn3sbEZLfAZZ/t6sTozo6SHOjigu7AEDP7wdH9pm7up9GOCqevdqEBrezXLxdef7eAbGkvtPdpfgXXFwvwV5swfJXgZ/CQnQ+CAUdTnCyODpfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bPgxtgv+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYNBuyG7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bPgxtgv+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYNBuyG7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA9E31402224;
	Wed, 23 Jul 2025 09:38:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 09:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753277927; x=1753364327; bh=GLGAmCNkKe
	irFFc9DKm8jXelWNjmXMKyD/jhEadU2yk=; b=bPgxtgv+93REC3m7+3sSZpJ5Fg
	hgSghzt7X6oHRTE0CLtRoQqfgsE161/oubUV27zkci0N8VJtFddnluRsF1H7lT6Z
	4qwFfHHi+3u56jP4GfFYAQQ/SQT2qA5hMy5ySxAvtEmD49KqiEbXxjC3qgkanS+l
	rtGXDxmImh3UT2HLB+HVwG+gAm3e8AEsqVsjUA2Ks9NGmX065SVxXLInNWyaSoax
	mV2mA/XN5wYjRN85WHF+yiTm/kbvUaT1FINiE/Nq9BUd+8EUYi9nHQwC5Cxfo+W8
	Fw8hPZBk8+l33YaDtioriQKQF8BCDONnuv335DeDmZyP3rrnhP0e+jaifpLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753277927; x=1753364327; bh=GLGAmCNkKeirFFc9DKm8jXelWNjmXMKyD/j
	hEadU2yk=; b=FYNBuyG7RnUo0Oqlq7LCl4bUnm4juxMjap9mO3sTlPATMbpviPo
	GmBpbxDvQZ352DsNMvEjfcrgRqfPp61P8bnrZjyAL08NTIrRiewfY+51THMTRhZD
	j6YjIRK78b/esfvk+lFhX/yKerWGfL0ndIfbDlo+WgvT7Bp3im6Y4NtnzLKfiiBD
	8DEqC8tT0KP2ssiQDtBExHgcvz2xDUxeq4zAz9rVATdz/9xM00LlncDeO0Mprs0G
	4Iav4/jmUP1GK2hix4zM/pIM5DviAm0LcRWTHyFxupweO09HgKWYD0zCb9i4+oMZ
	YgLKnlpNsSPCcuQ9eyUBZQ/YoJnvmUI1SZQ==
X-ME-Sender: <xms:5-WAaNivW1S5F2paMO_RZp6pdbfwzkZfnTaSNPMqr3ugvd5pUqIZUw>
    <xme:5-WAaK9s7J8mDqNJEV5I1teqKs3UJ0p9M7_OHcAookoImPbOHFFy0E7VPu_zlKyK6
    kAwJcSZQhFbavylPA>
X-ME-Received: <xmr:5-WAaPBrOxKv7vWu8KZxpb1bmj7lgAdfUlTRHQZ20K6JD22b_91Gv4JeKSWmitsidbLldIIs6uTKniFu5AuFKNJwiUNfL8o8WCeyVMoWk5q1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:5-WAaPJHG6N3NyA-LaTKSS8SbIVz6PMghgbXkUxsJAbxlqOql2BEqw>
    <xmx:5-WAaKkFK9ZT2db2Vj3kRAM1Qppr-WqgW4BJ5sM63fPU1ZY41vdx9w>
    <xmx:5-WAaFFHsdFrRHTsmH5RtcvzEtgIdBCI7S2sVo5E-5TbpuHoPpmxuw>
    <xmx:5-WAaCGnBHRXNwanAHdvKT1nn_-OvnZFlRn_1DGUtZoBzhmN2f8_Mg>
    <xmx:5-WAaE94cnppmkCAk6hxQ9xqJsoB9sG_is6B4qhV6bWo5t7SQAoB0bOE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 09:38:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42f38956 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 13:38:44 +0000 (UTC)
Date: Wed, 23 Jul 2025 15:38:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 21/21] config: fix sign comparison warnings
Message-ID: <aIDl0tiAmBrQU8Ql@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
 <20250717-pks-config-wo-the-repository-v1-21-d888e4a17de1@pks.im>
 <2b914b60-3417-4a49-b545-3109c9a05257@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b914b60-3417-4a49-b545-3109c9a05257@gmail.com>

On Wed, Jul 23, 2025 at 10:38:16AM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 17/07/2025 11:49, Patrick Steinhardt wrote:
> > There are a couple of -Wsign-compare warnings in "config.c":
> > 
> >    - `prepare_include_condition_pattern()` is declared to return a signed
> >      int, but it either returns 0 or the index of the last dir separator
> >      in a path.
> 
> That is not correct, the function contains the lines
> 
>               if (!kvi || !kvi->path)
>                         return error(_("relative config include "
>                                        "conditionals must come from
> files"));
> 
> so a negative return value is possible.

Oh dear, I totally missed this one. Good catch, will fix in the next
version of this series. Thanks!

Patrick
