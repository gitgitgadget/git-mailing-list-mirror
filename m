Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BF3987D
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524533; cv=none; b=U+PJ5NVGUiNxMKS9P9ayp5Ej3RGwTtk5SJleRnnxEvfKKTzLdY5E3emTaBdDyWpjDIJ0pV1Z+ucLlnwONz3R0KMcDDty8VbRoptbYBkiAlXNXkCuHADUlkx2j++jSsNQVzP+E7safrPz+tgZ/RrCxjD7XyiDMiKRtZmBp6fnFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524533; c=relaxed/simple;
	bh=HOksW3lIg+I6Q9xBiHsJADHd8E8xVC48dU47UdT5nz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=q3J9QiwyWm29UqXQbShILpKks+5HRfveAzS+qHzaiR51hovp6U9sxdfLIPwxJMP1H0ddar/7g5Ci/uNMSDNzyBK2nvOysXbPrW6tIJS4zd+XMu1Ttl+7k7Iuw9EtfWM4ZrDbCQr/c2XTSEIT1aWVCE5OV5nKJ1435EpgOIg4nSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elfsm9Ni; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elfsm9Ni"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42594fb2fe9so7518695ab.3
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759524531; x=1760129331; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmeaDF8OQByqaTZ69yLCqxIz4AeZOwNqbVcszggbksQ=;
        b=Elfsm9Ni3zhO5mgTrL/w8wmFeOY+l4Efrfay8xp3SFm1W2J+4eWoygysh5SjzPViNz
         KnyxKFd1/MmRnr9q71aNgXRr/5hGt3DFG/W4W02KYysJGCllegQsXo1raO9oelRQffGL
         YtcFKlJ7URuWa0CNlWB6f0b7BCY+SPLhYqHF4jjLLyMzCDO79AgpPf3kFPv39nGRJSl2
         eV1LDEy2flWEF1eeCGph2MwjDZIzoOuwY9pVADz3QeK3WOKK3GbYNCmfON8B3HyD2NMi
         SJWzVAiVXPZSDlfLnZG2HOep2064NIxicmjo6mFnxWqOL5EhecCr1H/OCiC9G/sYvA4X
         UgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524531; x=1760129331;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmeaDF8OQByqaTZ69yLCqxIz4AeZOwNqbVcszggbksQ=;
        b=hHmAjLm/HEshKtTwzy12QfJkus1xqIMZyt6r/44aoO8zCOSQ9VucROXEFQp7AA3Fql
         QYQixXDyG6xlxOyQZfqWdIuJUnZI+rYm/NGYmGWOUq5rFbbCqhDC9vUvfWQ8qfaX7ser
         WXyyz0yz0fCNQzGrOuiGKickd3QqXvQGZYpF7sX/kpzUiVyHCDOXEgyGV/JQWBZSxBKE
         8zezF9IFBFmtBh1X18p2hRBqbE0Ohyj5jk16IPR/4v4v/3ZSoPbUpE5c0jnlZ31Oea2I
         bkz3wvwnEusABDquixzuOqGdOZvkGX1XdMzD3p9Vgh7oJAErd+387LMNIdOerZIXxzOY
         gL9A==
X-Forwarded-Encrypted: i=1; AJvYcCVteg+bvD2rDrYHklas3/58+nQWS8Ctdr+fwbfnK61vbgDFNQR9p6+Ic0a9LSUn4oOM30Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZ5y8j96wnbfTdfqw8vmTBIiSQAMhqmnff1MdOnj9zFehKs8F
	muGGz/SVOkxWXOL8N8bNRXuYB++eatkSx1L2yPbuXKKqyy+72PkpgdYamP+/zwnKtOBlQYgES2K
	TE/2fDYeNZg10vapFaBiHcogjWUjxmP0=
X-Gm-Gg: ASbGncsdLAsBy/NyZxUKgFILT4z8ggyGx63FHenM0Q5GxCI0K9Druidnm5BVZJ7TnXJ
	zf/I4gpzjwGRJgVDeBnC2IMujJkyHU34I0vfRY7ol5ZzQ1oCXbofjoDBPlqv8+KEL3p+tLSipFN
	0ctD4c4QzbpcYblALYt1WJa02iMrtaPmP27fHGOic97/YJK82wPSCPjlEWt8pomq4kkiGquX+D+
	QTj+sfU51rDLeKxqTlLAsbzc8K+wB2OUO4XwLeecBDjWUOqPi0MfQvAPfALpGfCGmgNK7sbvQ==
X-Google-Smtp-Source: AGHT+IHlWfNubewFLQIr5yH0AH5DMlqg9NzTdvUt0fR7a0JBoYh2lCfHXAm9uzWzedk4n3nMnIGEJfKTQO5EKDdCU1Q=
X-Received: by 2002:a05:6e02:1a69:b0:42e:731c:a07c with SMTP id
 e9e14a558f8ab-42e7ad2e73cmr62262655ab.12.1759524531321; Fri, 03 Oct 2025
 13:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
In-Reply-To: <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 3 Oct 2025 13:48:40 -0700
X-Gm-Features: AS18NWB9SPq_tcw8ut1C2Wsp7YLbw87qly1cTszQClDF7ZF5W6SBE9RHfRDsVJw
Message-ID: <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Rick Sanders <rick@sfconservancy.org>, Git at SFC <git@sfconservancy.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 2:37=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-10-01 at 14:02:50, Christian Couder wrote:
> > +[[ai]]
> > +=3D=3D=3D Use of Artificial Intelligence (AI)
> > +
> > +The Developer's Certificate of Origin requires contributors to certify
> > +that they know the origin of their contributions to the project and
> > +that they have the right to submit it under the project's license.
> > +It's not yet clear that this can be legally satisfied when submitting
> > +significant amount of content that has been generated by AI tools.
>
> Perhaps we'd like to write this:
>
>   It's not yet clear that this can be legally satisfied when submitting
>   significant amount of content that has been generated by AI tools,
>   so we cannot accept this content in our project.
>
> If we're going to have a policy, we need to be direct about it and not
> let people draw their own conclusions.  Many people don't have English
> as a first language and we don't want people trying to language lawyer.
>
> We could say something like this:
>
>   Please do not sign off your work if you=E2=80=99re using an LLM to cont=
ribute
>   unless you have included copyright and license information for all the
>   code used in that LLM.

Would this mean that you wanted to ban contributions like d12166d3c8bb
(Merge branch 'en/docfixes', 2023-10-23), available on the list over
at https://lore.kernel.org/git/pull.1595.git.1696747527.gitgitgadget@gmail.=
com/
?   We don't need to go theoretical, I've already contributed such a
patch series before -- 2 years ago -- and it was merged.  Granted,
that was entirely documentation, and I called out the usage of AI in
the cover letter, and I manually checked every change (discarding many
of them) and split it into commits on my own, could easily explain any
change and why it was good, etc.  And I was upfront about all of it.

If any use of AI is bad, do we need to revert that series?
