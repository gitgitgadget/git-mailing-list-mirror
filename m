Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFA214A61
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292806; cv=none; b=XDY8lcm7xFC6R2x/9418dlL9xktI/8hqHeUPOU2jl/nufu00HWi0N0TSIr+Aptlb+A/maw2gt2YaoInsGcATF8L4/6VGqo/f+EFEP+1v0v9+SM2DsziYsWql3lnKylpU7dX1YhdBPxv+3I5q1IjNM5FmqzO5sCIS0h05t6RZ8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292806; c=relaxed/simple;
	bh=TtXECie+va52STydZek3axnJp3CFTup28JeBpPpu/2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSHMN886i9v74BfOW3ugd+gBu10LkSbUg4MAlIJ8mYJyCi8VhIi+HDU5KD4foqILZmthvLCd+1L11M6rNAg9JZ2/esBH216v5f4LRmZRa0FpTtnwBAQRZXAJ8pqBvltdY1rupDjaJeli8pJm9Y3NaoalT3uwG8vtGDKq/bnl5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pev6+GNj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pev6+GNj"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf4d756135so188355266b.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741292803; x=1741897603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtXECie+va52STydZek3axnJp3CFTup28JeBpPpu/2M=;
        b=Pev6+GNjdp58Yxx226duqigVw2sDN/4DYeWVWJPeqXr6XsxubYUrZw/gj0u8S3yfG6
         SyqpREtAsjhlAQtO2vSXuGQOtW1HmOmgYSQJ7ByyBKS6XxXRpr7zdnfqNXhXT0JEV4CA
         w5oSt4yi1sKqXdI5vlE2lPBhIChcy/KxNt6WMTtSigfya+Q9XPxnLeyPmMho6zejlwNt
         9ccD0Vc4saX1u+s0Ju5yrDz0bq4JVwk/855+qZczaARn65ATOWhiAxPgkfgoQC4AkkU0
         Yw9fY00TbWBfUHnUz3kBRSQDFqnt0Wn/x46EoltyfUeUZ/VwRlJv7Yp+v+MWcdZgCbsz
         78uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292803; x=1741897603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtXECie+va52STydZek3axnJp3CFTup28JeBpPpu/2M=;
        b=jiReBork8JYhhz1GlXxFMIW9aCmQmySyy9fvAWmX7WPyZMizK27ZWXNM81pIB45gBp
         4+tneKuLVVTcIc99tnuZKHjlmmespectM3hbX7PQBh9Pfi2uXobpQ8xXPEHU87Nfhnsl
         Wve3ugu//J1qbtb5mWx1dbc5kFsEwSkihvEDYmwrwVX8t2eYq9S5257UDBS6iDe7nrnH
         AmMe2mTglW3a+EJIwzqLIaTbggAp3yHfCZd4p5QV1D9Ik//7cdu16NYWAf3AzFE4WC5d
         DDAlCt+8QHzor5tTDjW+Xo5cdzUTyDB/HHxyrUGGRnf1vvdxMrX2l7VkITVFVKbLs13o
         PT8g==
X-Forwarded-Encrypted: i=1; AJvYcCWk8/YlvZv5I47HQjwamrH73wsDCJ4OPAypl80xrUVLaicq0zwh/Y5Evl4453tx8tVTKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqfeDx3LH8v7b9NkVeTxqVP83qchmuqiqAxHTfAAWu/DAzyKn
	iPuE22A0OtE43hJGEEgzdawMLoeRtnPh5rUt6Z/fHTmSDIO4ys2nyG+Lk0wkLgpQM9IQSZf9DFM
	OK9jisBATbwDoY6GtL4bwbjgN4BM=
X-Gm-Gg: ASbGnctyjsYFEdVbSZqbMwKwWZTio9lSfHnmJsY2O+BWF8VCXGeLB/Sf1uMNnubt4IW
	Ql8L2UydITpLg2farQn/tcXoUunKsU1PNPwTJrj0hIwtQL4H42UAv4WaZxWniJhq1P49vrc5KGI
	zQfGw45/Z6CGk4CyZhXoSUaDRYQ+JCuw2m4wNFu+YjEUHfkGrp1K5ADvvc
X-Google-Smtp-Source: AGHT+IGXCpGf06AXbOFEtS0SqvgkeofN7R2ueeBBeJSV/qtSr7SdXOm+b+HMjsZLizdT1w5ayzVCwu55O1XKMSMrjiw=
X-Received: by 2002:a17:907:7d8b:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-ac252aae2c7mr53096266b.27.1741292802870; Thu, 06 Mar 2025
 12:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com> <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com> <42dfc06e-8eb1-46da-9971-9d102f1390ad@mandelberg.org>
 <Z8YGY1QMaIsQTXoS@teonanacatl.net>
In-Reply-To: <Z8YGY1QMaIsQTXoS@teonanacatl.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Mar 2025 15:26:30 -0500
X-Gm-Features: AQ5f1Jr_iGXwTtzvvUfEcgKaZjneuRHxbIUaC_KSmMplBf90GrYC9U1FMACQtBk
Message-ID: <CALnO6CBjigppCYBTd049osHrcA=snaGrYk4YW0m+tzHqYAaikg@mail.gmail.com>
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: Todd Zullinger <tmz@pobox.com>
Cc: David Mandelberg <david@mandelberg.org>, phillip.wood@dunelm.org.uk, 
	David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:43=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrote=
:
>
> David Mandelberg wrote:
> > I think that would work. I was hoping to avoid sed, and I was thinking =
about
> > using shell's ${parameter#word} to strip and test for matching prefixes=
. But
> > I can't think of a way to do that with GIT_COMPLETION_IGNORE_CASE. Mode=
rn
> > bash has ${parameter@L} to lowercase a string, but I don't think the ve=
rsion
> > of bash on macos has that. With sed it would just be a matter of adding=
 the
> > i flag if needed.
>
> I haven't followed this discussion closely, but you can
> also use ${parameter,,} to do parameter case modification.
>
> Sadly, it looks like those were added in bash-4.0, so Apple
> will have kept their users from benefiting from that to
> avoid GPLv3 code. :/
>
> I don't have an ancient bash-3.x like MacOS to test, but
> maybe they've backported some features?

I can confirm Apple's /bin/bash doesn't have ${x,,}

>
> Though if you do end up using this, ${parameter,,} will work
> in a much wider range of bash version that ${parameter@L}
> which covers various releases in the OS's we aim to target
> (e.g. RHEL 8.x, which has bash-4.4).
>
> --
> Todd
>


--=20
D. Ben Knoble
