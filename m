Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E02E2F16
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795170; cv=none; b=JfEYcte+mpxb/zttN2DF0sk5jbUI9moU4r823xWWjyBk7VgcPqvKb0pu6qjrp4VvQzChocZcxKwlFi25IVEiyUTLnSok1XGNPFiLyIq8qy4nOB3YCPUZiQDS9z/I/1AVmhamRnLCN1XwvvzKkd+jFUJ/0fZ6j/8fzC6GxxII348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795170; c=relaxed/simple;
	bh=Cj4fBT5rJf02meHdmYGJfGr9ZiehuQidsJg3tbcJc+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2ItuyMYSmLgFMYVOr0jMKcyf6AQ6GuSQ+aGJ3/EoXY7EJqRAR2SXxBEncPJO45UzrsjDWXEXC7P1OgDuvsjjSjSRStTYEHb7NVWztM2fMiYYiUK0voYjYEaqzccNsY1dnUj2tkWgBkp4q9REdCnN1FfqTgkiZNyf1msVpdyym0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdRm1OEo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdRm1OEo"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-890190c6165so355101241.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755795168; x=1756399968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SarfuxkOQvE65Er3zm86PiH+DsNVBNL7I3rycksE7L8=;
        b=mdRm1OEoGooiy5GhZUALSrTWw1Fzc3LZUmnTLdN1MTbsM19IoinjTPjvMiV5ZGjeI1
         Ohr5fOtbNz2/FPX6NmlV2ngYQ9BWjyRjUL62PBzlA8pS47qZCpPfMKuvjkHAAqEvqoJn
         csOYv9s2rhfZdJPTYFrkilLViVaVqP21oNgFQM19uhf1gYtpAX7JUzKetKgCQ7iOvCso
         U1dDHgrL9VsZqpYHPjzmbkpq2++a1L+7e8QNrfsX1wlhwq3e2wwTmCY3wQ1H4R/F5ioO
         banx5QraKFhLoouG14mZVDjaxtxd2CsJXzwpq6+9cHmeWGFa95numqivq8bx5wnMN3W+
         XJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755795168; x=1756399968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SarfuxkOQvE65Er3zm86PiH+DsNVBNL7I3rycksE7L8=;
        b=MvHXH1iJa/VpPyx6VP8NSW2o5bQTKcAe1cy+lwn35hz/neWOBS8Of9UBrDN4EBZHBM
         vrxyLp/b9K187RAYesxe+bsEeMtSkVrSL/YU8x3gPIXuk9ZZzLAzg3jXuDDuF8WTBB7W
         zRJcZ8wBBckqMvHjdU8lClCu0nrE7fjRVJA8gmr1gLvvr+CJdVFyrq6eXTV5su3lAxYX
         Teg696SgzZNo3hHsWqhDyh796MgSxjUBdFLci+RE90fTsYJqnDoddPmfhru+Q96C0XAb
         RI8rLMyX8dDmsrLmzNq8AupPn8Tuzy2x0trjbJG+m999ioCqumPWzeDqr+CIpTnJxyNF
         Mo0g==
X-Forwarded-Encrypted: i=1; AJvYcCXa93FCvqzTiIaq4qJjii6qfcxMJDqnvsbhMXiWYfbcTuEcJmtDSvk+bJ7exIBMx38F8SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsfH+mh3dYNWA+SDypLfbTZJoDhMmOxOevU5K4AkaMz3DXd30
	41xOQjCfYqBCLPT1VCOOe9j/FYGly/hOLZUVdRQjCyoJREBNnP4FfCZkvLkkBoH79wuVVrY2ZBA
	mS+eoZLoU5MtVPbuBCSCJWbb6Pvgbi74=
X-Gm-Gg: ASbGncvWu92oCE/GvjgbuRluRjweJZVpQek4wjgo43HwIHdXxhBNDl5kYPY2uU+5Gnc
	iJ3MJoQUH3PIdE5/qYaWuS0+a1V4afOit+MhhoomKBLh3XqK4z6gyFB2Ydqy2pOVpKVCiQpUisf
	O+O/fK/JUeR0fIAC8ZOUYU4LXk/e6K8NST/xKfkccGI0mOT4p8rnEnPl+tW4ywrNjQ+Zs5x/cnu
	gzdNUqZC3oTwdcXxESobXSVmFXsTtbk3JgEvFoWIg==
X-Google-Smtp-Source: AGHT+IHf3/ufOLITUamx0Q6/azYPomuIe6PQKxWououRA2XGwyyBETzW+F7C4MJnK/ahHYvR4hh9SMrmiDxhZOh99VI=
X-Received: by 2002:a05:6102:f9e:b0:4e7:dbd2:4604 with SMTP id
 ada2fe7eead31-51be0c3dadbmr1111465137.17.1755795168133; Thu, 21 Aug 2025
 09:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-2-lucasseikioshiro@gmail.com> <CAOLa=ZQZCUsa7M0mh1oCq8hhBZS05=jw4y2Lr1r3rPe0-ajbhw@mail.gmail.com>
 <xmqqsehk3bcp.fsf@gitster.g>
In-Reply-To: <xmqqsehk3bcp.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 21 Aug 2025 18:52:22 +0200
X-Gm-Features: Ac12FXws8wi9q4doYM-ThTB-JsjAvWTluPfP0hiWXo0nD9Yy4NtrjH6m0YQ0UaY
Message-ID: <CAOLa=ZQ3d6aDi5jH6A8xuwmdnk78fXq12pGxo+_WDN-0tNorkg@mail.gmail.com>
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for --format=nul
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 6:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> >> -git repo info [--format=3D(keyvalue|nul)] [<key>...]
> >> +git repo info [--format=3D(keyvalue|nul)|-z] [<key>...]
> >>
> >
> > Nit: Perhaps we can leave a space around '|' to make it easier to read?
>
> Documentation/CodingGuidelines (Synopsis Syntax) has explicit
> guidelines about these things.
>
>      Don't use spacing around "|" tokens when they're used to separate th=
e
>      alternate arguments of an option:
>         Do: --track[=3D(direct|inherit)]
>         Don't: --track[=3D(direct | inherit)]
>

I stand corrected, thanks!
