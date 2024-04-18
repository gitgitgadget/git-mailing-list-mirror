Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703315F418
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451974; cv=none; b=fm95pLYFFZ7BgunKOazdN8TQWw6gaybtQceVoDq/LyF0KZD2A2zpS29UyxTJLyhEcdF10fnpADv/Yt+OhRcGd/EAAbCi4CLvai3mtDrK14hk5P0AQvoBZjwySY6B3IwQTGwpTsq2D0OHijK0pzD5XcFPjygSmW1KNGUShUbUNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451974; c=relaxed/simple;
	bh=zmqUjNITODNHSkB4MVqr+mu6Paob5y85yh4ARASHNDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taVeANzjNFr6Ndk0oUS8gqlJdN3KbHqgn5drhYJd2e/6JKuf3AYiYfdmcdGmi4qWT8av0yfATYPPN+skdpJvxa1/aBf0kF8PAQ2w0JtlrcrbcHtg0CMeh+ps5UNA2B28YcznTiEXxm601ejtzMhcrWuBAOzusnh9KX6RUBN403U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvDyQkC+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvDyQkC+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so979818a12.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713451971; x=1714056771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UuBhRRPkewKhoSMOcPnvJMfxISAEOFz5BlubT4EqIk=;
        b=VvDyQkC+HXBiaNEprHmsdja5IiNAxCmmKh6h3scwR8HL+o/SSRWs2MWt0NZR3KfJbe
         5TE7VKH/rLlwDoi1tKxVO2ApiYKwF4EhVB4eHWyT+bnAssPAtqd/NAF2nDGi4/RnW+WY
         otbH9os0qCFyeFkbxM6FMNFMVuqIyhKqRoKbOkLfPSvYYmncYD6hXXRbDvRuxjO/sjwv
         1eWHU7RI6ZVayEdYSpZ7S1zJwLvYDvicWHyCX4T5nckKW+nlSGeUgokhbZQZWv8BNIMX
         +Sssh/Hqf/OPPJgWY4rzywOFOB6EpHf4BABd+LcXr3O0W+P1dXZOB/azndaaI3lxwhKr
         4krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451971; x=1714056771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UuBhRRPkewKhoSMOcPnvJMfxISAEOFz5BlubT4EqIk=;
        b=ZwBikR0WwoW/gyrTlvEcLiScK6/1b0NNa4uFkeIAyMP2MdmtX4/2cvNYO9Kw0EMkUP
         PbZtDOqRxviHMGJn6Dl5EfxIM505oH5J+Ak41AdOl2CIV8SPpjOCirgGoesZU5tN8+gI
         UfJcaREG6BWR3nmCwyk9onnY7TwUsS5ZG4RT5fCsVr+R7mrGc1lYd5Q6zEoVyBNqEnOs
         a6DD1GdZlXzkg/j5XI0wx5U3LnGCktaSQDl68xUCcD/6IvPF0a5ZgKyclCn4UQqnt00Q
         /KxSYAodJId8//iSPfcqJ/5GxwfhUKg87wndY4sOqaPYO96E1lgu65twuB2SrY7Tc7Md
         wvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXZA+rYA7O342+YjT6bc9+/rK9JbJiwovhRshlx9zobrVlx6jpcIqjoTK9fXhg8U3B8x+5WqVBkKFjvjslujXyiJ68J
X-Gm-Message-State: AOJu0YzaM4tC9bgZ6bTxRM/Ypz2goluNp72Jm4tDVj+t4EG+YOvOgigs
	UBlTuA5ivI94PzmT6CEJPJOBMzT75vw2aejjVJUfneK/CaG+/gr6LTcV6ymfEvrm4wLBZTAtD+v
	YFBgRLG4Jhvxq2LO6vXvYVE1PrGBECHvt
X-Google-Smtp-Source: AGHT+IHJMCElR0OGFeBhhw13YR4QyOz5BcGDwQ22/WH5BDrMOZGTevjDLNpyGAPiPIT7qu8y1vWQqCJL2vYoBzqahpc=
X-Received: by 2002:a17:906:694b:b0:a52:54d5:7915 with SMTP id
 c11-20020a170906694b00b00a5254d57915mr2147975ejs.74.1713451971024; Thu, 18
 Apr 2024 07:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-4-knayak@gitlab.com>
In-Reply-To: <20240412095908.1134387-4-knayak@gitlab.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 18 Apr 2024 16:52:39 +0200
Message-ID: <CAP8UFD1Fwq4exKKz3kyJiwcgtOe4TjQ938C=sAbdWOTsw6241A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] update-ref: add support for symref-delete
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Similar to the previous commit, add 'symref-delete' to allow deletions
> of symbolic refs in a transaction via the 'git-update-ref' command. The
> 'symref-delete' command can when given with an <old-ref>, deletes the
> provided <ref> only when it points to <old-ref>.

I have a similar question as with the previous patch about what
happens if <old-ref> looks like an oid and <ref> is a regular ref
pointing to it.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-=
ref.txt
> index 749aaa7892..ef22a1a2f4 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands =
of the form:
>         create SP <ref> SP <new-oid> LF
>         delete SP <ref> [SP <old-oid>] LF
>         verify SP <ref> [SP <old-oid>] LF
> +       symref-delete SP <ref> [SP <old-ref>] LF
>         symref-verify SP <ref> [SP <old-ref>] LF
>         option SP <opt> LF
>         start LF
> @@ -87,6 +88,7 @@ quoting:
>         create SP <ref> NUL <new-oid> NUL
>         delete SP <ref> NUL [<old-oid>] NUL
>         verify SP <ref> NUL [<old-oid>] NUL
> +       symref-delete SP <ref> [NUL <old-ref>] NUL
>         symref-verify SP <ref> [NUL <old-ref>] NUL
>         option SP <opt> NUL
>         start NUL

Also I wonder if there is a test where <old-ref> is an empty string, so whe=
re:

    symref-delete SP <ref> SP LF

or:

    symref-delete SP <ref> NUL NUL

are used?
