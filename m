Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58A1BBBF1
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437733; cv=none; b=iyV+VGYlW6OhFt49R6wnYVRDtJ3xOBcCImjNuNcdKqPlW/uqVZCZ/ANgIrhpxDv1W3dJJbSEjLLtanrSyUmFjZCDRTumHU6TloBwqynxF5/Phu9zC5CqbpkoC5J+z9s6+RjnQDBJVQa0igUIUZ4fUOgxHviERr5WHAGAwBZuKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437733; c=relaxed/simple;
	bh=I9HpZR/N86c0n62tEHRiUQymAX0kDcdaBNh/szvAcR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTpbDrNgNQwdnWrwZfyUB0MYIMzb4gJA+po699l8nfqRH4FRI7d6n7lCYruwlZeLBLIDFB8qNIEDzsU+fNHKgFzwBmj+XeRwo0nToQd1/EPuiYM9dLmyI9TXbYrf4lSkUbrsFBrxB5l5W9233/IPfr+n++R94TCFzEY9hlgBPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzhMcnBv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzhMcnBv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2154dc36907so58095ad.0
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733437731; x=1734042531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux6kiNRpvutWolGmscnhm1aXKgruAYp4tXfwTSRsSCY=;
        b=IzhMcnBvFeWSwlMXoe954niNGDHVKc0/y9X+Kh5CVK+YYNI3QGmZFl/I4DTg3UH5iq
         WoLd5rWm4nvxAH/atkZLTyHTwTCJ8Rt7sH72l6mQpPXLcvEVDJyXYWvMEVIKHcco4GwL
         EwQMcloPkQeqiq3xXgHZAWVnIEsKPqgJIDKv2kcdW6j1jZegHKimhvbX52WKU8aoCQdQ
         6hxldL64Jz/X72QF0XyX/hOR1rmOi40bDB1GiCtlqecpESyqOEVc6R4Tsif3nswuvh6U
         MtQavrY0GohUYCiGcwO1sXw0WfmUnhqRupq5eO77dDDEhKQBYbpUHStTXTBiiMIi68Ls
         9rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733437731; x=1734042531;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux6kiNRpvutWolGmscnhm1aXKgruAYp4tXfwTSRsSCY=;
        b=g05EMSpYzajykEgnBa1Jhawq7UzajheKPHJ/j6dOwQcKD0eVSG5aFmREkymTZkF+CS
         ST+LFwNmORDOnV9wjElRdqWehVE1IlYrhsj7nAQw71/uFttf6zSlyYTi4BvZjFSYxrQq
         HvCE6FjRLtO+jfGRdZGAxuKqE1wNe306cqkCRjbFF0FCR8OocmJg0jLMvN5KJLJZmCnE
         S1oP9gpMyvRSfxclllU61H6hEM7BHrwCq5pJUP9ea/nvDxWBQJHSoWPoAzmrOa4xR3Z+
         q+SttK5z9Vkbnfbrem8gEw2YH2oWetE+LuvLlvMw844nKuRx8LK+JTA0xZPqNSX9qa0o
         ydJQ==
X-Gm-Message-State: AOJu0YwcH3Z+SXjzYabxcKK/qZbqb4BAEEkoonwkCJBgTQRzlYFfCDME
	0xznkyl5jYKTYI0xji1HQO6ln95YlJmvceEpPSPncroX/X0ZduQ4nZlZNsd1lQ==
X-Gm-Gg: ASbGncvzWzptadlvarJsMBT55G9hh6sRYj4+T1je5lUDbA0/2DgrFcEX3zAW+X2UQXZ
	+1vYNFQ/Wh3sfEPWpKaZNa9lEuvnDC3/d0mV/KqcfyX8qfnKTX7utb0yfiQ74sK9gB0qrz0Ce9r
	MjDWqf9jTr4Jk99EiNxf52n7fqhTLH6Wmj14evGPmP3CdphZa0AJLARAO3ETYyx2QNH1y8xXMIo
	j7yYGXdO/cVXI3mpLWgT/CsydgI+X/PdV04Cg5TzMRfQ1Nx
X-Google-Smtp-Source: AGHT+IE81bLgQG9qBjET46EIrqZT10XSo0D+1ApkpX6tpT5TBP1pbJnlPJPh5ETlZ1rIT39208Qf7A==
X-Received: by 2002:a17:903:290:b0:215:a3e9:88cc with SMTP id d9443c01a7336-216166a307dmr223325ad.3.1733437731000;
        Thu, 05 Dec 2024 14:28:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:80c2:988f:e15c:5983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45fa6688sm1878854a91.24.2024.12.05.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:28:50 -0800 (PST)
Date: Thu, 5 Dec 2024 14:28:45 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, benno.martin.evers@gmail.com, 
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] describe: drop early return for max_candidates == 0
Message-ID: <plncccgcchrmspkelepacifqpfua7nzsb4y5xzjv4vzc3p36yr@r63i2xo6avba>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com, 
	benno.martin.evers@gmail.com, benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org, 
	masahiroy@kernel.org
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
 <20241205201449.GA2635755@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205201449.GA2635755@coredump.intra.peff.net>

On 2024.12.05 15:14, Jeff King wrote:
> On Wed, Dec 04, 2024 at 06:27:50PM -0500, Jeff King wrote:
> 
> > > Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names
> > 
> > This commit is already in 'next', so it's too late to squash in a change
> > (though I'd have done this separately anyway, as it's already an issue
> > for a manual --candidates=0 setting, as unlikely as that is).
> > 
> > Can you re-send with a full commit message?
> 
> Actually, after thinking on this a bit more, I think the solution below
> is a bit more elegant. This can go on top of jk/describe-perf.
> 

Thanks, and sorry for not replying earlier, I got distracted by a
different $DAYJOB breakage:
https://lore.kernel.org/git/b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com/
