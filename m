Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B1A29BDA2
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234550; cv=none; b=mSIwzWVmgxZfHysSMcIbb5ojHhhlsV2ldxOuXuOTnECnXGumkVhG8IR8xlsKBa7+0Som6c9v6uYBlSISEwMF/dCNoAPowsY4G3zF21qEd2O5dSt+yhFXcYoeDMFumP4RdsJ0A2b7q6jzUv/7zxQ7zx6RrXYTzGuqCJsZZALteIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234550; c=relaxed/simple;
	bh=KY5EhgQdV4JTf1KtRLhaJGHlLIkJH4UNOe0khqhPXXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSa/YOxrgNNgEMl4Hw95XN1C3JZdYkIflGuZzgQyzECfFfR4npQikuCIYZJj7bJ4jKIILCgQBQXu7+OtGqa0hvEiFNlb/XY8DPR09F2btA0SgYdxfZ83CvDl5sSdNaCV9d4a+3hLTFha5JmCd168vEwErrXCWv7+3HqJ/zS4EYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtxmBODR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtxmBODR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34abc7da414so3711878a91.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768234548; x=1768839348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fkZ/gz0RjWTuXixcwc8jedJo4LoEM7XK4oMFM93Hf4=;
        b=LtxmBODRe2sS7oYO8uymuP0GqwauKD0t9vvU8j7BomP/O9YTIDa2U+64578CmGFyDN
         Pwv/ee4PUmR28tq8Kn4A7h6VgQr7GP8I6iVNgElDW9X+DoHBw+iOV7zfyF/+q/XG08wB
         izKXZj5YCt1cj5sKd641zANnWr/VYcLPiw0AMspKM0TR0jSUHuP+2XuDxzBtHwZoORWV
         1EdtsvOb48t/L88AWdISypzvgCo6YZdl/VhLt8ddv+VrLUq74DOTBSBmrGhm6vVR1OxX
         KaNJGtpbSVt2sDNxHgak63hA3pKTiV0xIG4yxwG1MMjhcUlRnCYaXqHr4oOwvQexitpN
         rXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234548; x=1768839348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fkZ/gz0RjWTuXixcwc8jedJo4LoEM7XK4oMFM93Hf4=;
        b=e60/qO7KYcKDvkWNLWD9rniKGsdHDyQpki9iCmDOpwkVS/SkGWdZJ7hX1DWav7nK+n
         RL0vqKv4r5sweQvDY5qe9wfxCQZSncJL53TsRg5HmZoFNogpVm0TI8+VXQQop8AlTXqI
         r78ejGW5gi8jMjrzJ5bzM1/afTrIE1zfs0aFDw2SXDIKx3fL5oEjbR+vU0ZhxWwHrdty
         6fKmn/pRhVw9+Rck5oA99RX4JsOCYacZxV1pgQalwi6DnpYNTo/ZstIO7QHPrD9O8bZQ
         JWTpcPT1m4NdH0pwOtmrT7U1XDtYbYSZnfPuCcPIEvRW0cIjX9GWO+DilYovSjgWLhzY
         e9xA==
X-Gm-Message-State: AOJu0YzXPHaUU435aAkE2R6i5EFY+Wt0y+cOwMJ6zj+Banh8JBB99H+x
	tIZV8ShkrggoW2LIhkFbLmwmZAJAUOJ/l0R195LPpKPdfO21HztYZgatbg6tvw==
X-Gm-Gg: AY/fxX4BgvM6CbGOTyC+U9uSU/gbreOlPU/EvsRmH8Q18FjTBkgjBGQOOkX44YfG/gO
	WjIbEaWr4nxvKq3yPgj0eGRHqglrXztZ+wSzP7YGMe70w4kcYVF13GuD6CytMqbyI5fpj0m18Ix
	occ+YleDYJ9y/KKDRcNBlMOcAHWOZWQHJ496SVIy6LWNTVlaIxfSAlWg5aYdJQMwsNKSSOrz1CJ
	nkWMKGTdFkYrnVAePs0ZS69v1fp4WsX+emGCjbRaZyHFcMDgQtz8i33RFF6+//8IpOVbDDGk404
	d6ToJm0/5RzgwPb9rbO5lxLKYIupqdJYJBFu5lJwadL6QK/A0QXaekAfl+HogpJYclw5YKy7+eQ
	KcbTgzTfgtfXj9qBIt7PCEVzvdkEbTJsfZrwmQ3sMgLhVB3N5VQzUhJ5osTnrSEt/ZJC/HeG+zL
	KO/g1wCtMkFL9CNZtbOxDll7DupDVPkBM1CsKL6bTuVAaVmcO+MvHc6eo8
