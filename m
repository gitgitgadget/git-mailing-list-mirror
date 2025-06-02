Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06E1474DA
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748859890; cv=none; b=lXAlOznSkX8aahsYhqtsiKIFDgs3cwtfGJJ4xCdmtOBA22RyDm7DbZaMLyCm7Ie7owAQe3KHmvjH5nQb8ccBpk0EMMJrJO+lCz/aI0wXyjGlkWqSobS1M+HmM+A6CL0WKaWsFQdy4tm77Q76chzA1HUI7nl13Z3PHlpA15CpHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748859890; c=relaxed/simple;
	bh=V4eXyDYsTREeQIW/IzxYEnQdi0GVNrVT0TfFMbseldQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqbbnt/UXpDcy+WQ2bGdbVvVOcX3Qiuv01oa3OB5pj6aMcyWzk89IZ8MgjGYh7NEVTlQ++D2hMVei9HdE4HKtOmzHf1AyZgZJuTWKxNqe7ydBSTFH81whE2ev8A+YqxR64u/6yv1Ug9TGbJWS8UbQwLtVdv5xmKjWUu3QJgHd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FLWFo3dO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkQoogT3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FLWFo3dO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkQoogT3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73A3A254011D;
	Mon,  2 Jun 2025 06:24:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 02 Jun 2025 06:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748859886; x=1748946286; bh=ijimltzaHC
	a0XyCo1T6SDsLRbSvhLInaWc4gnxjhwK8=; b=FLWFo3dO24O9srZ8AaeJwEEUzO
	J4+oBJShRhJukA7ieM4VvviYsSxkJ/PX9KSijGG7b7NI1T0/w9WXzx4vukSLJPw5
	jDrrtj/wwfPTy/svTXJ9tc462OCrcFnQpdhpahNtNZtN/Q9AEPi5jYTr1olGKxH2
	N93QHEgq7thFesjpc9cGD3plDcp6vpFkwGPtr/2hDNyeuREwgdY41u+la4N6X3X7
	hHKaV9zRcNiUShmXb3u6jNJjSwEGFeqBijSk/GjlYoXKVulEj0Z7o6y/SBQsMdBG
	PCRiyUFdIxOHwTpsuiJakEB4YjFsuEKFhvcroipqPclkpXZCECqtfcKURz5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748859886; x=1748946286; bh=ijimltzaHCa0XyCo1T6SDsLRbSvhLInaWc4
	gnxjhwK8=; b=BkQoogT3YzDcUuPIB84hV5iQ6rE2jwN9kRP58vaVy7pV3uENilo
	phTIxDfapgGLf8EMY1uqH3QFbdlhyhWvT+HlioGoY98nIz3kgPDHe+Pwa/lIS8ic
	4VRFxZE1IwlSuWQWjHMbDPDFo73LHM9bwUlyGuzXl5R4vQCk/3qbvqAycouce454
	zd74QBQAlu+u7qYx+8JthCRPt2v+KDzO7q1IJpiZsl/tmqiXyZ9OX/VV7CIDcp+X
	6HoLJqtw54I4eUVJlAp4FJ6Ii4TCUXzg3le6Z6RAKXQmMZ9/rAv3F+fFWy5XNOy3
	7FFF8NAf5XDMrkZmar9pRxSmNKidfILNB3Q==
X-ME-Sender: <xms:7Xs9aHdQtYaoy_LTeoR0kG5DX24aDLEfhyL6hI6UB1_nguxFpgz-xA>
    <xme:7Xs9aNNIKOmgx7EVncX0fffMdbY1GsPHwR4iQA6-psSMunAmIq9gAgZgbe8-qJERa
    tssQ8Ba3MxeLA0o6Q>
X-ME-Received: <xmr:7Xs9aAjseIvJbO-_FuqABxPb8SoNb4bXJEOT1-5sRCtS0ROsEkndck7_JSMJ925Dd-s2CO4NPJ4QzvSWnfI6I3wT--Ar4eAMEI7a2soCS2WL8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7Xs9aI8bz9Ki1iY-MP0Onu2ANpHZ8NGVWTi80oguvXSBk52_jv_S2g>
    <xmx:7Xs9aDv6CHtDxiGCBJcaHkKgT8OjTGpSwLY1kxPQhBSNYOYb5ERlyg>
    <xmx:7Xs9aHEp7syER0ouOBjs5NTIcDK7mWoMzIGEu7NpZ6og2reZi5tELw>
    <xmx:7Xs9aKO8bN_6H1_Q1ICKIsGfTTZKENEsXrIy_FP6PmW44RiFdLFwHg>
    <xmx:7ns9aCGU83mw5RjC5WcpaSSasOzeNrTWPoFkpgkdv135jApMb4mA9W9s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:24:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a1ff737 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:24:42 +0000 (UTC)
Date: Mon, 2 Jun 2025 12:24:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD176UYWKEbmhiaw@pks.im>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux>
 <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>

On Mon, Jun 02, 2025 at 10:53:50AM +0100, Phillip Wood wrote:
> Hi Shejialuo
> 
> On 31/05/2025 04:39, shejialuo wrote:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 4d1f65a57a..bf6f89b1d1 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
> >   	iter = dir_iterator_begin(sb.buf, 0);
> >   	if (!iter) {
> > +		if (errno == ENOENT && !is_main_worktree(wt))
> > +			goto out;
> > +
> >   		ret = error_errno(_("cannot open directory %s"), sb.buf);
> >   		goto out;
> >   	}
> 
> I think it would be clearer to write this as
> 
> 	if (is_main_worktree(wt) || errno != ENOENT)
> 		ret = error_errno(_("cannot open directory %s"), sb.buf);
> 	goto out;
> 
> so that the condition that triggers the error message is explicit rather
> than having to mentally invert the condition to figure out when we return an
> error

The downside though is that this mandates that `is_main_worktree()` must
never set `errno` itself. So while it may be clearer, the original
version feels safer to me.

Patrick
