Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238691311B5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433880; cv=none; b=q7AKBwms/G+QeHTG9/gvz0mSANDu5NBWCtT5VWJUQa4NycXhPiwD1qFbEeo3DXmFF1Avz5FIyjGjd1a8FPyh9oyzynH73URn49EP70Rndyl20g/1TEfPbBnv5zcbN1pTE7Muy0RJXHAyuy1keGgxrfOUIUKAshVM+vY5AfdFb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433880; c=relaxed/simple;
	bh=NuWZzNrnTo75mJuTmbflkE7a6Kh3VKnrK0Z2uC1RQPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/eRRqhVd5dvZQ2fbPKR0bSKdOSgc+sdvvptiR77012wThDWN2OAte+X29cnKhTXxRG5wQmpE3Hj9dGlTsEGI/7k96izj7u7IqBm8uJJ8OUFnkawgpx2tdXtofYRaxEuEnfTnjNzPLsnsipv0kgwhCgNX3a/UDYen7EJxOCU5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ae1059a62fso1211876d6.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 09:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433877; x=1718038677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV1EGvNE/AuacyySe3eyFsFWH05wO0PCWOWenF6b79E=;
        b=r4c50xPGuoBmVw0tm7sd/8ZS3xj3yBoVcAp4GpMfwfHfa6gMuayiPtj+qriC+Ww05n
         RIfKOpJqCKdC5UuYzd+JXd5gd1zgfzByhYjCm60qknZIMYETCtcE+nFzg3hvvyiNt2ZN
         Nop5KppeVXD391zdUQ1SF1POAAeJBk6OOAe6/7scaxTpI9sJRpJZWQWW6IbXm5HvpBxM
         srmxK+xGEVdjx1IBKAVW5MxIfv8jlyxUB3kTHzZuGJIMWnqKdzvlFFVrw0ywSKRiwOwW
         /T66gXyraz6rDs8lUhtJrNMJfeZ28YdclpdtX5aEcsCjNLAbIwSk8wrET75Qgnlz+c/1
         mTog==
X-Gm-Message-State: AOJu0Yzi80uT265VsNt0BcVqzcNntRvE8sVcQjWp+rJJBFo8WNFojfmD
	AUx4IKTE86OSj0CChKUnXV4qVt+X5mAY5NWNYqdRmCcLD6TRDrPLNCSJleJMQs/djqmclxyy3L7
	5Pcjt8jog2VTonYo+r3r7BhgGuD8=
X-Google-Smtp-Source: AGHT+IEjltsqGTaPrZH1VO7xKrQi/epbDqHsuiJTCg5lw1YqvTNFzJVpCTsH6CgIrVSjtqwUVK/1VJwrKr5E3r0V/W0=
X-Received: by 2002:a05:6214:43ca:b0:6ad:79d7:a1a4 with SMTP id
 6a1803df08f44-6aecd6fc463mr109489566d6.65.1717433876974; Mon, 03 Jun 2024
 09:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716983704.git.ps@pks.im> <cover.1717402403.git.ps@pks.im> <3d92528125ee419aefdac790dc1a4106be632c60.1717402403.git.ps@pks.im>
In-Reply-To: <3d92528125ee419aefdac790dc1a4106be632c60.1717402403.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Jun 2024 12:57:45 -0400
Message-ID: <CAPig+cTC83ZE2kGy=epeRFJ7a3jjRQXsvUYzB6jdOYfmy0yVOg@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] compat/win32: fix const-correctness with string constants
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Adjust various places in our Win32 compatibility layer where we are not
> assigning string constants to `const char *` variables.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/compat/basename.c b/compat/basename.c
> @@ -1,6 +1,8 @@
> +static char current_directory[] =3D ".";
> @@ -10,7 +12,13 @@ char *gitbasename (char *path)
>         if (!path || !*path)
> -               return ".";
> +               /*
> +                * basename(3P) is mis-specified because it returns a
> +                * non-constant pointer even though it is specified to re=
turn a
> +                * pointer to internal memory at times. The cast is a res=
ult of
> +                * that.
> +                */
> +               return (char *) "";

The change from returning "." to returning "" is unexplained by the
commit message. Did you mean to return the newly-introduced
`current_directory` instead?

> @@ -34,7 +42,13 @@ char *gitdirname(char *path)
>         if (!p)
> -               return ".";
> +               /*
> +                * dirname(3P) is mis-specified because it returns a
> +                * non-constant pointer even though it is specified to re=
turn a
> +                * pointer to internal memory at times. The cast is a res=
ult of
> +                * that.
> +                */
> +               return (char *) "";

Ditto.
