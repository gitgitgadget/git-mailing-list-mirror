Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B8632
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513979; cv=none; b=dHN/MYYTp8uUSyoM9oOcgeJOuP1X0+JeOhEMwZklivK55WadBy0FMUNgluGyBhg/b5sPOI1phwRoGKjLLRoz3Rqq1T7916tAjUsjtWlt24OKXMGu7EI0KaZlshsLGPtRI6adEHMBzN7fXggG+mvVCb5j8urAC+ade7hLfDKjHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513979; c=relaxed/simple;
	bh=VTWBrNh1PrxJm+Kg9aX5XIbLohdbO4o0Wj6WzRxnAnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AEy8QCkg8JMdiPQkz1zbAbUP1Xdu235r0I9EQMkDSMufofKuSHWNhSgGxTkC58RxqFV/GSkPOrkRcgvaUSm9pOtnHRFw+NmZXswO90MAQ3ABtLLBE3zxa4tuH1LvYCQF/FGvZ7bwvrhiA7cChsP3/2CyA2fkrKuF5inPyIN23n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaUxKDVh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaUxKDVh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6f571so115080517b3.1
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711513977; x=1712118777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxKU8l0j+qJqRwQBFeKwWnCv4cj11z9T7qvYlQt8KEM=;
        b=IaUxKDVhSC89wA9aYTQmy4ff9tm34mVv+tXse7p/dX3uASifEoK+BfYjkMt+hARa4Y
         oJwTCy9hVnpEfPr6YPNZCr8Io1j5tGLGcVEdsd50BZpr2KxMBl0Iqrin/V4WIkZsFem8
         fltWrkx5h8QDuqgNT7XV5Erq1XeNnTKrOsYrvFs98qVrV3JnpMCfbDhg6RkhA5AJkuWx
         R0d83lg1qjZYnfIRQQ/+Je0olRvY3N9abSXtCVkUwlkEhiRgLG7Sj/21pK4VRarc1AzO
         u5dkDzv4Oi1J1luZ1ymkFxcinySs8eBEHif5o67AbRTWAu/GWo9exH3UJIJPNCvEMxtM
         qtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711513977; x=1712118777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxKU8l0j+qJqRwQBFeKwWnCv4cj11z9T7qvYlQt8KEM=;
        b=c5jJ4+RJKEi887nBzYDJ+vP97PplUeito4sLdn9eAc5jJy01pF5W2Bx6DTsPLopVMk
         /dOzy5/eNY0ppATFsgvciCtxRNggCMSZ5vFbLfC0n5DSuKqPatVNFHP4XaENg/wi5KCv
         wwg/6thqC6uuiGetjixy3bM0Zk0iIeMMiZlUQRZ9dMm9I5HzeS3HiS1Gk5Qq5ehIRmPb
         LBvkwKEgHqRI9P2EDGcfohFyEokY8pXktIwGzzkJxP3XOStM+tkLvJOIwb3nK8rLnISh
         WgB3dhpfDa5GWVpW/X4JdfK03prFKCrYpdC36iaC8+umXn7+X6Tq6RYY2L5fuRBYxB2q
         UvXg==
X-Gm-Message-State: AOJu0YwDPSOAhaSGAlcE6/PuszecwNXf4cx+YRgQn00MpnxbHNu0hwkH
	sXrQYR22AWKFe2u732oH9UbT+jtPdsYFL3PIhVvWq1uBeUbCD78SyrlRPbd+CWortN59+wSBHEl
	v0w==
X-Google-Smtp-Source: AGHT+IETRrqAe1vx209cPeUPmPNnzjVTbTXTUHZ+sDyuZodY4Sh+uRxPCZxouZh8YzY5KKIiy0kra6v35YM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:4ec2:0:b0:611:63e5:6489 with SMTP id
 c185-20020a814ec2000000b0061163e56489mr1961082ywb.1.1711513976857; Tue, 26
 Mar 2024 21:32:56 -0700 (PDT)
Date: Tue, 26 Mar 2024 21:32:55 -0700
In-Reply-To: <xmqqsf0gvjrg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com> <xmqqsf0gvjrg.fsf@gitster.g>
Message-ID: <owly7cho1eh4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> This patch is designed to spur discussion about adding an official
>> MAINTAINERS file to our project. The hope is that it could be used as a
>> reference in (at least) the following scenarios:
>>
>>   (1) [CC list] patch authors want to know who to CC on their
>>       submissions, without resorting to git-blame-level of precision;
>>
>>   (2) [escalation path] patch authors have been waiting 1+ weeks for
>>       review comments, but are not sure who to escalate to (other than
>>       Junio);
>>
>>   (3) [status tracking] record former maintainers/reviewers who are now
>>       inactive.
>>
>> In addition having a MAINTAINERS file could give a more official sense
>> of ownership in the codebase.
>
> OK.  They are understandable goals.
>
> As to the format of the actual file, I do not have much opinion.
> What works for the kernel may or may not work for us, as the project
> size is very different, but I am fairly confident that we can agree
> on something usable.

Agreed.

> I am more worried about how the file is used and maintained.  Some
> things to think about while in the "spurred discussion" I can think
> of are:
>
>  - Is the project big enough to require this (especially for the
>    purpose of (1)), or would
>
>    $ git shortlog -n --no-merges --since=24.months -- path-to-file
>
>    be sufficient and more importantly the value that it will keep
>    current automatically outweigh the benefit of having this file
>    that can go stale?
>
>    To answer this question, we'd need to know
>    the turnover rates of past project contributors, of course.  If
>    it is too high, having such a list may help for (1) and (3)
>    above.

In addition to checking git-shortlog on the Git repo, perhaps it's also
worth running a similar query against the public-inbox repo of this
list? We could perhaps use a script to generate this list automatically
every Git release (or some other cadence that we undergo regularly)?

>  - How binding is it for a contributor to be on this list as an area
>    expert?  Will there be concrete "expected response time"?  It can
>    be different for each area expert, of course.  I'd expect better
>    from those who work on Git as a major part of their job and
>    contributes some part of their work product back to the upstream,
>    than from folks who do Git as a hobby.  Is each contributer
>    expected to volunteer to be on this list, with self declared
>    service level target?

Ideally there should be some teeth to the document/agreement (esp for
service level targets), but I think practically the best we can do is
positive reinforcement. So maybe a prominent "The Git Code Review Team"
web page (somewhere on git-scm.com?) with profile photos and short
biographies should be enough to motivate people to stay engaged and keep
their spot.

I realize that such an idea is beyond the scope of a simple MAINTAINERS
(or similar) file that's checked into the Git code repo, but I think
it's worth stating as a thought experiment. The overall point I want to
make is that we need to be extra-thankful to those who sign up to say
"yes, I can review patches in areas X, Y, Z" and recognize (in a very
official way) their generosity in contributing back to this project.

>  - With many good reviewer candidates being employed in companies
>    and doing Git as part of their job, how would we handle folks
>    getting transferred out of the Git ecosystem?  Unlike in a
>    corporate environment, nominating successors who have no track
>    record in the community by the current area expert would not work
>    at all.  The successors themselves have to earn respect by
>    demonstrating their own competence, which would take time.

Unfortunately I don't think there's a good answer here. I agree that
only those who have demonstrated a good track record should become a
"successor".

OTOH, if we are fortunate enough to have multiple people sign up for a
particular area, then maybe that can be a sub-team and finding a
successor won't be such a big deal. It would only be a problem for those
areas where there is only 1 person who signed up for it.
