Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5839AF0
	for <git@vger.kernel.org>; Sat,  4 May 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714844032; cv=none; b=XlDbTmeeFfhgeBuiWHaHu075NXhGBsh+hHQVxrFITlbzopptMcBYaOaHBQL7bYiEk3acegShVwsRee1FBi0foH/C4oq/wAtp5JiBiScjN0NZlrNSKMkSSivRKYXBpCvy83egkbA1QRJcxdM3IJODhrtnS9Sz3wGDBrjq+aptO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714844032; c=relaxed/simple;
	bh=KYQbnisNKjUsu9Ys7s3ZVZJupprvI0Wg/lfyPTpJQpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quS+OQR1wp7GQUh+KniMckIO6LO5UMSAp0Rxg8PqRhkNrNyRo5nQqnYWlFgkKn5wlyuGiw7s8lLUYisse06L+1qi8s6uceJ2ju9iYL/iiKVuDxZLHJSqhqlZi3npP77Cdyv87rbB7rL/p28/IGBf+QRUcldrfl4GVUaBCbohIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWKru2Uw; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWKru2Uw"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b205a3b3dcso52219eaf.1
        for <git@vger.kernel.org>; Sat, 04 May 2024 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714844030; x=1715448830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Umb68wZKI8B5jgpsbsEg0rEqGqWNIeuX7zoN6xeYfMc=;
        b=WWKru2Uw5uuUiY/w5pr1beVd2kuI0d4vKJFcbLUDFRUPcl1jNRxe+Pu5uMu4/0v8hL
         8GPlByQqTEcvX/ZrBrJ/XZD/YYtKokedtSk1L52wFjlFSMOpzH2HVeg3A7U17mDmHBb9
         cbYhaBBbhX2rrvjNCceCk9HuT5V6g9O5dIH8kBaZhCHW5/aS689vQvqMwhkuiZ6XYLPj
         2diifSs7oDX5KWFTpH1rR/h5CCKWbkXie+CVFujbxRRha/QN7jVT2qy90nE5o+xMaRpy
         5pS/a31RiwEYaOSZx1FDvBtbio/F4vajSAvXKPaYVvtVzWvcxjS/nMwXANmhzA0tIfx5
         S2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714844030; x=1715448830;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umb68wZKI8B5jgpsbsEg0rEqGqWNIeuX7zoN6xeYfMc=;
        b=kowmmKcyOARL3ZaRwhYquB2s/pPaxLrXh9ACW45C0AixGIMsyenWbz4yhWZL1anQrE
         v6mtxf+kFZdSi0xk1S6NjMSFBZVZy6Kiaq6/LMCpj5ikAmbfRhK4OhDdORYF67NQpasQ
         GnLA5rz3ACIHwr4yP17VWbhTRStdI+PsKIudIBNCyEFVT/7lEoDCogkA9894QsSsF5VD
         7HfMpJ7QmkSA+pZ+pGzRT2KWrXvfXzG5fotKJetFW0EbZzbypoDv0Pqz2ylrBWGPNza+
         fvbgPjFDidru+u1QZJe4W+/5b2EgYkgWHMe4z6vh78uXLsr0EDe5DQdLG9UMzE2HvUId
         F+0A==
X-Gm-Message-State: AOJu0Yw7HLN1rB0iMCEJ3fWqRH9b+bjspzfXS+FBHiyrBFAFI9u+JhEG
	At4+dq5XRCNlrL0f72gInhQDLjJdskTiynv+OaDSukKsL3YSTIEF
X-Google-Smtp-Source: AGHT+IGUiaSiudqaCEbiyujZBhXCg3XDPOEZCnUQqP3iDUCkFtn7R18SroEGEdhkAqLViKkc+wXpxQ==
X-Received: by 2002:a4a:902:0:b0:5aa:62e6:656f with SMTP id 2-20020a4a0902000000b005aa62e6656fmr6473466ooa.6.1714844030410;
        Sat, 04 May 2024 10:33:50 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id bp5-20020a056820198500b005a13ead482bsm1197005oob.12.2024.05.04.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:33:49 -0700 (PDT)
Date: Sat, 4 May 2024 12:32:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 00/13] t: exercise Git/JGit reftable compatibility
Message-ID: <enfz4bzeg5m3odkbhrzwjfgah3cd5fl333rgos3sz3aju33y4y@do3yczu7a6hc>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Toon Claes <toon@iotcl.com>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712896868.git.ps@pks.im>
 <x7v4d4siixs3wllzycibxtgsqipnwohhyxg72zvcxboucshd2t@won3yobvixbu>
 <ZjUxY7kqgy-iLIzG@ncase>
 <ZjUzjhN78lqYtXqT@ncase>
 <2hhwttin6gvs2munwpl2zhnm2573bm5vklbk6mcwxbgc7z5sog@3dygnrnnnpna>
 <ZjU_1PJnvmGhtckO@ncase>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjU_1PJnvmGhtckO@ncase>

On 24/05/03 09:49PM, Patrick Steinhardt wrote:
> On Fri, May 03, 2024 at 02:35:46PM -0500, Justin Tobler wrote:
> > On 24/05/03 08:57PM, Patrick Steinhardt wrote:
> > > On Fri, May 03, 2024 at 08:48:03PM +0200, Patrick Steinhardt wrote:
> > > > On Fri, May 03, 2024 at 01:42:32PM -0500, Justin Tobler wrote:
> > > > > On 24/04/12 06:43AM, Patrick Steinhardt wrote:
> [snip]
> > > Maybe we should do something like below patch. Basically, we start to
> > > acknowledge the fact that Python 2 is end of life and always use Python
> > > 3 on ubuntu:latest. We might go even further than that and only use
> > > Python 2 on ubuntu:20.04 and slowly phase out support for it.
> > > 
> > > diff --git a/ci/lib.sh b/ci/lib.sh
> > > index 473a2d0348..3967a5af85 100755
> > > --- a/ci/lib.sh
> > > +++ b/ci/lib.sh
> > > @@ -325,11 +325,18 @@ ubuntu-*)
> > >  		break
> > >  	fi
> > >  
> > > -	PYTHON_PACKAGE=python2
> > > -	if test "$jobname" = linux-gcc
> > > -	then
> > > +	case "$distro" in
> > > +	ubuntu-latest)
> > >  		PYTHON_PACKAGE=python3
> > > -	fi
> > > +		;;
> > > +	*)
> > > +		PYTHON_PACKAGE=python2
> > > +		if test "$jobname" = linux-gcc
> > > +		then
> > > +			PYTHON_PACKAGE=python3
> > > +		fi
> > > +		;;
> > > +	esac
> > >  	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
> > >  
> > >  	export GIT_TEST_HTTPD=true
> > 
> > This seems reasonable to me :)
> 
> Please feel free to adopt and adapt this fix. I probably shouldn't be
> reading mails at this time of the day in the first place :)

Thanks, I'll give it a go!

-Justin

