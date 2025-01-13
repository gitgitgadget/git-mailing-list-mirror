Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F91B21BC
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796415; cv=none; b=gzsEeIffM9A6MjbWMklIGdEa4k0PjMTsIW+jK+yE6VMTGjIoLKGO8m2x/1rTG4vBlv4rOEoQa1lfTZXSI7ilhckn7i8xm+29otyoUdw3bYYfpTdr+lIVH0HC46/u7Pmc3vAFlbpDY0Qxa3up5XXGvmi3tinqL0QJuNs2pfm8Cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796415; c=relaxed/simple;
	bh=NFhaCoYEtseD5mh+FAGAT4IkWEywGrXiyY5/lArnEyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUdCFmLb+j+nGuIg3Rgv+diY5aICwzex6YJMhWEoGEPCUs7eye6BDpczlRrRcmh4AumOrRpexfmNwVzNrXTP+MYpxTL8KKs3LCsuUZ+xbOVi6V1i+hfsfeoViuoa/LYFE+FBw8a+vCA/5vVDzVRRl+Vm6rDUmHDrJzmcWv52/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM4QN8wv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM4QN8wv"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cdce23f3e7so35133725ab.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736796413; x=1737401213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IruGUoWtAk/5m3JUa8ctpzsaGnw4MJ6ExfhbEEbo37Q=;
        b=ZM4QN8wvOPN23NHqKk9oL8H65PSN/XYeCeNzOSRpAQk2+exjSEBab5IViO1Og4ot44
         /aZhGBo3kOM0/FM7ROMcP+jApC5v8ggdH5MRDgQ0MK1akUMc8umuL4so3hmK81NxgDjK
         R0FeE9LEj1aEhRBkbL919u1IxIeYZNnD5ljnOGat6qn4eVgeHXRjVNk7368eiuJkjtC6
         81Ju78JKtYHv6l/WqPZd77CV+B6brqeEmcprEEGT9/et3dtbPQCbwFttGCz1c0yhsZIP
         EJVMEWhkpsCNqL+kR1f/6/YWq56w6hxyfFtWzgVtOQFxeNFcsscykxdtZBvlaARu4PKI
         PShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796413; x=1737401213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IruGUoWtAk/5m3JUa8ctpzsaGnw4MJ6ExfhbEEbo37Q=;
        b=cYOvfOI0gnYZ4szkBvmUt7QrVF12kslIeOqH0VLpzZbUo3LpkrWvKQf8yBefXNLkJn
         MZTC1+EzNMjLiNrb4YNiGh2X9TXzE6wzgQGgyYGB1HAs3kUTYtzRJcc8BOtMh+Su8T6G
         vlekK1Pfwe7HlnY8PZORJzk6z5E22t/vJTQnXrRXRXHHGjUnk45kWnUmN56cdRSYjhZh
         YHEV4Qj1kKTnM8+LMETInze16Dvh/cVY/azTaRZVOFdiujEfXiX14JrMISIpn6Ijyk5L
         vA1yV5jdJUdKmxknwJ7q319TPhrjRn4K3l/tcnGU6ju/9TsZvWyopAEtoZ19hCxaG23o
         8EJA==
X-Forwarded-Encrypted: i=1; AJvYcCWGkpmb290NW7Y/6G0nWba4FE4vL5afjvHG4gKl39LntQaSUa15eph+tm/rrhD/982kLUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLa5auliRxG3kaOTISpnUihxSbxrMj8K6bcVIaux5JsybIiS1M
	+qiXaq/tUtjvPebPqVqqe1juYHczdBfOyILxvG96ZgTVQ52iIHBM8HoQcPMxG2t6i3Uv/KtlI7r
	6nbUdengAHB412nrmYivM/ugGSEQ=
X-Gm-Gg: ASbGncuxm5PYzz/8ylpPN+0Zy1S1tevXDoTUTrk/c8A1Qkzo2cUW1P5Z9sYcmW6JKNf
	P8DE8NsoDp71JcGsrszsMtUUjQob8Tmyvnx8SAi7+do6Rg3cR1GGV
X-Google-Smtp-Source: AGHT+IHocyN1r4PaGVnEikhjrQ6THClP3u/0DkPuEO+GxsdnsIO7TKWBofSFMwqlOtP4nOL/QjVMhJahe4mBSICvqFU=
X-Received: by 2002:a05:6e02:13a2:b0:3a7:e732:472a with SMTP id
 e9e14a558f8ab-3ce3a9a4ac6mr185101615ab.2.1736796413349; Mon, 13 Jan 2025
 11:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
 <pull.1844.v3.git.1736788417.gitgitgadget@gmail.com> <xmqqjzay8trm.fsf@gitster.g>
In-Reply-To: <xmqqjzay8trm.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 13 Jan 2025 11:26:42 -0800
X-Gm-Features: AbW1kvbyvzIQrvd9oAIPeF74vZAdxrtG5b6-y-cmc7vIsOYptU7JPMJWHsZg1Yg
Message-ID: <CABPp-BG=Yu8DRb_xPOE0PC8HPRSBzYn7FW_8rN=rRsg4t_hE2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] object-name: fix a pair of object name resolution issues
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 10:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v2:
> >
> >  * Readability improvement to the first patch, which fixes object name
> >    resolution with refs containing a curly brace
> >  * Fixed the second patch for cases like OBJ-COUNT-gHASH~13 and added a
> >    couple test cases for that. Also, extended the commit message a bit =
to
> >    discuss the cases brought up on the list.
> >
> > For the second patch, if folks want some open source examples where it =
could
> > be triggered, I found two examples:
> >
> >  * lore.git: git cat-file -t master:random/path/major-gaffed
> >  * git.git: git cat-file -t super-invalid~///\\.....@.lock-gfd0bba94e
> >
> > Elijah Newren (2):
> >   object-name: fix resolution of object names containing curly braces
> >   object-name: be more strict in parsing describe-like output
> >
> >  object-name.c       | 63 ++++++++++++++++++++++++++++++++++++++++++---
> >  t/t1006-cat-file.sh | 31 +++++++++++++++++++++-
> >  t/t6120-describe.sh | 24 +++++++++++++++++
> >  3 files changed, 113 insertions(+), 5 deletions(-)
> >
>
> Although ...
>
> >      +    Note that we'd prefer duplicating the special logic for "@^" =
characters
> >      +    here, because if get_oid_basic() or interpret_nth_prior_check=
out() or
>
> ... I suspect that you meant "we'd prefer not duplicating" here,
> both patches look very good to me.

Oops, indeed.

> Thanks, will replace.

Thanks.
