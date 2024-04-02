Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E915A4B4
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080201; cv=none; b=tLRf/SScnYWPRUfKnNVO+NF0tcGYK38oCXtX6o1t+VXUan40llH4gZ0ajXQe1IApwlQzU9b8At4tJzy1u568sTCbaXSa2Q/ATjbapeDPIHHYRnUwzB1l6kpVr1XtgA59OEkg1wLnIoa82QqxYypbmw8igMkbdbHDNFX2BVcLJBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080201; c=relaxed/simple;
	bh=Bmg94ax/j+G237c47YLTsD4nyGg9aA7u0ZZPv0knyvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5jinhk4lU7ep2nz1Hf8ekWjUvYU4xrRxuSaEUjKJB2xPDN65iNaurU2kzyxe/VIt7aULraNv8Lt0JNNuK9C2Vb+Gb308k7bdzGI8KxTnxGSTd/9xSqaWcuCxB1Sx+ifvFxSB8pf0l8FmliV9/9PzrrjYFReHNIzwywdeu5/f+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gf1LD7/K; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf1LD7/K"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22e822483a4so320197fac.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080199; x=1712684999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fLksPOODVdnmYbfYbP68lU6fNh7PcD2+RtzKzfpA/0=;
        b=Gf1LD7/KhsYoBkhbTQiMqvY4/XAnTtex0S61cs6KbD7D6thXKruZL4pwRecvP8xpAq
         NrRJrAmFbO9nNfs+2pRG1K+w1J1/EenDBaXyDWVhjGYbNipZitufyAopelbddvXqY2Zj
         XHsaAL+EYXFBcT1QHPDO18I3KAWkrbnZrQu0/LBWMFEJbLcriTVQxDPguOZB45bdGAk5
         HyazEjDnF8aEa1yLKe+9gJ62NrMKlgrfzsXiHA8BTXfe0i+fp/UEtAPq5GXviQTZaPWV
         ojs/ofAzlFlUgjGhrjveOm/rlN+znBNJ1I4KMMNSdumKRTsCWuZX75y5jx6I1ww6JMZY
         Y++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080199; x=1712684999;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fLksPOODVdnmYbfYbP68lU6fNh7PcD2+RtzKzfpA/0=;
        b=JOR9Lku0L4xaoiK58iuTaAAL2ims93HJmU7wUzj0onDY8mIGsLqzyBntEz6+lWnVSp
         N2fb3PlK8NqZClATSGgxSk71mMTYJiClTOF1DsYtIGyqI+CbQXSWOe8y0qgnJTZkdcPd
         cRYr4+XqIXaX46Xq5yo8pmhe20FE7JSbLsa0jz+DlXxf4m204iWVShAkTsT4aY0PXhE2
         0YgfrCarCguNcA+VpDhy53JG7QJNYO2hM+33b5klR49Ok20CscbPxpkamqMkKlPusDBA
         FrcMAEGniSM1M6iVlLzgkyyzFlhGlXgOFE7v56lXqyNtfhsC/M3+e3+4AlRzgXAs1RF/
         q3Ew==
X-Gm-Message-State: AOJu0YwHmGbmHEGCO5zQ7T03GHZ62+edGjxAnKTAGGRdHGnLn8/BmBsv
	wFFZJWtFklZq9qUadQD4X3zgklrgLQltPdxr4Uc/VTF2gYpS3est
X-Google-Smtp-Source: AGHT+IGFn2JRXdbqkuIUah/F8HH17P80aOA0swDhNj0qhJs7eF+uWMAoOIrSy/Ilgr5i1r82gFsd0g==
X-Received: by 2002:a05:6870:5314:b0:22a:a167:50fe with SMTP id j20-20020a056870531400b0022aa16750femr15449250oan.3.1712080199378;
        Tue, 02 Apr 2024 10:49:59 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id mp5-20020a056871328500b0022e866c64f5sm181103oac.31.2024.04.02.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:49:59 -0700 (PDT)
Date: Tue, 2 Apr 2024 12:49:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] reftable: improvements for the `binsearch()`
 mechanism
Message-ID: <owpd2yaxorwbbaurra2zra6zrd2qgshdiubnkgzqouzkqd3xgq@s7a6wchg4xnn>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>

On 24/04/02 07:24PM, Patrick Steinhardt wrote:
> Hi,
> 
> this is the third version of my patch series that refactors the
> `binsearch()` mechanism in the reftable library. There's only a single
> change compared to v2, namely a rename of some arguments when calling
> `refname_needle_lesseq()`.
> 
> Thanks!
> 
> Patrick
> 
...

Thanks Patrick! This version looks good to me :)

-Justin
