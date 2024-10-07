Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159131D45FF
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312971; cv=none; b=ueMN2VxEtpahnOGJ332jIcAf07W49e3xoHPWuxg0eXV8rSTKfy/vVPMpMjysTKcvy7ANzziC1CJSbfAA5rKyet9339GAbxSstsmQrsU03fSYA+vYJjad/s8F8axSQv/VHzbPAlm4ZUnvVNpbTi/lblNXYLM77CocC/7FPBe93HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312971; c=relaxed/simple;
	bh=+kHT883DCw3ChY6q0oGr7QgoToXHKOA4yuOJZP/Bqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYFKkZi208FAE9W/T7RDu8KUgB4sCvk0CfudJT6ll+MvGcBM/d+X4mRzXh5m8tZ158zFwspOe//14V/qLYpLirHqBDwxxPkqzNsBcUWPgH8Yu5i0mjz8mvKpfCVlPSwTXSqqSkKneqWQ2OQBcyPT2g02GM0hBaYd+0xhgwJq0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eEW5vqRd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eEW5vqRd"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e026a2238d8so4008083276.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728312969; x=1728917769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kHT883DCw3ChY6q0oGr7QgoToXHKOA4yuOJZP/Bqtc=;
        b=eEW5vqRdeuVVmpFikAt7EAFYFJH2bDAKwiskyJs5uD7rRgdK9S7r7+6zKtDBiFjLTv
         6FtkAYHZTf4m0hgFLCebrwOZPjJgYzkNuW68QhmlNODM5mAGdPyMDsVAhduwVUrWNUcB
         T3seJuFzVfmOd0WtrTCDexIviYcCazE6Sad/+GBhH8HJEQzaoz6E00ZMtP0/S16l52gR
         QyvaeeSMZ9jsniuQ6GPELZQ4f55fR4LPTn0d8RyMi4c96/mmvC0JEueb1GteoASpqbm9
         bezBhnCv+9kpBOikeCaAWNPg6HvS7SZukX7XJPWFSsPK4VDuQoPMjqF6IT6V3pnTS44A
         SmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312969; x=1728917769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kHT883DCw3ChY6q0oGr7QgoToXHKOA4yuOJZP/Bqtc=;
        b=lCfcR/Rptx1AMZoMij00Wt88h6aF69y3M49WHmjTist9lTvVtKfD53VDe7lW5YFOqv
         OsTFIsbbGAa3IyZXy9Yl2IgHyqj1ylPW+T/BGDvc2vUXcFh2LPa2gEQue6sjXMUTx7ru
         SH23G6Ry+nq7KEljCF9KKbYGmFu1Eta/LM4fIT8OoZB+isB79IRGhoAwIpGRcJ86/KmX
         k4Iyj6CHJ80BymO3Xegjx2OAnnFJy5K/C6fPfCJuwK1DfacqvyJpSa8L8ZLoZeYs0+q7
         TEIR922Bj0EibJZYZTuiNw2HZ53QZh3vU/pm7tE6rbKvdLli1wvtqaFJ+NXVQjd3+0j1
         Kn+A==
X-Forwarded-Encrypted: i=1; AJvYcCUeM4db3S/Q2JK6eQjbimAhgdfU1NuKjXrTTWxhVdqyNPEDhedJvv/JlKW/4EyIaTFaXlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYuYP3VTQvVZg7cThlXU8NtC9swKHNjtarBZww/KWe4le/Xdv
	ZD8ibfRyemohMZFN7UnysXW3sJ7XFyGeFkXc68ozE8n/JoSqMTjR3ixZwvUXezo=
X-Google-Smtp-Source: AGHT+IE+Qp5EM1vXd5YRa3qN+DEFWWrZdrD7Cvc+sRmoXDjqMGVS+L8Z3sq2Bso/pJnHpG1Lf1dnfA==
X-Received: by 2002:a05:6902:2511:b0:e26:796:e19d with SMTP id 3f1490d57ef6-e28937e44dfmr9306617276.32.1728312968866;
        Mon, 07 Oct 2024 07:56:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3a3c4sm990793276.21.2024.10.07.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:56:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:56:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: the latter half of october, the maintainer goes offline
Message-ID: <ZwP2hlVN7Cd+U3O7@nand.local>
References: <xmqqh69thzd0.fsf@gitster.g>
 <Zv7aLRXwt9cfqW58@nand.local>
 <ZwAIM6GO3VtoG3ZM@pks.im>
 <ZwAYccsboGIhGVIx@ArchLinux>
 <xmqqmsjjereb.fsf@gitster.g>
 <ZwBtwFeVYmu6/Sc0@nand.local>
 <ZwN10b28Aaj3roz2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwN10b28Aaj3roz2@pks.im>

On Mon, Oct 07, 2024 at 07:47:07AM +0200, Patrick Steinhardt wrote:
> > Sure, though I would add that my personal feeling is that it is a
> > possibility, not a requirement, that the maintainer's funding come from
> > either an independent entity (like the Linux Foundation) or from a pool
> > funded by industry leaders.
> >
> > I say that only to point out that while Junio is employed by Google, I
> > don't think any of us would doubt his impartiality with regard to the
> > project.
>
> Oh, yes, and I've explicitly mentioned that Junio is doing an awesome
> job of that indeed. But I see the employment by Google as kind of an
> outlier here, because Google itself is not really competing in the Git
> ecosystem. They do not sell a Git-based product directly to customers as
> both GitHub and GitLab do, to the best of my knowledge.

I think your argument looses some subtlety here. Indeed, Google does not
sell a SaaS product based on Git like GitHub and GitLab do. But they
most certainly use Git extensively within Google. And I imagine that the
engineering team working on Git at Google has certain things that they
would like the project to do that would benefit Google's use of Git.

But what I don't see is Google benefiting unfairly by employing the
maintainer. So as long as Junio continues to maintain that impartiality,
I don't see any problem with him being employed by Google.

The other aspect of this is that it is Junio's personal choice where
they would like to work. Is it possible to organize some kind of shared
funding model? Perhaps (though I am personally not convinced). But I
think that imposing that model on Junio is not fair to him. Junio may
wish to work at Google for other reasons (e.g., perhaps he likes the
benefits, his work environment, benefits from his tenure there, etc.).

As long as Junio remains impartial, I do not see why the project should
dictate his choice of employer. Or IOW, if Junio woke up tomorrow with a
job offer from GitLab or GitHub (or any other company), I do not think
the project should dictate that he turn it down, or mandate that he be
replaced as maintainer for exercising his personal choice.

IOW, I think that the maintainer's impartiality is the most important
aspect of this. So long as the maintainer is impartial, I don't see why
they can't work at any company they choose.

> > I think as long as the maintainer's employer does not unfairly influence
> > the maintainer's decisions on their behalf, then it is OK.
>
> So yes, I would probably be okay with a maintainer that is employed by a
> company which I don't see as competing in this space. But I would
> strongly disagree with this statement if the intent were to ever have a
> GitHub or GitLab employee become the single maintainer.
>
> Impartiality is only one part of the picture here. The other part is
> that Git would start to feel like a project owned by that company. There
> simply is too much political tension for this to work out in the long
> term, in my opinion.

Again, I don't really see how this is the case. Git does not feel like a
Google project to me, even though Junio is employed by Google. I think
as long as the maintainer is impartial with respect to their employer,
then their individual choice of employer should not matter.

> So if we do not have an individual at the ready that is independent,
> then I would strongly favor a model where the maintainer role is shared
> across a group of people.

Like I mentioned earlier in this thread, I don't really see how this
model would work.

Thanks,
Taylor
