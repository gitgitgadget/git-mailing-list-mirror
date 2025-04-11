Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AE22C35E
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391526; cv=none; b=dPEv+uAYZM0M2ZKVHG/4rzoZVk0/bv53IctbVSjbZelFISpKk3/b6GiRkS3EIZAVcZT5QPXzvfrrJnXoSbPpfo2zaqxfFxm9KAUp5rijO1cQCK5zVdCzvZlNU1PN3ngqbN/3+SsnwiSKjD0vW+RFUof6dSJcIdI200GbBuc+J2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391526; c=relaxed/simple;
	bh=DiaNlITmSoehorP5KBidIwAfTDrTn041bSa0yeZVMFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5QONqbr1tJSohsL8rwOuhhcAtd0X83tOs38swbr5zCf6el3pyb6yo3NRkpUBSZ3QJ4l+cT5DKtH1B3eQKtKamjU6MBrGS0pNGMUZ5TTbASrgl3kWnoHirgqx7C0h+k/xkOR3dfaLaO2zrZEelfDNCtexhvrloAPZcD7vxuhNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cob2pmal; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cob2pmal"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso18686745ab.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744391524; x=1744996324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGAevT3IXX2BZ4gay0L+1HcBTkZF7dx047a2dZ0xK8=;
        b=Cob2pmal39mqFdwasQPiw0qNGixLW5MgQDtARtauuKImxw8u2XDdLS0OKY5cH7cvxW
         6WVTfZ11S/vJRGhExctFwAmdn368oKlvuelh/B2FSQe+jZBn5DOn+JGsjfR0vHKHkkUK
         ieS5qYP2Yxqnrt7zYtNAdyIni1JEdN89C1pVDc/taTHfiD7yQIfvM7girCpgAg9+JMhq
         9b8jqiQUq/N4XBy2BxH3PJ6AvekcG3WYXf4bqiWtCesPSR2VjCNGgyMZ0Na57FqHtHh6
         47SiYe1UyjUbzf8MpG7LbMfokciimsfm632GAiIsyCpog0uoYpdPOl9JPhWA9BKvAHk5
         fSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744391524; x=1744996324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGAevT3IXX2BZ4gay0L+1HcBTkZF7dx047a2dZ0xK8=;
        b=YOgmq0L1R+/qrrGMX/LnPCDRMRpJeFUHY7fwuuxN84looursaezhsv6myxW4lnkRID
         8ZouoCi9AxVnf00e3mn2673kZAgd1WWs1x7xE8J6Iae2yxFYPpI1CN90opKz1dkcmsWp
         FitQbQwwDJu4zKMG3cOeZs3aXuJPgmvN5XLuyAFVtBaLUfD2LqqtwBWOJQ1dYT8IWtjP
         1KlhLL1LZ61fiETSUc7ZElrqYequ4LhnDTMWexiHhs+8LywUXf+ULito9ftas4MWS2uz
         T3djf2COT6JxrgZH2Xdjw9Zlr3diA654FU3hnIR3mhK883/tU3HMB+n5zIFHDV0cUo2C
         rAQw==
X-Gm-Message-State: AOJu0YzttWCbo7mN+nY1JH2BXvoQGI+9VcbzT0OkRNhf+aKUWu+uqesO
	W8EKVYh6JwK0I2uRbFkFGO5KfaNdnFQIohLBFkj0AT59ZzjR0YXNlOEho2Qh2O2zeNgu/ZrZVW9
	3BoIw9yVsnqgIZI9nmOIK4lnUslznNZ53
X-Gm-Gg: ASbGnctS71xrqbEUpZVQqiowuBBhcNhrRBXBXYnRCt2bgaw6FJbX9c2B6DEH9GVss7s
	xI+fM9mdNA51kiqbKgxLn7byclgH2rIpIUJyRLx47Ql8N3DsDYVLl2S0rW/WJABChJnQWQhEEoW
	8baKPLdJ+JAmZz+4yUWtZyRWFJpR0/eU8WyqTmqgPuRj0f3zagSPg+0pHx8ae8YWMlNQ==
X-Google-Smtp-Source: AGHT+IFwnfJNm8jZFiDJz+AJtDPwR6nLDQvLRZGILcQEpcwxJUYF4KdP3yyTp29e2bL03g0CwYcT15Zqsz5w+1Zea6Y=
X-Received: by 2002:a92:c266:0:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d7ec22765fmr36107235ab.13.1744391523882; Fri, 11 Apr 2025
 10:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im> <CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>
 <Z_jgdV7Tkw0hkvgj@pks.im>
In-Reply-To: <Z_jgdV7Tkw0hkvgj@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 11 Apr 2025 10:11:52 -0700
X-Gm-Features: ATxdqUGqT-CTC5U-RGFQH1V3q7bIWYtGim13WXrI2gySDVEripZveW3ZO_2c_bM
Message-ID: <CABPp-BHJHPx7orf-jjgbcPtJo=tGeDZzYWEKvPU-qzXTa1fNSw@mail.gmail.com>
Subject: Re: [PATCH 1/9] object-file: move `safe_create_leading_directories()`
 into "dir.c"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 2:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Apr 09, 2025 at 07:36:47AM -0700, Elijah Newren wrote:
> > On Tue, Apr 8, 2025 at 3:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > >
> > > The `safe_create_leading_directories()` function and its relatives
> >
> > How is mkdir_in_gitdir() a relative of safe_create_leading_directories(=
)?
> >
> > I assumed the relation was "called by", but there is no such
> > relationship.  The rest of the patch looked fine, but I was puzzled
> > for a while trying to figure out what this relationship is.
>
> It's more of a sibling than a child/parent in this case, true. I still
> think it makes sense to move it around as it is rather generic in the
> functionality it provides and doesn't have anything to do with objects.
>
> Patrick

I fully agree it makes sense to move it and that dir.c is a good place
for it, I just think it also makes sense to fix the commit message to
avoid the misleading/confusing text by calling out mkdir_in_gitdir()
separately since it isn't related to
safe_create_leading_directories().  For example, highlighting the text
I added between asterisks, you could make it read:

The `safe_create_leading_directories()` function and its relatives*,
as well as mkdir_in_gitdir()*, are
located in "object-file.c", which is not a good fit as they provide
generic functionality not related to objects at all. Move them into
"dir.c".

However, this is a nitpick and probably not worth another re-roll;
especially since everything else in your v2 looks great to me.