X-Google-Smtp-Source: AGHT+IH9MZRHUfXyXzQinv+WHp99CZzvVpxbXc/Ar9Cyf2yopsEJteB4LTeyJ89ifPhxR+ynQzOhjw==
X-Received: by 2002:a17:90b:2587:b0:340:c179:365a with SMTP id 98e67ed59e1d1-34f68a29d18mr15057225a91.0.1768234548459;
        Mon, 12 Jan 2026 08:15:48 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0d7esm17972739a91.16.2026.01.12.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:15:48 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH] doc: MyFirstContribution: fix missing dependencies and clarify build steps
Date: Mon, 12 Jan 2026 21:41:09 +0530
Message-ID: <20260112161538.351527-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqcy3eoq6e.fsf@gitster.g>
References: <xmqqcy3eoq6e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> > Fix several issues in the MyFirstContribution guide that can lead to
> > confusion or test failures when following the documented steps.
> >
> > * Add missing header includes in code examples (environment.h and
> > strbuf.h).
> >
> > *  correct manpage synopsis formatting to prevent failing documentation tests.
> 
> Two spaces???

Sorry, my bad. Will fix it in v2.

> >  Then, add the following bits to the function body:
> >  function body:
> >  
> > @@ -429,6 +430,7 @@ Add the following includes:
> >  ----
> >  #include "commit.h"
> >  #include "pretty.h"
> > +#include "strbuf.h"
> >  ----
> >  
> >  Then, add the following lines within your implementation of `cmd_psuh()` near
> > @@ -504,7 +506,7 @@ git-psuh - Delight users' typo with a shy horse
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git-psuh [<arg>...]'
> > +git psuh [<arg>...]
> 
> Removing "-" does make sense but did you really want to remove the
> quotes around the command?  If you are moving to the [synopsis]
> style from [verse] (*), it may make sense, but otherwise...?
> 
>     Side note: see de56e1d7 (Merge branch
>     'ja/doc-commit-markup-updates', 2025-01-29) for example.

Actually, I initially kept the quotes, but the test that checks consistency between
the manpage synopsis and the -h output was still failing. At that point, my intention
was to switch to the [synopsis] style, so I removed the quotes, but I missed updating
the markup from [verse] to [synopsis].
Will fix this as well in v2.

> >  NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
> > -installed.
> > +and `docbook-xsl` installed. See `INSTALL` for details.
> 
> I suspect this is highly distribution specific.  The asciidoc
> package is typically packaged to depend on or suggest the docbook
> toolchain including docbook-xsl, and if we start adding more "to
> help newbies", we'd face the problem of "where would we stop?".  For
> example, on Debian derived systems, the docbook-xsl package
> typicallly depends on the xml-core package---should we also list it?
> 
> I personally find that stopping at asciidoc and let the user deal
> with their platform convention to get asciidoc working, like the
> current documentation does, draws the line better than the above
> updated text.

I totally agree with the “where would we stop?” concern, that is also
why I intentionally avoided calling out Windows or any linux-distro
specific details elsewhere in the document.

My thinking here was that docbook-xsl felt more like a peer dependency
to asciidoc rather than a deeper, transitive one (like xml-core),
especially since it is explicitly mentioned in INSTALL doc.

An alternative could be to keep it less concrete and say something like

	“make sure you have the `asciidoc` installed along with the
	 required docbook toolchain. Refer INSTALL for details”

Please let me know what would be the appropriate approach with this.

Best,
Shreyansh
