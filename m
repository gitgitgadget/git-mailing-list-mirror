Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37B1D1506
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541072; cv=none; b=nTomv+lXh+yVdQTOfWViC7ve+DV+fFyRwFxnk4cjj3JJDpbZN//+2wJFJ8vy8V3DOdl0sgo+oANZRWRF/D1iqbw1pp9MOTehGt8GcUWQVFGuuiYA9j8RNoHwZ365xWZvyOrpA5wiaoiuS/82yL6ayw21kUz5RF1HkukpSg8B804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541072; c=relaxed/simple;
	bh=+VHkjZIs+Fwit8bfOFl5AUzCavvdMx5+0hC0J3PpURU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFKeYvsnQk16oPX9Uc4JNZ1uOKpGlIHUdd0sobrPApo+XSl1HZNNm7MOQ09408arQfVU8d3oD+1+UIEWl3zw/61lScBlESVLxhpMJ0RdmE47ZKb1cphwPs+bCbALYGuowcgqfbrqf/UNYQ4I2WF2K3gVd5RDzezBxzp5CVF+/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=OgGvHmr3; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OgGvHmr3"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e38ebcc0abso53135307b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729541070; x=1730145870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OeVsmprzWJMqTzfNmsaH+o+LmLj0N6vqd7YwTQW6f9Y=;
        b=OgGvHmr3peZcLNhEb77QLVqwRTBFyQN0rrkl/p85QihBJf5UPHOWuX8zMt2Iva+cEa
         K0euIK+4pUe9vuhNeXgVaYGkLg3f99GrDxIFub2wUHbSIX5ujI2+sPJ63b3nS0X5EDOH
         PqJgd/W98y32Zlr1ZZ2maZcFGYvpyUiV8IDSYQd6TRi//oQh8YRx2tVysVQ66lIVccN+
         b8auU64+NxqkXIOhMgteWne5PMjIz1qI6Z+/hs2aajhi882hAm0KUBG9/apjZuqGXbGE
         tj2lH50MIYDMKp1HRHNKL1knc4JXbTONmoJtt0R+OovWiw69JiCUhkkbG3S3PI5wQMH3
         A+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541070; x=1730145870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeVsmprzWJMqTzfNmsaH+o+LmLj0N6vqd7YwTQW6f9Y=;
        b=n5p5XxSpwncKbZ3foRbaC3OxYxch2lINlb8pzf/qEyoMIVg4bsjfqRRMi0ebY6p8Cl
         OPZzTrYSbtXgRiVlOpzLcYUBuHHR/Famemi8zoVXUNgKuZsTbjsDGrWAaP/F2r+KRH15
         x9jxL1J1AEGa/fWQr7iazN0VM+ZQ/F0z5vhOf9tZa/JE0mjE0aFWrjoZ4IamTC0oxxX/
         +P++uC+kajEqBMt8o1UJ4tJD4bvTYJIxpLXl3PSwP0pvVAnlKKL4q/N0piPvnZmBzRG0
         LvFaq3YLPPydmriw9fCRD8Jnw1jT7DCkHW3VKEYt907mT9Ru28mW3VJI5d8o3qdAFoed
         c4PA==
X-Forwarded-Encrypted: i=1; AJvYcCXmH8eGu91BrX2krYMHhpmXz0+4bI4rd5epd4JmujfFyDe81iZOJfACxjOIWE9TBpxo/4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyYWScLchozvFqntliBCPJ3QSi+4ctox/7G20tQ75q1iXJ1HB
	sNn4wnRNTg5y1G09Bffg4KSQL1071GtIZbOw0JN4Dsp5DiAlfLvBRICadh1bvAs=
X-Google-Smtp-Source: AGHT+IHna1f3eezFwBC8+3OqAI5WSdtoXFeO0siWngtGxNCCUNuPaqndNJWLgP/2zZqK1M4gP0HUTQ==
X-Received: by 2002:a05:690c:3109:b0:6e2:43ea:552 with SMTP id 00721157ae682-6e5bf9a5d95mr92430217b3.16.1729541070316;
        Mon, 21 Oct 2024 13:04:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cf4f05sm7894017b3.109.2024.10.21.13.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:04:29 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:04:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Sven Strickroth <email@cs-ware.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] Fix duplicate word typos
Message-ID: <ZxazzIUA/JQDi/Uw@nand.local>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
 <ZxYjISSiV-vlE96W@pks.im>
 <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>

On Mon, Oct 21, 2024 at 11:57:25AM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 11:47, Patrick Steinhardt wrote:
> > On Sat, Oct 19, 2024 at 12:06:54PM +0200, Kristoffer Haugsbakk wrote:
> >> Hi
> >>
> >> I guess it was an intentional choice to not use an “area” in the commit
> >> message?
> >>
> >> I found this similar patch which used `*` as the area: abcb66c614c (*:
> >> fix typos which duplicate a word, 2021-06-11); review here:
> >>
> >> https://lore.kernel.org/git/CAPig+cTjjNrU9q8UPm+CRuTKq8_XNc+1z7-3F4bvetBi+NjKeQ@mail.gmail.com/
> >
> > I think many projects also use the "global:" prefix to denote changes
> > all over the place. We also do this in Git, even though I should
> > probably say that all patches that do have that prefix are from myself
> > :P In any case, I don't have a strong opinion here.
> >
> > Patrick
>
> I forgot to mention that “treewide” is used to a decent degree.  :)

Yes, I think in any case we can blame Patrick for setting the convention
here ;-).

(For what it's worth, I have occasionally used '*:' in the past, but I
don't think it matters so long as we use something to avoid 99.9% of
commits being prefixed with an area and having a few odd ones stuck
out).

Thanks,
Taylor
