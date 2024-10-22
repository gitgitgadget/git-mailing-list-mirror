Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D91CDA2D
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634828; cv=none; b=E0kGbOdCvGq4fTRlS08KK3DrdGwL7lsbhffQAeWAyBfF6WhJ2OcXYeyevp3SKWEr853lqf4TcC9ftdrjxM+Z7kvym+vEQNIjWYrq/H6JUC/TfZ+HJFeaUwl1XAyRlq8ZfVQtZCvdbYReMf3OzxCeyej4Yz+AL51viNKec7zjbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634828; c=relaxed/simple;
	bh=nwcpla7i8KGaYx/MyeHjmv2Sv4t/bwWS+wRy6T/XYSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6xrlRm81zhcd/Cd4m2lgyd5zlp1VB3x3gGbeP+y3PZpmFK6YZSH0nPx+djRV2K6hArqLc9zZ1t8EZYPQTuP1BGJHYquKwxOoied0gLzuQH5gy1j15jkEgmt6DzrD3z8JWCB/v1s4jz97YKiTrUaimp54Y62opKkcELRLXkD+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeYgJd9W; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeYgJd9W"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d4213c5f6so1852568e0c.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634825; x=1730239625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeo9oLWNN2boHL3ie/35uMGNlZ6vD+jxwB2xuF/ZxsI=;
        b=UeYgJd9Wxwbbyrv5cLHqicwidfWrqG2JKdFL7/RQv416TsD0hhHh7CQjqSKZvcm9ip
         nqDdJxbb10QT5gde8iWNjsR3+09BNsOHaYh5w/9II8Yg28Cu59baMvgz33hiwUYHEOp6
         DO9svQ++PsDlvdiuuek2e1miTI/rQzkJX05YA9LybUN+6KvfOHtX/zFRqnpApzhRT0Ip
         eFhSA/31qh+FyD//Maj1G2tI/+koL95KYEvFA8/M3FZfBhwbzfMqnPE3Pv8dVjFvJKXi
         GBbYgijY5kdQVIc2CGFnKF2gmjcH9NFylGo14BXJPc60HbwpcbhBLL0TJnvOSZSlZA5x
         c4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634825; x=1730239625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeo9oLWNN2boHL3ie/35uMGNlZ6vD+jxwB2xuF/ZxsI=;
        b=CAMsBqhuOBCFdPxa6FLx25Ey8m3BZ4sgoYEm5U6JAhXRKqlw3OR6PQdCEjqjVe0m3j
         SVCHIS5qBDfPsFHcaLgO687rQ1296/HML1tRm/TlrTunMh7FHot0BUoFIglLNDo4/ojO
         sCkLBgaYXShvMqP9UovspL1Q6aYIjuGpnf3Oi6R8/R/lyZQIOuxC48m2oJSY7y1OJXxQ
         17E1g3p/CfkK2EUw2/ENW5+50myf6yE2NougXrYQfMzDoOinUviZBq4oyzzUhwYTldYu
         yr9DRmr0wKJySJfi+v/C8UDvDHlylQuCZCsK6nu/3dmz3KvU3e3JuWnBG6YleIwvMQss
         41aw==
X-Forwarded-Encrypted: i=1; AJvYcCXjpBfv23X+FTg57lDKMQf9QoxL4IY2+ISWQ+UMDF1nBP8OLn54im5utBqYP9RvC8qSDLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjTnu0dm4IB2h3wv2uf0IxC9XISFJd1qj29jp1piAFA/O0PNk
	XE4cmkuehHKPYrcTCl99evhYIJcvSlf3DlFr+ZBK/50kqgV1dmSQOetzuCBxo0PchL5CXb6aFf2
	ARxNRECVQ4YfOMw7gWVRAi6HBpr8=
X-Google-Smtp-Source: AGHT+IFhfbuaCbI6+0R148iddcW9roaiHfQ7ZYbn3tFaJJQSGUeNqWPGmlxNbBSbF/r50HLSB/t1ZpJm2ug5CBTj3WE=
X-Received: by 2002:a05:6122:16a8:b0:50a:49d1:f1f with SMTP id
 71dfb90a1353d-50fd034ee98mr764121e0c.13.1729634825518; Tue, 22 Oct 2024
 15:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com> <e292b82d6a1d46990477a043901fa9c56bc00023.1729574624.git.gitgitgadget@gmail.com>
 <ZxfRIIcd2H4S3i3+@nand.local>
In-Reply-To: <ZxfRIIcd2H4S3i3+@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 22:06:54 +0000
Message-ID: <CAPSxiM_YbO_AamPb7kmMEK8icSQ2YqqupFoSLHeCMNXsjGtoEQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:21=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Oct 22, 2024 at 05:23:41AM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > diff --git a/daemon.c b/daemon.c
> > index cb946e3c95f..09a31d2344d 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1308,17 +1308,20 @@ int cmd_main(int argc, const char **argv)
> >                       continue;
> >               }
> >               if (skip_prefix(arg, "--timeout=3D", &v)) {
> > -                     timeout =3D atoi(v);
> > +                     if (strtoul_ui(v, 10, &timeout))
> > +                             die("invalid timeout '%s', expecting a no=
n-negative integer", v);
>
> The conversion you made to both (a) use warning() and (b) mark the
> string for translation in the second patch were good, but I would have
> expected to see them here as well.
>
> Perhaps leaving this one as a die() makes sense, because we are taking
> direct input from the user, so invoking 'git daemon' with bogus options
> should result in us dying. But these strings should be marked as
> translate-able regardless.
As you said, since the git daemon takes direct input from the user,
compared to the other which takes input from .gitattributes leaving as
die is okay here. I have marked it as translate-able in my fourth
patch. Thank you very much for the review.
Usman Akinyemi.
>
> Thanks,
> Taylor
