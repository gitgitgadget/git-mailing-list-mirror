Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC0288A2
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430789; cv=none; b=S5fE7AVjnEk5j/ZQk981Oq2jFkYMRg7V1B4qQcJ/Ugp6Lwt6Ya/IZP7XLBAqmUKDZ5Ycq8j8tskKmzqb1bETClz9NBXIx2ctIWd3OM9DhF9nSbKyLGkIQvVrKzOtGfiXOcDgAYJ5NCqRXcF52Zp4u1oIXUzOKr1FXfDqOM8kC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430789; c=relaxed/simple;
	bh=H7i+WXs7YTUUjrFXAF/MpAPjs+evL7WworKn5Ta9QNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVckeWoH1ZBly+yG2IpQ3QOlbC0wf5pCdIC8Z+289wwn40Jm2C2CrjDKEpJBSkvGGsIpcchh5C92cg3pWRwc0vnK7QvhUVDQppSUnuNZGuw78jnsD/1qLq7gm3JakSaPxy5M/Rx/fnvAuhz3LFX+vDPuT+I07+fkR8st25XpbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZeLxx2gE; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZeLxx2gE"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-745582572a1so134169a34.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756430786; x=1757035586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VjtvNOmV0G63m82D0lYEDGnLOn8ZIeyfIqyTr9Mgzs=;
        b=ZeLxx2gEM7iScFywWJMYXtZkGAlE7ZxygwuQWqySYuxR0+psQD4RHvrlzPjBWl9GYy
         O9CCkUMawxQ/B+szk6AOofaMY68bZZkenMOF4XC/34idDv+eLnAKlF5QSLB4HsS425WV
         0fSFcu8Tkzd6pDXYgCMN6pG20uuGFRkDgsW3IYv81S7a6HMkNGSKCygV+ULvfANNI6Ou
         sYCqXLAHLBtFy/88mthLywBUh4OlhVYNrFJp56hyRB8Ez99+UAsPJduvmdac1g6pNBeS
         ZLLM70F7boDqM1/iTiacewWGOBv514ZQoGy3U/Tdb0M3PLrEkODufF08Xs5ubwrPBV+Z
         yPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430786; x=1757035586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VjtvNOmV0G63m82D0lYEDGnLOn8ZIeyfIqyTr9Mgzs=;
        b=jSp8mfTJZncARQqSDAqc9qkevyr6Rn6EP1DV/ZRWQUWXk4GLsHBfQ0oYb9T1YF6gBe
         WKVKDlyIxYkLFdVpjpDZ3/DZVUU8Qd/4vsxvkb2Df3TW/n5ukbXYSxwSLXn6+9mx3xEJ
         qULMYWxcsXEiBrsZ+/xtklmxvM9ezqws4kevOH8fjBYM8vi6VtZRC9gVumiTnnVa4+J6
         iOYZ/IR5oOLpQWsUZIkzmrvCGUj8pkznCzhGgxbZSMFc1r8BO769rZGMQ1ABTpyoE5d8
         +BAZghOLBed0wGYoMulL165+mPYPm467+NyRGbXaMORVVzxPxPB8PEKzEbZrAMjkFMfZ
         L+hA==
X-Forwarded-Encrypted: i=1; AJvYcCUmyHpArK2NG+15pCz4WG0/oCY67rKK/yQFMfY9V7B1YENG7db/q7Z2hHHepgZj0t5LiSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVsimN0SbJb5WLeXUYbfraFQ162CBscJqjnmv3WOOTD6h4+KC
	0VOtYrkO68mYrNF9Yx9zStnpPXh82cDXXHKql3yyeKWFeC/iSVX/iyHaPYordPnwclc=
X-Gm-Gg: ASbGncsrGeEDwAXibLC82rh687Qu2PogYZmT36Ap6xwGLBM5KxPORcaTUgtCxCEnn15
	PZup/fnYOUSu4wphHTavW5qUwmnROrdqud3W7oXc9JmCh5U8VfnrOISBj4luWyJ8DJIsuXoZotX
	/i4JNZc/Kn2Z2HIcj9j8xcobxSyR5wArObdFxgkDeDlLFVaUMTqK26usTC34TRmHUZ+QZqg0g0k
	lih6jGq7o00rXVs8ST4VGWDRmHeuh6gV9Kv4smLiknTvFTct/t8Ma9aWVYTyf/Zu52Z4h2v+wSA
	3C3/kHbI4BH3Sj8MCyR5PMUMLXaHMSx5vyzyXWFoCDSkcGAI5PywebHdT5DGRkXs4cdB8uhUAh8
	NF4UV3wRd+3dydESfAVZgBe3mZkcH5lJQf+B/6yAMd7leryLlYHjufTCnmZziH1qzBM4Z70+Sxv
	mYNmmCuPIJSLcKGZ6+w/8cyZWMOw==
X-Google-Smtp-Source: AGHT+IGie35ZCNr26y9Ga0RlGXBF0zrcWUdyBpJv9mPid/+7vnakKLjgVtpv1d8iHkOvg3xaZdJ/zQ==
X-Received: by 2002:a05:6808:2107:b0:433:ef4c:6d85 with SMTP id 5614622812f47-4378519e960mr13390520b6e.14.1756430786168;
        Thu, 28 Aug 2025 18:26:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-437e8ccddf0sm152308b6e.30.2025.08.28.18.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:26:25 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:26:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/5] midx-write: put failing response value back
Message-ID: <aLEBwC9Oky+NV/Vk@nand.local>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <709555c5316014b2b4d6648db407d15160769146.1756402795.git.gitgitgadget@gmail.com>
 <xmqq1povuqdr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1povuqdr.fsf@gitster.g>

On Thu, Aug 28, 2025 at 01:45:36PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Derrick Stolee <stolee@gmail.com>
> >
> > This instance of setting the result to 1 before going to cleanup was
> > accidentally removed in fcb2205b77 (midx: implement support for writing
> > incremental MIDX chains, 2024-08-06).
> >
> > Signed-off-by: Derrick Stolee <stolee@gmail.com>
> > ---
> >  midx-write.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> The cover letter made it sound as if [1/5] was the only fix and the
> rest was clean-up, but unless all callers of write_midx_internal()
> ignores the return value from it, this surely would change the
> behaviour of the program, no?

I think the cover letter is saying that only the first patch is required
to fix the crash that was reported, and the rest are clean-ups.

Not that this isn't a bug in its own right, but it's definitely distinct
from the one that is addressed in the previous patch.

> And the results from write-midx_file_only(), write_midx_file(), and
> expire_midx_packs(), the three callers of this _internal() function,
> all seem to be used in builtin/multi-pack-index.c so wouldn't this
> also be a fix?
>
> Not that I endorse "0 is success and any non-zero value is an error",
> but this does not look like a mere clean-up to me.
>
> > diff --git a/midx-write.c b/midx-write.c
> > index d8f9679868..85b2d471ef 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -1106,6 +1106,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
> >  			m = m->base_midx;
> >  		}
> >  	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
> > +		result = 1;
> >  		goto cleanup;

It might be nice to have a test that confirms this behavior (though the
changes look obviously correct to me). It should suffice to write a
MIDX, drop one of its packs, and then try to write it again with a new
pack.

Thanks,
Taylor
