Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1012580CF
	for <git@vger.kernel.org>; Sat, 16 May 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778939654; cv=none; b=lEdEGZgDgRuWv1XKBpXwYyoNwv4DdUjVJAI8i2r2ePxNGWlproJ8lW9KOGKKztWEG9msmeXpwNkfm6fo8zVutwyvJi+JOHxyMTf1J6ivrBW7NhLRTHl0JN4L2+YwhHuhsJ5KbbSTB4pKxRg++LRU0Kp5dVxjXehDHqoT80V1LzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778939654; c=relaxed/simple;
	bh=aXIntXI9JAcoZa2hYpBYXGtE8xeh4y0c/paHuGQk0F0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2zlgMRyI9YdENieGWovV0D+W5+D9GS8F3lvQLIDNKX7+5dUtIcWr5wyV53Ryg6TBenX8o6f5kV2bsoMhfTOg28lKDCsKGChOLa91rEZkaLE7nJikSVf5FFr7UMC2+ESvDU8MZ/9DQrGosXdZ84saw6cEB0pdLtyiXFqsMHCgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=A9jA1fUO; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="A9jA1fUO"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 64GDs1rM022513-64GDs1rO022513
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 16 May 2026 16:54:01 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wOFSr-00BEKJ-6g;
	Sat, 16 May 2026 16:54:01 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 16:54:00 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 496f0253;
	Sat, 16 May 2026 13:54:00 +0000 (UTC)
Date: Sat, 16 May 2026 16:54:00 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] approxidate: make "today" wrap to midnight
Message-ID: <20260516135400.2UqFV%taahol@utu.fi>
In-Reply-To: <xmqqik8ncw98.fsf@gitster.g>
References: <20260515205803.26211-1-taahol@utu.fi>
 <20260516113622.23902-1-taahol@utu.fi> <xmqqik8ncw98.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=+XeAxy7jbeN/LHr8BSHt/sBSJvHrYi4Nh/aNQ963RmM=;
 b=A9jA1fUOPbivDjxIVwq4RXyRybn28rxf+8UV8lgXqXn9fC4IFC2+wcbGW2lwytw59LzHSdI2Vd9f
	9Xshc/zmOzNllMcql/C98u2SK2k3kPlHNdfQjNKP2DWYrj0P+4TjNd1qq3mBhbLRswiEDFVXWKA9
	ASbdnzHxVMom041JvbQ0gLWzEZpgrs75m1EjZJYDdFTzKNgDtmFGExDwLu1Kc1dtSVHTlAi/f41G
	LFqGjBZ535inHYxQSPJgPUik4FPYg4Ftpw3Vs7yiw0aWG6W46kEXJl/24/JQd4Kd8pUNn8rsddP+
	YWEbqcOUPsKKq3kllV+VDrWrZzz6fvkRzCUuDg==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Although some commands do reject invalid approxidate expressions,
> > in other cases those are simply evaluated as the current time.
> > Oftentimes that is a perfectly good compromise to handle silly
> > requests, but it isn't without rough edges.
> > ...
> > Bind "today" to new function `date_today()` as an approxidate
> > special.  Make it return the last midnight if no specific time
> > is given; i.e. retain the old behavior of "noon today" and such.
> >
> > Document the new behavior of "git log --since=today" in
> > rev-list-options.adoc.
> >
> > Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> > ---
> 
> I like this construction of argument.
> 
> How does this patch mesh with your earlier effort to make "noon" and
> "tea" more sensible?  Should we eject the "today is now" step from
> that series and instead queue this patch in its place?
> 
> Thanks.

Yes.  I have already rebased the series on top of this patch.  I will
soon(ish) post v4 without "today is now" step.

--Tuomas
