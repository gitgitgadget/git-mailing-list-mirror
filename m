Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA83365
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707539658; cv=none; b=dAg2tMKZo27P+fsfx1mIMLsPOWgyN2xPiu0rzm0dLj9fSN7VRlo0eADOr56APISV/DUT4tTcHEGQAsDewvWYwNZ51HAbWqx0HKuvr9qEBYlr+xI/O33++9v92KB6QLOwi0ZzwmLba27ML/pLtL+TA4ZNCdQPpFndPfi+6/A/2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707539658; c=relaxed/simple;
	bh=7uE72IUpCFASvaI0B1bvzZyihvvTNernr17B48hI9yw=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=m1Uap9IZB5B4akqtN5PIIE6UFUS/C1GAsKLRYN8jxDqDavCY+RZfWupwbzfmVxW81cfEBBmHnFp3HUUBmJywl9zJO6p/eoISouOhfshqO0ENwVXG/bG3WMElivnJtc2VzFzVvBuwPgk4tHFvTu3pEat1mYzqkeDydsm3D5V4aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZbY+Avw; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZbY+Avw"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c02cad1dc2so106552b6e.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 20:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707539655; x=1708144455; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uE72IUpCFASvaI0B1bvzZyihvvTNernr17B48hI9yw=;
        b=lZbY+AvwjmQ0xz0t696yrZzslDXqYhS75NLSBrjbLbKDtSltXnGJ2Wst2Gp37QNQr1
         CE+sneXonxolZR8sIcWHCTMspslew+dfgA5fEssS1lXOvlSRvv+qDHi5zfz+JBEUIcTg
         Nz6AaZIWLyjrLpJgXMUVEtJndEHAuhjZMzP0ow6dW4AuCW5qRU3kmF8HptKXJWdd+Cwv
         CO+v75WUV+oUwcDkCJpr9hccZE0ItFrzZtCSdA+o+m48MTz83WHIl32Rhn3N1jYURRhA
         zK/xzasXzXHDoUq1bLAGcLKwwbGTFZbP9SEjGrp06o/w5pfHxXdqw467mqYG5R+bZ1cV
         2kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707539655; x=1708144455;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uE72IUpCFASvaI0B1bvzZyihvvTNernr17B48hI9yw=;
        b=PN67Saoviwh1tTW+d3d4o9mRcRW5fYtBkg0sfWYL4OQbqTeg30Keb3sdWFXPTY6E4V
         7MeEUYRqkzTGa4DM3uH2rgANatQ8VtNn1wjNcArXKrRP9RSBUVL45YkP96l+dZ4+EU5g
         IQ7tg1bz+0svV5BQaEARh95PTxkqduEUTCDbDJhcJsBTchQEclm5ATBBkaj3EjXFc3Sc
         TPtLHK/MSpkSuvIAQ8MAkVxdtkXOj0WbPxh+3ZqlKrvAwG8dCqdAB3bnqravOF66FPYx
         Rj+fgNt8jlaoI9IOeD+feTXGaTi4665TChkgv1Bv9P5b3OlFIFGHaIjctSa0BWCN30Sl
         iQDA==
X-Gm-Message-State: AOJu0Yzvb5AuQ2EzNUwvtVL8YFqFPlooBrvVIXt32JZQ2DayMNPqAhKt
	K75lzCQO6wSa0jC1Rc4ObZ7AZyL6SDPA5W0Mn9JktzU+g2XRgZ+CmyRT/9vQ
X-Google-Smtp-Source: AGHT+IEvMcmJ6qHa2C7DduJ1Oj4AvbICFmOxNuuB/jcyfBRkkqJY5lRr9FffS0DekwhuVHPluQyLHA==
X-Received: by 2002:a05:6808:7c5:b0:3bf:daf1:48bb with SMTP id f5-20020a05680807c500b003bfdaf148bbmr1146304oij.29.1707539655204;
        Fri, 09 Feb 2024 20:34:15 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id 7-20020aca2807000000b003bfdf6679a4sm559170oix.25.2024.02.09.20.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 20:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <8ff4650c-f84f-41bd-a46c-3b845ff29b70@gmail.com>
Cc: <git@vger.kernel.org>, <me@ttaylorr.com>, 
	<newren@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
	 commit options
Message-ID: <17b26644b51ba1ec.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Sat, 10 Feb 2024 04:34:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip

On Thu, Feb 1, 2024 at 4:57=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.c=
om>
wrote:

> That sounds like a good strategy. I'm wondering if we should not change=20
> the behavior of `--keep-redundant-commits` to avoid breaking existing=20
> users but have `--empty=3Dkeep|drop` not imply `--allow-empty`. What ever=
=20
> we do we'll annoy someone. It is confusing to have subtly different=20
> behaviors for `--keep-redundant-commits` and `--empty=3Dkeep` but it=20
> avoids breaking existing users. If we change `--keep-redundant-commits`=20
> we potentially upset existing users but we don't confuse others with the=
=20
> subtle difference between the two.

I am starting to come around to this approach for this particular series
just to avoid anything potentially controversial holding it up.

>>> Do you have a practical example of where you want to keep the commits
>>> that become empty but not the ones that start empty? I agree there is a
>>> distinction but I think the common case is that the user wants to keep
>>> both types of empty commit or none. I'm not against giving the user the
>>> option to keep one or the other if it is useful but I'm wary of changing
>>> the default.
>>=20
>> That practical example is documented in the initial discussion[1], which
>> I should have ought to have linked in a cover letter for this series
>> (and will do so in v2). I'll avoid copying the details here, but we'd
>> very much like to be able to programmatically drop the commits that
>> become empty when doing the automated cherry-pick described there.
>>=20
>> [1]: https://lore.kernel.org/git/CAHPHrSevBdQF0BisR8VK=3DjM=3Dwj1dTUYEVrv=
31gLerAzL9=3DCd8Q@mail.gmail.com/
>=20
> Maybe I've missed something but that seems to be an argument for=20
> implementing `--empty=3Ddrop` which is completely reasonable but doesn't=
=20
> explain why someone using `--keep-redundant-commits` would want to keep=20
> the commits that become empty while dropping the commits that start empty.

Nope, you didn't miss something -- I just didn't read properly.

I don't have a concrete example here, but the behavior *feels* quite odd
to me. But I suppose that's not a good enough reason to make a breaking
change.

--=20
Thank you,
Brian Lyles
