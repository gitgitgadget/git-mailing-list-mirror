Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC813C69B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715206; cv=none; b=Ico4NVRLLftj1V9/DFkyq6JjF81FMdzwPg0sIPGfwIwIFqmQ5XKWIowW50gLbIzIG1hgjqfVNeDhsAX9Zp0ZvjRk752a6aoypFL1mDWzmNxtfkcpXnYEY1OLscdU73tp8dbvmXhE14wlyMol+0n3FUuvaLi/6MBoQWkS2yzEkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715206; c=relaxed/simple;
	bh=qWr6d+UZphdHc6HXFju3OvoAuQErbaMH4TQeQD/3LhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P//pN4FzrFsj1xU7atf29XDEte3b4MPBU28Cu0d+vZAKjyna6XCElSWEkSu1NSGmE6/Soc/ij5Dd3Sif4UuOK2WI6KwDovhmTzvlt9mU2xKF19KAWmFLx6k4W04A6eDuY48tZM2oknLbpPD4JpU6YqqWI8144/WoF1Pr1I1+9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=acVt5uGL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="acVt5uGL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79535efc9d8so68634085a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715204; x=1718320004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWr6d+UZphdHc6HXFju3OvoAuQErbaMH4TQeQD/3LhE=;
        b=acVt5uGLTT83XiG0HG629wLdAqlMeSO2PTRVwv9g/tWd109dh20/Xozoj06mOic1mF
         m/l/zwQbZZZTUOmAoD9xP/GHjljkAq59avT1zvt4Dw3zAIeQu/Xbsr7/LEWr5zxNVx0c
         qSO0CvHIcnQfHTmgBiOeGPARpLJ0w+bgSinBU0fDfmv5DwiM3OUfpyGG9mKFJadRLHLk
         p604Mc8A6md7coE/frtl3TlMo4bumHfhFZj638d/wFz+69f4r0RZPNLWbrrMb6RmXzxr
         9NMayhbEe7RLKHxMKdvSaxmKD+Qo+WKhToECEqyrvexsWFQTm1+aGmko5rri8UkLtciF
         ENpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715204; x=1718320004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWr6d+UZphdHc6HXFju3OvoAuQErbaMH4TQeQD/3LhE=;
        b=NW8XGeSMsGSevlUpbe7DURPHutbskLJSAxH0TZcYDzwnQMpJO5Z82LPijsUp4Uw/QM
         /gw1vPos+CrndQXvKevK+w98pFtp5RSmpz9xIbWUDz+NaDSGZ8L8q3i3U86QqqL2Ir8R
         eMy3DM+AFnzw9dhfEgPId+sK/IUneUhYvRuBaHuY3NNhprUCKeyqerEhvGwIbtl3E2fJ
         /UgnHL22dvn4b735iLYvsDw1jQEU0gfnaXLR50wN38CEJVMYX1p4zAdo/ILIargAVNP9
         xp8ITqIvL9umxUdiI8MUN3X++kF559l5/k/+tcnCEw9H6i1ef5NoYapOz6npyz/yOyht
         bHFw==
X-Gm-Message-State: AOJu0YwGuQ/JC+ELFHY4/dM4DvcLYrBsKU1wTyv78pG6CrRRzEjICxY7
	c8MaMMLN9JQlBrQCpVActOqNzeLjDPBtdmDXYnOcC5S4RkJrkpGo6tj+OGNzPBqRFJG2JrY78fX
	NE9Y=
X-Google-Smtp-Source: AGHT+IHi2zPWpU3n24hlm4Tk50s3VSQau/Ba+hswvQgUdlecBZ8bZ45fTE4xBlOTXbaVwnLwb7sj3g==
X-Received: by 2002:a05:6214:5b86:b0:6ae:d2f1:d335 with SMTP id 6a1803df08f44-6b059b502a5mr12793616d6.13.1717715203639;
        Thu, 06 Jun 2024 16:06:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6245a7sm10627696d6.10.2024.06.06.16.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:06:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:06:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <ZmJBAjraBh6O/G1d@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

On Thu, Jun 06, 2024 at 07:04:22PM -0400, Taylor Blau wrote:
> This series implements incremental MIDXs, which allow for storing
> a MIDX across multiple layers, each with their own distinct set of
> packs.

I forgot to mention, this series is based off a merge with current
master and 'tb/midx-write-cleanup'.

The latter topic is marked to merge into 'master', but hasn't been
pushed out yet, hence the dependency on a merge with that and 'master'
instead of just 'master'.

Thanks,
Taylor
