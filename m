Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A971991AE
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540686; cv=none; b=Rzz85n6FrEptU8flFPx/Ac2Ma95kG4wwFtJhq2YA7AvYBSIPnooxaGcQA8IQi1f1LvVRbOCazT/XFoDgvhYL7Jy7VfPYcHFoxeZkMkiVIcLnIWUoEwPzFRp0jN0fN7jq6x5sf2HyFa9vBTyNJ1Ozk8lfLZDss5HhtzFBSqXZRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540686; c=relaxed/simple;
	bh=njaLGDLUO1EMXGNLncj6trH5BjUMAhUXeK51Rm8DKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgbdsWRigivm2qP7gqX8bYf74/TmfFBYhvUXRv/1B0OtjHT5Vyw1A9kP+wNyfto04JD+u/JzH8h+mYRCtgJ9r3iFSRCjTqwLQl/Th3c747Vq4wISm97HhCDKlpYcAcUHSRWf/GiZtbzorNFnzlJKge/rrQYUDCF5Ht7Xw68TlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LnyXLNwb; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LnyXLNwb"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e292926104bso4299333276.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540684; x=1730145484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njaLGDLUO1EMXGNLncj6trH5BjUMAhUXeK51Rm8DKgs=;
        b=LnyXLNwbHh4V5E4lyCsI+ZQiEIv3Y+whKlYjlZck9Bfca4L5qUDUJ08hpp0lvV3e+1
         I0uQcsj0OLOuOPn0xrel97YBD798mzOW/aXoaPs7QgFa9mkQ+0PP5pNRShle0T7yjNCG
         8iwm8jZHp2IMQFTq6MHE/JdkrjzgLh0RjNxStTp90DoXkWpnrL5lDYqUJXlETvYg53f3
         CaIYnT3zbCsRkDkU5Rumz33Nh/vlnhHEB+q/dIkEwXwSdAkm+aL9JgRYvDdLBZwIi/8W
         IKItD6okax3Y3UMpDJoOgM0u+wSAMuErzejBjEo01jXMk1g9eXhbzfgWiKJr0a0MGAjN
         7eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540684; x=1730145484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njaLGDLUO1EMXGNLncj6trH5BjUMAhUXeK51Rm8DKgs=;
        b=pQT8RQaNP1FIp7vbc90aVaALKj/ri4TG8hLmaOBUIngwJAFvXp/cmcgFLrjo3FNrt7
         vZ5ibeZcn8Mgq7cZn6kBcX421dVP4DmEaJwPxXwLCo04qaDuV8hTGkPzrecm+sivzyKI
         ZDaQVLbbCE7d0uDHglLXoaHr1fYaUM1lq0EezvrxLXHsyKDS67qD9mXpqSBd9tClypvW
         L47QAd2sHPDhuJE0aXkkFoY+xfIixv2p9Mi8eSG3Q4o4vqhCZpUaT6Fsy6eZjnfJSp0c
         VVEroVf5ZYI1RSJNieO+Z4U9GhX4ND2EXIeZTS7e4B4KWco/j4+GWRRKk6fHsNwKkbXu
         8gng==
X-Forwarded-Encrypted: i=1; AJvYcCVdr/Jj9CmT54OV/bCP0Db0rcJWKGmPQthw79iTnLAd9pia493uO3hHy/zaqPwNxE0aGac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/nMAPSJvLvSqyO2uAfMlt/yp5LIPc+t3dEFnsJ4MtkBx+++4
	k9mfJ73Ckfh2HCZ5PuZQWn8Ffxo1BST9upZTW1/XU4xoGjNtMgUiHu4N/bXeFTs5J66zFAvkavq
	O
X-Google-Smtp-Source: AGHT+IG/75Bzs4fSwH/o7fyI/x1LFhDnLoA3bDFGY0k2deZuWYIVohu6aQjAo9APTtVCzj3fnjjZuw==
X-Received: by 2002:a05:6902:c01:b0:e2b:a893:573d with SMTP id 3f1490d57ef6-e2bb14274a9mr11855583276.33.1729540684206;
        Mon, 21 Oct 2024 12:58:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc993cedsm829036276.25.2024.10.21.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:58:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:58:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Message-ID: <ZxaySpwA7jg7c1aw@nand.local>
References: <20241019163439.274656-1-kuforiji98@gmail.com>
 <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
 <ZxZDFyKxTn_D7c3o@pks.im>
 <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGedMteMtaOvyE2gX59bMudEUmCZw7nOh=MuDRi=7CbYm-gBDQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 06:17:06PM +0100, Seyi Chamber wrote:
> Yay!
>
> Thank you for the feedback @Patrick Steinhardt @Kristoffer Haugsbakk

Thanks, all. Let's start merging this one down.

Thanks,
Taylor
