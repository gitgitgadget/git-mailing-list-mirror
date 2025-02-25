Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D220C01B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472029; cv=none; b=L2wR4QkOQt+WgAu10UohQDQa0SJ4W4flS36srJ4+G7lYsmddeUVhqHrBeOCvq4dYjfxyGwU3wIfGzrb3cO+hhc9smnbCPh36h4nTjr+7zep6OVqwKGm01cWLVfofla27/QOHwu4hrPVqT7Jvb3ynZvbLzFARJfbuWYHOa+pj8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472029; c=relaxed/simple;
	bh=n/S/UGAo07yI78iSIID+NJErouSholus9ldKzPBuObY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqzyWCAlX5zM/lzOdIiyFQg1dzVGRU9rRQD475qgeql129fwrYZX+mMYjBaYiJ3Sv3t6ASU7K2IlY+4ZnM6fxV1tYVoHvfpygKXbFNLBQ35oWy0w7pVGgvg7fBlamR8DALoZ/TCl9+Q50MYFoSic4myLGijU7jZ6+kIGKhWf0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kR+M6i4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3cIGADm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kR+M6i4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3cIGADm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AE6CC1140178;
	Tue, 25 Feb 2025 03:27:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 25 Feb 2025 03:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740472026; x=1740558426; bh=g0sNjpYcB6
	t1pA1I+iORdEDTK+4sx+Lb+7SSvlBm1d0=; b=kR+M6i4pDN4/cU9uy6OH5abQOK
	Y0yH/mFoJb0KD+zb2flquHgxdS0dQ/f4vizSrcYrgVwlX0F1X0mQvH++Hn7CXmXu
	1kGgPJN4T7FR7m9gQ96h9FlzRjlbszeXd+ypJRX4U41zod80euZAMHFGfU8U1yDy
	qiQXkKiPmirpgJH5UZtpkuKvz+qZ8xlVWXMwuYhM86/gMnGZUmkHjhjnyTi9IbWh
	rhzNjvK8mZhbaV8ZSs5CZWIOLVf862a+xYZgi1UXrkXVOX7zv+JaRwcIAeHBuRPx
	2kzmRkD3xa7r2e72DY7wKPHeZ0MdGl2rpKDiQiHqU21uvTD3I4lQxJdTaevw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740472026; x=1740558426; bh=g0sNjpYcB6t1pA1I+iORdEDTK+4sx+Lb+7S
	SvlBm1d0=; b=A3cIGADmnpCOR6flOOyE+AwCg2lC6hc5DHHQUVQaKSrNcstt8uV
	ADo8/wGKmdiril8c529BsA+ufj5TQxZVYxvFZFbRtJggh2HRBW1diwNTmtJYuDvP
	Wnbh2paARowuVZfYwcRJoagUXlzNpBnwAqXhBF3zHu9k5TCq+ZdSwkT16H5D2h86
	xjoYsF565tHZThvUQ6c0/4X/+A9rJMR44FEgLDJ6pkm6YPTtgRdYM95AiIzPnRS/
	eEUmhSxmiN55k9AQuoRx56jYKVxxKUCBhweIjqdwUjBVVbDPkspo2yxmhTVi9xoN
	BRg4xlIBnKREKArvEb+IxRfMWtQ2e3aRq5g==
X-ME-Sender: <xms:2n69Z-QM1n6RmQP3ItVRzNZMsnruWxSVgTaGPPxKUAjkmuBj3JfECw>
    <xme:2n69Zzxx3jJ03WgXmyY6Xg5rNzGdkiauHQGpPd8FkUIA17xVHEjMUJfZShvzntTrj
    Ya4VgECh4tG4NyjbQ>
X-ME-Received: <xmr:2n69Z712IuWWIhcovMFjLeZOuEJ-R-kPS9--oCbbZJeM3lj2RdhpxmWU4RGyR7_nGZ0trgTn_rdpcRr5bldoOVq32Ilp1QSmXVyAqEl1IsEQxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuh
    dprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:2n69Z6DIeSfTrs7C2VPcXl7qEb8DHv1Bf7zgs2UbnP3X4LM5Bgcu6Q>
    <xmx:2n69Z3jw3ShCIhIt06qwdoDCO_Aq5NagGyKCMThFlwRbd34W4ZVktQ>
    <xmx:2n69Z2rPEQwR8pqW2G0MaL3U1Tr9DM17bYy0pzMRA976vHwEEsSe6g>
    <xmx:2n69Z6gdRLhMFCiVTyxjIjwe_jdViQkP7MpumnMmiWvFqgHnBE0CEg>
    <xmx:2n69Z9bX6F16r1ipBth1cbv8FpR2Ko4xSvEuwr-rJNIinMr9TLLwNf-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:27:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 173b94cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:27:04 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:27:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z71-1xa_o39IAo6A@pks.im>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
 <Z7NVdhM61rhjAHtW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NVdhM61rhjAHtW@ArchLinux>

On Mon, Feb 17, 2025 at 11:27:50PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 8140a31d07..09eb3886c3 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -694,7 +694,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
>  
>  		tmp = xmemdupz(snapshot->buf, eol - snapshot->buf);
>  
> -		if (!skip_prefix(tmp, "# pack-refs with:", (const char **)&p))
> +		if (!skip_prefix(tmp, "# pack-refs with: ", (const char **)&p))
>  			die_invalid_line(refs->path,
>  					 snapshot->buf,
>  					 snapshot->eof - snapshot->buf);

I know that Junio pointed out that we should check for a trailing space
after the colon. But do we really feel comfortable to tighten the check
like this now? If there was any broken writer of the format that does
not include the whitespace we'd now be unable to parse their output.

I scanned through a couple of third-party clients:

  - libgit2 is fine and always writes the space. It also expects the
    whitespace to exist.

  - JGit does not expect the header to have a trailing space, but
    expects the "peeled" capability to have a leading space, which is
    mostly equivalent because that capability is typically the first one
    we write. It always writes the space.

  - gitoxide expects the space to exist and writes it.

  - go-git doesn't even seem to care about the header? Dunno, maybe I
    was just not able to locate the relevant code.

So yes, we should be fine, and the fact that other implementations
expect the space to exist indicates that being more thorough here is a
good thing. It might be a good idea though to split out this change into
a separate commit and then provide more reasoning _why_ it is fine,
including the above info about alternate implementations.

Patrick
