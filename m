Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37911C3BEB
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357168; cv=none; b=PG4L82zVZL1l7Xqbult9HLmcZdcnJif7/xHttyIyfCOucIg//oNMhmwCkpp976kG/P+ksIa8EYSWfmF2uQHU/Vb+gTqQS6rA2wyE6P47/4qYAqzmLJb2gzK+GVO2NYXo1JpmP6VAJJEu03KippRp7amkgGAyRRappX6269wLpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357168; c=relaxed/simple;
	bh=nZhjidLo9NLKMv5jc/kzyxCdZAn3eiZrHqtd4O69uxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVkUQxkP4MYgLIv5/kK/tHt/pC6aekPh0ZKy22g8IpcHcmTrOUeHGGH8STle9TQw9TsVR6uy3fgLmfYC0lEM48yKZUY+skN4kV1oJqc/+t677D4bWehpgnoW22qmeHDEGUMjmkwWuniff7I7fTvyDyuuHp8GuHynRiyCD1QFGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeFKd9fs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeFKd9fs"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983bae80so3470626a12.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357166; x=1768961966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZhjidLo9NLKMv5jc/kzyxCdZAn3eiZrHqtd4O69uxI=;
        b=UeFKd9fsVKewrLghEpcE0YA6lhVZc382Vf+5u/8LP2mALg7jHB3b0ilvLl+MOeZJ92
         D3fmXgu7KRN/WP3AogIgegHl1TdMQdqeRywpiqxh2NBdZboyybpUtYJCursNgqnnL53Y
         AaiSBZBcjK/3lmaQpcmSdJw4wIcEB1PZAY7oVWMr2P6twpl3+7dmGDAbbhYZV7NCjRUs
         YhfQ6lEhu4f1Vlva7RmZP7M5bAf+1ozydjYpPUc9RakZWgxGqIp7QswZBkg1pMfQ6kav
         HqNQVhlNz9n0MQqBXh4o9icIMA89Wa6ekka8Pmsp5ZXWGdWlX5DZ0mkWDkJdCQlYQ7Li
         jDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357166; x=1768961966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZhjidLo9NLKMv5jc/kzyxCdZAn3eiZrHqtd4O69uxI=;
        b=bMbuQsdkoLEBMT1A7bMWVwYxAvfXV8tCPkFW8G4pgYhQhreGfdLy4kKYVLIr3fBaeb
         OycK7AfnTE2J7qNXVTEaD7+nAKqhPHdCgFaVdI6zaW0u5w7SCY2HVLO3NgzxKuyWAsRm
         guylTWXpK+VrfiE6yA6C6xMTwds18KXbIUtj2CzpGVIl+/GreRMeuoTcfC0vrS3m9nmH
         exf8x5wIC/pXX6LwvW8VFeq4e+iqLcfVLFtb75UyQ5kSnZW8bwLeJQmDDhDvJ9ED+hgJ
         fw01LqN61yaUNcC8qxcHKbHJld4x8eaYwOMVvxEsOcNfzzjbBGlcHMxHzkDDoBBP8gaz
         hr3w==
X-Gm-Message-State: AOJu0YwFqPZqmOxtq6sZK1kNu80Oupd7XIWlt1TVB9YoxyarZB0jswY7
	RnkZrJpyClW5coXXCY+YFWrYzr1h2YgPbZhBV2mh3n3gYSJQAjMcBSLfNYXO2toG/gomSxjHZC9
	CPzuM/VAG589QOii6qKR96ni7LJc0giR/bg==
X-Gm-Gg: AY/fxX78bVC4ZiA7+Qk+2ZpLzOtZLQI0StNywrkyghZSLim/NDAlhDv4g+lXiB5N86H
	7YoH27s6AXAPu1kSZPxfoy3lNiiEUs+JlyR9KboQqBySosDSWHhNFHaxO5LmqGeodfQJjfXEgLZ
	/qUjaN+NASSaGf2GLQ5PzXqfumtwiCkjX+TuDIFqn6xTbhfrikJR4cG6M/xXVNBQ3nS6Q0/uXaU
	D+B/B5G72h3H3mlO6gqIiNr8dAiKB7YM5bAiALqAacD2QFxdANa/FrJj7VZYXot5yiS+LAH4NW8
	TA67d+mRsXmcMR5jNLiM3MyjZnjQpoETJeSdYbeErKwFDwb7I7rLrYrRgPFQKZSfJaPKSzFlHje
	V8m98hnVYUAbpoJw=
X-Received: by 2002:a17:90b:5705:b0:34c:4c6e:beb3 with SMTP id
 98e67ed59e1d1-351091290c5mr1070949a91.18.1768357166198; Tue, 13 Jan 2026
 18:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112213612.2761854-1-nasser.grainawi@oss.qualcomm.com>
 <7FB6BFD0-4C54-4924-851E-D4B5C574D7FC@gmail.com> <CAFcKa=_P8kUXvsuneQsoi=Bwbmc8U1kBv68fx4yq81vKBLkFEQ@mail.gmail.com>
In-Reply-To: <CAFcKa=_P8kUXvsuneQsoi=Bwbmc8U1kBv68fx4yq81vKBLkFEQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 13 Jan 2026 21:19:14 -0500
X-Gm-Features: AZwV_Qg7KTId8sLolkf5_nWVYo3i2HWin8_6Q9rdnOZlMSeKqHGSQsRI0Q309Yk
Message-ID: <CALnO6CAVup7AeOyUu4Qt9onD77c+GWsWJ1o5NVDtymGhwuE7XQ@mail.gmail.com>
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 5:41=E2=80=AFPM Nasser Grainawi
<nasser.grainawi@oss.qualcomm.com> wrote:
> On Tue, Jan 13, 2026 at 2:51=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> > > Le 12 janv. 2026 =C3=A0 16:36, Nasser Grainawi <nasser.grainawi@oss.q=
ualcomm.com> a =C3=A9crit :
> > >
> > > =EF=BB=BFWhen be76c2128234d94b47f7087152ee55d08bb65d88 added support =
for fetching
> > > a missing submodule object by id, it
> >
> > Convention is to refer to published commits using the =E2=80=9Creferenc=
e=E2=80=9D format supported by git log and git show :)
>
> Oh, thanks for pointing that out! I missed it in the SubmittingPatches
> doc. If I end up sending a v2 I'll include the update, but I assume
> that alone isn't worth sending a new patch for?
>
> If it helps to have it here, the corrected first paragraph should be:
>
> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".

Thanks. That should be sufficient for Junio to correct it when
applying, but I would amend the change locally in case we get further
iterations ;)

--=20
D. Ben Knoble
