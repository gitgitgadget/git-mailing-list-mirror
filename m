Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D901272CB
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028205; cv=none; b=gFYnIQ1nXtiPp3xp/41pQiNgeiv3NzEpUsDg+ewzYQmkwtiH8HnjioMMg/gBbH3ePZu9dHHR/zV1bhiIPGMy6jgzu/wrOsI7J0ildGkJjfsVGlxER8W3Dz94BwaxcqzhasJUlHWp/56+HATJOLaNivtsb9PRrPAYAq3fiIJe7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028205; c=relaxed/simple;
	bh=GbY+KANuOTyOPqvjNaMxKy1PaPmI6wp/ODvOnL1dOzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j28hOhaUDytQUmDNlFzbik6hoQySRFzktxdqyljDWFRq15bGQILAJOtQANN164eoYhA8E+XiX9D1F5squUgPrmtdwJ0jN/kco9TmfPz9XECRL8CNpRAkzo8NfqYJXM1vQ7WXuF57hlCeFFhmiD4T2+xBMIs1K0QytG46L26xmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcWCeb2c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcWCeb2c"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290b9f83037so1288744a91.1
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028203; x=1706633003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1qpKwUBogPzDEth5b9F7EuRxq+N/Tz4hseVyc35qlM=;
        b=OcWCeb2cWi1WvfBmBS5J1wDNlWJxsCds7Q1nSm8CIAOL6SFRpxlxwad9h8dLUHFMgb
         /edgupz+ndj05JUCQsnJAKGmXp14GbKJEHuU3J8wOwbWnACu7CuG/TE1OXtSYKlUmGyT
         1LYR6Ufk3iL6loldGTSdGLjkVdFoUxfZAXbC3mzdiEATPahqLKVYSUe17skv6AaVP8JX
         mwuO/w+sTjAVjZzE7xJbAZJXVonHmkWdd5Ra9jrwaoJj4R8eoZinNFLDfW+qE60Sb/YS
         HiNRZ88qMfCp7KgTX7gRqR+MohntkyMZdTa+7iWuygv5aqsFAtd/G72pWXb00PCfE6J7
         VhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028203; x=1706633003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1qpKwUBogPzDEth5b9F7EuRxq+N/Tz4hseVyc35qlM=;
        b=ggSn3S1K/p2oo7Iz5IYrfmb9E7EuDoIP9dLcSq2eETc7GFNM9Bd+BowAmRvoFb37Km
         9Te/K9l0MtiQedSghv3SBac5qmw8dyRFz5Wb9Bfc4qUmu4r9o6KVRVnvu1dgp/Q9vvio
         ceqrzrX7OjO9ie1G2ZPQV1vkuDcjUDt0UW5ZJq0BppyRDeHKa2DNz+N/mS+2QefTV6Bo
         9ht2UVQs7kP2jEAlVnc1FFeMAShW/izI0imv3I8Lh+8Qne/oGaqdfH8dI/APlTyYDY7a
         rvUnyK0ITqMddtkrEHO5ULAmvjcf3q6OKq4VILOAQuWCyoEvw5/xu2kLUcwvxUoUS1ch
         QpRQ==
X-Gm-Message-State: AOJu0YyKxH+XInzPbkV2Sg+CmDPpTaF39OF9TqkjlonPoAYrrzPR+x0H
	Dv/hcTJcKRu4ca66j8nsbHoiUzqoKEawcNte3d1DmwyKRZJOMqlXTfH8NUW0X9982DjJinCOMVl
	WsZfTAw+mhQExBkM5Y+vex3ON/TleJbi01nI=
X-Google-Smtp-Source: AGHT+IENZRRHTMoUVPE6tEaczKQ1UBxu14K5sRmnVJ3q2HobYRCoxsNMny2qBznJhCGH72qcSN0d67M0DlPvn5p8sQI=
X-Received: by 2002:a17:90a:12ce:b0:28e:77e9:a2c6 with SMTP id
 b14-20020a17090a12ce00b0028e77e9a2c6mr9088487pjg.8.1706028203419; Tue, 23 Jan
 2024 08:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704802213.git.ps@pks.im> <cover.1704877233.git.ps@pks.im>
 <0552123fa30243d6d8d6b378991651dd6ade7de3.1704877233.git.ps@pks.im>
 <87ede8qhw9.fsf@iotcl.com> <Za_ZrtRMEmVHu_o5@tanuki>
In-Reply-To: <Za_ZrtRMEmVHu_o5@tanuki>
From: Justin Tobler <jltobler@gmail.com>
Date: Tue, 23 Jan 2024 10:43:10 -0600
Message-ID: <CAGAWz+43bjotkJ3UxGgsageYuWt4g=95uBM-sy4dqyBVCJLToA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t1300: make tests more robust with non-default ref backends
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Jan 23, 2024 at 02:41:17PM +0100, Toon Claes wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > [[PGP Signed Part:Undecided]]
> > > [1. text/plain]
> > > The t1300 test suite exercises the git-config(1) tool. To do so we
> > > overwrite ".git/config" to contain custom contents. While this is eas=
y
> > > enough to do, it may create problems when using a non-default reposit=
ory
> > > format because we also overwrite the repository format version as wel=
l
> > > as any potential extensions. With the upcoming "reftable" ref backend
> > > the result is that we may try to access refs via the "files" backend
> > > even though the repository has been initialized with the "reftable"
> > > backend.
> > >
> > > Refactor tests which access the refdb to be more robust by using thei=
r
> > > own separate repositories, which allows us to be more careful and not
> > > discard required extensions.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> >
> > > @@ -2009,11 +2020,11 @@ test_expect_success '--show-origin getting a =
single key' '
> > >  '
> > >
> > >  test_expect_success 'set up custom config file' '
> > > -   CUSTOM_CONFIG_FILE=3D"custom.conf" &&
> > > -   cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> > > +   cat >"custom.conf" <<-\EOF &&
> > >     [user]
> > >             custom =3D true
> > >     EOF
> > > +   CUSTOM_CONFIG_FILE=3D"$(test-tool path-utils real_path
> > >  custom.conf)"
> > >  '
> >
> > From the commit message it was not clear to me this change was needed.
> > Do you think it's worth it to add something to the commit message
> > explaining you now need to copy the custom.conf into each seperate
> > repository?
>
> Good point in fact. The problem here is that before, CUSTOM_CONFIG_FILE
> was using a relative path that wouldn't be found when cd'ing into the
> respective subrepositories. By using `path-utils real_path` we resolve
> the relative path to the full path, and thus we can find the file
> regardless of our shell's current working directory.
>
> Not sure whether this is worth a reroll, but in case you or others think
> that it is then I'm happy to add this explanation.

I also found it unclear why the CUSTOM_CONFIG_FILE change was needed.
I had assumed it was a refactor to make the tests more robust. It might be
nice to explain it in the commit message. :)

-Justin
