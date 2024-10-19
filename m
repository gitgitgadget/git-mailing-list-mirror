Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44161DE4CE
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327382; cv=none; b=p8pWzxPd2vf03Y8pb63cDOrL1tPTKFR9/LIAx2z4yvr3SRjuhV8PlIVakkjzP8nWEAVS3NLg+8SVHOremOBwywLUJ+lbAhgJPwDPRpOmW1nvgbEefnmE7Zoqx04oci32pZ3YHWitLDcjbDxVkCTKcUCq6XTvaho6qh7ajxOMvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327382; c=relaxed/simple;
	bh=UNo8X6kdJ+6HbYozZa5V+r2nvjFuv62Zp3jApjdsxIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR3jGvL3bfp9D43mS7io4zj4YqGe+tsEZ2QmivzC3YZCEYleVTbC8DTzHrahfhrxWPwH84kn0IFoFOPDMJ5SuD25JxrR0safsgD91p9g3M+NLYb5aNhalRXrNap9wzygsVaM262kY7hwHlpGAz0wPYQMvZmkd6bi84ekUGiE5yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0CkjaUA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0CkjaUA"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e390d9ad1dso30074167b3.3
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729327380; x=1729932180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbWvc5vZ7WRFX8Q79RRbByrm0Up4SiLy4UYkUDtiyFo=;
        b=k0CkjaUA0IoySh0N3HH47cBhuw6U85/PpqG170wyDyfPwlQ9v3yv9DfYFBRuaE/2G6
         cF6itKT+loVZa33Wi2Y6urdAUA1kzTErZ6FZ0S/iAhleVFwmL1+ioAmDn4TOq6qRBJtf
         9qaGLS7Iz4igqgwba1G2h73QY3r8ky4PDayz1ePP4fei3BekRqdAOSPX5w4eafCzFdwr
         VVs//azkxIswvDxp2S4YVb+vtkpd4f3+/UgqHGVhKGTZK0mAN5g63RqcU1l15ZLn5OnG
         g0NHxb/zK7uD9h3w6kcgtND28BV9zihXJJH9DSWh/j6EZfbukbcUFBAa/hocGu9cNYCS
         apMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729327380; x=1729932180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbWvc5vZ7WRFX8Q79RRbByrm0Up4SiLy4UYkUDtiyFo=;
        b=FJj6FLsONjRL8T9dyV7SHfWtvcNFG/hiCETXPG8ZcewVBVNZyD1KXfCJyTc827tJNQ
         /EgSPFKmOE1f+n0m1ClNoujASeb0ITDIv0PIKVy5Fjmxui62CJBm67oD93Rx47uW0Ugw
         quhcnfaU4lwAsYjr1qxgCNTBoFPv3eb1tURBmF67IlM8zib+8qu4XhBBEQe1s/F/b9pm
         gjevskkXpSdgtBSBiddIj4AvslrWYryWIkU5TMvikAd2sbQQbhKDoxyjKdp3yNRTO4xR
         22+qYpxArHPVaikP0G++R3lsV3oXiXuWPMYwYg0FTGyQNhq6eWWSIfG/vHhecGRA8wrH
         5Tgw==
X-Forwarded-Encrypted: i=1; AJvYcCW33J2iHz4n0/Y5ewNFL8F5ib83K3KlzLxLzaLi230sRlMsaqNt+hhz7WaLqIf4gExN/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CBrNEF5eeywQHCYQJyDgD94bxupI9Q/9UJbZw+D2mie2M+gx
	N92Ms9+cA0LzYJ/s2r3IeC+ckAGBHlPeP8NXYN//xIO+vj+KjPNVfY+/R9kK5ikcrWv7ULy5es8
	XKoDjD1r0r77oA7eZHOJHYfNuvq0=
X-Google-Smtp-Source: AGHT+IGvI+r0gimFpsO16EK68jST6tYFgWPEDNglcUowcx0CXkW/SIsM4pAwCp0oAVCMrA+HPtcRty/aQhhoL6w/Ax8=
X-Received: by 2002:a05:690c:7307:b0:6e5:9d3c:f9d3 with SMTP id
 00721157ae682-6e5bfc62563mr53798937b3.41.1729327379734; Sat, 19 Oct 2024
 01:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018191744.209746-1-kuforiji98@gmail.com> <b005084c-2710-4567-9217-27f34c2bbc95@app.fastmail.com>
 <ZxLNBxcnTf8nsT1H@nand.local>
In-Reply-To: <ZxLNBxcnTf8nsT1H@nand.local>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Sat, 19 Oct 2024 09:42:45 +0100
Message-ID: <CAGedMtcBbzA57Cs3W3f4ZbS9roERMhxe3GK=HL-7oRBOUsxB-A@mail.gmail.com>
Subject: Re: [[PATCH][Outreachy]] t7011-skip-worktree-reading.sh: ensure no
 whitespace after redirect operators
To: Taylor Blau <me@ttaylorr.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 22:03, Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Oct 18, 2024 at 10:04:43PM +0200, Kristoffer Haugsbakk wrote:
>> We can see that from the patch.  Saying what it does is redundant in
>> this case in my opinion. :)

>> I think it suffices to say that you are fixing the code style.  If so
>> this would have been enough:
>> You seem to be wrapping the lines at 80 columns.  72 columns is more
>> common here.  The idea is (I think) that you add some slack for things
>> like commit message indentation in git-log(1), multiple levels of email
>> quoting and so on.

>> It=E2=80=99s kind of indirectly mentioned in Documentation/MyFirstContri=
bution.
>> I also found this:

>> https://lore.kernel.org/git/ZrCdDHqKfwWbr_Zn@tanuki/

Duly noted, haha!

> > Hiya
> >
> > > [[PATCH][Outreachy]]
> >
> > Apparently you can=E2=80=99t nest brackets like this according to git-a=
m(1).  I
> > got this:
> >
> >     ] t7011-skip-worktree-reading.sh: ensure no whitespace after redire=
ct operators
> >
> > Doesn=E2=80=99t really matter though.  I suspect `[PATCH Outreachy]` wo=
uld work.
>
> Indeed. With format-patch, you can do '--rfc=3D-Outreachy' to achieve the
> desired effect.

Thank you for the feedback Kristoffer and Taylor!

I'll adjust the subject line to conform to git-am using Taylor's
suggestion for my next patch :)

>
> > The diff here is clean.  It only does what you describe in the commit
> > message.  Good.
> >
> > I checked the file and I can=E2=80=99t find any missed instances.  Nice=
!
>
> Thanks for the helpful review and feedback for Seyi's patch.
>
> Seyi: I'll queue this into my tree, but mark it as expecting a new
> version to address Kristoffer's comments above. Thanks.
>
> Thanks,
> Taylor

Duly noted, Thanks.
