Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A25660
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678597; cv=none; b=ivZuInfWBx/1mcV0Xlf5vczr1kTfnx7Is5y9r/qSiR8h9DhPkn1isClx2K7Zz/VPG1v68QPLz33OqgcBEYg8rEQjCZGUR4aUioTXXISlHU/YGbFBMDP15MAfjHRSCSgC5WU+PjYURdA33iMuXlnCITrNG6I3Y6ySYGCMApeuerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678597; c=relaxed/simple;
	bh=otHkhsUuK/zPzSFl617GyCAZYf8bClV/0o3Rq645Hx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmKGdpbgs45aN9YQ2ipP0gwQbPIieGwTBH3uCVqB8XmPjRyuy9YPkuoJZoe8OD3uWIbvEHw58cbqVWXvyOmg2iKmsSonDLSXQemMnCpbAvZSwp+Rf+etFFYbbCuUG5R4/PlaBuVwWc7B1QFhbncZm3gZcg38VigbOeYNX8aVIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxnNIXpP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxnNIXpP"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a72420e84feso184659766b.0
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719678594; x=1720283394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otHkhsUuK/zPzSFl617GyCAZYf8bClV/0o3Rq645Hx0=;
        b=IxnNIXpPijopF2kqP0P+p9fYzzYOW0huw3qIVWq1uLzn2YK5zhDU4Dj5nAdLQZSKdr
         pe3DHAhGTQThcMbEUzy3x8LLnpxeGsFARsR6z48r8HIwM0pjiGviaLet9QD2pgOgTtvz
         SnevpZLhtYb0B403KMGFLVtEzojxco64rcx+J3GpgAt4PWShu9IZFWTpd42BckVQDJz7
         K8qP3L5F+vZQrXcA8Dw6thhXu4DKR4YDfA2x7DFTy2zIi3YfI6/FHvBsT7okW7+zhdfb
         p8KDkX1ceTCAUih42om8jga+8mksHwzoEscNRxhly5Nw5i+xeVIpFv1TNq1W/dLTOFAb
         sBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719678594; x=1720283394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otHkhsUuK/zPzSFl617GyCAZYf8bClV/0o3Rq645Hx0=;
        b=ENeXhpmn1ssPlElRngMCBOfXV59pTS9QFmAv1gFdP0mFTosr3EsTv3wprvXwx+E2zj
         Q9SOFkh7HVMd8OYPf0wNKkPpQgo5+bL9czE6hNHyyUTi7T1gFlT6MGdWPcuIM8Eq9plD
         ta5gFYi3dwn2HBYUKMCpHYU/scQYjFo6rIwKx9CXpdpLjU9HRBuU5iNrYT3yfQ4s8NI7
         41QultyA3zRXz7eXb0UOlqCm4xGdAGTm6n+bzfURHbj1K7DaWt8WgAckVR04ryB/D34u
         ld9r8XUQi6eLWk47LHbsVYSdM5Ox0Qlq62EN9fud3sL5AmMINPv3Ig5S8vOSka0p2KJ6
         9IbA==
X-Gm-Message-State: AOJu0Yzs1UcJ4iyDNahe3gPzjs6AyaE6JkaeY6wbMqJuBB9EVOw/B2ZE
	dwS35rnIKWnp+W79pE34G9x3JFMdf9ce4yTnRJgVwrHo09Kb5QKxH1HBm1KdvhZGkTla8xFB6B3
	lOc6rs0aXmyTUy68MziHzISn+1As=
X-Google-Smtp-Source: AGHT+IE1nRW0Ot9f2tdJPRc/MDf5YU7Q9XhlBy9JfvSaO6HVQVnBlWQNscw5gv7XydCV8xWNXMk626cucBJy8nYr/Gw=
X-Received: by 2002:a17:906:c141:b0:a68:b73d:30d0 with SMTP id
 a640c23a62f3a-a751446804amr109096266b.6.1719678594027; Sat, 29 Jun 2024
 09:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8Sb4+_L7TrP8zZvvSqFu0MqbDanOhi6jfxfRLQKRimYzw@mail.gmail.com>
In-Reply-To: <CAOLTT8Sb4+_L7TrP8zZvvSqFu0MqbDanOhi6jfxfRLQKRimYzw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 29 Jun 2024 18:29:41 +0200
Message-ID: <CAP8UFD04cvb8k2ZkUYM20B5ym6e8q=KGL4PEDNF8_4x6G32SnQ@mail.gmail.com>
Subject: Re: [QUESTION]: How to get uploading git objects via a git command in
 a pre-receive-hook
To: ZheNing Hu <adlternative@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ZheNing,

On Sat, Jun 29, 2024 at 4:42=E2=80=AFPM ZheNing Hu <adlternative@gmail.com>=
 wrote:
>
> Hi,
>
> I want to check the uploaded Git LFS objects in the pre-receive hook
> of the Git server. Assuming that the Git repository during the upload
> process is A.git, my current approach is to create an empty repository
> B.git and then use
> GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"A.git/objects/tmp_objdir-incoming-**"
> followed by executing git -C B.git cat-file --batch-check
> --batch-all-objects to obtain the objects being uploaded, then filter
> out the LFS objects. This process is very time-consuming, taking
> roughly more than 10 seconds. I wonder if there's a simpler method?

I wonder if it's possible to use `git verify-pack --verbose` on the
received packfile.

Best,
Christian.
