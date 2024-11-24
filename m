Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6C13D246
	for <git@vger.kernel.org>; Sun, 24 Nov 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488096; cv=none; b=glbzRXg0X9oSWX3+VQLnyoXpR/D9GXrSqptgDggHGWncCgNvrRB7500a0r8fuoMucf8gJ7WmTPgAT+mayHEYmtezoiXdFTNRPQq7dR80Dm5RlNd9DsAbvzD7NfE8stGdHrL/lEpRMyH1nJGBw1pcdGAh5Au9q6QPO0p+CfTDC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488096; c=relaxed/simple;
	bh=o94QjvNPhdhWO3Drdc4XVV8ofVFdKF81KOQS3Z3LXCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=d49tW2svPtw3OwXYlzYqAR3DCYgA1kpvn4xcTjNmVohazfHFHawXEGLAV+srrqjMrvcNOd1eyuFBbZUC6I/4piKGrqRbiZkpzj4S3fQvVYGmClL29Y60jGffnXRLkc+8HMJTHwsrVCckGVa264MrUFIVwQH+OYG15X/sEP/ZMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMaZAuTV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMaZAuTV"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8418ecda199so21788239f.2
        for <git@vger.kernel.org>; Sun, 24 Nov 2024 14:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732488093; x=1733092893; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1MdqrFUcDGWq8cv9Rzr6uesJ4VsTQB4I+Fu75ctfAc=;
        b=UMaZAuTVBpRYD20yPsqsEfzl9NzNW1hBB/VQddlXYhTO7eGnCS2jJR4n/UP8h7aI7v
         1NVcbkE7Wgztyo8myl+zSWDKhNlkzw7Azv3GjdQ4tyCRy5WWKxQSFU3P/xA7DsID9wYc
         X6LILkeynaTGTHaYEmZshBBXpeE2BUTo4y48IKftK/Vq9SMM/0tdcPbLt90QfhIyDsev
         BHgte28p9X3ZeY5BOz19HNvbl4F4dOKu+cNkceFefYcEWIUzyqKhCIkO9PEQHojv9XL6
         cR39ABbyDJ91eJ723priMQu6PIwFwzSFWNja6CeZ0K6Re9Es1X8gq8LJiYGUMt/AEyqk
         YYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488093; x=1733092893;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1MdqrFUcDGWq8cv9Rzr6uesJ4VsTQB4I+Fu75ctfAc=;
        b=lIwKeM389NtLRtTDB9fOgWLqmjYW7bgJ7n8Tk+nNT5kDhi6VaaEMwnRLr2nkIIozFM
         jYl94TNovvwUga9H5+TvyLr02xsUSBM+XIc2m9un6dGVJxtewFscFlEMHNE+LvExH4J2
         siUZxyYV5cSodfYgzkm0Px9r/O29oUoz/x7p+AeTn8ff8JWk7gro151B1QWPrgZ38K1z
         VZ+lAFZ6K2Utzfh6qN65vq5mFlwxkeIS1As5uwcy0m1OigJlzey12wec+nxI9Ou7fBu9
         IA4bjGYiUAYkTHuPmkFh+cOW18bsOIO43FtAC1A4eIZRGZdsKukH+o5BAm37lFXEDAbg
         ArUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVaawjllYheJ7Jb0CxdkmjFrBvKaNb33oXi/uiUJXjm4UYrfhgBx2hjDLbmHB41p+HfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLy7Pyc+aHrvLxNPqD5LTUBK7PumWKtgYcc8QLWddqWLhPF4+
	cJMZxd2VA6e68XQHQXgmdzLwQemgPUjzLsBE4iYWTqNY/ePik49hP1e1GamA/l1bYmQYwHjdUNJ
	6aoO5v/WhpGo5+dZo1NYSt4/Ha5w=
X-Gm-Gg: ASbGncvuaAip9jgRvW8Fn3cA26B+aZA1MJpKYyiMi9G4tEfHQwRSngLSnDa8oubEM/k
	3nhhZ9igDZfuYEH6tN+LYS1HxqkEeQexh
X-Google-Smtp-Source: AGHT+IFXjO+EPeKUBSOFJNaVwOKg9XkggkQN3orr08fT2PbRVnPy7HFChC8PP+H8cWQXCBvUYFZo+BqaOlFDJUqYH70=
X-Received: by 2002:a05:6602:6c0a:b0:837:7d54:acf1 with SMTP id
 ca18e2360f4ac-83ecdc5165fmr1022386639f.2.1732488093432; Sun, 24 Nov 2024
 14:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmt1jx9OHDnNRdcgB+sPNH90=eZYFRVEbO7PcETiN0ojMQi4Q@mail.gmail.com>
 <Z0Oavzr03tTMiKfl@tapette.crustytoothpaste.net>
In-Reply-To: <Z0Oavzr03tTMiKfl@tapette.crustytoothpaste.net>
From: Jacob Pfundstein <jjpfst@gmail.com>
Date: Sun, 24 Nov 2024 23:41:17 +0100
Message-ID: <CAFmt1jxxnnhSysC0cLEptifY=cKLZ4rgBJ4gpp1O7=WkuMzeaA@mail.gmail.com>
Subject: Re: Bug with SSH keys loaded into ssh-add
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Jacob Pfundstein <jjpfst@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

the issue was indeed solved by using the OpenSSH version that comes
bundled with Windows instead of the one that ships with Git. Thanks a
lot!

Best Regards,

Jacob P.

Am So., 24. Nov. 2024 um 22:29 Uhr schrieb brian m. carlson
<sandals@crustytoothpaste.net>:
>
> On 2024-11-24 at 16:23:21, Jacob Pfundstein wrote:
> > Hello everyone,
>
> Hi,
>
> > I've recently encountered a bug/issue while using Git for Windows. You
> > can load a passphrase-secured SSH key into the ssh agent using
> > ssh-add. As long as the key is loaded into the ssh agent, you don't
> > have to enter the passphrase when using the key. However, when I do
> > git pull or something similar, Git still prompts me for the
> > passphrase.
>
> This isn't Git prompting you for the passphrase.  Git passes the
> terminal through to OpenSSH, which is prompting you for the passphrase.
> There's really nothing that Git can do, since it doesn't know what
> OpenSSH will do.
>
> I can make a guess about what might be going wrong here so you can try
> to see if that fixes things, and if not, you could try contacting the
> Git for Windows issue tracker at [0].  Please be sure to search first,
> including the closed issues, as the question may already have been asked
> and answered.
>
> My guess as to what's going on is that you're using two different
> versions of OpenSSH, since there are two with Git for Windows.  One is
> shipped with Git for Windows, and one is the one shipped with Windows. I
> think MSYS2 may implement sockets in an unusual way, which means that if
> the agent is from one version and the `ssh` binary is from another
> version, that they may not be able to communicate properly.  In such a
> case, OpenSSH would prompt you again since it can't contact the agent.
> You could try using both from the same version (I think there's an
> install option for that) or try using Git Bash to see if that fixes the
> problem (even if that isn't a good solution for you, it's useful to know
> from a debugging point of view).
>
> As I said, this is just a guess and I don't use Windows, so you'll have
> to try what I mentioned above or open an issue.
>
> [0] https://github.com/git-for-windows/git/issues
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
