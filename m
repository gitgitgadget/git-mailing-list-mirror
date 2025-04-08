Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D723A991
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127951; cv=none; b=kJQYE2R46ESQqORxJgM11IbpndgGsTYao1dze3TItPfGJKi49hUMdhnDU2diLi40NXPMhGaLQpOnCTaM308ynETHnnwzH+Yl/2RCBxRkoKXkLHUl5oGAHVm5Ixuk1oqQxRCfMrkBgHiKetM/a+kMZKdu+xBiWBFpXIRiIWYv7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127951; c=relaxed/simple;
	bh=kbm7bosDON+ZR2TtpinP0H8Em+Ov86+r82mwnA4AMVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZYlooXu6Ur+JLR3RAfgzcevU0z0hWJXkUcM79qwgX7PzJ1p1OIZfFhF0b3EXhV2rtjUwH2LP12LPldnFa2gCzWBEAdurFRZElxubde1lHs1xePOl79iw3ry0PCDkWPAQJqEN4QdRBsjXD6nVepRIYPjtnvim3iPCnVDKpLTiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoPJJ3ev; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoPJJ3ev"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1efc4577so3172298f8f.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127948; x=1744732748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tKW3BLRakTXqfI+34wrtm8RTSVq2kBBon9acVRtVjDs=;
        b=FoPJJ3evHO9ajMF1eibAyLTx2QIpLm+l+fl1GsgfiT7UNxeusR94ME6I3MjQPIsCcf
         knAd77qXIFEhVBdpZiEhRXnzC+gggo5x5oxDgcdc6wRJfreGi6O9bqgkEa7Aob9JnVGU
         xI3nplhyXB1/LJYVV2vMvD0c+AJbio3sakjiZNRCeOUBFAXDJ0TRFrX025KRKuCVWDRl
         vAwray71miPNI71U1if+jvH59Yy3rYMniIOaYQeVU8mGci5NP9tT61qqeyRm7jxtaEIn
         lvuRHXbUtF4foGOmut6p+4lippmChLPiQaWQb9w2d8i9hnehHnx64n/yaJ4dGNDhwUAj
         uoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127948; x=1744732748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKW3BLRakTXqfI+34wrtm8RTSVq2kBBon9acVRtVjDs=;
        b=rY4U7MA6GpfX/7/FzEEImhkhNOKvcgbJe1QyDaxqqbSOekVFuVxbFzccs4yXJC2xih
         HIdQV8fwMkaBWznacu9k90ingyl6juUQRlaLkQh342xWSw9Hp8ngVHgXdVQEN4ZiXxlG
         +HxSKIIiJtQKr6ncFHdlSy97kAVigWusm9E791y3IJwSpYbSzUW45ys44MV61G0cxS6n
         m/B6CFaEOkrSVKlYzzDguN+FogK50tjA+OyF0xAbAk/m8SVJ5Y9Usb03ZCaMnnBfxZdV
         cIT1Dn5WyKg76cS4C24u2U4NgRwxqndCJMr0h0+p10HZmVEMc5Xdn8jhs6vJ2vxgzZDB
         dtqA==
X-Gm-Message-State: AOJu0YwqEYKN1UaYqKrJv5KCjBwHiZo9Iz6eDVair6YuI5iqV26o8Jb4
	ENO7xsjZ/DB/WhJ6+CVYchOJ0w2TxkfLlN8K8+g1OtIKBAVwKJwZ
X-Gm-Gg: ASbGnctiptHWkohxY3afk5hbETfcGI7d/UHLEPysDA+fe9/oaq5yzHrfz5nolmNhz0L
	tzPjubAalgbe9D94DbZG+u4mOTOgg94VwgoXekjy1fjy9XYtm8YhHK83VS5vJ9ouIBN/kZAFTmr
	nTEzzOVh26BJFGPlmxnLbmM6Cmaivx2opP9VifnGKIazZ4r/x1KD3NsAZ+Ej/R5951vM8ZHimnz
	CsrVuEiNQMChW2NgCup7sqfY+JHAS8vXOnRYibjRsmNwhqEjUGn9QDl/2m465a8o+GlbUP0NT7P
	aRCIEfVXJXhkZTwVpie6S8Ex3/KtdJh1S7nABEpTUWwoEIot8kC3i1TYDAtmVF/RtsC3je7ONyN
	E6vUicgwGhEqOa2NsfWvP
