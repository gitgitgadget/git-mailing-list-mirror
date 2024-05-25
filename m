Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B567E1
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600979; cv=none; b=cvwzAqKrjquUGh1NByHyv7FmhzXhI9BZ0NvGr4BvW06XWSEiZpMv2ppO5758QO7Aih0LCRO9kKXCTq46vL61IIk+v7HnxcWXxAmiIpr4GMnzx3QV9I+KCZCN59hi10nF21D6Eqi/9Z0GlPiFgMadDqdyH5ueMHdXeHqVjDls4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600979; c=relaxed/simple;
	bh=+fkvW4/1npYgpPfPwMyoP+iaEix4HFU2TWwOAjkofVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Exkl6iYZnrOuSgP+808tueYXuCIdb1Jv+wm+ZnI7BRB8LHMIxmYS87NEvzwpkFJfZfQDMngj9sDMybyVc36VCKwJqqEJrYulnawBJM2cOJPQ7jgQvVEGXiQ4kSAPjZhclug/gVs96FyZkmSKlb/wrcDg7sGzduD/Gmin7W42qfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4boUKQX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4boUKQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716600976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sK2B24gbMUACydGHXfGM9jnmc3RveuLSYfw5+GqeNw=;
	b=V4boUKQXIaLgJ7X6DY4E4ith0RQF6tSdQW6pmoV5bFmZWm69zeveZ8qzF+asIiyH/Pqy+w
	1l0vqoTXThyeZnIFtX5R5qOQYBzedC8/gTB9JTjylcmo68ED3NH7/pSUuShzG+zWzItC97
	cqUWMrYDqSYa3UFLcgBBloSpuCmpuMg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-CGBP0DWRMqy_dU9spTHWBg-1; Fri, 24 May 2024 21:36:15 -0400
X-MC-Unique: CGBP0DWRMqy_dU9spTHWBg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-794aaf57a38so161886985a.0
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600974; x=1717205774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sK2B24gbMUACydGHXfGM9jnmc3RveuLSYfw5+GqeNw=;
        b=mkuZyDJqsqVF4URK9m5Wecrx8BLkatEh4EUDGNRjmkLj87Kq7bhMRFWv2tlHVfzW3m
         3esemI922BXPfYnD4lnDftrK1jougDrGBH57mRTJuN3HnL2KPIE6ItDjuh8NJLUpCKBa
         ZfSAPlPIEN1zUvYEqHGGpFBcv1/BtjM5rPqe5kZ6SBsZTBDtJUwijmduKfImULLdNu/P
         HPqFWUnxFUivx5hG8xRSAb/kajowc0aKd4/VtVc18QCpCtK1iX39ggHOSj8nc9Swh6Tr
         cIjyo5Uc3fKuwhvH8P/F0TH2mr/hBetfK1Mieon1ssOeWaVz3lOMnJwn+O0BEIiygJl8
         Y3GQ==
X-Gm-Message-State: AOJu0YynC2ISBJ4EoCQTpfN9HI49coNO/15DNGZZr0j/czQ+8wfrru2q
	j0DZxEA4Wm9c/XsP2Lt1GJsar8FMIiL6tLmQqgUbXVSAh1dlUz07rYDu2l6pDI4DPDFkrMnRcXD
	vJZbifQVHYiVmz3YM8EuM/4HS/TTnqjazFaiWRH2vdw/nT3ED4A==
X-Received: by 2002:a05:620a:8119:b0:794:7ba7:16b6 with SMTP id af79cd13be357-794ab07cb9dmr335984685a.24.1716600973458;
        Fri, 24 May 2024 18:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE//4OCxh7j86F8LBqhwiVKofI2H94HdFyfqWNfePYYF3rVzCkior137iB+xto1RX6fHkKxFg==
X-Received: by 2002:a05:620a:8119:b0:794:7ba7:16b6 with SMTP id af79cd13be357-794ab07cb9dmr335983385a.24.1716600972948;
        Fri, 24 May 2024 18:36:12 -0700 (PDT)
Received: from fedora19.localdomain (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd44ec6sm107363285a.133.2024.05.24.18.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:36:12 -0700 (PDT)
Date: Sat, 25 May 2024 11:36:08 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] alias: pass --help through to shell alias
Message-ID: <ZlFAiMAOaBK1Qrrw@fedora19.localdomain>
References: <20240524070623.1344636-2-iwienand@redhat.com>
 <xmqq8qzyk9u8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qzyk9u8.fsf@gitster.g>

On Fri, May 24, 2024 at 05:34:55PM -0700, Junio C Hamano wrote:
> Ian Wienand <iwienand@redhat.com> writes:
> This is a safe behaviour because the underlying command may not be
> prepared to see "--help" and ignore it silently in the best case,
> e.g.
> 
>     sh -c 'false "$@" || :' - --help
> 
> that would confuse users by being totally silent, or 
> 
>     sh -c 'awk "$@" || :' - --help
> 
> that gives "awk: not an option: --help" (which is less useful than
> the report of alias),

The proposed patch does still print the alias expansion before trying
to pass the "--help" onto the command.  That was intention to be the
same as "-h" behaviour.  But I take your point the error message
doesn't help.

> or even worse yet, if the underlying command
> does not understand "--help" and considers it something different,
> who knows what havoc it would wreak.

I guess this means that someone was relying on git to filter out
--help such that it would never get to their command.  To me this
could probably be considered "undefined behaviour" that is probably
low risk to change, but I understand the aversion to it.

> For the above reason ...
> 
> > I would propose that "--help" to a shell alias is passed through to
> > the underlying command.  This way you can write aliases that act more
> > like the other git commands.
> 
> ... this is a dangerous thing to do unconditionally.
> 
> I wonder if we can come up with a notation to annotate aliases that
> do support the "--help" option that wouldn't have been used by
> mistake for existing aliases?

We could do something like make "!!" as an alias prefix also passes
this through.  It seems too niche to bother with though, TBH.

I could propose documenting the behaviour as-is, although that
probably moves it from undefined behaviour to "this will never
change".  I'll take advice on what you think :)

-i

