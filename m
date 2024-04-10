Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678582883
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712737106; cv=none; b=t05kFUQ5ecjAHzvkp8570XvrKBcC9rT9ZJccjEzOG4aWqQVj8syPluwlp+lTdDcjkAM7k51Ey+GmcJeVPP6YO1oLgB0SDY66AbxX+zlntjQdnESii1iNTMVHNBku+8K26Aq6e+irKqwTOQDuuudTyrsiRKSV8N+mdKToxxxDWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712737106; c=relaxed/simple;
	bh=k2pec06IIf7C7sySDrZ5EULaaRSys+PkSqpKncjXBgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qx/OewpGzssvGinz56IWEeYDHkAty0PuF9XSsx68/CpkV1uegNQh8aaZ0+Cihf7bKi77ux9gHjo9+up3njPOJ9g/jRNxUYkmmiXsTtlw0ukWwgyxxMH3GpzajQe5S1GO5klQMpIikQ6Lqu8C4cezjRItzzPwSgxcr2Vn6+cFm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNcOFxwQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNcOFxwQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a1c8d931so608540866b.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712737104; x=1713341904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvJJAJqwSFS/Yu3yjAc8yoyaHXHcuh1oR2Dj/jSx0eQ=;
        b=FNcOFxwQkBsYSRBZIW7mMZlGuvUtN5QHZwJLJP5KyCARH7k6mKA4sfgCxoVZWzepje
         QCvMZ3quuUK/PZqLB+IojtWGM0oul/tkcOXnFHjV8c+N3YZNBto7tHMHE+OgGIY9zaRO
         HVHSCP3Ey9l9E90QJ1LGjC8sCUzJnfRfOjt4ZgJOW8d8ZRKPBW4t5azeksQLcToQ/qAj
         O+MncJSJoYpAZG9uJ7SKY740Ryinz/j3g1fumCCFLx9CfLY7qv/bfcG7QEN3RbrTMZTh
         K7vBJFecRXvDbcZXa+10STgbX1Vhv5qmV3EMYRbhXi8WjVLFwA6tMI+4mnzpfEaSxdS6
         J2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712737104; x=1713341904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvJJAJqwSFS/Yu3yjAc8yoyaHXHcuh1oR2Dj/jSx0eQ=;
        b=YRf/4CYN9zS9ncnpjDBha6D7nKMxW+kfF5hO3NFSnJv54NHMPCYcgVh6OL4A1eB/Mj
         W0ioZd4DlqPsB/zbAvqPq/8+x3iWiPTHeBHKW6ifleoVDqMoVZq20b3WKgKRPsADVhf9
         jd1Vl3eN0uud35C6n1XzDE1IDwG9Iso6+4mUjXnqQjrSutx/Lv2tIsZ1NZvMXzWLVNXI
         kZSZgh7CPkA+HFBsPBSQ5EqqXykRK5JhP0R1mTC/zkupNQtH4yAMkRJopJ97nM9qU65f
         2jOimin+PN1xNfIytjLBe/Pi5KDBsRt8NrYmOFtPvtQ9IjpUWCWGdOFxvdM8j+J1TF/t
         mRMw==
X-Forwarded-Encrypted: i=1; AJvYcCVHCgfNRB+u56UORUADeMD/z865/KrEeBzSjSnOzGQ6H9YYhijrHaH6GQKetZbPY6q0JIwW51rl1au6vKavzq9sp5sm
X-Gm-Message-State: AOJu0YylOfdXmq9ISUT/EXUZZNWArvKimYirb01V6uMLCwM+MK65Qp1H
	MjIY0of16s8yDrurUSIq2yJw4vtK/ZCBWZI4+ApgHq/63K/i2hvq80PP5Q9fSK7gMELcYo2cVfO
	ILmNrWHEHiQsjC8uR6MWMl7aUzXQ=
X-Google-Smtp-Source: AGHT+IGSdaLLyndrloSL6JJk0DSK/cmbi0ZYLXRARDfmuweel6CtiiVBMCGKqhCM0tPwmePxd+9Me/mL3vXDLf2XjoI=
X-Received: by 2002:a17:907:1ca0:b0:a52:3d1:6769 with SMTP id
 nb32-20020a1709071ca000b00a5203d16769mr1341480ejc.14.1712737103602; Wed, 10
 Apr 2024 01:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
 <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev>
 <ZhYxNYR33ftEfcPk@tanuki>
In-Reply-To: <ZhYxNYR33ftEfcPk@tanuki>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 10 Apr 2024 01:18:12 -0700
Message-ID: <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
To: Patrick Steinhardt <ps@pks.im>
Cc: Thalia Archibald <thalia@archibald.dev>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> > +             if (include_spaces)
> > +                     *endp =3D p + strlen(p);
> > +             else
> > +                     *endp =3D strchr(p, ' ');
> > +             strbuf_add(sb, p, *endp - p);
>
> strchr(3P) may return a NULL pointer in case there is no space, which
> would make us segfault here when dereferencing `*endp`. We should
> probably add a testcase that would hit this edge case.

Note that you can do:

    *endp =3D p + strcspn(p, " ");

(though `strcspn` is a fundamentally harder operation since it
takes a string argument). Everything depends on whether you
want to test for an explicit "there was no space at all" case of
course; performance considerations are secondary.

Chris
