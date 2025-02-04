Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6EA203710
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738701216; cv=none; b=J8FRWPET4PEAG0ojVJykhkHzjpngOTEO8I60IfvOw9faz4/LPKDQ0wNRn/0TuGWeiV7DGT2Sfv6SgxuNK8sVSf26HgDV9DXi2qYz9DjI7e+5bJYgz+HnJ9F625z5bAhYhqNV4ONmuVCRG9ATnwRFwQQcAS0KYq1el2DeILeEHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738701216; c=relaxed/simple;
	bh=9N3udgs4EqUEP/EDsG1+H8wfSe49bKiTCcJZbG2pqLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2dZYCpqZ3dFDf2AFWjA/OyUlo4I5rCkulG/Tv+DZkXVj10MGzvR8R4CmT9fbPg0EZCKl9gUQ067x/jPil2wJd7tC+BKjfRe8BTOhnGSe0A1qLWYra7mC5WkSeO8dFdY7FOqX1ywGUJ6FvRhEksNE7N/xkRjfuIJ9PmRUTxUrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=VBDvlzlC; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="VBDvlzlC"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e42e0ae0dso856916a34.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 12:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1738701213; x=1739306013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK9fnOIyXQIYbv1ubQyjr2ppXEiaKApY1MSRPj3ejGM=;
        b=VBDvlzlCPEvZ32YAKosuxs25Wu+U1esHPXnOemD3XA89t83QanBl5WjMPWokU968w3
         dH3eco7iNIAzCqZFZbpKjguDU+0ycVekh0Fkn1hTI+u/YnUFXzZZgbyg/Z9gt6D1TyIA
         7Pn1AUbxVyGiQ9Ju/HC4dG/ydfiax3WPn7Uu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738701213; x=1739306013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK9fnOIyXQIYbv1ubQyjr2ppXEiaKApY1MSRPj3ejGM=;
        b=fSgXQLbQmy7OY1ZdMDbRL/UQhME3Hg505IHW1jtANoLb2HCpvBJNDV4t/epsry3P93
         72jhY5Vw2+8WF4detmvNEscSoPwCbuO05BRzauwEgOqT+hep6PsFIaKGUnpLrj+asWq1
         G3TJEJIw99Kh3hDKCmilm3u9Vj4rHJCGlQwdpUHpNyJ5JkNoUB6bvTKGDDYk75N4NMxr
         JC90iNn52CtsCetzXvIw+/3U2pwZsuK+H/CC+Qzsh9W7Re31zQdSIahBKGRleesCzK8r
         jegTqMeQzEXo3pE/1OUyQO4IYt4kEf2q70waAKoGUqvyKSsxyd/JUaOdci8DkfOxSsGa
         vl5w==
X-Forwarded-Encrypted: i=1; AJvYcCXQCaPl3JO3AvqJoN877Ct21O6bIiqppSUUcenUdRNtAmoLBiztRkzvj5zuifengDOc8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2IWTM/3kCuh1H0url6QoQEWDvnZBRPyS9M7B1JpVt99Iq5i2
	6nkI5hHi7OzI8L8iDLS+N4wsKjyNEcLyTc5B4osPfG39J4Gl6Y3LwGiZIadivumT4j8FPHrJMWP
	dpn5edt2WDeWjMfETNDJtKilXEDjrioDToM6doZMzZXr6IqL3ODI=
X-Gm-Gg: ASbGncvXNh4kEDFuZbuYHO5oYK3Jexegd4AQaw9vkUJlx4Vm6raS/IxIOxW3w/UUuHD
	RS0I/hds4ocn+STIYkJrvUk0RI8wMID9n+UsmTEcwsqzrRfx4Pqo7pCIrd5AdhZq7nxC1P+mzwT
	q/E5/lMRZHSwu0dOQ1AwmQGjnrMeR8Ew==
X-Google-Smtp-Source: AGHT+IEz0YU+gqy4XyV7NvrmE8ZuvH3OpsdKU0WSa4+cgj9u227c5VAJLmne/JL5lDjlYzF0RXrXSUcngAo/gChRb14=
X-Received: by 2002:a05:6808:2101:b0:3eb:3bcc:a9dd with SMTP id
 5614622812f47-3f37c196871mr28333b6e.7.1738701213449; Tue, 04 Feb 2025
 12:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
 <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com> <xmqqcyg294ft.fsf@gitster.g>
 <xmqq8qqq943u.fsf@gitster.g> <CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
 <xmqq8qqq7n26.fsf@gitster.g> <CAFLeGL4v90zArJjtCOSGUTGQTq6qQJEcNMhi4P=ucDU+9bGRHg@mail.gmail.com>
 <xmqqa5b1ts0y.fsf@gitster.g>
In-Reply-To: <xmqqa5b1ts0y.fsf@gitster.g>
From: Olga Pilipenco <olga.pilipenco@shopify.com>
Date: Tue, 4 Feb 2025 13:33:22 -0700
X-Gm-Features: AWEUYZlVb9GKa6S1AziZlOSJzCbNqVh1lSD9YOJenjqODj_EmmUod9gAj8WSUdU
Message-ID: <CAFLeGL7aewQTECw3sUPSgysaWCcS+U_7vf=uHDuuvKDkQUHfxA@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
To: Junio C Hamano <gitster@pobox.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Olga Pilipenco <olga.pilipenco@shopify.com> writes:
>
> > I have 2 versions for comment:
> >
> > 1. Since is_main_worktree_bare explains quite well what it does we can =
have
> > a shorter explanation of `!worktree->is_current` part, something like:
> >
> > /* Additional checks are needed if main worktree is not current
> > (checking from secondary worktree) */
> > (!worktree->is_current && is_main_worktree_bare(the_repository));
>
> For somebody who thought about the issue themselves (like me, before
> writing the message you are responding to), this shorter form would
> suffice.  I'd rephrase it more like so
>
>     /* When a secondary worktree, an extra check is needed */
>
> for brevity, though.
>
>
> > 2. Or a bit longer inline explanation that partially repeats the
> > explanation of is_main_worktree_bare
> > + adds explanation about efficiency:
> >  /*
> >   * When in a secondary worktree we have to also verify if the main wor=
ktree
> >   * is bare in $commondir/config.worktree.
> >   * This check is unnecessary if we're currently in the main worktree,
> >   * as prior checks already consulted all configs of the current worktr=
ee.
> >  */
> > (!worktree->is_current && is_main_worktree_bare(the_repository));
>
> And this more extended version would have helped me by not having to
> ask
>
>     Is "this worktree does not have is_current bit set" equivalent
>     to "this worktree is the main one, so is_main_worktree_bare()
>     needs to be consulted"?  That linkage between "the is_current
>     bit unset" and "is the main worktree" is not obvious to me.
>
> in the first place.
>
> In short, both should work, and I personally find that the latter
> may be a bit more helpful to readers.
>
> THanks.

Perfect, I'll add the latter one then. Thank you!
