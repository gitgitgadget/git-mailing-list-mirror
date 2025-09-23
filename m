Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70333203AF
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620634; cv=none; b=kIZmAhi/3ReGPGmWA+5n7jiJmyXlW+P5bzJxKmXiNFPGOdu9zQ2fMo+1SgJ9xHSQst0isrFm8p3GW2Df5EJITztnvKPkvG/UlEYC1MPv7Ug6xFx8tUWRV6AXi2ghvB7Dr5MSaKvIMyZK7irislQC9Stq/BPDIas1/4eRriP6wj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620634; c=relaxed/simple;
	bh=PqO8aVQn/mk1wnwaEh9yL0nuJtrHf70zR6S2XrSgnwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHemC9iHGME5Qrn4PCHLi9rofH6JinFKcZaIjtpJUgzMdZwa+eM5DtgweCpQNUVIcuVvYxFwTl3lDbMaf8n2uq6/GvVc8wNkK3g3Rd3Ta7UYnq68OhTpeFifHlKPa/mpXJDb2LaiwWLzE2AM6Et9xg5a42Aw90ENCUKGyc2b+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3eLSutH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3eLSutH"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so9344155a12.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620631; x=1759225431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlsRF/NLSlQGtkHXovX3MqeX5FqgvMHSWxCv9Ii7cbw=;
        b=J3eLSutHBFsj9T9lD9/mDgY7oCNRmmtzwEDu6rVyHMH6Gdcavc6muk2owfwAwR0BLN
         DMCwbr5trK9zR7tRLzyVkfpB+6bmBR/+lF12IdKDv1CQ1dn/i2+q57pDYnKvhykZ6KNu
         BjQYVXMEGIrwmQSoOsS1TrMVUW+nhA4D4xSTUaAQqzQ3yCXfaJsOVRVYSJMZQEScerHc
         O5pct4Cjs3HvqvbH5/tZSriXq7+NF2IkaKe9KrcUxF39tCEJ2wnf6SiEXT31eUQ+UgqO
         kzPtH7Q3mpfVG/9exm2ggM2RB6YwuECZjy681aquZxofSy2u9vqFNKDsi30dYE2D/Xkc
         5P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620631; x=1759225431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlsRF/NLSlQGtkHXovX3MqeX5FqgvMHSWxCv9Ii7cbw=;
        b=AqOLSkP7awOv/2CYRZM3us9ClbUkUKIFkAYqfL11OTkYfQO28z9AGIrWOJpSiI2ZBo
         PlRZ4k6wiTuKCeQXGjkCsuEFVMiawbRDpL4aboT3Ijdb40dwrtp77iNig5Vku1vIsd/8
         k5RL+ERb39z+t07eBjiWp/VpxmCDHO1wcXoQ4FdcZ1rNNuLeUGQ0BLdCmLrqaLJbEygr
         dq37NYMJ2Ga5kHMbim6abIUg+CPtFEDs7sToX9nfPN6gpJVjbjU/3durSt2Rqg7vxYYb
         QK1RjJo0SRLNqrr+vz9UeXwBEytShNSl0laO+e+HFqSzcuWkvdCEii/SXLSQJmh6ZJ7O
         YtKg==
X-Gm-Message-State: AOJu0YyCJK/c26dnWDusklgmPYcz8m0HCVIQTFPJcMo1o/jTKHodRYt0
	m7ojrUVz1XddcUtFWtqejw+hZjcphHOJvtWmOks/MN96eC/SfspPLOBh+rWPK/K+62GTqZsxFLy
	w5b2KD5OW3DjURglX8UEPhvkeXZ+n6xTQa/V0Gg8=
X-Gm-Gg: ASbGncvYMD9Cs4jz9VfXh0fAarG3K2JLhPSR5HIjhusd8tqoN4YnPuEqAjNDSV+db3G
	raVrGjo8C90ykkNr0+QTLeFKjdsUwxn/D03zmL8DIyi4B6/uo4o+9TPmizzJvHY7KdDGcX1huJe
	7vHoOTLtJy3peA8Sn0XzeIJCTa87TVA5dte6JMxtA+dy1+aQ8DQJk9rqIFK6CzshJcryYcniy5e
	9UK7xEGC6RB+4SgRdnDXFMSYJD3zHh1/DDCxkugEgiFY8NA
X-Google-Smtp-Source: AGHT+IH4nRsqUFltL15haNtPNER/xd+3iuzJeBG/kjLBHlEyjemvksIxew4wJBBzCY35FFi7po+nQb6FubpIJSYi7qA=
X-Received: by 2002:a05:6402:84f:b0:634:4b23:c9df with SMTP id
 4fb4d7f45d1cf-634677eab5emr1599315a12.18.1758620630983; Tue, 23 Sep 2025
 02:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
In-Reply-To: <4ea9cb1e-4367-4926-a9ba-0680dd63e616@velocifyer.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 23 Sep 2025 11:43:39 +0200
X-Gm-Features: AS18NWDGsXQGg2Cc4HAcldLghBg4m62NddOEK1OAyVhAEkS89j9lG_rfgzuqCns
Message-ID: <CAP8UFD2asXf_4_02khYRVWVQruBdvoMkZVE-6cVHttT9gHdWqw@mail.gmail.com>
Subject: Re: How do i get news of git releases
To: =?UTF-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW8J2Vow==?= <velocifyer@velocifyer.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:43=E2=80=AFPM =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=
=9D=F0=9D=95=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=
=F0=9D=95=A3
<velocifyer@velocifyer.com> wrote:
>
> How do i get changelogs for git in a convinent format (like email or RSS
> or Atom)?  I see that i can get changelogs in /Documentation/RelNotes/
> but then i have to check the folder manually instead of it being in my
> email and RSS and Atom client (Thunderbird).

Not sure it is what you need, but just in case, there is:

https://github.com/chriscool/getreleases

that we use to automatically generate release information that we
publish in our Git Rev News newsletter:

https://git.github.io/rev_news/archive/

You can use it like this:

$ ./get_releases.py --get "Git" --exact --since 2025-07-24
Getting releases for exactly "Git" since 2025-07-24

> Requesting https://lore.kernel.org/git/?q=3Dd%3A20250724..+%5BANNOUNCE%5D=
+Git
+ Git [2.51.0](https://lore.kernel.org/git/xmqqikikk1hr.fsf@gitster.g/),
[2.51.0-rc2](https://lore.kernel.org/git/xmqqh5ybcfwt.fsf@gitster.g/),
[2.51.0-rc1](https://lore.kernel.org/git/xmqqikizoybn.fsf@gitster.g/),
[2.51.0-rc0](https://lore.kernel.org/git/xmqqms8f5889.fsf@gitster.g/

The URL for each release points to the announcement email on the
mailing list archive. That email contains the release notes.
