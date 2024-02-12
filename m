Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F334C601
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769396; cv=none; b=JsXcxJn4+diKHgsWhiVc782IBaGKbj8bwN78+PnLWW9WKJyI3Jaq0UEODNFmeL9WU3Fue6jBb4XEv4eH/rOMVs1m7l7xVjyEDefLfk66gtpU9xSEpbMyO1p4yOUcjqf/RER6BxJ6uoJCYZKY8gFFHa1Bmxd50QPhTXUSHjvlBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769396; c=relaxed/simple;
	bh=ZOHYOXDC+UXZ7lSRqdo7I7xZmKmk8Gq3B5vMaDTSvLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fs/BeF7LuYIydi5tJHYm/g+RGv+47O3eVmj50LBvyCkTTjSO0XvW7TNWNvnHmcwloehElguz2IKjHRTJempgZ/mNmhF/kN1NJD+DclRxTY39A1k5Ejlueaotq7Ifxao3X8puPaH0dZwQn0KsQ18I363HxwWz0dlWmcIMcyN4oIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=GICzgu7N; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GICzgu7N"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so487778366b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707769392; x=1708374192; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZOHYOXDC+UXZ7lSRqdo7I7xZmKmk8Gq3B5vMaDTSvLQ=;
        b=GICzgu7NRx5I0Fzi0gOoRG3pMxNahhIeJwwWDTfc6ZlQuK66Ptfy1yoXLf9PyAjada
         NXalHI9K40FK0bXXEutl5VODs9GtNlzzsF3oll/dlD0wb76CLqReTne9LygEERrwOrFr
         qcIBi9a+Sigo2I/DLJo+cB/Gwwk7d7VYe2r4JYwXjDsZQXcSyYOXMsHdSwpvvDwYjzuq
         ERDGSuqZQQKiAZW7Dq1ufEG14a811rsRt3RiPLzqHFdEdaWj6EhXL5upR/w1WpUv4Rkn
         O3zaRiQRd2HnaaLkRgIE/idgkS1FdgYGDzv0WEv4XtfsQnn4ybTr7nBmLr4DRrIlbZDL
         W5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769392; x=1708374192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOHYOXDC+UXZ7lSRqdo7I7xZmKmk8Gq3B5vMaDTSvLQ=;
        b=lDu6qUrxQMF6Z4aU7FRyAQhfs+osOSmuyWFUS7xzB4P+8/4Z2wn6w1LGL7kXsgDwai
         NqJlHcjW4N5BckUa8v4K1c0q7uNnfdyLcM9vxfG8MJpDJwDbvtcGzakck9rPbUZOoBaP
         LNH1zkYXk7E3JcoS2fg+NLeLC9gVPtXB1EJ3EMIeia6mI8xtKO/6/iAVbz0NWtJHRiWX
         LDss2C6mr40gis9bW281ObiHONLW/R/Cz2uobmvrAdTeITfCK00DkLIb0lpmkKMfuLDz
         beRfG+kJV5wSpb4j43kcpGpUh89kYNrCcfoL3e/Zu8o3VOaF1E50CZ/0S2NymJNe0Tv7
         3X5g==
X-Gm-Message-State: AOJu0Yxru3zYthK0CFszLStKFUWgHb0UWF/ip29QHVTwAZqLuLfkQm6k
	T5qDVCqGiN4XW6OVmBla3CrJazAf9msLU5OTR2sxEXUQynxsdfw=
X-Google-Smtp-Source: AGHT+IFSfUY+ed4ekTH/kxrz/iJNdRK3WixKySIl0kUlB86aGq5UOluD3e8/C49jHwwEkUrVAVLoWA==
X-Received: by 2002:a17:906:6c89:b0:a3c:5766:58f0 with SMTP id s9-20020a1709066c8900b00a3c576658f0mr3665757ejr.4.1707769392392;
        Mon, 12 Feb 2024 12:23:12 -0800 (PST)
