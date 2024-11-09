Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD01E4B2
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731160916; cv=none; b=FBzuVLEQ2rMoXCfFgd30sJFx0w3GyWIgl097dqVWuIuySR7r2/P++U3J40k7x66ji+RNcsMQMf1pS7UP8oSAKYikxN2Jk1Ol4OoykyOrAOpwxeSw4ed2qt4uYAdpMGNQMjN5WW9Ujbs+WJ7Hqqu2gU5dK/bSSzeQOQO0tsyG7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731160916; c=relaxed/simple;
	bh=FJFvLJLCyG9g0dax6J6DkhZhODfe6FthwxWR/Db1Ang=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n63xgdfc//4jdlCIAVMgjGIN9LWvHBF9HCxzhxfq9mUA1oC/6gg3WYBGBZLUY2nMnQkWobbfjkV+cfqmldlW0dmQTx7EK0EjH1UhcmTz/Z+fC4Pa91zn/ecbNNflyljyGiRjJd1D/ioarfPXzwMFPY0/oSXVjZgth5TKu/zkLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J99Km1GH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J99Km1GH"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso3941489a12.2
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731160914; x=1731765714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpmck2Kwmv49XR5iw1uluBzmZvNksRlUtp6A+r3WcKs=;
        b=J99Km1GHCGDS5UCrcevMa7gzc9LIY4ZcNi4oiksd4ThN4L8wogq50pn37E/aMemBMu
         KNMXkpeWVz09mPd0JT3/uwPEOBV8+ox+0RQXJ35y9G1axFtmJG1gey659gI0GK8Fqn77
         +1OVZLC7NKDIOrSdD3rH2vIvxs26EHUCcn15hcxq52egWyV3X9WN2aN44pyebmLS5MlT
         fZCY2Fr7TbpJ9LlDsp5lB+2WB/YB4EKXMTo+0BbpzvenMA9b0qdHwomA6ABJA90enN66
         PhsDLwR6F32+8sflO76afSOtiAdW+uM8aDZqK7gcFp7WY38wYoJvtlKp9sJOCPDMp9wy
         JUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731160914; x=1731765714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpmck2Kwmv49XR5iw1uluBzmZvNksRlUtp6A+r3WcKs=;
        b=en5nu4vwX93TwxeJ+w2qDbZZd4stQ+OVj81iJW+ZamZV5cpeeTNXLw5F8o+FAJlqMW
         vCYzL2VtPIQW8lXWAft/RbWxXk0WsUvDozhMCetINnxE8H1o3SLMCI6s5YcVepzLeHCr
         VtMp48SAh40I/BTfga9ovYVRRIw5OfxbNCyNKS12SisIfBipWmPw3YGqitkLYmZl8nMX
         mtYyOH77Id7902n7cVpwwiOkSHWNDm/lQMRjbHhgQdNFbz4icK8QexQmeCNCdvACPeol
         HD9TDlqlMS6lm2+2VRTqnCtVyWuXvUh1QNgacFxBgD9WA5hi4bXwHG7cNUvHkHBSFgyM
         mK6A==
X-Gm-Message-State: AOJu0YzxKDsZORLwtobqaq6uQMUnwtDxk68cauOO6W3IjBn1nYJbtpZ8
	XSIq5D2F/IecRmqnjF7VZ+ZM7+1oTiugc6ZWu/CqVBnzAfhhKJo5S231D0CWjdjsBpYvqn5lZFr
	N9/I4krg8QoLHRc9iTQgcmXQlB0s=
X-Google-Smtp-Source: AGHT+IGpcgOCQ+iVNNKULzlR0tYrgHqh3/RhH0NirFEAWQ8IaB6Jpvmx4BR0gWgRkg6Vpdif5WAvJgHwLQOA8JBqnRk=
X-Received: by 2002:aa7:c1da:0:b0:5cf:9e5:7d12 with SMTP id
 4fb4d7f45d1cf-5cf0a44756amr4753600a12.22.1731160913181; Sat, 09 Nov 2024
 06:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com> <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
In-Reply-To: <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 9 Nov 2024 15:01:41 +0100
Message-ID: <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

On Sat, Nov 9, 2024 at 10:33=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Sat, Nov 9, 2024 at 3:12=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:

> > You can run each failing test with some options like -i and -v to get
> > more information, like for example:
> >
> > $ ./t0000-basic.sh -i -v
>
> I was using make before. I tried to run the single test as above, the err=
or was
> ERROR: ld.so: object 'libc_malloc_debug.so.0' from LD_PRELOAD cannot
> be preloaded (cannot open shared object file): ignored
> I tried to check this online, but, all the solutions I found were not
> resolving it.

First, as a workaround, maybe you can try:

$ TEST_NO_MALLOC_CHECK=3D1 ./t0000-basic.sh -i -v

to see if things work when disabling malloc checks.

Anyway the issue might be related to how your shared libraries are
installed, so using ldconfig might help:

$ sudo ldconfig

Alternatively you can try replacing the following line in t/test-lib.sh:

                 LD_PRELOAD=3D"libc_malloc_debug.so.0"

with:

                 LD_PRELOAD=3D"/usr/lib/libc_malloc_debug.so.0"

This is a hack but it might help understand what's going on if it works.

> I look for libc_malloc_debug.so.0 and it is located in /usr/lib
> uniqueusman@fedora:~/git/t$ sudo find / -name "libc_malloc_debug.so.0"
> find: =E2=80=98/run/user/1000/gvfs=E2=80=99: Permission denied
> find: =E2=80=98/run/user/1000/doc=E2=80=99: Permission denied
> /usr/lib/libc_malloc_debug.so.0

Yeah, not sure why it doesn't work while you have it.

Best,
Christian.
