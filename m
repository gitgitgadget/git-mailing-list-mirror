Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684D1C8618
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968866; cv=none; b=WTdvOtiCAL92O3p9wdLe0Z+v7szXoXaogznMRe4GJr3H8Mx2m0gIsJZxUfcVO/+dSo2NHdsy9p5o3ZzVExvVgbuz/DbVfLlHSibqZ3H2ZQD/6OnIqJTtvsTKk6r60fnqeljW6oiz2qfI5xCgwfRxD8K5pXKCOSMvTWjKcyeUr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968866; c=relaxed/simple;
	bh=NnGGV/dxTtX/IbcUZeAsHfdtQXrRxYTBfLUk8pIIGnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaMCzH+yUK1P6yC4hBcIORkx8ACbAzostAIn1LiJsGae1VocLzo1vgSBOZgAb5LdN7EiUS21ACLW/P8/+Hl04eQgYZTjwqz+toIi9Uf5Gn92lqUBrYa4OIytw+5qDXgnugt8cjOSyaz60Fs8M4zDcQSctDuzyVYvT3+oC5WcPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCguc4sq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCguc4sq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22100006bc8so75382265ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 04:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968864; x=1740573664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUwLXDG0tA9NEBoDci6Jt1iU8q0jTp5R48pMHwYCL00=;
        b=OCguc4sqoDWqxG3iz3g0r/KbIDZ875Y8dQh9hkRjM5mlWJBYsXugv/lAy//gLB/Zy0
         VKe2s8IRaTbEzobM+zrvH+Lz/oMugnSjt5HiONNnBE+NokYg6k7KvMwwlI1iK++YcSj1
         /7yUS45DHwmUfapmGwY49oqGdr5YF1yADSw68QaVTpP43y2NdiAMeHgPJ6xxWt9fquf0
         mgjY2PT0KO2h+cIVTpTir6zM5MXkf54SaLOM1tFU9TfAX90JP8Swv+/IefhhacTqg989
         EkXvh718RSl+L0yt94icKEtsZNashQrweYkAhtGrEHcHsWdnXG/5GHPYvswy+BD0E7SZ
         yxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968864; x=1740573664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUwLXDG0tA9NEBoDci6Jt1iU8q0jTp5R48pMHwYCL00=;
        b=U4WVHqc9YcRp/mT4igjWuPZ7D33PZj4tSIuymRCqcOejYkWU5LlBv2bt81aW9A7KBY
         3PFRmZy1PqJDK7ubdzBcTIJwYAFWHTwwClmGuQPIc5WsYkXIzoIrwddFwfACfjlVnxP7
         Ge/xsJg1wa/NzrJMogRAur1t0r9QbJmgAYAg4eXJkrxr0UTCevyTrbmLvhlqzHhmLT5+
         SSptkZIP/rPbk28lUwJ8tit/1DMP/E8NP/Nc5+f1dPTndATzcvs+bT7hClmC6fJShUnj
         BxIJdTdYGpDVtE4nAOjwXFZhvD06cL1l1tOWqTV1ZhxBU3CisXuiQF7tlcfO7dxeBE5D
         sTIg==
X-Gm-Message-State: AOJu0Yy83A+aT5UQXrNAloCoHEn5h51/lLXR5nVMYS6L7A4W/m1tWTRX
	d3/NW2PQgIAwUItZaj5VWlKPjZ3McIZhfcj6Ca8zKDVfy188nAC2
X-Gm-Gg: ASbGnctiEnKL+/A3yuwbP7ARFlMMiBAO1+WZDGhVSb7tm3RYHp5SO2/ADJc1EarZmm8
	a1X5LS6BUr65FPcVx4KM5hNyMvqXu7slNtMkcaepalG9I0CtyNcUKf8j7G2b+EuiR/2xGv8UcWt
	HiqBaVRwxNC9M1zbcmOAepuI/LWQU3bB31ZLLII+wf55bcETuV327bathPiMxrTlpeQcWZvdmTC
	4xX70PDkP+uSCKKAz0hxYx9lKbwzQQhcUSzv9yH21jwIhA/XOPNsgCbEPg/jNIrk5PRdfn4aSz2
	wPXjBvyA3io=
X-Google-Smtp-Source: AGHT+IF9cDn4QuuWXEj4tGKdQOtF4VFXYSSaub69+lziwE3KVK8zlzT5t9iP3C4OM188u9CjDvDIng==
X-Received: by 2002:a05:6a21:7889:b0:1ee:6567:135c with SMTP id adf61e73a8af0-1ee8cacbf33mr32179617637.6.1739968863647;
        Wed, 19 Feb 2025 04:41:03 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adcbe0311b6sm9119865a12.56.2025.02.19.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:41:03 -0800 (PST)
