Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CF878C8C
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987013; cv=none; b=ZV4SKEZq0vIXfj7Mz9l/LKXw8HBCwUa94CMFd9UIqURAT+FS0WDBxK4F7N/+dEfRc1qqBHOcB0yHaJ/j1Y7uJkqnOpAP4ghEQhOW1OeFhvwUoThOPTktDGulbmXgl8/KQbf7EzsDEyIXCPnKHepEeeBpb4eUlg+/HVGt2QOggzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987013; c=relaxed/simple;
	bh=bEb+M6+2E4HzxwY/utsJVuYTcSNwMo4WxjELdg1ureo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POpDWB3BHtj6/g/6mHAPoSnutEqJN1Ot7UeJqgU1Qqi8wsmCNeVu2ynioKhJLt4Lg/87Lx2FJAhSEetUY7Ev3g5IKBwH29Lh1C2wdyGAwGHTFdB4guYhMsUPOl26cbKbhg1sR6VnyQzDRNnrTNPp0Fwi82WROhIhzuqHTRys02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSLl4/75; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSLl4/75"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so175555a12.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713987011; x=1714591811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lyEzW1L8yLYLADfxwWLaRfWwdPoIiNKpI4xOjcATsg=;
        b=sSLl4/750cxJ0awW6UgTU5pfKhFvpXsZyph0rdfKLOjMDPWAqMqmuvOkyAx4GvvzPX
         0WkjUK1EUHV5qB8LTGzJQGHtXgUrfz4zHcUKQL3kzk32atOOlU2xU8dZU3LrKR8EixNm
         l2lv911Y0aCPBZcHrA0sduVUENGZQXbsNCA431eCl8ccsMgnYpzhQ8DDSG0vflzrgbgh
         3liBh74HqDr3Q7a6T5xIoODyX58nzulrg9gSiOEzd+QBnEonX4wz5hqgP6OajlOQ3jke
         U1v+12PptW4f+B/uICFR/8dhMg3EkYvXE1NQOfHk8oR1cF+hSB2gn8mpe8aWLZrZ09qA
         Cp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987011; x=1714591811;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lyEzW1L8yLYLADfxwWLaRfWwdPoIiNKpI4xOjcATsg=;
        b=JzBYNk83QSspHVNbfKulQ8jQLyh93zlVISDhnHjzVhvQG3PZ1cSY82buNxoap8X6Aj
         ROm09Xv+N2aLzxbum9ZmVEQBNhv117EhJeFCrfwLXqUJ83Bj3uDh1tjl4MizgT/i5va6
         xhqlmlq6jlnIVMvFXwtVoTzw0lnLqswb0eukWBUZZBVzCyqskK01mzNBN533UP4gRQj1
         LQu/TAFY/tmm1IaKa5mS5m6dTwAQTqEcyPuEyCJe+7MDTmogMUniRr/GTByvTJLvGNgm
         Q+QfzQDOWcvH83YJVEziNGIQi4USB2uWRxIceIUAecDmeKQPoWKYySIdxCyXyv9ZyJyR
         MKhQ==
X-Gm-Message-State: AOJu0Yx+zJepFnF4o6CNtFofacbXHXXYMPVVMp0zThVzCUB5OqlZ8Tlt
	Z8kD/Nm0wXR6PhYMZHz0RkeI5mO7CxalMKnlZdkod5NTq/o1CoUD/0SEsBrtyA==
X-Google-Smtp-Source: AGHT+IE4yAiu8H5JKXVmu/h6dFDexT5mu3m3Iv4QTasq4EiiYDiQFqXOdQnf+5IBW6z3TyziE0zyWA==
X-Received: by 2002:a05:6a20:dd9f:b0:1a9:97d2:8082 with SMTP id kw31-20020a056a20dd9f00b001a997d28082mr3404983pzb.9.1713987010976;
        Wed, 24 Apr 2024 12:30:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
        by smtp.gmail.com with ESMTPSA id fu16-20020a056a00611000b006ecca2f2a32sm11813902pfb.168.2024.04.24.12.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:30:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:30:05 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] commit-graph: suggest deleting corrupt graphs
Message-ID: <sc4xgsvzioqglqtsaqww56vctehfzkomy7wr574y3su6optu6t@punugznrq7bk>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1708643825.git.steadmon@google.com>
 <xmqqwmqw82pv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmqw82pv.fsf@gitster.g>

On 2024.02.22 16:05, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > At $WORK, we've had a few occasions where someone's commit-graph becomes
> > corrupt, and hits various BUG()s that block their day-to-day work. When
> > this happens, we advise the user to either disable the commit graph, or
> > to delete it and let it be regenerated.
> >
> > It would be a nicer user experience if we can make this a self-serve
> > procedure. To do this, let's add a new `git commit-graph clear`
> > subcommand so that users don't need to manually delete files under their
> > .git directories. And to make it self-documenting, update various BUG(),
> > die(), and error() messages to suggest removing the commit graph to
> > recover from the corruption.
> 
> I am of two minds.
> 
> For one, if we know there is a corruption and if we know that we
> will certainly recover cleanly if we removed these files, it would
> be fair for an end-user to respond with: instead of telling me to
> run "commit-graph clear", you can run it for me, can't you?
> 
> The other one is if it hinders debugging the root cause to run
> "clear", whether it is done by the end-user or by the mechanism that
> detects and dies upon discovery of a corruption.  Do we know how
> these commit-graph files become corrupt?  How valuable would these
> corrupt files be to help us track down where the corruption comes
> from?  If they are not all that useful in debugging, then removing
> them ourselves or telling users to remove them may be OK, of course.
> 
> Do these BUG()s come from corruption that can be diagnosed upfront
> when we "open" the commit-graph files?  I am wondering if it would
> be the matter of teaching prepare_commit_graph() to check for
> corruption and return without enabling the support.
> 
> Thanks.

Sorry for the late reply, this got buried in my inbox. The corruption we
saw was related to a generation numbers bug [1] that I think was only
present for a short while in 'next'.

[1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/

I believe that being able to examine the files after the corruption was
detected did help us narrow down the issue, so I would lean towards not
automatically deleting them upon detecting corruption.

I don't think that this case would be detectable without running a full
`git commit-graph verify` up front.