Received: from ?IPv6:2a01:c23:954a:f200:cbd8:d105:8084:6a9b? (dynamic-2a01-0c23-954a-f200-cbd8-d105-8084-6a9b.c23.pool.telefonica.de. [2a01:c23:954a:f200:cbd8:d105:8084:6a9b])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a3c488d79b1sm538799ejc.223.2024.02.12.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:23:12 -0800 (PST)
Message-ID: <6111b76ff145c2a1b24c09596b7e4d63f0089815.camel@googlemail.com>
Subject: Re: git-gui desktop launcher
From: Tobias Boesch <tobias.boesch@googlemail.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Date: Mon, 12 Feb 2024 21:23:11 +0100
In-Reply-To: <993e6823-7fa7-4130-8c0a-69ed31da5fbe@kdbg.org>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
	 <993e6823-7fa7-4130-8c0a-69ed31da5fbe@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 07:50 +0100, Johannes Sixt wrote:
> Am 05.02.24 um 21:12 schrieb Tobias Boesch:
> > Hello everyone,
> >=20
> > quoting from downstream issue:
> > https://gitlab.archlinux.org/archlinux/packaging/packages/git/-/issues/=
5
> >=20
> > -------------------------
> >=20
> > "As far as I can see git gui cannot easily be used by me on arch.
> > A .desktop entry is missing for me.
> > I created one that opens git gui.
> > It also adds an entry in the "Open With..." menu of file managers
> > (I
> > tested only with Nautilus). Opeing git gui with this entry git gui
> > is
> > opened in the folder where the menu was opened.
> > If it is a git repository git gui open it. If it is no git
> > repository
> > git gui opens just as if it was called from the desktop launcher.
> > Since it took a while to create it and adds value for me I would
> > like
> > to share it to be added to the git package by default.
> > It is far from being perfect. It's a first working version. For me
> > personally it is enough.
> > Before tweaking it further to fit the packaging standards I would
> > like
> > to ask if is desired to be added.
> >=20
> > .desktop file proposal
>=20
> Thank you, this is certainly helpful. To get a .desktop file
> accepted,
> you would have to submit it in patch form. Additionally, since there
> is
> a dependence on the install location, it must be included in the
> build
> process.
>=20

I plan to work on this. It might take some time since I cannot spend
much time on it.

> >=20
> > [Desktop Entry]
> > Name=3Dgit gui
>=20
> When I launch the program on my openSUSE desktop, the titlebar uses
> the
> name "Git Gui". IMO, that would make it more consistent.
>=20

"Git Gui" is fine for me. I thought I took the name from the official
docs at https://git-scm.com/docs/git-gui, but there is called "git-
gui".

> > Comment=3DA portable graphical interface to Git
>=20
> I have two gripes with this Comment:
>=20
> - That the program is portable is irrelevant for the user. The word
> need
> not occur in this Comment.
>=20
> - I had hoped for a more precise description. In particular, when a
> program is advertised as "graphical interface to Git", then I would
> expect that it can do a bit more than initialize repositories and
> make
> commits. At a minimum, I would expect a history viewer; but Git Gui
> doesn't have one. Unless you count the two "Visualize" entries in the
> "Repository" menu that invoke gitk as such. So, I dunno.
>=20

This is the one line desciption of the official documentation.
I would like to keep this description, to be consistent with the docs.

> > Exec=3D/bin/bash -c 'if [[ "$0" =3D "/bin/bash" ]]; then git gui; else
> > cd
> > "$0" && git gui; fi' %F
> > Icon=3D/usr/share/git-gui/lib/git-gui.ico
> > Type=3DApplication
> > Terminal=3Dfalse
> > Categories=3DDevelopment;
> >=20
> >=20
> > I think upstream has any interest to add this. Therefore I ask
> > here."
> >=20
> > -------------------------
> >=20
> > The arch package maintainer proposed to try to to add this to
> > upstream
> > before just putting it into the arch package.
> > Here I am asking if it could be added to git.
> >=20
> > If it's worth to add it, I would take the time to improve it if
> > there
> > are suggestions or comments on the current version.
> >=20
> > Best wishes and thanks for developing git.
> > Tobias
>=20
> -- Hannes
>=20
