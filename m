Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24155230BC1
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389167; cv=none; b=plnmSXgaA6eLhvCG8dne6kUcP/8uShsgwELIcBMpN+qDUOZ1LfEmtCXzPSe0V7+rgTRh95+oW+leGzEjZw81iMphhxVF58TzCjfBEy44EGEClbg9E9EKqtJB08D+Dt0+GmASusFFWR7qa0YiWMxO7r0oxOxOXeucPpoxmw9F4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389167; c=relaxed/simple;
	bh=mQFB5EJmhn4nzKjUoiQOYHzMkBJKAV0VxXu9A3dIa9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obJdBI1nHkx41HS0SJOXpqLOZ2Mtewz2hnUqbZSnAN3mTIuJ0LkfHmvGVrR/Wz0M+Iry5eescE+sN2b61TJ/mKy+G/J6ZOS/CW88kiNgIBaX9ubgcNVEp+Xu5y4nUrV95hWVWVYxjDjMMyYRer1/uWxQIkZ+YLBiTJDwzeMA3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yG5fmSIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMLCHOKm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yG5fmSIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMLCHOKm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A6E5114016B;
	Fri, 16 May 2025 05:52:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 16 May 2025 05:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389165; x=1747475565; bh=n6KZTHRoxw
	HHH1BuTSul1GY1vxqa/mtmhkppb7JljRc=; b=yG5fmSIvNWWbHkVKEJyz3LFWHA
	ZBm5Z8FpjJ19zhbt+eP6w40t9Vs1ZGB/tSVTlMheUCXMppHUzJqUQer0NfUOlsFm
	kRcXjm2HgCGMdXuZx7sDSai8gjP96FW2x5cQYaPNNoR6jaxX6B30erJCL9aP+Z7f
	rGVOFtfxnSIaKURqY0z9mGEPfY8LOCAkFfLrnfDJHIibaqks1lkJ4xi3vbt+Ns6H
	9di8KjBPnEvZarVAz+jzCRkuODWqiFk58ZIT3rj2MCLhW/K8TWOB52MQasYuDrf6
	J/cg3ce8cq2d/L2QuQ7eJ1v7X3BCA0hc82/Pr3SYdNQCbEOlZ82XGIiGHsPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389165; x=1747475565; bh=n6KZTHRoxwHHH1BuTSul1GY1vxqa/mtmhkp
	pb7JljRc=; b=SMLCHOKm8AUNTuXvKZnjehAUjFOvh+OzhIeKHEaMH7EISVycpbQ
	4/FJEJ9gC4d55jluDK2w1lEBTcOJijQ4oWf57D/pyFJhdowPvJX/RYYA3yEcAm8j
	pAskfqgj+3IrAzbvn6e4eaA/uwUWdDNDMwxdSPDIBt6lS2XD2DB1uAhPL5O3zWRV
	SKeF0QZJTaoxXghimAF4T2R9/HvSl254b9TmZw71esIBfTqKkVwknEQ3rYEvWara
	2fq9jTA0f6IpC/ySDS4GKTgOgsRNV9OJDBKv14LSass1bhifI1tcuSzXpDKVGECB
	iHBXdmXAb+MAkAE7fAj3BtNZRCAZWi+m2/A==
X-ME-Sender: <xms:7AonaE7N8TaOt4LtbCIYdC835Ls7rWhO3Zu515WJNOEY6itxZileVw>
    <xme:7AonaF6aRtMgKOezbzSf_H1rgoJClQdlu_-V4O1PxweUwL0xAWt1BGM7K7lktTv9f
    3fl27FKUilvPIXysQ>
X-ME-Received: <xmr:7AonaDeGyC0La1Xk54hoFabCON_nCM6FP5HcqWA7Kel6zETTyLS3oyyyi6NAACBy2c_oK8zcE22SEx3MTLAjLNVzdF8zgFpIoSMDBTdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:7AonaJL7jViIzegcCtTXUnKyEFzXzK_krKxdpte38Z6BLrTszVmcmg>
    <xmx:7AonaIINVQc6vo4tQXiDiUceVcfi2cvnM3ceu8J9EYEIq7bJm0RBIg>
    <xmx:7AonaKwoGDqjlHieKv5JI8pTtO5q4CLQqpQYhmEllANymWj4OpwOqw>
    <xmx:7AonaMJqAYoGd8rfUMluUTItwAIfJwEDJ5hp3E8RcGG9iy2l_El7vA>
    <xmx:7QonaE9xa4JEzcDUr7p7qbcztVYWWDUSy4qAapdR_vk3TQLFBJrtd_A2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:52:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33b668c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 09:52:43 +0000 (UTC)
Date: Fri, 16 May 2025 11:52:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/13] object-file: drop support for writing objects with
 unknown types
Message-ID: <aCcK6quAx_q28ltu@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516045013.GM22242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516045013.GM22242@coredump.intra.peff.net>

On Fri, May 16, 2025 at 12:50:13AM -0400, Jeff King wrote:
> Since "hash-object --literally" no longer supports objects with unknown
> types, there are now no callers of write_object_file_literally() and its
> helpers. Let's drop them to simplify the code.
> 
> In particular, this gets rid of some ugly copy-and-paste code from
> write_object_file_literally(), which is a parallel implementation of
> write_object_file(). When the split was originally made, the two weren't
> that long, but commits like 63a6745a07 (object-file: update the loose
> object map when writing loose objects, 2023-10-01) ended up having to
> duplicate some tricky code.
> 
> This patch drops all of that duplication and should make things less
> error-prone going forward.

Just today I was looking at this code and pondered what to do about it
with pluggable object databases. I started unifying those code paths,
but all the results looked quite ugly. I am thus very happy to see that
it just goes away completely. Thank you for making my life easier!

Patrick
