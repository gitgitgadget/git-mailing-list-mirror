Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70226AE4
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915288; cv=none; b=esaecaK45QzlON3r28EZp9J+dkw+0XnS45x0hMtMBB/SEczVG/i8+z4kcejxyanYBVe+QOrV6SZnX0bghMEkEbOkwg5s2R5/oq9DbxF+8X5AGOVf6w9yq4wwLWpgyYCsm23ehDq+G/dV+pkz7VR5GlG9Ihl45tY32IdB8m4Ftmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915288; c=relaxed/simple;
	bh=oVK5xW6m7uIjkEcuc/TBHgUF6PL1uLXURvxaDfUnpgg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=LC2uSG3kd0Xllx5dKAw/a/dy2OevdsajuZU6D03AfKjyYZyqOYnxpHdRUD15ED8W5j8L9Xxsuwqx+AwAKHYVd5VeBmCI+oWqgQ2vil3fzc2DSpVQIzhxT0S9TBYq3sfhyctdOX9ZjeZurzVAPYBfCtngChyKM7sC53wuvVUqCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJdoCYQ9; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJdoCYQ9"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8bbb605530so4356429276.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754915284; x=1755520084; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRaWtRWZJ+v5ovma22ggI3b0xjxrdNvEe5PblBjKa5U=;
        b=GJdoCYQ9DFLTwbv5khuiHqcHxa9IvG7gq26DdtEPe1nvlAwc75iz5SegBEOJF7W1h6
         ahgvlamIM4x7nE+aqJAQXnWlj1QdIrgbPIo+6/upr8a6hjrcUJCoZxRgLcIY9nmOzcPI
         uwaIheyZ9Vz2UJuvwryf8Tm1JCSBZ6aMQFzTjisFXW3VCr1JSW8sDcMiB0OtmXJz/fQl
         uoyEY84cFyf2TIGxuYJbTigrSmJldaYFImoWBijStC4etLyC1JbaMS5cqSgsGyAFyBkU
         7YlMnhbHAQ+QfZvr5cjT0aCeakeFu7ZXGEOKc1FDgCaA5QorcTG2XortztboftdgV7hA
         Wxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915284; x=1755520084;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRaWtRWZJ+v5ovma22ggI3b0xjxrdNvEe5PblBjKa5U=;
        b=IlGEEapq08FVaM8Knjr73UO4j4F6geg7PvrL6Xln/yCB1TsKLnmR8rTFAKvT6wS64k
         K2TiNHZc6BpgYjwc7njaBhPdwgMxarj4U1QM1EuGTpGXOuID2ik6HpOHTGtOsHU6nmdb
         6u7bMUe6RniU4jqN0PbmfUGWXd5kqB6K86doh42H3+XftlehY3J9ueUb1Qy0NQ6Esso7
         qp/PdDo0++w+GwiDASPSmXemEu+IPSiN74fknTLxv5xP3Mf4gVKd479UKZSebWQFEPSN
         JzIsyVaEvHR0WxK4yHJOqmhvmmwr+RVe2y+Z8LrYo24czHMeCloEw2DeKBZzwBi+270A
         MVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbdAja13StH5O9gpuDKBy4VpfHhdalezSMhh9hJzwkTf310RN8jVCX4BZ+Qkp+oQkgKnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHrNsAklAoNA1n993U0V+FCD3FpOHPC2dmfeXuAlaPCvjl6aF
	zTq77ik8fz323zesrKmNutQmQIRbyAmm/8etxUhII9h5xh6JTs5tREzvMzaltU+W
X-Gm-Gg: ASbGncu0Of+aQwBUlZ9NzkNulp7eWG3SNX39Gp2viJYfvxKbC735fkjhjGAaq2bToj4
	bos9DvBfLx3xWrcSsu8TpEw9GLguO5F1DXqehw9M27N4UJ5cgXGEO19t1TbPQohE2R4z+ZC6Swz
	f6popUq21y9FdGvstbBVFDJ1IxOZQfhyd2W5mnJq1bI/5ONEcpg5DsGvnlI+ShRUsMchtZHZaJU
	e554sGp8nXZXVDuVYCsc41AFNhgFsrmTb3wj1cuLEmjI4cf4iOG7DfjT66seyoEPQfWSGkuFd5n
	RcrPiMfU1LWUEKxw1YfKV24IUDHkzLNF0Ybk9KeX81J4FXCYBwT/RhcT/Qav2n7vIu1xqL/Yoyl
	HP20eUJ9MqaRs+2P+zHJy+F50bu0MRlNFC5fIG4d3LPEG4j9KYZXt5LzJdUR3VQ==
X-Google-Smtp-Source: AGHT+IGUS85MQtI4L7ZQv/CWxxplQiwBIxcZbK8L7fV9lYW/V6cLUc4ALv4ENIElit+s7vylMCMYvQ==
X-Received: by 2002:a05:6902:1146:b0:e90:5e84:a3d5 with SMTP id 3f1490d57ef6-e905e84a713mr9012110276.10.1754915284297;
        Mon, 11 Aug 2025 05:28:04 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f5e7:14b4:8a2a:aa03])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713f97sm9607051276.9.2025.08.11.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 05:28:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
Date: Mon, 11 Aug 2025 08:27:52 -0400
Message-Id: <46477AC9-8363-453D-8A57-F599A451D36D@gmail.com>
References: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Julia Evans <julia@jvns.ca>
In-Reply-To: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 11 ao=C3=BBt 2025 =C3=A0 05:29, Karthik Nayak <karthik.188@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>> Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
>> 1 file changed, 23 insertions(+), 26 deletions(-)
>>=20
>> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.ado=
c
>> index 956d3048f5a6..449f01fba560 100644
>> --- a/Documentation/git-rebase.adoc
>> +++ b/Documentation/git-rebase.adoc
>> @@ -16,6 +16,29 @@ SYNOPSIS
>>=20
>> DESCRIPTION
>> -----------
>> +Transplant a series of commits onto a different starting point.
>> +
>> +For example, imagine that you have been working on the `topic` branch in=
 this
>> +history, and you want to "catch up" to the work done on the `master` bra=
nch.
>> +
>> +------------
>> +          A---B---C topic
>> +         /
>> +    D---E---F---G master
>> +------------
>> +
>> +You want to transplant the commits you made on `topic` since it diverged=
 from
>> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do=
 this
>> +by running `git rebase master` while the `topic` branch is checked out. =
 If you
>> +want to rebase `topic` while on another branch, `git rebase master topic=
` is a
>> +shortcut for `git checkout topic && git rebase master`.
>> +
>=20
> Nit: now that `git-switch(1)` is no longer experimental, we should start
> recommending it over `git-checkout(1)` as necessary. So perhaps, we
> could s/checkout/switch here?

Junio previously recommended checkout (a prior version used switch): I suspe=
ct because checkout will detach head without extra syntax (where switch will=
 not)?=
