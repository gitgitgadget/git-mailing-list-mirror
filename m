Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D12BB17
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459917; cv=none; b=V6NHpfX/mIuZuYVq1ww4AvHLu6BSyHD43EhSLQV954Zw4p/eTKftU23Dg32AFRJvayx3lhOBp0uZMrBFsIiM0biMQcl0vD/wHc4JBrHmWkF8kIxHP09EnJXnfKvHPktLZz0oTtcptuHTZd/FeigpABAUadSvlR2GYfBBbimUUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459917; c=relaxed/simple;
	bh=VZWuxahGlgj/T6cP7kLQwptUF0yrFAOGclgRXrZo/Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbyA7pbAX+5r5HUE7pza0YMjlPFcpzDVT/g+rsmsXScVZHVhV3plN9AbgtGdg7yb7ur70lCMuWkcIknSbBJplCB9mtmWYezZjUFyKqEYSnL7osCxZCjUw2UA8da579PjHyGTkTPI+K609Zpb27AuyW47UuC4WHVNl/nBdVMEjL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9dQ2l7R; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9dQ2l7R"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3800376a12.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753459914; x=1754064714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbILZX7uhXF3KNgk9saOgoZGBldZZVIrO5qVtC+Q/k8=;
        b=P9dQ2l7Ra8Z1+a9vtxa1HmM155TEj0DvLi73xRp004Qw1g8I8kkGodBKJiP1lJXWqT
         XYCFS9NGa0e0W0G3NW/FbYR598PBFzVB0qllJUU8WUMczlcgbxnwKmu0/HdtseK74+eL
         PC1w9JUCD9dn20hzn6Dw/gA+1o6inT921KTBE5rWw7yuZZIACFBbgKvFx0waSNEIVSEb
         7ix7s6kLmXpnRYq4dTc4/gzmRlqD8d10S+fmHwVCqintlSbrK3ojLy94XV1960dUBoO+
         uc4eXgwoMn2N2wBXFmV5Olvje7w/TA+YbHiUXoO4skfLtBK3khsoekQdmXT5ZWn12s3N
         0Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753459914; x=1754064714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbILZX7uhXF3KNgk9saOgoZGBldZZVIrO5qVtC+Q/k8=;
        b=K2TAGanWvqupFgfy+HD9OfhUQ7kVk8uw4zkfW01u/CtN/cisbLxiqcooD8FaEroAwq
         QG2Vm1638rqYdljuYgeuWuolW6dJcvXkE7R/VOcI/VSAINSH/cxSzdugXt4t6QQzbOEm
         aNyeG0ZYqXLcWTq5WfzEJ+v+5vP9fNbafE/7rQSQTACg0QeaMaVgUq7k/OZRaDuWp2m3
         zm75Ep+3VR0h2hMDuA7Xx42oRIFJ8vrmv2PjA/VZd2RRNRSdqeAWIjwXT3YPqI7htHQp
         /v6RrO62E3X8d1o3SdHA2Ol8l9rlZaus9bDMTrJHpik6NnSavmnUZkczGp3ZsDo/dtl6
         qJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXAE4OhvgbB+Fgb/XtGEBee22JnwylDswcp51ycZ5ti4Im3Z6+BGHXfOEH0gKZv3jYyMQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxz2Qwyy2GQVCc5BAnHmxjVBWvvldx+MorV3DaGZvRZ/pVV5QW
	aevPxgPL+SynUkExicqoDBTW7IzaEsjcouxBH87ho7r0YcriTFjn9c6KMsemqRkLi0d0k9H1p+n
	l9IA+DJo1On/ZUM+F7vtII6eOEkYxlj8=
X-Gm-Gg: ASbGnctkTSrI1TPQUVXRlEHz0zwJJ/O/bpY+Q8V23gT913sQbd0iFf1AuJpQNtLRulW
	OB9cYDJ7UI0vs4fZViIUTTlFm/4WizP1NKNQZfiybJXl0yEtS9vG5a5vtlI3yR05ZtfSg+86WhY
	fk6fm+7+5nUUe1VYycrBcvLkLfJfnD7XkpzQWy64TVD38nFsdpNKOFfYS5xgPLDA38qEiQOjtmq
	Gv6NT0h/g==
X-Google-Smtp-Source: AGHT+IEoegn4ZS/uRvuwn3C8aPRKe5Dgle3ZU938I9W372PvZ6odlBHNG7F4EqJrh10UmsGsJPU3gmMOPkhtLYgZA3Q=
X-Received: by 2002:a17:907:7b8b:b0:ad8:a935:b8e8 with SMTP id
 a640c23a62f3a-af61c2aeebamr286360266b.5.1753459913215; Fri, 25 Jul 2025
 09:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708091738.4072857-1-christian.couder@gmail.com>
 <20250709141253.623563-1-christian.couder@gmail.com> <CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com>
 <xmqqikjulb5d.fsf@gitster.g>
In-Reply-To: <xmqqikjulb5d.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Jul 2025 18:11:41 +0200
X-Gm-Features: Ac12FXxp_GCnTLXq3gKYilSXHyJWxL_n1omGy8j1_57DCGb8Ky-vMWv9Vzo8FAI
Message-ID: <CAP8UFD37JWpWoyMfpP1i6454ib14Jbg33=J=KgVBF54xp-d4hg@mail.gmail.com>
Subject: Re: [PATCH v6] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 11:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Overall, the patch looks great now.  There's just one little nit-pick
> > left; I'm still not a fan of tests of the form
> >
> >   (
> >     cd dir &&
> >     git fast-import
> >     ...lots of other commands...
> >   ) <output
> >
> > because I think the "<output" should really be moved to the "git
> > fast-import" line since it's only meant to be used there.
> >
> > This series adds 2 such tests.  You did point out in the discussion on
> > v5 that the testsuite already uses this idiom and you wanted to match
> > existing style.  (Though there were only 2 tests previously that used
> > it, and you already modified both as part of this patch.)
> >
> > However...we've been through enough rounds and this is really just a
> > nit-pick; I can submit a follow-on patch later to clean up the four
> > tests and see if others agree with me that this is an eyesore, or if
> > I'm just weird.
>
> FWIW, I think it makes sense to ensure that the "output" is consumed
> only by the intended command.  And "there are already two cases"
> would not work very well as an excuse to add two more to make the
> codebase even worse.

I have just sent the following patch to fix all the instances of this
in t9350-fast-export.sh:

https://lore.kernel.org/git/20250725160536.2909011-1-christian.couder@gmail=
.com/

> > I think it's good to merge down.
>
> OK.  As long as somebody promises that the result will be cleaned up
> soon later, I am OK with that.

Thanks both for reviewing the previous patch.
