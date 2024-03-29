Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE033BB2A
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745048; cv=none; b=OQOWfvKek/QIZ6ePmcP0baacwl20w2LuPrmNfqVu4xtOCWwuFYCQZqPO4MJEl4lhQkFweJogL1nmeLGWAyHcFybwBdB0qFP+i00h9BItlKaf74cFhdvX+xcqVQGmRUax/oz6+fZDbrBojAVEx0WHQYDEIECS5q8O8lOTFOlt45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745048; c=relaxed/simple;
	bh=DlD2FCvI+tHAFikFQCbWmrxu1vhJmO0VwP9PYXECjhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJYriZEKGbuKcSse+ASr89+OHOUrvgjHxVfx2Gh+u0wvj3KfwIHVE1d49Kt0M8it7NUPl4/BDjOz+9l7Chtu9/8KC65IBxDdcBYDVtlm4oiG79BaHSd66QwOlV+8iyCFouSq3LH28rlqli7LE7BmhDxX9x/eQ9+sfj8NCX8LWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.washington.edu; spf=pass smtp.mailfrom=cs.washington.edu; dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b=gugjqdzm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.washington.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.washington.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="gugjqdzm"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso2913471a12.1
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206; t=1711745045; x=1712349845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0nVvHfdMRzmbIqC/21yuRajgovcIpjaZ7HZwyAYTuaw=;
        b=gugjqdzmCtzPcJ3c2pIol7RF09hRbpAnON66cFuSXw9qK6hhbOGxVwFc09DwgNmCV+
         aRmr69UxYRsE9oUxH0oR4loZmrcYJKjC2NUBAaa6hUfyaupPROqTj1ApA5eXP6Vdi6UZ
         QGHIADqqNbLjBCOq2eLuopFevjlM5lJuoeteg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711745045; x=1712349845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nVvHfdMRzmbIqC/21yuRajgovcIpjaZ7HZwyAYTuaw=;
        b=Ix9sYgbvqH3Y1goXEq0IBd1s8EV0n96L4k1KcI5i/2w9hPArO3oM8jC6Kdb8gG5kil
         CnIiTlUSQ3eeew7Z6EZtoSvBVZhju779yvW4vgh0DC/0bsiSCVA+HRE0q0q9qfpXrvIh
         i9lLB1XF+kL+EDYLS4H/uRJjtCnmgo2AVhmHKUMRKnuEpKAKke4PoYCzwufPBmZ/gt1i
         9uqOiREEQ/Tb6AeqOBtSaRgdILWnmSlK7FAKmjcALZHCA9251yMoCLy3QK4r6r7i6Dhc
         hJLwO6gxJ6wZYbHsxMNAFq0q+0prpYw95Vl5BMxeqlQocG1jJHYLjnobB4+ldoWkRoeI
         8jYA==
X-Gm-Message-State: AOJu0YwZWHha3vpAW6OY4ysmHnMZIoKXfIm4HvrmQ9zsXyd2prlVaSes
	YbraOOwuR81tL1H8PjX96zR7QdFyOoviawvUeg7Oj6JhL2SLpWjByVXHaaspoxGKItw42m4DezX
	htkeOwXLMjPPK3mR9bTysHIGq2Ap5OLgi29Jh
X-Google-Smtp-Source: AGHT+IG58yFXgn+bjiogZqQQtzov0stgA3PHy5ajsrdmzVwB/1HtQsKyz0CrLK8Zf+47sPLl45DUZ2gM+OYWz+78lKE=
X-Received: by 2002:a50:d64e:0:b0:568:d7fe:a857 with SMTP id
 c14-20020a50d64e000000b00568d7fea857mr1887217edj.11.1711745044982; Fri, 29
 Mar 2024 13:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
 <xmqqfrw8ygg2.fsf@gitster.g>
In-Reply-To: <xmqqfrw8ygg2.fsf@gitster.g>
From: Michael Ernst <mernst@cs.washington.edu>
Date: Fri, 29 Mar 2024 13:43:53 -0700
Message-ID: <CAAJCdQQceA7yANHCPzUGbANR-XKVDUzfN5ym6Rb-oEWgcq=4Uw@mail.gmail.com>
Subject: Re: Feature request: a merge strategy that makes any file difference
 a merge conflict
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio-

Thank you for the clarification.  There is a lot of misleading
information about this on the Internet.

I was mistaken about when a merge driver is called.  Now I see that
the merge driver is called anytime that no two of
{base,parent1,parent2} are the same.  This means that a merge driver
*can* prevent a clean-but-incorrect merge.  I was right that a
mergetool cannot be used to correct a clean-but-incorrect merge.

-Mike
