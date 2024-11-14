Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1BE573
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574682; cv=none; b=g9tMCsv0ogxP0JaNis6Se3TIzuMXrsOQICTh6ixKA0j4IVXzlo8tJ+GPAmiQNY6sBUU4n5xon5kVXMjkOqEBs2feygld5bgcHdNL9XsJXTrlrWwZd1CDjn3hyrBaVnJbbESxo85RRJQb9Js1z6YBSmZJ1cbnZ7ROI4q1XzgnWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574682; c=relaxed/simple;
	bh=7NJrR4vogW0/vHM41KtELnfnPiTdaVLzZujR4oU5hh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CU3SO8ZrP/elCVbWmZ5YU0PSDvfzG7W5HNWlMawElAY7Ck+bQru7DAAb6HusXXNOFEaJyEKiB6GfHtuNFcStr2bRUFCfKNDEF2MXUd/p924OVkFFWacqxYcmrPikoFg5iy5uEVNOMLou478k/QZze87fx9X8aGVxvtIQxgxPNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMrzmkAW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMrzmkAW"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso47164166b.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731574679; x=1732179479; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ8CBbrdC83PF6kbM0WmZZwpLC3HhIb1tEVxC2PrtjM=;
        b=XMrzmkAW0NnacWf0nDR8sriBBDnB2ATpPw9uuYlCGSPtuulx4HKeOhv9mYSCNGOk5m
         DikWTM1yN7TqKaunUsrRaNvrtMpbWHrBUdbwzDeNF6pXEBcnAYpeF5w4qaNfkx9e7IyI
         USWaVK8RBBfg59XXbBqxsbzl94/nOyBgSQXoGjWDb/hdE5TNmViXpFqQgXmAzkS31T2v
         g7uXDiHdBX0+z6Y0eiIMGmUo7PmJjIGdaj5kDZLeLWJMXF4AWNAetXm82D1/2fp0DfyE
         0vDrSnO9tn6Mycu1o+tIAwoa6re8hkCeMq7ZWaIjZxFCKmBE0zbc+4x2R/zd6hK4Nv9G
         NKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574679; x=1732179479;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ8CBbrdC83PF6kbM0WmZZwpLC3HhIb1tEVxC2PrtjM=;
        b=rlFxTcukuVUuAWGXcu/zSTMD0qruqAHeOxvWxpMm00gW6s/JrlWYXldlGmvKiakvWV
         r1KQpsmFmWUvBSJuiAXSqGhgeyP9UoOXcvYBGQWXlwux1xJOMwnsFYnxYzkgYM1vhMJU
         H2OCfa07FmygTYq9YQt+HQYM3vvAQ3hWCzMLmhXwyMY74eTD/BRcaaiKW2BBjILEubWH
         EpIzF8boYmcOsMX9csTYAkmUiHbT4sggjSpiT7VB1v+OmMg3IRJ60DQjmTmO9vSnMngL
         SE9a5PY9JyWQOPESdjnovuz3A0frfM1NHSJe3xPB/fG7kiPlRvfLB7AmTEj7dpVJRES4
         yDYw==
X-Forwarded-Encrypted: i=1; AJvYcCUOIxCDJPGlL0iNn3lrseu3M3PmOYXlHSY/jZZvJCZYQMyM0vv65932EyjU8I4xx8N5B1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4m1OI4980chNVdEysAJa8b+uCNdnnyeLNuYv2/X9t7Dn3Ezv
	mvlkDqP5B8GHYpbrfiWQzK2CwA+AYVuVIUNTTuQCLiqiDZ10cdkksKQhicIHvQS8WafSAJgL3t/
	lsqxaZGvgzeUdszGzrZCRGGpEalc=
X-Google-Smtp-Source: AGHT+IGR/QBamY00nWOslQqE/PbtnN2gZzqoEGMyOF96AO7qCsOv7QxTRY+PRxwqgHhGhwgJUI+XzOkiU8nJr56xR/Q=
X-Received: by 2002:a17:907:9302:b0:a9a:3f9d:62f8 with SMTP id
 a640c23a62f3a-aa1f805d27bmr577682866b.19.1731574678698; Thu, 14 Nov 2024
 00:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJPGt+U1icoNJHPtiFcidtwN6ts03jH9WpaGxDGoE5RBQSCCLA@mail.gmail.com>
 <ZyybBPigKZ_MlnU6@tapette.crustytoothpaste.net>
In-Reply-To: <ZyybBPigKZ_MlnU6@tapette.crustytoothpaste.net>
From: Yarden Bar <ayash.jorden@gmail.com>
Date: Thu, 14 Nov 2024 00:57:22 -0800
Message-ID: <CAJPGt+WwMWApt5o8E1nQGZnADbfjEkVmazUmxJ83Au6QPJ8Jdg@mail.gmail.com>
Subject: Re: gpg-ssh signing with AgentForwarding
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Yarden Bar <ayash.jorden@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
A colleague of mine was able to figure it out.
https://github.com/maxgoedjen/secretive/issues/405#issuecomment-2475175801
Hope it will help/serve the community

Jordan

On Thu, Nov 7, 2024 at 2:48=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-11-07 at 04:16:34, Yarden Bar wrote:
> > Hello Git community,
> > Not sure what search terms I haven't used, but I'll try to describe the=
 use-case
> >
> > On my local machine I have a SSH key, and I use AgentForwarding when I
> > go out and about to other hosts (dev machines)
> > The usual workflow of using the forwarded socket works for pull and pus=
h.
> >
> > Where it gets pitch-dark is when I try to use my ssh key to sign git co=
mmits.
> > Following is my git config on the remote host:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [user]
> >     name =3D John Doe
> >     email =3D jdoe@jdoe.com
> > # on my local machine(gpg-ssh signing works): signingkey =3D
> > /Users/jdoe/.ssh/id_ecdsa.pub
> >     signingkey =3D WHAT_SHOULD_I_PUT_HERE # on my laptop its the path t=
o
> > the public key from Secretive, or just omit it?
>
> I think you want something like this:
>
>   [user]
>       signingkey =3D "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzr=
m0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl"
>
> You should use your own key; that's just an example.  Note that you want
> the public key (that is, what's in `id_ecdsa.pub`, not `id_ecdsa`).
>
> Once you have the key in the config file like that, with the "key::"
> prefix, Git will pull from the agent if necessary.  I do that for
> signing commits using GitHub Codespaces, where it's easier to forward
> an SSH agent to the remote system than with GnuPG.
>
> This is documented in the `user.signingKey` entry in `git config
> --help`, but if there's something there that's unclear or you think the
> text could be improved, please say something, and we'll try to get it
> fixed.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
