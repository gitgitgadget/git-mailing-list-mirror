Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51912AAD6
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207198; cv=none; b=YGEK2DXYyqVzEFlad3ZwKyqy6DNfkqOagq8zgNMePlKbG0SXeMqQyzW4VEOrHS/HrCsdHG9VMRKKhWl2ET87K2OoyOm0t+EbDIdQxHcq30A4+epAuIQ0CmoGpXonhTF80EwDMVRdUum/Z4MgdhV7lCTdB04eQKAuSLWF35Z39UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207198; c=relaxed/simple;
	bh=FKN87WdJTsTwTpI3gE+YpHtCGpxYe56agBjM4UrCbEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/7MPOH5dG7/c6K+RfcYnwud9cqaYCOyKBJRjvPR7IcAQGET69BUTNo+cNjPZ/36ZhEJXZY90SnQjN/QsCf1/6dc6dr2GVXt51exi9Dwie2JYuLMIKtcjuuh4iLk6ig3aD8scucAsFC+KB8gsefQg6y+0aZyt7bI8BI7J1ZC2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh1XbgPJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh1XbgPJ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so6024312a12.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 00:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207195; x=1707811995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKN87WdJTsTwTpI3gE+YpHtCGpxYe56agBjM4UrCbEg=;
        b=Zh1XbgPJITbRWdy2nmuXO1ztuN2IzZMmE4mwsVzKl3usC0Mc+F+Kqq8X1Dsc3jG896
         6rtJJKo5jayqWdzbqRaxjNiCD4t0Quz6yBfaoGzbXHFtz224N+BvQ91bUPwiAM3If/D8
         5j6SNaWN4cFSzzoNGlAms7xV+RvSf941tYDIdDEIW3dY+8nHNPWno3ZKJLNaZowqwVa/
         l/9mjeh4XBKK36nNShHrm3IiJo02TrL+r4F4x02iNzzS7psP8DT/3Xx6TsUx3Qoeev3Q
         LxxLA8KcNkzZjSh7/X4PynfM5ILcwPLE2eo0p/zvFSRJXfDRY0U/Fcc76tKWfyhG2jS6
         D2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207195; x=1707811995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKN87WdJTsTwTpI3gE+YpHtCGpxYe56agBjM4UrCbEg=;
        b=APV/tPLfVhfYgBs6T9QmikICInoCiGh92kGxLUYSjatwYduZQWiSob/yTyQIn3KJpn
         so3njX0fisUDVapZvmT9m9eg/FJUNGXhJ0YmhcpcKWPpjhxm9kEauyLQ+mju0DoqbYFj
         2Fz+PrWodgmsDupQILP8KVPwZMw8IAURAStTaUN+xAIjZrukZj8qUXqcb3zpFyVrbCYL
         +wOYArZDtkxnI25sSMeQm4qXlHwE9k0nVSRJi4mLvOPqPTIZlZnmK0o6QSPEUZTV76XB
         LZ0qZWES8wENBNC5oLDzqlwY9jYnFh3DztfNIcwKMnQrOVllyUje0nQGixLQDbLAXKeZ
         EAbg==
X-Gm-Message-State: AOJu0YzeTo2Xo5X2SlUJqT1j3c8tYcCuvOp8GusCKmYKrat7RTHp0G6q
	bslJeImiza7Cs5VCNXXOT19GtndV6YDyycJe9Y0G6YiNXTmfdunCLEdU/uwrHS2LStXvekGQW00
	quKJDc7UAVrw6pUhLoPWFXcunxy4=
X-Google-Smtp-Source: AGHT+IFZjDT5gZ2pOBjY2DNKE8mng4W9J0DfTdK0BoYxk9UjZHDHjB326uO6aofmNjveuWyyH3v5y7tNaS6BqSeqq5U=
X-Received: by 2002:aa7:cf87:0:b0:560:6518:8ac with SMTP id
 z7-20020aa7cf87000000b00560651808acmr1144375edx.2.1707207194979; Tue, 06 Feb
 2024 00:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
 <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com> <ZcHIxcrKbgyhdyWn@tanuki>
In-Reply-To: <ZcHIxcrKbgyhdyWn@tanuki>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Feb 2024 09:13:02 +0100
Message-ID: <CAP8UFD2yFr1uOjKOnMjznjR6BEzGqq=R7K85z2Jz4i=sG0CLJA@mail.gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> On Tue, Feb 06, 2024 at 12:25:31AM +0530, Kaartic Sivaraam wrote:

> > Makes sense. Also, I'm kind of cat-one-the-wall about whether it makes =
sense
> > to have two projects about the unit test migration effort itself. If we=
're
> > clear that both of them would not overlap, it should be fine. Otherwise=
, it
> > would be better to merge them as Patrick suggests.
>
> I don't quite mind either way. I think overall we have enough tests that
> can be converted even if both projects got picked up separately. And the
> reftable unit tests are a bit more involved than the other tests given
> that their coding style doesn't fit at all into the Git project. So it's
> not like they can just be copied over, they definitely need some special
> care.
>
> Also, the technical complexity of the "reftable" backend is rather high,
> which is another hurdle to take.
>
> Which overall makes me lean more towards keeping this as a separate
> project now that I think about it.

Ok, for me. If we have a contributor working on each of these 2
projects, we just need to be clear that the contributors should not
work together on the 2 projects as I think the GSoC forbids that.

> > That said, how helpful would it be to link the following doc in the uni=
t
> > testing related ideas?
> >
> > https://github.com/git/git/blob/master/Documentation/technical/unit-tes=
ts.txt
>
> Makes sense to me.

To me too.

> > Would it worth linking the reftable technical doc for the above ideas?
> >
> > https://git-scm.com/docs/reftable
> >
> > I could see it goes into a lot of detail. I'm just wondering if link to=
 it
> > would help someone who's looking to learn about reftable.
>
> Definitely doesn't hurt.

I agree.

Thanks!