Date: Wed, 19 Feb 2025 20:41:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XRX1gfo942QdNR@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7XF5pGsa42jrIcN@pks.im>

On Wed, Feb 19, 2025 at 12:52:06PM +0100, Patrick Steinhardt wrote:
> > > @@ -935,23 +931,17 @@ static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
> > >  	return ref_iterator_peel(iter->iter0, peeled);
> > >  }
> > >  
> > > -int ref_iterator_abort(struct ref_iterator *ref_iterator)
> > > +void ref_iterator_free(struct ref_iterator *ref_iterator)
> > >  {
> > > -	return ref_iterator->vtable->abort(ref_iterator);
> > > +	if (ref_iterator) {
> > > +		ref_iterator->vtable->release(ref_iterator);
> > > +		/* Help make use-after-free bugs fail quickly: */
> > > +		ref_iterator->vtable = NULL;
> > > +		free(ref_iterator);
> > > +	}
> > >  }
> > >  
> > 
> > So, when calling `ref_iterator_free`, we will call corresponding
> > "release" method to release the resources associated and then we free
> > the iterator. Would this be too complicated? From my view, we could just
> > make the `ref_iterator_abort` name unchanged but add a new variable such
> > as "unsigned int free_iterator". And we change each "abort" callback to
> > avoid free the iterator. This would be much simpler.
> 
> I think adding a separate variable to track whether or not things should
> be freed would make things way more complicated. I would claim the
> opposite: the fact that the patch removes 100 lines of code demonstrates
> quite neatly that the new design is way simpler and needs less logic.
> 

I agree with you with the current implementation, we don't need to worry
about calling "abort" callback in "advance". And the logic is simpler.
When writing this comment, I have thought that there is a situation that
we just want to call "release" callback. So, that's the reason why I
have asked you why not just add a new variable.

However, we don't call "release" callback expect in `ref_iterator_free`.

[snip]

> > 2. I don't think we need to make things complicated. From my
> > understanding, the motivation here is that we don't want to `advance`
> > callback to call `abort` callback. I want to ask an _important_ question
> > here: what is the motivation we rename `abort` to `release` in the first
> > place? As far as I know, we only call this callback in the newly created
> > "ref_iterator_free". Although release may be more accurate, this change
> > truly causes overhead of this patch.
> 
> We have to touch up all of these functions anyway, so renaming them at
> the same point doesn't feel like it adds any more complexity.
> 

I will explain this in the later.

[snip]

> > Writing here, I have always thought that there is a situation that we
> > just want to release the resources but not want to free the iterator
> > itself. That's why I am wondering why just add a new variable to do.
> > However, if we just want to make the lifecycle out, we just delete each
> > "abort" code where it frees the iterator. And we free the iterator in
> > the "ref_iterator_abort". Should this be enough?
> 
> As mentioned, I don't think a new variable would lead to a simplified
> architecture. With re-seekable iterators the caller is the one who needs
> to control whether the iterator should or should not be free'd, as they
> are the only one who knows whether they want to reuse it. So making it
> the responsibility of the callers to release the iterator is the proper
> way to do it.
> 

Yes, actually I think you have misunderstood my meaning here. I have
abandoned the idea to add a new variable when writing here. After
reading through the patch, I know that your motivation. My point is
"However, ..." part.

> I also don't quite see the complexity argument. The patch rather clearly
> shows that we're _reducing_ complexity as it allows us to drop around a
> 100 lines of code. We can stop worrying about whether or not we have to
> call `ref_iterator_abort()` and don't have to worry about any conditions
> that leak from the iterator subsystem to the callers. We just free the
> iterator once we're done with it and call it a day.
> 

Yes, I agree with you that we truly reduce complexity here. And as you
have said, the user allocate the iterator and free the iterator. With
this, we make call sequence clearer.

But there is one thing I want to argue with. I don't think we need to
rename "abort" callback to "release" and also "ref_iterator_abort" to
"ref_iterator_free" for the following reasons:

1. We never call "release" expect in the "ref_iterator_free" function.
For other exposed functions "ref_iterator_advance", "ref_iterator_peel"
and the original "ref_iterator_abort". We will just call the registered
callback "advance", "peel" or "abort" via virtual table. I somehow think
we should follow this pattern. But I don't know actually.
2. When I read the patch yesterday, I really wonder what is the
difference between "release" and "free". Why do we only change the
"ref_iterator_abort" to "ref_iterator_free" but for the callback, we
rename "abort" to "release". I know that you want to distinguish to
emphasis that we won't free the iterator but only release its resource
for ref iterator. But could abort also mean this?

Thanks,
Jialuo
