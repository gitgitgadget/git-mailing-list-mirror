Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48988298991
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888186; cv=none; b=qYGErCkSGmonDoxRvZXtRYHZmxQFxcKv5Wu8hmbf92KBCWv19jJGMMpJCWfT1dUwQKMEVjEuwW8Yv5MAENOX8ua+pBev3JC8/GsVXvnX/8GxdmondeC/Ee5wnmpH3TSgwD3j3ib80HBOyT0RSiJsfX+93mj0bwYcbViyE5Xv1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888186; c=relaxed/simple;
	bh=MrLxuNtKszMee/6rHuoGOXcRpe6KIfGTFGOD7cKN0J0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ch/Ta2seidCiftvhAyLRSdtVWq88DOx1HYPbY2ox9otcHpyXo5uPvLdlTu/CRTyu8eVUSNrD4E5ZnjpDA/GyDKovwWR+Q0FjJjW4O1ND90/CgAnikp5Olciwxe4CpTRWb8eJmtbCZP9G6VeNaoVh5ij0J/zqH5+UGXQx08Bcyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvsIEnRV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvsIEnRV"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-793021f348fso1158655b3a.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 18:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759888184; x=1760492984; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dauEphiJbb0Ah2UxlQV/qeCH03MnbaLDSHEatmMrjWc=;
        b=TvsIEnRVTv655DYaNi6uiAQHJeyhKft/f4Ld6WWeuYwkcWJjri52P7jAOlrlMneX9i
         UdQL1sbBd2NehPQymdH/PRXtrn98pJQ8lnV6iUhNBWOAlO6RyVBs6hSEKTtf/Po6EsJM
         7mEawdHGFq9MRuIE22c40wiYaHEE56X2YHg5/zJ5Rw9iOnB7RJj0DRKgmxLG+F7QCepy
         FN192zt2pbkONI4BhqucCCbxqIdjqt5RecBvjPLiMpclyYsVy2tIcrv9nxQCxMVHgvXd
         AA04hK/sM/UoH0nCymQoXJUr7p/+sZvcrEdAqGWkdwqgxJkW/rXCjLstwRlKfQICug90
         NtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759888184; x=1760492984;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dauEphiJbb0Ah2UxlQV/qeCH03MnbaLDSHEatmMrjWc=;
        b=Pw/naH9/K0eNBl6MspdbmoUVLMcZQgtdFEW9kzgXH45Qcz/+y4K1Ltap33BeW5RvBI
         8OW/YMnqBVzginh6KEKs218uJMvcdFbX1FmBdhGi+c2UIxpwQ9RFidDF9Vc1BTKY+hwM
         Jpvr+PTWSJbFcwkhQ4n1iDlTj/8PtDc2ZO3H+HZOPs4mzzhcf5zOubLKh5p6/QkbH/9x
         EPv3B1gs14+zHv0aaKUlIlpCWT8NTvqF9PjIl0UduwwgYY/ET0Jy/O23XcDknSjnyUhH
         YgJxnmhVoqzK5u/89SfrrSaNnIBJnW7h+twM0z7XbOYS5iYNS1/VSsoCnKS9IPHjZ56t
         9vcA==
X-Forwarded-Encrypted: i=1; AJvYcCWmHflnGxEzA9788LvDC5rnMKfs1M4vNijg7OGMCLd4MuPz1vqcuZW3oThzK2kaGHZX0LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKd3v/FHlVPDJVp63ZionW6LPOVkY7Ua3gFkd4f+zHCLSf2Jr
	FDxcf0Z/HHVItt/HFsJDfHrc0ed2tjOnRyMnUK+zE9nMsikjv5VHc6Y5
