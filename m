Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458B155A4D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541806; cv=none; b=R8T2+g9/9p81brY0tO4RSSOd15G1b+TrnXPGclpM7OL1sl1r2wQh+Oq9AZsIc4Rq8JFFGLGK1FCdKo9QIyUR6PFfSYQf/qBtfjXV4mPTBZr6UEeO7CigTrHWPgY08BKwW30y8ynoNEfwdg5sW36CxTNzElf1VO7RmXviEHb8vVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541806; c=relaxed/simple;
	bh=pXHzDQLK0kqv/4586q42EkMDO5eItkUmHKYIA4yrbgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBlS2DfyTwnXKbeeYNNWApTQ+AwDa39rcEWAnAHcb1yvhmF0quhgEML+Dw1xKQaw1YDcGKwlxKCynTn0rNSA3A5XyEpePQLuNZmxKCp43Xtu2S3NULuhN5/TnomqOYbU7TCvgq/JL1WnDiTr9vBOa8hYRhvniQRjVUV+NJyUIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dxs4pw58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LTh3P3cp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dxs4pw58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LTh3P3cp"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 74F63EC00B1;
	Thu,  7 Aug 2025 00:43:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 07 Aug 2025 00:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754541803;
	 x=1754628203; bh=eW/z1uaWFHwo3OFCAFhB6pWlWRQPuuw636svznxv8zk=; b=
	Dxs4pw5801AWf+Yxinn5y8k1S0CmeYnJajkA9yWLoDlJ+nS1vY5UsvIpUtVpj5Hc
	g5P6v37gApx4sAd9r7qYS/aTodYlXHvS2vUpAGaUtI6hUbc8DJLSvu23B9qVmBpb
	t5LJpBep7c/lPBr0tbiPVVfdRPJaUqafo8p1yzJqKdkrufgVgAvYjxEOmnxAGYlw
	nmk0LH9PnADgVhX0sVAmTn47MGA1lnn1z9MzszjW6g6HhkRdzTnpKa1NwHodDl1t
	JAERJ1blHCyP1G6Xj7TzvqVJLQmP2+79m95xSM2o1ZWLsFuRlPsIWSsLgm7C2TVC
	xZjgBE6OlSEV9c96xoechA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754541803; x=
	1754628203; bh=eW/z1uaWFHwo3OFCAFhB6pWlWRQPuuw636svznxv8zk=; b=L
	Th3P3cpTYxvSSFsb06QoNEpQER1aXtDfnaWj5TFhWTRFa0u+xJkA9JYdBDNg/JVO
	fxM/wzUObfdtI/K0MXaxKRrd8n8o36eTk8ezvH+Zjqb+d3lXkB6pyTuc7izlcXMu
	z7eNpcXRO/bXGmTFJTN1plq8NRQmJQ1tcdAQc/syUShAKJtOLgCEXk7C8b0RIgAx
	/L60Xe1BfvZwLegomL1lyWmwrnEqy0p/yFkj0ZsX6R46Ejt8cb3M4TK5V1yveYpJ
	HQ5Nh6YyNriMaFt4mXCq5jKM+3V1fR4vTfXVvJx4IFNTkKYn2oldxqBpRK1IfE9O
	Z6ZPWjInQM2h+8To2QDlg==
X-ME-Sender: <xms:6y6UaHml3L6hQefmVsk3tvsEndTzkfWK1EXlhlb-I-trqSIjoYhFnQ>
    <xme:6y6UaOEypy5w4DS7McEGyiFdAPLMHxYPabPPVmnOMxYIwWZUOa9ENDSsHBuYjgNEf
    4qtOCrbKTOUHq0UcA>
X-ME-Received: <xmr:6y6UaHFTHQPgpFjpct4IZnYEhxFyjIFwQNuY4OGUuesC91OwO737YJewIfnGWmP9O_jca_pznI714wmJq3RahU0GZStWLUNoCr32cemlJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddttddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6y6UaLOIAQEuPf_MWBX-Y0nj5GrQIOIYS7xq36vAVgKS4EiXxVEoUw>
    <xmx:6y6UaGGHDRiCFXrmdJZn1igyYqw4LEBJcTMUMKx3Upl7IELdfZknDw>
    <xmx:6y6UaCPUor53mUYdldxUBykqSc6ZIVL5BZ6tw61VDIDUMEB7-19fdQ>
    <xmx:6y6UaH-FXsOVHcPnFXXiiZkZtkjPzWmsMBb7Q6Xq2nYi9UtXrW42_A>
    <xmx:6y6UaKuqwkPstKtqhjhQ3bJ3c5aboOMSBn1N9VPo71_AaZz5hFdNCt-K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 00:43:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 613f3b54 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 04:43:21 +0000 (UTC)
Date: Thu, 7 Aug 2025 06:43:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
Message-ID: <aJQu5VJ_w1Vq_VYW@pks.im>
References: <xmqqectr57ax.fsf@gitster.g>
 <aJO/VhvaH7FgluZA@szeder.dev>
 <xmqqfre4tahh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfre4tahh.fsf@gitster.g>

On Wed, Aug 06, 2025 at 02:18:34PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Before merging please make sure that the topic can be built on its
> > own.  Currently all of its commits, including the merge commit the
> > topic is based on, fail to build because:
> >
> >   $ git log --oneline -1
> >   fc33fe7eff (HEAD) Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
> >   $ make
> >       CC builtin/reflog.o
> >   builtin/reflog.c:7:10: fatal error: object-store.h: No such file or directory
> >       7 | #include "object-store.h"
> >         |          ^~~~~~~~~~~~~~~~
> >   compilation terminated.
> >   make: *** [Makefile:2817: builtin/reflog.o] Error 1
> 
> The joy of having too many moving parts X-<.
> 
> Thanks for catching.

I guess what I learned is that I'll refrain from building on top of a
topic that hasn't hit "next" yet from now on. I knew it was a going to
become a bit painful, but I guess it's even more so than I expected.

The merge commit does need to rename the include from "object-store.h"
to "odb.h", which is because the parent topic was built on top of
"maint" where the rename hasn't yet happened.

Thanks!

Patrick
