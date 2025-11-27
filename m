Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A131D735
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228817; cv=none; b=nowzPGU8xkadxA1mGL0CASkU2hxmoMiN5Qa9EsG0isOVyYWlDLxFucoxB9kYM7yIyuudDyu3mB48JZOxBBOzFtw9Ul5J19RVOGZlNeqJPIvdS1FImiW8upL5HvIkV7MYRZ8Nn69MT06dpnqKlzqP9AgwiXsDRON/8txETxhR2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228817; c=relaxed/simple;
	bh=lNQzcHuTp1pphKTM0nMj+/Uuf+XIyoHUFclFyvVkJH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZOtBTjYL2LQ9T6fkiYHOsiaP88Ckmdr1wyq6NHYkH5FyYpJuD0+eFlCs55cS4FlCchqPLlhDop466TPBUHl3OtBCxeScpZ01+hkfKD/7ghYH+SDw2mIutrMmb6eTucXieLzmxA6NiNF3S47+wA0N+sjjuzi9bf6DrREAIJ2JhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvkYlV+L; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvkYlV+L"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b76b5afdf04so100596666b.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 23:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764228813; x=1764833613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aj8Pg0Jn7KL+krDGfHXcLG1UcTE4kkjcRiMNSaOMjsw=;
        b=JvkYlV+LsIDgiguwt+lpekHD1zrzsBi6DKSDTtrDp+tXaymeUpFSMDwNGoPH0sB6ve
         DStWRRBAXWugAXkY/hBkEksBx9thCklS3/DoGrmJzdGiEp3rhtG5S3ewlC5MaRxqbXgz
         CZ8eOeB3NtZelbyS80VHeWMT4nNjxF54imIA0BbViNm2QzTMXjWUjPB5Qz1xBfB5ZKKa
         wNc3ynnrd0Dz3L+cTFDXP8+0qns8/RjYe3uj1yy1yj9RWgldRbpwljodgEpMsJwNA9Z2
         sdT6mVcH2+fHmnLBr9tzBWFbZ+5bwM7HfyW+ycHPl3E+ZZb9ATBbOx6UrsEZG8ho261a
         oZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764228813; x=1764833613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj8Pg0Jn7KL+krDGfHXcLG1UcTE4kkjcRiMNSaOMjsw=;
        b=fjW53yIcjPto/b/w6TjDPHY1P7h4aajC3/f+mmLWlXrcD3OWAUkTFSSBUXswvHZUGf
         DGSbu06G02IJNn+jZ7Y2efdzI51TFs/S0wRsWxZSnu1edJyQOVdWng/GSO2YvmKLOroI
         E/4eX1vYanTvdFDpFxb5MDVTRvn//E0LB5t4UlhVI3MFdcxPOXesYcNl92HNct4AI3Dn
         e4kB2s3g5T8FzieRIuDTQFYFlnD/aHFxJQcbiTXnnys3cygF78XU/piVu2aSxsXaerEP
         EXlSYAdiGhgCifrHpEytb7IgIym67WDRB17iLGOgcY2o4vOVp54TGw+jJZxECjBdRdLx
         S8DA==
X-Forwarded-Encrypted: i=1; AJvYcCWiS/rXV51CASVHc79DSOLaZB6wZ1e0Jgsjix6yscUwAz6yL7KG4auPNpAtRa9lATOECAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVub7MJ2DbMza6APSFWZ5NUPw4+XmgDT7UV3Aa32zCjRzycOL
	CIGK+zp7+9p6XaGX35lW10IM28nLJhELFT/A48G0NRM4Vpdrys32auhR
