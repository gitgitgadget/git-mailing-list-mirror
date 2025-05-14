Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7A135A53
	for <git@vger.kernel.org>; Wed, 14 May 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241202; cv=none; b=oPiOpF93jIEMUUc5pq3VfEbZ7jxqOOluG35aG2tzDe0VHdZ5+7reLYewHNcsD4GeOkfCgY64AncwhewSwz81qJs4HawZi9iMSYBeD5x5kzFzy1orUiF/g/U/e+QUV3jGn9sYRVUhzG5ujo+u+qefHkwT5ZcjlTCLkddIhUgN6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241202; c=relaxed/simple;
	bh=vM9DI0FXUuVxgj5IuoirSNp8X6nVxvKamQ4hnTYhtZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmRI8Vpek3rx6g8kFiK/hBXObijQrQFiBJhqnEI7RACt6g+gJ9icEeUipDSDS01t0Eq0ukXOm2XF32cPINz3/ParjcDBckWFTPEW+PvQXqOM9GiKBIyqoi0PTsEY9Xz3mC3ZZy0mMyAFEm1IEhYYdjBLjC/NDGG8ysv/5nnV8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=MjoEBvKJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="MjoEBvKJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so239345e9.3
        for <git@vger.kernel.org>; Wed, 14 May 2025 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1747241199; x=1747845999; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpHTCY4tJOyu30iP4chLIjfGHlYrKlSNTzkzcA7MSKQ=;
        b=MjoEBvKJv9KerZSxFuB4iwh7xboloIkIo0KSZWxwZo4XmXzYDc7sJzSqvAYskXB7d5
         /YjDkh6u9OXxXi5hkzYZkvuYha/6wnrlBxnOw5womIN8oXDJbzLClyGeAmhs5nF5gkqD
         WFMtjs4BxKqwbkScwbbhEdmJb83OeaYkNUdl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747241199; x=1747845999;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpHTCY4tJOyu30iP4chLIjfGHlYrKlSNTzkzcA7MSKQ=;
        b=CtkpIJIR06RTYXIhKC95u9LQO5kciNuyrPsmzWbpYRNAaX9+UCMHaV+cZsqTCwrX3b
         1ZP7ozUgPcJsCPz2IjfzmibIf5Mkg/k9VXKQ2IX1wKXrvSj78gXlHPRDdUmAIKzGns9r
         u5sjr6vHtAUl25xMcQsn+Aqys+szqu6uq4toz1mScOBij+ttDaDXSX0Sie9meJtf1B5b
         GHARiKmEvREiJvCjxyUPPUY1hGSczj2Nr/yPVrBpbFaCbqRGH40wdzpPWXXm8cq24O5p
         Xfn3MYJ4rNkk7zqMvxcn8nE7UVuJVL+cTL8Y7cYc57cuAtu8jeo0wJJ3tB+WUzL+il21
         cWIg==
X-Gm-Message-State: AOJu0Yx084841lhvGPueCxLJpaDKfcyFbdOx22hBwY7q3JuAh+drY4vp
	wjwlrZGdzTJEsDJj3WD/ijTq8PVurU4kibeucKLNyvOBWYC2xMfV0kwbzO8Fo+0=
X-Gm-Gg: ASbGnctO4s0KjY6pBxb5h8tvakJstYraAaCvs3Sd6VwB+4QW3VJYOIE3TikyiV1a+Qg
	6ACUSi/JEQUy/2Jb68+2mJFmi/2JEDuX7ShR20y5H1c94gULvII/pEf96z6iaPX9O1av1wEFxdD
	lvWhRHBhAxZTbAd/q4en10jfenuNi1LWiepVAG+tLtFry/8ZqyZnHSM3gVdF0ruG8+G+ctGo08b
	fzg8fzNXlIV5gHjU62Omz5z3h/WR1R1Q1r2b0OmjwvMrP67wFOBN4hSE3zdUUXE5AauKz6Nozt3
	pryjTW3xhCEUGy0lq8BqxhXHG8aEqM0vllXZDKQm7atdX/dW9dy96w==
X-Google-Smtp-Source: AGHT+IFhu7fBoPZk0v4GksajuaF1KenqN+7kG12j7iO1HRevFvLpFz+1y9+Xncr9qnkbWDRabHC5Eg==
X-Received: by 2002:a05:600c:1c14:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-442f210f6f4mr43446985e9.17.1747241198502;
        Wed, 14 May 2025 09:46:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:46a3:bbff:fe27:9a9d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442f3380544sm37612475e9.13.2025.05.14.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:46:37 -0700 (PDT)
Date: Wed, 14 May 2025 17:46:37 +0100
From: Chris Down <chris@chrisdown.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aCTI7VjK5QMht3ws@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
 <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

[Code changes acked, thank you for the review :-)]

D. Ben Knoble writes:
>It would probably be nice to say why this makes sense in light of
>previously-raised objections, too [1].
>
>[1]: https://lore.kernel.org/git/xmqqo6x4p6z2.fsf@gitster.g/

I understand where people are coming from for sure, but I think the 
conversation has moved on beyond many of those points, right? For example, some 
of the objections are about format.signoff in 2006, but we merged that into the 
tree since 2009 in commit 1d1876e9300c ("Add configuration variable for 
sign-off to format-patch").

 From those threads, the main arguments seem to be:

- Signoff should be a conscious act
- Adding it automatically might dilute its meaning
- The potential for signoffs through inertia without proper intent

However, I think these objections don't hold up well in light of a few things.

First, the objections conflict with precedent from the now merged 
format.signoff. If we've already determined that configuring automatic signoffs 
in one context is acceptable (where that will then later become a commit 
anyway), it creates inconsistency to reject the same capability in another 
closely related context.

Second, setting a configuration value _is_ a conscious act. When I enable 
commit.signoff=true in a repository, I'm making a deliberate, repository 
specific declaration that I have the rights to submit all work in this 
repository under the project's license. This is arguably even more meaningful 
than mechanically adding -s to individual commits, either without thought 
through muscle memory, or through a shell based, context agnostic alias as many 
users do now.

In general, it feels like an inconsistency in semantics to have format.signoff 
available but not commit.signoff. From a user's perspective, we're just adding 
a signoff trailer to something that will eventually become an upstream commit.  
It doesn't really matter whether that's through a mailing list (format-patch), 
a pull request (commit), or otherwise.

I'm certainly open to further discussion, of course, but the existing precedent 
seems to make a compelling case for this feature.
