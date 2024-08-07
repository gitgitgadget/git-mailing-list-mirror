Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126112C460
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071301; cv=none; b=hlqKe9es5pGwsh3s69A5dA9WvPNhdHlXLZb9axNxUb0+9bvJtlv1x5rEyGClOCPwlmR0iccapyD0NliP7GMgHLMqdYsAaKf1GiKUzQW1wxblgM/pnb20plj8N5inqqFswRGY2NdbNA1lPsRY4l/o7YLLCfLsFwFixemA4cYj4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071301; c=relaxed/simple;
	bh=GxbeoUv1iFzg/FRwF+Vv4tj8icnlJOM7WNFDqaCUH/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iie/sH6c2ySF4nOpmwHJDJPI1+/crW0U0+7xsBi+ljZOWZULk4WflV0zprVutZOfX8mLSMr0YMlny8qz0Zxdk83gFSWGFin0IKx2d15RYwdYGyd7ta1b/T8bC30yhpkPVb1nGQ2tnCb285axnDQsiJoPP0dmjwKQDsdSeYaxckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wMU8oM93; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMU8oM93"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so332300a91.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 15:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723071299; x=1723676099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3X3k18Q1ryzMZS4Geho3ct4nQftw6hnhwpmqzaDo/8=;
        b=wMU8oM932XIDk5HKAs4tvPtCn0dqxHcULNaSd5PICPiT52MBMhJ6hLkF8/ZHwjA2Cd
         N+XOKnC4ohFmYRLX4yL2/s0fmv/xjxmcGiBz+X4wsb7cCcZUIfDklN9XLUwh+ykY5AM3
         8hmaDA4BNev+SdfQ1fmNwAbThq2rNDyd6Hy8Y600VygkcX0KqcPia8OkUzOtGFCxSzlk
         BqgGtM8smP6mo3os8hr7HhN7chPFLy5Z2s56zVrzRrHaNEEBHB5sJPGS5OiaxRypjilV
         Gf3lGOZlIxD+aeOoaHi9GhK1JfT1yrQQyc3w3P9IQtoYcoxY8G7gzTjOXz1EhCTr/tbc
         4k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071299; x=1723676099;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3X3k18Q1ryzMZS4Geho3ct4nQftw6hnhwpmqzaDo/8=;
        b=FcYO3Ho3OGqZSmgbgpASUXw1xlaLJoJ4DR7d1RAZr+xUl6RcJtf/AvIfgYic/t4T+p
         m36N68WEe7x6K7cfkFNAhwxApmObanWTP4DIVHS6e3/WJvrTdb7mOvuNzEbphjVKPuqB
         5AP5rYOdhAwa70DxJRuUWkNbss45AN/zNXvDum7MSgrFS27ecdwDU5qjW92OtslAPsBb
         BQs8QxApEerzbb1y9B3QauMfFCVZ3dmrMJmbo/INm69ZoEbs/Aj0OKOtHkl5slfpaQoV
         QzPAykjJKqiCGDHwYqFR6HjxmSv1YKHYToDpcV7aOQK/dm+CDc4E7OPhD5PBZAioLHhs
         vNOw==
X-Gm-Message-State: AOJu0YxTC0NP5Mv0i4+S/rlyIxVIZEGvDjItTP0fdxKSJB7u1Um1oZqW
	c4YyyCuwF0t3nMWxQi1OHGORyyChLPCoun1ejZoFY4UpXTEg2NXbvMb5/5OHcQ==
X-Google-Smtp-Source: AGHT+IH3apDkdHlF9bZi/rEb6Rp9OlKjWxldUrh4Jj+iL3OkxwMS7x0SDQTGUUHKavNEkWvXut+WxA==
X-Received: by 2002:a17:90b:3886:b0:2ca:8a93:a40b with SMTP id 98e67ed59e1d1-2d1c3450a5fmr78636a91.31.1723071299013;
        Wed, 07 Aug 2024 15:54:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab3baesm2151749a91.15.2024.08.07.15.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:54:58 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:54:53 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 1/6] common-main: split common_exit() into a new file
Message-ID: <s3goovaobkxlq5kmhcycfxh7mt3bw7igrsyi7dqttkbcgpqtcn@wjixqesll5tx>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <78c2aa2ef9351d977f31dbbb16b148baf254ad59.1723054623.git.steadmon@google.com>
 <xmqqr0b0ni5n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0b0ni5n.fsf@gitster.g>

On 2024.08.07 14:21, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/common-exit.c b/common-exit.c
> > new file mode 100644
> > index 0000000000..1aaa538be3
> > --- /dev/null
> > +++ b/common-exit.c
> > @@ -0,0 +1,26 @@
> > +#include "git-compat-util.h"
> > +#include "trace2.h"
> > +
> > +static void check_bug_if_BUG(void)
> > +{
> > +	if (!bug_called_must_BUG)
> > +		return;
> > +	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
> > +}
> 
> Nice that this can stay file-scope static.
> 
> > +/* We wrap exit() to call common_exit() in git-compat-util.h */
> > +int common_exit(const char *file, int line, int code)
> > +{
> > +	/*
> > +	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
> > +	 * to e.g. turn -1 into 255. On a POSIX system this is
> > +	 * redundant, see exit(3) and wait(2), but as it doesn't harm
> > +	 * anything there we don't need to guard this with an "ifdef".
> > +	 */
> > +	code &= 0xff;
> > +
> > +	check_bug_if_BUG();
> > +	trace2_cmd_exit_fl(file, line, code);
> > +
> > +	return code;
> > +}
> 
> I wonder if at least the part that primes the trace2 system needs to
> also be split out of the file that defines our own main(), though.
> 
> Are libgit.a users now responsible for calling things like
> trace2_initialize_clock(), trace2_initialize(), etc., themselves?  I
> am wondering if these calls are encapsulated into a simple helper
> function, say common_startup(), then the story we need to tell the
> libgit.a users may become simpler, i.e. you call common_startup, do
> your things, and then you somehow cause common_exit() to be called.

Yeah, I actually already have a fixup patch to move the initialization
into a separate object file as well. Will include in V2.