X-Gm-Gg: ASbGncsLhvcbBp7KGq6GemTttE83RB08bYjdZNACB1ynQ5mQzbSX1FiC8KnzDPItUde
	0jQu51jSb6sQYRxUw2tiBTzGuP6Kt5nl9ZzSIiXOrQTYID7zy/g7Ny4mlpeU6A7fvduotkdug+5
	IYnYElStmnD6HmTgykmqdI0OXkQvn8ziyxKVigIMdAE84TOeiY8T4E7CNezwX9p90eGk7B119U0
	ZOxsISi5wBJSp1Fe/6F+pcrU5hkVh8tZf99dgssWqomzHoY8GGlypPxHGwaWuGPxtxAxyUsNKbQ
	ngN6raNyQrKwITivHxltUT3HuallwqkVHeOITKr3mOYtLwTDCDy7swjbuMAB7zrugHL7T9ALS2F
	biQJpttquLcKGRx8G58R9lY0xKySc
X-Google-Smtp-Source: AGHT+IGeRqokivJdrCpTRH6gJ6bcuXbJsr3/cgNZ6YRljPfND2k9hKTkjL89y/uUcgZ0Wh1KVXaGNg==
X-Received: by 2002:a17:902:d584:b0:269:6e73:b90a with SMTP id d9443c01a7336-290272aeebemr23221635ad.15.1759888184395;
        Tue, 07 Oct 2025 18:49:44 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::55b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1eee04sm175330315ad.130.2025.10.07.18.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:49:43 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,  Karthik Nayak <karthik.188@gmail.com>,
  shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding
 with "exact_match" parameter
In-Reply-To: <xmqqwm5om1gy.fsf@gitster.g>
References: <aMp8yNFiXDyk2hP4@ArchLinux> <aMp9OtXLfRw7dEwA@ArchLinux>
	<CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
	<xmqq348dovi3.fsf@gitster.g>
	<20250924053601.GC1173044@coredump.intra.peff.net>
	<xmqqwm5om1gy.fsf@gitster.g>
Date: Tue, 07 Oct 2025 18:49:42 -0700
Message-ID: <87jz16dux5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I agree that size_t is much more than one needs for counting most
>> things. But the problem is that "int" is much too small, if you are
>> worried about malicious input causing integer overflows that could cause
>> memory access errors.
>
> Well, a malicious input can cause overflow/wraparound size_t while
> parsing, so I do not think that is really an argument.
>
> The code need to be protected against such overflows either way.

Apologies for jumping into this thread so long after it happened, but I
wanted to voice my agreement with Junio here and mention another
consideration.

In GNU Coreutils and Gnulib we often use 'idx_t', which is a typedef to
the standard signed type 'ptrdiff_t', when we refer to allocation of
objects or indexes.

The rational is written in the header file where it is defined [1].
However, I want to highlight one part that I find most useful:

     * Security: Signed types can be checked for overflow via
       '-fsanitize=undefined', but unsigned types cannot.

On common platforms, you will never need to allocate more memory than
PTRDIFF_MAX anyways:

    $ numfmt --to=iec-i `echo $(((1 << 63) - 1))`
    8.0Ei

I think that addresses Jeff's point that 'int' is too small, which I
agree with.

In C23 it is also easy to do wraparound arithmetic on signed integers if
you want to. Here is an example:

    $ cat main.c 
    #include <stdio.h>
    #include <inttypes.h>
    #include <stddef.h>
    #include <stdckdint.h>
    int
    main (void)
    {
      ptrdiff_t value = PTRDIFF_MAX;
      if (! ckd_add (&value, value, 1))
        printf ("No overflow\n");
      else
        {
          /* Or handle overflow.  */
          printf ("%td\n", value);
          printf ("%td\n", PTRDIFF_MIN);
        }
      return 0;
    }
    $ gcc -std=gnu23 main.c 
    $ ./a.out 
    -9223372036854775808
    -9223372036854775808

Paul Eggert wrote some macros to implement these on old compilers which
is very helpful [2] [3]. They only assume that signed integers are two's
complement without padding bits (I would hope that git doesn't have to
support anything else...).

Collin

[1] https://github.com/coreutils/gnulib/blob/master/lib/idx.h
[2] https://github.com/coreutils/gnulib/blob/master/lib/intprops.h
[3] https://github.com/coreutils/gnulib/blob/master/lib/stdckdint.in.h
