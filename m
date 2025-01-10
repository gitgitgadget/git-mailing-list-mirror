Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D4205E16
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531787; cv=none; b=NZIRIU3sZyZ5sU3pXFPhbNxV9uVWQKTIr4Jffy6x4SP9Jipr8eFR/TgHXzcsH5WjvYPP0PtTP8r1jV72ryADGJL+zUdmBuU2HSk1m2zsq/zEgM0QzX3mVSfFK/YwBybaJRmYBTtEz37AjYTSZamY+NOEyXFK2OlY9aPlHwTfZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531787; c=relaxed/simple;
	bh=UCLzXQl+RSbp0DGSxYErZFoXrY2jiCrqczney60v+Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHp8q7FO7HuXBH3DNjl4ddJSS2P5CDmLrMLNddrcuPCUyykgxSaCwe+AfRqsJXTO1D0GJ7RtOuKF+Z38uZDtDu6G4Ek9X6+evFIEzGqXvh0TlPEVk+WcDuG2fp8IN4gA8izD8Nr5z0WJG2QvH2qd2Y1Dd/Jp1DfkCGnBYk9Y5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7bLkSiR; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7bLkSiR"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4affd0fb6adso774720137.1
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736531785; x=1737136585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoaX7NutWKbv3/B7VZPDWGcsZ/NhrvOKPMyu9eOEIyw=;
        b=f7bLkSiR6/spFcsm5fffxIiaITlxNiDwzmzS9RA+IZoT/2EaP7IOYdM6jQ9LICjDxk
         mMcABkHy533QxhscFTXFzf4wvI57AkDJ/8tdcjlvdmt4t5L6BUX+gZDq0yOp5by4HbW7
         JSkCSmWAibO2OzCIk0kvlGk5S4NH7vQYqCke7HRb6pNI4KardVgR8nF+7/5C6UeyfY/l
         363EOUuZ0OKZ1T81epn1D/9bzvtpCsqS4kggxsSfnu6UslytEmMLuv0ffibujKeb2kBQ
         SmcOyHGy6cp8Xxhq5sWdJ5+kx2+3S4Z1pa06rPZ87/+0cpvG7IDLmRdyM8YB3TFtCAdO
         HrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531785; x=1737136585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoaX7NutWKbv3/B7VZPDWGcsZ/NhrvOKPMyu9eOEIyw=;
        b=qrwZS0+v2lIyc72lqs2cSxHoz5SPxGaVOZQH9E+1Gy4SVb0GyDzH0AMgJr//zco1wW
         u1EdxmZ0p8P/XM9kHbGJuFMZAzhBwNrCHvv2Exu8qTir7cd7xSEKrN45y0GHTxtDcD2M
         /iYTD/7EEJ7o2/IWVgHVEGoblvhpWsV8BaXx88QTW7VT53fs0CEvS9xCPQzedj3OKTc9
         1Q+lNi0nNify+dVUF/qrKw8YrRUfrvlW8DQluTsCuZCz5Hs7KfyYvc/2CpDuNrrLTw5l
         tqL+WT1wixwPPpvaod/gRgNFWnYTKBEF4ssDpjL6YWsLWOiEw/eH+wjgGN0ahLTCZE0i
         Pu4Q==
X-Gm-Message-State: AOJu0YyjVIpXBz2wy2eZW9eQ/HquF49/0EBrAn3jT22iI9JZFDWhSHrT
	qupdUcjXvhD7omQe4IFx/aeBgxVuZqoyM1n56VcYFMN4kJjgXuRPELHeKQ8Hf0pdRjPLpFlJRFg
	r+eDTlhkQd7vTLCKWaEIrUKzyNkE=
X-Gm-Gg: ASbGncuKAlRgrUryNYSfHsDoU56ldC+nzZukeRUMb08dDhyNpDwE6X7DRLnNQc+ygHx
	rcdzmigTTQTxv5YysM8na8CoxAgqh8qU7HUOapw==
X-Google-Smtp-Source: AGHT+IFZUz+OydlZfUIEbS+5iyopfzXO9PXeDFSYeczvbZnDOS5NqdD+tIVSAPtdp5WT9/ZTFTyHuwewyOPpSGP87qo=
X-Received: by 2002:a05:6102:3591:b0:4af:98c6:bc97 with SMTP id
 ada2fe7eead31-4b3d0e60973mr12793062137.19.1736531785265; Fri, 10 Jan 2025
 09:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250106103713.1452035-4-usmanakinyemi202@gmail.com> <xmqqfrlvzzcd.fsf@gitster.g>
 <CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>
 <xmqq1pxdnuxo.fsf@gitster.g> <CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>
 <xmqq5xmokn0z.fsf@gitster.g>
In-Reply-To: <xmqq5xmokn0z.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 10 Jan 2025 23:26:14 +0530
X-Gm-Features: AbW1kvZtiUsyQGtisT0U0ghhpGOXpDH0nHioCre-XcKZWZRTPtTjAmQZ4URiG0Y
Message-ID: <CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] connect: advertise OS version
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 9:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Instead of having .format that will allow user to have multiple
> > variation or different placeholder,
> > we can allow it to take only specific values for examples:
> > - "full" which would mean the same thing as  the result of `uname -srvm=
`,
> > - "default" or "short" which would mean the same thing as  the result
> > of `uname -s`,
> > - "medium"  which would mean the same thing as  the result of `uname -s=
r`.
> >
> > What is your thought about this ?
>
> I think two-level is good enough.  One level is "yes, please give
> the minimum that would not offend even the privacy-conscious folks
> (like 'Linux', 'macOS', 'Windows' etc.)" or "no, please do not show
> os-version at all".  The other is "Please use this exact string."
> We do not need anything more elaborate.
>
> The reasoning behind this conclusion goes like this.
>
> First of all, I mentioned "registry of canonical os-version strings"
> to help the users of the "Please use this string" so their server do
> not have to suffer from different names and spellings to identify
> the same class of clients.
>
> But the server operators that *want* such tighter control *and* are
> capable of enforcing their choice to their users are probably $CORP
> in-house operators.  They can tell their employees what string to
> use, or they may even do that in /etc/gitconfig on the machines they
> give to their users.  In other words, they do not need our help at
> all.
>
> At least that is my thought.  Others may have different opinions.
Hi Junio,

Thanks for this.

So instead of having a .format config, we should have a .string config
which just
takes a string and uses it as the value for the `os-version` capability ?

Thank you.
Usman.
>
> Thanks.
