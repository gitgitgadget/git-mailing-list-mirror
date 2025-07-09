Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A3248F57
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097309; cv=none; b=uwVvUuop88kL2Izsl6AxhHc6ZSWLPFgh3tXCUKLsjbhLMor0e/lYgRf9n3+Me//+/ipGVxhYb56bhzzt0noXM3H/K0WTmm5b6ySNY8uybOnPk68klFHo2TX21pR2ujIx48pS1VgYFM32Y6yVS9LCc4bc75drgHcWPH+eQaqVFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097309; c=relaxed/simple;
	bh=giFuxEMuPmsdO5n09SENU0w2VD6ENPINQ6fNn/sNbNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX3+QrT1qWz1uRzFDkAyzlU8c6aWDBlhODKNGiQLF+jKVnLVDcG1RBRlR+QdNwYlh/AhAz77snr3icPfSnqF6snff09TnHJZzfgXYyBNyJo6oF01bDbyPmf7PAcE1RipoJVx+JD8Atj7Cnohp9nIg6XiAmS3fCT9xIl8GUp8s9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBu4dasy; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBu4dasy"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60d666804ebso741617eaf.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752097307; x=1752702107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9x9kn4E+65eAn8ZfRem4QVx8ofT/7hiR5HR5ntWFYs=;
        b=EBu4dasy1VqxOGYhwbHTOnZJooG1c9YHkwXRZ1gGMkuePdERWvwDkeWUP0thi/wnsi
         02m54ke+2bw45M8B/0PkfC4W1FZJG6oBPEzelhjGLiV4fttRT3/7A23Gq6Wd+CY/QhEP
         2izQXs+fn9A+bvUbWsJPp600oS+SA91w9U/d13JTgIRD0aCCVEZKWafXfONSHMKOGS8D
         NGJwyJ6klaVRP/DlXuVU9RPftsujBYyW1tH2oxbBImhvcn4XR58urmIlgj5/k3BjpiIh
         HL38MmjtV5AXOP98WkUQnJfQw1NP0vWnFR2YBva13Asq8HTOD+qtfq0qLgAx8nF8/iYZ
         qxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097307; x=1752702107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9x9kn4E+65eAn8ZfRem4QVx8ofT/7hiR5HR5ntWFYs=;
        b=pOll8+fHxpsQjwXHGztx7vZ3E8CrH9ZY0VNpfzS1Cs2mxzgWztRT6BteEy9pqOok93
         p+uyzk3TMhTwaqrzK11+7+CxXp+zG1uyiH21RCvyn5eWK5qWjC5FmGRvGNgWK0CfG+Gl
         wWO7akAswLG9+JscyZaUhyCYLjRnhowFaiVab8d5PdiUTa7luou3AYMk+a5W8cKW0l02
         m6UT1DWqEgrebpPxfVhh5gn05smUstRc/6oZz5hGOR4/cZgw6Jcg0TlQI76jUUoLw/sz
         nyOEuG46pX7YgpX6bJdL9is91fakqkPjYmFYJggUyMRderB9ZtVpaaY8oL6YXEa9EvHn
         qp/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnk1HJmtpc2ZPPh1cBiUNcmOsJL6zQ6Ft+0cY+WeX/IFHpFhGMQ2AaWeq/YXzoziGtVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIR+5FoMacAOZgTfmK0UjT/mnf3Xb/W4JzqxTpk6o7Xd/MtYW
	wnXtx7R4Gov3H3JzsgdFFW9qhMSeN98vgWmvvC4lkdCDQNIl8M7+6b5hHg4lu52N
X-Gm-Gg: ASbGncsJQrJZV7mvgoZIyzs7WTP30C17gJ4TAW4JtA52vFbXqGP+ZrjCBiIAGVXY3LV
	x/FEuVHz8olwB5Df+IZNsTmJFSEGrp+pUmF8AqpFc+QIh4PDc+ti7+3L7kO97uvCzhCrqCMO64n
	dWMtQ7i3ocmoPcQOlOVBJPrto7LKp6qQxA1zkNWeA6KUwnjD5hIpGurPv1OoaZhfUlAisrG2kph
	s1/WNFlVDtFpK4C7mIm+vld8NRyUfAx4Tz0MLpgD0+mmuqXYdC+x+z5uGiQ2TeeFr2bX5sOuF//
	qCVTySVd50Puf4EuQthziT+evmqp1IAE9aaHQ6O/yAGsLbjPxpSbTpQ=
X-Google-Smtp-Source: AGHT+IE0dW6KCllyCaXtzqyLq+fQrfBFjkH0/LcBBYRXLb6JzGAa/0XXRzrimA0xGCsLuGKbsW+1CA==
X-Received: by 2002:a05:6870:c48:b0:2ea:1e58:7a69 with SMTP id 586e51a60fabf-2ff0c7b7825mr981533fac.15.1752097306937;
        Wed, 09 Jul 2025 14:41:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff11259495sm28011fac.17.2025.07.09.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 14:41:46 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:36:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/8] meson: stop discovering native version of Python
Message-ID: <mku4cmu4tgib637ptpile5nch72cr55565o6oyaxjklc756j4c@63zony3qdzio>
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
 <20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
 <xmqqikk1pfiz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikk1pfiz.fsf@gitster.g>

On 25/07/09 08:09AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > -python = import('python').find_installation('python3', required: get_option('python'))
> > -target_python = find_program('python3', native: false, required: python.found())
> > -if python.found()
> > +# Python is not used for our build system, but exclusively for git-p4.
> > +# Consequently we only need to determine whether Python is available for the
> > +# build target.
> > +target_python = find_program('python3', native: false, required: get_option('python'))
> > +if target_python.found()
> >    build_options_config.set('NO_PYTHON', '')
> >  else
> >    libgit_c_args += '-DNO_PYTHON'
> 
> We ask explicitly for Python 3 here.
> 
> Does find_program() have some magic to deal with installations where
> Python3 is simply called /usr/bin/python (and worse yet, not as a
> symbolic link to /usr/bin/python3)?

My understanding is that find_program() won't do anything in this case.
I would imagine if the target host has Python3 in a non-standard
location, there would probably need to be a cross-file that defines it.

> I found
> 
>     "Since 0.50.0 if the "python3" program is requested and it is
>     not found in the system, Meson will return its current
>     interpreter",
> 
> which I suspect refers to the path to python3 used during the build
> and is not what we want, at
> 
> https://mesonbuild.com/Reference-manual_functions.html#find_program
> 
> which got me a bit worried.

As you mentioned, I think this is only relevant for Python scipts
executed at build time.

-Justin
