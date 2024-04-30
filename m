Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8A18E1A
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459284; cv=none; b=rAFiKxtSUGnrDGUIMnrXB28WSKD/SnmY2wPbL0dRE73uOZyubwQ2JB7+gizRkkiDh+TjTo0DxIi7xOtlHjTZyTI6cGpssGMmVVYEfAq6BdZnfjSl+RrgsTSKrpYcwBWJD/zFJgxq25ccBGURTTva5VCPFbsK9ieqaIqonKf2SBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459284; c=relaxed/simple;
	bh=FK2zGvnFNe96C2hnGlHuQYragb+GOvPFoQ164GvSNkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkjxcyneINQ88qWyKD6lP5HMdywX623CFeV2hJbtj8LaY/nK47hxmX2eEE8ImZk3wVoOv/7bQWTqglMjQIw6LJB7EmyBGaZp8xMKI8T8nT2FSIGKQPCqljZ3vpVbQ0uXf8IJMJQW2EUffSUCWMHySOif0I9+9MbBqaO4TLxzd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfa15q+v; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfa15q+v"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58ebdd8b64so280647966b.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714459280; x=1715064080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BphZPZq9xh4H5e43CCB6UrxpFm8qD070glG2Fl7axK8=;
        b=mfa15q+vlsX9nDRrYlYKZQgQ4ZRowwq13jPf+W5vkYmDl/1/n/KiMcO0cJggAf/aXn
         fRynIh5TQyBZ8UlU2+0683BTNxYZIoh+Yt3y91BgrXri0998HedQTUOFvUmFXlnWjv0m
         Q1xsPkye8b28hv+x1jVk43Cx/UwPDoARzZ7tsg2aOrrQNCQ5MerOb0kRe3stRyEH60u9
         YOpSRd5XVExLrsv72H+BMs3Eni9HGOYLP0oBk3ACvDt42MVN5enMHo3uHTNJ7VtuAytD
         MFnmrh4v/LVh1X9Jvpr5c1Fb0x9N1VnDX3aAaqFCC2ncEsgDQ2hZnqXruRcDvvD58YnZ
         2cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459280; x=1715064080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BphZPZq9xh4H5e43CCB6UrxpFm8qD070glG2Fl7axK8=;
        b=Eus656R2d4hucscKle8buTbgZ7tKaDieEl1/0zNo5S62rQeel/Pk7xYpFmvTMiiyKO
         vhaDgM+EyXDl7fF7jizEa29VOSpbFTpPF4SSpBGFsBuyoimitwuOPzeWB3zzVXGNnDzG
         vdboIVotR6sXVGXhll1/XkE5ccz4RkjKtlasqTxGvZhk+gHqgZz9+mYNrOTVMI0FWCiS
         uE4oh1lj6+QtrTWzhiAw2XqNkaylcU5p18QcEL7vGDESrhsFD/Fb2QuWx1BxSDmEFXLB
         3U2CFvJmNpwk0jL5x+1oLaXYz2JWlfoch+p2iG+WO+aDFK5oYEmngJ3Z53RfNASEia5P
         UGag==
X-Gm-Message-State: AOJu0Yx+W7flP5VhKkDUnLL5ERQlDIQ8d32wJ4ao66yV+j/TwjvDKJ5V
	4FZWxg5DGxobZhHb2nslfjlSzE9ORqZf1uLmOwTC8eYe7fq+LVoG+RF4ME2j/PSmFdEe7ZgxxDr
	84Naez+Pu1zBsAk4vXUV4C9GRSmk=
X-Google-Smtp-Source: AGHT+IHtqT13OMoDXil0kOsYUEZ/6QCd3Y6INRtp1kJ5VE095KaGtD/Q367/9JNOQYhBTD9DxcgOg5CrjhMZhfmIQl8=
X-Received: by 2002:a17:906:f743:b0:a58:f13d:d373 with SMTP id
 jp3-20020a170906f74300b00a58f13dd373mr5061363ejb.2.1714459280259; Mon, 29 Apr
 2024 23:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD1Feotp4ra2tpeA7+iRiqDOFzLsQbzw6mUDqt1Uq1oTVA@mail.gmail.com>
 <393d03f2aa814010cfaed0d73cf424b3@manjaro.org>
In-Reply-To: <393d03f2aa814010cfaed0d73cf424b3@manjaro.org>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 30 Apr 2024 08:41:08 +0200
Message-ID: <CAP8UFD2xN26cuvMKL2jddmnbHLhjV0a+s1xGN=mNYnd+fbHVzQ@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 110
To: Dragan Simic <dsimic@manjaro.org>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Brian Lyles <brianmlyles@gmail.com>, Max Gautier <mg@max.gautier.name>, Adam Johnson <me@adamj.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Mon, Apr 29, 2024 at 6:45=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-04-29 18:41, Christian Couder wrote:

> > In general all kinds of contributions, for example proofreading,
> > suggestions for articles or links, help on the issues in GitHub,
> > volunteering for being interviewed and so on, are very much
> > appreciated.
>
> I just read the main part of the current draft and it's looking
> good to me.  Thanks for preparing Git Rev News!

Thanks for reading it and for the feedback!
