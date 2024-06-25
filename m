Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43C16C696
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334449; cv=none; b=CnYcyjTzYG/miGkEHYP90PqN0QPG3hx/GgtiRtWqi0Sr38UnIJq9XNGZq2FM7uuuVLRBqQiUkZ+jSvEGwUDkwHQ9UqKvQnosutc/+9r3BacMrZvWjh6Fk/cM5PJvZ26R+RUb+cNVQTEN/DHKdzDQYx2ILcsQQO83bFVs6UeNHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334449; c=relaxed/simple;
	bh=7CUFBfV6+Rn4KZll7IkXW0jbuBrTgW561BkuvwtAOwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h15yWDdKY8U7tqZoeGU5k+ZG2a7JvUylZV10pt3BvmjnFnRqvFokEIxIY42/GyOMlwA4dHZw5X0KlPIBl1BpurTy7mGWyn+W2zamZ6M1Wvd3irHhOWTgoCXvG/9RVrNmyzdLbBVUQilaxXa/X3LdoCdtLwDbuOWXksT3eURrY7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5uWLUgN; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5uWLUgN"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64546605546so25215197b3.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719334447; x=1719939247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZdHlsjiEIMGudwibZFGk2XLvjmpwajzvGEuhYOwkhw=;
        b=Q5uWLUgN5j3KQbdkdicYvPcf2MQqp3uSPY2hSiq1YeW1AdNRJkBVi1eE67vUzlw++n
         V3omcnUe4YQlRZ8DnSbySWFsA4rjP2yLUX10GNZ4GIBD9IBn4X1dF7kzGQ1fHSI01Z8r
         nsoSAhrBSfQNcbpEMASY20Y9Udo7DnF7vbWfwO9iYtSCoDbthBAyDD7srqDfQZoPuI8l
         mOYuTsd44fPK5RcHiME4MPQjxPhLlxgR/m+VobSvpaDiwWxz3Br4rVPCZ8YcgbV7Xz71
         u72+8/oklHD1RbyttLR62jxtf8IRJIjiDXgCotkkRAWI6koM/SXHOhAB4kAynovBSDyi
         b2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334447; x=1719939247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZdHlsjiEIMGudwibZFGk2XLvjmpwajzvGEuhYOwkhw=;
        b=Zb03MGGxiJLy/uCGTnhz7NmWwiT8S0SSt31u8efmHiHhGDnoxD9Dh4mUYnZkqm2VTM
         0cp/MGcbENKlufnlTYUC7nepxfvYl6r7FXNhnl1SQ56klgjlYX0xZQbb7gx0XU1EvwvO
         EirIlG9MSRps5ULvaMWQcnIGwflcDyZKXhrR2qEAtkyihrun2HQUuy8zk9sOICy+7PCd
         GK1J9GGTZdjCiap1zlkU46U4iHfUWT7u0AfnxfGqJPhXawGZIrE8AdGVJDPB/rARvYjM
         45UNDpvnMVhTy4/uIipNdUyj2ZbC3yQcOXJz8mM7y8xwACSip0lTuHTWjkOBIzja90DH
         +Mpg==
X-Gm-Message-State: AOJu0Yww0E27oy/P72U78OrobjjUCrQRaafbzrj11tg2p+gMwSXf6kXv
	N8AQMWfbhVcYuKvDhSH4zl6+kLWdswS+Y93B15aNfvjUsRXRqXD83goiY3WSPjU6G35fk3DatGF
	srz2o73ixHyoa8mgUJrJ3vcyUntUDRA==
X-Google-Smtp-Source: AGHT+IEODGY760fvcF6UZn3Vicfne9Tr8pOn+7IR8VqzKY840D0kpm3jbZ5GsKJF0JeDscuZ2jkr2r2RWU1p48F6X2w=
X-Received: by 2002:a05:690c:6f08:b0:618:95a3:70b9 with SMTP id
 00721157ae682-643ac81d3b9mr89908317b3.36.1719334446794; Tue, 25 Jun 2024
 09:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF4erGWF+Lx=K09yFhd_abC2M5b5Ab0vM2uehkdVmridmsHqDg@mail.gmail.com>
 <20240625132001.GA535756@coredump.intra.peff.net>
In-Reply-To: <20240625132001.GA535756@coredump.intra.peff.net>
From: Ryan Vu <ryanvu87@gmail.com>
Date: Tue, 25 Jun 2024 09:53:55 -0700
Message-ID: <CAF4erGXkP3AR3dNvsqmo5FBLxOaGZhd9pHCHKsL8Q0BV5BiKJA@mail.gmail.com>
Subject: Re: gitconfig - interaction between credential.helper and includeIf
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you! I have the configurations working now.

On Tue, Jun 25, 2024 at 6:20=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 24, 2024 at 10:59:33PM -0700, Ryan Vu wrote:
>
> > I created the following files:
> >
> > ``` ~/workspace/.gitconfig-workspace
> > [credential]
> >     helper =3D store --file ~/workspace/.git-credentials-workspace
> > ```
> >
> > ``` ~/.gitconfig
> > [credential]
> >     helper =3D store
> > [includeIf "gitdir:~/workspace/"]
> >     path =3D ~/workspace/.gitconfig-workspace
> > ```
>
> credential.helper is a multi-valued config key that forms a list, and
> Git will try each one in sequence. So in your ~/workspace repositories,
> you've configured _two_ helpers: a vanilla "store" and one with the
> --file option.
>
> You can reset the list with an empty string. So putting:
>
>   [credential]
>   helper =3D
>   helper =3D store --file ~/workspace/.git-credentials-workspace
>
> in your .gitconfig-workspace would do what you want.
>
> -Peff
