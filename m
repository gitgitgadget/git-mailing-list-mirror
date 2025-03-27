Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16013A86C
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112266; cv=none; b=uLXNovfODapABK4zlz9eKdXNcwLxfstGNtVeIZKDC56xhZfBrvEbHgVg0jjUX3dF0/TRKWqNHx74rF9t0yFZxEOTmPjh75xZUHrubpRVLYKNrUM32jKJQTYPaRxWpwMhRvMAH9XGkrcTrvdF0Yh3K36j4ngATC9k9Eog60YaXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112266; c=relaxed/simple;
	bh=BbIIgH/4Rv4Jl0NRRbwziV+P6qKki2FfX+LwsCDGYSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHzdRbkhU84IKM0tSihYiuUMUwRxCIzzweaa1bp8yntnbEEkpDsX/ssIzpF8uQhg9LhaYLGnjqwOhJAfqXHPLbCSb4Y+2K64qK4Esl+ulgl1PLyFwR/fDj6mnfF1rB9fOZUrU5I9Kx8hLtlLC4y41+3ZoT2FoOafvpVAwPCTJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o4V//3a3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o4V//3a3"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso12462156d6.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743112262; x=1743717062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLkCiKzXFUnbHGxfDsAXbnI+ZSxG2FEP0lBg4jmUqZE=;
        b=o4V//3a3KDfoUc/r2nKSkhfhRqOJ7gB+FW88/ibmlH7WE4s7aI+1m4ruhAz7JI0+f0
         g5nuWr+3AAL51qp4PlaFopnImFjaFcj7fjIm9XRt6d0cXDjKnqYuj1V1Me/jz7gGwwAw
         zxGI4FyJ6rBQy8YrNQdnceP7psQK8o2Jo1Oqhqp3rD2wsz6mlzTdGn54fiw9q3zhg8lM
         mujBE5NVdKcbLI/pPXGeDybC1T5ZnurT9SRVan2wfwuxaSrjaBEF/HZ6xJPDPvigyZkl
         sesYHlBj9fMRmcNmP6118bYgkKlXTYv8hxmPHckBXFO8cA8lsXx3m9uotDXRGhBf2e8D
         gZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743112262; x=1743717062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLkCiKzXFUnbHGxfDsAXbnI+ZSxG2FEP0lBg4jmUqZE=;
        b=Tibpxb7qBLyLqJ2uQRZjmlFsvVj4dJbYzINwp6XsnnslXC2JCXVb+4HM+HvQithwFS
         nuYE6Nf+jY1ML+MYOsFpBbw7HZUiMwQ2/QfLugBwDw/f1V9+XL+EOE6xoc+ndGjMhGYo
         W+unkJCqnFVrSxAAcGJQJqnRJClzSgWpDZFOTKu0Fk3hj1MYPfcHj3WH58CHjLEyJG6+
         KlZ7m9L8XwAkdAhBXYiZOhVHkfvopkArPgjutAc6qwflP5Wb3HAKoq5Hlim7ahwIB/Ma
         tcu9BsuBCgHxmu4ehS93PjEELj2onotjt2BfJKwyae+DGiSODUfDjHYiI+XT4x5PpOxy
         7H/g==
X-Forwarded-Encrypted: i=1; AJvYcCUnmSyg7wONrJYiMe4KY0K7XMy+x4g34DjN2mZqeK8kG6M8Ij5X1+PCdHro3T1YE7hpIT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrazfMmdgKGU8gl0kjyn4HR+0XTjX0kYcDk7pWReBQ1USBs0o1
	AYg254WlxwG8u0xHfLvp+MYISZXIK1G2EbldPB+v8Vt/amxSU52nAyhwB9Bt810=
X-Gm-Gg: ASbGnct9zyub/FyMVo/O/L/V3w4ez0Ll3+sjzYd2RbenbPZ+0mjia5L9oakHnQljjQL
	pbYUNjpvq4L0udIbBbLwYLaWVyIR0X95r9U1WVL+om5qv4c8s3dG9MyvAKIiYttFdQZdIq6i/4p
	CiVijni3fIDG2g3iJ6vymqwEsqatYeF/bBskRLOHbgbnGvd+Ee9Gz0aN/FNvQDLZsxVNqgRgj8I
	jMNw5rnfPs3W919cDP4tmTc52byLw+0VvU9yejx68OOAbB3IUCZh2z4glo2fMOcRQCJw6usyvPQ
	C0F8unnKZC9LfIfA92LMz6ABRpRsLxkgOtfex1zpWZRfgZ5uJqHBYRZMLxGbLklQybw55tCJDVs
	7f1gM2J7CcunB29Rq
X-Google-Smtp-Source: AGHT+IHxgiYaRbhL4YkgoD8qnxEAPbZdsJKAGMKysAutqA+LzMiCDQvPZdRoTyxPzmq4NkoyohKffw==
X-Received: by 2002:a05:6214:d65:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6ed239576a0mr78186596d6.45.1743112262170;
        Thu, 27 Mar 2025 14:51:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eec9799693sm3361146d6.101.2025.03.27.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:51:01 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:51:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/10] compat/regex: explicitly mark intentional use
 of the comma operator
Message-ID: <Z+XIROew1umqs1XA@nand.local>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <dc626f36df34df4897289e508dbf608512a93870.1742945534.git.gitgitgadget@gmail.com>
 <Z+RlEwwTvFkUWwkT@nand.local>
 <1c8a3d80-5817-1e2a-de8c-06046d372fea@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c8a3d80-5817-1e2a-de8c-06046d372fea@gmx.de>

On Thu, Mar 27, 2025 at 11:29:16AM +0100, Johannes Schindelin wrote:
> Hi Taylor,
>
> On Wed, 26 Mar 2025, Taylor Blau wrote:
>
> > On Tue, Mar 25, 2025 at 11:32:12PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
> > > index ec5cc5d2dd1..7672583bf7e 100644
> > > --- a/compat/regex/regex_internal.c
> > > +++ b/compat/regex/regex_internal.c
> > > @@ -1231,9 +1231,10 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
> > >    for (sbase = dest->nelem + 2 * src->nelem,
> > >         is = src->nelem - 1, id = dest->nelem - 1; is >= 0 && id >= 0; )
> > >      {
> > > -      if (dest->elems[id] == src->elems[is])
> > > -	is--, id--;
> > > -      else if (dest->elems[id] < src->elems[is])
> > > +      if (dest->elems[id] == src->elems[is]) {
> > > +	is--;
> > > +	id--;
> > > +      } else if (dest->elems[id] < src->elems[is])
> >
> > Should the other arms of this conditional have matching curly-braces?
>
> No. Have a look around in that file, that's not the coding convention.

I was just about to respond that even though it breaks the convention,
that we should encourage good hygeine by ensuring new code follows the
CodingGuidelines, even if it looks wonky in the context of the rest of
the file.

But this is compat/regex code, which clearly does not need to follow the
convention. Sorry about that!

Thanks,
Taylor
