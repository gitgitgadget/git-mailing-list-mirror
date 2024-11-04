Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7351ABEB1
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714996; cv=none; b=rLxU9UPuPeQ6c5k1WQJDjSqgDYZb1JeVUyjhxjJzOqxqXmQq4KKtAVrpgsnCmdh0V4y1eM5T1JpIkcrgSxeLH5CXJDBLmvx4lg/af5BY0MlL2c1MB9t2KWMKroDTZ6whSM8UitPGkgWR9LsQQztToCbQ5EiTOgZaA0L25HdI+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714996; c=relaxed/simple;
	bh=aQXcN5hpmUFZMttwbTM5aD8Dp8wWV9qtJvMJL7jble0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afBglM8hmmDMB8BF6TSnkC2gahbz/mopUNJztXu+NLZKrao5mc5ou0dnXffhVnTyc8Za0ZvekZXqAsTamy5w76mYEibJDkv/BXRBm8DmzEl9xw72lswgHTGnQx3IhVDWei5wsTSJ4y0ztjpzYoP1nGd7KblUMOKbzOI9HVFKVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8X/sg4C; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8X/sg4C"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e59dadebso4674865e87.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 02:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730714993; x=1731319793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQXcN5hpmUFZMttwbTM5aD8Dp8wWV9qtJvMJL7jble0=;
        b=d8X/sg4Cju0IJUgk2fd8w23w1fecVtvjgeAL3E7Xv+GI6i7LJp3D/M0iUnGRgcBaJ2
         +BuKSu0uKNDrJYkzaHmDcziaoGxWlMsbah1swS161LIiSh5Tvqqt9SdFEpyTlOi2MiLv
         YXSWfCj5WQBW4vMIkOwtcmJ5bC+hNsZaf73rJ5viAkVVem0EBrUJW1ea8dS/6G8EAWNq
         ZXN1BsqzXuDb0yEb3G/5jKDPt1+wTRLHvyMYdUoXoQxdpfbQ/9cRYE0VkZa8fVrMhLNZ
         fIBlPPPWYhKDO8uh3tLcNZt9r0BCX8l90GLOsYz2qGcmi893amIRDkpIn8zKHLLD1VaM
         9a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714993; x=1731319793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQXcN5hpmUFZMttwbTM5aD8Dp8wWV9qtJvMJL7jble0=;
        b=KR7HqMCgWiC/kxRdl8YV5xYUTMd6zpub5L9pqFXtVQEdQ757SBZJIGuIvMIS+WxA8s
         ZyLZLpW5w3VDRWVNacPwVn16CBPNdofKi3YEJJY27schN4ZY7vTtuMlFJtVTnEYmyf2L
         rvTk2iqMfWjlsuonN/joccdvLKI8eUpDe0eNJYL1/iuByQaIfsjllDf3yq0oD3l32A7p
         Dms1Ikm+bzK7EUf068SbMpN42/OcqLzxSOMN0JBkExdv7Z4MOaBOL/ocH5urwroYHl3N
         vkYarAwmY+9LAKsN0xUPXxKTh8mfaZ1C9BBZ09+lP/TstpsHzrCmTYU6zZMeCe81Fute
         zxdQ==
X-Gm-Message-State: AOJu0YxE0zDB0+2Q5jlZyBdS7VM1+XLQZaNmrzQtzxc3D4cJhF35XKq3
	yCE49ZW34uAml1hugroasfLFJ86t9Qd2PNzyEMx3myikGeG2TfiM/8IYgBGmETORz4VzXwA1+N+
	NekeR0yQLXw/DHnlkhGoakvy5+/bzVKI5
X-Google-Smtp-Source: AGHT+IFvMyzi0vFgvkTQs95pE/7dqmrUyt3LVXN3d1keRLdTdiLRBlrikkgEVO26ldSfqJRnK2TlBLwMtCHf9AmqF/Q=
X-Received: by 2002:a05:651c:1a0c:b0:2fb:519e:b784 with SMTP id
 38308e7fff4ca-2fcbdf60e13mr157424591fa.3.1730714992116; Mon, 04 Nov 2024
 02:09:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
 <CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com> <Zx7O3VsZX2B9d9qN@nand.local>
In-Reply-To: <Zx7O3VsZX2B9d9qN@nand.local>
From: Devste Devste <devstemail@gmail.com>
Date: Mon, 4 Nov 2024 11:09:40 +0100
Message-ID: <CANM0SV3vNBwoNw08AevHE-3cOjUTG4AGVJdpwfKCr=CX5DSW8w@mail.gmail.com>
Subject: Re: 2.43+ git checkout --theirs on stash error - no alternative?
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

"--theirs" was necessary since I want the file exactly as it is in the
stash - any conflicts from applying the file from stash should be
automatically resolved using the hunk from the stash

On Mon, 28 Oct 2024 at 00:38, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Oct 27, 2024 at 11:31:05PM +0100, Devste Devste wrote:
> > Turns out the previous behavior can be achieved with
> > git restore --source='stash@{0}' -- "some-file.txt"
>
> Hmm. What you wrote above here makes sense, but I agree with the
> original change from Junio (CC'd) that using `--theirs` does not make
> sense when the source is a tree-ish and not the index directly.
>
> This is different, though, since here you are just trying to check out
> the contents of some-file.txt at stash@{0}, without `--theirs`. What did
> you mean in the previous example, and why was `--theirs` necessary in
> the call there?
>
> Thanks,
> Taylor
