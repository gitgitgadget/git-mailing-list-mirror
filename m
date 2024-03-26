Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408AFC0E
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484325; cv=none; b=Xcn6GB0jvAvkxXGJ3iX6sN3s5Ual5BogbyJ5arIXmXkyZcWVLbtC7VQLZN3bn+lGFN3YhQvmxA9TZ9Cga0irhhhCAXOGqn7UNUyFChMryl9gqstb8lNh3Jb9Lm2zOWIMAKqM9PJIQOu8wZxD+F2N6Li2zLfayC6R3OdO58sMZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484325; c=relaxed/simple;
	bh=uKplHoNbtk4b4ZC62z62PeC3kRMbuYGgV23kq3KUAcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpX46W9OlohmXZSSJreoAHGSTtaqKnkcesDalc2XvEG4mQDRJX48+UAAG9bDqDKTjDNAnp+rQ7TROmikKpvYtB4IwpMWAf4bjo/NPvCdmXqJZwWE5CGi67c+u0OBd/77XBJAbMoOyFRhQgYCgR7KLEukj0ytyR/nJw0NvMAjFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfHFibbG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHFibbG"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6ca2ac094so5155552b3a.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484323; x=1712089123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLUIIXlFKtGnxe6z6SpnIr3inNTsPmXvuB8tdxBsEmE=;
        b=DfHFibbGeu0nhPeG/qKiQ7HYY7DY+hMzsa+XmTG3unMCDtAxWi82gq0o1eQwZAmzbS
         PrNOA/274NvNdgJU42JnhJgMa4KKQgxhFvBcv8qZMOYb5EIxPGgebRyCr6Y3nRcexyj8
         tj3CUfHK5qDoI+xyWdGNj0gXmuSDzRcHdswyWm/4RIt3ws4VJPhsS4GPLOB+LvZ1ZGa2
         2gsqBkUS7+KojYiiftk+Bn9uWHO1XX5EQcQY42XlDm+m/MTtO7jARW4mf/jHapZqwHrV
         HsteDaQOT56B5eK2dI4dqFTr4owKZKO3+y9GVHEQrTAtiO35LpEccQMNTywEa/F0XAti
         tHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484323; x=1712089123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLUIIXlFKtGnxe6z6SpnIr3inNTsPmXvuB8tdxBsEmE=;
        b=fAlumxv+cCtwc4F3EEcXNfjcjGnJmeySyM7PKVfwquh6uOHsAJJz2pV0cEJtT98yS7
         zuo/R/DvvfdjEi3a/MXZu3klNbwplKAAJnTY9WvQyA66wv+FB/90DtEP7BPf1TjFHuCv
         WaAQba9wgF6DoNaKYTgttbCowaCPnn2jXrKUVr3+hVJE9gnjjecq0k2nDk8IZH7pbdV3
         5SeeVyy4MHrAsq76weRwSoFH6PT2dF8ZIQo8GKODkchK3BwY81uqIqAcFM+HOAqUKE1i
         O9IOwxq3LSx8toqU0X2Y32Jb+wAQLMHmjpPyM2N3a8z42d2B15RGV6dbiKaRBHzvCGe3
         gIaQ==
X-Gm-Message-State: AOJu0Yy1YipbgtBqlE66JK3pOTULpSe/VTM75AIyzLW1QwissYc2sEev
	sIQkgctfbJZvBU6l50j4gS8WHAVBxneSkekHKFYn89VyqgewnU0OjCmgOzsOutd48qDAtA96xU/
	VwLzqs8P0YvkIZ2KNOpY1jLMrOKA=
X-Google-Smtp-Source: AGHT+IHb1GUtFQC9QV5o4he4eiI3dF9AjkeYGIStODR/DZt02CWCyggVxQI9SupQhTT+FvwT9giIQkeajWMaksyXjgI=
X-Received: by 2002:a05:6a20:4aa9:b0:1a3:66e2:f2e1 with SMTP id
 fn41-20020a056a204aa900b001a366e2f2e1mr7783858pzb.28.1711484323428; Tue, 26
 Mar 2024 13:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com> <310f09fc81c75ef03eb00629db6302d1904585fe.1711318740.git.gitgitgadget@gmail.com>
In-Reply-To: <310f09fc81c75ef03eb00629db6302d1904585fe.1711318740.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Tue, 26 Mar 2024 21:18:31 +0100
Message-ID: <CAN0heSpVLAw3iYiCcgTnOtO9saY0KXR+00r7mR-PfqU+EcfPoA@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: git-init: apply new documentation formatting guidelines
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 at 23:19, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> -umask::
> -false::
> +`umask`::
> +`false`::

(It should be `umask` here exactly as you did, ok, good.)

>  Use permissions reported by umask(2). The default, when `--shared` is no=
t
>  specified.

>  _<perm>_ is a 3-digit octal number prefixed with `0` and each file
>  will have mode _<perm>_. _<perm>_ will override users'`umask(2)`

It's a bit of a mix whether umask(2) should be `umask(2)` with backticks
or just umask(2) without. That's pretty much the only thing I noticed,
everything else looks really nice and consistent. I guess it's not a
literal, since we don't expect to user to actually type the 8 characters
"umask(2)"? If you do decide to drop the backticks, notice that there's
one instance (seen above) of "users'`umask(2)`" with a missing space,
so you might want to fix that up at the same time.

Martin
