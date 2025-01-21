Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1B145A18
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447160; cv=none; b=opd8BDsw3KoyAILDjjpA3qyvkPMHQcqX7D09FVqTC2TfiYN9r1UfK5L+EK/LFR99MQgHGLcb82erK0tm3w8vkAXzGPwaAYR8IPDxIiWuiSXAextLMKNSGDFOXlrdavF2X6dIriG2zXtOEf6ojVelxqc3+jYBWvFPH+mevgnUF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447160; c=relaxed/simple;
	bh=Jfogl0pdXHp18jAlo2ZgDTUjaYsPzQtjzI6kWyaUL+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCzF9KHy+ME8bVap7MatVqxh0oYPgVEMwj9SAO1DkSmZPIlUjkeke3zmanL916y5VPew6E6pZu3jvjR10xJyztVNn+9MRYNHexfGdQeZ3bzlc7aglWEl4Ev3bUvijjq4EBJrWx2XGT9ovpuhrDfMR3aCIOdamju7IIBasebPj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9bDIHx6; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9bDIHx6"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5da12190e75so10880267a12.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737447157; x=1738051957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhYH7cR2t53SArpjuXt0hXEQ45+lS/AuNUmSLC9/pXo=;
        b=H9bDIHx6Tz8ao9XjZxNz5fIpyhFnb3MmrwgapTr6anv9etT+CZoBde8qDULzlqkUaC
         DFUwMgdaxuPKu4tGB7C9u6EAT0aFAIUI6Oeek3PssLrdLTkd4BtpCoGtS49ZqJOIYXLH
         qy+iPmYeluCO3KQV4AHu/OMGEmMOCsR7gxT8WWtAzfvMGWDYvfoSWGHAgyNEpfUvDNHj
         isOk05EEcsSpllPgEJuqNDO+Rh0OsAfTvfyYMpy3bxglMc3dc7uY06kCoDhC+IRqzp4J
         uy46dDtzyTerzPIxqT84GTREvCKRp+EQxH23segYAPjrSR+HUO7hFzYMawfY+OLybZne
         4kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737447157; x=1738051957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhYH7cR2t53SArpjuXt0hXEQ45+lS/AuNUmSLC9/pXo=;
        b=fmM8vwlBnl5MysuBjYqzPzDmA9u3lWSgqn6nDSBklrU0bR4Rgin8cQcpbgTn5qBCBV
         Ia06amyp+iLxEnGdshpRSOWOsozjdY9X2uJDD5EHjDPxPyd9etn7mlnpeQpC/k22Y6dw
         GQUeWoQVs5IDrbcwQFCKPdGDRz0mvaSw9oQ3NkVCmKrz1ERoIHWpNg5CIONOL6iTuc2D
         so15bTPS7lPTJO7sCXAA4ydHAIkne3iehwpo5zYiM8RG2hNVHo9+oZNEPN+nRosb1CEG
         ctEv1WTN5xXD3A28x8HAIAznmTcfcbz3JKh1TQ1mtqd0ekuHNHk8Ax/oZt3ZwNUDfLu+
         400w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8VvuzVhdM+Jy17AK4eRKuOuZAflUVnS36CfTHKTXax4XGPcAQ2R7JX0+DnJpCLryk1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYTm3ZphupIiHef3CXTTBdkmmyMKzVIzxc06VvasWPmUfB6ST
	w7aGGmMPYAo0MVblCZ+25MbTKON4gneIoNO4qRgzVBdyMhwu6TBSgPkZ5iSS+8F4ZFTEqb21zoH
	2wR8yER36Yg+to1MOc9lWLaZE3Ic=
X-Gm-Gg: ASbGncvr3HnbVs0pzrFhs7zQprbLkIPcM+g7I+FS56EEmaTLTVLCFzj5lQl8RNPojVa
	AXMtD0WQd1iNi+5Oyc4PVKLt/tv8/gd3EZEa4ivmqkl7YTxVnhEF3NQ==
X-Google-Smtp-Source: AGHT+IFPGBWgTTCQBL3C6imI7voxs1dLX2OtikeUg7UyYX+dBB3SNmUe/T9xvxHduTOaCZHK5Mmv1XF0aAiG24z++wE=
X-Received: by 2002:a50:9346:0:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5dbd9acb39dmr2363484a12.32.1737447157121; Tue, 21 Jan 2025
 00:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-2-usmanakinyemi202@gmail.com>
 <xmqqfrlhl2jv.fsf@gitster.g> <CAPSxiM-NPobarwmeRA+Z1L1DCLMEJy=1REobt3tyCKKFZOO_gw@mail.gmail.com>
In-Reply-To: <CAPSxiM-NPobarwmeRA+Z1L1DCLMEJy=1REobt3tyCKKFZOO_gw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 21 Jan 2025 09:12:24 +0100
X-Gm-Features: AbW1kvbVIERB0oYeObZu6PFI6iXobUaPo7romVZ__-7Nhwa36wqTFtMGNa3y8ic
Message-ID: <CAP8UFD3ccT=bAy=fsHaha=yNEDOuFpEsJ5tR7zQ1VJWtgNDh9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] version: refactor redact_non_printables()
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, johncai86@gmail.com, 
	Johannes.Schindelin@gmx.de, me@ttaylorr.com, phillip.wood@dunelm.org.uk, 
	sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 6:10=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Fri, Jan 17, 2025 at 11:56=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> > > +static void redact_non_printables(struct strbuf *buf)
> > > +{
> > > +     strbuf_trim(buf);
> > > +     for (size_t i =3D 0; i < buf->len; i++) {
> > > +             if (buf->buf[i] <=3D 32 || buf->buf[i] >=3D 127)
> >
> > <sane-ctype.h> defines isprint() we can use here.
> I think it would be better to add this in another commit so that one comm=
it
> does one thing. I will add it after this patch series got settled,
> what do you think ?

Alternatively it could be done in its own preparatory patch at the
beginning of this patch series.

<sane-ctype.h> has:

#define isprint(x) ((x) >=3D 0x20 && (x) <=3D 0x7e)

So if we wanted to use isprint() we would have to use something like:

    for (size_t i =3D 0; i < buf->len; i++) {
            if (!isprint(buf->buf[i]) || buf->buf[i] =3D=3D ' ')
                    buf->buf[i] =3D '.';
    }

It would have been nicer if we didn't need a special case for SP. So I
would say it's likely a matter of taste if the result is nicer than
the original.

> >
> > > +                     buf->buf[i] =3D '.';
> > > +     }
> > > +}
