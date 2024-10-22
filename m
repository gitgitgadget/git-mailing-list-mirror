Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DAD1E481
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604602; cv=none; b=sxNm9SlmBGxcMpV6FFq+vEcV8tQTLZmIPGAhlkZlDrsVBn4XqPapfulcyEH+p3RvuZ1RUikh8avAJvE/3mCZzz0bvE5Ph8u4eeRS21jsuEqHXX6QDobculWgPwmNCfL0DiWoyPayWueYvTugP2fBlSUQGXZgTX71QoUV9/5CPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604602; c=relaxed/simple;
	bh=32of1ILU/UaMN+59e5CkvqAKV7ufbT1WVrnO5trgw4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8MoWcptkOhpJH0+SF04IQP1OPGcHO9R7kn5limZhoYpSw9vEYMg/J7+GEwyyw+9wTVDniHhYGzKDQO//rgBItGh+fwzX26NnWXsycb6F9l1g5mLaG/RtaSNlVi+rzr3TLLD7WJUBR3YbDb43Hq5eeW2kGPWI8SfXVshjDJ49WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8evFwaL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8evFwaL"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fd01c9defso1748862241.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729604599; x=1730209399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32of1ILU/UaMN+59e5CkvqAKV7ufbT1WVrnO5trgw4c=;
        b=m8evFwaLSysG0qgmqiMr0wpl7Wifl3ta6oEjbFctZPAq21e7sZMDtoe+ON+65eB45h
         Pr+G25og//HfZhCS3KR2rYMMdoSH0mG25exLCoo7OTy5nB5PpK4zDl+gtWhAN1/O4BkZ
         mFdzUWEC3an7O9bRSJp50+xXAR1CdOzv/HldFt4fYn9t8rPGGPscyk/dyI72XDjmMyuq
         YoyxIV3Y1gj0M9YW9RNSI0wO5BqDcAK4iq5O8fVF57feuTWGXYFWIG//dqMRpnIOnLep
         UJT4wNV2WNWYjVD51rlbhBBr8MKAdzIn+vmBcogUNlEVGcjV6DwAhq+b4UJ8UdVPTEq6
         ZJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729604599; x=1730209399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32of1ILU/UaMN+59e5CkvqAKV7ufbT1WVrnO5trgw4c=;
        b=P2KUw/3nqO3zR2Dy97+gBrT/PMEGUuG7Q/DQtbI1JcASZd5YgJsT8tRSz9JyuJvgom
         MkKQHz9IDMIV3n2sW4gvTNILEHFswwnojNlJg5qzXfLnBpM7fiteBU/0ug280ZHUqHf9
         Pu+6i2e4stmvNDShulY9F1KjugDVufyuNFwJ/MPosG4v4yX6kKPRgCS2dXQjjGcAQ6wa
         ShNQG/2OERzF6/y59ATk38RWBTIDjp0u2qBjLeca2/qyr/pPWUTMh9jKZdsGmRLClfOM
         Zu0Unep8jFEh1zoAVhJt5lEbfN2qsswmDyMXZvBiA4Ok/bQmWYqXd1ex5gtBruuw9vwU
         ZVSw==
X-Forwarded-Encrypted: i=1; AJvYcCUo0YQIcAQSZWJe5XSZMnX/5emAWYr3hrw85Tpz+Vtg903hCj6i0Yzd2b0FiqvtlNKdRco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJhJwCR1Y7XXnLlblzeYVksD2vmefNn2/MkKEyxpzq85tvdI0
	XBIQNYTCbrSwrceesvMZ/rhpnzVOON+pQ3qF5XrOPhPrWKO03B8rC3ZL2bdKCzmAUQP+ajrwEze
	ssgsa+DWjELscR18IH/F/RY8sOZc=
X-Google-Smtp-Source: AGHT+IH/9gBdtZLQuhUrDspwsO0qtGN7Vb3g1+6UlA+qJSM5n4aUxdq3yoNnU8d5TcZRdVetqw9G5UPKZY2Ftn8wteM=
X-Received: by 2002:a05:6122:468d:b0:50d:535b:a18a with SMTP id
 71dfb90a1353d-50dda1d2d31mr11097836e0c.6.1729604599021; Tue, 22 Oct 2024
 06:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im> <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
 <ZxZKQrc0Ch_YA1IV@pks.im>
In-Reply-To: <ZxZKQrc0Ch_YA1IV@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 13:43:08 +0000
Message-ID: <CAPSxiM9Ae4zK7R61=pByoaaaeA=4x77SufTmrsa-Huwsj7EQ-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:21=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 21, 2024 at 12:27:05PM +0000, Usman Akinyemi wrote:
> > On Mon, Oct 21, 2024 at 12:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> > >
> > > On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGa=
dget wrote:
> > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > >
> > > > Replaced unsafe uses of atoi() with strtol_i() to improve error han=
dling
> > > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > > > Invalid values, such as those with letters,
> > > > now trigger error messages and prevent malformed status responses.
> > >
> > > The line break after "letters," is a bit funny.
> > I just noticed that I will change it.
> > >
> > > It would also be nice to point out why this commit doesn't add any ne=
w
> > > tests. I guess the answer is that we don't have any tests for
> > > git-imap-send(1) at all, which is too bad, but a fair excuse and not =
a
> > > problem of your patch. So introducing such tests would be too much to
> > > ask.
> > I can try, but, why was it not introduced before, is there a reason ?
>
> I think it's mostly that we'd have to have an IMAP server available to
> test sending emails properly, so the test setup would be comparatively
> involved. Nobody felt like doing that, and thus we don't have any tests
> :)
>
> Patrick
>
I made all these changes in version 3 of the patch. Thank you.
