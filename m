Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7B2DEA67
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989643; cv=none; b=Uhbmhn0VSOdctBC7p7xoeFR+pf3N0hmeqJp2icYxSwYyCQ65kJJtvq5edotlZE+bzN9L/XNl3XU4xR95WoM392h3UWWWBosVlrSdGn5cNi1cSYhkgGUVwq5u0dom9Um1IdPTTH+tUn8tgU8TBE+ZJTgVXwrNZmPUKjP3W5rlpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989643; c=relaxed/simple;
	bh=B8TWHZb3xq4AP7ud+InyEAZoL6tm8a+qXsMD6UD0z1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDflqqBHSZRWtTMqyruEYRP29dZnlb6GWj3wihGuw7PQgJAYFnrn9d4RG3mroqzt2KoGEwguvp4oPF3utV21+rlLFFK3tmYYdJw55oSzCmyglGG0+bdFmmmmohsUufDCWxBOgqW3B9RcXi4ZdKztBYUqeV/fKOnSQIuaaioDLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxd1dHx3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxd1dHx3"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso5300549a12.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751989641; x=1752594441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=314z6MlglbukNdol8XnNTyUm4Bk/au2vty8Ed9bfUz0=;
        b=Qxd1dHx3cHk51LBICQCUojCUFOLZ3CnkC42JGuF+aaHVK+/ZleuQgAX/oZKf9m99Qp
         e/iBZ4T2+rXHk70Vgfj/dnZYZlq/UOsiYqxyo+ESLT9uB/V65SPb22opOPqwbliO4aog
         SYgyVQUhjIxNiUk4fxQ1sSK8ic7QvegNxBgTZbcrkjVZhRkfAMlUxBEPhP2i5dp/ULB4
         Lc6yr4xy96Z5kqMdD1dO2PcQ15REagmBFTRgH8xwX42K8tYHCI6t+TKq1BgvBPCLPt+x
         hRdVpIEPVtpnx0AizO+roWGQdYT1V1DjNYcTT6jH6U2xdryX2x+T8MnWAWecDp1rDtnG
         ieBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989641; x=1752594441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=314z6MlglbukNdol8XnNTyUm4Bk/au2vty8Ed9bfUz0=;
        b=YPiuiXe7CMBW0LZZUdNE+rOrvGcBT2IPrQVVRSV5GefS+j/u0JzLU/ur7VZcdObrHw
         XFu1Bcc+i3Q4c3LE0d7qHDkh5gOdrcWlAurl6KBaxlacP+0ORJeg3Mcu3GK70EIfo4TA
         fPFp6dk3T4frpxb7sgz6mrMUHUcpGmjAJ6GMxM45OaowU9a/ELVY3D6ID/1b1mAkL2v/
         Z8B9Th84mvP0XNoOyl6WGQwOC1tJydefA8tc1BCvJ3ur++7Y81ovq3qsnklJas9U1jmR
         DyI4cylBZYADy8MShdswlhkikhWxu9S5ZAlaFY62OLc0KK+LdY84vMDsQSaxurPAZ1/7
         TK0g==
X-Forwarded-Encrypted: i=1; AJvYcCUmtdVkUPtM4O61mpGq1+qkwjdhOiG8kDPMQ3aqMADZgSx3KGuvjutZ30UFaRPQBoIw4m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSuHtQEP5tjYUbmsZCjSQkgWxWVAOqA/qH1WTEJM/J08HSIrS
	xqcdrEdYgbfVIQ+zm09dgcjJJpvLg+XOmKSFrk7e5idYv736a6V7uOIGCr1rnzvCI6elPjBVZNO
	EgGEhvLNBumZRhJBY803o1Ur0uL5JiVY=
