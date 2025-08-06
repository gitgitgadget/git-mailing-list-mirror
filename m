Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB21A3166
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 17:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501311; cv=none; b=L6BEgnssp+ChY+2ZrqVtTzQoVNdXkZFnmtQ3cTv7rnXrQea//dEbaqpmclkMW3LqoaFDSieDZuo3mKJBfNNF4lKCBEDOZYghIlWgYY1X94JKEvl+/1C00KBU6+oKPcNdJMLwyD8MR2ugmGKOVvmXdyUAnHeCl5Q0NSza9t6iQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501311; c=relaxed/simple;
	bh=s7QT13abeB2AE0+Hp5mgiRRsvIv/g5LO4pWu8Mst6dM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nrxA0pLmCVLfGTadI7Ey+cp3Y1V8JquNi9lFlFeQhjsP3Nr4EYVNB9WISYYG2+KRKBxqmL22t3SUTXkJLQp2ulyGw8vyjDrZ9ks1NJaT/D0Wvf/O6ml+18EZNKdefaXHnuID/8lL/2f4QIKgCQ9xJuKlr2W38mCWjkXItWh6b2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx8tVvV6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx8tVvV6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b428dd79d46so42383a12.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754501309; x=1755106109; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g87zcHvZ+LA6kiuYrBpo5lJSjf0MKUZxsN3tqGfLMRI=;
        b=Nx8tVvV63wyQy0wZ6KOKmJ2az6dTQUOLWGCTI3ghCMTHbjIha/RpvQyVLcJUgbfEhF
         8WToUx+25+Ffwg1xFsy/TzpSMkwYya0T2kHERFs4b+2GZhEm700uYJ1u2Po8q23vU2+r
         DYVkvuqKnqoen6f/lQ6uxcOjWUh81BZbHKLyfMduZJxaeOPuLmolZ9NbRa5rY2mA0DKD
         Q8LaDPwfkc+/AFFRggUtwBf5ShTzt3mTWiUmimmH0MmWMAyowPePhJwD07SRxAW52yZR
         6GaKf/H3Cvuvvuf+cFjWqVAuS+JC5BTI/gKh32Zrr1lyeDHRgakpVs2b0ZR5YLErtgxi
         A2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754501309; x=1755106109;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g87zcHvZ+LA6kiuYrBpo5lJSjf0MKUZxsN3tqGfLMRI=;
        b=RJvTjSfivpsuIrHOlOlXkfM9MTUzfYkwqLRQtMZ8iAkMipkR/LUSAkR0OaIylAein4
         o7ROculWToE9dafxoednYUEi+0+9HXi9mBfk3i/+/8lTukWA0Au3AuJ10zBxz6DcRinr
         D+mqzHN9miGtJ25pEbt/hb5AIM7q1VJbsf/hoqua96UlRThl0q+tD+qLuPW44Kqvz15W
         o1hUfj15FMxmwmPsznbkstq+kEN0waB/2wNDo5dHf1pghkUWw2V4IaZBBo5mPYpouJlY
         abKIG0Md9qWDPSfDa6/mXDLZIQ0rrRyft95iPXVwhmEXyLORpxQhqojVYfTJ/iW7BvFL
         n0HA==
X-Forwarded-Encrypted: i=1; AJvYcCUycLrdrdFg/d7GPLbBDveVu5LvJNtJR0XjUi72iqX8z1oo5FkUCTAwHhqqJkQ3PqSfC3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkwJv16SW3y8GzjW63cqA+zUf8QW7cnxlduuvUKcI3J2Vulfz
	0xqm+H9m3ZB56N47kbgcBq7K5XywaQRYb2qLnIHoP8ScmkyuKYmPr4A3
X-Gm-Gg: ASbGncsBpmMjBpjylhZvjBj7iHz6buGejtuJiBtVwIFh+kadzKQMOLQxehA7BhUH9IW
	ewcrAXtsagFoZbjBjngewH7SrbbSXxl4bBG/IU7leL0Im513ZcE8aq6+hDFD6VqcEjEf5QqW0GB
	sHFzPMt6p6Z36XyIuLDphfvYPdfwDMcTzlU5pCUbDighL1r0AFOmN+Ck7RFbqnEHKiH26HjbwVB
	srcYG7scMH6awDDuVi91o1vcqsUILIIAQzRic3KBibZ4eQAA0AWgzVsJJfludTYETKvy4Ls21Ba
	YJH3JVt8JV/j5Ct8FbMw4MFQ4rdBB+LN1gtPAQqAjjGKQp8iX6Jf7pR/3ZsGSNJX7lcZ5oYaEuT
	MfTMMo4UPSAcRB1F1PW27eU/Gi6SOqAjxHOu0aTFB0h9NrrHDpt8FtjKy
X-Google-Smtp-Source: AGHT+IGLWzBg+MIgQQr3/2NOo2MdsbNyZlWIuajsz3u7bSf5X2rgUSiOB4AkyERxikXNJOFmDU8RCA==
X-Received: by 2002:a17:902:f552:b0:242:8a45:a95e with SMTP id d9443c01a7336-242a0aa6987mr48444185ad.15.1754501309170;
        Wed, 06 Aug 2025 10:28:29 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm162388395ad.69.2025.08.06.10.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Aug 2025 10:28:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqectpziz9.fsf@gitster.g>
Date: Wed, 6 Aug 2025 14:28:14 -0300
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB375D08-5178-4A7C-9538-DE4A7CDD1346@gmail.com>
References: <xmqqms8fbilv.fsf@gitster.g>
 <CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
 <xmqq4ium3w2x.fsf@gitster.g>
 <CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
 <CALnO6CASXHv_wwmAfn9tZ4D1qdJBgVKfLEQ9+LTEF9FJPiS0qQ@mail.gmail.com>
 <xmqqectpziz9.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


>=20
> When I report a public CI failure, I'd try to give an exact URL, but
> otherwise the failure would have been seen in my local environment,
> and because I tend to refrain from pushing out a know-to-be-broken
> tree, it is unsurprising if 371c45b569 did not fail.
>=20
> That commit does not have lo/repo-info, I suspect.  I didn't know
> exactly which topic was causing

Yeah, I forgot to check the CI before I sent the last version. My bad,
I'm sorry for this. I'll be more careful next time.

> but the error was observed when
> "repo --help-all" was given, so perhaps some interactions between
> these two topics.

However, after merging my local repo-info-v7 onto 371c45b569 in my local
environment, I can execute `git repo --help-all` without any errors. I
also pushed this merge to GitHub [1], the only fails were directly =
related
to my branch (some tests that I wrote and some leaks).

[1] =
https://github.com/lucasoshiro/git/actions/runs/16759427895/job/4745054874=
0

