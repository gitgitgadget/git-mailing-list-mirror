Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A45B67F
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932498; cv=none; b=hQx2H6LSea1LHxyTzPs+CdJlNtHac9kBSwR6NfNcEON9tcwFeREf5Kw3NAUGNjWJNwPSxSr+U4DTCZyEcRKi6FJUUlJS/yJtaH3uA9EMXdhGffjz5euILjuTNI3cp8mwkqjmrIkv497nsCiQ/gNtnZ9Y8TlUZTEMmaFISvziSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932498; c=relaxed/simple;
	bh=dTP514ek9LksNv7YlVEOtYkotgROJLuu+aPxARgMf3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM1KwWlJHLBHQPdN6XhacK1p70Twzh/3EbkTbeYXYh1rFp4UxqVU5GVCmBZENY00KoYxcjaVD1fMQSyx+Z6CzA3rG1Qs4K33CttIQWQYeNAP8KWQRUTF5Pa8GKIWCXcsvrcqNxcDqnd5/pYO3RkM/jc9ZL1K1YrNrGJe7vkqHGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RThjLVA/; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RThjLVA/"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d45503af24so15110355ab.2
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741932494; x=1742537294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTP514ek9LksNv7YlVEOtYkotgROJLuu+aPxARgMf3o=;
        b=RThjLVA/TKX/0Dmi08bJqJNuQQiar7AASkn5jtQn4E9XcS2z3x8c2RMogoslI3b16Q
         T6zDS+620RQvMfBOO2oYSR7PCFYoO5e0nCKOMEPiuSy/nBut0d9zijES+CWNA/s7SI6I
         qAfZS8XSoLi+sWpofJyNv+9pkZM8DPgXMSX990YdP3Bot0j35yrMxpB4zi2vpsVXO7TX
         PdwvV0xApj87TTKs60FyvLybvBvt2lp1nW5WXDWrGojRgCDbakoxW2UDJ2VqcGr9St16
         sMajokk5JRW4DH+Ib/5oM34isNdyB2J6WzCRpDf0TSTXu9wvGVxjjFCy+E1FmZubNqv7
         jncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932494; x=1742537294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTP514ek9LksNv7YlVEOtYkotgROJLuu+aPxARgMf3o=;
        b=DWbgxrEWA5z3a1M+qJh2Xlbs3uKda4sX5dIToF/3NYN4SIW4h94bod7XUl9SAk+LOM
         Xj4j0P/fxRR+l6lVEJcT5NO1Hz9DatN+hlzVJ0pTmOosxID+qBAAM3CbEpZBwObLwTjM
         MwVtmdVDVbCp/KFm8pksnlK1mXx57kGBlgHM4Q+ULG5UZlR2C/VSm8uVvWEKzSVo4mdj
         pAhK4Y8HgSUHP+VAIt88URobvNapvC9WcuBUPFayCrRokDChpuWFYEMigpC92M16MSO3
         7oTEf8DZ1H5tenyTE35a6YFQG5pl7MaYH6GFfR8V5JQPOrd1+Pnakq3FY0Eb3YR+r6/N
         mXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfRVf9gXXdgjZHi/k6QndMRuS8e54it0YFNa4uVmaXJ1Z9rtYB2NRJ1sSSjueq7//8D/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YapiGz1ilSttyUXOm/uljALKoc5vGRJDbaAWqjUA/b+bVLi7
	S21jJADLd1vx/K5aAp+8bsRVYnRoMFJbsO3v74GZIq7sFRBxHfr6blNJeBRPNPJnpRQc6sgIIxL
	Itm1j4ZMeVH/0tm9RIunb1FTEkF1thTEd
X-Gm-Gg: ASbGnctnFEkHQ2LJvRYrbG4AXNVAMgHi65ix+DEIXyxKSEfQoz3ee9OgMZGt2IvUgBg
	kif6wbwDOfS1mWEtV8zOHwDLY7JzaUtCU5nO9pomQ3fP/6oQ4I9YqumhvN3vpQmBy3gREIiI5jj
	sSoSnlffmCt+ANBppEAys/CpIbVyGG+ALntsBnYZ0lxEllEszTrw4vhG8EIlA=
X-Google-Smtp-Source: AGHT+IFUjUF+0E5U1z7GoB8KsNk6klNYrk5vxmOiuz6Z1ro+7HmI7A6zKe10RkEEONNM/KJlb0ZiZAKbatEK/3LoFW8=
X-Received: by 2002:a05:6e02:144c:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d483a19d2bmr9373695ab.11.1741932493786; Thu, 13 Mar 2025
 23:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920112228.3d1130f5.olaf@aepfle.de> <20240920130729.GA7349@peff.net>
In-Reply-To: <20240920130729.GA7349@peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Mar 2025 23:08:02 -0700
X-Gm-Features: AQ5f1JqdKWPNTGao2cJ23zaBT6QMZzIUTeMFT_Qt9F_ry8mCYjeZNhZ-Rb6kjdI
Message-ID: <CABPp-BFb1d7dbWdPwA9q_e6pLT6OHPr2SQC5ZwqXwkS74dXqdQ@mail.gmail.com>
Subject: Re: BUG: diffcore-rename.c:1674: tracking failed somehow; failed to
 find associated dst for broken pair
To: Jeff King <peff@peff.net>
Cc: Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 6:07=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Fri, Sep 20, 2024 at 11:22:28AM +0200, Olaf Hering wrote:
>
> > The following issue left my terminal in a weird state.
> > Is this a bug in the repository, or a bug in git 2.43/46?
> >
> > set -ex
> > pushd /dev/shm
> > test -d x.git || git clone https://github.com/intel/linux-sgx.git x.git
> > cd $_
> > git checkout -b $PPID.$$ a53adeaab7a8176fabb415bfcdf6d29fe4060678
> > d=3Dexternal/ippcp_internal/inc
> > git log -p -b -B -w --stat --follow "$d" |& tail
> > cd $d
> > git log -p -b -B -w --stat --follow . |& tail
>
> Definitely a bug in Git, since we're hitting a BUG(). Looks like it
> reproduces with just "-B --follow" on the path in question. Bisecting
> leads to 9db2ac5616 (diffcore-rename: accelerate rename_dst setup,
> 2020-12-11). +cc Elijah.
>
> -Peff

Sorry for the lengthy delay; fix over here:
https://lore.kernel.org/git/pull.1876.git.1741395615315.gitgitgadget@gmail.=
com/
