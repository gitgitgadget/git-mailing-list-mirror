Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87A60DEE
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786177; cv=none; b=htI+z+m1B7ZfSxvvfiYAyLEChkeRjKqMNoqK56XvG2YONhUoYH31Kzd1EQK9NFhHdGzMN2AZQ/kUF9rLwHCnXKpEgCU9kairQeHxQggNwf7t1dJvQjwqelC2Qp84uNOpta+q+mEabDiFRDCdq6Bm3FIpWW5Su95kig6XT+hfRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786177; c=relaxed/simple;
	bh=TFgpKGzvr+UoDdR7ZNaMeG22UGWItbUC0nDmVKpaa34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNmFDH+PNRg8orspTkQEHwQVEKiQLUMqHS1k9Tj5OyYnoBoZKI9fkFKHmoQ9u5hgmzkXbMUi11EUtm8XvlQrAnd4Zhh1gSesHdpLJ5S/FC8n2IPRfMLtlSG+ahQ1C7McMh4/IZNwvtl7EWhQIiZvn6dzTgbv+Ic1L0y3d/lMffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=El+XmiI3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="El+XmiI3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso35934566b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707786173; x=1708390973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFgpKGzvr+UoDdR7ZNaMeG22UGWItbUC0nDmVKpaa34=;
        b=El+XmiI3eL16rNIkcvkLy8j9avU9ibSWlo8npFZmMKwCHw/84hKaOLUv+CWLEkxv7n
         38K+uZ3QpNJ6CEkaeogvVljADHtApZUM4THEXl5hm8hr8pVZEXuf0HG2CAg1kCMwVgGj
         5MxldPAfdcYmTs6pUmSp1j2A+4Kj2+DupEnGeZa4Pt8CUdCXeaVDiVmo5g8XggU10O8I
         Z5CGMWKxxB3Y2re6JtMyJfFDKFmKGpNuYOU5kOKAGxor/p7tg8JnT0HDzs9LFW3y4cXb
         PmsZnA631cLf51tqaQ0LooQ0JvFmi/1mQEOxlGVM8aprtOvhJG/99MpQWy54dBYJy3kM
         qCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707786173; x=1708390973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFgpKGzvr+UoDdR7ZNaMeG22UGWItbUC0nDmVKpaa34=;
        b=HS4pARnw8VjK0G9wcMNaE9im97mkMxp5RS+IHlJLVMDELGBcpHIRZ7uaJLcCAvbRlR
         /BfzcKr8bqZurKgj1I1vlr3Z0lfHvPIx92lfe8cYAm7UN+of4mFlQKYZyiwSggJOhoM8
         JmsmFuhooc2Yl4r0mcOChNtzYgxcGVqOy/SuJhnzttSfoRFeECL78bcdUZAEwPuiJHsS
         DZ8/AC6h0OpvOIZTkyT/oGqw1mxd38jl239VjdAdEi9OL3yeZHDAIydc+XzG8EmSZsPR
         KhL6LSyFHUwN0QiSAVNRULw4QeVp7x0omwGLcns1pKk/XilAAw38rkrPrPJFrqe4HoXB
         O2Cw==
X-Gm-Message-State: AOJu0Yz/xq/w6/d0f/ij+/ADTWCdGogHtHV8qb7qrzQeS4YOMR51tSS7
	tvx2gi1jNmsl3Jettb0IGESYD3pTjzqk6OLRahpr4Xqc7Z9X1B2v+vX1cMiTElhdAFMFOTQakBH
	HMQdlD4VAvNIgk1b/rjfUcEtC6SDiRdtPVLUenlanqooXsPg0sQ==
X-Google-Smtp-Source: AGHT+IGnJBKVpu1EbVXawJKkOz/D/eHIH8icu4N4KfD5Xa6jRghjVhen8U8hey+hz6+/WNEHXpBUdit4Ci7NhUN+7Hs=
X-Received: by 2002:a17:906:558a:b0:a3c:f048:c9eb with SMTP id
 y10-20020a170906558a00b00a3cf048c9ebmr568902ejp.12.1707786173408; Mon, 12 Feb
 2024 17:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
 <000301da5b5c$5477d7f0$fd6787d0$@nexbridge.com>
