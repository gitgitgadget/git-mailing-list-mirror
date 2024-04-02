Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D841CF83
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038605; cv=none; b=Iujhjtzu5QGflvf27AGrM7pW6kTSauvRTmCUNcdHkDcJBtnG2cNdm6I2oVe1A68G3P2j6F5KdTNx90XOijiO9IIDXAw8+hl4XX6QRTARQpqDDXxrqyUF65zGrtmCAcZi2C9vkdlOfkcYgD4cZe7ecuN2gxfNxQMuOEMDkwy0xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038605; c=relaxed/simple;
	bh=Rwuuf41L1y7fvefgxp7gJG75Q2PUV4cB1pWHi7OAI5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFanrl3/IerPXvEYHc127ggU1+Du5CodLVKJTJk7/hlrsqIxM80MhhiaAjP1Jcl5zlfFo4mhJzU/f0c98i3jZjbGEs6yr8rfZDpNza/n97ahybm6IAlGRSCQYtEcypHMKACzCik6evP4cCDwDBqbkCGmf446h9DNSDAjSkpNhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfW3BZlw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfW3BZlw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69682bdf1d5so28902166d6.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712038603; x=1712643403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwuuf41L1y7fvefgxp7gJG75Q2PUV4cB1pWHi7OAI5c=;
        b=YfW3BZlwJJN3wu5ZFMJEh3/E5Z0lFWQnK/rMQslFHbwND4u+Rv6F/jcMjz2tjgHA9T
         AKvA4eDVThpBDSi98Uu7YV/bGVxOohWixCTcVu9iE0zsJQkLLhY0zJnhdLDDH4NqrwTX
         mQXirgQizA2yzZqTtItOMOL63CXqZoMCyC5pYK7qCFKDJ/9TAWLN+oXLkWWP41HjaMta
         IQGUAknEm69V4Y7/SKy+kFTCYa4koXXmvYcuCeRyw+XeW4cTSUReqjoK53xdDOMvNd0N
         +RX7XiXu05bL8eJX0igo6QQTQbBO7lUwr9E6Dn5OVvsudTt1oR/3AC7n6kWZRgJ+YQ64
         X7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712038603; x=1712643403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rwuuf41L1y7fvefgxp7gJG75Q2PUV4cB1pWHi7OAI5c=;
        b=X+qWAhpTJ3ViG21Y/XwX/aDuNcNALakCM6lQrLltazFtGHUouB43VielKF3wfdhGzu
         yX48u8hhH1M3QJZUw7qG7Bdp0wIuVu43q/TYnGsWYk0B3ZyycWymr8Aw2/tUllARUBho
         pRtT5/p0Yh350G4lsetMOpMGKFWs3Nhf7nJWZ5V2z/A2ke96E0pZH2BVDvVRjGufVwbc
         AEH9wNdedAwSKCXIPIVNALOEGxGQi0jrcqwc+q97Y1SzVH+OnH7LhY1MOdw9FHYjPW/l
         Ud+5O55OwrtFIuYw7SVOANXVIiWKmH3lqPHUVHXpo8tvox82hds3keNEIuVe8oVZHHha
         ushA==
X-Forwarded-Encrypted: i=1; AJvYcCX/X4xwFtOfaknaiqRnuMEt+gN1tVhNgfZvUpeUQm9BSRN5ixNtv9ALMS6rHPll95vsxgDIu02PTM22X9uzA+5TpW8o
X-Gm-Message-State: AOJu0YyigNu7NCjEyy3+HHpkYTtR7l+v3HzG3ZPJxZUe1j5zyE+yRdgt
	PhzKVjbyhmvDqAe+7T9b40KX9+ayzgCLeZIP2AtBIfO8CPlDrFqRLCEDrW8rR8IhJIHdwlt4pGj
	Lo1UQrp8dOyYTl1mjtyZI5xHeAts=
X-Google-Smtp-Source: AGHT+IH8euYD5nzCIHcqmFqURD3sZnKuzYNefucDE9RlsSqcSJAe+0z6Z7PVUe6E7akoBrZHRpdMt2+zP55l9b8kb+Q=
X-Received: by 2002:a0c:ea85:0:b0:698:6fbd:6c33 with SMTP id
 d5-20020a0cea85000000b006986fbd6c33mr10649999qvp.33.1712038603421; Mon, 01
 Apr 2024 23:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
 <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com>
 <ZgUdKU5uynGrJ33f@tanuki> <CAN7Jk_3Y+Ls2VjhQqzA3Ymy-WDv8nT+v5bzU2a1YGz+j89vPgw@mail.gmail.com>
In-Reply-To: <CAN7Jk_3Y+Ls2VjhQqzA3Ymy-WDv8nT+v5bzU2a1YGz+j89vPgw@mail.gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Tue, 2 Apr 2024 11:46:32 +0530
Message-ID: <CA+ARAtq85UYD0_XxPPu2QnWQ5gjpSMrXkTO48DOYkfu5h_1NhQ@mail.gmail.com>
Subject: Re: Fwd: [GSOC][Proposal] Move existing tests to a unit testing framework
To: Sanchit Jindal <sanchit1053@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sanchit,

On Mon, Apr 1, 2024 at 10:59=E2=80=AFPM Sanchit Jindal <sanchit1053@gmail.c=
om> wrote:
>
> Thank you for the review and sorry for the late reply.
> I have made the required changes in the document and uploaded the pdf
> to GSOC webpage
>

Thank you for submitting the proposal. I just noticed one
inconsistency which I wanted
to get a clarification on.

> ### Availability
>
> I am expecting to be free from my academic responsibilities by 4th
> May. I have no further commitments for the summer and will be able to
> provide about 40-50 hours of work per week. I will try porting at
> least one file per week, depending on the community feedback and the
> pace of the development process.
>

You have mentioned that you would contribute 40-50 hours per week. That mea=
ns
it would qualify as a "Large" size project according to Google's
definition [1]. It
seems you have mentioned the project size as "Medium" while submitting the =
same
in the GSoC website. Have you done this intentionally considering any plann=
ed or
foreseen unavailability? If so, kindly clarify the same in your
proposal. If not and you do
intend to contribute the said amount of time, make sure to adjust the
project time in the
GSoC portal soon.

[1]: https://developers.google.com/open-source/gsoc/faq#how_much_time_does_=
gsoc_participation_take

--
Sivaraam
