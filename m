Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7809215071
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740840; cv=none; b=g8LhtWM+f4SFvYmmJxIwLKsYRkLA3yo6PlIUC6EvfQyLm833Zw8/Ew87xWNl1W9Pm7zsg5nckOeyEeor/2q8GHCq/gamr1R+6814py4+eORnizVVUvC9bM5zageHnHUkyRBLzk8zn4+/z12qPtdqNqLPBOhEcnVNhP/aLbZAeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740840; c=relaxed/simple;
	bh=k/o2Cmzw1ewdrbI959scB1PdbcKKWSVYAk39CJN4kHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I36CFb7LbFPDDKq/xZP1zALuJyuM7ql2WHENDBa0p7DovJKhH9aB+bDjentMi0VXi1qWUShgz9YIyDuz5KkYiR0ezX1ZTGE4bTobcl4W9pkcfVMaWyDof/NKH3PhYrTpEwsk0cXHbhf6Q4wmhZRksTAYnGbzOxGy+xLzs4bVMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngq7KObG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngq7KObG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so4659936a12.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733740837; x=1734345637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufXapYx2sifTw+DkM/FvyacZefhVE8waW9yEnLL3DfU=;
        b=Ngq7KObGaPHCWKG9YQVM+r0wxv64O2jIYHac7IkCIULjbjviOwx2zL5Pib3xjjt34B
         1dQqFB8P5r751qeVP25pl9RimcAnuSKovBB0Lo6dJuq5fiqYjBrMn8m63FKqcxu9u13s
         RBY7S+K/rIH5GvAp5RzfL99Y6l6z6lzDGrZMqBgbJkKVid15WFYuA8NERVLjvqHdSiA7
         Roc9PQhiWhod+M2mEQkF6m5LMjeUPw4WI9l7XPMoQgoVl7NK6URMHKxxIT30o/CSz6Gw
         w35QYLhEL+fBemmFUQWgGxuHC5hhd7mjIg8jYqEiC/S8ldChsYcAgSUo6MB0goQV09AX
         jInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740837; x=1734345637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufXapYx2sifTw+DkM/FvyacZefhVE8waW9yEnLL3DfU=;
        b=eEOTJist4Hsygn7/Kyddy6n67Tf6eae1Km/Zrj3PcvN2y5dARwEE6Q+k43clKGhBfp
         k4d7ae0dujuuVolR9nRWfaZZmQ7GTKtox6IgF5tHVfZqbwBL2bjaE6xSql3ho5AqLDXM
         hXjHtID0OwXIWHvIEI0j+UM9tJnHZvXTPGlt7hgqFSqtQR+RdgIOnDMRCLzl8W598Whd
         jUsNdP3vf/X1eYQ76CbPLCWVjHuBKrmUh8sN/jkM6Yyu7e2D/foIiJEOuvUhwzPMDjrs
         GRrj/BCwE1+TTAaeQJkgnN9PfYNxHp4mdj7RfM2a/ujrJ7hkaCjuL1b53DWoNi+CyoWv
         yt8g==
X-Gm-Message-State: AOJu0Yx+BQKocV7gIDbPfOjUiRxwH4Mjf1ycUFXfElEn5mq7QjgC2HRV
	zYWAy/Ng1PuKXK0fPTgwkEmwa3zX63SfZX5gVyqRjp5aBcZ2YQBG4wYyH/roFdFkhV/MIIDbeto
	f51YK9qQqlRDWsEHoko/WvlzJZPU=
X-Gm-Gg: ASbGncsHf+/NgvCauk9oxGtwJmLVZajZNXts0d2Dfyy2djl9GZotGid8optlw15nyNo
	ycvGuvrnlVDTIs2zQlCcdVq+TbrFeufxiqg==
X-Google-Smtp-Source: AGHT+IEBKjX0EU1zszA2GXcuh//UMWGL2bK5wCm58S09wXIPGKUr1ES6IybL77CDUjewCKQM2JH8KpZWQf4PNOvZpuU=
X-Received: by 2002:a05:6402:2349:b0:5d0:b9c7:479a with SMTP id
 4fb4d7f45d1cf-5d3be7f04e6mr12138164a12.25.1733740837034; Mon, 09 Dec 2024
 02:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <xmqqikrtnuyp.fsf@gitster.g>
In-Reply-To: <xmqqikrtnuyp.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Dec 2024 11:40:24 +0100
Message-ID: <CAP8UFD3bdEo1_bg+aX52xSGxmg9KfNrpiX+2LwUM-yDqjvfZbQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Introduce a "promisor-remote" capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This work is part of some effort to better handle large files/blobs in
> > a client-server context using promisor remotes dedicated to storing
> > large blobs. To help understand this effort, this series now contains
> > a patch (patch 5/5) that adds design documentation about this effort.
>
> https://github.com/git/git/actions/runs/12229786922/job/34110073072
> is a CI-run on 'seen' with this topic.  linux-TEST-vars job is failing.
>
> A CI-run for the same topics in 'seen' but without this topic is
> https://github.com/git/git/actions/runs/12230853182/job/34112864500
>
> This topic seems to break linux-TEST-vars CI job (where different
> settings like + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
> is used).

Yeah, in the "CI tests" section in the cover letter I wrote:

> One test, linux-TEST-vars, failed much earlier, in what doesn't look
> like a CI issue as I could reproduce the failure locally when setting
> GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL to 1. I will investigate,
> but in the meantime I think I can send this as-is so we can start
> discussing.

I noticed that fcb2205b77 (midx: implement support for writing
incremental MIDX chains, 2024-08-06)
which introduced GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL adds lines lik=
e:

GIT_TEST_MULTI_PACK_INDEX=3D0
GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=3D0

at the top of a number of repack related test scripts like
t7700-repack.sh, so I guess that it should be OK to add the same lines
at the top of the t5710 test script added by this series. This should
fix the CI failures.

I have made this change in my current version.

Thanks.



Yeah, not sure why
