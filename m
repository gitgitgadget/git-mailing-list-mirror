Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334113B5A0
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124364; cv=none; b=sljZEd77DERZQa5eNPhdfk2RwrIU7rsZMqTnEWjPVPuCm9kjCJRm9ugSnLlPF/pOpOM9VAwRqU9U6KK4VqaZGZEIJMaoeaCOTN1BnBuhllfGIVZsQS26lNdhyuGK5z8iYfBaWxPx0puI4xVhvGp/WDggDdQXgcgSSdjcF3rSgrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124364; c=relaxed/simple;
	bh=qxJpl6xqG74FDmlIqULd8aEQUudn6Se8Lp0BofH9UdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cped+tHZR5fOynwEpLrhg5csXjyiG037YZTAj0p75dP3mjh3cZjNrrZuJorBie7Mq0z3oGbAs+nccvAHjsrDZ/FNMPk9JmAjORiVJxgcAs+LyNHPTPCpqPzYAm/5Cd+GcJZFhyMF5ef6YwTBWoUxleXFti9NcCqiBBMQeCUcJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2iBe8mO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2iBe8mO"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f32f5b0631so1519598eaf.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737124361; x=1737729161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPHYzRz/2kwqMDVKFZFZxC/OunOoT9PDb34GmvHS9Fo=;
        b=A2iBe8mO2jTIgcS7G6kQjsll6GacTDcTwoj/NKs1HTKtJ8w6nixw/bxf0lBUml3bCZ
         uZkwqMDwgWlYhz5Uz1isIPtyhlFOtTsxe8k5G6p6z1F6NgFSrmKFzoSPJX3cu0BcFkYf
         bre/P0kH11tY1NZAdSLbUkltFWbfrM328MeEK0RG84gqXLbE+pPWKKTA6lQOZa3v47J3
         +ArgaK9yMhNixFCd8e8LVUAsOKMELQBgOSQOjOn6t0kL+jKokc9NnE9Sf/sulg462JzM
         lFVYSkl6cu5nGniT7rKL98esLE1jMPqN+CKv38uSnSZnzgTl9IZ479Ypfj03yYB/31No
         bTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737124361; x=1737729161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPHYzRz/2kwqMDVKFZFZxC/OunOoT9PDb34GmvHS9Fo=;
        b=n5fPMW1Rssil6rRT5uVToC5or3RAwJJ4D1Y+QFCrvel19q1SFVmNBRpbPxsXdhyRDt
         DhCYaK6vekRTATdpiYrwmGYRTtYGydqNtje9B//0X6FXVKJikKuoePYedUDOmCaeI4+S
         NX9UeKQNNboOD0mrDYc4R3q6Q8FLMCxE/7Y9A/sQz5JTsxZIG9o9EeWQebeXLoAgrSFe
         j/Hp/ehTPdEieb/86nRQjPbYsJLw/64Qrj7G0UEG6QGCOEEZ3f1ahmRM0a+lSzZr+PmQ
         hkldxWu3Da1QIeOU2ZibQBWkhxBEHZCYkK2Y7yhU3aGkR9iK2psHyhZO6WNqTKqsqyST
         MCQg==
X-Gm-Message-State: AOJu0Yx1BFNYEO1ZDAmQzLm+IO//cp2Ovkd6PqdqrffnEQqiJaOqlXE4
	jVIYpUuxYdsHZQd37cs52deDui0bVxXVKVXx5iB4qEUp/qHNNl8w
X-Gm-Gg: ASbGnctlKyNUhnXYLLAbzUMAa9ORsivReN4kZBSuJQ3GbuaQK7WmFE2z2+o9MfDdW+O
	Q71rQ1oBQ+PYgDQ412a66YLscvfLRcjUFV7UXR+64oBk9AQrMJKN8fWkd7TYSTS6QQPyUu5U3if
	cy5Vyp55HNHNF/XPfPOD4EhlCcfx51pqkiTYHwb/PUewCvpsimki/iXM2gwQrhqqGL2GUNUeWMh
	hu9bRpbMJM1IWQayJIabVBF4XCybYg7jdw=
