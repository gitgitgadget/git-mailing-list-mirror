Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8E14E2CC
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164363; cv=none; b=TEfyLOp7+5399hTr5tIaE1CS7OGiv/O0Oo6dMHynq3mTVb7BJw3dLbdKawR9UVgftW34M5thI8SEScipP77ShoUJfRD05hON8TquOm8j7rj8iIWmyCijnJSPi+GE0MBQkLUe3bi9ZzyE3+My7DGHZI2cEyMiSygfPE06d3526UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164363; c=relaxed/simple;
	bh=TGzBLdxMT4NrXFM1rwyq6TOsOeHrQKvtGq3uZ6b1Z3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNCMOlE6AZLSOJNfyElwtaHZ+RviLZ6pRd3HHcPgKt3OC/LjAsHG/CrzeZW//MXNoa9H7uPO1ulyGkOZQBPlqvdB4qkS7EEqK8DcD5GbP4wtk1unW76fIlnAXYSm+mScAiCE9OYYKpwNHykG7v3e2RJ2D9I2Il/Xx7N3qbodgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhHvf5jp; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhHvf5jp"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso1219473241.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731164360; x=1731769160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=726GYHbzR0CmGsYlvfEIqPSBPUYaC5yG1xAtaO4kqQE=;
        b=JhHvf5jp2layLuGbn5eKdBX4wr+jP4ZPjXdo3eKiu4TF1r9RLj0smaHEizdR9ReZvQ
         ZxCRdj+XUBjrPi+QLsJu+OTQd8bHNh0WfDGtkWZiWABcdryNnw+2cGEkoH1fdKm+eysC
         bG3FInTs6B7r2Zug7+T7u93XLI0T1dHmn2aDaK0sjwZM+D/KMBOhr09lqQUhxYtPOB2l
         Ws2oWmVJUp4LY3II51mpxqTrGbXivfeYZN5QV5/jik3gzTYAgly8+6CHtnER7d7l22kw
         9+ekRlGkjnJOygqjTjhkIyl9GQOzA+7NPodUNNdj4IKPluQMdOiMNoUSjc4xxzqR/zCB
         PXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731164360; x=1731769160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=726GYHbzR0CmGsYlvfEIqPSBPUYaC5yG1xAtaO4kqQE=;
        b=gQA4QrP0O9+cCMaEkFAY9koqpS/crO47RuLDDChS79o6x3cjN9X+4/bnqht/Zt30w3
         Ctz4K4nxgB4IrEHl5tIiN2CXIk7E/NAm+5LWspiM1hSI2M114vRrL0CWLw5zlx4zsYY/
         07eKvUVbeDKZ0G7UtWDlbM2M5kME8H8EwVCxbpkUXTKWll3yVgaUcyAdYU0/Ky5hfQsB
         Ur/JIlrIG3fmIVVsfCUDdI3MYkSrAwnCUWkRvXmwcLc6zVM7FOemuamjqW2w7dpdvOXB
         E5yiLe3b+2wcidW+mUdY3R/Jy5CgymyCmHzWHVzXDTxqgDfJ5DSjvC4DluqzrLnoNjBc
         Qn6g==
X-Gm-Message-State: AOJu0Yxqe9JgysE2kmJ4st93wTPRKVMTwR7V6DwaYgTnqbS/If+ZJbTd
	PrXh5LiHkjik4MzF6dFaTZgw+5nVwcarglLzjSio2xyGjq/P07el0agEflnIAzisU0QGZQFyLao
	Lb7N6DSezRifKDwqQ0OdzwA/iPQ4=
X-Google-Smtp-Source: AGHT+IFHdvJwGx5O2CwQUV0C4r3udK5fTWIG/CI+d+HfgcBcx4pRAFEAjxvKzCbVdd9tC/VE7hi3+I4RvxKi7/tYrDI=
X-Received: by 2002:a05:6102:419f:b0:4a4:8f4f:136e with SMTP id
 ada2fe7eead31-4aae13b4ad2mr6752834137.15.1731164360421; Sat, 09 Nov 2024
 06:59:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
 <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
 <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com> <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 09:59:09 -0500
Message-ID: <CAPSxiM9AwwmoPcoGs57A8HtwZVMOH5Kzgsa4ju7DqhFjMAeKSQ@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 9:01=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Usman,
>
> On Sat, Nov 9, 2024 at 10:33=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > On Sat, Nov 9, 2024 at 3:12=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > You can run each failing test with some options like -i and -v to get
> > > more information, like for example:
> > >
> > > $ ./t0000-basic.sh -i -v
> >
> > I was using make before. I tried to run the single test as above, the e=
rror was
> > ERROR: ld.so: object 'libc_malloc_debug.so.0' from LD_PRELOAD cannot
> > be preloaded (cannot open shared object file): ignored
> > I tried to check this online, but, all the solutions I found were not
> > resolving it.
>
> First, as a workaround, maybe you can try:
>
> $ TEST_NO_MALLOC_CHECK=3D1 ./t0000-basic.sh -i -v
>
> to see if things work when disabling malloc checks.
>
> Anyway the issue might be related to how your shared libraries are
> installed, so using ldconfig might help:
>
> $ sudo ldconfig
>
> Alternatively you can try replacing the following line in t/test-lib.sh:
>
>                  LD_PRELOAD=3D"libc_malloc_debug.so.0"
>
> with:
>
>                  LD_PRELOAD=3D"/usr/lib/libc_malloc_debug.so.0"
>
> This is a hack but it might help understand what's going on if it works.
Hi Christian.

Thanks for this, the problem was due to the architecture, the one
/usr/lib/libc_malloc_debug.so.0 was 32bit,
I had to download the 64bit by downloading glibc-utils.x86_64. I did
not face this when I was using Arch Linux.

Thank you.
Usman.
>
> > I look for libc_malloc_debug.so.0 and it is located in /usr/lib
> > uniqueusman@fedora:~/git/t$ sudo find / -name "libc_malloc_debug.so.0"
> > find: =E2=80=98/run/user/1000/gvfs=E2=80=99: Permission denied
> > find: =E2=80=98/run/user/1000/doc=E2=80=99: Permission denied
> > /usr/lib/libc_malloc_debug.so.0
>
> Yeah, not sure why it doesn't work while you have it.
>
> Best,
> Christian.
