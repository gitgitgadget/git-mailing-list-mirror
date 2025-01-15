Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2452B1EEA37
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932915; cv=none; b=GDzwQgqG9MNoAwKyjDPTSa9cyjdK4R8iD/03NOIyqw7xvSRuE9cUVDBxK/MLQrJMLHEC0L7zeaYTyWxI9O8jwDxCsJaCNTbNTkaZJ8sxjbluh+7oUctsY54JTBJrAjmngdxd/v5GsyZg45dC5VRQJcIlZOcTZ5vAmeN0Vzz8syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932915; c=relaxed/simple;
	bh=UI64hx0HYo/dnNeNdby45qLGKQ55KLxVvwXMf32MHYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6XYmZJP4uOISntmHrqt/r0dFS76srUmw+MmJRuiOLx8OSeOaEUMy6H0Mmqg44xDABSogYnX+zK4vUYj4lgfYcz9PW0ltLr6ull5Ffsl8RZEogLuI9CyYsSV67GUy4U8r93AoMTel9CaAXTUI9h1W88fIZLTCAqDvZlUJI/UVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGYI0EyD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGYI0EyD"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so9092526a12.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736932912; x=1737537712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI64hx0HYo/dnNeNdby45qLGKQ55KLxVvwXMf32MHYw=;
        b=cGYI0EyD1RY03QEjUqVxisTxzGMiQmHhm9ptC1jVu2dHQDQXilj+EA/REbWSM4dL0x
         sAJ6j4bTJWw3TofSbZ3ExqC04ecTpX+KfF9qZh8Qm3btKFOHXUxu9VeeNUZgBWR9e4U0
         S61gK2bzVw5lD4CQgZZ8YQoxLwe1G5B6Zy/w3mN46ha2N+ODjCR+9eUZ2Nclwg9OdTuz
         +dG1rzaa+Qrkg0NUPrdgruoe2Qp8+dZiDRnkmJguCSPbY6deS3qe+9FmQAyZA2aoNwfE
         UlW0l1vyHM3JqvIL8Crscbi1nj6+ceIUJeRPfnnToYXAUCREzFXs6yMfqrv6zvOf05Q3
         b1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736932912; x=1737537712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI64hx0HYo/dnNeNdby45qLGKQ55KLxVvwXMf32MHYw=;
        b=LFnz2xeNTz224AsJ5J4U6k674beoKAe7QDBsevLSVg/KoMOWueWdESNBqj2OXi8pXG
         ef/NEeEfJvqj+XSKNtTpzANQVU1WXRc9kEpwzE1P08gS1MdmfxMTN23lPIgwwi4VN7i6
         vfVJ3xfuxtq9qs3ghl3qK94dGQYCA1ydvbNLMKp3x0hCKuuSp2jZ/Hg1VmgDL31sjDVK
         dFmFt1d4ysRj8/LyArSRLG4fkyC17M9eNYyNGDnl5W2YGaWjZhwAL8cIu+qu3u03815V
         v5re6DiBW1z2CLm2eepobbwaiHvHJTbH5Eog9J2hl1H7AG/piPrBGfGU563+soFO3Ec6
         GYWw==
X-Gm-Message-State: AOJu0YyQs30ZTpKc5JSP9k4GiyeUih5ZKFk+B8RFOfgcso4lpZvYUdBH
	4uC9LmsxHY/q2/dVe6l81M0VQiiS0/qAJdbDsURFd5BtBbqaSoRwlAFEKp3bKuYSuumlpgDpf5Q
	M2cBURWFZE4cbQXN+rXq41IBxLXo8O3yJ
X-Gm-Gg: ASbGncuRcG3K4Hl6t6bctG9rexdWAnJnJhZTZFrF6+cYaPPCJiDlt4RwDwiyTa++Sc6
	/QHagLpMZryjzz1JM++oXBxMs36ktwL2gDxCxebgx
X-Google-Smtp-Source: AGHT+IHIRVqGVaScXEHPb4OWcl7W2hPv9nqR6kp8fJ+FYFQFRpipVyi39wI2MD3QQm0HoBbkOxvdxE6RqrQsQRRb1i4=
X-Received: by 2002:a05:6402:270d:b0:5d9:ad1:dafc with SMTP id
 4fb4d7f45d1cf-5d972e639famr63419273a12.25.1736932911937; Wed, 15 Jan 2025
 01:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFAcib9rWO8WFmaAwf+1Ng85+N7O3Y=QM6wG5xEz0r4tGXJ8TQ@mail.gmail.com>
 <CAP8UFD206mL+CYxOUKOPWFj7tX1Y79Moc7UjvH4BsLVLbAk-JA@mail.gmail.com> <CAFAcib9cJOp26J=PxU3XwmLT0hQVqCb8vcS7MdGpFd5TNVfDzw@mail.gmail.com>
In-Reply-To: <CAFAcib9cJOp26J=PxU3XwmLT0hQVqCb8vcS7MdGpFd5TNVfDzw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Jan 2025 10:21:39 +0100
X-Gm-Features: AbW1kvY_VPvOAjL4RDj9hF7xn0jXcJm1NTrgZ7YufB-smJAW4D0bPAGUV4slJmo
Message-ID: <CAP8UFD1ioX4R6J+Spb2oPEeTHvUBrt62iBqvRgMNJVbp45sw_Q@mail.gmail.com>
Subject: Re: Should 'git replace' respect GIT_NAMESPACE?
To: Josh Bleecher Snyder <josharian@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:40=E2=80=AFPM Josh Bleecher Snyder
<josharian@gmail.com> wrote:

> Do you have suggestions for alternative mechanisms I might use?
>
> I want to be able to easily enable/disable a set of replace directives
> for the purposes of running other git commands, without globally
> altering the repository. Otherwise I have to worry about locking,
> cleanup when something goes wrong, and state visibility and
> management. All possible to fix, but messy compared with something
> like namespaces.

The simplest would likely be to develop a small set of shell
scripts/commands to move or copy replace refs around. These scripts or
commands could use `git for-each-ref` to get replace ref information
and then `git update-ref` to create and/or delete replace refs.

For example a 'mv-rep-refs <src> <dst>' command would move all the
refs under "refs/replace/views/<src>/" to "refs/replace/views/<dst>/"
except if <src> or <dst> is '.' which would mean "refs/replace/". Then
`mv-rep-refs build-fixes .` could activate the replace refs that fix
the build.

Alternatively you could work on implementing a similar "view"
mechanism in Git itself and submit your patches here.
