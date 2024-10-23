Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1281E7C16
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717464; cv=none; b=iv32HCJXsxiYaHgRPbYU466zq3unKHuXPgApYTPG/xW6Zl/u/K5y9Sj7apJdAb6TpZBrdgoD8nhftxjD1ex9L2k0+5FjEK5q4QR/j/Lry44m+0ZKqvANFR80g06hMNIHZicC6Ae2+OOUCthSqzr3ATZfEjYrVtumrRPN+mA/nSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717464; c=relaxed/simple;
	bh=19WYqa3IRkUfIM6dWWPSo2hG1R1/Cc5cqYZcIdLgPPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojbD83psA+UTzbs6DZz0nTL+7lQ1yqN6fHGlfmC6rA7fElvr7wfepfBxZLyGX6eq9GbYPI5zzhDZynLVPNgwSsvTBFce6LJAVARa0hiMX3ZrujIUBKj8LvqUUv3ceWyKPTD0Fo+UE1kc2b2jkRS1AP7d2D11rGmJxwzGfg2i/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlhxLT+u; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlhxLT+u"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f968230bso157972b6e.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717461; x=1730322261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12SZvaE3FO+A7DJn60+WmbHMoi0ytfaMiPuB7fwrA7Q=;
        b=OlhxLT+uaQtgOb27iLU63fQTf8q+goT3f4vIZ5/q8I95wHlu43aG6TMUZUANowNvp/
         tbinwrNzwPMYlYohFrzefpdiNmXh7lG3vJmE/FhzxZtEIqo1V2Zvp+0BIsKOsR9jMF21
         Y1Txt5AfkxhiQVWbdtkhehK9U1gYMdfQGHuFjPdVeCNg05SJci3zHRWKTpN6Y/Kiy08t
         +vSvpvxwGteU+kmnOylX5QWn27k8+yvV2UYRBqCVvi7EIgcXWnZP98w7XZz2lbzH2D9A
         kAUmzKkSsOR73lGxJRZKjV+oJ3kLs+WixW9p30gs2iSr4VuAbKD1ZAEAAkgvB5Fo+saY
         pieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717461; x=1730322261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12SZvaE3FO+A7DJn60+WmbHMoi0ytfaMiPuB7fwrA7Q=;
        b=RGI6Z64kDNh7XB3hbM8rywDAi5zv9XBZjFGZNVTnLyzO+Lz7F7ILkVSqLtCtI+7AkK
         h+a292t4r0TavSDU3fPFuDDKCRv0fiWFehpuIgyEkogcvxQXz90ZGyw1huOnRquLamuL
         6r2f6omQnqibkWlMrwJ6D7WH6fJAmCv+5YYmrstc3dxJM8oJr4VqhwtbEhPcTZyjYqEN
         fiU9lbvhWCSseFrsI8x5U3Pe0Yx/z5A0AKutJ5rImHas2nr1whNFyBXNt2n4sFQugQr/
         1sxC46j97xcUcqyl/pMsW+VnpEjIL1wdDN3J7G6YMjT+Ifs7oIHajNmyKQhyErLyK5Hg
         qL5Q==
X-Gm-Message-State: AOJu0YxmNN9f9rT0vbb9vd0N4WUgTIX+8dVgyo1BDdtJfWBr0FEBOcJY
	GreRZVjNJffGoSMj9KpDRKmb8fMKpAyeI+SbDDiyC4xsDkItVTooUi16meTG2/BxE+/mjgn94tw
	Ktdmiev1rMxA6LeCTOKmSw8cmvsk=
X-Google-Smtp-Source: AGHT+IFYH83NBygk5cm8kNBOmN3rVig9agGCEFC2xDDPVu1zPvlsxOOyPqVh/rq9jLAc+Q1Hfark5EpnE63RbciMhE8=
X-Received: by 2002:a05:6808:3a19:b0:3e6:147:6c5 with SMTP id
 5614622812f47-3e6244e65a7mr4712812b6e.10.1729717461330; Wed, 23 Oct 2024
 14:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <20241023075706.1393147-1-karthik.188@gmail.com> <Zxld62svV9iDCcJJ@nand.local>
In-Reply-To: <Zxld62svV9iDCcJJ@nand.local>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Oct 2024 23:03:55 +0200
Message-ID: <CAOLa=ZR7gBCuawUxhQ_j=E5-GqKD+xP0+rPwa6DWAxn9g03UBw@mail.gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: discourage arbitrary suffixes in
 function names
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:34=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Wed, Oct 23, 2024 at 09:57:06AM +0200, Karthik Nayak wrote:
> > + - Function names should be self-explanatory, clearly reflecting their
> > +   purpose or behavior.
> > +
> > +   The '_1' suffix for function names has historically indicated:
> > +
> > +    - functions processing one of several elements that all need to be
> > +      handled similarly.
> > +
> > +    - recursive functions that need to be separated from a setup stage=
.
> > +
> > +   To maintain clarity and avoid confusion, such arbitrary suffixes ar=
e
> > +   discouraged, as they provide no meaningful insight into the functio=
n's
> > +   role.
> > +
>
> I'm still not sold on the suggestion to discourage the use of '_1' in
> the future, so we may want to further qualify this statement with cases
> where it is OK (in the spirit of Patrick's "as long as this is loosely
> applied" comment from earlier).
>

I would say that in some sense goes against my motive for this patch,
and I still firmly stand by not having '_1' as a suffix. As such, I underst=
and
that this might be my biased opinion, so I'll drop the patch overall since
like you mentioned, it probably is better to not have anything at all added
to the documentation.

> > +To maintain clarity and avoid confusion,
> > +   arbitrary suffixes such as _1 are discouraged, as they provide no
> > +   meaningful insight into the function's role.
> > +
>
> Stray diff from the first round?
>

Indeed :)

> Thanks,
> Taylor

Karthik
