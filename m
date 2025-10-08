Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3882571B9
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956292; cv=none; b=H2I70CnV3Mj2EciQzXZRuqjT/7j8dtRT3S02ilDLGHpomuH6eATygQp280tiuUV+crJmmp+Jp3L191nOWgwPrseBm5/ufvZ1h83cKU2KtYxuG5UP68AHHAqw18t1ipJa2a5Om8h5oXmokSI5qMdtTtYuE7ePdDnsWI2XIp5M7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956292; c=relaxed/simple;
	bh=BCJvGKTOveXKuE2lp1LO8W+XcQZcmcELl7JwWAnXHhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyuA1pBQCyT/g5s7QO2zoVohfBsbmIrnb363P3VA7amwTFq5BmyGJt5tvF+Wwu+1qGiqJap7P9o3i0zshef/bgNz553LIwOAjGETZ1MthyY3IsQfFfq45rCSL96TAuFkyoO5wulmjhFnYuyGBzsXaSYishgDYH5urjOhfo7ViuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jsD7jWbT; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jsD7jWbT"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4291359714eso2389745ab.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759956289; x=1760561089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCJvGKTOveXKuE2lp1LO8W+XcQZcmcELl7JwWAnXHhU=;
        b=jsD7jWbT5EZkMd4KkstK72Ls2+Jp9k2zP3RL8Ejfzhf2KOuNiu1Ezd+RtZiUhUIJ8y
         7VncWVFq4Vx6bzxQ4d9uAvf93W7HBHtmNeVd+KOUDI7qGaH3OKFXDEjX4EMZerd9ELQh
         dSZafoJprY8ml1CmeqKo1h68E7xIULy4TQzKu0OS1ouQqDA/Ihgh9VYlGv7CFnEeC5mm
         rVKdGFR7mcYflaQZolsEwqzTLG6LEmey3UdwTzVr+QLB8uoIJhmxcTYds+YFAi9kgL+e
         pKTCNFSAOi/TgbC4J9gZl82CiXaGYDMzrz4xkT1JjKEXaasG3JhsflBFBUNg249Z26lD
         8cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956289; x=1760561089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCJvGKTOveXKuE2lp1LO8W+XcQZcmcELl7JwWAnXHhU=;
        b=RbLQvhdx5FbuOXN9+Z+RwEiC/LyLKPuA1+xn8rWCoxjYEho2OBuddAUXs5lZgJE6jH
         xw2PW1t0j6KRZaeXonMqqosrkSk26FyfPEiyki6SGe6oSb9rbQGLR8jLwdmMSckeBLaq
         VTRKDTFUmwzkaBQAU76Xy6DI+G9e4eFlJ4rW4MFF7fWSCtScHxWcsct5EQdukn+Rs5Tk
         NILHUcqptYKv4EU5sd1bNzFjU6+sQ0AkTLqnPecHQ001NVi2EZgznCfRzH9PHw0+KoQr
         faxjA6H31lW/bHM1W1J+vlowWf/Y5pvU4XZcKMaiYzE1XU9ubMyjVlVRIm6tdFG4flK4
         C77g==
X-Gm-Message-State: AOJu0YztpXyYm3s2PT7cKEn9HsKjIbMe+qstsLM3VDzZSWpFOzFaXUVp
	MqJC0dK+icn8UT7QtM8+g/fyMOty1nd4U4454KSR88/P3IdnZAXHaLwYw9eeaDf9NXWHfQmcSer
	D+9ujQ1bDfA==
X-Gm-Gg: ASbGncvG6cz+6Puhetl/tETdLi4Sl2Mrdjseu0ZPDKozJIGV8ChxduEWjwIvVMwZska
	6eP8uONY9ZCZOy9FS69Raxzocw3bkA5KfrJFBd79mHNpZPJNoG5M8KvN3LRImI60qrZMJHI0cQ2
	EXhmO2N7KzA0RuzvdyIgbvnwUD4cMd92gzIUdNwTh5Nc3Hiy0G3T/Qgr7aB7JY6y6kynEsvC37o
	jSV6iJ6SmU1efNVxDwra11HK7d7UHUuS+E4wrvCUS6Q0e975goy/yv0z7k/o5wzlqITMR269H5B
	SZH0VwdLuJ3SqXka++Zu6OiRU3pJRC6YHwSDh/GP8PDRPhuGqBYBMflwiZR9s//f5wQ9gJXJfQx
	vQ3mCsGkpLB5wX8Ey3mehTUpxvHdlbuARrngliE4gsZAVwdvVcpz4XoG0memZCMbel2561WutLj
	sTPqXaC33R+XsCJ2LK323g/dWj8ADp9AATjwnULtol+sSxqXhUkQ==
X-Google-Smtp-Source: AGHT+IFRqYKRgpUMoiIZh9GBW9WFQTyPAh8WdXfoy80BhecU9OdO90jGKMWbLzs9MtTl9axYZoEOpw==
X-Received: by 2002:a05:6e02:1a88:b0:42d:86cc:1bd2 with SMTP id e9e14a558f8ab-42f87410bd5mr43458275ab.32.1759956289010;
        Wed, 08 Oct 2025 13:44:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42f9025d928sm2969175ab.8.2025.10.08.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:44:48 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:44:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] packfile: drop `packfile_store_get_packs()`
Message-ID: <aObNP9yyOoNYPYtQ@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-4-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-4-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:10PM +0200, Patrick Steinhardt wrote:
> In the preceding commits we have removed all remaining callers of
> `packfile_store_get_packs()`, the function is thus unused now. Remove
> it.

Woohoo!

Thanks for tackling these one at a time. I agree with your reasoning in
the commits leading up to this point, but it was very helpful to see
plainly that each step was safe to perform.

Thanks,
Taylor