X-Gm-Gg: ASbGncvYSyYB0J6sViOKMpusx8FQyg7xSWCafvevSGS6jsA5dnV2plpLsq4r4cfc8xn
	ko0qUUV+sJUoOLXaDIbyUu9gJ3qpuZrVCAH/WWZxQox53a8oW/EJjPP0L7ubgFRvlb6jczJdcSG
	VOGz1so6Ub1M1RUcMoTt01YGj6umPnYd6nhxxKcjAQRRYJAxKR8aaTM3tyOyQ2kgh9bB6cKtrWy
	EIk74tfuy0GlXusqBHOcQmaJeKvj140Oyb9165ByziRvxOnZcRUIRWzaKZmkNixSlUhD2mJ9MMt
	B5iDLwjISfcbHSQZe4qvVFsPK3fkn+adUb0OY1dowjsp5rpKRpKnZrfXslcfSWkogpl0HPCUs7N
	jZ6DfGS60ym3hsvlO2X0qCyEEZRGkqtic1FswvSruqgD0atLUn/1Cnrqikn34tMjf/kpU2aXbzz
	TNFinDaewmyiV2iNeERu4PIrdU7SRNCOhF
X-Google-Smtp-Source: AGHT+IHKCWxKa3hE1r2DI97vGzMdD/EDgwpapcJ+xwrrnKRZueGlW5jJmkaHjkXGq3/RZ6r/Yi/fcg==
X-Received: by 2002:a17:907:3cd3:b0:b76:23b0:7d8d with SMTP id a640c23a62f3a-b7671860d63mr2499572966b.43.1764228813230;
        Wed, 26 Nov 2025 23:33:33 -0800 (PST)
Received: from localhost (94-21-29-8.pool.digikabel.hu. [94.21.29.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f519e2a7sm90722866b.19.2025.11.26.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:33:32 -0800 (PST)
Date: Thu, 27 Nov 2025 08:33:30 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wiktor Mis via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Wiktor Mis <mwiktor023@gmail.com>
Subject: Re: [PATCH v2] completion: complete "git -<TAB>" with short options
Message-ID: <aSf+yrfJo8dRIkSo@szeder.dev>
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
 <pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
 <xmqqh5ugmu8d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5ugmu8d.fsf@gitster.g>

On Wed, Nov 26, 2025 at 12:09:22PM -0800, Junio C Hamano wrote:
> "Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Wiktor Mis <mwiktor023@gmail.com>
> >
> > "git" itself has completion for long options and cmds, but not short ones
> >
> > Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
> > ---
> >     Add completion for short options
> 
> Will queue with a slight update to the log message.  I am unsure if
> we want to limit "-<TAB>" to one-letter options or if we want to
> include the long ones (the latter is what v2 implements), but let's
> see if others have strong opinions.
> 
>     completion: complete "git -<TAB>" with short options
> 
>     "git" itself has completion for its long options and subcommands,
>     but not for its short options.  Add support for them.

It's not just git itself that doesn't have completion for its short
options, but the completion script in general doesn't complete the
short options for anything.  The reason being, I think, that it
doesn't save keystrokes and it doesn't really help discoverability
(Well, okay, strictly speaking it does help discoverability in the
sense that 'git -<TAB>' will show the existence of short options, but
since short options don't have self-explanatory names, the users won't
know what those short options are good for.  E.g. I just learned from
this patch that the main git command accepts -p and -P options, but I
have no idea what they are doing.)

So overall I'm somewhat negative on this patch and in general on the
direction it takes us, but if we do want to go in this direction, then
it will definitely need more justification than this.

>     Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Thanks.
> 
> >  contrib/completion/git-completion.bash | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 73abea31b4..1705ca3323 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3898,7 +3898,7 @@ __git_main ()
> >  			;;
> >  		esac
> >  		case "$cur" in
> > -		--*)
> > +		-*)
> >  			__gitcomp "
> >  			--paginate
> >  			--no-pager
> > @@ -3914,6 +3914,12 @@ __git_main ()
> >  			--namespace=
> >  			--no-replace-objects
> >  			--help
> > +			-C
> > +			-P
> > +			-c
> > +			-h
> > +			-p
> > +			-v
> >  			"
> >  			;;
> >  		*)
> >
> > base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
