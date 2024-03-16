Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0A1847
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710553888; cv=none; b=ElcynvDJHDMiSrH3oDreYVqK1KHI+f21J3IdolnNwwR5psf+bXQug0x2HAYw6cwRDIO9Py1gOgR7REYMDm0jp08JUwY1lk3oHgfWGr0Ahz8TtqQGUJ3u6cNJlzdqDngXwqnnU1EB3HpzXmqOJxpPg/lRqOMWvnMshrt2m3sXJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710553888; c=relaxed/simple;
	bh=igyHrTWfjf1yXTdhEz+s2QeMYOYXh2FK1yxlgPoqrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY6jGydC4VkxcR/WM9qRSQHVKd1NC7CVHThwCk9Hwvv60a+viiGupWSurP4JViobgosDHJH6+MoW4qVIvzXaYVtTlHRW0/nqWZWVEGH5rdsX/yIyw1t2BT6lgdSXh/CTdbEAzKbYsyQpFoViqtOBoSVByD3Mfs05ahMTRt4abgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ijh4DyyO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ijh4DyyO"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-690d75c73f4so16728356d6.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710553885; x=1711158685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igyHrTWfjf1yXTdhEz+s2QeMYOYXh2FK1yxlgPoqrYI=;
        b=ijh4DyyOd7uMEtKI4Rt1XPZWA6pULrk1x6By/6DDMItm69/2sZXgBa5cHKRDKIx0Gx
         nHFAXAJZn7ZV+NhDwmGA6/Zuuv7cz/WqCiKPQu9pOyqvntI1pJAM9NIUVMStVYnR3va1
         iCdlccChoIrQMhhmr1TZvNSRgGU603slzwuJ+/dBOQ6nwsDsJkM6Dwm+HRe08cjRv51Q
         d13KBoHikPhXd/nRJSGT7RLqzxE0tRIcJOuy0Bi4HcHwgSrXH7Xni6NLpupXDbLPxB8O
         0zo8Y34aZ2SqoDUOdmS+Qhp+8FnmoW9IgQVTMZEZZcKEZXx7zMe5nPYMee8/tRhDRVMG
         YAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710553885; x=1711158685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igyHrTWfjf1yXTdhEz+s2QeMYOYXh2FK1yxlgPoqrYI=;
        b=BdIsZHanWcFVo+AT+tZynSY9XOLqrBjYvhAPMVa3aY8KQlvjITp76hTUXSAzL3QE65
         jXtYz9WMpLg3a9sMJJ8ZluNPW53qEV4isLNuuY4qDWyPDQc7fenROoFGwz3SxSTjgxF5
         2rWmRSN8k2yYsQnoNLCKffpkk1QFsTXMZlDZZtzYZI6hnwwXQ4qgGm7QogdgoGf0c67c
         4FDnp2WsljqpKy2nDPJ1hgTGE3Y3KUXLclmcDZK+0AE4IfkbKaKUpPj03ta5FOH27Gxi
         HT8y5Kn+Hp0HPxJtxwdVl+QLjgpzNTcwMqJ7v78JOeo6F93NDDinwRAbzje3mIvCpAwk
         vZlw==
X-Gm-Message-State: AOJu0YzlPVSTdmoHi48cFMCHnwg1ptGI6M9+lkBdd9ugLJw1HuupjwSo
	3skah5fOK3J8UkoSMYvATNe5kdZYc9O/7nTyxbkXScNb8B3d78HNYyQjASXJSaY=
X-Google-Smtp-Source: AGHT+IGHNuQ+CTH3wVI+wsQzdLRMRKhtBwRUQoP2PasLPuTXcVls1+qgIbm24pfhYgt1Ab73upV/9Q==
X-Received: by 2002:a05:6214:b91:b0:690:b65c:766c with SMTP id fe17-20020a0562140b9100b00690b65c766cmr5588770qvb.55.1710553885500;
        Fri, 15 Mar 2024 18:51:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m9-20020ad45dc9000000b00691152606b6sm2592042qvh.46.2024.03.15.18.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:51:25 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:51:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Elijah Newren <newren@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/22] avoid redundant pipelines
Message-ID: <ZfT7HHZ9Uchvp6Ao@nand.local>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>

On Fri, Mar 15, 2024 at 08:45:57PM +0100, Beat Bolli wrote:
> As follow-up to [1], here's a series that eliminates redundant
> pipelines, mostly under t/.
>
> --
> 2.44.0

I read through both rounds of this series thoroughly and everything
looks all good to me. I left a couple of minor notes throughout that you
might consider changing, but I think that neither merit a reroll.

I'd be happy to see this series move forward as-is. Thanks for working
on this!

Thanks,
Taylor
