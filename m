Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B230BF4F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726880; cv=none; b=N2LDIbkrOHrjGRtqusnUi5xEw2uGRLksIluJyJVUhH5GwkfLRBwZt/uvfNEqtYEMHF9oT5Ygcg3TAxyLWheqN4xap+RxFfVviFAP5qu9MooLxSaaPPYYSxzwP3KOLmS2QCpW2efX3ltnUDCF2wTZ7vTkdcSotY4cZU5uT/ZTFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726880; c=relaxed/simple;
	bh=TPnoKQvv56b5DBjiFA9offWb4M2BX+f6BBX4LX9THL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py6GCheXPEO495igBuLsRMfg24xQLt3v3SHlgwE+rXMqChkTNKL5QRFn9HebrqInwfFs1JAF5zRuxlb0JPYnY0PMgcYYNbHnL47wBHk7S9pNawjTpO/dD4t75NNrsX73luuQ4TogGQiLNVy6vTGjwxc8i1ZBqnx762ZgUuh9ygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSjyGkb/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSjyGkb/"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso41863711fa.0
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758726876; x=1759331676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPnoKQvv56b5DBjiFA9offWb4M2BX+f6BBX4LX9THL4=;
        b=PSjyGkb/iDVp1EFfG4GTfIWhJPur/By7w4oouATrjFXlr6Qgfdm+Swq8+cOdu0vF/z
         W/t5Ic9oovImShbxuWJ6DhhDxADcUAHYLFr0C8+oBjp/6rISH6+DACs4qCY32kuK3mlK
         V3wPUk+c/tTqoyrlpXwPpEQs9bs8Ixa5nZeYNug8Rx0Qb2I1h0Y64GIMcZyOStoAuftM
         BbkgMNnl+DsdjTh/z4UqC2eeJaQEKvM3QSFtqqH/2aJFcQry6WgbFbSxrnBhKUd5qAdZ
         6FWAu+iEAS4Ed6leQSymQ6fvdYpkQFLFZIfg3k+nyUdMZb5Ofzn0K0z23PFQIx1HYju5
         DJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726876; x=1759331676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPnoKQvv56b5DBjiFA9offWb4M2BX+f6BBX4LX9THL4=;
        b=HwlvgoqYfO6fPtHqgZI3UxeSfh4CrdOkZp78gndHRwfUkObV98OjoTp1rRil7Vc3TZ
         Qa8XVG/sU+UJ8/5Nr2zTbheEgPoBxjbwfzbJ3QmrHzb3zw6XTA89s/O6oW1PPWftrM4b
         nBSwDurrwNgzSzP0JSVeKhqUGqPtSRivwFd3Rxre1Y1Dl+6ZNn9XwaJBN1wfLuTn1d7g
         /iHMwpTjMgVX8PbY+ON/vIxsOcup8Bjpi4pJrQaSHyWowpiPlmuQljTettdNwXCTJyXM
         AQQiKSA/+M/7G2tRQOyL98kzZ7UnMggXR8v5+7tXqTFAJ/VwZKlXNn6z8ab6TUWpFZns
         uTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUujpMTT0Z07jQNzMgHZc/8xejP+DoKcGtZoh8xK53ryVm4CwwkCBte9DPn34E7zcTCTvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJ2++ePWk1LGm3JmmYUiU3UlULjirad5x/+u3UGK05jhfCsjC
	2wjccsukTlxj+GbseMI++OgpCgMtEd2knKyyAJcOtrcn17n39N3kMwPACapwld4layV4PwiDDG6
	KOPm9L73LISCTDE29Uf+ulltX3vTu0sJ07++qeo8=
X-Gm-Gg: ASbGncv9tBP0vSg3QCPjccDIEyIYWkGmfXP1eGHyTgjJ414pWKAmE3wHR/nOas3qqb8
	A5p2qJNKUQwVhRT7p9clhwtmkG5oBzuxA+7z0mjWeefHg+VBZ6Z4kxqUO3MP7+Io62RYPZuOoAT
	UJPyrHDX0/+zi2BZtTlUejWHXcNeKoaDAMFJgWMlAA3SsSkTYZahxXgwbSWaBKLqMUWfkRqH7Qi
	gjv65oF
X-Google-Smtp-Source: AGHT+IHwCOIVp9pBH9nwl5F4q1uE6iPPSvEvqzaaP8Og9SOUwYzjnQOCldXHGBzCjJC8uekCoKKZay/5e+F8/qG3qmw=
X-Received: by 2002:a05:651c:4391:10b0:333:e590:1bc9 with SMTP id
 38308e7fff4ca-36d170fa5ffmr15222431fa.24.1758726876177; Wed, 24 Sep 2025
 08:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <975e845bfa80fe838433f7f64759a72f6d565aea.1758662670.git.gitgitgadget@gmail.com>
 <a17e00fa-bf4b-4b53-817b-297236178101@gmail.com>
In-Reply-To: <a17e00fa-bf4b-4b53-817b-297236178101@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 09:14:24 -0600
X-Gm-Features: AS18NWDYHZqOq0Aus0USriXVuYVT7SJbnmUE6fFKcR6IHnE8A6aidJtkdmIajSg
Message-ID: <CAH=ZcbBzG+Ekzp-mE+MBDbU2PaP3qikyJJcgnh_G2+mOf67CWQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] xdiff: change type of xdfile_t.changed from char
 to bool
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > The only values possible for 'changed' is 1 and 0, which exactly maps
> > to a bool type. It might not look like this is the case because
> > matches1 and matches2 (which use to be dis1, and dis2) were also char
> > and were assigned numerical values within a few lines of 'changed'
> > (what used to be rchg).
> >
> > Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
> > for changed[k] makes it clear to future readers that these are
> > logically separate concepts.
>
> Nicely explained - I think this change is a very good idea and
> separating it out like this makes it much clearer what's going on
> compared to V4.

Thank you! It was obvious to me because I've been refactoring xdiff
for many months now, but I wasn't doing a good job of expressing why
these 2 concepts are closely related, but distinct.
