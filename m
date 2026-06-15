Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FA03F20F3
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528308; cv=none; b=FwLU4MnVrEoqhAGaowM0m4MXau3b0WIGEV6bE06oHdNEyuSiBDDGWneIYKO9N8jIKty3k/grv2Wh/4UhSMNdQLVTKkcMSbg95VKIoCw5bGV7GvG1UH3kdRhCXBQ/ju+RiZe+8fUtYRPFhvQR8gFUd4buP5TxR3pmwLWOx9XdguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528308; c=relaxed/simple;
	bh=v4cznSRSdmFCxc/x/X8s3CS7Fy+nAaah/VQ9568GYs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn5Hb0ohq+X5eOq0qHUBkg3nNz4wpTVn6yb2kxCsSN95N/hebsX82Iin+W9IHkOZYEtJziEZRjKGMn1TG8o8NMY3MlYY4REgoDORdBTsjk+UI+WKVAZwP+lD2tx4o1+8gKSqsk0yQSBIK58aPzwRbmPpZp4lSF16Pn19RBTyqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KmkgtJyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MH7+VTvo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KmkgtJyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MH7+VTvo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79E96140009B;
	Mon, 15 Jun 2026 08:58:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 15 Jun 2026 08:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781528305; x=1781614705; bh=HM3UkhQyat
	AYUKCEXg2LolZiqIEfYrv7xvYqaT8E4Ro=; b=KmkgtJyZJW/raWmbU33f5ky1CZ
	rPhcFY6w4pI5j+gokS1nol2UACMQLDsEihPgdwYe3xDclGEwQ3RcEiEvPbXQbVB8
	y4C8nRZYftXvpcoxlNZCEEVy6WjQH1TIVh/vWE0CA0lGmMbABhj9pECU8e3SYO2h
	xPe5LAwPdtnMqXTGhRP73m1BDJuRjQ1fiWT0mdhKDb1u4yiaOyU2/ZTMgC7z0rig
	VGgz6aJt1DTU88hy/tWfAwhFaBvhDUBKpi2rXOrf6el1wwpnTmSlm4HguI7k6rYm
	v0Vjd6NsjplvWgoapc4Wece1LoA/CWXXLwh+mydrRzzsWsbsk9yKdlocvWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781528305; x=1781614705; bh=HM3UkhQyatAYUKCEXg2LolZiqIEfYrv7xvY
	qaT8E4Ro=; b=MH7+VTvo/Jfyhu7nJ7uzP2VKubaX2rS5HxWITZCoRi0/9Vshuzs
	3hf322FBPSg97TKRq5qBNra7XAMmN6aRmG6XkfI9r8Ce8kD2lJ5gnZ9hLM4c8GbS
	0QSi7XHLNEP+KezDOA+Tgi9yZAcGdmuEEK7HIwUrv0QzJRII9jT8JIZ1/+lQQEAc
	mPvb29UEoB7E0mWPrtiZD2j6YSXeokFph1mBoVCWSUH+VuuSm7WZB2Y6Nr3uigkQ
	C3cYEtYKxkCCsqrInCJOitZn2SSIBjuJIMhQCXS3iq4Cir8t03G1stN6aukNUSzK
	bJOtELyEY9fVLHmCC/C4ifRm72tU7II2M/w==
X-ME-Sender: <xms:8PYvanlMsea4N86CCmOUSmtpoeXK_e5ff3YIGF91d9NIrgXtHH_JNA>
    <xme:8PYvavz6Sv8vGBYqr8L8Z8pgenmUN98_djWoFLTxlTPyMcwVhQaFw1EsWfz_nrZ0T
    2WKRN2x2v_0URkUQKwZCZacPshMt35DM-rGi8JDNEYBQ-Q8uLT2>
