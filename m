Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED91547D2
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335442; cv=none; b=mvxvA0X/jQbA1wpA2wljTmuqQuFqTiSXzPQ/s2pg5u5jFbUGXTUkqZxpiQN4WqU5px1rKq7dvXrR7j+sHf+LdkFn4RzcPAgD8RjrXoHFYIDhCEgRKK1vvLJF+ILdpT/DviKtF0BIfxWVGYB3AzMn/6p/RMCo3YHe3KcZkDemw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335442; c=relaxed/simple;
	bh=7eYrGONTVllRujyOaMu9OfIYxrpB0gZVuG67d/bjaWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETcge4vPzun+tb8nNFp9gD3qo712dryD/r95NqYEoLBNtzk/Sui6GvS1c07ufD4VvhDxFmQ8eFijwhXDp0xHxV8ph4vX6eFc9IpwGwTi7BWAXyOPZCFJPzH/4gfOxS1Chb7MDtrJY13ZCdXcsxnh7jarZPBKXO0adxZlWwX2XFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew/hdhPo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew/hdhPo"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e3ea9e8154so22573835ab.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754335440; x=1754940240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrfB95BaBLa2IzFum5K5ORjVAF6W7xoOi5AFRz5caIU=;
        b=Ew/hdhPouh/0pAVhqStBq6euWy9UV+SmbmOEP68INC/5ZEtacKHn94VP/kivp/7tWq
         TvqReebGRckKtpNtv6rPx1dSeypE+NetqFGuKmCPiP6r97NSXD5QiCEHWzhEyMutPsVW
         npQvua4QqrH4CErU+FqPhNMtdRRO+XszqrLmeVGpluKFHzFz2uBEkzGDxWC+hw1CUipt
         9OHxVsprvPT/V9eBvIGu+JQmKPZrBIF2Xn2j6+pZz4VxvCAOQWp59tWCJZ5155hbwz0O
         9b+z9/WxAF7hIxKqgVprychHOVGpm7ZEjk1O2+eaTIvBmsstAxrD5dR4K4JDzeBQS6Gs
         ljgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335440; x=1754940240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrfB95BaBLa2IzFum5K5ORjVAF6W7xoOi5AFRz5caIU=;
        b=wJTG6n4LzM6PgYYejaBZhSj9sQUmRjkBvll4V++O/vCEysqaoihgXZ5NoQerSFdsRw
         3ssppaqIb/UvVzBv8pmSKeEN0SLfWSwH7IfaZHmtFI+mPrDuBt+f3FE/cwPwkx6cvrnD
         xpJoRUsb5OfE85FvZzoZIn38zueTDlEhc99Ww3v1Ibyx5+n527wMrG1k5bqKtuxqeKxq
         l8pAwdGWy7FU/pdhrLtXouE2jXUNV9olfIWpK2IIOb2csgacx8AK/iRxnkEUUMcpZYXn
         TZmx/GItBGQrJw/6bzMZfy1A1wboYUlSGh22N67FIAkZxRUDe8j9BSNQmqoQVLbmLZ7M
         /WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9I3Ypgc9LJX4fBciinABx2vTx+qOfv226XdWuCLnMVLxgkbksijlNFGotNtesi6xHcxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jbuez3VNwlpHaH79SZtZIort1vHk6yHf8+XmEsQU0af1Z7O6
	hL95TieYcCCs013zLUR0ZCikt64bE3NcJXcWFfhMdbV8UOzpDNskQxyRijVm+g5h9rjNBmDi6OX
	cgsmdtkFeBAYAKp3OQrt47R5XfqJoCZk=
X-Gm-Gg: ASbGncsqBXHQpkN7emFvQXFojBna35am31EkXGePCq5UrDjrICQiepzXQZ915SVPl5h
	BldGmmeUhl+2znpT4ioJSql+uVoLhmF6CoahY83ltnQyLw5j/WQ5Uo/ChnErQr6ys1mIFHzAW0+
	UD40f3MtfRpWNPxu8liwwG5fjzDlJVaGE4Z4alROd5bxmduOxU7+B/KU1Baqmya8DGgSEjPghef
	Z95EdcxfUHTBe4Bbrepa87DT2T3QkkAiu8lcg==
X-Google-Smtp-Source: AGHT+IEWhpTo153CXZedZ1vm+p9WjO/nor4ZcgtzQbT0c5/Rbg8ia8qC6YMSPOFRmgEv/x1X4yNP0Bz6rT+NmdI0mYQ=
X-Received: by 2002:a05:6e02:330e:b0:3e3:d5d2:23e4 with SMTP id
 e9e14a558f8ab-3e41615b809mr192173305ab.13.1754335440147; Mon, 04 Aug 2025
 12:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>
 <aIx7Qp_epPOpk8OF@pks.im>
In-Reply-To: <aIx7Qp_epPOpk8OF@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 4 Aug 2025 12:23:49 -0700
X-Gm-Features: Ac12FXyJHddRXq5LSc7ExtAKyVUmCw5e3_x5zopEgiqHzLQJHMKX8a5kHQMFrq0
Message-ID: <CABPp-BF36TtAaqbV01m82Cj_7Mr23P1DEuSTR7oM9odLbD9q5g@mail.gmail.com>
Subject: Re: [PATCH 4/6] t6423: fix missed staging of file in testcases 12i,12j,12k
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 22, 2025 at 03:23:09PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 806f83287f8d (t6423: test directory renames causing
> > rename-to-self, 2021-06-30) introduced testcase 12i-12k but omitted
> > staging one of the files and copy-pasted that mistake to the other
> > tests.  This means the merge runs with an unstaged change, even though
> > that isn't related to what is being tested and makes the test look more
> > complicated than it is.
> >
> > The cover letter for the series associated with the above commit noted
>
> It might be a good idea to provide the message ID of that cover letter.

Sounds like a good idea; will do.

> > diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename=
-directories.sh
> > index 69de7a3b84af..c2032eb6cfa1 100755
> > --- a/t/t6423-merge-rename-directories.sh
> > +++ b/t/t6423-merge-rename-directories.sh
> > @@ -5114,7 +5117,7 @@ test_expect_failure '12n: Directory rename transi=
tively makes rename back to sel
> >               grep "CONFLICT (file location).*should perhaps be moved" =
out &&
> >
> >               # Should have 1 entry for hello, and 1 for world
> > -             test_stdout_line_count =3D 2 git ls-files -s &&
> > +             test_stdout_line_count =3D 3 git ls-files -s &&
> >               test_stdout_line_count =3D 1 git ls-files -s hello &&
> >               test_stdout_line_count =3D 2 git ls-files -s world
> >       )
>
> Should we also explicitly check `git ls-files -s baz`?

Why?  There was no baz in this testcase -- not only did it not appear
in the final commit, it didn't appear in either branch being merged
nor anywhere in the entire history of the repository.  Testcases
12{i,j,k} all had such a file, but testcase 12n does not.
