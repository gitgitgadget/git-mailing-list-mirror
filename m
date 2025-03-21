Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E51E8348
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586602; cv=none; b=d2r6GyxGFEs5EqEp3/aibfvBo1DGghUwt5LB9r7EwWJmCB8uEmQ8RJmP+xsiuaQeKaqNU0093MfqqRfNMhbSUDrCPGKM+bSswpDUWuUkTeE8rqaFD8mvM1+fmXpUqgQ2aa6+pMdHrJJ0JI0/0srPN78ce/XMjSvDGyWtk2jx/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586602; c=relaxed/simple;
	bh=3aexS6ZmwoRsmLxOs3cDby8bPoIaZitvRvUC6+4MoEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0ecjbYkMt3nmQhpEpQzCbjnhdLdSS8DD6v7ReugDaEPVJ94FXtaRveUtWzgVZeZutSk4VyymuCNAQvwts69e4AHoeeR+z00AvFTXlzfOudjjM0NKh7CK+wADwrPkZgwlQYzMz/e+OwJjrTBi9VuyfLH1y0vpw5xOPF4f9jR6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXjxjk20; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXjxjk20"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so50025ad.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742586600; x=1743191400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E5uLEnx52oqd42L+X533EKOED3DsmJHU9cGU7sdD9c=;
        b=OXjxjk204nFIMo0qolhpD/uDDfp0RLIuBwfVa9RkK3ThR0n0HzGkkmuVlRtJQtUihg
         PwqW8r5fsa/5tFHoOAY+E3QbNeckcDXiBLO6tKcGe348XyMxh1FxV79yBPOxFGFXaknF
         EImgwjoCb5t7aVx4D9jHUOzV+JlioeZ7a9BdFIFK6DHdgAU1dNG+f96CDIj371AzZT9x
         up7j8Z36DA21f9TWunftBi6MNmxs1A5WZUGCTBbNAf6OtbmLxwOVCaDkfn136BQdtHyR
         Lh9MnjakYlYusCC033Hq32aydnw7/4ZjQ74W+Gy/vB2fKf9LCghKtRaKkpaUl4LjRIEW
         k4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586600; x=1743191400;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E5uLEnx52oqd42L+X533EKOED3DsmJHU9cGU7sdD9c=;
        b=KbNXV9eoU67iPifzSsDVlNu18+l5mTFGbQUuSBUEaDqnPDz/Fzsyn7maimsZD6dn+W
         o66oVPll9nXO37Zz5ADgpeFpxmhjCWzVSsfzapJRx6BxAC0CM4KcAs5nYfSMBCWl3gYi
         bvA0ii2UPLsaVQ2SLnbK/IjVqvOlQpYjIVAh7D7cvCXtTk1gApfQzUjMu4XpljuDKCll
         eux4TUhwKNiXlHFKDbQtoM2dkDJfDrX3y3ObhBq2p1Le/lDqF3AD7GrBJRbaA4DLWmeW
         2gw4sYRRBKU+UqqP+VAACoadh0bG4lHtr/pcUMHKK12NF6WRxBTSezRF4AzI+TA57b7C
         znAA==
X-Gm-Message-State: AOJu0YxVSQiBQ7k2DxwPsjzTfek6Mk9gx1qk0F2vCzMvQFez+en1mWvM
	vXjTY1xqbX5XLuf4Rp/ZEHoIzFThezoo5VBXD1BjCr2bzxShORfS7Iiv55T4+w==
X-Gm-Gg: ASbGncvcsdKkYUkOm/ZgjDIsgnsPqghqVcKBCsvWwIfhfZptdPmJAF8DfR6tMYwpLzc
	VgMVnBGHqwxEvqGgqYM5ssnp51OOvFIeLvL0MtzEdyg+D7uIo/5mZ0OKkryGq+YCHqU9IfWTu28
	N1mvAesDmnveerl5lWRwHi3HB0C2F/waJYx86C7fM82eRouW8le667Gy/r9aMuanorgYiWCVx9D
	626SoEFEVrcsTx9x9aFAgddEb39F+yGH5WyfN+q4Jz4p5Nks4XDDFc5O6K9N74UtpzNJqdJP7qy
	JZTcFeunXinGa6f8s37juP3BuqMdiJhTDsoz0XNOsBk=
X-Google-Smtp-Source: AGHT+IG+i0Rzz04Y6XZG9O6PBryZuNUtkcbfpcczEVBYjLjum7v2DbMWbkbwLX4GovquefBk3ZvXBQ==
X-Received: by 2002:a17:902:f607:b0:217:8612:b690 with SMTP id d9443c01a7336-227982a7b83mr522255ad.8.1742586600291;
        Fri, 21 Mar 2025 12:50:00 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:f0dc:20d3:8aea:87e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811dd182sm21423045ad.196.2025.03.21.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:49:59 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:49:54 -0700
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH v1 2/4] libgit-sys: add symlink to git repo root and
 clean after build
Message-ID: <fyl4ogjine7tclhrdklwqv5hnd572ba6tmpecws7qt4hexhtoy@h77drm7odksx>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1742339107.git.josh@steadmon.net>
 <d592a3c2e3f56aa4f6915a07307a2ed349296272.1742339107.git.josh@steadmon.net>
 <uu4s2acl4lwhj2rycojebnkygwqvdhge7iwh6uaedsmvkphchz@vg75gxitvqvn>
 <03110f30-54e8-49c4-86bc-f4c0f5641f41@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03110f30-54e8-49c4-86bc-f4c0f5641f41@gmail.com>

On 2025.03.20 11:10, Phillip Wood wrote:
> Hi Josh
> 
> On 19/03/2025 22:23, Josh Steadmon wrote:
> > On 2025.03.18 16:24, Josh Steadmon wrote:
> > 
> > I'm currently working on an alternate solution where we build the object
> > files in Cargo's working directory, rather than in the source tree. This
> > will (mostly) avoid the need to clean after the build. I hope to send a
> > v2 with this change in the next few days.
> 
> Meson has builtin support for out-of-tree builds which would make building
> in Cargo's OUT_DIR trivial. Our meson build is still experimental though so
> you may not want to rely on it.
> 
> Best Wishes
> 
> Phillip

Thanks for the pointer! I have a working Makefile solution which I'll be
sending out soon, but I'll keep meson in mind as a backup if the list
doesn't like my V2.
