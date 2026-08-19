Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A72445AD5
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133687; cv=none; b=TznT4lOZJP1r6TesGkMsqD07r9ekW/sbe6AMs0fiJiUKpOHjgXfpqY+gkAT6lmh0bNVa2nCiFb9dm/8aOZ8fLpHMergcjPFkTW0W271ul8DHmZOhH1s2lOhbvbMTUgFMGajcoWeJqjTELWmBjdjLe5Sxe/9hxj8qOYkJh8PIvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133687; c=relaxed/simple;
	bh=6WSXHTXfHse5mSslM1Bun8TLXGf2Y2oFv6nMyhYwjME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3wiE9pFWj3FEG62+GcAMOmNtADp4tcBExcqQPF+V4b1jaocZx6LFTt81oA+u3r3/sOTyBGVn4aTK0IqE9utZcVe4DV3eDid6cTjxHorjiFNnRRtNleIxt85pT3yeENbQbRocxwqIrlgE8t1H5aqZTmJGAY+bSPN8bolrQCKEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCDSU5fx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CaDHKZ02; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCDSU5fx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CaDHKZ02"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AE8161D00171;
	Wed, 19 Aug 2026 06:01:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Aug 2026 06:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787133684; x=1787220084; bh=yDk6+DFwvd
	FtTfvZWHMmc9WU6l196tzsv6cTGKQ0Z8c=; b=kCDSU5fxGBsQKjhLnSKtj0MU8M
	mNg/KCG5O6rP4W5mP6J6UrP9eJlVNHbg24HmEBPC4LGAwDqN8RdmktBIW29U0bbv
	haFMg+2ky/BYMjkdLTVylc+CNwb0h5JEXt9Lqb6hdaOBAxbe00clXr6GZKb25wQz
	mF0GC60XbsYZG+z4cjdUCge8arY3ALlipTP33VR9GCJ2pJHXA1rwvcq3Duz8iCUY
	jnpeUE5tIS+82qPsddhu7vlpYyEPaAwBfyjGprikDJbye1wvuPpILOprY7ZxMN51
	EovbebVQvySjEBVfJjTXy/sMrEAgeiVjc0Qr9NgKb+IWdaOi9qP5KObbg2eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787133684; x=1787220084; bh=yDk6+DFwvdFtTfvZWHMmc9WU6l196tzsv6c
	TGKQ0Z8c=; b=CaDHKZ02QIJI/Ctwziw8M1YrECNVDB7xQjx37KjO1Js+Jrby5SK
	CnvpVnG77Ql4qFLxm5p3W5h0tlIOGV36AWLjyKQ6o/qxjcVRwC/qC0hxZ9V3LRes
	RPvmhuR6o6fVN235FNDyjxyKUq0NqO2uhpIgkmqywWbvABJLPUDuvsWUgjR0syAc
	Ej6qQ8NiM2NRwZQ1gql5uqzLpt/dSxhZgw3MnfQGrVDLf9zMWECw23+cS7b7++Z0
	c5sEi4QnNwhXnWMSm28XAyQdrga88RSDcJcXaZYYfjtsivrvo0GBbVjpERW508BS
	DaZnTb5Cyh7gK5B3lhbIUvEPW2yTgihfU8g==
X-ME-Sender: <xms:9H6FauJl4ECT4O_kEvQidY7mdRuVzan7DY4FFNJ0xiB8PUSeuZ24QQ>
    <xme:9H6FasIMAPyRCGOOsc-vAM2WkDUFalOD7psvmBCnME9CiqIq7nBg0-lE5nL3qn5Tz
    F_yWgdNXg13ArteBaw56gc8uCqgn8i77r7MS8CXO61TBGY_d5XQJw>
