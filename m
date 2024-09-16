Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849213A863
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480357; cv=none; b=MvWl/8W4nvJIQX+IQNOU0NR0LlZ8I+GzDBmC2dtOhV/EhaiCRSPYzuEugJJsjFFxLHF3KpeOuC0IAUjUhlJ9LTaLOI+THmZ0WAeGvKDjy08FHiWa2GxqpTpL/NN+tJx+RcO07sTxyL0HNP84RSifDDGbzUHsXT6VK414mYOHt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480357; c=relaxed/simple;
	bh=LVDkvvaLTpsY+1PhLnwolHl1Jgeebpk+xhH9WKFsEMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFVQ8w7PxCQfwQQIMnE50/2VwrgzubYuOusqJxcpSloZfB8NTXY3tE+rRJ2r8MeMJXsF65rTO6Utw1K1ZFy2nEoaOy/yINzAfwtkgem2lcQ1wma1VFI9IT4B4PGzvPkk9Qz5GxIi8PSUOzrebLJQK2SwqxGEhw2exCOaKnVCTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEUqBfXw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEUqBfXw"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c4d4f219so2732799f8f.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726480354; x=1727085154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCbLxI6OGtnxuJHlW3zRi1Fx4wocASGhodTapFRf+Gs=;
        b=fEUqBfXw3ZmNS553ejT59Y6LQ/F0VANv95nDaY1vEp8gvFHqHRpOqNE67aW1hWtL3q
         IwXkebkYXTbVRP+JZKfhTXUE9svf5S+nuyCUnm3Ilnrp4Pbwxc6/plk3JXWhT/O15OpO
         Vt21WvZUnjgomQliXAbwZ/w7+Q1wLMllDeI+JjZ3yF19efyKPKUYVHU6Mm6L3LEK11mT
         RXw/1mXw6sGxpunTzdYx5qf/0TGvxVy90OW144Mt6cZq8oqWuw7JmlICD12bOhgPare0
         Mo1nQUYd+VhrsmcTgsgU2VBj3BSyln1j0U8MgxqlpU0hiJs9NvuYHCj34bZ1reTlvmTK
         ejAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726480354; x=1727085154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCbLxI6OGtnxuJHlW3zRi1Fx4wocASGhodTapFRf+Gs=;
        b=ukFsa1skwQqrOg5mn5qxdE31QQ/zfu6XMolHycho+rRvpyOHnuEi6naPCACm3vHFiA
         nEm64PXam43UgDhogvE/R74mo+5R/dge+Iv/4xhqm1jgCbe7dqbPFSuipZkf79LUy2Eh
         DDhS+YVdrPMJLh+9K5Lh02q9Ey2rYbeM7Wd1UZ1ZUo3VJp4bYhHF3aLLgSFcaj7YGQ4z
         19XrI1CICsgMPgnPLObBIvE34Cb0byFZXu+FkBGf7IHdLyIPpWGwKrMF/BgY1DA6yTRC
         J+nd4nBxNVV6RFIg2wiSp82fTLzA6kbn1kmwVZWAgZ21RCzFZUdwtHTnV5RD2rbnakYe
         XJew==
X-Gm-Message-State: AOJu0YxMFUtMnVsZBu6dDVCHsnsDMdHaRWIu3zgMrFjntMpEZlJHf70E
	8ld/pLI25iA1UOL5tqba/d+AuSGhObBypbs9DBXbkdBKxY09hH6V
X-Google-Smtp-Source: AGHT+IHq63qRGInkXCYMW6xwB0y4rbqVQwOBmRsHKO9J+P6/5+eBktzMfVge61143HJHwaKiKFC7UQ==
X-Received: by 2002:adf:f6c6:0:b0:374:baf1:41cb with SMTP id ffacd0b85a97d-378c2cfedebmr7899773f8f.4.1726480353336;
        Mon, 16 Sep 2024 02:52:33 -0700 (PDT)
Received: from void.void ([141.226.169.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e8388sm6745660f8f.32.2024.09.16.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:52:33 -0700 (PDT)
Date: Mon, 16 Sep 2024 12:52:30 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cbtree: fix a typo
Message-ID: <Zuf_3mNRm3KuQxlV@void.void>
References: <20240915230522.129253-1-algonell@gmail.com>
 <Zufef70mfdUwSwnY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zufef70mfdUwSwnY@pks.im>

On Mon, Sep 16, 2024 at 09:30:07AM +0200, Patrick Steinhardt wrote:
> On Mon, Sep 16, 2024 at 02:05:22AM +0300, Andrew Kreimer wrote:
> > Fix a typo in comments.
> > 
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> 
> Thanks for these fixes, all three of them look good to me. For future
> such patch series I'd recommend to send a single series that combines
> such related fixes. It makes it a bit easier to keep track of these
> similar patches and review them in one go.
> 

Understood.

> > ---
> >  cbtree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/cbtree.c b/cbtree.c
> > index c1cc30a5dc..cf8cf75b89 100644
> > --- a/cbtree.c
> > +++ b/cbtree.c
> > @@ -12,7 +12,7 @@ static struct cb_node *cb_node_of(const void *p)
> >  	return (struct cb_node *)((uintptr_t)p - 1);
> >  }
> >  
> > -/* locate the best match, does not do a final comparision */
> > +/* locate the best match, does not do a final comparison */
> >  static struct cb_node *cb_internal_best_match(struct cb_node *p,
> >  					const uint8_t *k, size_t klen)
> >  {
> 
> We might convert this to be a proper sentence while at it, namely
> s/locate/Locate/ and s/comparison/&./. But no need to reroll this patch
> for that, as your change is a strict improvement by itself already.
> 
> Thanks!
> 
> Patrick

Thank you!
