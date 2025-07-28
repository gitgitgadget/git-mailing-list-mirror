Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FC1EB5B
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732825; cv=none; b=es3Ar7OakVZZp2Q1C51YNjz+LoF0svarE+u3yFfOSWPoiqKcoo5SmTKlXJXF7T44i37rEKAmClzQj5ImhSOZidx1qEw3PUED8XpLdfVFZjTZjJ6255CASOqIsv9sQIOCmu3n+ZEKkTEft75HQxznSkX+lA9kWi3cqgyOoOV9yvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732825; c=relaxed/simple;
	bh=G9SfXPhEHURhnUkODB0ysCXy3WyejXxe1nd450OZLYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMm5KXxQT/mHMN0M3h4BVieY9eyowSL+hFvaHIejsMp8+IGG9xmenF3OmhKBckUHZtUtbjFInZIZufbug/LVfaPCRtQGHCMkXbcUbcKhdg0sFuciCZhAu2Rtqh1IkK0V7fruzm/OLcOYNYsHhwbIck4ggoAjUIHCJdjYKL42t7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNBWlbX9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNBWlbX9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23602481460so49096675ad.0
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753732823; x=1754337623; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkYdOhOY80ca9BPMAMZK+oSHuHujK/M1hbZWOSFKhT4=;
        b=hNBWlbX96VYcXMxAJo4Vm3n5w1wqxcClQV8OfiaJfEXLh96svCNAlSeHoqZI1Q+4Ua
         qE2L8awVppGwwUDReCO/XxT1NM2g6KGK8CnMaN8tqZJioxTt5c2pnc1em1iRWEz2bRw/
         tg+swPsc1Y6Ikqh5S6J/Q51T+CFzxWaZUOSc3tfnebSVG6gI6WwfReYR2Uc7SZqc0NZU
         j8tV/AcQ2VGb08Jpvqf+mgMhPjBQhMIQ8s0LPyvOePkcaQj2QlL/EJxF5IWg8brZT+6K
         o5ucA8ePWHbiJ74hLlcsYNI6mtdSn4UqWBC6C/XAFLMJPa6UpW4/UiraqunkWND6Ou/+
         owmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753732823; x=1754337623;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkYdOhOY80ca9BPMAMZK+oSHuHujK/M1hbZWOSFKhT4=;
        b=UpxNw93OCvQPJQg6NUxtZlckJB+YFwnvun1ru0kdM7pnvpx62l7Wx2PRqY0OmL9dk1
         ck80ZjMrVYoed/OiWMHlSVf7joZA4KlMsVx2eJ4Z2byod8ABUfefBRBj7fNPrmY9mGmj
         Rhx7QX9FnQlnjr7sluT6FehwtlgdAHlXc4UHdrOZFneqY2y1GunnLWEMgtG2QULZ8z8Q
         RCxjoKrbtmw2kIvwZRPVsoubppl6FlrpIrAyx48rVT4oEXAYezS92uOAKNpXuazGgbAP
         LszyU9juevVbJbJZw5AFNVQV+jArKo1KS3h0+ol4QbM4UNJUwujhSTBaxcEokMZqrt4A
         iFvA==
X-Forwarded-Encrypted: i=1; AJvYcCWkKEUgTW8nlweu5YWSACjGrr7Y9RXztt2fc754iELqG437gVwp2hoQ8ejZmNWdftgQK2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvtR8UCfiImcbL6wc1poffX59NVHo22WaJhzkN6I2+kcQK+Wc
	jNoRdb2IFNwCG2yq6H2Uz0HYt4xfRRv6cjdLep5PEp9fi+ixLoc1lEvqfv3stA==
X-Gm-Gg: ASbGncs3EkY63KULuWg97rYW+ilAyJUCc5if5ZLog1sdvj2Vw5MxBZ4WkfP4hjxhNHV
	cSU/ieLTdD7dtPlRFvdgrqRCuKESApy0xxBc0BrzyB7Vr3uyiLOGOBHOZzkwKwO0DUAUYVqynPs
	jKMqEtJ7fpAdsh4Mi8/i5+vgsiO9NhTdKD0XJru65KShz2eoy8Dn53lCeOHn9IiO4oOu9vbMuIb
	lEvylTyOA0Oh2I7/2aw0BeswCFtN8mMFgWc7KbRHIY+/eHc4S/35Nm1IYBJ/+xpHyJK88AMs9hj
	scD1Ib5wCqIFhp3I/zRB5K67O2QGr2WLOrentFCv6s7Xx3XcRHsRXOY6eo4P6EIlB8LLbPQZueZ
	3WgM=
X-Google-Smtp-Source: AGHT+IFmcCjRnzWxTu97YZXi3c5C51j57m/lhMq/p0ApLy/Qc07vOmslYL6kL20tjumNB5zk8Pg4BQ==
X-Received: by 2002:a17:902:ef4e:b0:240:b28:22a3 with SMTP id d9443c01a7336-2400b282b9amr99710245ad.29.1753732823337;
        Mon, 28 Jul 2025 13:00:23 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::e9a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24025f5a3cesm29051425ad.72.2025.07.28.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:00:22 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
In-Reply-To: <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
	<91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
	<CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
Date: Mon, 28 Jul 2025 13:00:21 -0700
Message-ID: <87ecu0nl0q.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> Rust defines char as 32 bits. C treats char as signed 8 bits. What git
> really means by char* is treat everything like a byte string, and u8
> is how raw bytes are handled in Rust.

Minor correction, but the C standard leaves the signedness of 'char' up
to the implementation. Portable code must be written to assume a plain
'char' can be signed or unsigned.

Using the test program below:

    #include <stdio.h>
    #define TYPE_SIGNED(t) (! ((t) 0 < (t) -1))
    int
    main (void)
    {
      printf ("%d\n", TYPE_SIGNED (char));
      return 0;
    }

On GNU/Linux x86_64:

    $ ./a.out 
    1

On GNU/Linux aarch64:

    $ ./a.out 
    0

Collin
