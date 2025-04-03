Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A91514F6
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698349; cv=none; b=V1+6gQLIh4RwR5uxw65CYWeplRNYSnAlLKNvrZ2dA+j5alPjb4+g91WDdKJMIhDk+APMet8Hf01zDge4Q2iZ3ciK0f8UFQUKdoxRikXr6srlHoH5PXXzOtHJfNQ16qmFAqfqYJUuE+AIAmmITqHKxiEEuMrWs3gFf0a6CPF8rpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698349; c=relaxed/simple;
	bh=5N42C6aUIA0WycpAQD02Lv20zhzfB37557uvDgDok50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg3f6lf/t19hDmQmxTrLVDF7FcOWRKi2/P6AnUKYkhlsETrGMPezjH90vWKDzZdXrBAmapJTA/wdPzfD84YIQa3b5Qn11ldw7KtvXSuE7VAwPVoxOUL3IKXpKDzQyL7qbacMQGC6PZnbvzjnwoxGU2SUvLL5FLPU94JQ7z/tQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=algD2aBh; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="algD2aBh"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso35454839f.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743698347; x=1744303147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3IXkFibCIbCiefrBfcrQjmZjF+dLuO6o8otb5gQVZo=;
        b=algD2aBhiFSwdY9Pd0qDalHipL9QlgaE0iT0iDwygnT2i0VnmB2iDyjibgXHYnleq5
         qpayyPljdsusdExgtr8NcdxlYjK2f3BS5T1Q/IyDnr6g+0gypPHGNpdes/zg1D0Ve2ms
         Q4IuguomvOK9/OsA0X0ayKU224EJvTVUkL/Zqa8ezRpN1+9bOfsY5A/CRjgno7V4BqsD
         EF/ok7yDRUd39Kiz4YdMJ9CMfm6i4PZvnwzA65ChNwL0FepWQeBJDyOwqReUi43j5B0J
         1HNh6Z8myQCXDfQe6h+AINmOFJWWzU0RJcv5e7NerhOhcePm8srFyKRe7lxfT0df1gVU
         Ykiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698347; x=1744303147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3IXkFibCIbCiefrBfcrQjmZjF+dLuO6o8otb5gQVZo=;
        b=Ewt9hPWPczWRfr7jJqbebg1Noi9vqUYIfNnroSvTCvMki9MG7O+o+3JJyQyiOtaUbC
         pV3X7wjhVwG3qdLfoLNipx/aukSeTzXm2yDBYpCZSORAwEIixhPLUJnqdyJ5tbzXcBF7
         5NxhgIZKkSpB+jecnpKrVU8UEzSTp/nnJe0MvOYyCzL3/6gL/OlxvN+t1cL92IaVFq0S
         yh3dxhTnI7fRikLktW0s/A7j/98Nnmrp1T9/KXqUtt/yL6ls2gk1t/PWXl5R753hzCLE
         WBcRWioFx6XjP8odFK0G0VDk66UAL5NDk8ISfmBnyKyfq0BJIm6Gpe/nPtDUX4IHU+4M
         sglw==
X-Forwarded-Encrypted: i=1; AJvYcCXQhSRY2E+Evn/JIPktntPgEpdO4TRUNe8u0K5MBSwa58JcK++yBHTyTA1oe1xlzF7v9vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybE30NnO49AG8tPnJrH41K/hWS5ywreQttKU4IViF42cKJAAtx
	2SRemnjsTHNgPWQguxOQCQgxXTKYaDLmAPXBVJNHOQGdpAp9+vfJUf/Sdk4+Ll9Yf3BVxqvY5g7
	5FRDmQoXfExAApzasivQl8c0a5qU=
X-Gm-Gg: ASbGnctpFh7VTgsMlJLIA9Sh3/NUlr4RsqKoveXrHYIThY6LYuV7l7OefFq9SX3AGVt
	GuDEj+6m8DFStIdFE2ykp/g+UM1xbxrbUg/MT2++Jy/jMXIxNoXarzU1BjL8URFIN5vbTUo+SmN
	ZHO5cPlIanClvjHVSMwArqwAb3vHQbJ+AqHgkSWRGiopXGjPXtZgbyJknNFA==
X-Google-Smtp-Source: AGHT+IEvY43DNVXqgBjhg0IziuTbeX0dKKIQDM/huXylz8R9z+uhWf4IHsmTxGazdPZfXpijz/f3QFxaf9stinL6Tus=
X-Received: by 2002:a05:6602:3f69:b0:85e:d0ca:b635 with SMTP id
 ca18e2360f4ac-860da280c81mr431026839f.2.1743698346918; Thu, 03 Apr 2025
 09:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <Z-5QR57zgSsm6jNP@pks.im> <CABPp-BGwXaiohvfSdr96hzKNPYXQqz+_okxLNj7P9KSjX2PW6g@mail.gmail.com>
 <D8X571K4M77Y.2PVKK2KQCRBOM@buenzli.dev>
In-Reply-To: <D8X571K4M77Y.2PVKK2KQCRBOM@buenzli.dev>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 09:38:55 -0700
X-Gm-Features: AQ5f1JoN5WCpEXmqgAYGdD6zKhCNsaow8V5NlESPTlbV2HpRogNVz9ORppOuOxM
Message-ID: <CABPp-BFr+4iy7awessWSY8NzzswY1-=30L4VvOZMpFDoOxJUgg@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Martin von Zweigbergk <martinvonz@google.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:25=E2=80=AFAM Remo Senekowitsch <remo@buenzli.dev>=
 wrote:
>
> On Thu Apr 3, 2025 at 5:56 PM CEST, Elijah Newren wrote:
> > On Thu, Apr 3, 2025 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >>
> >>   - Extending revisions to allow specifying commits by change ID.
> >
> > Would this essentially be similar to <rev>^{/<text>} except searching
> > specifically change-id headers rather than commit message?
>
> One benefit of using the "reverse-hex" format (hex with a different
> alphabet: z(0) through k(25)) we're proposing is that it allows a
> change-id or its prefix to be used in the same place as a commit hash,
> without ambiguity.

I already saw that, but this doesn't address my question.
