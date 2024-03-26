Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35391CAAE
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491844; cv=none; b=fx0MwgUZYroTlhdhhfDY45IA54TR5qIydoj3cet20sEegm/pV42tW6QikEufsUDH5C9REQ7TXrMwI3fHP+LjqcZDSiAraa4l4ZO5S6P9ef6iNzXIVIhszGQyRHOo2L6sG8+Z+znAv5c49Sa7qAjaAeptqo5W97m8+WxCjFjzQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491844; c=relaxed/simple;
	bh=+TAwscSqoK4cqadd8lxP9IDasluhGNX876tGGFuOIKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QbRqNwpKXpWUDavszcq4Egxy3v/0G4SWhT4iYRgImS87HGujnPNUDYe+RBoqWfMUkolYSA3u0qo0qJBlm4/9KrlFWj8rpAWV7Mg96r6YmAqF4gox/mNxV+HoJDmvLgWqyxL2RjA/OwQq78KsLvTGUIi+fMbW0qQjcmitXgb/POE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDdBWvG7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDdBWvG7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so9253893276.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 15:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711491842; x=1712096642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeH1mC+421b0d4fpB2UmFufsGfwRapO1Kv84G5SIcb0=;
        b=YDdBWvG7KaoBUSHJ5QoXmFPr5s8wYGIEHg3jAbm+tSaEEWM/nUk86Ym4xiqg0R3JJD
         1FksVaAbx6GOLxbAcGnvXEAIqR8mYkIOmFIPrFNNyiS16GuyewtdGMKCyCHWmfzXIoPz
         mEmGslzMS+2RJxcl4WtRRjYzdsd1cylMBIx63iv2kzGWDKpb6kztfex6lDiXqmesDn+Y
         iJ1BeZdNL/6CdrKEQoh02Ow1Dawp1gPPYKk89ye7wxe2ODFlcSZLtn/fYKbiNajUTW0J
         as2GJK7eFFQUyrPyUSJ0ESfsPQEcdtd3bBo1E41RqUtePu177QIhK2fJuMPy8RJKJljE
         rIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491842; x=1712096642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeH1mC+421b0d4fpB2UmFufsGfwRapO1Kv84G5SIcb0=;
        b=Uj5oV8jdJli5quJwNit0wyNc5URSL9dD3X0BAJAKeF6/Qm9z/CS6oLXv3G7F+RfX14
         bqMH1JG2v0tcHfvqRS9LLeKnfb1Az/woP1Clzi3VzUP8ug2Z3K0Acu6mARpjMAGTIYLT
         XVu+i86eO/MRcGOegM40U/HEogu0o9OeGwpyp1WeRoi77tKIH0dMImK88Oq0OcN+UOss
         N3sutE1/GTDmxu7Yd2voieVv/p3Ynr56svJQhvYJTEkXusy1kkY1EKoSg9bdVQhvitEj
         ILbPivRrb/MSj8ogCFwpnVkaasV4+FTW0gTSD5TQW+S4nhQA/C6I2c9zId2Xt6zKj32Q
         BqWA==
X-Gm-Message-State: AOJu0Yxxl1b+vo5Ab9L/fKZFBe3O3WEM2SCVFcyZEdJCE7AwND44hRdi
	3ZlFbeChA3LJmebAkl8Ko621WznePHf23ckhoFvV+3q4ucPmYXyc+97tHQarbipWwsft8GUw+8z
	c2A==
X-Google-Smtp-Source: AGHT+IG40ZYhdrBSLQFG68sdeSAqRjO/ti6KbApZTuFyNQOj3HOXVaaLCsZ0dtuzo+IxRJptkCajrxpJe80=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2407:b0:dcd:4286:4498 with SMTP id
 dr7-20020a056902240700b00dcd42864498mr742545ybb.6.1711491841959; Tue, 26 Mar
 2024 15:24:01 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:24:00 -0700
In-Reply-To: <xmqqsf0gvjrg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com> <xmqqsf0gvjrg.fsf@gitster.g>
Message-ID: <owlybk701vjz.fsf@fine.c.googlers.com>
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
>
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
>    that can go stale?  To answer this question, we'd need to know
>    the turnover rates of past project contributors, of course.  If
>    it is too high, having such a list may help for (1) and (3)
>    above.
>
>  - How binding is it for a contributor to be on this list as an area
>    expert?  Will there be concrete "expected response time"?  It can
>    be different for each area expert, of course.  I'd expect better
>    from those who work on Git as a major part of their job and
>    contributes some part of their work product back to the upstream,
>    than from folks who do Git as a hobby.  Is each contributer
>    expected to volunteer to be on this list, with self declared
>    service level target?
>
>  - With many good reviewer candidates being employed in companies
>    and doing Git as part of their job, how would we handle folks
>    getting transferred out of the Git ecosystem?  Unlike in a
>    corporate environment, nominating successors who have no track
>    record in the community by the current area expert would not work
>    at all.  The successors themselves have to earn respect by
>    demonstrating their own competence, which would take time.
>
> There may be many others.

Thanks for the initial comments! I will try to formulate a response
soon while I consider your other comments also.
