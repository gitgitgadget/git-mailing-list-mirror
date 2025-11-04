Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBF256C61
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269481; cv=none; b=RIFmvZOrHC/7r7PbIKyReAsz39S/uwk0yzVj5SBP+n94oZxcGLAeMrSvdqj5OyS44ACf/R1m0mVLcZxJb5ZGBQsYD44a/yo23iyHSD8GY9yE8g5bsnWtyL2cqL4vE1rXqddhO0rgYQbM4IYlnutD5bQ+etBCQyyAYT+IVteVuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269481; c=relaxed/simple;
	bh=cg5ZU0NAML+qrTESc0fQ2ujP6hM0fnt/msy/9sxOZFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOIPYS9D0o3G3w5zvufYMhi8Vwqf9NMZQsAwghRHG/3DN5iBE2tj+yIQqnSOBPaiU3SPba//znNx6S+vie/a4rOG+dAoPob1Y67PT+xuBdH8iJansXWgGFx+OlGoJqK27i46SW9YBdfzJMvo/s/qFauOeIBtaJvxuBzogurRj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdvPdmDH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdvPdmDH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78665bc1aecso27262067b3.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762269478; x=1762874278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1+6qLqZUhx72siObnHrP2xCv5ujVYYCTdJ/mcRRCco=;
        b=UdvPdmDHfaiZokTynxZpHn7hajxzpM6Cb0utzxMh4hHd1cH3VY5VgpfFf+wA/HyH1+
         20+LEuDUTDjZeYcTNqrju629DGjoiJcjjSirEfoTiGf0h96AVCCr6hpuz2K6838X/NGZ
         m5e9coHd5RSeywLTkMHgF2Rty1FtGC3jjM37TbKj1/WNjjUR5YOruZC9nr9t7fQU6c0A
         yzbGE8bG/fTGIry2dUN1eyRQrHXIku6r8wYreWa3qHjGeFlHBC7XVzJ+5np4IRpd3eT4
         E1MsE2fjGtij68v2H6AOBaybYy9kAQWJNnN3Yv8+4vKDas1xVkh28K9ig1hq6g3LkMny
         VUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762269478; x=1762874278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1+6qLqZUhx72siObnHrP2xCv5ujVYYCTdJ/mcRRCco=;
        b=bNqKDKRQZTrOYFE6CIyWb/WG+IHXNufyV9Ap3EO3mkEltCFsT9yaBa6xSmJVh7n0up
         14zdIXHFlQz78KdvoCnIirB+kxTUNJjTKPqHGkfP5bpGQV456R1Hk6t2kXNvLPWQFr6y
         bCz7Q7mqPN4GMPRMaavh+EoVlD2AvZa+/nkw/WY/gkYH+/gxspUMK7jo7KvscB4N75eD
         OsRasd48ccXfniKUR2ysWXZjztaCilmtYxkMAW8GmIxWfp7x1GLIlRBzW6QBuxfZrqC0
         8chFlEZWAVScm2ut7VvCDjMnQ7r3jZ32hZDS8EnvZ9CNGj1EgtVE+RaabqHHOOvc1TUF
         p+VQ==
X-Gm-Message-State: AOJu0Yw13MToMBYEkIlDhpWax5TViPxuo02QvvO0TNfedFXpi+CquhGq
	reREK/OMGxo8PExc5kNiQ1LhZ4Si2OXLkviBO534vcSZ9LPjvNcMRPOY+9cgD9bLN0MD3V9m5LK
	N6yOFDT9Tjfd+Qxg/plOPjsWnRaxFj5s=
X-Gm-Gg: ASbGncuzp9s1ec6UFtLCnfJPCh4cBYIpxnj12sqM8g2BYe9YGP+nRPS2IEWI8MDpeWx
	T6GBATKJ+9k8VTIwVnxio/wa8gYY/AgtKytEy5AyLAm2zmSEjDeGeoXFYS+WWct+ayx4X5lMRbY
	abx7l7PBH47in2+rKuY3f1H4yPxG+tlSRDsoGaRsKYFOcjKSBFMlZwTENM18rwfjQkW68vjrV15
	o+RUM5AGE0b2xGQ5xdz/ZHALqqjqalDxw7ew89JaOBCmPkQZdWYnnw2RS1E5CQp7A==
