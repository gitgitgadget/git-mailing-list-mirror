Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780523208
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189560; cv=none; b=ATC7OxreeTiWow5NVOCRrX2ZKhZ6V3jN5ENiXS3mcLdkGST++zt8vDkwl9ZtZUfJq5uqOz+ovP+/gt+ySmihk358K36StT7yqjFksogtia30R+R458y1n5Uz/SySlTX3YUy5KJE2yvFfoRa4KbWQN88dn4L89uRdnIjF6xoFhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189560; c=relaxed/simple;
	bh=C8Kldw4QsrYeQ77O6eKm4xkSyywCUTeqk6jK2MY6gi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze0c9iFLD/836z6nhlLIDuWtuw76es6iTaz12wYdYjnfzc0JnQBUSsqrpSntjRGroSe9Uj2MD1nlSiBN09355QCuGRFzqbvWlzGfjDpR4laang5hBG5Szps5sgfHYUf+Up3XVdVjkA8x4UiRIDYO0Jmh7WESP7/65jxsRaneqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=L5liEKQ0; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="L5liEKQ0"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-711756ae8c9so11942267b3.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752189557; x=1752794357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fBWYHs2pN102p8115r8OTpUprfsCYbSmi/6BAyiqTY=;
        b=L5liEKQ01J5eYmSFOK060huGQTzWuYi4dfKccgyCaCbnfhjnHgI83gQYfSbja40ile
         jd6xZNnbiTH0DarH6q3puebg27eHjFqlK7odkYWYYdqniIY4A1DzJ+DYFUHn9eHKkORw
         vGA2AR44B0mjAzv848VYcc6Bccxjf8Drx+25oEW9GgzeCuwNo75Fa4L6UekofNbpu75d
         bEW8DP/LK2RmIgOiuZgqBKdFkcd7QswMVyn4hBdaXwzcGxy79BKR0VTygLeOigBy06Ly
         MjJSe21xP7F9OStc3BXtTWlqLfxeTksJIeorbiBNocEwSHhMHHnJ2Tk2UTQmom1h6wmg
         P5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189557; x=1752794357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fBWYHs2pN102p8115r8OTpUprfsCYbSmi/6BAyiqTY=;
        b=csau1tybBKLSFWWrFWcwUuIaocyzu6z3BahnHxkCNdW5I23pPRbacpQRIjIc7o6a2t
         QsgfV4VSwS+RaQPH5eRsDSzxM2YCCePFi4cYiHmz1+MX4LlvGR/cBKmGM9fcLhZMAcNw
         UBM8kqTuVm6DQV6A150FbDk+Ds71Z2Sh92lZftOvVFff5WIddWm8R3swN9VQD0J6gcFf
         pB/ZsB7zCCV+ki9zXRpzlQ8kHw/w42KJbM9MaXsKD7SpIrQvVXjS6eoBWEZRWjAwhEoR
         8h3yREB984a1vlXgnyLYMJ7YbkC+B9uWQzYUDBn1HUE7LFPgK/mMiv0hpzlLiteRrFKf
         Pjbw==
X-Gm-Message-State: AOJu0Yw2zLwqW1ZMO3FZmI5QumDIw12NS97f0jAp8AUeIF+XwkCjgO9P
	dbnlrV3IWQADLxC2GQevQaeMAH6PUMkHT8LpP8/PCo7m2sIrsbk28w1d+D0W0TfPf0aywmazIOA
	acjDLHQM=
X-Gm-Gg: ASbGncvauHILB5z+PSFy0f51ma244/QrBcKZtW7WwhXOaVMVKdYj4Y1RGF6cbQHNWFQ
	wxS9PtDHcx+F9Z23p8rrbEUzUaZ+EF/E96ZZP6uUxTiKN6sY2gOtCfb1Y9Z1YOixLQmjuh68xSO
	pisVBcKHd+Q4xsuRtsRwavR9ke5sbFKa7LP268pG/01wBBN42sC++XgU5hL3qtyOmBfT2YruKBJ
	n2VuAvljTl0MGegzck8R4o4IIqD4Vi7Fsm/7lCaFGmBE31M6CzjMccKZwlkiThmDV/WSubuxZeW
	0KbC0r05G/m4xXEwHVlnTno2Xakawg90OF3tuELBZa79Bx5EPZryuYqH0Of6osuczIgc+XiCLx8
	/sWL5qXo8t+haCd+StxVx0WodIHIyUnmktjhfTkxpC6Dmo7IFbAc+KhinlRsGaX01t2hDbA==
X-Google-Smtp-Source: AGHT+IGuS4OvlwxJcec8v0xCN5Ts06TSWS06cl1J20Xsfnugi/c7m5bsfet6JiY+bBSMrikAKcwobg==
X-Received: by 2002:a05:690c:fc9:b0:711:406f:7735 with SMTP id 00721157ae682-717d5d7b900mr28643287b3.13.1752189557323;
        Thu, 10 Jul 2025 16:19:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d72ca2sm5104517b3.32.2025.07.10.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:19:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:19:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] midx: start tracking per object database source
Message-ID: <aHBKdGfVfn7Xigip@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-1-f31150d21331@pks.im>
 <aHBISjW/OErOy3Cp@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHBISjW/OErOy3Cp@nand.local>

On Thu, Jul 10, 2025 at 07:10:02PM -0400, Taylor Blau wrote:
> On Wed, Jul 09, 2025 at 09:54:49AM +0200, Patrick Steinhardt wrote:
> > Multi-pack indices are tracked via `struct multi_pack_index`. This data
> > structure is stored as a linked list inside `struct object_database`,
> > which is the global database that spans across all of the object
> > sources.
> >
> > This layout causes two problems:
> >
> >   - Multi-pack indices aren't global to an object database, but instead
> >     there can be one multi-pack index per source. This creates a
> >     mismatch between the on-disk layout and how things are organized in
> >     the object database subsystems and makes some parts, like figuring
> >     out whether a source has an MIDX, quite awkward.
>
> This is a little confusing to me. What do we consider to be an "object
> database", and what do we consider to be a "source"?
>
> For instance, if I have a repository with one or more alternates, I
> would imagine that each alternate is a separate "source", and the
> sources together comprise the object database. Does that match the way
> you're thinking about it?
>
> If so, that makes sense. But if not (i.e., we consider all alternates to
> belong to the same object database and share a single source), then I
> don't know how this will interact with the existing MIDX alternates
> mechanism.
>
> Some clarification here would be helpful, I think.

Ahh..., after applying part of this series locally, the documentation in
"struct odb_source" clarifies that (at least as of yet) there is one
source per alternate, along with a source for the local object database,
and that these collection of sources comprise the object database.

Makes sense.

Thanks,
Taylor
