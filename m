Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E31E47D4
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226791; cv=none; b=Zk5Yd2t3nG6upIdKwS0R1XBzkF9a6Vdb6a0HxHbW7s9JUQzkJMM4JjgCiHMuP8NF2l0Fk/felrD2/azsNU6jJEntR5GvSgDsnH3ktM1RncVnN021nN8UUQN35pGpMhx5uZ18piIk7VB4Ut0dutFgsJpq2EgN2sS3r949HwgekT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226791; c=relaxed/simple;
	bh=CdWA0p5tA/D5+wE11oRZ232VYCKYi5QdWyuDuvjE8qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igLQJcW7TrZbpUU9fUnKhX+WmpNufW6yjxKwukx6lik5B1UqNJ2d8ld9vzbhtNpOpyD/5JY5c1s7TNPraNEGriYoRAtpGtg4Q+TlrzOBDSzjDXZBnQlwjMSz8ckkIY2kL/lCz/RuDxj4/lj2kFbec8h6alowHYZm6j2HZlr6fLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEsCyE3z; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEsCyE3z"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef7c9e9592so32154997b3.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733226789; x=1733831589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcT8y2a2EIzCqcwbvW/asvSn+ViOL/2DsrLUqr2GgWo=;
        b=mEsCyE3zxp4XE3xRRL+8nqm33A78dKtNHBUBzrBfaecelQpSGGFbRrGhQ6ji5i/q0M
         IuHqVB/wlynxvVbT94ExX4hMHMbCm0t+I8BdqDK2mbZpnGxOQdXaB6WPVtjO5ELW92+c
         zHjQcnZOc9q62pj4eX0HVcJ0WsU7VLkrm6lJby8oALaMs5Wo9VwjOgIIJQKaGJJ/jNcA
         yJg88vkSXZed2J7auHRcDVUQf9Xj4BnRZ9bVnMNcuzQCWVlLjvMaXpI5RKW0LNWmzxzc
         Lj7PL5pf5FESK3IBsoeqDE3rlEDU4BtAA7Ymq+IIV4aITU3AlNvY/NnZjYlcP1UJOdqK
         Zn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226789; x=1733831589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcT8y2a2EIzCqcwbvW/asvSn+ViOL/2DsrLUqr2GgWo=;
        b=Xfw3wjU9H/Jotj5jr+nh64J7nCdDAiqt9++u0U09jICWisqOp/X63xwRuM2buXnt6+
         qvx5/SrGA6u98CHniR8f1pyIUuwZRYLNKjQYLKQ6zMfzzgqyYb588UeG4JVkPoi4mVSS
         WME626Bv/gbked0aWUqdLDbhMsCvipdtAH1AUMzso+YgO9quOumk9femz/ojspy0ardQ
         EU4++51K2vzreNXdY9mTyNYEaq1J4pemQ5tkHDqL2cKhWNcvI5rWUDILgbL8WWdxM92p
         dVCAqB2pOGwJVVxrJpGcljZYUkdMAWyd8QSoTZk0njh2hCAjqGxlVTf9wv6NrfWlou+z
         AQvA==
X-Gm-Message-State: AOJu0Yzzf/D/5BIHOGS/tCzWYVWfXiKQWZc5FJXaLMai5/IdyyVeQBta
	+tS46ghi2Y26O8AH247D8BTFxXp0lc8k7KQSSrU5HXYNMHJDYAE+r1MZ8e7lnSqnfi5DG3QMu+q
	Ci3k4uSVzRO7467FSpPc1dsc8ISc=
X-Gm-Gg: ASbGncuztqlM+OKxFuXSkpKMeTfcziV0D1unBere4sMwnF1LfCMVb3O14G4Fij8rnXF
	ldL4bhzKDsf387ZwaZNYZ6kppcgglX5+X
X-Google-Smtp-Source: AGHT+IGJrZE048l8MS2bV3MQBFS56ScBhMUkf/VHuKQEBRCKeX7e0NDZ8Gw8sOFBvabNV4buy9s0TQTWqYBciM2wy+A=
X-Received: by 2002:a05:690c:6089:b0:6ee:fabb:d5ea with SMTP id
 00721157ae682-6efad329009mr26977747b3.30.1733226788931; Tue, 03 Dec 2024
 03:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <7cedfd718c4f2d6fed7420a3341e82c9287d2085.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <Z0Q0sSsUXg47gn6Y@pks.im>
In-Reply-To: <Z0Q0sSsUXg47gn6Y@pks.im>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 3 Dec 2024 19:52:56 +0800
Message-ID: <CANYiYbEoa4fJ4TmQVf+brEk74b3-mY13dxtFVgvTvtOD8TO++w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t5548: new test cases for push --porcelain and --dry-run
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
	"Larry D'Anna" <larry@elder-gods.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 4:26=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Nov 15, 2024 at 01:15:32AM +0800, Jiang Xin wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Refactor t5548 and add new test cases for git-push with both --porcelai=
n
> > and --dry-run flags in order to cover the issues reported by Patrick.
> >
> > When executing git-push(1) with the "--porcelain" flag, then we will
> > print updated references in a machine-readable format that looks like
> > this:
> >
> > To destination
> > =3D   refs/heads/noop:refs/heads/noop [up to date]
> > !   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push fai=
led)
> > !   refs/heads/noff:refs/heads/(off (non-fast-forward)
> > Done
> >
> > The final "Done" stanza was introduced via 77555854be (git-push: make
> > git push --porcelain print "Done", 2010-02-26), where it was printed
> > "unless any errors have occurred". For the purpose of the "Done" line,
> > knowing a ref will be rejected in a --dry-run does not count as an
> > error. Actual rejections in non --dry-run pushes do count as errors.
> >
> > The new test cases will be used in the next commit to protect the above
> > behaviors of porcelain output of git push.
>
> It's a bit hard to make sense of this commit: does it introduce new
> tests? Does it refactor existing tests? Does it change the test setup?
> It seems to be a mixture of all of these, which makes it hard to see
> what the actual change is.
>
> I'd propose to split up this commit into multiple ones: one that
> introduces `restore_upstream()`, one that adapts the test data, and one
> that introduces new tests.

I've been quite busy lately, but I plan to revisit this next week,
incorporating both your and Junio's suggestions. Thank you for your
input!

>
> Patrick
