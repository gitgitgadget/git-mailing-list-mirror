Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8118D65C
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287688; cv=none; b=Q6/Gnzg4vKKwqKliPCepR9PsvvhEeJxo4zyJ+aCpxbzuUKtx3k5w9zCZDDxRBGYolWXj/ixhEJloxwVNRoDMBd0ypdGvDAZMHVI4QnFaXkIWLJECK0h6wjm/RQra9zIPvQgbtvTS05swDu0Qu+Deo8uBE5z2+2vgWVruc1f3yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287688; c=relaxed/simple;
	bh=wr4gBQZpQDS6TK5hbAIXlNMGJ+fZf7nrJHptVpIkd18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6h5OEn1c4uKJjT00w8g215Q4rkGn+GpzmBTkRje0iGtdRwp9P2rbb9MNbkfOijcAaXuEl5H4EPT2Hd/1kFiCLeS/qE81UPkXkT0JPZCE2a0OhF+mh6Tp3449AfChLfL8aWGAsuWcQHqVB/CLOS6Yeqr0LRWS0dBG+1YZCCeDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OF7uP9g3; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OF7uP9g3"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e297cc4b134so2624957276.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287685; x=1729892485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wr4gBQZpQDS6TK5hbAIXlNMGJ+fZf7nrJHptVpIkd18=;
        b=OF7uP9g39Lrd6OM+vJ3SuLrvlHW0VIJ4uTnvFrteSLwr8o6RqoRIHMLbrHnLsp0LQh
         lQs1yTVHjfd9XRsQu1lh+8q5dMqdKz7asOWfTuBz3ZkQWV0jbjP/RMT3kEAgHDUKgfEd
         PQQw16OKaBXkY+2wngfKupdshHFmiATKiRGgZhq/Yl2dsJULCKS3eq6sBa5gVSkNGWB1
         ER/186Sr2XJqD12o4XYJuFK6Z74COabQd9B7d+ok3T4gG6+K3Tz1JB6JTNkzw+xfpZY1
         jtZxtgU0sCA2W8+sefdPaKI5w1bfbCWF0j+8QvRjyS8ZtSp9trMNT6apC8yeHbJRmuM6
         XXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287685; x=1729892485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr4gBQZpQDS6TK5hbAIXlNMGJ+fZf7nrJHptVpIkd18=;
        b=D8+fCQNPhuUyKxhixTbJ0NbotDXOH1KC2UthVgRH5S+Wt6sdN7l8UQY//5NuG7jwai
         BhiUPhFhejXmdcU5//zBha0ta38x78z2uRANF2HM+7MLJ9JgYaNwspBrQbXL3xLHdWqE
         AL6Z4WrL9SzaX2JSs2Pmr73ShSkA1IYiqjC4O9hkYL3T+lAZWyiDcFqJsoho/B8GaDQ+
         FjULn3KqK5p8EHAg+pWp6TTdMkUvogwvE3W+H6Qmtu/SCt7d4c9mQgp/iQuzA6RzpWrg
         CkscvoRxRV+G4Y/K1xJ4XjQ7sdCrxWfZb5i1hBgb2seLvYLFrrfYR73weeOdIl6g/80o
         LBgA==
X-Forwarded-Encrypted: i=1; AJvYcCW3yvX0grH2PZka44eSjPZGRZY5bz+ajejM7vRkJav8OWDKVHHveiLgNG0VfulxRPMQnpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GY4MMR3Wn2gNtv8R01oC7+MdP0Eb8qaRC/TiaOZPqBfz0CE/
	TrLN0iP5vz0ZAL454lXXg34h2WqLXCQ0ee46IyEVkzDrzUVbleXFqCHN1Bf3fms=
X-Google-Smtp-Source: AGHT+IG583ore+ZTXEKm8HYjuS3too15hbto8HhMggjNjhorcflLaRIX5aJuXmBpg+1G4DiZYX5kYw==
X-Received: by 2002:a05:6902:2701:b0:e29:2d9d:7b93 with SMTP id 3f1490d57ef6-e2bb16910b8mr3709905276.41.1729287685396;
        Fri, 18 Oct 2024 14:41:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb0204f39sm486684276.17.2024.10.18.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:41:25 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:41:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] t: fix typos
Message-ID: <ZxLWAmXJORyVldip@nand.local>
References: <20241017112835.10100-1-algonell@gmail.com>
 <ZxFyKXDCJkRZYYQY@nand.local>
 <ZxKSFBl_pV2r99dY@void.void>
 <be0c95ee-1d9f-4e97-9710-0ceba9c3aaed@app.fastmail.com>
 <ZxKi7qn6tEWyBXsd@void.void>
 <ZxLNj59mKfZubiY/@nand.local>
 <ZxLN0u5r88hQsY+c@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxLN0u5r88hQsY+c@nand.local>

On Fri, Oct 18, 2024 at 05:06:26PM -0400, Taylor Blau wrote:
> > > Thanks for the clarification, will address this one as well.
> >
> > Thanks, both. Kristoffer -- it's fine to do this in the same, or a
> > separate patch in the new round. Thanks.
>
> Oops, I meant s/Kristoffer/Andrew/ here. Sorry about that.

Wow. It must be time for me to close my laptop for the day ;-).

Since this topic is already on 'next', please submit any new patches in
a separate topic so I can queue them independently. Thanks.

Thanks,
Taylor
