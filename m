Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33581EC00C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815762; cv=none; b=f1mqKHdjTccBUS61HncUW8SSoxq7+cHOMJPi7sCEc3BUxF5I0sIST3DHLtLO78Vl6pbbTEw4seuPVjedeFpnhQqdNwxO4ei7LYPKmKbA1D6yeNOIZ5gmSVwTSStsszMoqWZ71lkTxjfAeG2grqk/y/NmbW8EArVi7GCO23E1gyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815762; c=relaxed/simple;
	bh=tajjEvYT+bsgy8HqzO/yKHZV5003GiZBIoaX4DrtUG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZieRMlb/5+Jr+uChu9sW0o7nQzaA7zZuIzJYUun6ufNpy17saiaL/OwVBl9lPCtWmNWcUIu7/gqwEhhIcyWPfpK5yt1WonOuv0DUMUPd8FaB4DiRzyLb4q5jisG9ThtIAbDj9SRfVR6W3OdHtWIuMLp6j5v8G5cFIH6qBoTffC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN00+5BA; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN00+5BA"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b2b6019a74so190737fac.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815757; x=1742420557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PazOGAR4eQJSWmDkE8+uXpzFkJ5qOOtRmbFKEiKauRY=;
        b=QN00+5BAqH/qFSfSbSmQstSFYQw3IyZz3FeeKdHKs8HJRWVorxXnw0BYOaJiM3nGrS
         96IJVdVnKACrV4rUGN6aZsf+duUBSm2ybT1WZXBhFdoXai27QbEvTIvY/+PhcZ8O0zvU
         Rwi6d4qIUs6O0nM+y0s8zvYyDL7/XOWJLf45xltcWOrH8gmgkfXZ3NXWtd4KCstGh/ZO
         rzI1fE0kzuHsTseauQJqQGjsetH0ZXa7v+5jmLnSgESVS4zztQyD99yabl/oAqQ4njR4
         VTQUWDdpQ2AKyNRk1pCfiKjLOWwmT6psrM4HbU6tKiw49F3cweMnRIFJDDeAbSHbquat
         U0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815757; x=1742420557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PazOGAR4eQJSWmDkE8+uXpzFkJ5qOOtRmbFKEiKauRY=;
        b=vlEdaKDIHKWUIjAwYKlMkjoO5vOgAAPpVYAyerxI8B47p9f2PT4sFl0fcF0ORJbLr4
         dnRpHmcRllTJqvNjsMKTSlfTJlIIiApgtQHTeHPRLRJIKwTaNdbyn0i1TH2SymNdIFhf
         u4K7EjHGfNL8BsDKaollAwg7HaUtizzspDoCL0DTNqHR24BDVI/zfxzm7qEYNWsvZ7SU
         WzNZdS0IfA2wLuziMmGytpCtm8BUIisVKSuzOK6mFHWNIxhaKYak+VBVEFYFu7rd07Yy
         xnbRW86czzpqe7Hcbofu7/zvky7/ExIM/KlubUEOOjNLlFtdaSYPrXMy7RAQQR4wFefe
         3s/w==
X-Gm-Message-State: AOJu0Yw3DBb1f+DacL0mSBbpTR57pMGfcRvTGMVJg5l66Z9ji/jnJjsM
	OiZdN/NUl7ASPrteN1W8DH640UYmapXbQqWA+eLJYstVFMF81bUgc4ijGg==
X-Gm-Gg: ASbGncsCBaddgVVs96HZj3O1lTFv1dsj4TYQsn8yI4ptsu52ZssrLSxB5ZVFAWL2ex9
	X+4kNZ3Q9POiMmx9F4pfIyt/paqxCD9g5ZWp4v1PX9Wxgrsu0x/0fr2ZG8mLZVYlMCvL1mCnnVi
	rn/GAW66UKOF4o6/uUCHnlIWg6cWr+U4F4dk9mjr3/F5M0NdWI6uhqRj5lBuffe7nuipCxWmNF+
	oqaW6LP2A6EYJjFaZlGc6/udmsZGmJcaUz+s7Ga0A7WHLRPPxcNqultvReNlUmSLDP/y9L53N7U
	O6wpBmvRnH+aDPXRw0uO53s4kUdduJlqNFhYlVuPm86ehHyo
X-Google-Smtp-Source: AGHT+IF6/BA+/pfPEtlp3hyn1Z+dyXzDXYVSWDc65Z+kdIZcMMd5MgQBFPTuzR5LSGRk8qzQfplnzg==
X-Received: by 2002:a05:6870:ef03:b0:29e:62e5:9b55 with SMTP id 586e51a60fabf-2c2610da07amr12032708fac.20.1741815756757;
        Wed, 12 Mar 2025 14:42:36 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72b8c9fe897sm1286147a34.2.2025.03.12.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:42:36 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:39:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com
Subject: Re: [PATCH 2/4] rev-list: refactor early option parsing
Message-ID: <zozymxxh4s2qbh2cknqyy7z4ktgppm7i62bhkgupnij4enkq5n@6v2icwdt77nc>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250310192829.661692-3-jltobler@gmail.com>
 <xmqqr03461z7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr03461z7.fsf@gitster.g>

On 25/03/10 01:54PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > @@ -639,19 +640,15 @@ int cmd_rev_list(int argc,
> >  		if (!strcmp(arg, "--exclude-promisor-objects")) {
> >  			fetch_if_missing = 0;
> >  			revs.exclude_promisor_objects = 1;
> > -			break;
> > -		}
> > -	}
> > -	for (i = 1; i < argc; i++) {
> > -		const char *arg = argv[i];
> > -		if (skip_prefix(arg, "--missing=", &arg)) {
> > -			if (revs.exclude_promisor_objects)
> > -				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
> > -			if (parse_missing_action_value(arg))
> > -				break;
> > +		} else if (skip_prefix(arg, "--missing=", &arg)) {
> > +			parse_missing_action_value(arg);
> >  		}
> >  	}
> 
> There is a huge NEEDSWORK comment that essentially says that the
> above two loops that this patch combines into one is fundamentally
> broken.  I suspect that the remaining two patches in this series
> would punt and not improve them, but offhand I am not sure if this
> change is making it harder to fix them properly easier or harder.

My understanding here is that `setup_revisions()` does not provide a
mechanism to reject certain individual or combinations of parsed options
that do not make sense for a command. As you mentioned, this patch is
just punting on that issue, but I don't think it is really making the
problem any harder to be resolved in the future.

In this case, the `-z` option is parsed early to avoid is being handled
by the diff options parsing in `setup_revisions()`. From the perspective
of git-rev-list(1), I don't think there is any reason to be parsing diff
options at all. We could introduce an option to disable diff options
parsing in `setup_revisions()`, but now that we also want to modify
stdin argument parsing to be NUL-delimited, we would still have to parse
the -z option early in order to configure `setup_revisions()`
appropriately.

Another way we could potentially resolve these issues would be to
optionally separate the argument/option parsing logic out of
`setup_revisions()` and expose it directly. That could give the caller
more control over how options are handled before fully setting up the
`rev_info` structure. I suspect this would be non-trivial though, so I
think it would preferrable to keep the current approach for now as it
isn't making the problem harder to fix IMO.

-Justin