X-Google-Smtp-Source: AGHT+IFmys+oVgm4VF7ZDZhnBWe8rRTWk+1XEtkKhpNX3F5gnHH/G6u4+5TOk9FtKZZqPxAtLxX3Eg==
X-Received: by 2002:a5d:59ae:0:b0:39c:2661:4ce0 with SMTP id ffacd0b85a97d-39cb35bd5d7mr15607655f8f.13.1744127947936;
        Tue, 08 Apr 2025 08:59:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16ba978sm168938495e9.23.2025.04.08.08.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 08:59:07 -0700 (PDT)
Message-ID: <3a5eeaef-05a1-4e04-8bc5-0d023e63f27c@gmail.com>
Date: Tue, 8 Apr 2025 16:58:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Junio C Hamano <gitster@pobox.com>,
 Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, Edwin Kempin
 <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
 <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
 <xmqqwmbuybhg.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqwmbuybhg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2025 15:27, Junio C Hamano wrote:
> Martin von Zweigbergk <martinvonz@google.com> writes:
> 
>>> A set of individual commits that share the same "change ID" is,
>>> unlike reflog entries which is an ordered set of tip of topics, not
>>> inherently ordered.  This is inevitable in the distributed world
>>> where many people can simultaneously work on improving a single
>>> "change" in many different ways, but making it difficult if not
>>> impossible to see how things evolved, simply because you first need
>>> to figure out the order of these commits that share the same "change
>>> ID".  Some may be independently evolved from the same ancestor
>>> iteration.  Some may be repeatedly worked on on a single strand of
>>> pearls (much like how development recorded in reflog entries of a
>>> single branch in a single user set-up goes).  I guess you would need
>>> a way to record the predecessor vs successor relationship of various
>>> commits that share the same "change ID", much like commits form DAG
>>> to represent ancestor vs descendant relationship.
>>
>> That is correct. The change ID should be sufficient for handling
>> simple distributed cases involving a single remote but it's not a full
>> replacement for something like Mercurial's Changeset Evolution [1].
> 
> Just a random thought.  We could very easily replace "change ID"
> with a concept of predecessor-successor commits.
> 
> Just like we can represent parents-children NxM transitive relation
> only with 0 or more "parent" commit object headers, we can record
> zero or more "predecessor" trailer in the commit log.
> 
>   (1) a commit with no "predecessor" is like "root commit" in the
>       commit history topology.  It is a brand new change that took
>       inspiration from nobody else and that is not a polished form of
>       any other existing commit.
> 
>   (2) a commit created as a refinement for one or more existing
>       commits record each of them as "predecessor" to it.  Having
>       more than one of them is like a "merge commit" in the commit
>       history topology and represents that two patches were squashed
>       into one.
> 
>   (3) Splitting an originally large change into multiple changes can
>       be represented the same way.  They share the same commit as
>       their "predecessor".  Perhaps you have originally two-commit
>       series, A and B, and split them differently in such a way that
>       C has half of a and D has the rest of A plus B.  In which case,
>       C has A as its predecessor while D has both A and B as its
>       predecessor.
> 
>   (4) Just like we can use auxiliary data structures like bitmaps to
>       figure out reachability without following all the links in the
>       commit history topology, we should be able to learn how a new
>       change was born, and trace how it evolved into newer iteration
>       of the moral equivalent of the change, possibly as a series
>       with mutiple commits, using auxiliary data structure, which
>       would represent predecessor-successor NxM transitive relation
>       in a similar way in a form that is efficient to access.
> 
> Something like this should allow us avoid relying on "change ID"s
> that can collide elsewhere in the world without having a central
> authority to assign them.

This is similar in spirit to the "git evolve" proposal [1]. One of the 
objections to that was that it required all of the rewritten commits to 
be pushed back to the remote, rather than just the current version. So 
if I rewrite a branch three times and push the result for review all of 
the intermediate state gets pushed as well. That is because the 
intermediate commits were needed to track the chain of rewritten commits 
  to avoid the problem Elijah described [2] when trying to follow 
cherry-picked-from trailers. If the predecessor information was stored 
separately to the commit it refers to (in a notes ref for example) then 
we could in principle simplify the chain of rewrites when pushing so 
that we only need to push the final version of the commit and a mapping 
from the version that we fetched from the remote.

Tracking predecessors as you describe is certainly a more complete 
solution to tracking the evolution of commits and it addresses the 
shortcomings of change-ids you outlined in your previous mail. It is a 
lot more work to implement though.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/pull.1356.git.1663959324.gitgitgadget@gmail.com/
[2] 
https://lore.kernel.org/git/CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com/