X-Gm-Gg: ASbGncs14S+Av0a4EKC4u6PGK7nnNUcKTdTTyvsQZkM/svz/tLP2z4fRG0esNBZ5lsM
	kFpC6UBM4yi0DHb3uDJ051cMcW7dLARPNdQeEF6fbEDZt5ISWfyY78RfgHt35SmCRLFARCKzj2V
	+XgXGWRBFs2pqDcP1syx2Mt60jLhPezXUbVd+4sRV5Ogc5ZoIUx+n3INJCqpXnXbBIWbr6H3oAz
	Kg=
X-Google-Smtp-Source: AGHT+IEEpR+PJTP62QvZLFp7T+wK0dLSu1T3nWPqODoS1b5j9BGfZ2RpiUaJNmxk3EAJmKrmI8Cm1z1TS6u1QuipZg0=
X-Received: by 2002:a05:6a21:e598:b0:220:af59:2e35 with SMTP id
 adf61e73a8af0-22c801e2394mr10962637.38.1751989640732; Tue, 08 Jul 2025
 08:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com> <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
 <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
 <9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com> <CAE7as+abNzqbGSCWsuYe8D_c5dBUuRdDEbHL0pVW5j3kTMER4Q@mail.gmail.com>
 <062e7abd-97b1-4806-9753-338906642265@gmail.com>
In-Reply-To: <062e7abd-97b1-4806-9753-338906642265@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 8 Jul 2025 21:17:09 +0530
X-Gm-Features: Ac12FXx-o9_DZt9zMT3p7Kn6QVJRttHd7CmOTxnpIkbLrLWHAF_UGke5pY3_Q0M
Message-ID: <CAE7as+Yp9GWRohqe4oHHmYa1MfuKbyg9qKRf_z6N50bCSZ8vzQ@mail.gmail.com>
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey, Phillip

On Fri, Jul 4, 2025 at 1:53=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ayush
>
> On 03/07/2025 00:46, Ayush Chandekar wrote:
> > On Wed, Jul 2, 2025 at 1:02=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >> diff --git a/config.c b/config.c
> >> index eb60c293ab3..bb75bdc65d3 100644
> >> --- a/config.c
> >> +++ b/config.c
> >> @@ -1537,9 +1537,11 @@ static int git_default_core_config(const char
> >> *var, const char *value,
> >>                !strcmp(var, "core.commentstring")) {
> >>                    if (!value)
> >>                            return config_error_nonbool(var);
> >> -                else if (!strcasecmp(value, "auto"))
> >> +                else if (!strcasecmp(value, "auto")) {
> >>                            auto_comment_line_char =3D 1;
> >> -                else if (value[0]) {
> >> +                        FREE_AND_NULL(comment_line_str_to_free);
> >> +                        comment_line_str =3D "#";
> >> +                } else if (value[0]) {
> >>                            if (strchr(value, '\n'))
> >>                                    return error(_("%s cannot contain
> >> newline"), var);
> >>                            comment_line_str =3D value;
> >>
> >
> > Thanks, I understood it.
> >
> > What if we simply return the function `adjust_comment_line_char()` if
> > we get a non-zero value from `ignored_log_message_bytes()`, i.e we
> > won't scan the commit message in case conflict message exists, and we
> > let the old code exist as it is?
> >
> > +       if(ignored_log_message_bytes(sb->buf, sb->len))
> > +               return;
>
> So we'd ignore core.commentChar=3Dauto if we detected conflict comments?
> That might be surprising to the user - it would mean that we'd always
> avoid adding the conflict comments to the commit message but we'd lose
> any lines that begin with the comment string. I think I'm leaning
> slightly towards the original solution but it is not clear to me that
> one option is much better that the other.
>
> Thanks
>
> Phillip
>

Now that we're planning to get rid of the 'auto' keyword from
commentChar [1], do you think it would be better if we just ignored
the keyword when we detect conflict comments? Also, how is it that a
user will end up having lines starting with the character being the
same as the conflict comment's character?

Thanks!
Ayush

[1]: https://lore.kernel.org/git/cover.1751983009.git.phillip.wood@dunelm.o=
rg.uk/
