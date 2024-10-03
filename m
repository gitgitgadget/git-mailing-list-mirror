Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039189479
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917781; cv=none; b=G+wNQGkdMtylDxseBgpVzZN+jR+6ClWxkeXAKOM1q4yi6pmUlK7oiWLG8xHplWFk4vi42alL/m+HfZvL6QqAyvCCyO9enQCpi5wRRjV7VH2ISwHsD2jMkDlMyet3dmXi2j1//H8CfA6VMDGXpOqOsr4SFVIF1JbVOtivf58+C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917781; c=relaxed/simple;
	bh=6glK4NDrMW7vjE/uQ8C6t2Gz6WRbmlvZPiLtlyywTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqYQXk6zH/Eq6+Fif6Hf0OPmHMdKZ5zwLbTEL5rA664ZMt1jk3NaFj1aLiYTbbN3biobkbvGS6ZInQpjsi/8mJmBtxDo0KWArfyt7Ve6N/idm/7QpsJ39EwVm72f8O2WytN3cY+qR/fZpIvH6hLkv6+P1aoiNhZshg7kWRAhQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tIJ/haRv; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tIJ/haRv"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e260850140fso432933276.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727917779; x=1728522579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6glK4NDrMW7vjE/uQ8C6t2Gz6WRbmlvZPiLtlyywTWA=;
        b=tIJ/haRvcSG8jhNgQTvalXzKG4ArV6uWl2vEmg/nZnU/FcLjtS3/IptJFm2sz62QKQ
         JJWvgttlbZFM7AtiDzCuPqRZFbs8UldTlTUfWmljpOVCRu5FNS20dldmzUaLZU7cAnN/
         V5ObP6AvqI2fIYbQ5BePHLFtpbIElnBDk9npy7cFer0YWwGByDd/OBtixlUgmONv4Bn3
         RMpGDGHeLBxJSU3HfouZCzu92l09Lol9CSWU68irfvag9x6wIYJy65I79xLTtZkbgvw8
         e8reoX7dHbS353QNH42UMZFjISfM7fF86q8rMB99vmkHBigGccZ23gGdjj07UCrZjf3g
         Vkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917779; x=1728522579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6glK4NDrMW7vjE/uQ8C6t2Gz6WRbmlvZPiLtlyywTWA=;
        b=MM/qvtmPmsKMu02EBrppX9CWUHiQ+gVVtYyUqkPikJCMUrF5s4BFrx3mH8nOxuhOJe
         nQGTGAIJ48Ef2OPg7nnIjJ7n8atprIi61snHxy5al5NepT1Tyk665UsCtx5aIF2MwWCR
         9TNBSnvbsktsjO5ybysfmA6ngNcA3Asg/PC5O+AdAYfCxabLU9KmWMuxbL9JPtSrnvGD
         C/D4ABe95lDLW3Pz8YCqVbkgNNZVf5zYurzodIlzNqIw7ThV9BxuxiiNPjDSktC1lT00
         2OLvZGyZCZJhZJrfYcjhuCQzK+czVYLTv+0eZ4eYri5b+26KuxLsmBfYOx9DJVsdg750
         nAkQ==
X-Gm-Message-State: AOJu0YzfOnxS5wxB6O7X/O+dc7L2vFhely1mG9igMgPcXzrR1pR/BDhM
	Dn97+c3fV4TZVIth3dmMe+/gk6DnFyLExxI2rfjfPMn/CmbuW569SXddGZYcjwM=
X-Google-Smtp-Source: AGHT+IG3hgHWvhRY6BrbS+c+L5x2Ma7meppZMEH5anDvJLhhRmspLg2F9GvS9W7UzQa1rGAxJN8hmA==
X-Received: by 2002:a05:6902:2b0e:b0:e25:d492:d096 with SMTP id 3f1490d57ef6-e26384193cemr5108329276.38.1727917779015;
        Wed, 02 Oct 2024 18:09:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885eb2368sm52217276.45.2024.10.02.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:09:38 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:09:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] Documentation: mention the amlog in
 howto/maintain-git.txt
Message-ID: <Zv3u0bx0QqG6q2A2@nand.local>
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
 <5cc8e2bcb88424d8dce526f518282e4b26a1760a.1727881364.git.me@ttaylorr.com>
 <xmqq8qv6l226.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qv6l226.fsf@gitster.g>

On Wed, Oct 02, 2024 at 12:47:29PM -0700, Junio C Hamano wrote:
> Other than that, nicely done.

All very fair suggestions. A v3 is on its way...

Thanks,
Taylor