X-ME-Received: <xmr:9H6FasWwnIpQZ0yYm9U14_rT7UbMUa8Mpo-Xg2oDNOcENJ8_sKwwBA8qcowSsBvLLnj_r8atT3PEFX3HPfgcQbuiAY8icrAnAoZh6YSb>
X-ME-Proxy-Cause: dmFkZTEcxJxqjgnIJCOyLYkUaCbpc/O5ez8LaS1o30Qh5o4JHFJUN+/XKwdNadb6xFH2Pd
    ma7WnBaw+91Eh72CiQkykj1LoSg2N9lOD2FdA8fSXK+d1NZpXPhrSulO08mK2irqGeir5Z
    R0m/XzoLFgXo4cnXuIV5foeyTHuulNwnkU4JZ6haUqu/rnDlMwtkIWCTKrkcmo/1+TZTn+
    ZBzRoZlnq8mMyrSyvj4l6tkRSpbfhRYtSmU6Q3chmHFKHMXIZCdauaOosRSVVy9zhzEey1
    gjw8ZU2w3OW5jYW9bXr+EqNddz9BMb/07NqOBw7bwZEgRlzIqxiX6GahkJnDni7s1T5Cbu
    fQaXntmv1vGOFg5hB/cN4LqG2uxqYJlwUOAY5k1zaQs1FA0Eb5hUM4D1OEdC2hJJZd1d8g
    7WRyqdiAn9uLoWKM5bHZtYfo/EsLiyzrd6bH9JDvfi7GjWLOMsZO+Hu74QRbeNma0cRo1T
    F3ZwxXIT+sRLb9LjYMd8jrynwoxjZfyPL+bfTUTZQ8CFg6j2mPMWo0ba8cl2eYsIbFSD/E
    GHeAIDFwSkoEcKJhjrHD1X0nnSGOfITUEaxWQSFHx1PhaK9qt5/1FI/G4nrERsEt+vbzmN
    03/4xGBHG+DiMkZJV7Oij343Qm2nW+aqnua9mK6OJ+K2Q9p5et6RZbG8xUOg
X-ME-Proxy: <xmx:9H6FauiK_r4-aRzpzoDAFIdSgx3S3R1Oyfh8QAdr5tDcSJaN8qN_8g>
    <xmx:9H6Fan8S1CoFsVyeOIiyxkkOPQBUYu9Sa6Yd3zb4_6aUQROKOCy4ng>
    <xmx:9H6FaoDllZE_moGIa69rsttK-_76QmHd9kI0S1FQZllLKHQLEsDInA>
    <xmx:9H6FakJqmBZSmvhWUkEi7FPFqTlkRP5F4npJvtCjRbpwSBVf1ax_Gw>
    <xmx:9H6FahgNmIVDJxQLcRujmIo_fGYK6F6vpAYR0Anllv9JDf9wDF3YgXc6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:01:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 219bc523 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 10:01:21 +0000 (UTC)
Date: Wed, 19 Aug 2026 12:01:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] odb/source-inmemory: signal missing objects via
 positive return
Message-ID: <aoV-6ClUIPYh_-OJ@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
 <20260818-pks-odb-generic-corrupt-objects-v1-2-ec234567510f@pks.im>
 <xmqqcxvfz4lu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxvfz4lu.fsf@gitster.g>

On Tue, Aug 18, 2026 at 11:05:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The in-memory source returns a negative value from its
> > `read_object_info()` callback when the object in question does not
> > exist. Adapt the callback to return a positive value for missing objects
> > according to the new calling convention.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-inmemory.c         | 2 +-
> >  t/unit-tests/u-odb-inmemory.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> > index 3e71611b8e..57183daf4d 100644
> > --- a/odb/source-inmemory.c
> > +++ b/odb/source-inmemory.c
> > @@ -66,7 +66,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
> >  
> >  	object = find_cached_object(inmemory, oid);
> >  	if (!object)
> > -		return -1;
> > +		return 1;
> 
> Let's not define "any positive value means this single thing: it
> does not exist" and then return a mysterious and unspecified hard
> coded constant like this.  Instead perhaps something along this
> line?
> 
>     enum odb_roi_status {
> 	ODB_ROI_SUCCESS = 0,
> 	ODB_ROI_MISSING = 1,
> 	ODB_ROI_IO_ERROR = -1,
> 	...
>     };
> 
> As I already said, I personally prefer to define MISSING also as
> a negative value.

Fair enough, will adapt.

Patrick
