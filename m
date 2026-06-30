Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0013423392B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828896; cv=none; b=rMqwQ2oVmEIG7fD9spaI10DJKTGpIKk3lcWnB5bCTVJTMgZVwRvcLc4l2b9U2fjMkDw+AT1zRCThz0KTRa4Nl17WyHYq96w7TWVOcaZOl+pfGYEdHtEtvGo+DysrgG1VfxIKUhWOZSlkUXweiQASAA7Mysl44oye9F741zWF9j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828896; c=relaxed/simple;
	bh=dGFLQ+QPBnaCgLq7iyr3OMOpkgJtRni3AOigJhUCQl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DynsJJTllW1EpW3rZli2PMjsiBO7meLd1eW+nSD3RQ2PRj3/FyMcctcT5mR+8fC8l4iF4bsRTOGGbBhKthsOkxKjqhXmokvJIwWbbM8dUGtTittYgzm4ctu2jwdA/1jPKEqdtd4E/sSdRqw4z305dw0QIBJlMBf/LUgvw8EF8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEdsIvgL; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEdsIvgL"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d7aa0ac14so3055749eaf.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828894; x=1783433694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOyDBQHmQX8/wS4mafutdNgdHtYh2aDpzMqLD60Wc3k=;
        b=kEdsIvgLEUdLN7bIKdoKqaNHCCJdTc72fjIybZYUCurNJJuUcrTgTyrIso00BpM166
         QYRZylObxUUoHcRqCPvasf473BHz64yEplJ1zdGF/bj7IjWSzYoqsRA0Tbom329yPN39
         kkONmLw4sOkcDGDPMmZ9OkHZ/GYEqFhr8ScBLsJfMXbcAm356GlAKy09JiB5UasNwODE
         ObjpefDIUCW1PJdnH9/dozlBWxrGJJhPUM3revKi3xz3FocjXEyAxvT+zC70Hs2jVjKT
         1l3akK/QqbYu2H7ur/mQPYLwVVrKML9GzC+YdfmDzqEqI8WTMNWOHf6F9Y0FSWNcrBoh
         lBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828894; x=1783433694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOyDBQHmQX8/wS4mafutdNgdHtYh2aDpzMqLD60Wc3k=;
        b=Ve+qvOEPAwHaElJ0uD+RBKenDjRr6AUBtEs1SveQlr35HyY2CNHQ1w26dD3ACzpP+o
         jE1+T62PtGNDI3ouG8HUMovi+BjmJuGC1JUQoEOm0yrEO4B1zr0MVMe2JuP2vwWGUZPh
         3an2xUn2Dk1RD1N0FytjM2rXOQcGBf1Eak+IOyVwpcH61jAiKZ9lSnhvld3AM65b8DUg
         VdvXUf9qGoaHTGZ615TxSJ9FpVEPWW09PpDfeqbx8fZ/5+uC7+e/hcDVDQYJ1WknQKvN
         pifI5nGTE8UHpjLDUs+hRH4kRqmB0Y/kGvS8KIFY2Qs9/u5HIiVnYju9IH/46KN7qUf/
         Fe6w==
X-Gm-Message-State: AOJu0Yx8seqc+twcRYKKnCxH7GauHfxVZ9jEs9it+svRgDvvGrrz34Rf
	tIBovQRtfPuqEBfXlfzu4mLOqUQeZNc1U+EaQTLJo8+zYloh7IjvG4OUXgOmsQ==
X-Gm-Gg: AfdE7ckUWtUYya+rV86GgQ6Q1HzS796J0kN6jvQ0PwfAuhyZ65CuXPDV5E3xuJiNePc
	ddy/+4oRsqH6eEBDVev1nr+pAtBxAknJJ8vPHcSIuKJ/PbwOh2XKT0x+bo1EaiOYLH+qMB1MFqI
	8wAP0uNfUmw9dnbNsrJTBUYxvearA6kf3g30kMDedZINObEE1H7k6Ruv0uOvxEGR67RUJiH7OJg
	FAN5RD+clQRAtzhpySVatDg+agKHQb8tZ9uOY94lTwwiv2tApv64pt+axufbQYodTiUMVhMqRKW
	nW1uAEp09h8iY7h5/Jsx1DcnsFx2VObErHU/iYghemHM/xWtP6g1lRWaDZeAKdS0Dd5XnreND5s
	vMLHRC5zt40nsltf5g3M6QAYKgw/EyHzqcM/7gBuUaTouU2nJvCw54zYD4YK3DBwzpGkXLkBEJh
	EWItwLYg==
X-Received: by 2002:a05:6820:c449:20b0:6a0:de78:6154 with SMTP id 006d021491bc7-6a18904c07cmr2016420eaf.14.1782828893728;
        Tue, 30 Jun 2026 07:14:53 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a18946385fsm2137850eaf.12.2026.06.30.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:14:53 -0700 (PDT)
Date: Tue, 30 Jun 2026 09:14:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akPOZMCq8G_DGl0h@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <aju-7Z-ecJG_ORow@pks.im>
 <akK1roQJknYstX0u@denethor>
 <akLBFaTfBEq8vHUr@denethor>
 <akOCPk55yi3lerL-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akOCPk55yi3lerL-@pks.im>

On 26/06/30 10:45AM, Patrick Steinhardt wrote:
> On Mon, Jun 29, 2026 at 02:04:08PM -0500, Justin Tobler wrote:
> > On 26/06/29 01:58PM, Justin Tobler wrote:
> > > On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> > > > On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> > > > > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> > > > >  	 * added at the time they call odb_transaction_files_begin.
> > > > >  	 */
> > > > >  	if (!transaction || transaction->objdir)
> > > > > -		return;
> > > > > +		return 0;
> > > > >  
> > > > >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > > > > -	if (transaction->objdir)
> > > > > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > > > > +	if (!transaction->objdir)
> > > > > +		return -1;
> > > > 
> > > > Huh. So previously we just didn't handle this error at all and just
> > > > continued to tag along? Did that result in anything sensible or was this
> > > > just YOLOing it?
> > > 
> > > Good question. Previously if there was an error, we wouldn't end up
> > > creating any tmpdir and would instead continue to use the primary ODB to
> > > write objects in. This change would make it a hard error if we fail to
> > > create the temp dir. This matches the behavior that git-receive-pack(1)
> > > expects, but I didn't consider that the existing callers could
> > > transparently handle there being no temp dir.
> > > 
> > > I suspect we may want existing ODB transaction users to continue being
> > > resilient in the same manner. In the next version, I'll maintain the
> > > same behavior.
> > 
> > I think I got a bit ahead of myself. The existing callers of
> > odb_transaction_files_prepare() still continue to ignore this error. So
> > the behavior already does remain the same here.
> 
> Oh, well, okay. I think this behaviour is plain bad -- if the caller
> wants to have a transaction, then we should bail in case we cannot
> create one. But this doesn't need to be fixed in this patch series.

Ya, I tend to agree. The problem here is that
odb_transaction_files_prepare() is being invoked lazily during the
object write. This would be another argument against lazily creating the
temporary directory though. In a followup series I'll explore removing
this and investigate if it has any meaninful performance implications.

-Justin
