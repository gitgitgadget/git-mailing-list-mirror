Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4832C0F89
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959900; cv=none; b=m1z/AZgP+AiBtsCVI3GwtXybGJr6A+rknvc3yYc9HnTmFZ5AWNbALY/A8DMr5Pmk+QFBfKz0HZR7CD7nj0sp2mXTvNwx1ybsd8IlHrGmzaD75FPAUVEbPxnJPN3O+sZV2gU5xugqfoSpeSgw9gnmq/txF3llTpOoLjtBwCSJQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959900; c=relaxed/simple;
	bh=UizANlV+BwS7s9dzgf/sGt/16xDVutlT0rLwSjsZ9wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsDC83bvYl4zr5sbYA1A4QJvlU78erSUM5s3T0aYQyNDd+/zkG9WfBkPnMVkmYo24wOzKHGY8MPYJGZiLVj46MqLLHDygV/UYdsW6E8I4By/ad0qex9wviBmAymeo7pSOpTUX0xaCkGypi9fCwB04SxnDG9KmvGWGehvPnoGh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=X/NW8V52; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="X/NW8V52"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42f6e0bdcf7so2560225ab.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759959898; x=1760564698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UizANlV+BwS7s9dzgf/sGt/16xDVutlT0rLwSjsZ9wM=;
        b=X/NW8V52Pt2y+MSR7fHSYT2Q5GVOrQzw8aDtjwoBXwwTQg6sqXSPk8f37AxNjcpspz
         8JQs+oTjNJBa55Ah3JHNPPPiBwzriGfjgknOnDjAJECk40oNb0IkT3O5ZZ4SK4pNXGNl
         29Rj7OEtFHsW7KXza+i1DmCb96dFTkF4YF563736XyUF7i8rBf5rvtMKmHkT6qgPvijw
         mVOfLNlC84uLBOK7p+qnOCr89qmepA/R7Pzi5amaFc0XmyH+tmELPpQBP/kdQ3rWq584
         MlOWbTdW55VnDh9M9asjYHaUWS733TahxZgT3UqT9GSmkTOiAONlfXLFo+Vk9QBemkOE
         xhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759959898; x=1760564698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UizANlV+BwS7s9dzgf/sGt/16xDVutlT0rLwSjsZ9wM=;
        b=hxb9V88Ejr4kIP52kxyWOC1aw/gNZXL7eUuLqRWF/7SHXVd2n1jq2wo6gb+/VbyMan
         /c7qTV/RIkV2kNWlLsoGMH2+Ah6mJlrJwpZgFSkOOU1qrOaolEFXCSwkujOd666CSVr7
         gQ6kRTvah0ADiwwolv4Hd0hQZk7KSvY+1EaNO7DpdOo6aCbdpIHEsQAm+Zo1Ue0rjgiA
         MSz20FOMYCw34+LOJiKw/uVxKDtLNpxyo8XuZM9mB+Ft9+tvE3usnPjgi3pmJFeF6DKe
         LLGT+ZbJY1EInAfqf2ZCau/dUE/JAlaSLqE3zYqpkgf2qzsl2ecEx9OTB2a83/XzUMvJ
         X92w==
X-Forwarded-Encrypted: i=1; AJvYcCVjI3joWutpUDJp/IJbYfcgj97ybxsXq2haEbhxZYxnl3GfYblfGK/r/BZ70AymPKQSqKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQSr4gt/3CnLvAPRh7uFSmJt4bfi2Rxq5I1nzgEY+V5rog4Du
	5EwNSf9CqdGIVCmTMqa0/gu38AVxwqIAcBeP40t4OLsyYAbnjgpywdBYf7qZ9x3md04=
X-Gm-Gg: ASbGncui+w2C2Y/B2+/FjP4eienkI/c9rSuylYDD3No76ABhR3A4edGRKxiQsVXBx2N
	YkLKcXTXiWtJzDk5oX9fF68QZ0nV0nr5JdJpm04xiU2BQmBW8Xgj3q7rNOkurz3zzvT0R7qlgTE
	yxCN/z/8KfdxoLqHQpdDAo5GaXDLxqM9AxCdJffVc85ppqhD17hK2Q1RXexIteYe4Vm5m7KvEk3
	TgLspwsfTdVdZoYXoB72YFqxNoZEf2aJxAImJp305JEbWFRFk72TItUoTQuVY7I/c4raM3GbCgV
	NvY5wreSSt/64WEslKqVME4OG64Nr1mo8mwnlex2PEIxbYb8U8o7CV2SRbk5SQvDPy8Jj7qhUlq
	cNZpvR0evY5Namc9WdZUQXtgVHo3eOL5tOWJA9/RnMSj2OPsyP/F7gQ8hrGlSxE7Ngh7uqm3v0A
	pend3xia9PCUzn/uc02hVUDWwdmw+XbMPES4bSjCBiuDDy93MUwg==
X-Google-Smtp-Source: AGHT+IFZryPXMIQfbqFKhPf0V2TclBDiQtjKouVc37seTn/A4J0TnXg6F7P2ExpX6s7p3B5tc4IenA==
X-Received: by 2002:a05:6e02:1805:b0:42f:86a5:5dc1 with SMTP id e9e14a558f8ab-42f873460c2mr50220845ab.3.1759959897813;
        Wed, 08 Oct 2025 14:44:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ec0b026sm7482698173.59.2025.10.08.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:44:57 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:44:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: 'Luca Milanesio' <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aObbWLBCbXsvuajS@nand.local>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <04f501dc330a$0ecd3010$2c679030$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04f501dc330a$0ecd3010$2c679030$@nexbridge.com>

On Wed, Oct 01, 2025 at 03:31:54PM -0400, rsbecker@nexbridge.com wrote:
> On October 1, 2025 12:05 PM, Taylor Blau wrote:
> >On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
> >> I am worried that if we rush into Git 3.0 with breaking changes that
> >> would make other “forges” (e.g. JGit) incompatible, we would be in a
> >> difficult situation with the other Git ecosystem that isn’t based on
> >> the C-Git implementation.
> >
> >That's a good point. I am not familiar enough with JGit (or really any non-standard
> >Git implementations) to know where SHA-256 support is in those respective
> >implementations.
>
> AFAIK, JGit still depends on some core git functions, including gc. It
> also depends on LFS for those functions. Interop it fairly important
> in that space.

What are "core git functions" here? I'm not at all familiar with JGit,
but my understanding is that it doesn't use the Git binary directly
whatsoever, so I am not sure how the presence of interop support or not
would affect JGit or LFS.

Thanks,
Taylor