X-ME-Received: <xmr:8PYvah51O3r-AZ9Zgcr7iNCEBADwvNnyEsZkDLTwhSWk54Z0P8QqRQmCzxvgVypJhsywi9_2g3JedbVu0IQlV9XjKko4o2wHrnvGMeYcUw>
X-ME-Proxy-Cause: dmFkZTFXCHa6aC1+76eJv8S5WHCc4n6pfBal6OzmidYCIsw9cHVnS6ghOUb+jb+q/eAejJ
    7Rs80nBbSXjddWHXPVOt/PLVFeH6xfXf/KZaZQY79jeIWLrLnQzxmU6fUjVNUzEpyjNOKa
    VTBCphTY1Nb2m3TGa/YY79ACurNDWebXwnhMw77bvtOMNihceaV0uhGrerZUZAOCFDxeru
    ClOqKGE8VHJDsiLNeasKqO+2uxwwwWTUwsvZNPUQ81TcoUSquQpWMuFcXtDpy/5mTaN8hR
    e7XwwIaCW7Xaeq2bWHJteWvc0I2gx/P/4rNIeMh69ylj6NKkzT/ydiyX7OFy+APTH0e/BZ
    ADan6W34pWt4bvs2f1Rpzw46St1punUMaYuvSJ6EkVDkacxeYGt3G8UdX2nHzFqkXv/mfc
    zYlU1DCveMO4qyr4S2WnnO/KwnbKaJ3Dcts4lHwWvr0E6B5cr6dv2pBLrgoopVlll9C18j
    pZLIeSoz8IvFnjCoT1u+4OeagndM02AznL793AGUQGu8uE9Vne0T3Uc7KekbXAaZxMzqXT
    aBVKIJIVgc+RDQiG0vzQJtOgMwkIsrlBoBDwKHz2FPqWncC+N/YrDxkoSUe6GIydaUP/RL
    Q7I5rOtK/zxNQw+IUUNZl189eo6GXCnXLCey0pEcHT/fJMQCjKEyIo0NjCmA
X-ME-Proxy: <xmx:8PYvavWH04Ovk0qrJs4jnyj830spLZwh3R4-gOGwv99N1OlZ78K7Kw>
    <xmx:8PYvapL9GcL6N4GPcMrupe3VzREZ5BhBxXKAuCyDpO0Q1RKJxDNFKQ>
    <xmx:8PYvahsKRtXAsPtvAywnYIlHjTSyOnE4A3cKlzhhb7-C6O_Dub6pfg>
    <xmx:8PYvamLIcOodQo_C3IMtzpIFcocq6L2XiIpGIhizGCEEPT7UtmRzsw>
    <xmx:8fYval1qG2epeocuWeg9OPRsUSnRnW6rRHdNfLwTuIYSzb8_P7nDO90Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:58:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a782d046 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:58:21 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:58:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 1/3] MyFirstContribution: recommend shallow threading
 of cover letters
Message-ID: <ai_26l4sYwK09kdY@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im>
 <20260608-pks-b4-v3-1-f5e497d10c56@pks.im>
 <CAOLa=ZQE-kkpSX=pP2A6SXdbp_O6AHzRmbUDOtKCsvz2Yz66Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQE-kkpSX=pP2A6SXdbp_O6AHzRmbUDOtKCsvz2Yz66Ng@mail.gmail.com>

On Wed, Jun 10, 2026 at 07:08:33AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "MyFirstContribution" document recommends the use of deep threading
> > of cover letters: every cover letter of subsequent iterations shall be
> > linked to the cover letter of the preceding version. The result of this
> > is that eventually, threads with many versions are getting nested so
> > deep that it becomes hard to follow.
> >
> > Adapt the recommendation to instead propose shallow threading of cover
> > letters: instead of linking the cover letter to the previous cover
> > letter, the user is supposed to always link it to the first cover
> > letter. This still makes it easy to follow the iterations, but has the
> > benefit of nesting to a much shallower level.
> 
> Should we also modify 'Documentation/SubmittingPatches'? Which states:
> 
>   All subsequent versions of a patch series and other related patches
>   should be grouped into their own e-mail thread to help readers find
>   all parts of the series.  To that end, send them as replies to either
>   an additional "cover letter" message (see below), the first patch, or
>   the respective preceding patch. Here is a
>   link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
>   how to submit updated versions of a patch series.
> 
> Personally, I find it a bit awkward when new versions are sent as a new
> separate thread, especially when the subject is changed over versions.

I don't necessarily see this as contradicting advice, I rather read it
as "patches of vN+1 should have their own subthread". But it certainly
is confusingly written, and I'm not even sure myself whether I'm reading
it correctly or not.

I kind of feel like this is a bit outside the scope of this series. Also
because I'm not a 100% sure how to reword this to make it read nicer :)
But I'm very happy to accept suggestions here.

Patrick