X-Google-Smtp-Source: AGHT+IHGN2mZV18fyukRzY+6paDOmoLrCUUKmrOL0GonE+XcERpD+dVIP+LubhLMtQLPmwLbnDJR5nDwrGA39nod/Qg=
X-Received: by 2002:a05:690c:10:b0:783:cfa0:3b69 with SMTP id
 00721157ae682-786483d470cmr149637227b3.4.1762269478560; Tue, 04 Nov 2025
 07:17:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104100653.2152-1-qjessa662@gmail.com> <xmqqqzudrhkv.fsf@gitster.g>
In-Reply-To: <xmqqqzudrhkv.fsf@gitster.g>
From: Queen Ediri Jessa <qjessa662@gmail.com>
Date: Tue, 4 Nov 2025 16:17:47 +0100
X-Gm-Features: AWmQ_bnjf8O-zoXe8_07nJX9_MrdW5v0748nrXYa904ZcwBaXno1px9DFfSLxB4
Message-ID: <CA+JX8FoXiDF7RtNM7Rx4idEZsQn=tsB2jUsWeCVk8o_OUR5bZA@mail.gmail.com>
Subject: Re: [PATCH v2] doc: clarify server behavior for invalid 'want' lines
 in HTTP protocol
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usman.akinyemi@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, Junio.
I=E2=80=99ll fix the duplicate =E2=80=9CFrom=E2=80=9D line and move the =E2=
=80=9CChanges since=E2=80=9D
section below the --- line as suggested.
I=E2=80=99ll resend this as v3 after testing locally.

On Tue, Nov 4, 2025 at 3:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Queen Ediri Jessa <qjessa662@gmail.com> writes:
>
> > From: QueenJcloud <qjessa662@gmail.com>
> >
> >
> > From: Queen Ediri Jessa <qjessa662@gmail.com>
> >
> >
> > Update the documentation to clearly describe how the server responds wh=
en a
> > client sends an invalid or malformed `want` line during the HTTP protoc=
ol
> > exchange. This improves understanding of Git=E2=80=99s behavior when ha=
ndling
> > incorrect object requests and helps developers detect and handle such
> > protocol issues accurately.
> >
> > Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
> >
> > Changes since v1:
> > - Rephrased the explanation to be more concise and aligned with reviewe=
r
> >   feedback.
> > - Clarified that the server includes the offending object name in its e=
rror
> >   message.
> > - Adjusted tone to describe the expected behavior rather than prescribi=
ng
> >   implementation-specific messages.
> > - Improved readability and technical consistency of the section.
> > ---
> >  Documentation/gitprotocol-http.adoc | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>
> I'll locally fix up before queuing this time, but
>
>  * You now have one in-body header to force "From: QueenJcloud",
>    after which the blank line declares everything below is the body
>    and no in-body header remains, and then you have another line
>    "From: Queen Ediri Jessa" that is not an in-body header.  Perhaps
>    you should send your e-mail only to yourself without sending to
>    the list as practice to prevent them from appearing again?  You
>    only want the second one, IIUC.
>
>  * Describing "Changes since..." is a very good idea, but that
>    should be done _after_ the three-dash line, not beffore.
>
> Thanks.
>
> > diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitpro=
tocol-http.adoc
> > index d024010414..f3f48d3f35 100644
> > --- a/Documentation/gitprotocol-http.adoc
> > +++ b/Documentation/gitprotocol-http.adoc
> > @@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
> >  TODO: Define error if no "want" lines are requested.
> >
> >  If any "want" object is not reachable, send an error:
> > -TODO: Define error if an invalid "want" is requested.
> > +When a Git server receives an invalid or malformed `want` line, it
> > +responds with an error message that includes the offending object name=
.
> > +This clarifies the expected behavior for Git implementations and helps
> > +clients detect protocol issues accurately during fetch operations.
> >
> >  Create an empty list, `s_common`.
