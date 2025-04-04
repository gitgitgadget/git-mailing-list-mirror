Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEEDDD2
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743732407; cv=none; b=R+tIhjtYJ3ehn4Zoj/AcFiFWZKJtM+3BOFAYlLsH/NBop+zghXmtNSWcKeg6bmemEO3mB/gLPxYMMxLtss5aXFNAdXNyajP1JhnV1sqsCLkjkXPWUPN3WHZVnteu5iIlfy1B8yCTm1DXji486uhZEYfqAXnwhZQH1txfXw32rfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743732407; c=relaxed/simple;
	bh=U1Sa8S9w77/eeQve+ednuBTlVcE6WX39wpluQdTLZ1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRNvr2zt5RJ3HaWfaPcGS4b5Q6XQP9X8nz6+GErbAQkthcIwa70onEuBGgX0iAMWFrfw07jeXYX/g2Tdbt/NJJQoD9LPfhZsUR7spdBi8sLy/bkvK9NckTp4yPyKRxYI5jaFaCQdI3UW3H3p6LZFUdTDjKRCcntRfd1t8mJXMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhthR+tQ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhthR+tQ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d45875d440so6176165ab.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743732405; x=1744337205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovODmHHGhem063QqL2xGUZHglI2gvFfFISnDPDUfbXc=;
        b=nhthR+tQXkn/JQIrTLie+SbbTGL3lNq64evCnx4mHI8kwunuJLqQp0iefBGC4JXbst
         WRrFIqZ1MziUfvrx9hyDtL44Ky0d0dIAxq8nZ+h7MyqepCac1cNo7pX/pAp3YBigcnZW
         lSfUUZHBA+zMLk0wZKVtZ27BhCEh7trgS9DBVE4uCRCvBS9m4qTd1dLT8voE/Iu3Ib6x
         QkaM9XLj8kXBsPpTcH6ys9m8sKlGIa24le2UEhIoMrB63NO6qhBbDxu29VoUEL/TGzdX
         sEEN5F2iCvsxGKn9bVmviJ4bCQ33LK3YJTXIiehHolOQ4xxykqwTh+3IQEsj93fVkt9l
         dE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743732405; x=1744337205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovODmHHGhem063QqL2xGUZHglI2gvFfFISnDPDUfbXc=;
        b=sEfXx+VaF2KsmOvfESIbMcOnbsPuH/DCAe12z1BL64gXzaYDlLjcKu+L3W1yrfDex8
         0czowB7BLA1GEyA2umJtYWkPCXYhBZW2pyJQcPlxIjRP1oKyfKnufnBZmtnxwtV5c+XY
         H0BYCeiboA7bLUT/2T0E/2dmeXXtSRlsonHJAU0uOOCd64qKBmFBFPTXot5Nm4Zq0LqI
         93JJaR4c+/aCt31tltSyiORap81cULXzaejQ9o3uj2DF8WJNIAKkXbgDUroQRJbzzxb0
         0dBRlql8zN8d88ozkKRQDUokBcIxSeZwwT+Zd3QDJsz0ycvKslZv8fOVrhRlUcTQBT0Q
         Z+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCW7dRDNHZeTd9YPceVEARMVhzJ39fbRgfG4R1knDiy2xRXSOdOXHJ6zC8g2K9vHjybzG20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANagli83zNhuPN2e5TP19b/CFbCEnY9PD+J6PpZbAg2pZy0YO
	Gbx3R0hmCsOWj/1n3/xunS4IsY7jx0+GNnIFMwN+3Xq5K9QwkN70e9PxvuR+j0GIfeCRcw4Cx5P
	T8YZZb8vVwrAO0YaPbveUYfDKHdU=
X-Gm-Gg: ASbGncv0DjjIpipLfjsMmTCKPOp/+ASvS1CCqMhQPkp5XXRwFeuXSNDtFdJ6ZOcVmRQ
	YIdcE8onQ4qzsXPnhYYDLj8o1R4fiFbXPAU5Z1pWFWFxrYDl0lirwqqORYVmVrkbqjBRi6l/9Lw
	lZ/q2cLSiD0klxaXqJ2PqVbQqk4hpgZkASdoxfWk/NU6GJhFXUJbt3Wst30YI=
X-Google-Smtp-Source: AGHT+IFrhQ3ars+38udzFiWPAyk0rFZcwC4gyuTMAeyIOcjEOGi0o3BG0AOZUhODk0BgJMjzc2fFi1H70vkFEiWb0hM=
X-Received: by 2002:a05:6e02:4401:10b0:3d4:6ff4:261e with SMTP id
 e9e14a558f8ab-3d6e3e67eacmr13872115ab.0.1743732405407; Thu, 03 Apr 2025
 19:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <Z+7PDi5y4wXJBK4r@ubby> <CAESOdVAd+X=6nEULHtKKotH_W5yNaJAcUajRU79EuG+0SF3m1A@mail.gmail.com>
 <Z+8IF67AC8gSouYc@ubby> <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
In-Reply-To: <CAESOdVAWWP=Rte4bx3zUZc6p0XiZaJS2OZr8ezRPkfq8K1TYfw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 19:06:33 -0700
X-Gm-Features: AQ5f1JpKK3oDCmyfwCszapwpZZvYzSK4-oGSR-zcR59CckPZ1LwcvnVZjYdEVow
Message-ID: <CABPp-BHHz3zASVEmePxEW4qsu85Q_kfO8JHeb67CB6DMRHmUKg@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Nico Williams <nico@cryptonector.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 3:47=E2=80=AFPM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
[...]
> > What would `git switch <change ID>` do?  `git switch` switches between
> > branches, but a change ID can't possibly identify a branch since many
> > commits could exist with the same change ID all in different branches.
>
> Yes, the same change id *can* exist on many branches, but it's pretty
> uncommon.

In my experience with Gerrit-based projects, it was actually pretty common.=
..

> > I'd expect many commits with the same change ID in a _repo_, but at mos=
t
> > one in a _branch_.
>
> There may be multiple commits with the same change ID in a repo if you
> had cherry-picked the commit, depending on what we decide to do with
> the change ID on cherry-pick. But cherry-picks are not very common
> anyway. Or maybe it's common in some workflow?

It's quite common for projects with multiple supported LTS releases.
Important fixes are backported to each LTS branch, and people
typically check that the fix has been backported by looking for the
same change id on other branches.

In such projects, 'git switch <change-id>' feels non-sensical to me;
which particular copy of that change-id from which branch would that
switch you to?

Or were the dozens of projects I was using that were hosted in Gerrit
abusing change-ids in your view?  If so, how would you get them to
stop?

If you don't have multiple LTS releases to support, or avoid
backporting fixes, then I could see how you'd arrive at the conclusion
that duplicate change-ids were rare, and then you could start using
change-ids interchangably with commit identifiers in commands so long
as you only tried it on such projects.  But I'm a bit uncomfortable
suggesting we just assume all projects fit that mold.  Am I still
missing something here?
