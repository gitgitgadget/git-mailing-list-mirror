Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sze/S6qP"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B4D40
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:08:45 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-679dd3055faso6941256d6.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701371324; x=1701976124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMjX0HvhL3BqOSHwNG9xqmlO7y0MjcWK7xwSqWpDERY=;
        b=sze/S6qPvaiH9/zPUQptv5ZwZ7lAycS55tVMvqtO0v7B5rwL3x/xMc+lvqu8xelJrt
         1XRgjnj37cqVlIUvGm4ACNJjbbQFPqAzXKdKc9VclEdm8rofaCs4xeQ/6To2Ei7tuwVd
         sPRPEMpPivL6tpImAFvNomATeUtCb7rflPLTqFF7HESllfpw6lYBfhnVob0PdO3AJldT
         N8bNuzr9sVsXjkFQcigVBUFMyDQ40FpaqhZ5aJjkrC0XMb6sXw5AILtGdvsDaHIn+EJl
         S4IZL2IRwsE0rgPzfIYjfk1oIhxJb2DSDnuAq+LNwqjW5VfQf2luL2I0awUediUcZgU1
         WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371324; x=1701976124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMjX0HvhL3BqOSHwNG9xqmlO7y0MjcWK7xwSqWpDERY=;
        b=ZHwA3E/BYu023bIvoZK6M55ve1l+4EZ4hqc5hnJpB1s4g4udgc98OE8dT1CoMUS3PK
         Hh4KFvPcwpAIC8jWnDHnK4NAEntATNRB+I9YoTyGgFE59Rp5sC3SANtDpcqfBO172/cp
         o+gML0ZiSqZIX78doFYszVG02Y8dKdjdSqgo7At5pXY4EzMWjmTvP+ao2KWxNjVYyTxz
         N9Gjhd84n1WnTKibS0/o5pPLTL+JadTwn52MuOl1G010WRd+CcDl6P6hlAwvEEvHxsfR
         ngp6K9pOqNUSXqtoXACT2UOSTsv/wTU9xjg1yDoUsjW5LMp4+VDC+hzk7FIogdTSbA5H
         xbBg==
X-Gm-Message-State: AOJu0YwsYN+j+DSDzfW17zshxa3NAra6kicuw04kBPCZPTchcCgWarhF
	izs9Jc7GSQa2maJkcv28IcRVUYhCp6LZQCAXBdw=
X-Google-Smtp-Source: AGHT+IGqARbE/HeSv/4TX99kh3UYPrJwrUbCj2+vr+VbEtqCkIHkNhfGd3o8FTXoZSVUpIKQ4wMGoQ==
X-Received: by 2002:ad4:458b:0:b0:67a:8f89:a631 with SMTP id x11-20020ad4458b000000b0067a8f89a631mr1221210qvu.23.1701371324395;
        Thu, 30 Nov 2023 11:08:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y2-20020a0cd982000000b0067a34deb15asm745643qvj.9.2023.11.30.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:08:44 -0800 (PST)
Date: Thu, 30 Nov 2023 14:08:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/24] pack-objects: free packing_data in more places
Message-ID: <ZWjdu4h96CSKU/Tr@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <101d6a2841a909aa9c99225ebf1b65695cf116cb.1701198172.git.me@ttaylorr.com>
 <ZWhhcv25B5nUNoyu@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhhcv25B5nUNoyu@tanuki>

On Thu, Nov 30, 2023 at 11:18:26AM +0100, Patrick Steinhardt wrote:
> > diff --git a/pack-objects.c b/pack-objects.c
> > index f403ca6986..1c7bedcc94 100644
> > --- a/pack-objects.c
> > +++ b/pack-objects.c
> > @@ -151,6 +151,21 @@ void prepare_packing_data(struct repository *r, struct packing_data *pdata)
> >  	init_recursive_mutex(&pdata->odb_lock);
> >  }
> >
> > +void free_packing_data(struct packing_data *pdata)
>
> Nit: shouldn't this rather be called `clear_packing_data`? `free` to me
> indicates that the data structure itself will be free'd, as well, which
> is not the case.

Thanks, that's a good suggestion. I've made the changes locally and will
include it in the subsequent round(s) ;-).

Thanks,
Taylor
