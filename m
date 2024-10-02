Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED1567D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881474; cv=none; b=UMmdThx13Q+SeYIMgXk1FCanC392qeYOdTkX0+xS8YL+MPt7KfOmM4H/n4y0Hce7BqDxF1orZgQxw+arqBzJ62fffUCGAlpQ1Zz9i0ewzwTcpEHoRdqHEVBrqM2PIuFHCUZ1Y81yBQ4GqV+RkupJ8fKed1YqNEFRWaIzsxw84Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881474; c=relaxed/simple;
	bh=uvRuSwdq80f0QH/bsD9qzTWH/lyullMMDlRwQhX+xJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSxvdZ/yVLIGy5jvIcIPI/X2nZjgxzIdeyekR15v8p/Ny1mVZz1/Kg0LdvJd1ALdWf9s4s6mo0RNjiVbBAblQ98d+Dn7/8kQXTYY64PqW7mzzh1mPstIxkpZYARaSTgQdHS3S32aXq2LcBJKSFo/Gb6iZooWa6i3uVnCVUdQ2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IgvUmBD2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IgvUmBD2"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d6342837so5414936276.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727881470; x=1728486270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XYlhIYFCvtMc7qZwi+cz92Nu858tvkzOKfzZTrXgKso=;
        b=IgvUmBD2YMXT4gpdFI1wahh/WpiuJNVUHGfTFOKKyM/tVODwqQE4Kn4UeS/aJWtU6d
         0MNFhWP2KCNffrF6rJlGZAVPyulQz7LYquYvNMcdYXQniUgQhpK0ezxrpmDGDpD9aZAL
         tqh0OoBqSv1cZzzocYjmLRFPfDVVkjc4DOwh9aa2cDk2WYiIpPBf8hN0OFY6SYacuk+X
         duV36FtKMTickNz57f9s588Jhe8pEyg1dGGw8ucNcPf7stkilQATA3kVK/+nymZcnRyy
         EDatklbzG98dmXw4asVQ6oUGnBkrVDOap+xTFqIc5g5OcVb9XZEHgcIklA/isiFEqKWB
         jxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881470; x=1728486270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYlhIYFCvtMc7qZwi+cz92Nu858tvkzOKfzZTrXgKso=;
        b=phiT0EK9EW/DyOYIPnCbxO7TxzSlmeI9KmqG4sTA5oDdmBVUxD+GND/q0FNjcGzxSw
         xSSqrfZxpxgfZTAGewYXoZoP/NMkw+0g0nVUFVGWBMziG0nqAXWoL+VJwjSmpW8065/R
         UEHM/zfAPd9hoH4/nVhVtcsBp2Z8B3aYocmPAZkC5rBmAwhWDhFCI3FF7pV/HB2a7Iu1
         MMJ0WCeFWqftuZOlZmANc1yxlEXqlbKC5opdrXy6EP8jUjpMlyajdZIbXUy88NbqcrCB
         ziGrNY2CTLWQL/pF4HkYSRZtPO6m3fon8QNOM9i0WCHPBujvCqvcQIpO4J2sGh0g3Qys
         ZqBw==
X-Gm-Message-State: AOJu0YzVKHWsC9l4cqYr3MG3eOMdh+ayG2jmBOh/AKg59C6qe0qMC2+h
	edDmpqFILIncLM3WKRMZR1C+yEKyiU62zG3NuUuFCmFoKrwUZVDCnuOAKwL8iNg=
X-Google-Smtp-Source: AGHT+IH5fJULge/Xcm625Ct+yB3HjuTaM1ciL8XrXxsDWughpNowrduy13CqTnhqmUejgVIC1FYn2Q==
X-Received: by 2002:a05:6902:1288:b0:e25:d11c:5ed8 with SMTP id 3f1490d57ef6-e26383b2d00mr3379016276.20.1727881470546;
        Wed, 02 Oct 2024 08:04:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e421f63esm3790923276.31.2024.10.02.08.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:04:30 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:04:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: mention the amlog in
 howto/maintain-git.txt
Message-ID: <Zv1g/dKlLJ2FoEvG@nand.local>
References: <xmqqv7yd548i.fsf@gitster.g>
 <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
 <ff2909b2-3526-4628-bb11-b3a09066a7a6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff2909b2-3526-4628-bb11-b3a09066a7a6@app.fastmail.com>

On Mon, Sep 30, 2024 at 11:06:03PM +0200, Kristoffer Haugsbakk wrote:
> > @@ -165,6 +165,22 @@ by doing the following:
> >     In practice, almost no patch directly goes to 'master' or
> >     'maint'.
> >
> > +   The maintainer is expected to update refs/notes/amlog with a
> > +   mapping between the applied commit and the 'Message-Id'
> > +   corresponding to the e-mail which carried the patch.
> > +
> > +   This mapping is created with the aid of the "post-applypatch" hook
> > +   found in the 'todo' branch. That hook should be installed before
> > +   applying patches. It is also helpful to carry forward any relevant
> > +   amlog entries when rebasing, so the following config may be useful:
> > +
> > +      [notes]
> > +	rewriteref = refs/notes/amlog
>
> Nit: `[notes]` is indented with spaces while the next line is indented
> with a tab.  I guess it’s supposed to just be spaces in this context?

Oops, good catch, thanks.

> It might be worth explicitly mentioning the git-cherry-pick(1) footgun
> that Junio talked about in his email: you have to restrict yourself to
> git-rebase(1) and `git commit --amend`.  Since git-cherry-pick(1)
> doesn’t care about (respect?) this configuration.

I think that's worth mentioning, and I added a small tidbit in the
latest round mentioning it, thanks.

Thanks,
Taylor
