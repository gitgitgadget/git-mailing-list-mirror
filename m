Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC11E505
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112019; cv=none; b=AIxDCRrV9qJbU4TrJKP+x5G9ZVxspAvZ3zx/yI24P2pnNXwFZYNDYr55Up7WEieQwgfxhEBfEaoc8ulYM7iLCklGz5ymNCcWbY7nPbgyq6rbtlo67c2BJXRn0Vjtb1xRJ22VgrxzNTN60Z1soyS15gHTwTkrI48asgEx/8xuEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112019; c=relaxed/simple;
	bh=ObKMIawMRgSu9v4QxlnoXzU6S/J1xGun/zI0m9ysOxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgeIqamcJGO9CPooQsE0F9ZSrFzN5L3SHXxavH9yk12CidCyNrGF4I4QdQtNo51dq9ObMpHalr3fIuKjP5oAz6vw3c+7KJsXXkuwaWyZaRrYI5R2x1Qz8GLHH759PBmzuZWWr7bDuBLT9gKg/Em5JccXw4js2Kn06h29t0Y5iIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGAQAanE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGAQAanE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so7028142e87.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741112016; x=1741716816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRfkX+OskmNwdeBR06/iuTYzDeCH5LEibzpGq49xmXk=;
        b=JGAQAanExOxGYRuhh4iDaReCwHaN81WKfkhUTlu/IdcLLzFUjwQ4YPd9wc4eJlTBUH
         2VEgPxXFz/Lr/e7phXBXS02xL65YzhQstmFgmVtDLpDMWJvo7xJTyO6iHdQSqf+3LNMC
         zwHkzBjD5pSYWYGFclXIoWh4amne7MQD8IvyW0++06n6oAuQ93ly5oxqSMuiwLpWFGxR
         tR6Diml/6QjMMpW5tTWaIEPbNRqehs+puSncix08SqljkikoHZcYwSBF0We6D6zByNw0
         UHMRTc/pmV86twgi5STN1g4l1vKl4i2VmZnABta/Oi29SEitKt2MfbC7Y6Yt4EUcTBQv
         pNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112016; x=1741716816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRfkX+OskmNwdeBR06/iuTYzDeCH5LEibzpGq49xmXk=;
        b=j7tRkn43ys5Pip4KjVSP7c2QatiElqjT/TUUw+KmaLtM0nO06oLwnlyaop94+sRd50
         go4VbfSU5YO7GBmnb0HprDmL3WuZYdCMWeZkN/yLwCwmpL8UcdvdIjn7JDlfCeChMTGO
         P8ZvOaRhU+TBvVNhLdfVvijw+vLVkUzj5k74PckYcmZaTySjZXbsUenqCvddl3NeslBf
         W5z9WhRhzbNgMV+KDSdxvzZ0MK6tOi08EHg7Td5/5B/D3FNLRWIR4mPSOwBqh6tNhgZ0
         WEZCpOESJjUTya2b45WPOwmftO8/pBWwtPDe+pETWdRPzzv9f8Aj25fLTXAGZBaM0NZQ
         6bkA==
X-Gm-Message-State: AOJu0YzNmdtFtA2HiSr9HPIKUYMgFdi1qIFfko2iCPoUyDwuMiGpZeFq
	fw+C3PCPlUmFMirWceCYK0a9KZciODDNhN62xAASwXGvh9iQwtklE11E4HDDb4C1e8IZce6qnRI
	uRhLeIPVpaVSbqkSe1GuzOWEMhc72RCSpV4dK3A==
X-Gm-Gg: ASbGncs47tFYL7y/mATavMxsr6H1vcAgfhJR8Zq5ujADXMRK9aY00Q4gMN0o9wGV8UG
	M6AShnAfjyQGaTPMPADxVdY9/csTW0S1D5uQPzSlRglt8gv8m8//0MMMqmmUJyr/nQeNIwXDvjS
	G3m9lq4kwmVHjLqcUhAZ0RBLAgL5inW9atcnmrUydWrRnCwnptsv9wdpuU5g==
X-Google-Smtp-Source: AGHT+IHikkREHbeeCm2JkFgyRBejE9mEiPdKv60krZsrexhKnqxupe8GkKFs0ysTlKYfdqftSg7ubxuhEhpCb0YPKzg=
X-Received: by 2002:a05:6512:1596:b0:549:74a7:12d6 with SMTP id
 2adb3069b0e04-5497d357da3mr48786e87.26.1741112015792; Tue, 04 Mar 2025
 10:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
 <20250304094153.28959-1-danimahendra0904@gmail.com> <20250304094153.28959-2-danimahendra0904@gmail.com>
 <xmqqv7sopt7o.fsf@gitster.g> <xmqqo6ygpt5i.fsf@gitster.g>
In-Reply-To: <xmqqo6ygpt5i.fsf@gitster.g>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 23:43:23 +0530
X-Gm-Features: AQ5f1Jocq4jmDUXqVBxWvUrQBdDnLJdKA4QZLXyvoL5ilBb656eJpyG4-3qk5nM
Message-ID: <CABGrwBBcg9DnPHtDG=OjQWJKWJy1mD26xXm7r5W80GNBgqFa-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] t1403: verify that path exists and is a file
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Mahendra Dani <danimahendra0904@gmail.com> writes:
> >
> >> test -e does not provide a nice error message when
> >> we hit test failures, so use test_path_exists() instead
> >> and verify that if the path exists then it is a file using test_path_i=
s_file().
> >>
> >> Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> >> ---
> >>  t/t1403-show-ref.sh | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> >> index 9d698b3cc3..4afde01a29 100755
> >> --- a/t/t1403-show-ref.sh
> >> +++ b/t/t1403-show-ref.sh
> >> @@ -196,7 +196,8 @@ test_expect_success 'show-ref --verify with dangli=
ng ref' '
> >>
> >>      remove_object() {
> >>              file=3D$(sha1_file "$*") &&
> >> -            test -e "$file" &&
> >> +            test_path_exists "$file" &&
> >> +            test_path_is_file "$file" &&
> >>              rm -f "$file"
> >>      } &&
> >
> > Makes sense.  Will queue.
>
> No, no, no.  test_is_file alone is sufficient---if the thing does
> not exist, it would not be a file anyway ;-)
>

Yes, it was pointed out by Patrick in [1], that `test_path_is_file()`
alone is sufficient. Hence I removed the `test_path_exists()` check in
patch v4 [2].

[References]
1. https://lore.kernel.org/git/Z8bd3iHrhXb4WH6A@pks.im/
2. https://lore.kernel.org/git/20250304112728.41228-2-danimahendra0904@gmai=
l.com/
