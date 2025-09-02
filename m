Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52C33EB01
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833668; cv=none; b=Rip9FP08ujtyvwtxiy95IyEU+eL1QR4dCRcMAmRsMBxKTBfYmFBbSOGf7MqDHDzaYJi5nltnrMWXI4X9o5sheUHld+sI2dFsjCEgEqqhr/TMIT+f4LWbG21vMqvVOQVbEBgyTjppfN8CU0+VAdlRegB/XMGurdFkOTHV+LAxK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833668; c=relaxed/simple;
	bh=OafxVbUhJebbG2NztPaKCBkF13cufLdPbCKCHiSxfK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecq88q9fGVMAlpj1jlFZAY7Rq6ooV/DaDzIsWIs3Vehz6f7g8iLLWaJHB9Gw0WRmzn9StNDcyLXX2U5J+0azi2z377UwDkddVSXk2vGcB5Y+/iPVwx2mhswyirDYmvJgIN3m6la42eS01gdndxxedu4cLqPRUtuRKtwkNArQXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MmwbU/1n; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MmwbU/1n"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so37397375ab.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 10:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756833666; x=1757438466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6zRkGmFsdXmj3Fn3rrxP8MrbGNX2M3Iw7A9gFNI81E=;
        b=MmwbU/1nXbXjpbb+aZ9XBm1WM1/XdePfVJ9ie/0Yy/YJl879A+A57pjq7C1pP0SeBa
         ki4ovBhcV8AnB7oTGxLlX54YQGCL5dzl8fsJEqIrdwbrGpcDsQpzIw9sU9CcJetCm2wD
         aY1EHSlFymw+knLWSqamYNyNbAb0H9G8hvJoQSRE4DxowIzF2EsByg4loL8AYJMTbTv2
         z26jpBWqS+pASpUNOn12pOXl5Ommwd9oJNurrekeDmI9HMqRWr8UFwqhstDEcNqf+tmu
         1R0MxiJFcqsPI4Ctht1qTaW8JzTdtJRhZn2VrdiIimc9sJm6DydJEwC9NbqsvZcezuAZ
         v74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833666; x=1757438466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6zRkGmFsdXmj3Fn3rrxP8MrbGNX2M3Iw7A9gFNI81E=;
        b=HNX4aa5K0fwOE65q+EnsKFHWtWapVYL3BzTGuGmOYns/dCeK1sn+dQGZFZnT18O9Cd
         oX1jMIZc8ToafH81Zj0JhOEUMBgQZoZNzzskQ83cTZjMrUIO8FrU0RsQwx+D+V5eBd6d
         Dq+TGg3c/IX0rkwB3bS+m301Q/4GQuOqlTNAcQUlBidNxZtSJEZAD/5K/B6rQO+73jpN
         ab0BCV2FDtBgnyk7BKCU0zwiRfLIbZyoLYqr3jGRj0k10/tok6Nfk0C8SYajBU8qwwUd
         n71kQxsnoGYxMuTD9SgC0pzWxgkruk3sWWDAFr2P3/vuRx+aFSD3L7/bIKL6cuOA7iKC
         W2mw==
X-Gm-Message-State: AOJu0YzVN+gm4MonT19NAQvv8AgmD2THPAmMNUKgtzwlY6M0FTmEcu+6
	tmTw28fCe8ECNqIJQl0q1X49FDt3PkfFXndyoobVcApkMNFr/HRWC6Lj0wxNohp6ANQ=
X-Gm-Gg: ASbGnctTkdY2oVPIKgztJpEzIM8P7HiPX/fIAOvjlQyvJyDf3yWOnh7IiajCHpjcQKK
	nfdBaJrjGXVfSUpdGzoRox5iW9T+jGQvTQDRgyZqoXu93CxXsAob4lt/5DHro9CUfzkvsdoRJPa
	fd501l036bn56Mt8k9siHXkzhyJAUBP+8ZRQ30WnMjDL+SCB2cgxKHB2VS4xS+9NqCM+4kNNOsn
	G4EJwP0N1kTAlN3fILdfyaihYyjWIhicJTmwOs+bRlf7bHxvRROcsFzAvqtPVOBsCScFVnrAehU
	G4R9txNe4E9yK/eJSUyoUe3Uosy4c6WN6mYtI5k9nPVGqmSaiO+HpjgQoqFZbShZdG4ybIEUTPf
	YkDosG+BL13l1HsF1j4KhsP1IDXtWQPpw7FDI5KMGy5L4nTtNf2fBaXroACi2Wd4H//ivXCht47
	+xwujWtNi6iLKAoTd9oHDhVu16eg==
X-Google-Smtp-Source: AGHT+IEI6/7kkeKzNcgGfdiEiq8YczJTcnkKFGRiaD/orhDEX19sXMh5tvNxwXs0wydfun/WO1asAg==
X-Received: by 2002:a05:6e02:3c06:b0:3f1:dd7:24a7 with SMTP id e9e14a558f8ab-3f4026bd93cmr250236115ab.29.1756833665788;
        Tue, 02 Sep 2025 10:21:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3f65dd28888sm3460945ab.48.2025.09.02.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:21:05 -0700 (PDT)
Date: Tue, 2 Sep 2025 13:21:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 02/16] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aLcngI6vm9DmqUeI@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-2-d10623355e9f@pks.im>
 <aKz0/WNu/GRYh3/W@nand.local>
 <aLav4UAcfQjvNzMF@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLav4UAcfQjvNzMF@pks.im>

On Tue, Sep 02, 2025 at 10:50:41AM +0200, Patrick Steinhardt wrote:
> > > +void packfile_store_close(struct packfile_store *store)
> > > +{
> > > +	struct packed_git *p;
> > > +
> > > +	for (p = store->packs; p; p = p->next)
> > > +		if (p->do_not_close)
> > > +			BUG("want to close pack marked 'do-not-close'");
> > > +		else
> > > +			close_pack(p);
> > > +}
> >
> > And likewise this looks good to me. I do find the braceless for-loop a
> > little hard to read, but it's (a) correct, and (b) consistent with the
> > original implementation, so I don't feel strongly about changing it.
>
> Agreed, it is a bit awkward. I feel like our coding style should be
> amended to say that we only do braceless bodies in case the body is a
> single statement.

I think that our CodingGuidelines cover this as of 1797dc5176
(CodingGuidelines: clarify multi-line brace style, 2017-01-17), which
frowns upon statements that extend multiple lines.

So I think in this case, the CodingGuidelines would suggest that we
write this as:

    for (p = store->packs; p; p = p->next) {
        if (p->do_not_close)
            BUG("want to close pack marked 'do-not-close'");
        else
            close_pack(p);
    }

, which from our discussion here seems like something that we both find
more readable than the original.

Thanks,
Taylor
