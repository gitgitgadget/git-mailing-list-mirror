Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9B4EB45
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947760; cv=none; b=axMsw9uUttAxr6Wc7/J/Yr7ByIcOLN3levnWBghgxjd6OkEyrZS1ZmE13LNzOou7fv5GmYJE9LpykM7wVPxJQOaVuRQCvoAZi2ypU3TrYN7lNLuCNxWHzPpsi+U6IWTo3FRWHj2veD5CMGIkU2ceovOqnp9AOQ0/a7cbiA6bATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947760; c=relaxed/simple;
	bh=MYhzzM/8E76yO12kD6gxwJPqGy9mnl43UEeh9sR1TQw=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=Gkqo/Uhk5X0JoWyuCCunT/ZiF62yBClD09FkDy3GQju1UhJzdvOPRrbJk03BGlaU0LUNHi/rBR5dznkLtrwQOFDKqQ1MYaPOUEYbPcH8CJesCe9IBw2jmxPCzmpVjmIoGInq9VV09NY8TJaYBsgdYlHxiY0b3hMxYn+Z/UJCH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzPzqxg4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzPzqxg4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430ca04b09bso25008781cf.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947758; x=1711552558; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGLmV+BN+HSCaA7QkFXACJBx+SjSxJsuc5+zStOSokc=;
        b=GzPzqxg4eynWPcor6KED5OxlSNtd5jqokE05v23GZDqWmZOX6NKq4XGiJcdRXernlb
         qSlq1oWCkJy5Jo5w+5y5hnQiVrnRTgOQSR6+u3u2ngku94fxIut6E3qGrxifU7AepEB7
         jQVY/wWp5XK33YnSZeuDlt9JF+sv032yET7pwOsmqxumNT4r0aVjscX8kFUnmOh8hf5F
         agsNCkGA/O8YDnMo4VUq8XXLTaKNv5byjiBAvRsx2dkuPYgs5nXRQCZqZayhyKUXUvc8
         NWfSobWjyDLCsZaWvxO9YEKuAlbqBRdrXCQczUmGc2ioQl5RteITPiBNhaJhqyETVwsj
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947758; x=1711552558;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGLmV+BN+HSCaA7QkFXACJBx+SjSxJsuc5+zStOSokc=;
        b=mcyY9JmlYPGYPDkdNriYooVwVqe1P/GZ3ZKsaf5pX+0kp1RxWl1o7d5pEG1T+xO/7J
         BumfXbxWcHy2jfa9L7RSnySQlnhQGJTsbspHhBmIp0T9a+ig3xeaC+ocWSI4eJJ75w5M
         ngpnzAulCuygfxwZb3W6UpAoOhNc6QT1LIMwjZnANjALqtQEEq9/jMAjvjFbEBChU9ge
         MZSI6LpnbdiK49w03Yfeymftd7RwO7h5jvK1OyxrVV5lhm8H4YFNwrVh3aJVLE4k1Xbs
         4AUV6LGTfqhR9LV94qHyUD57g2GnSrtCBtbQTzii3bzIWRAIiP1BHqWwU7nTGRA4am/k
         iUag==
X-Gm-Message-State: AOJu0YyKOUuL3CQ9ZvE2LioSzDewDFJD38FMd2aEoq77w5J+ZKw0qIgW
	xQnL8X7UhJa+/8b9YH852+zqCFHxXemOQ0oChVdBV90yEYXUk/yIdo0/R1pE
X-Google-Smtp-Source: AGHT+IEul477mqqL1I4M0iSy5KHnqZYvUvkU7WeWrGS1ZDAt8elwMtV4l50qddjcMdj74PF4A7l8iQ==
X-Received: by 2002:a05:622a:81:b0:430:ecb0:545b with SMTP id o1-20020a05622a008100b00430ecb0545bmr5063379qtw.20.1710947757837;
        Wed, 20 Mar 2024 08:15:57 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id jx1-20020a05622a810100b00430a6fe5867sm7058139qtb.88.2024.03.20.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqil1iqi37.fsf@gitster.g>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
Message-ID: <17be81eb83ff314d.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Wed, 20 Mar 2024 15:15:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

> * bl/cherry-pick-empty (2024-03-11) 7 commits
>  - cherry-pick: add `--empty` for more robust redundant commit handling
>  - cherry-pick: enforce `--keep-redundant-commits` incompatibility
>  - sequencer: do not require `allow_empty` for redundant commit options
>  - sequencer: treat error reading HEAD as unborn branch
>  - rebase: update `--empty=3Dask` to `--empty=3Dstop`
>  - docs: clean up `--empty` formatting in git-rebase(1) and git-am (1)
>  - docs: address inaccurate `--empty` default with `--exec`
>=20
>  "cherry-pick" told to keep redundant commits needs to be allowed to
>  create empty commits to do its job, but it required the user to
>  give the --allow-empty option, which was unnecessary.  Its UI has
>  also been tweaked a bit.

Note that the description here is a little out-of-date; we're no longer
changing the relationship between --allow-empty and
--keep-redundant-commits (and the user didn't have to manually supply
--allow-empty previously). I'd summarize this as:

	Allow git-cherry-pick(1) to automatically drop redundant commits via
	a new `--empty` option, similar to the `--empty` options for
	git-rebase(1) and git-am(1). Includes a soft deprecation of
	`--keep-redundant-commits` as well as some related docs changes and
	sequencer code cleanup.

>  Comments?
>  source: <20240119060721.3734775-2-brianmlyles@gmail.com>

You can expect a v4 reroll tonight to address a few remaining comments.
The only thing I haven't heard back on is this change [1] to the docs
for the new `--empty` option, but I'm confident enough in my proposed
alternative there that I'm comfortable rerolling even if I don't hear
back today.

[1]: https://lore.kernel.org/git/CAHPHrSfiMbU55K2=3D8+hJZy1cMSRbYM77pCK8BdcA=
PHLvapHO_A@mail.gmail.com/

--=20
Thank you,
Brian Lyles