X-Google-Smtp-Source: AGHT+IFTNeSar2U2UsRBuw47XG5jiJ6zkyaDfkUtWMUJUhuBD1Z9B7yqQlHUb0vU5+jA4cMyrwkPOw==
X-Received: by 2002:a05:6820:3083:b0:5f8:c64a:f293 with SMTP id 006d021491bc7-5fa38879f6bmr1860151eaf.5.1737124361437;
        Fri, 17 Jan 2025 06:32:41 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7249b3e0dc7sm920544a34.41.2025.01.17.06.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:32:40 -0800 (PST)
Date: Fri, 17 Jan 2025 22:33:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/10] packed-backend: check whether the refname contains
 NULL binaries
Message-ID: <Z4pqVRsCg3KfjJf-@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN_8-HKdspwcDb@ArchLinux>
 <Z4kQVHw7Uio-Pzo5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kQVHw7Uio-Pzo5@pks.im>

On Thu, Jan 16, 2025 at 02:57:40PM +0100, Patrick Steinhardt wrote:
> On Sun, Jan 05, 2025 at 09:49:51PM +0800, shejialuo wrote:
> > We have already implemented the header consistency check for the raw
> > "packed-refs" file. Before we implement the consistency check for each
> > ref entry, let's analysis [1] which reports that "git fsck" cannot
> > detect some binary zeros.
> > 
> > "packed-backend.c::next_record" will use "check_refname_format" to check
> > the consistency of the refname. If it is not OK, the program will die.
> > So, we already have the code path and we must miss out something.
> > 
> > We use the following code to get the refname:
> > 
> >     strbuf_add(&iter->refname_buf, p, eol - p);
> >     iter->base.refname = iter->refname_buf.buf
> > 
> > In the above code, `p` is the start pointer of the refname and `eol` is
> > the next newline pointer. We calculate the length of the refname by
> > subtracting the two pointers. Then we add the memory range between `p`
> > and `eol` to get the refname.
> > 
> > However, if there are some NULL binaries in the memory range between `p`
> 
> You probably mean NUL characters, not NULL binaries?
> 

Yes, I will improve this in the next version.

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 3b11abe5f8..f6142a4402 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -493,6 +493,23 @@ static void verify_buffer_safe(struct snapshot *snapshot)
> >  				 last_line, eof - last_line);
> >  }
> >  
> > +/*
> > + * When parsing the "packed-refs" file, we will parse it line by line.
> > + * Because we know the start pointer of the refname and the next
> > + * newline pointer, we could calculate the length of the refname by
> > + * subtracting the two pointers. However, there is a corner case where
> > + * the refname contains corrupted embedded NULL binaries. And
> > + * `check_refname_format()` will not catch this when the truncated
> > + * refname is still a valid refname. To prevent this, we need to check
> > + * whether the refname contains the NULL binaries.
> > + */
> > +static int refname_contains_null(struct strbuf refname)
> > +{
> > +	if (refname.len != strlen(refname.buf))
> > +		return 1;
> > +	return 0;
> > +}
> > +
> >  #define SMALL_FILE_SIZE (32*1024)
> >  
> >  /*
> > @@ -894,6 +911,9 @@ static int next_record(struct packed_ref_iterator *iter)
> >  	strbuf_add(&iter->refname_buf, p, eol - p);
> >  	iter->base.refname = iter->refname_buf.buf;
> >  
> > +	if (refname_contains_null(iter->refname_buf))
> 
> We can replace this with `memchr(iter->refname_buf.buf, '\0',
> iter->refname_buf.len)`, which should be more efficient than using
> strlen(3p).

Thanks for the suggestion. Will improve this in the next version.

> 
> > +		die("packed refname contains embedded NULL: %s", iter->base.refname);
> > +
> 
> I was a bit surprised to find that we modify the way that we read refs
> from the packed-refs file instead of adapting the fsck code. But I think
> this check is sensible.

Actually, I am also surprised here. And this thing is extremely
interesting. When I implement all the fsck code, I find I still cannot
detect the error reported in [1] which is the motivation why we want to
add checks for ref explicitly.

And I dive into the code to fix this problem. The reason why I put here
is that we are going to implement the checks like what "next_record"
does.

[1] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/

Thanks,
Jialuo
