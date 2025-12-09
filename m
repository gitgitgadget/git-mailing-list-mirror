Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1741991CB
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272191; cv=none; b=RHOXjc4En3wy+SuRY0fYPL68ofwu7+47iV4nku7EfaESyHHtKHAZXwwLUtzUFXjURQYgvfo3cQFLeHyIRWuTsVRfFvpGbfs6OMcAEW0L26JdLw1wyFapcY9oV2WzOPrZAUbb1jXMTsm5yfg1OkBQ1G9+UwmL9utD6twfXY9QrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272191; c=relaxed/simple;
	bh=3Th54i3594aoSvYVzrM9nqNlZYZyiZB/S66UH6CU0ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYJoO8uRdzaxvAXnnCn2+S5XOOlKp7/sJUXMzwPvV/bALkXHXIfUp5XEei7S5l2HWp1NMlpHoRyicpb12+DZ749qvA5k18d8Mom4YJEVJlhteC8Ra6NmQi5YPunOiV0RIRTQiGFF5UAfpuuOAfRdMr5J4fFVMbc88pPcEJ7Zi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbvxIpg3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbvxIpg3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso8361731b3a.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765272187; x=1765876987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Th54i3594aoSvYVzrM9nqNlZYZyiZB/S66UH6CU0ps=;
        b=GbvxIpg3c+wM6rgE3KWpveLv1ELxtNmInkQxPXspgS3akW5CuX6ZJTMa1UBvGLw5S6
         wzVgXnIAxOuqxGDyAdEcyy4WQ72/0job10JzkRa6KWw6bXpY8ebVzXkGs3MDKf1ROnDl
         5M0Okdjf9yAh3tNIKFjBmXlDI4KR1mw1ssb2I2cxqEWEtYFHVfqvFMQbUXvd23GaZoty
         YPs/nUfmKIp/ZlbhwPRfrGEpP1T+yZKXc6USmXbX3aPjK6HR4Xb8liWKFtYHfFfq+LcE
         qdRB/UzGaWgAwbhdQ+rJ/xlbe89pcBKQiGbVcb3eYoHWWugPl5WM1ZacHF3kLMsPloDi
         /OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765272187; x=1765876987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Th54i3594aoSvYVzrM9nqNlZYZyiZB/S66UH6CU0ps=;
        b=wkoPbiZMVCCHWn3Apyc3ZZ+TlmTjamo3MkMyWgd4x8O+SbZiy9mm63O9RbpdfD18Co
         EeCeuKhGdYkg8NljfeF0DUSkz15YwC9f6nlgYY17UmGqMMUw/+YVYV4diTAo7/cAGud2
         7nvu3vFTCX0Y2E6LXi7zTi6G6YmU7i1oP4ASHOBsSuHoed13LNONnTaL46ijqFatKv+K
         dtieZn1avnmXBrunKpO4cVRoNLLn3wbNjJof02zH0OBZc8ytkviIwEWX7ewla+xACGZl
         k3FhnWJoRo2UzeY9GUtOvVPbEpbaDGh38AbW790G02FAyaHYkJEoQfXDkeAwU+kgLFFA
         s/1g==
X-Gm-Message-State: AOJu0YxfVgPCFuQXrX+73MzU1Ah/r4CRHJFmW1nHt9gqck52wGUKeOwI
	QjKuVrLOoD112QgKGZy5gU6fb68VFnv/piDeeh2tdCXz1isB7gg32sZ7OCXK1wB1QlWU3SXc4f3
	haoGdbFXRMGkgj/4uWz43Oep6ArrfJDo=
X-Gm-Gg: ASbGncv7o+Z71WzFISaIn9Rp1uf+FIi2ikdNdlknSIeIymlJApxDE4h0ePMynRwGuWI
	ePcIXr3O2VFVN3zYCLyy8a7PncgDhLEcDRtNsG7IvCqSn2pAE5ZgJM+kO0m7v1SrkB1/GpCY/tI
	OCId28kgmb8d93A5ps5cLkFICoVIn2NAFx0/l3wHWlhYwcsT0Qgg9mcca4aDJ2OM72glOdxLSja
	wl3s9zZR+BBsfcAotHmELoUBB4tEXrorV1uQowIsHBMf/idfTcSWVDq/WzsMFdq5VgoJkO0
X-Google-Smtp-Source: AGHT+IEAY0+dXKhSeqooBKKnekggMKCskt24EC/PyWTGNQFAwWVQLw+v0/mrPOQRroKEj8X2ga7/JqwEk/OUf8FxDr4=
X-Received: by 2002:a05:7022:a82:b0:11d:f462:78ac with SMTP id
 a92af1059eb24-11e032949c3mr6840438c88.28.1765272186911; Tue, 09 Dec 2025
 01:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE7as+ZROO1GiEhXYga5Nqmrs5Xr=k9zsAiP2y0xzuny1ws+UQ@mail.gmail.com>
 <20251208201132.40186-1-belkid98@gmail.com> <CAE7as+Zka6J+du+V5zsHzc4eiH+Mzx=dQUnjuJz_Mhnk2RzOPA@mail.gmail.com>
In-Reply-To: <CAE7as+Zka6J+du+V5zsHzc4eiH+Mzx=dQUnjuJz_Mhnk2RzOPA@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 9 Dec 2025 10:23:08 +0100
X-Gm-Features: AQt7F2q2NB9MumXfzM6205x4FdpFGFwMqx2oogBqzQVru-3aN6NEFDrR7EquRwY
Message-ID: <CAD=f0L8JMUxKBDFj+=v+HvEQ-TFM2ZxkZbkGSfhx4=3-PD=nCg@mail.gmail.com>
Subject: Re: Outreachy intern: Request for the completion of this series
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, shejialuo@gmail.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Dec 2025 at 01:30, Ayush Chandekar <ayu.chandekar@gmail.com> wrot=
e:
>
>
>
> On Tue, Dec 9, 2025 at 1:41=E2=80=AFAM Olamide Caleb Bello <belkid98@gmai=
l.com> wrote:
> >
> >
> > Hello Ayush,
> > My name is Bello and I am an intern for the ongoing round of the Outrea=
chy
> > program for the project "Refactor in order to reduce Git's global state=
".
> >
> > I would like to commend and appreciate you on your previous works done =
with
> > regards to the project. They provided enough guide for me in my bid to =
continue
> > where you stopped.
> > I referenced this patch in my proposal as a part of the
> > patches I would like to complete to kick start my internship.
> > Please let me know if you will be okay with me completing this patch an=
d
> > submitting for review.
> >
> > Thanks
> > Bello.
>
> Hey Bello,
>
> Thanks a lot for reaching out, and congratulations on your Outreachy inte=
rnship!
>
> You are absolutely welcome to complete the patch. I'm glad my previous wo=
rk was helpful, and I wish you all the best!
>
> Ayush:)

Thank you

Bello.
