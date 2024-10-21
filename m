Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12E1C3F01
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528624; cv=none; b=uW9qzGBNXMCijl1nvk3QQSe0Cfgpm+OXLvBwXqOTxRnT8qjVcWZ4TPtVnik9bl6cvQzgTDmLUArCS7ad1rKkSj2077SjykhCJg8sbezFriwH9MLYPBtD/3tZ6A8uFrjK+jH/P6xfzigztxS6FXFpmCxuAm4rc2qd4cLZzJTdTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528624; c=relaxed/simple;
	bh=FDm1F7t2RMYvIpTCIxQwZg2lHTs3EAA5Uv8R6dfxERM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDZJqGkEykCA9cp62OOKklkcpg1hap1qMfCPU7MNpSSdNqW17lsjmz/HT0LfLS80Y4G/qymDBC1zG/I965qlWvW9HyAazG/KmqqzfXhWEVSPh9wPh6GE3Fx54cNSDI/yMovxk/yEIAhA2kBjjfkOi2A/pAGRb6jDgqjAPDmU2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0KTlHGD; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0KTlHGD"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a48477b25eso3245943137.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729528621; x=1730133421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDm1F7t2RMYvIpTCIxQwZg2lHTs3EAA5Uv8R6dfxERM=;
        b=k0KTlHGDu1CC3WCFHN+cVO7SVJujC9YSjg96yQzvPvrlW/Ysqopt847K1GT0EjJBkM
         bPEKMSQ/9Ji7Nf5dZzSSon5nusghMBDHCmxKO0Uv1cIHI0fpTejEjd54C1/B8EytrdWw
         PFg/h9tvxgsoo1RB/8OB30HWUlEtneNlQKyQziqyGeCnWBdNE2a1lQX2VD33RsVPIuF0
         RT20mOdodrmdSUGsrRybUAOu4xN/ozem9A1MQM0pfXBh3lZjhOZR1krHdzBlFzDTZtWo
         PwVAPUM/y3jXk8OeaL5b48VEdKFJfFrYCNneEJSK7Iri0b4+lwnz5+KqOTt93FQ/q0on
         9vJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528621; x=1730133421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDm1F7t2RMYvIpTCIxQwZg2lHTs3EAA5Uv8R6dfxERM=;
        b=HiKE2XJVvOFFJFY16OiHfadb7cmUl0Wcn8d3fkkyAgEe8670Q5yOdDpJ9HWeTwxiDu
         lXQyJr3FvrS6dbsgfqI/aPm1oenjgqjTWSKYLrywbcmrUA1IqEmiFVGXiMNxtlgjNhpp
         cIvVWSaPLc1vthlPyn4FiQRSs7vvdSl3i4gSynba3mC7k4fu6oGDO508MnbNsctwxYEv
         8a6Utd1V89I1/Q68Wz+3jXPKWvt7Tbf0oT7mh/RsEcFoeEIGlAIO5vyuOG/QSzFY/zD9
         VpQBV2RNFDQwXNvcPnX/qW37OVkd3UH71GX/Ege2vbJUdWvAGjb1lCm+hjEYl2Ck/7a3
         oFgA==
X-Forwarded-Encrypted: i=1; AJvYcCWEm4HFS+DZmx6xi2WSvKhea4sZp1sDiFt4B7fOOMjIjpRFUqOzoQFUhSNFeaIB/BLr8MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQs5kaxm9IO+ySd1ZyJWXheLPI9HhJi1iHfPXuXXBMlTlxOgRP
	VwIfP9w4/Zojuc08F+Tam4MT3FFSFHyT0YMpgzOGRo5KR3ofScbwhQLUZQSHZn3q9YMQ+bxVkat
	bLpYzb4wn+gg6WxmaWhHfqI1EpdM=
X-Google-Smtp-Source: AGHT+IEaqQpI/yRhJ5t1jundmvcD0KvyCHRy8vXyHDznYMi5wIph4YufSvAZeOFdFJzc5do5ys2oxYTuFMAhw54E62w=
X-Received: by 2002:a05:6102:441f:b0:4a4:77c7:9471 with SMTP id
 ada2fe7eead31-4a740d8a1bemr366256137.5.1729528619762; Mon, 21 Oct 2024
 09:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im> <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
 <ZxZKQrc0Ch_YA1IV@pks.im> <CAPSxiM9BuOCXSstZCm5B9dR6D0rg5vB23T0xNT3xAOJihQy0BA@mail.gmail.com>
 <ZxaC3o05fZNOWsf/@nand.local>
In-Reply-To: <ZxaC3o05fZNOWsf/@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 16:36:49 +0000
Message-ID: <CAPSxiM8VeXZFdTP3QBwLHbJvXZ2W3vBxn8P=kcDcfFQzaHSHUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 4:35=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Oct 21, 2024 at 02:38:40PM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 21, 2024 at 2:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > On Mon, Oct 21, 2024 at 12:27:05PM +0000, Usman Akinyemi wrote:
> > > > On Mon, Oct 21, 2024 at 12:20=E2=80=AFPM Patrick Steinhardt <ps@pks=
.im> wrote:
> > > > >
> > > > > On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitG=
itGadget wrote:
> > > > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > > > >
> > > > > > Replaced unsafe uses of atoi() with strtol_i() to improve error=
 handling
> > > > > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP comman=
ds.
> > > > > > Invalid values, such as those with letters,
> > > > > > now trigger error messages and prevent malformed status respons=
es.
> > > > >
> > > > > The line break after "letters," is a bit funny.
> > > > I just noticed that I will change it.
> > > > >
> > > > > It would also be nice to point out why this commit doesn't add an=
y new
> > > > > tests. I guess the answer is that we don't have any tests for
> > > > > git-imap-send(1) at all, which is too bad, but a fair excuse and =
not a
> > > > > problem of your patch. So introducing such tests would be too muc=
h to
> > > > > ask.
> > > > I can try, but, why was it not introduced before, is there a reason=
 ?
> > >
> > > I think it's mostly that we'd have to have an IMAP server available t=
o
> > > test sending emails properly, so the test setup would be comparativel=
y
> > > involved. Nobody felt like doing that, and thus we don't have any tes=
ts
> > > :)
> > Ohh, I see. I have not set up an IMAP server before though. I can take
> > it up but might require some level of guidance.
>
> I think what Patrick is saying is that it's probably not worth the
> effort to do so for an automated test, especially if the code change is
> trivial by comparison.
>
> Thanks,
> Taylor
Thanks Taylor. Noted.
