Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0417CD
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061370; cv=none; b=Yud/YmotKvQAz8fvB1U8RxnBBiYms2jwpvcPaX4pshXdPL2Js/xX1Cvbd/+NYiW/rskagPYRNc4gmSpr6NV8tTErEF8alEGrsGb6U+x3GNYaFZO3HFkfyl7JrTAO0O/4Fy3rb+FpVzBggYdFqOTwhC1317Ujp2WXES/QFS8P7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061370; c=relaxed/simple;
	bh=GhTkIpKmOZi+AJRDz76rOQ3ernNKJcGALBwG1DAp9ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNEfBN1G/eqtyzo8eSdpzcZMtt61Hc62llfFd+877ncKG+r6WgJFl9uT8+frQoowInLV/sN+lhLu2e1oR8iVL6w/hO3aCYWQqs9880CM06DMOGsTND8jBRKxBjHCCYcT4fqPBsTUHjpfY59oiDEKH9jZ1003cxwYXYwsQmELnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4SdNH8z; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4SdNH8z"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221816e3ab9so713299fac.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711061367; x=1711666167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQFVj4Zh/5SUu/ekLlNGEzvcGBU2UiAB08JKcptiKUw=;
        b=l4SdNH8zChaS0ctl9RKnbIg8dQE//VfGJpaXo7Px/U5BwqTYJk1KHyb3NhG+ruyXgA
         ppdTc+qXbkrgWuK5F46/e8nYltHlZudZQjHI2a0gp1OIfCL9Fz5SoYDIRAvscireBVzo
         T5WKJN5vv0rNG+yvV20t/ZVOqmWaFc1KQBgv7FUe74oT2FqD/d61orPiF3Xj7xdkfwiS
         /5gUghXsynAuAnBYu2nGQCWsMNXAg/wNI3wC94UR3JpPDgNNu3orlTcujkFhcBsONcIF
         Dl1LyBjeRwOHRG7EdHy8AM1Nu6YgVxZaRqigur8uNwRUsimZV9XtaMhxvGTupowgHSXx
         n2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711061367; x=1711666167;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQFVj4Zh/5SUu/ekLlNGEzvcGBU2UiAB08JKcptiKUw=;
        b=tDx4DZpQLF9cwWDcrUTzpepRt0H0cNEAlM6mJuo1mgzye+UgUsWJlXGMwlHUb3wkKw
         tzD9lSQ8o1vhKbXY/cNXs6RcM1CB2VgoJ8l1hQc91YS98wh62EHw4r3za/lSeN32UW28
         cQz/EThKUMCpgJbzROaTu0FwXExH3Dr3BF/4+8O+D16HNKInnUIee4PCjzdCzWexpdS8
         0uoix50kYu7pS02vjx04PI5A8ViRkYu3rNGgVNmDOi6Nit2JGKMBugaSSyVc0hWGBxN4
         4513I6il//OHa5eoucXQ2aBClw4tCqmPd0VTaD0ethZvArM+KbmSr0ofOFgtzy+VzeN8
         9sKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDA4VjtkIPLfOT4CLgHxSYdZss0iDadDdS8Q1w+827bAqPCbhoFUJ9zu0fjzkNp/KAdAqOnOAG6W6sGllQSHuPe80/
X-Gm-Message-State: AOJu0Yyz8SRqCVio1n1qWszxRzg7WTBzi9WJGIEPyisTCEyBn5qvbJ4R
	XPt9wEO4wmvBT+WQs7aEAEjI7MyZ8KtO0X7Cl/FEiKx9ylGGQzoI
X-Google-Smtp-Source: AGHT+IGhPDcRBhpFAjwoIhC/ab6ZsdXj5tEuKJfPUjcc2whOiYOtuuP36dyTtVj4HHuX+VOGpDjiGA==
X-Received: by 2002:a05:6870:649f:b0:221:c9ef:43c with SMTP id cz31-20020a056870649f00b00221c9ef043cmr716808oab.1.1711061367662;
        Thu, 21 Mar 2024 15:49:27 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id hx27-20020a056871531b00b0022260d13f18sm193775oac.25.2024.03.21.15.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 15:49:27 -0700 (PDT)
Date: Thu, 21 Mar 2024 17:48:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH] reftable/stack: use geometric table compaction
Message-ID: <g55luyh5diq6w4d5jigkhrwnxfu4ekz6nb2s7sjug2agjoexd5@63cyzht4ihcx>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <ZehjoXhH6deTJmSm@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehjoXhH6deTJmSm@tanuki>

On 24/03/06 01:37PM, Patrick Steinhardt wrote:
> On Tue, Mar 05, 2024 at 08:03:45PM +0000, Justin Tobler via GitGitGadget wrote:
> > From: Justin Tobler <jltobler@gmail.com>
> > @@ -1305,7 +1287,7 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
> >  		suggest_compaction_segment(sizes, st->merged->stack_len);
> >  	reftable_free(sizes);
> >  	if (segment_size(&seg) > 0)
> > -		return stack_compact_range_stats(st, seg.start, seg.end - 1,
> > +		return stack_compact_range_stats(st, seg.start, seg.end,
> >  						 NULL);
> >  
> >  	return 0;
> 
> One more thing: I think it would make sense to move the refactoring
> where you change whether the end segment index is inclusive or exclusive
> into a separate patch so that it's easier to reason about. Also, the
> fact that no tests would require changes would further stress the point
> that this is a mere refactoring without unintended side effects.

The `test_suggest_compaction_segment()` in `stack_test.c` does have to
be updated to reflect the segment end now being inclusive. But other
than that, no tests have to be updated.

Thanks Patrick for all the great feedback! I've updated per your
comments in V2 of the patch series.

-Justin
