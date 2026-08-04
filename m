Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DC3E5A20
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867926; cv=none; b=Z2IUZawhc5p0oNoeyGcVNPU4DxvJUAW0NV1rCdmIVLMg+oObgkRH7QMH8FxiEHORt/naG0UnlDRLK7tNNM2bQZxsWDjRAi05xoNqKqndMaDIWJnRI77beIaSEoo7LN1DExGCQ9NuWAlLAn5aSSx2wADWeCYIcm3XZ8MqI7USqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867926; c=relaxed/simple;
	bh=1N018y6wiEzVyLiicngX1XA/WRDE2XihvgGO4OiNuEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoBs8/7s/8NoTeK4RkwdNbAy0OMRi811N8YCT6DXrTrmCGAXglStFcDiAG3NOxu7x/10cb1W966+06Q2gV5bpPdaTgHTkgMbpHBLWVNOSQP3y/VlXwzfA/RJ06o1oBp1VANVbC3AY5hE4WaXVUaUawN7sEzwz+B8UF8e5sVPMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Z6etIv; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Z6etIv"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af81963f35so80641b6e.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 11:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785867923; x=1786472723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1N018y6wiEzVyLiicngX1XA/WRDE2XihvgGO4OiNuEM=;
        b=J7Z6etIvcydUm5WCUyjkhaw0yHh8qR4lbgC2XySl+2nP75cds1qCHsv3+PtC+35u7X
         50C0z/IxAE+Cp842SnLgWvw7MvU+REsiYShI17W//p/l5wz/bg2c1hrbE/mZaKlsWbOd
         fZu7BBoEsqiaQyUy/lszyGZMbX5SjRR4Ug1kRt701cvKCQOkozCZH0Ksd9MhsBzCvar3
         yBDa9K5Eqs6TloUVUtoTuT0tPEPBWIwc6Yq2m2ORpH7WzbGnrvtXE3JH5J9FM0q7wxru
         QmpwAX42IfOvyZt+Jy8fxr4dwx70AMKKANKu+LE3Jr9zpMsRUROYa2A47nfcnaXVx3u5
         YOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867923; x=1786472723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1N018y6wiEzVyLiicngX1XA/WRDE2XihvgGO4OiNuEM=;
        b=RLSVVuK+tKH7k38VkYlmEC4mrPTIMBxXA09K/9CNxqw+nuCj20SCE1619FRRnWqTUE
         6oVR+IFE/1Sgcxn4mPYfC24eZPCZ3ahGOILzS3FaQablhE3KLR271b8RCNYhl6pM1Psc
         LJtgAij3PRBNE1OQjJS5HbuZl/px+Crao0wQE3G1Mi0WDDDzNcC3qTuPqGh6b97qb+3C
         9NJ8U4V8GsV//sfmcoxgfexC7lGWq7dhzUS7KPz2h7eoiIeYZw2sLJhFz3tCh8908xVu
         EeI+lCQOgrMc/B2d6UJRWwQnDQDLVNqnnEF+xIirSqr6HwhT0y6d4Ms5iMPbDk051zSp
         JAlQ==
X-Gm-Message-State: AOJu0YwtmZMEIxUl4P8udb0DzppOcTm+S2BjDg91SAUvl4R+pt28jcGK
	4vVMPYbZZe1Y6PF5Vc/qNTpWIHcDWuVs+ICaYShKfZofnYAOAmS3NAoDYlu9GA==
X-Gm-Gg: AR+sD12p69omM5bw3vbUG4ICIz0CuHPHJqc6s9BaU6lCQU823k/3Rub/Bsgb+t+AdnE
	DOw+H5ECe0FRoWEfSwETn7XLNsg2vZuE+jG18rFsJTKL4/UzRFdNfBfaS6oWPiMFYYYAlkkTBRB
	BfNvqkhyG8HAAlXOoxcCsBjP3pWjcJGcs+5vqeA6I9yXJPVi14lFqF7UuTLuzn4g5WE/UO5y7LN
	50zIJY06WqM6pN4hNhGXLPDv4dVUlI4hpuhJZ28GNrMIWY6aCaKTPRdwQe/sISm83YCAFWqTkzi
	M0gV/Lq4KyQ2+CXTG7zYj05eJMjdu+V0QzFodgkIjaDjcyc7u7FaUVGUtjMmH0jbUoAIV+40nJa
	/pzeYpEA/1/SUaemvNGT4NRpmpA/VCykpfv3Tiji2QCX5yS9S8U/PPacKVNJ6lSUeyT1z9i2rVZ
	0h2XClLz3xBuGd71eO24PT4sDzAgJJrIvGKAj0Ndzy44cw8flHT6LNEA==
X-Received: by 2002:a05:6808:c3ea:b0:495:fb79:7712 with SMTP id 5614622812f47-4afadbf49c1mr425037b6e.0.1785867922998;
        Tue, 04 Aug 2026 11:25:22 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae75db20sm102733b6e.14.2026.08.04.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:25:22 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:25:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] odb/streaming: rename `struct read_object_fd_data`
Message-ID: <anIuT6GFJ8st-cF4@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-6-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-6-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> With the preceding refactorings the `struct read_object_fd_data` is now
> somewhat misnamed, as it doesn't only contain the data anymore, but also
> the stream itself. Rename the structure to `struct fd_stream` to better
> match the new structure.

Ah ok, this addresses one of my comments in the last patch. The renames
here all look good.

-Justin
