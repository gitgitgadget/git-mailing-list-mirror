Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B2170A3F
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221234; cv=none; b=VeWbXokYxC+cQMQI8swqr9weGd/6nDXanywOAWkA1m2WT6sps7WKG04q9zjoYHTk81MKHjqUinp+qBVC45n6omWXvDFN4GbmEWRXjuqwQJiKf59OxKgO16AF12ZaeGZ9JXCX/3IP3OLoMeYz2dGeNIcTSUYckxYsb+ysYO66V74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221234; c=relaxed/simple;
	bh=dvLYESDwKgK40z3Z5KBlNdGJBZMeqLkEVdx4QLNna00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwkPC63Px07hqeLnWDdBCc817FwSpYVqfEsMzs7A7BCdgXDXjnIL93GRWW0do5RFMqIwD0CCa5ZqQ2zeVrx/V0PIRm0EomNFlIIeDtcMgx98Q3Y3mGBupILZewqzIgoIbMImLQK3+V0M4TLV/vR9bll1HKUfvUFGlR+U/pL3cwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs5Al8ew; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs5Al8ew"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a3a8cef4d2so1118278137.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728221232; x=1728826032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vmapDqrgDteTeiv/vAAMX4bIV2f55ycxMp20b/a0Zc=;
        b=Cs5Al8ewDQq5UHnN+TM7icnbf+YvvooeJgLdLc+Z3zMPMMmmKVUULQC3HngwNW8/Tr
         qvgHV70gJYVQWRq6n/lOMWZsWirUAaYtPqjUUrkK+WKN6bZgsrnbNgPRg3ebEQzWrFt7
         d0c6sMfok3Kd/3ksUviKzv8/xJus0VeA252RlOzokc6u17UZ3kEvstZ4z2PDYedLuxB/
         6vOdhOug4mFyqkmAM+n87Ggi1dMD/brdpxgAcoaRnC3kXD5n5S/NODOmpRIuGFXcIMGv
         iVe6pMfwcw0aPJ6apkUnmfhX8u/WUVGMgyGDmZbKZ8j9epsd1D6WlLIit9viq96Zzsqr
         vLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728221232; x=1728826032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vmapDqrgDteTeiv/vAAMX4bIV2f55ycxMp20b/a0Zc=;
        b=RTNqVlZDUF+FJY4lf6vIKpkxAE8EL6n5EuNQPAep4/PazhaMfwjsI1GW6UGKpzt5Cw
         RSFPnn2pclXjdT9eNgNudhF+PgiI0oSXQowhuFVBezc/7z2y58rtzIm/6XshWdcziM/p
         HYvCGl/xngMEMJm47tOxa/5Y+voBEUO25z3Kptws3kEpPv9WOnhkjN6wfVBpBBg/bDwk
         Vch85VX/b5TT2+yDGoHHdV0eIV4IbVNMIY9JbY4odKLEsh4coH7o82IhOptlrkpHIX2H
         i9ogNjwBmHC7SprZioyorgf6ES+BC4FMjHZwuWJ5JGE9THeSbFvFDjBzhERYgA1AOLSy
         o6XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUacj+M7aTOTxDBDVjZK0GLBJIvVwvcYTU6BZWT/18l/xYt5tUrprOtg7s3v4DRoueNPJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGl3LTlHK/dsxZruGff7TyiRHxpjYBousqkqC4+/fGHwalRPD
	2uDhyGeYcKU15pzzdjQZQsABfA7WrAvBuV/JVa5HHYbAr4hCx/mbZd/ltq1GPfv3a/GoN+X4D69
	jaGtRVhrxHDzHaRTWzliXW/hIcIE=
X-Google-Smtp-Source: AGHT+IHYXI7k8FR50B9CoPTckcH9hv4SqBYbTpgy5zHm0AFrV0lw0oCRl/vVEun8a9Rs9xoGEsK/zxZAm1QVsCdHSG4=
X-Received: by 2002:a05:6102:5111:b0:498:ef8d:8368 with SMTP id
 ada2fe7eead31-4a405782f37mr5525559137.13.1728221231905; Sun, 06 Oct 2024
 06:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <CAPig+cRePbX6OyE6WhFp1GEZenZyC7HFeA3188F_nErt7Gin6A@mail.gmail.com>
 <ZwJwsuf5ZOKiWbS1@ArchLinux> <CAPig+cTVf=W5KXkE2iTxCSPmZjOSbmf90J_JugDuTH_xudcW2g@mail.gmail.com>
 <CAPSxiM-bx7KdhP0OyajfiTczg-WqiJDPso1EAxLzntLqcuOUkA@mail.gmail.com> <ZwKKhzbeyQ5e_H9Q@ArchLinux>
In-Reply-To: <ZwKKhzbeyQ5e_H9Q@ArchLinux>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 6 Oct 2024 13:27:00 +0000
Message-ID: <CAPSxiM_+LCH04ZbTZm8oZWDc=Mz2JNJ_Uw7u+gO4e_ie4yPw5g@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status
 to pipes
To: shejialuo <shejialuo@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks very much Jialuo,

My understanding of this, kindly tell me if I am wrong.

1. Make a new commit for test_line_count on the same branch right ?
2. I should remove the "Outreachy][Patch v1]" in the first patch to
enhance the commit message right?

Thank you.

On Sun, Oct 6, 2024 at 1:02=E2=80=AFPM shejialuo <shejialuo@gmail.com> wrot=
e:
>
> On Sun, Oct 06, 2024 at 12:28:26PM +0000, Usman Akinyemi wrote:
> > I am a bit confused now, I am already working on converting the
> > test_line_count right now. Can I update the patch or do something
> > regarding the first patch ?
>
> Hi Usman:
>
> I have just scanned the review from Eric.
>
> > These days, instead of manually using `wc -l` and `test`, we would
> > instead write:
>
> >    grep ONCE output >actual &&
> >    test_line_count 1 actual
>
> > However, that sort of change is independent of the purpose of this
> > patch, so you probably should not make such a change in this patch. If
> > you're up to it, you could instead turn this into a two-patch series
> > in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
> > then patch [2/2] converts these cases to use test_line_count().
>
> If you decide to do this. As Eric has commented in [1], you should add a
> new commit (a new patch) followed by current patch to convert to the
> `test_line_count`. Then you should re-send the series to the mailing
> list. And thus you could enhance the commit message of the first patch.
> If you do not decide to do this (the current patch is enough for the
> microproject), you don't need to reroll for the minor things.
>
> So, you should never update the current patch for converting the test
> using `test_line_count`. Instead, create a new commit to do this. and
> BTW you could change the commit message of the first patch if you want.
>
> Thanks,
> Jialuo
>
> [1] https://lore.kernel.org/git/CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=
=3DHwdqQYFN9w@mail.gmail.com/
