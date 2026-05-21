Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAF307492
	for <git@vger.kernel.org>; Thu, 21 May 2026 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372862; cv=none; b=XWVScGBuoo0IPZ8zYQBRgPfAQK5QSJTeXQf389xJ6Qv+DPdoA4g38C/HTY/8jR4OjDwK9+YHbkM4osdGnAmVQ2UN6QfZRAt4E4C/ey36EJ6i7Yc1bew44M7GC0R+YVkXlG4zYLHjBSL1b695qR55ms+SqTPHZCbW4fKwUBgVsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372862; c=relaxed/simple;
	bh=rGuT1Y2ktzcTZpxWUJuItVhSQ4yu5NMnFV6HNajWXHo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2h3Y6dzC5h91Gcxac45AvDDOYJPnTky62fHS94cV20+KB/vk+IEUNKL1b7tch3F35CQZ1c5N6yIfpaX9yaxOkWorTSMRI8yg3JIJJLjzWACaVSlzbtfilRfhfUCWQREmwvBjeT3VCxzUQEPqr/H1Q4yhKAYjpFYYOynQB/mJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=BkYzfemO; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="BkYzfemO"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64LEEAtw006296-64LEEAu0006296
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 May 2026 17:14:10 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wQ4A5-003oAZ-Vn;
	Thu, 21 May 2026 17:14:09 +0300
Received: from localhost (130.232.143.226) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 17:14:09 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 1dbc54e3;
	Thu, 21 May 2026 14:14:09 +0000 (UTC)
Date: Thu, 21 May 2026 17:14:09 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/4] approxidate: tweak special date formats
Message-ID: <20260521141409.5vXT3%taahol@utu.fi>
In-Reply-To: <xmqqik8g28gw.fsf@gitster.g>
References: <20260516151540.9611-1-taahol@utu.fi>
 <20260521105408.8222-1-taahol@utu.fi> <xmqqik8g28gw.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=zpism0e1k2mdO0MNnCLMF2b9oaV8hzJOLlFX3TkTpR0=;
 b=BkYzfemOb5k3it/81TuEJWE6S3Mb6UefhxnideSwrGijMdo24DgPq/1Zy3lU+3be9o5M7FLVmkpK
	5+QpTqQdQJY9hoO4xPCmA2hCCI515JSOWJ2uyIQwUm4zYgndxNrLkiy/KJ+Pv6LH8L7NvLuk9fBU
	XY6gowP/2dSfEJh/proNiSgH2YyPb/fcaH7klRgqdxwS5wILNrdvr5oe4OmQRRP/zYroHL6iUo0u
	MKftruCLl7CGWJx8TCMAXjIvunnpmXnCZrZHOH9VodEevnijOKduhlzGrp7OLLficZoCMzyAycrn
	ASttdycaD1lJdchhx1JGP3+Ckv68tt4jMvpH0w==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > -static void date_today(struct tm *tm, struct tm *now, int *num UNUSED)
> > +static void date_today(struct tm *tm, struct tm *now, int *num)
> >  {
> >  	if (tm->tm_hour == now->tm_hour &&
> >  	    tm->tm_min == now->tm_min &&
> >  	    tm->tm_sec == now->tm_sec)
> >  		date_time(tm, 0);
> > +	*num = 0;
> >  	tm->tm_mday = -1;
> >  	update_tm(tm, now, 0);
> >  }
> 
> Hmph, what is this change about?  Does the lack of this clearing
> break some test?
> 

As you can see, many other date_*() functions have that same assignment, too.
It looked a bit off, so I first left it out, but this revision does add a
corner case test[*] that would fail without it.

> In any case, will queue.  It seems that we are getting to the point
> of diminishing returns and better off declaring victory soonish?
> 

Yes, I agree.  The patch series is effectively finished as I don't have any
further itches or ideas.  And I think the series gets its work done quite well
actually.

> > +check_approxidate 'January 5th today pm' '2009-01-30 12:00:00'

[*] Namely, this one.