In-Reply-To: <000301da5b5c$5477d7f0$fd6787d0$@nexbridge.com>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 12 Feb 2024 17:02:37 -0800
Message-ID: <CAO_smVg-xxVeevuPr_E2F9mjnDzN7Tq6o9Tkhy4c+9qBmQTxdw@mail.gmail.com>
Subject: Re: libification: how to avoid symbol collisions?
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:31=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On Thursday, February 8, 2024 9:30 PM, Kyle Lippincott wrote:
> >While thinking about libification, I was wondering what we can/need to d=
o about
> >symbols (specifically functions, since our libraries will likely have fe=
w to no extern
> >variables) that need to escape their translation unit (.c file) but that=
 we don't want
> >to risk colliding with symbols from our "host" project.
> >
> >For any header that we're offering up as an API boundary we can have pre=
fixed
> >names, but there are symbols from git-compat-util.h with simple and like=
ly
> >common names like `die`, `usage`, error`, etc. I'm far from an expert on=
 linkers, but
> >I'm under the impression that even though we'll only be #including git-c=
ompat-
> >util.h in our own .c files (so the compiler for the host project wouldn'=
t see them),
> >the produced static library will still be "providing" these symbols unle=
ss we mark
> >them as `static` (and if we mark them as `static`, they can't be used ou=
tside of their
> >translation unit). This means that if the host project has a version of =
`die` (or links
> >against yet another library that does), we run into what C++ calls a One=
 Definition
> >Rule (ODR)
> >violation: we have two providers of the symbol `die` with different
> >implementations, and the behavior is undefined (no error needs to be gen=
erated as
> >far as I know).
> >
> >With dynamic libraries I believe that we have more control over what get=
s exposed,
> >but I don't know of functionality for this when linking statically. I'm =
assuming there
> >is no such functionality, as projects like openssl (ty Randall for menti=
oning this)
> >appear to have a convention of prefixing the symbols they put in their "=
public" API
> >(i.e. in non-internal header files) with things like OSSL_, and of prefi=
xing the symbols
> >they put in their "private" APIs that can't be marked as `static` with `=
ossl_`. I'd love
> >to be wrong about this. :)
> >
> >If I'm right that this is an issue, does this imply that we'd need to re=
name every non-
> >static function in the git codebase that's part of a library to have a `=
git_` prefix, even
> >if it won't be used outside of the git project's own .c files? Is there =
a solution that
> >doesn't involve making it so that we have to type `git_` a billion times=
 a day that's
> >also maintainable? We could try to guess at how likely a name collision =
would be
> >and only do this for ones where it's obviously going to collide, but if =
we get it wrong,
> >I'm concerned that we'll run into subtle ODR violations that *at best* e=
rode
> >confidence in our library, and can actually cause outages, data corrupti=
on, and
> >security/privacy issues.
>
> I think we only need to do this for functions that are in the libificatio=
n code-base for non-static symbols (and any data elements that may end up i=
n a DLL some day).

I believe the hope is that the majority/entirety of plumbing code will
be provided as a library, and we'll likely want to have a significant
portion of porcelain code as well. I think we're really talking about
(effectively) "all of git", but not all at once. If we attempt to make
things safe based on guesses about what's likely to collide with other
project's code, we'll (a) get it wrong, and only discover later when
they try to add our library to their project, and (b) have a
maintenance burden, where we now have to think about every function
name we introduce, which would not be fun (and we'll get it wrong.
Frequently.)

> The bulk of the non-libified code base would only need to adapt to new sy=
mbol names if those symbols are specifically moved.

I'm not following what you mean by "moved" here.

> die(), error(), are probably going to be impacted, but they can be aliase=
d with #defines internally to git to git_die() or git_error(), for example.
> --Randall
>
