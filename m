Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C74D6C4E
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832921; cv=none; b=g3r+yJn4Fd+qnDW6vQUwWgWIw9AYACbk+l75WEXli2ERE7RYNsasvcN4m+wta0155eV9tZ06nsYfssXSS7qDKnJrnaKo6jcUuF7Y8Rlf4uPwE4aO9HH02x9HqSk81/AID06hy0YiB6bFRSve1ZiA/Bvtrqy5hOkF5bfMtf4wVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832921; c=relaxed/simple;
	bh=vXPntCyTafRk+5JhD1B2ZwpXfCZI/yGJKjV+NUFQqng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9AXNGGsfLFDpWzTO8uQ1dkqFAdRyl9kmQ7igc/HWKJrynf1tPzx+Qayd+H85h2Y+4SvCIdYLDQhpck9Scu2aRRx6AN6SAaPm+ss30Rk7HC3L0Q6qBD96hFJG25mcbF01KOPdtW+CamjJpz2NzUSJk59tTJ4GNu5jph44oz3dJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFr1Fx4I; arc=none smtp.client-ip=209.85.217.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFr1Fx4I"
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cb0cbc6d35so463214137.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791832919; x=1792437719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdh0V7WCMgZLraX2K1+JPxBUO13gB8zysobKT7IJYqU=;
        b=dFr1Fx4IdpFvmI9mpI7s9mKWS20mCaibZEF+TqKvwRLPv3aAOBT+U9Snub4LtFPMhZ
         0cqzfTPBx5sDPHie2eA/Qv7IJ3H7aaTwaftQ1X6VuWnLC7g/0NqNpHknlkEjTRGUYD+3
         wrFa7BlZH0luN1Iu4rMAPPZAqbxEJj/EU/lDu5c8NF399wqip/w4hCpIqNacW0S0lvQn
         GyX6xQEvzSXKirU22uWl9n2f4+DWwE8OlN5hZ89Wwk7o/dkXQf8ozruU3esE/f9fxwmI
         Tlr+POCUYHX0E5xLyN3i0X3z6BI4MaUdk3Z6EX/ErHW4oQZuQpt/drvOy6C7/LANoFqO
         nWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832919; x=1792437719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdh0V7WCMgZLraX2K1+JPxBUO13gB8zysobKT7IJYqU=;
        b=lD2TORt+Vk49jWCU+X3qMIo6hhbnbFEZ6MGJlz5FSmlwYXFohD5FOFPEPGvL2ijCxf
         ctYGN1GLWB05uO1VRYylYAW85D4qExB8/OKie4y3V7whXq+u34tfcToNIorbHu0WDGGx
         C41FSPf/XWPy4YXW3+e1sGXPAVexWvT4rFNut7mPz6RAFvKDYTGrgAvJ74uZN8Nut1jQ
         IFkWGW80K8p0E2Y/0qyOvnp5Agf4ElzHco7mKmo7AM6hA1E8KqyRmhRxcH1uZmOp/Z5F
         IO0kSVrajiXk6BfmccXoBRI9x8DwuwvoP+38Vkkzht/eMkn2O2ZtDGDpbOKoXp5SW0bv
         fpXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIKHABX9KS/qi7OnCm6PtH2RVx1W+wDkviDcFSpKdgs0tXzWWGZh6f1yvQR2DJZ8U8ts0=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/5bPzlSfFKWyltVJAfMG05teXL+GgAfArfJSLegzDWDFmejjY
	+1Qptzo8AdHn1Br+GTluXWhmJferkfPALbZY3qkj1p3SmTN0CqET1/4n2fT+VvQJUugguYtSPhY
	onP7IjZserA==
X-Received: from vsbgq16.prod.google.com ([2002:a05:6102:61d0:b0:7cb:bd92:977b])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:548b:b0:7af:7db1:8291
 with SMTP id ada2fe7eead31-7cb36788382mr2380972137.5.1791832918237; Mon, 12
 Oct 2026 12:21:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:21:57 +0000
In-Reply-To: <xmqqbj8yan77.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqtsmsdpxz.fsf@gitster.g> <20261011222929.2957901-1-rmistry@google.com>
 <xmqq8q43eszt.fsf@gitster.g> <5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com> <xmqqbj8yan77.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.g72a87d1c34.dirty
Message-ID: <20261012192157.1835972-1-rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I've left a couple of comments on v3. Ignoring uncommitted changes in
> > the file in the working tree seems a bit odd to me and we seem to be
> > prepared to load a file of any size from an untrusted source.
>
> The latter sounds like a sensible thing to worry about.  Thanks for
> bringing it up.
>
> I do not have strong opinions either way on the former myself (the
> behaviour implemented is to attempt matching what the hosting sites
> do, which obviously work from the committed copy).  It indeed feels
> more intuitive if the checked out copy (or even the file before it
> gets added for the first time) were consulted.

I have sent v4, which caps the size of the default
HEAD:.git-blame-ignore-revs blob at 100MB (matching ATTR_MAX_FILE_SIZE
from 3c50032ff5 ("attr: ignore overly large gitattributes files",
2022-12-01)) so an oversized blob is skipped with a warning without
being loaded into memory.

For v4, I left the behavior as reading from HEAD:.git-blame-ignore-revs
to match hosting sites for now. Maybe consulting the working tree could
be explored in the future in a separate series if desired, or please let
me know if you or Phillip would prefer to change it in this series.

Thanks!
