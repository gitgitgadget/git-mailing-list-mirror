Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5001EA8F
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740075; cv=none; b=FwwhQDYethcsQIyVW+D8wsSZkpKDpVdj12u44gqmfvUqGqOst8h3yCRVVA7Qo2QXIReEsFdjyonXlH4Xy3ISuNb1M7+4yRx+hZTmY34mTcQCqzAqJVx7f/gXBja4iWWOJvsoyOle8gihbh7dKrgWImzwv3eCL4LgCkXUNweZcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740075; c=relaxed/simple;
	bh=BPTCvlsUDsdz2DxOif0Gdk9DRVhrRzWGWbv/NQ7ldaA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LzvMm+udVbV7wZYkxEfYy0WL66ndxgtJTO7E9Ob1aQKyQ+fMPfzNt3MbY9mtOd9qWtRwpOQrWzu77IGxFUEuf9GiZB8eGA84XHOXJyu2r9OSIIS47Lazf7IFoQJQtJMvTdFzvSXMk1f7IFwi1320VGv7pkVEsDi7IfrkpCIflz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.washington.edu; spf=pass smtp.mailfrom=cs.washington.edu; dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b=R8cnU+vj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.washington.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.washington.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="R8cnU+vj"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so24278691fa.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206; t=1711740071; x=1712344871; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b2l2xVghUaRifT4iMsLDvxAnHuTziv6S27kjZ/bQ+WQ=;
        b=R8cnU+vjYR5bSRoeVY9Dy1LIxApp6j6+GUATIfJ409TTOBWUcxTd8jMYSYcy/EL2hI
         XspZpIqu1aXfcWq6gxlBPHNo8U2+Dd6JbprhmXUV9S51B6nk+xWn3s/L/ZYCPRJimYvp
         GjaXkUtgnR+SE1cR9AdOxxGi8xbsq6758xxoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740071; x=1712344871;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2l2xVghUaRifT4iMsLDvxAnHuTziv6S27kjZ/bQ+WQ=;
        b=Xt3AwzV6La4lGhcMxfLwO+2iFMSeRRKrRXcNikZT3SL8T2ajokaOa6326zOAvPoTa7
         FC6pfVBO5A3m8xCn/m155EkbaZkse0UHFw6p49H72NRjUV0NgXDQbQme4lOk2lfIBXZE
         CZqIUOYk4fimiaRD4eLG+3u5m9fkXCmEIMmK9wnqpjaXqjbpZgw+aI1AemuwjNtLMyPr
         RFDOzqAyjH6Er6V54ppUiTlB6g0cpLwkDC7vGSZjaC8BImW/5B37ALlBXK/tocNly6u2
         ElZIRmZ07N2qKYoYLi2TWq2pjf2vo4VuKErDvgnkoVoVtHntytyDN+gOeZG+ByHSxN/3
         md+w==
X-Gm-Message-State: AOJu0YyuMMQFIGR3Khr3dCjbt5bupiUxyElpahQSuMynqC5qpj1PgvRa
	ANimZ7UkSMzzP58xf+E/mgMRZRKLaOJ9brZh68sMcnZmxrJZFP8PYGW1rnn0yK6rXF25j/GNbIx
	5GSEvI9k3sVlUhbsPp9PpYdKuAEFFFSEpBJwmMSThNpbVhXMt9g==
X-Google-Smtp-Source: AGHT+IEZyIb8MY+12yoPcZHkgiSyimeeq0HUCK/q2OKZ72EWBQumUJ/OmaIn8IksbQuQmSHrZpzDvWPqCxH67dODqt8=
X-Received: by 2002:a2e:8443:0:b0:2d6:d7ff:5d40 with SMTP id
 u3-20020a2e8443000000b002d6d7ff5d40mr2217894ljh.38.1711740070613; Fri, 29 Mar
 2024 12:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Ernst <mernst@cs.washington.edu>
Date: Fri, 29 Mar 2024 12:20:59 -0700
Message-ID: <CAAJCdQQB3_DWOTCTbb-TAkLUX_XVd5TBd3z0M2_KrHxKxr69Kw@mail.gmail.com>
Subject: Feature request: a merge strategy that makes any file difference a
 merge conflict
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Git's built-in merge strategies, such as ort, sometimes create a
clean-but-incorrect merge.  A merge driver or a mergetool cannot be
used to correct such problems, because a merge driver or mergetool is
only called when the strategy resulted in a conflict (so far as I
understand).  It is challenging to write a merge strategy, but it is
much easier to write a merge driver or a mergetool.

If git had a strategy that always caused a merge conflict (even when
the differences are mergeable), then a merge driver or mergetool would
be called on every file difference.  This effectively permits a user
to completely replace git's merge strategy, without the difficulty of
writing a merge strategy.

I realize that the proposed strategy would likely only create merge
conflicts when no two of {parent1,parent2,base} are the same -- that
is, only when the low-level merge driver `git merge-file` is called.
That is fine with me.

What do you think of this feature request?

Thanks in advance,
-Mike
